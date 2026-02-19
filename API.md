# API Documentation

## Endpoints

### GET /api/nfts

Fetches NFTs for a given wallet address with price information.

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `wallet` | string | Yes | CollectorCrypt wallet address |

#### Request Example

```bash
curl "http://localhost:3000/api/nfts?wallet=HGRuUkTLrTuKm22hFDCM47h7fakz4va5Y1vmsEw3pFb8"
```

#### Response

```json
{
  "nfts": [
    {
      "id": "1",
      "name": "Charizard - Base Set Holo",
      "image": "https://images.pokemontcg.io/base1/hires/4.jpg",
      "rarity": "Holo Rare",
      "series": "Base Set",
      "collectorCryptPrice": 380.00,
      "marketPrice": 350.00,
      "priceDifference": -7.89
    }
  ],
  "total": 1
}
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique NFT identifier |
| `name` | string | NFT/Card name |
| `image` | string | URL to card image |
| `rarity` | string | Card rarity (e.g., "Holo Rare", "Promo") |
| `series` | string | Card series/set |
| `collectorCryptPrice` | number \| null | Price on CollectorCrypt |
| `marketPrice` | number \| null | Market average price |
| `priceDifference` | number \| null | Percentage difference (market - CollectorCrypt) |

#### Error Responses

**400 Bad Request**
```json
{
  "error": "Wallet address is required"
}
```

**500 Internal Server Error**
```json
{
  "error": "Failed to fetch NFTs"
}
```

## Integration Guide

### Integrating Real CollectorCrypt API

1. Update `app/api/nfts/route.ts`:

```typescript
async function fetchCollectorCryptNFTs(walletAddress: string): Promise<NFT[]> {
  const response = await fetch(`${process.env.COLLECTORCRYPT_API_URL}/nfts/${walletAddress}`, {
    headers: {
      'Authorization': `Bearer ${process.env.COLLECTORCRYPT_API_KEY}`,
    },
  });

  const data = await response.json();

  return data.map((item: any) => ({
    id: item.id,
    name: item.name,
    image: item.image,
    rarity: item.attributes?.rarity || 'Unknown',
    series: item.attributes?.series || 'Unknown',
    collectorCryptPrice: item.price || null,
    marketPrice: null,
    priceDifference: null,
  }));
}
```

### Integrating Real Market Prices

#### TCGPlayer API

```typescript
async function fetchTCGPlayerPrice(cardName: string): Promise<number | null> {
  try {
    const response = await fetch(
      `${process.env.TCGPLAYER_API_URL}/catalog/products?productName=${encodeURIComponent(cardName)}`,
      {
        headers: {
          'Authorization': `Bearer ${process.env.TCGPLAYER_API_KEY}`,
        },
      }
    );

    const data = await response.json();

    if (data.results && data.results.length > 0) {
      const productId = data.results[0].productId;

      const priceResponse = await fetch(
        `${process.env.TCGPLAYER_API_URL}/marketprices/${productId}`,
        {
          headers: {
            'Authorization': `Bearer ${process.env.TCGPLAYER_API_KEY}`,
          },
        }
      );

      const priceData = await priceResponse.json();
      return priceData.results?.[0]?.marketPrice || null;
    }

    return null;
  } catch (error) {
    console.error('Error fetching TCGPlayer price:', error);
    return null;
  }
}
```

#### Pokemon TCG API

```typescript
async function fetchPokemonTCGPrice(cardName: string): Promise<number | null> {
  try {
    const response = await fetch(
      `${process.env.POKEMON_TCG_API_URL}/cards?q=name:"${encodeURIComponent(cardName)}"`,
      {
        headers: {
          'X-Api-Key': process.env.POKEMON_TCG_API_KEY,
        },
      }
    );

    const data = await response.json();

    if (data.data && data.data.length > 0) {
      const card = data.data[0];
      const prices = card.tcgplayer?.prices;

      if (prices) {
        // Get the best available price
        return prices.holofoil?.market ||
               prices.reverseHolofoil?.market ||
               prices.normal?.market ||
               null;
      }
    }

    return null;
  } catch (error) {
    console.error('Error fetching Pokemon TCG price:', error);
    return null;
  }
}
```

### Multiple Price Sources

Combine multiple APIs for better accuracy:

```typescript
async function fetchMarketPrice(nft: NFT): Promise<number | null> {
  // Try TCGPlayer first
  const tcgPrice = await fetchTCGPlayerPrice(nft.name);
  if (tcgPrice) return tcgPrice;

  // Fallback to Pokemon TCG API
  const pokemonPrice = await fetchPokemonTCGPrice(nft.name);
  if (pokemonPrice) return pokemonPrice;

  // Fallback to Cardmarket
  const cardmarketPrice = await fetchCardmarketPrice(nft.name);
  if (cardmarketPrice) return cardmarketPrice;

  return null;
}
```

### Caching Strategy

For production, implement caching to reduce API calls:

```typescript
import { redis } from '@/lib/redis';

async function fetchMarketPrice(nft: NFT): Promise<number | null> {
  const cacheKey = `price:${nft.name}`;

  // Check cache first
  const cached = await redis.get(cacheKey);
  if (cached) {
    return parseFloat(cached);
  }

  // Fetch from API
  const price = await fetchFromAPI(nft.name);

  // Cache for 1 hour
  if (price) {
    await redis.setex(cacheKey, 3600, price.toString());
  }

  return price;
}
```

## Rate Limiting

Implement rate limiting to avoid API limits:

```typescript
import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, "1 m"),
});

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const wallet = searchParams.get('wallet');
  const ip = request.ip ?? "127.0.0.1";

  const { success } = await ratelimit.limit(ip);

  if (!success) {
    return NextResponse.json(
      { error: 'Rate limit exceeded' },
      { status: 429 }
    );
  }

  // ... rest of the code
}
```

## Error Handling

Always implement proper error handling:

```typescript
try {
  const data = await fetchAPI();
  return NextResponse.json(data);
} catch (error) {
  if (error instanceof Error) {
    console.error('API Error:', error.message);

    if (error.message.includes('404')) {
      return NextResponse.json(
        { error: 'NFT not found' },
        { status: 404 }
      );
    }

    if (error.message.includes('rate limit')) {
      return NextResponse.json(
        { error: 'Rate limit exceeded. Please try again later.' },
        { status: 429 }
      );
    }
  }

  return NextResponse.json(
    { error: 'Internal server error' },
    { status: 500 }
  );
}
```

---

For more information, visit the [Next.js API Routes documentation](https://nextjs.org/docs/app/building-your-application/routing/route-handlers).
