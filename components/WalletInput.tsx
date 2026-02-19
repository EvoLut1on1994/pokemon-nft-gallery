export default function WalletInput({
  walletAddress,
  setWalletAddress,
  background,
  setBackground,
  onSearch,
  loading,
}: {
  walletAddress: string;
  setWalletAddress: (address: string) => void;
  background: string;
  setBackground: (bg: string) => void;
  onSearch: () => void;
  loading: boolean;
}) {
  return (
    <div className="bg-white rounded-xl shadow-lg p-6 max-w-4xl mx-auto">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Wallet Address
          </label>
          <input
            type="text"
            value={walletAddress}
            onChange={(e) => setWalletAddress(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && onSearch()}
            placeholder="Enter CollectorCrypt wallet address..."
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Background Theme
          </label>
          <select
            value={background}
            onChange={(e) => setBackground(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          >
            <option value="default">Default Gradient</option>
            <option value="woodgrain">Wood Grain</option>
            <option value="dark">Dark Mode</option>
            <option value="light">Light</option>
          </select>
        </div>
      </div>

      <button
        onClick={onSearch}
        disabled={loading || !walletAddress.trim()}
        className="w-full bg-indigo-600 text-white py-3 px-6 rounded-lg font-semibold hover:bg-indigo-700 focus:ring-4 focus:ring-indigo-300 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {loading ? 'Searching...' : 'Search NFTs'}
      </button>
    </div>
  );
}
