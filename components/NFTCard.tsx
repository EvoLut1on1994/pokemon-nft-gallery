import { NFT } from '@/types';

export default function NFTCard({ nft }: { nft: NFT }) {
  const getPriceColor = (difference: number | null) => {
    if (difference === null) return 'text-gray-500';
    if (difference > 0) return 'text-green-600';
    if (difference < 0) return 'text-red-600';
    return 'text-gray-600';
  };

  const getRarityColor = (rarity: string) => {
    const rarityLower = rarity.toLowerCase();
    if (rarityLower.includes('secret')) return 'bg-purple-500';
    if (rarityLower.includes('ultra rare') || rarityLower.includes('hyper rare')) return 'bg-red-500';
    if (rarityLower.includes('vmax') || rarityLower.includes('vstar')) return 'bg-yellow-500';
    if (rarityLower.includes('rare') || rarityLower.includes('holo')) return 'bg-blue-500';
    if (rarityLower.includes('uncommon')) return 'bg-green-500';
    return 'bg-gray-500';
  };

  return (
    <div className="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1">
      <div className="relative">
        <img
          src={nft.image || '/placeholder.png'}
          alt={nft.name}
          className="w-full h-48 object-cover"
          onError={(e) => {
            e.currentTarget.src = '/placeholder.png';
          }}
        />
        <div className={`absolute top-2 right-2 px-3 py-1 rounded-full text-white text-xs font-bold ${getRarityColor(nft.rarity)}`}>
          {nft.rarity}
        </div>
      </div>

      <div className="p-4">
        <h3 className="font-bold text-lg text-gray-800 mb-1 line-clamp-2" title={nft.name}>
          {nft.name}
        </h3>
        <p className="text-sm text-gray-600 mb-3">
          {nft.series}
        </p>

        <div className="space-y-2 border-t pt-3">
          {nft.collectorCryptPrice !== null && (
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">CollectorCrypt:</span>
              <span className="font-semibold text-gray-800">
                ${nft.collectorCryptPrice?.toFixed(2)}
              </span>
            </div>
          )}

          {nft.marketPrice !== null && (
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Market Price:</span>
              <span className="font-semibold text-indigo-600">
                ${nft.marketPrice?.toFixed(2)}
              </span>
            </div>
          )}

          {nft.priceDifference !== null && nft.collectorCryptPrice !== null && nft.marketPrice !== null && (
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Difference:</span>
              <span className={`font-semibold ${getPriceColor(nft.priceDifference)}`}>
                {nft.priceDifference > 0 ? '+' : ''}
                {nft.priceDifference.toFixed(2)}%
              </span>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
