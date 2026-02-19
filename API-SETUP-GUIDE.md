# API 配置指南

## 快速配置（推荐）

### 步骤 1: 获取 Helius API Key（免费）

1. 访问 https://www.helius.dev/
2. 使用 GitHub 或 Google 账户登录
3. 复制你的 API Key

### 步骤 2: 获取 Pokemon TCG API Key（免费）

1. 访问 https://pokemontcg.io/
2. 注册免费账户
3. Dashboard → API Keys → Create API Key
4. 复制 API Key

### 步骤 3: 配置环境变量

创建 `.env.local` 文件：

```env
HELIUS_API_KEY=your_helius_key_here
POKEMON_TCG_API_KEY=your_pokemon_tcg_key_here
```

### 步骤 4: 测试

```bash
npm run dev
```

访问 http://localhost:3000，输入你的钱包地址。

---

## 为什么需要API Key？

网站需要从以下数据源获取数据：

1. **Solana NFT数据**: 从区块链查询NFT所有权和元数据
   - 推荐API: Helius（免费，100,000 req/day）
   - 备选: Alchemy、Moralis

2. **市场价格**: Pokemon卡牌的市场价格
   - 推荐API: Pokemon TCG（免费，50 req/day）
   - 备选: TCGPlayer

---

## 如何获取API Key？

### Helius（推荐）

1. 访问 https://www.helius.dev/
2. Sign up with GitHub or Google
3. Copy API Key from Dashboard
4. 完全免费，无需信用卡

### Pokemon TCG

1. 访问 https://pokemontcg.io/
2. Sign In / Sign Up
3. Dashboard → API Keys
4. Create API Key
5. 完全免费

---

## 暂时不用API也可以

网站包含Mock数据，可以在没有API的情况下查看演示效果。

但要让网站真正查询你的NFT数据，需要配置API。

---

## 问题？

查看完整文档：API.md
