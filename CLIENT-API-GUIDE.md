# Pokemon NFT Gallery - Client-Side API Guide

## 🎉 Deployment Complete!

The Pokemon NFT Gallery has been successfully deployed to GitHub Pages:
**https://evolut1on1994.github.io/pokemon-nft-gallery/**

## 🚀 Current Status

### What's Working
- ✅ Static deployment on GitHub Pages
- ✅ Client-side API integration
- ✅ Responsive design
- ✅ Background theme options
- ✅ Pokemon card data from public Pokemon TCG API

### Current Limitations
- ⚠️ Using mock data for Solana NFTs (Helius API key not configured)
- ⚠️ CollectorCrypt pricing is simulated (no API access)
- ⚠️ Real-time Solana NFT fetching requires API key

## 🔧 How to Use Real Data

### Option 1: Get a Free Helius API Key (Recommended)

Helius provides a free tier with generous limits:

1. **Sign up** at https://www.helius.dev/signup
2. **Get your API key** from the dashboard
3. **Add it to `.env.local`** (create this file in the project root):

```env
NEXT_PUBLIC_HELIUS_API_KEY=your_helius_api_key_here
```

4. **Rebuild and deploy:**

```bash
npm run build
git add out/
git commit -m "chore: Update build with real API key"
git push origin main
```

### Option 2: Use Pokemon TCG API Key (Optional)

Pokemon TCG API offers a free tier with 50 requests/day:

1. **Sign up** at https://dev.pokemontcg.io/
2. **Get your API key**
3. **Add to `.env.local`:**

```env
NEXT_PUBLIC_POKEMON_TCG_API_KEY=your_api_key_here
```

### Option 3: Continue with Mock Data

If you don't want to set up API keys, the app will continue to work with mock data, which is fine for demonstration purposes.

## 📊 API Integration Details

### What's Integrated

1. **Helius API** (Solana NFTs)
   - Endpoint: `https://mainnet.helius-rpc.com/`
   - Purpose: Fetch NFTs from Solana wallets
   - Status: Configured but needs API key for real data

2. **Pokemon TCG API** (Card Data)
   - Endpoint: `https://api.pokemontcg.io/v2/`
   - Purpose: Get Pokemon card details and market prices
   - Status: Fully functional (no key required for basic usage)

3. **CollectorCrypt** (Pricing)
   - Status: Simulated (no public API available)
   - Pricing is estimated based on TCG market data

### Client-Side Architecture

The app uses a pure client-side architecture:

- **No API routes** - All API calls happen directly from the browser
- **No server requirements** - Can be deployed to any static hosting
- **GitHub Pages compatible** - Works perfectly with static export
- **Privacy focused** - No data passes through our servers

## 🎯 Features

### Wallet Lookup
- Enter any Solana wallet address
- Fetches NFTs from the wallet
- Matches NFTs to Pokemon TCG cards
- Shows pricing comparison

### Background Themes
- **Default**: Blue gradient
- **Woodgrain**: Classic trading card look
- **Dark**: Night mode
- **Light**: Clean white theme

### Price Comparison
- **CollectorCrypt Price**: Estimated price from CollectorCrypt (simulated)
- **Market Price**: Average market price from multiple sources
- **Price Difference**: Percentage difference between the two

## 🛠️ Development

### Local Development

1. **Install dependencies:**

```bash
npm install
```

2. **Configure API keys** (optional):

```bash
cp .env.local.example .env.local
# Edit .env.local with your API keys
```

3. **Run development server:**

```bash
npm run dev
```

4. **Build for production:**

```bash
npm run build
```

### Testing the Build

To test the production build locally:

```bash
npm run build
npx serve out
```

## 📝 API Function Reference

### `fetchSolanaNFTs(walletAddress: string)`
Fetches NFTs from a Solana wallet using Helius API.

### `searchPokemonCard(query: string)`
Searches Pokemon TCG API for cards matching the query.

### `getPokemonCard(cardId: string)`
Gets specific Pokemon card details by ID.

### `calculateMarketPrice(card: PokemonCard)`
Calculates average market price from multiple sources (TCGPlayer, Cardmarket).

### `matchPokemonCard(nftName: string)`
Matches NFT metadata to Pokemon TCG cards.

## 🚨 Troubleshooting

### Issue: "Using mock data" warning
**Solution**: Add `NEXT_PUBLIC_HELIUS_API_KEY` to `.env.local`

### Issue: NFTs not loading
**Solution**: Check that:
1. Wallet address is valid Solana address
2. API key is correctly configured
3. Browser console for specific error messages

### Issue: Images not loading
**Solution**: Pokemon TCG API images should load automatically. If not, check:
1. Network connection
2. CORS settings (should work fine)
3. Image URLs in browser console

## 📚 API Documentation

- **Helius**: https://docs.helius.dev/
- **Pokemon TCG API**: https://docs.pokemontcg.io/
- **Next.js Static Export**: https://nextjs.org/docs/app/building-your-application/deploying/static-exports

## 🎨 Customization

### Adding More APIs

Edit `lib/api.ts` to add new API integrations:

```typescript
export async function yourNewAPI() {
  const response = await fetch('your-api-endpoint');
  const data = await response.json();
  return data;
}
```

### Modifying Card Display

Edit `components/NFTCard.tsx` to customize how cards are displayed.

### Adding New Backgrounds

Edit `app/page.tsx` and add new options to the `getBackgroundClass()` function.

## 📞 Support

If you encounter issues:

1. Check the browser console for errors
2. Review API documentation links above
3. Ensure API keys are correctly configured
4. Verify network connectivity

---

**Last Updated**: 2026-02-20
**Version**: 1.0.0
