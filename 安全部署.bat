@echo off
cls
echo ==========================================
echo   Pokemon NFT Gallery - 安全部署
echo ==========================================
echo.
echo 此脚本将帮助您完成部署
echo.
pause

echo.
echo Step 1: 检查环境
echo.
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Node.js 未安装
    echo.
    echo 请先安装 Node.js: https://nodejs.org/
    pause
    exit /b 1
)
echo [OK] Node.js 已安装

where vercel >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Vercel CLI 未安装
    echo.
    echo 正在安装 Vercel CLI...
    npm install -g vercel
    if %errorlevel% neq 0 (
        echo [X] 安装失败
        pause
        exit /b 1
    )
)
echo [OK] Vercel CLI 已安装

echo.
echo Step 2: 检查登录状态
echo.
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] 未登录 Vercel
    echo.
    echo 正在打开登录页面...
    echo.
    echo 请复制下面的链接到浏览器：
    echo.
    vercel login
    if %errorlevel% neq 0 (
        echo [X] 登录失败
        pause
        exit /b 1
    )
    echo.
    echo [OK] 已登录
) else (
    echo [OK] 已登录
)

echo.
echo Step 3: 安装依赖
echo.
if not exist "node_modules" (
    echo 正在安装依赖...
    npm install
    if %errorlevel% neq 0 (
        echo [X] 依赖安装失败
        pause
        exit /b 1
    )
)
echo [OK] 依赖已安装

echo.
echo Step 4: 构建项目
echo.
npm run build
if %errorlevel% neq 0 (
    echo [X] 构建失败
    pause
    exit /b 1
)
echo [OK] 构建成功

echo.
echo Step 5: 部署到 Vercel
echo.
echo 正在部署...
vercel --prod
if %errorlevel% neq 0 (
    echo [X] 部署失败
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   部署完成！
echo ==========================================
echo.
echo 请保存上面的 URL
echo.
pause
