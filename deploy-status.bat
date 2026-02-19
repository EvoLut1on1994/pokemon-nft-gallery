@echo off
echo ==========================================
echo   部署状态检查
echo ==========================================
echo.

echo [1] 检查 Vercel 登录状态...
vercel whoami
if %errorlevel% neq 0 (
    echo.
    echo [!] 还未登录 Vercel
    echo.
    echo 请执行以下步骤：
    echo 1. 打开命令提示符（CMD）
    echo 2. 输入：cd C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery
    echo 3. 输入：vercel login
    echo 4. 按提示登录 Vercel 账户
    echo.
    echo 登录完成后，再次运行此脚本检查状态
    pause
    exit /b 1
)

echo.
echo [2] 登录成功！准备部署...
echo.
echo 请执行以下步骤完成部署：
echo 1. 在命令提示符中输入：
echo    cd C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery
echo 2. 输入：vercel --prod
echo 3. 按提示操作：
echo    - 选择团队（或按 Enter 选择个人）
echo    - 输入项目名称（或按 Enter 使用默认）
echo    - 确认部署配置
echo 4. 等待部署完成
echo.
echo 部署完成后，你会获得一个 URL
echo.

pause
