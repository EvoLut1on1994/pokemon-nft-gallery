# Pokemon NFT Gallery - 超简单部署指南

## 🚀 快速部署（三步走）

### 第1步：检查状态（可选）

**双击** `check-status.bat`

这会检查：
- Node.js 是否安装
- Vercel CLI 是否安装
- Vercel 是否已登录
- 项目是否已部署

---

### 第2步：登录 Vercel（如果未登录）

**双击** `login-helper.bat`

这会引导你：
1. 检查 Vercel CLI
2. 检查登录状态
3. 逐步完成登录流程
4. 验证登录结果

**登录步骤**：
1. 按 Enter 键在浏览器中打开 Vercel
2. 登录或注册账户（免费）
3. 验证邮箱（如果需要）
4. 验证完成后按任意键返回

---

### 第3步：部署项目

**双击** `deploy-2.bat`

这会自动完成：
1. 安装依赖
2. 构建项目
3. 部署到 Vercel
4. 生成你的永久 URL

**部署步骤**：
- 按 Enter 选择个人账户
- 按 Enter 使用默认项目名
- 按 Enter 确认部署配置
- 等待部署完成（2-5分钟）

**保存你的 URL**（格式：`https://pokemon-nft-gallery-xxx.vercel.app`）

---

## ✅ 完成！

现在你可以：
- 在浏览器中访问你的 URL
- 分享给其他人使用

---

## 🔍 诊断工具

### check-status.bat
检查所有环境状态（推荐首次使用前运行）

### login-helper.bat
逐步引导完成 Vercel 登录

### deploy-2.bat
执行项目部署

---

## 📝 下次更新

只需在项目文件夹打开命令行，执行：
```bash
vercel --prod
```

---

## ❓ 常见问题

**Q: 双击后窗口闪一下就没了？**
A: 使用 `check-status.bat` 检查状态，根据提示操作

**Q: 登录失败怎么办？**
A: 使用 `login-helper.bat` 逐步完成登录

**Q: 忘记了 URL 怎么办？**
A: 访问 https://vercel.com/dashboard 查看你的项目

**Q: 需要付费吗？**
A: Vercel 免费套餐完全够用

**Q: 部署失败怎么办？**
A: 检查网络连接，重新运行 `deploy-2.bat`

---

## 📞 需要帮助？

1. 先运行 `check-status.bat` 查看当前状态
2. 根据状态提示执行对应操作
3. 如果还有问题，联系我！

---

**推荐流程**：
```
check-status.bat → login-helper.bat → deploy-2.bat → 完成！
```

🚀
