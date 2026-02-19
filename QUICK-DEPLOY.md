# Pokemon NFT Gallery - 快速部署指南

## 准备工作（回到电脑后）

### 1. 打开项目目录
```bash
cd C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery
```

### 2. 双击运行部署脚本
- Windows: 双击 `deploy.bat`
- Mac/Linux: 运行 `./deploy.sh`

### 3. 按提示操作
脚本会自动完成以下操作：
- ✅ 安装 Vercel CLI（如果没有）
- ✅ 登录 Vercel 账户（如果没有）
- ✅ 安装项目依赖
- ✅ 构建项目
- ✅ 部署到 Vercel
- ✅ 生成永久 URL

### 4. 配置环境变量（可选）
如果需要使用真实API，访问 Vercel Dashboard 配置：
- https://vercel.com/dashboard → 你的项目 → Settings → Environment Variables

## 需要配置的环境变量

```
COLLECTORCRYPT_API_KEY=your_api_key_here
TCGPLAYER_API_KEY=your_tcgplayer_api_key
POKEMON_TCG_API_KEY=your_pokemon_tcg_api_key
REDIS_URL=redis://localhost:6379 (可选)
```

## 完成！

部署完成后，你会获得一个永久 URL，格式类似：
- `https://pokemon-nft-gallery.vercel.app`

## 下次更新

只需在项目目录执行：
```bash
vercel --prod
```

## 预计时间

- 首次部署：5-10 分钟
- 后续更新：2-5 分钟

## 常见问题

### Q: 需要付费吗？
A: Vercel 有免费套餐，足够个人使用。

### Q: 不配置环境变量能运行吗？
A: 可以！项目会使用模拟数据，功能完整。

### Q: 部署失败怎么办？
A: 检查网络连接，确保 Node.js 已安装，重新运行脚本。

---

**需要帮助？** 让我知道！🚀
