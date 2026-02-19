# Deployment Guide

## Environment Variables

Create a `.env.local` file for local development:

```env
# CollectorCrypt API Configuration
COLLECTORCRYPT_API_KEY=your_api_key_here
COLLECTORCRYPT_API_URL=https://api.collectorcrypt.com

# Market Price APIs
TCGPLAYER_API_KEY=your_tcgplayer_api_key
POKEMON_TCG_API_KEY=your_pokemon_tcg_api_key

# Optional: Redis for caching
REDIS_URL=redis://localhost:6379

# Optional: Analytics
NEXT_PUBLIC_GA_ID=your_google_analytics_id
```

## Deployment Platforms

### Vercel (Recommended)

1. **Install Vercel CLI**:
```bash
npm i -g vercel
```

2. **Deploy**:
```bash
vercel
```

3. **Add Environment Variables**:
   - Go to Vercel Dashboard → Project → Settings → Environment Variables
   - Add all required environment variables

4. **Custom Domain** (optional):
```bash
vercel domains add yourdomain.com
```

### Docker

1. **Build Docker Image**:
```bash
docker build -t pokemon-nft-gallery .
```

2. **Run Container**:
```bash
docker run -p 3000:3000 \
  -e COLLECTORCRYPT_API_KEY=your_key \
  -e TCGPLAYER_API_KEY=your_key \
  pokemon-nft-gallery
```

3. **Docker Compose**:
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - COLLECTORCRYPT_API_KEY=${COLLECTORCRYPT_API_KEY}
      - TCGPLAYER_API_KEY=${TCGPLAYER_API_KEY}
      - POKEMON_TCG_API_KEY=${POKEMON_TCG_API_KEY}
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Netlify

1. **Install Netlify CLI**:
```bash
npm i -g netlify-cli
```

2. **Deploy**:
```bash
netlify deploy --prod
```

3. **Add Environment Variables**:
   - Go to Netlify Dashboard → Site Settings → Environment Variables
   - Add all required environment variables

### AWS (Amplify)

1. **Install Amplify CLI**:
```bash
npm i -g @aws-amplify/cli
```

2. **Initialize**:
```bash
amplify init
```

3. **Add Hosting**:
```bash
amplify add hosting
```

4. **Publish**:
```bash
amplify publish
```

### Traditional VPS (DigitalOcean, Linode, etc.)

1. **Build Application**:
```bash
npm run build
```

2. **Install PM2**:
```bash
npm install -g pm2
```

3. **Start with PM2**:
```bash
pm2 start npm --name "pokemon-nft-gallery" -- start
pm2 save
pm2 startup
```

4. **Configure Nginx**:
```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Performance Optimization

### Enable Caching

1. **Next.js Config** (`next.config.ts`):
```typescript
const nextConfig = {
  async headers() {
    return [
      {
        source: '/api/:path*',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, s-maxage=60, stale-while-revalidate=300',
          },
        ],
      },
    ];
  },
};
```

2. **Redis Caching**:
```bash
npm install @upstash/redis
```

```typescript
// lib/redis.ts
import { Redis } from '@upstash/redis';

const redis = new Redis({
  url: process.env.REDIS_URL!,
  token: process.env.REDIS_TOKEN!,
});

export { redis };
```

### Image Optimization

Use Next.js Image component for automatic optimization:

```typescript
import Image from 'next/image';

<Image
  src={nft.image}
  alt={nft.name}
  width={400}
  height={300}
  loading="lazy"
/>
```

## Monitoring

### Vercel Analytics

1. Install:
```bash
npm install @vercel/analytics
```

2. Add to layout:
```typescript
import { Analytics } from '@vercel/analytics/react';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
      </body>
    </html>
  );
}
```

### Error Tracking (Sentry)

1. Install:
```bash
npm install @sentry/nextjs
```

2. Initialize:
```bash
npx @sentry/wizard@latest -i nextjs
```

### Uptime Monitoring

Use services like:
- [UptimeRobot](https://uptimerobot.com/)
- [Pingdom](https://www.pingdom.com/)
- [Better Uptime](https://betteruptime.com/)

## Security

### Environment Variables

Never commit `.env.local` to git. Use `.env.local.example` instead.

### API Key Protection

- Use server-side API routes for sensitive operations
- Never expose API keys in client-side code
- Rotate API keys regularly

### Rate Limiting

Implement rate limiting to prevent abuse:

```typescript
import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, "1 m"),
});
```

### HTTPS

Always use HTTPS in production:
- Vercel provides HTTPS automatically
- For custom domains, use Let's Encrypt or Cloudflare

## Scaling

### Horizontal Scaling

- Use a load balancer (nginx, HAProxy)
- Run multiple instances behind the load balancer

### Database Scaling

- Use Redis for caching
- Consider PostgreSQL or MongoDB for persistent storage
- Implement read replicas for high-traffic scenarios

### CDN

Use a CDN for static assets:
- Vercel Edge Network
- Cloudflare
- AWS CloudFront

## Backup Strategy

1. **Regular Backups**:
   - Database backups daily
   - Keep backups for 30 days
   - Test restoration process

2. **Disaster Recovery**:
   - Document recovery procedures
   - Maintain offsite backups
   - Regularly test DR plans

## Troubleshooting

### Common Issues

1. **Build Fails**:
```bash
# Clear cache
rm -rf .next
npm run build
```

2. **API Not Working**:
   - Check environment variables
   - Verify API keys are correct
   - Check API rate limits

3. **Images Not Loading**:
   - Verify image URLs are accessible
   - Check CORS settings
   - Ensure `next/image` is properly configured

### Logs

- **Vercel**: Dashboard → Logs
- **PM2**: `pm2 logs`
- **Docker**: `docker logs <container-id>`

## Support

For deployment issues:
- Check Next.js documentation: https://nextjs.org/docs
- Platform-specific docs: Vercel, Netlify, AWS, etc.
- Open an issue on GitHub

---

Good luck with your deployment! 🚀
