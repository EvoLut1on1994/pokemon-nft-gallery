export interface NFT {
  id: string;
  name: string;
  image: string;
  rarity: string;
  series: string;
  collectorCryptPrice: number | null;
  marketPrice: number | null;
  priceDifference: number | null;
}
