@echo off
REM 第二步：部署到 Vercel
echo.
echo ==========================================
echo   第2步：部署到 Vercel
echo ==========================================
echo.

echo [1/4] 检查登录状态...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 还未登录 Vercel，请先运行 deploy-1.bat
    pause
    exit /b 1
)
echo ✓ 已登录 Vercel
echo.

echo [2/4] 安装项目依赖...
call npm install
if %errorlevel% neq 0 (
    echo [错误] 依赖安装失败
    pause
    exit /b 1
)
echo ✓ 依赖安装完成
echo.

echo [3/4] 构建项目...
call npm run build
if %errorlevel% neq 0 (
    echo [错误] 项目构建失败
    pause
    exit /b 1
)
echo ✓ 项目构建完成
echo.

echo [4/4] 部署到 Vercel...
echo.
echo 请按提示操作：
echo - 选择团队（按 Enter 选择个人账户）
echo - 输入项目名称（按 Enter 使用默认名）
echo - 确认部署配置（按 Enter 确认）
echo.
call vercel --prod

if %errorlevel% neq 0 (
    echo [错误] Vercel 部署失败
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   部署完成！🎉
echo ==========================================
echo.
echo 你的项目已部署到 Vercel！
echo.
echo 请查看上面的输出，找到你的部署 URL
echo 格式通常是：
echo https://pokemon-nft-gallery-xxx.vercel.app
echo.
echo 如果需要配置 API 密钥，访问：
echo https://vercel.com/dashboard → 你的项目 → Settings → Environment Variables
echo.
echo 下次更新只需执行：
echo   vercel --prod
echo.
pause
