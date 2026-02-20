/**
 * Client-side API functions for Pokemon NFT Gallery
 * All API calls are made directly from the browser
 */

export interface PokemonCard {
  id: string;
  name: string;
  images: {
    small: string;
    large: string;
  };
  rarity?: string;
  set?: {
    name: string;
    series: string;
  };
  types?: string[];
  marketPrice?: number;
  tcgplayer?: {
    prices?: {
      holofoil?: {
        market?: number;
        mid?: number;
        low?: number;
      };
      normal?: {
        market?: number;
        mid?: number;
        low?: number;
      };
    };
  };
  cardmarket?: {
    prices?: {
      averageSellPrice?: number;
    };
  };
}

export interface NFTMetadata {
  id: string;
  name: string;
  image: string;
  collection: string;
  attributes: Array<{ trait_type: string; value: string }>;
}

/**
 * Fetch NFTs from Solana using Helius API (client-side)
 * Requires HELIUS_API_KEY in .env.local (client-side accessible)
 */
export async function fetchSolanaNFTs(walletAddress: string): Promise<NFTMetadata[]> {
  // Check if API key is available
  const apiKey = process.env.NEXT_PUBLIC_HELIUS_API_KEY;

  if (!apiKey) {
    console.warn('HELIUS_API_KEY not found, using mock data');
    return getMockNFTs();
  }

  try {
    const response = await fetch(
      `https://mainnet.helius-rpc.com/?api-key=${apiKey}`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          jsonrpc: '2.0',
          id: 'my-id',
          method: 'getAssetsByOwner',
          params: {
            ownerAddress: walletAddress,
            page: 1,
            limit: 100,
            displayOptions: {
              showFungible: false,
              showNativeBalance: false,
            },
          },
        }),
      }
    );

    const data = await response.json();
    const nfts: NFTMetadata[] = [];

    if (data.result && data.result.items) {
      for (const item of data.result.items) {
        nfts.push({
          id: item.id,
          name: item.content?.metadata?.name || 'Unknown NFT',
          image:
            item.content?.links?.image ||
            item.content?.files?.[0]?.uri ||
            '/placeholder.png',
          collection: item.content?.metadata?.collection?.name || 'Unknown Collection',
          attributes:
            item.content?.metadata?.attributes?.map((attr: any) => ({
              trait_type: attr.trait_type,
              value: attr.value,
            })) || [],
        });
      }
    }

    return nfts;
  } catch (error) {
    console.error('Error fetching Solana NFTs:', error);
    throw error;
  }
}

/**
 * Search Pokemon TCG API by card name
 * Public API, no key required
 */
export async function searchPokemonCard(query: string): Promise<PokemonCard[]> {
  try {
    const response = await fetch(`https://api.pokemontcg.io/v2/cards?q=${encodeURIComponent(query)}`);

    if (!response.ok) {
      throw new Error('Failed to fetch Pokemon TCG data');
    }

    const data = await response.json();
    return data.data || [];
  } catch (error) {
    console.error('Error searching Pokemon TCG:', error);
    throw error;
  }
}

/**
 * Get Pokemon card by ID
 * Public API, no key required
 */
export async function getPokemonCard(cardId: string): Promise<PokemonCard | null> {
  try {
    const response = await fetch(`https://api.pokemontcg.io/v2/cards/${cardId}`);

    if (!response.ok) {
      throw new Error('Failed to fetch Pokemon card');
    }

    const data = await response.json();
    return data.data || null;
  } catch (error) {
    console.error('Error fetching Pokemon card:', error);
    throw error;
  }
}

/**
 * Calculate average market price from TCG API data
 */
export function calculateMarketPrice(card: PokemonCard): number {
  const prices = [];

  if (card.tcgplayer?.prices?.holofoil?.market) {
    prices.push(card.tcgplayer.prices.holofoil.market);
  }
  if (card.tcgplayer?.prices?.normal?.market) {
    prices.push(card.tcgplayer.prices.normal.market);
  }
  if (card.tcgplayer?.prices?.holofoil?.mid) {
    prices.push(card.tcgplayer.prices.holofoil.mid);
  }
  if (card.tcgplayer?.prices?.normal?.mid) {
    prices.push(card.tcgplayer.prices.normal.mid);
  }
  if (card.cardmarket?.prices?.averageSellPrice) {
    prices.push(card.cardmarket.prices.averageSellPrice);
  }

  if (prices.length === 0) return 0;

  return prices.reduce((sum, price) => sum + price, 0) / prices.length;
}

/**
 * Mock NFT data for demo purposes
 */
function getMockNFTs(): NFTMetadata[] {
  return [
    {
      id: '1',
      name: 'Charizard Base Set',
      image: 'https://images.pokemontcg.io/base1/hires/4.jpg',
      collection: 'Base Set',
      attributes: [
        { trait_type: 'Rarity', value: 'Holo Rare' },
        { trait_type: 'Type', value: 'Fire' },
      ],
    },
    {
      id: '2',
      name: 'Pikachu Illustrator',
      image: 'https://images.pokemontcg.io/pqp/hires/1.jpg',
      collection: 'Pokemon Quest',
      attributes: [
        { trait_type: 'Rarity', value: 'Promo' },
        { trait_type: 'Type', value: 'Electric' },
      ],
    },
    {
      id: '3',
      name: 'Blastoise Base Set',
      image: 'https://images.pokemontcg.io/base1/hires/2.jpg',
      collection: 'Base Set',
      attributes: [
        { trait_type: 'Rarity', value: 'Holo Rare' },
        { trait_type: 'Type', value: 'Water' },
      ],
    },
    {
      id: '4',
      name: 'Mewtwo Base Set',
      image: 'https://images.pokemontcg.io/base1/hires/10.jpg',
      collection: 'Base Set',
      attributes: [
        { trait_type: 'Rarity', value: 'Holo Rare' },
        { trait_type: 'Type', value: 'Psychic' },
      ],
    },
  ];
}

/**
 * Try to match NFT metadata to Pokemon TCG card
 */
export async function matchPokemonCard(nftName: string): Promise<PokemonCard | null> {
  try {
    const cards = await searchPokemonCard(nftName);
    return cards[0] || null;
  } catch (error) {
    console.error('Error matching Pokemon card:', error);
    return null;
  }
}
