@echo off
REM 第一步：登录 Vercel
echo.
echo ==========================================
echo   第1步：登录 Vercel
echo ==========================================
echo.

echo 正在打开 Vercel 登录页面...
echo.
echo 请按提示操作：
echo 1. 浏览器会自动打开
echo 2. 登录或注册 Vercel 账户（免费）
echo 3. 验证邮箱（如果需要）
echo 4. 登录成功后，按任意键继续
echo.

call vercel login

if %errorlevel% neq 0 (
    echo [错误] 登录失败，请重试
    pause
    exit /b 1
)

echo.
echo ✓ 登录成功！
echo.
echo 请按任意键继续部署...
pause

REM 继续运行部署脚本
call deploy-2.bat
