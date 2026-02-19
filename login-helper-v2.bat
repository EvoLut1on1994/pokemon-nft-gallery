@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   Vercel 登录助手 V2
echo ==========================================
echo.

REM 检查Vercel CLI
echo [步骤 1/5] 检查 Vercel CLI...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Vercel CLI 未安装
    echo 正在安装 Vercel CLI...
    call npm install -g vercel
    if %errorlevel% neq 0 (
        echo [错误] 安装失败
        echo.
        echo 可能的原因：
        echo 1. 网络连接问题
        echo 2. 权限不足（请以管理员身份运行）
        echo.
        pause
        exit /b 1
    )
)
echo ✓ Vercel CLI 已安装
echo.

REM 检查登录状态
echo [步骤 2/5] 检查登录状态...
vercel whoami >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ 已登录 Vercel！
    echo.
    for /f "tokens=*" %%i in ('vercel whoami') do set "VERCEL_USER=%%i"
    echo 当前用户: !VERCEL_USER!
    echo.
    echo 你现在可以关闭此窗口，然后运行 deploy-2.bat 进行部署
    echo.
    pause
    exit /b 0
)

echo [!] 还未登录 Vercel
echo.

REM 显示登录说明
echo [步骤 3/5] 登录说明
echo.
echo ==========================================
echo   请按以下步骤操作：
echo ==========================================
echo.
echo 1. 运行登录命令后，终端会显示一个登录链接
echo 2. 按照终端提示，复制该链接到浏览器打开
echo 3. 登录或注册你的 Vercel 账户（完全免费）
echo 4. 验证你的邮箱（如果是首次登录）
echo 5. 验证完成后，回到此窗口
echo 6. 按任意键确认登录完成
echo.
echo ==========================================
echo.
echo 如果自动打开浏览器失败，可以手动复制链接
echo.
pause

REM 执行登录
echo.
echo [步骤 4/5] 正在启动登录流程...
echo.
echo ==========================================
echo.
call vercel login

REM 检查登录结果
if %errorlevel% neq 0 (
    echo.
    echo ==========================================
    echo   [错误] 登录失败
    echo ==========================================
    echo.
    echo 可能的原因：
    echo 1. 没有在浏览器中完成登录
    echo 2. 网络连接问题
    echo 3. 邮箱验证未完成
    echo 4. 登录超时（链接有效时间有限）
    echo.
    echo 解决方法：
    echo 1. 检查网络连接
    echo 2. 确保邮箱已验证
    echo 3. 重新运行此脚本
    echo 4. 手动执行: vercel login
    echo.
    pause
    exit /b 1
)

REM 验证登录
echo.
echo [步骤 5/5] 验证登录状态...
vercel whoami >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('vercel whoami') do set "VERCEL_USER=%%i"

    echo.
    echo ==========================================
    echo   登录成功！✅
    echo ==========================================
    echo.
    echo 当前用户: !VERCEL_USER!
    echo.
    echo 下一步：运行 deploy-2.bat 完成部署
    echo.
    pause
    exit /b 0
) else (
    echo.
    echo [错误] 登录验证失败
    echo.
    echo 请重新运行此脚本
    echo.
    pause
    exit /b 1
)
