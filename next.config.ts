import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: 'export',
  basePath: '/pokemon-nft-gallery',
  assetPrefix: '/pokemon-nft-gallery',
  images: {
    unoptimized: true,
  },
};

export default nextConfig;
