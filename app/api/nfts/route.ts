import { NextRequest, NextResponse } from 'next/server';

interface NFT {
  id: string;
  name: string;
  image: string;
  rarity: string;
  series: string;
  collectorCryptPrice: number | null;
  marketPrice: number | null;
  priceDifference: number | null;
}

// Pokemon card price database (sample data - in production, this would be from an external API)
const pokemonPrices: { [key: string]: { series: string; rarity: string; price: number } } = {
  'charizard': { series: 'Base Set', rarity: 'Holo Rare', price: 350.00 },
  'pikachu': { series: 'Base Set', rarity: 'Rare', price: 25.00 },
  'mewtwo': { series: 'Base Set', rarity: 'Holo Rare', price: 180.00 },
  'blastoise': { series: 'Base Set', rarity: 'Holo Rare', price: 120.00 },
  'venusaur': { series: 'Base Set', rarity: 'Holo Rare', price: 110.00 },
  'dragonite': { series: 'Fossil', rarity: 'Holo Rare', price: 95.00 },
  'gyarados': { series: 'Base Set', rarity: 'Holo Rare', price: 85.00 },
  'snorlax': { series: 'Jungle', rarity: 'Holo Rare', price: 70.00 },
  'lugia': { series: 'Neo Genesis', rarity: 'Rare Holo', price: 150.00 },
  'ho-oh': { series: 'Neo Genesis', rarity: 'Rare Holo', price: 140.00 },
};

// Mock CollectorCrypt API data
async function fetchCollectorCryptNFTs(walletAddress: string): Promise<NFT[]> {
  // In production, this would make an actual API call to CollectorCrypt
  // For now, we'll simulate it with mock data

  const mockNFTs: NFT[] = [
    {
      id: '1',
      name: 'Charizard - Base Set Holo',
      image: 'https://images.pokemontcg.io/base1/hires/4.jpg',
      rarity: 'Holo Rare',
      series: 'Base Set',
      collectorCryptPrice: 380.00,
      marketPrice: null,
      priceDifference: null,
    },
    {
      id: '2',
      name: 'Pikachu - Illustrator Promo',
      image: 'https://images.pokemontcg.io/pwp/01_hires.jpg',
      rarity: 'Promo',
      series: 'World Championships',
      collectorCryptPrice: 450.00,
      marketPrice: null,
      priceDifference: null,
    },
    {
      id: '3',
      name: 'Mewtwo - Base Set Holo',
      image: 'https://images.pokemontcg.io/base1/hires/10.jpg',
      rarity: 'Holo Rare',
      series: 'Base Set',
      collectorCryptPrice: 200.00,
      marketPrice: null,
      priceDifference: null,
    },
    {
      id: '4',
      name: 'Blastoise - Base Set Holo',
      image: 'https://images.pokemontcg.io/base1/hires/2.jpg',
      rarity: 'Holo Rare',
      series: 'Base Set',
      collectorCryptPrice: 130.00,
      marketPrice: null,
      priceDifference: null,
    },
    {
      id: '5',
      name: 'Venusaur - Base Set Holo',
      image: 'https://images.pokemontcg.io/base1/hires/15.jpg',
      rarity: 'Holo Rare',
      series: 'Base Set',
      collectorCryptPrice: 125.00,
      marketPrice: null,
      priceDifference: null,
    },
    {
      id: '6',
      name: 'Dragonite - Fossil Holo',
      image: 'https://images.pokemontcg.io/base4/hires/4.jpg',
      rarity: 'Holo Rare',
      series: 'Fossil',
      collectorCryptPrice: 100.00,
      marketPrice: null,
      priceDifference: null,
    },
  ];

  return mockNFTs;
}

// Fetch market prices from external sources
async function fetchMarketPrice(nft: NFT): Promise<number | null> {
  try {
    // Try to match Pokemon name to our database
    const lowerName = nft.name.toLowerCase();

    for (const [key, value] of Object.entries(pokemonPrices)) {
      if (lowerName.includes(key)) {
        return value.price;
      }
    }

    // If not found, try TCGPlayer API (would need API key in production)
    // const response = await fetch(`https://api.tcgplayer.com/...`);
    // const data = await response.json();

    // For demo purposes, return null if not found
    return null;
  } catch (error) {
    console.error('Error fetching market price:', error);
    return null;
  }
}

export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const wallet = searchParams.get('wallet');

  if (!wallet) {
    return NextResponse.json(
      { error: 'Wallet address is required' },
      { status: 400 }
    );
  }

  try {
    // Fetch NFTs from CollectorCrypt
    let nfts = await fetchCollectorCryptNFTs(wallet);

    // Fetch market prices for each NFT
    const nftsWithPrices = await Promise.all(
      nfts.map(async (nft) => {
        const marketPrice = await fetchMarketPrice(nft);
        let priceDifference: number | null = null;

        if (nft.collectorCryptPrice !== null && marketPrice !== null) {
          priceDifference = ((marketPrice - nft.collectorCryptPrice) / nft.collectorCryptPrice) * 100;
        }

        return {
          ...nft,
          marketPrice,
          priceDifference,
        };
      })
    );

    return NextResponse.json({
      nfts: nftsWithPrices,
      total: nftsWithPrices.length,
    });
  } catch (error) {
    console.error('Error fetching NFTs:', error);
    return NextResponse.json(
      { error: 'Failed to fetch NFTs' },
      { status: 500 }
    );
  }
}
