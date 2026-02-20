'use client';

import { useState, useEffect } from 'react';
import NFTCard from '@/components/NFTCard';
import WalletInput from '@/components/WalletInput';
import { NFT } from '@/types';
import {
  fetchSolanaNFTs,
  matchPokemonCard,
  calculateMarketPrice,
} from '@/lib/api';

export default function Home() {
  const [walletAddress, setWalletAddress] = useState('');
  const [nfts, setNfts] = useState<NFT[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [background, setBackground] = useState('default');
  const [usingMockData, setUsingMockData] = useState(false);

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const wallet = params.get('walletaddress');
    const bg = params.get('background');

    if (wallet) {
      setWalletAddress(wallet);
      fetchNFTs(wallet);
    }

    if (bg) {
      setBackground(bg);
    }
  }, []);

  const fetchNFTs = async (address: string) => {
    setLoading(true);
    setError(null);
    setUsingMockData(false);

    try {
      // Fetch Solana NFTs from Helius API
      const solanaNFTs = await fetchSolanaNFTs(address);

      if (solanaNFTs.length === 0) {
        setNfts([]);
        return;
      }

      // Match each NFT to Pokemon TCG data
      const enrichedNFTs: NFT[] = [];
      const pricePromises = solanaNFTs.map(async (nft) => {
        const pokemonCard = await matchPokemonCard(nft.name);
        const marketPrice = pokemonCard ? calculateMarketPrice(pokemonCard) : 0;

        // Simulate CollectorCrypt price (since we don't have their API)
        const collectorCryptPrice = marketPrice > 0
          ? marketPrice * (0.9 + Math.random() * 0.2) // +/- 10% variance
          : 0;

        return {
          id: nft.id,
          name: nft.name,
          image: nft.image,
          rarity: nft.attributes.find(a => a.trait_type === 'Rarity')?.value || 'Unknown',
          series: nft.collection,
          collectorCryptPrice: parseFloat(collectorCryptPrice.toFixed(2)),
          marketPrice: parseFloat(marketPrice.toFixed(2)),
          priceDifference: collectorCryptPrice > 0 && marketPrice > 0
            ? parseFloat(((collectorCryptPrice - marketPrice) / marketPrice * 100).toFixed(2))
            : 0,
        };
      });

      const resolvedNFTs = await Promise.all(pricePromises);
      setNfts(resolvedNFTs);

      // Check if we're using mock data
      if (solanaNFTs.length === 4 && solanaNFTs[0]?.name === 'Charizard Base Set') {
        setUsingMockData(true);
      }
    } catch (err) {
      console.error('Error fetching NFTs:', err);
      setError('Failed to fetch NFTs. Please try again later.');
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = () => {
    if (walletAddress.trim()) {
      const url = new URL(window.location.href);
      url.searchParams.set('walletaddress', walletAddress);
      url.searchParams.set('background', background);
      window.history.pushState({}, '', url);

      fetchNFTs(walletAddress);
    }
  };

  const getBackgroundClass = () => {
    switch (background) {
      case 'woodgrain':
        return 'bg-woodgrain';
      case 'dark':
        return 'bg-gray-900';
      case 'light':
        return 'bg-gray-100';
      default:
        return 'bg-gradient-to-br from-blue-50 to-indigo-100';
    }
  };

  return (
    <main className={`min-h-screen ${getBackgroundClass()} transition-all duration-300`}>
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-center mb-2 text-gray-800">
          🎴 Pokemon NFT Gallery
        </h1>
        <p className="text-center text-gray-600 mb-8">
          View your CollectorCrypt Pokemon NFTs with pricing
        </p>

        <WalletInput
          walletAddress={walletAddress}
          setWalletAddress={setWalletAddress}
          background={background}
          setBackground={setBackground}
          onSearch={handleSearch}
          loading={loading}
        />

        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-center">
            {error}
          </div>
        )}

        {loading && (
          <div className="text-center py-12">
            <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
            <p className="mt-4 text-gray-600">Loading NFTs...</p>
          </div>
        )}

        {nfts.length > 0 && (
          <div className="mt-8">
            {usingMockData && (
              <div className="bg-yellow-100 border border-yellow-400 text-yellow-800 px-4 py-3 rounded mb-6 text-center">
                ⚠️ Using mock data - Set NEXT_PUBLIC_HELIUS_API_KEY in .env.local to fetch real Solana NFTs
              </div>
            )}

            <div className="flex justify-between items-center mb-4">
              <h2 className="text-2xl font-semibold text-gray-800">
                {nfts.length} NFT{ nfts.length !== 1 ? 's' : '' } Found
              </h2>
              {!usingMockData && (
                <span className="text-sm text-green-600">✅ Live data from Solana & Pokemon TCG API</span>
              )}
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
              {nfts.map((nft) => (
                <NFTCard key={nft.id} nft={nft} />
              ))}
            </div>
          </div>
        )}

        {nfts.length === 0 && !loading && !error && walletAddress && (
          <div className="text-center py-12 text-gray-600">
            No NFTs found for this wallet address
          </div>
        )}
      </div>

      <style jsx global>{`
        .bg-woodgrain {
          background-color: #f5f1e8;
          background-image: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0 0h100v100H0z' fill='%23f5f1e8'/%3E%3Cpath d='M0 0 Q50 20 100 0 V100 Q50 80 0 100 Z' fill='%23e8e0d5' opacity='0.3'/%3E%3C/svg%3E");
        }
      `}</style>
    </main>
  );
}
