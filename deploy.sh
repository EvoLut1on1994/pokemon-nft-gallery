#!/bin/bash

# Pokemon NFT Gallery - 一键部署到Vercel
# 使用方法：chmod +x deploy.sh && ./deploy.sh

set -e

echo ""
echo "=========================================="
echo "  Pokemon NFT Gallery - Vercel 一键部署"
echo "=========================================="
echo ""

# 检查Node.js是否安装
if ! command -v node &> /dev/null; then
    echo "[错误] 未检测到 Node.js，请先安装 Node.js"
    echo "下载地址: https://nodejs.org/"
    exit 1
fi

echo "[1/6] 检查 Vercel CLI..."
if ! command -v vercel &> /dev/null; then
    echo "Vercel CLI 未安装，正在安装..."
    npm install -g vercel
    if [ $? -ne 0 ]; then
        echo "[错误] Vercel CLI 安装失败"
        exit 1
    fi
else
    echo "✓ Vercel CLI 已安装"
fi
echo ""

# 检查是否已登录
echo "[2/6] 检查 Vercel 登录状态..."
if ! vercel whoami &> /dev/null; then
    echo "需要登录 Vercel 账户"
    echo ""
    echo "请按提示操作："
    echo "1. 输入邮箱登录或注册"
    echo "2. 验证邮箱（如果需要）"
    echo "3. 验证完成后按任意键继续"
    echo ""
    vercel login
    if [ $? -ne 0 ]; then
        echo "[错误] Vercel 登录失败"
        exit 1
    fi
else
    echo "✓ 已登录 Vercel"
fi
echo ""

# 安装依赖
echo "[3/6] 安装项目依赖..."
npm install
if [ $? -ne 0 ]; then
    echo "[错误] 依赖安装失败"
    exit 1
fi
echo "✓ 依赖安装完成"
echo ""

# 构建项目
echo "[4/6] 构建项目..."
npm run build
if [ $? -ne 0 ]; then
    echo "[错误] 项目构建失败"
    exit 1
fi
echo "✓ 项目构建完成"
echo ""

# 部署到Vercel
echo "[5/6] 部署到 Vercel..."
echo ""
echo "请按提示操作："
echo "1. 选择要部署的团队（个人账户或团队）"
echo "2. 输入项目名称（或使用默认）"
echo "3. 确认部署配置"
echo ""
vercel --prod
if [ $? -ne 0 ]; then
    echo "[错误] Vercel 部署失败"
    exit 1
fi
echo ""
echo "✓ 部署成功！"
echo ""

# 设置环境变量（如果需要）
echo "[6/6] 配置环境变量..."
echo ""
echo "如果需要配置 API 密钥，请访问："
echo "https://vercel.com/dashboard → 你的项目 → Settings → Environment Variables"
echo ""
echo "需要配置的环境变量："
echo "- COLLECTORCRYPT_API_KEY"
echo "- TCGPLAYER_API_KEY"
echo "- POKEMON_TCG_API_KEY"
echo "- REDIS_URL (可选)"
echo ""

echo "=========================================="
echo "  部署完成！🎉"
echo "=========================================="
echo ""
echo "你的项目现在已部署到 Vercel"
echo ""
echo "下次更新时只需执行："
echo "  vercel --prod"
echo ""
