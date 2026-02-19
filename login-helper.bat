@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   Vercel 登录助手
echo ==========================================
echo.

echo [步骤 1/3] 检查 Vercel CLI...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Vercel CLI 未安装
    echo 请先运行: npm install -g vercel
    pause
    exit /b 1
)
echo ✓ Vercel CLI 已安装
echo.

echo [步骤 2/3] 检查登录状态...
vercel whoami >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ 已登录 Vercel！
    echo.
    echo 你现在可以关闭此窗口，然后运行 deploy-2.bat 进行部署
    pause
    exit /b 0
)

echo [!] 还未登录 Vercel
echo.
echo [步骤 3/3] 开始登录...
echo.
echo ==========================================
echo   请按提示操作：
echo ==========================================
echo.
echo 1. 下方会显示登录链接
echo 2. 按 Enter 键在浏览器中打开
echo 3. 登录或注册你的 Vercel 账户（免费）
echo 4. 验证邮箱（如果需要）
echo 5. 验证完成后按任意键返回
echo.
echo ==========================================
echo.
pause

echo.
echo 正在启动 Vercel 登录...
echo.

vercel login

if %errorlevel% neq 0 (
    echo.
    echo [错误] 登录失败
    echo.
    echo 可能的原因：
    echo 1. 没有在浏览器中完成登录
    echo 2. 网络连接问题
    echo 3. 邮箱验证未完成
    echo.
    echo 请重试
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   登录成功！✅
echo ==========================================
echo.
echo 下一步：运行 deploy-2.bat 完成部署
echo.
pause
