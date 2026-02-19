@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   部署状态检查
echo ==========================================
echo.

echo [检查 1/4] Node.js 是否安装...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Node.js 未安装
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)
echo ✓ Node.js 已安装
echo.

echo [检查 2/4] Vercel CLI 是否安装...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Vercel CLI 未安装
    echo 正在安装...
    npm install -g vercel
    if %errorlevel% neq 0 (
        echo [错误] 安装失败
        pause
        exit /b 1
    )
)
echo ✓ Vercel CLI 已安装
echo.

echo [检查 3/4] Vercel 是否已登录...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] 还未登录 Vercel
    echo.
    echo 请执行以下操作：
    echo 1. 双击运行 login-helper.bat 完成登录
    echo 2. 登录成功后，重新运行此脚本检查状态
    echo.
    pause
    exit /b 1
)
echo ✓ 已登录 Vercel
echo.

echo [检查 4/4] 检查项目是否已部署...
if exist ".vercel" (
    echo ✓ 项目已部署过
    echo.
    echo 检查部署历史...
    vercel ls
) else (
    echo [!] 项目还未部署
    echo.
    echo 请执行以下操作：
    echo 1. 双击运行 deploy-2.bat 完成部署
    echo 2. 部署完成后会显示你的 URL
    echo.
)

echo.
echo ==========================================
echo   检查完成
echo ==========================================
echo.
pause
