# Pokemon NFT Gallery - Token 部署指南

## 🚀 快速部署（无需浏览器登录）

我已经安装了 Netlify CLI，支持通过 token 直接部署。

---

## 📋 获取 Netlify Token

### 步骤1：创建 Netlify 账号（如果没有）
1. 访问 https://www.netlify.com/
2. 点击 "Sign up"
3. 使用 GitHub、GitLab、Bitbucket 或邮箱注册

### 步骤2：生成 Personal Access Token
1. 访问 https://app.netlify.com/user/applications
2. 点击 "New access token"
3. 输入描述（如：Pokemon NFT Gallery Deploy）
4. 点击 "Generate token"
5. **复制并保存这个 token**（只显示一次！）

---

## 🚀 使用 Token 部署

### 方法1：使用部署脚本（推荐）

在命令行中运行：

```cmd
cd C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery
deploy-netlify.bat 你的_netlify_token
```

示例：
```cmd
deploy-netlify.bat nfp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 方法2：手动命令

```cmd
cd C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery

set NETLIFY_AUTH_TOKEN=你的_netlify_token
netlify sites:create --name pokemon-nft-gallery
netlify deploy --prod
```

---

## ⏱️ 预计时间

- 获取 token：2分钟
- 运行部署命令：3-5分钟
- **总计：5-7分钟**

---

## 🎉 部署成功后

你的网站将可以通过以下地址访问：
- https://pokemon-nft-gallery.netlify.app
- 或者在 Netlify 控制台查看确切 URL

---

## 📝 注意事项

1. **Token 安全**：
   - 不要分享你的 token
   - 不要提交到 Git
   - 可以随时在 Netlify 控制台删除并重新生成

2. **自动部署**：
   - 一旦部署成功，后续更新只需运行 `netlify deploy --prod`
   - 也可以连接 Git 仓库实现自动部署

3. **自定义域名**：
   - 登录 Netlify 控制台
   - 添加自定义域名
   - 配置 DNS 记录

---

## 🆘 常见问题

### Q: 部署失败怎么办？
A: 检查以下几点：
1. Token 是否正确
2. 网络连接是否正常
3. 构建是否成功（运行 `npm run build`）

### Q: 如何查看部署日志？
A:
1. 登录 https://app.netlify.com
2. 选择你的网站
3. 点击 "Deploys" 查看部署历史和日志

### Q: 如何更新网站？
A: 只需重新运行部署命令：
```cmd
netlify deploy --prod --token=你的_token
```

---

## 📞 需要帮助？

如果在部署过程中遇到问题，告诉我错误信息，我会帮你解决！
