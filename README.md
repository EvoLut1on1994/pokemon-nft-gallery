# Pokemon NFT Gallery

A beautiful Next.js application for viewing CollectorCrypt Pokemon NFTs with pricing information and market comparisons.

## Features

✨ **Beautiful UI** - Clean, modern interface with multiple background themes
📊 **Price Comparison** - View CollectorCrypt prices vs market prices
🎨 **Customizable** - Choose from different background themes
📱 **Responsive Design** - Works on all devices
🔍 **Easy Search** - Just enter your wallet address to view NFTs

## Quick Start

1. Install dependencies:
```bash
npm install
```

2. Run the development server:
```bash
npm run dev
```

3. Open [http://localhost:3000](http://localhost:3000) in your browser

## Usage

### Via URL Parameters

You can directly access a wallet's NFTs using URL parameters:

```
http://localhost:3000/?walletaddress=YOUR_WALLET_ADDRESS&background=woodgrain
```

Available backgrounds:
- `default` - Gradient background
- `woodgrain` - Wood grain texture
- `dark` - Dark mode
- `light` - Light mode

### Via the Interface

1. Enter your CollectorCrypt wallet address in the input field
2. Select a background theme (optional)
3. Click "Search NFTs"

## API Integration

### CollectorCrypt API

The app currently uses mock data. To integrate with the real CollectorCrypt API:

1. Create an `.env.local` file:
```env
COLLECTORCRYPT_API_KEY=your_api_key_here
COLLECTORCRYPT_API_URL=https://api.collectorcrypt.com
```

2. Update `app/api/nfts/route.ts` to fetch real data

### Market Price APIs

To fetch real market prices, integrate with:
- **TCGPlayer API** - [https://docs.tcgplayer.com/](https://docs.tcgplayer.com/)
- **Pokemon TCG API** - [https://pokemontcg.io/](https://pokemontcg.io/)
- **Cardmarket API** - [https://www.cardmarket.com/](https://www.cardmarket.com/)

Update the `fetchMarketPrice` function in `app/api/nfts/route.ts` to use real API calls.

## Project Structure

```
pokemon-nft-gallery/
├── app/
│   ├── api/
│   │   └── nfts/
│   │       └── route.ts          # API endpoint for fetching NFTs
│   ├── page.tsx                  # Main page component
│   ├── layout.tsx                # Root layout
│   └── globals.css               # Global styles
├── components/
│   ├── NFTCard.tsx               # Individual NFT card component
│   └── WalletInput.tsx           # Wallet input component
├── public/
│   └── placeholder.svg           # Fallback image
└── ...
```

## Customization

### Adding New Background Themes

1. Add the theme in `app/page.tsx` `getBackgroundClass` function
2. Add CSS styles in the `<style jsx global>` block
3. Add option to the select in `components/WalletInput.tsx`

### Adding New Price Sources

Modify `app/api/nfts/route.ts`:
1. Add new API endpoint configuration
2. Implement the price fetching function
3. Add price comparison logic

## Deployment

### Vercel

```bash
npm run build
vercel deploy
```

### Docker

```bash
docker build -t pokemon-nft-gallery .
docker run -p 3000:3000 pokemon-nft-gallery
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License

## Support

For issues and questions, please open an issue on GitHub.

---

Built with ❤️ using Next.js, TypeScript, and Tailwind CSS
