'use client';

import { useState, useEffect } from 'react';
import NFTCard from '@/components/NFTCard';
import WalletInput from '@/components/WalletInput';
import { NFT } from '@/types';

export default function Home() {
  const [walletAddress, setWalletAddress] = useState('');
  const [nfts, setNfts] = useState<NFT[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [background, setBackground] = useState('default');

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

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1000));

    try {
      // Mock data for demonstration
      const mockNFTs: NFT[] = [
        {
          id: '1',
          name: 'Charizard - Base Set Holo',
          image: 'https://images.pokemontcg.io/base1/hires/4.jpg',
          rarity: 'Holo Rare',
          series: 'Base Set',
          collectorCryptPrice: 380.00,
          marketPrice: 350.00,
          priceDifference: -7.89,
        },
        {
          id: '2',
          name: 'Pikachu - Illustrator',
          image: 'https://images.pokemontcg.io/pqp/hires/1.jpg',
          rarity: 'Promo',
          series: 'Pokemon Quest',
          collectorCryptPrice: 2500.00,
          marketPrice: 2800.00,
          priceDifference: 12.00,
        },
        {
          id: '3',
          name: 'Blastoise - Base Set Holo',
          image: 'https://images.pokemontcg.io/base1/hires/2.jpg',
          rarity: 'Holo Rare',
          series: 'Base Set',
          collectorCryptPrice: 200.00,
          marketPrice: 185.00,
          priceDifference: -7.50,
        },
        {
          id: '4',
          name: 'Mewtwo - Base Set Holo',
          image: 'https://images.pokemontcg.io/base1/hires/10.jpg',
          rarity: 'Holo Rare',
          series: 'Base Set',
          collectorCryptPrice: 150.00,
          marketPrice: 160.00,
          priceDifference: 6.67,
        },
      ];

      setNfts(mockNFTs);
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
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-2xl font-semibold text-gray-800">
                {nfts.length} NFT{ nfts.length !== 1 ? 's' : '' } Found
              </h2>
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
