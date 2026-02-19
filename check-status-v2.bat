@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   部署状态检查 V2
echo ==========================================
echo.

REM 检查Node.js
echo [检查 1/4] Node.js 是否安装...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Node.js 未安装
    echo.
    echo 解决方法：
    echo 1. 访问 https://nodejs.org/
    echo 2. 下载并安装 LTS 版本
    echo 3. 安装完成后重新运行此脚本
    echo.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set "NODE_VERSION=%%i"
echo ✓ Node.js 已安装 (!NODE_VERSION!)
echo.

REM 检查Vercel CLI
echo [检查 2/4] Vercel CLI 是否安装...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Vercel CLI 未安装
    echo.
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
for /f "tokens=*" %%i in ('vercel --version') do set "VERCEL_VERSION=%%i"
echo ✓ Vercel CLI 已安装 (!VERCEL_VERSION!)
echo.

REM 检查Vercel登录状态
echo [检查 3/4] Vercel 是否已登录...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] 还未登录 Vercel
    echo.
    echo 解决方法：
    echo 1. 双击运行 login-helper-v2.bat 完成登录
    echo 2. 登录成功后，重新运行此脚本检查状态
    echo.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('vercel whoami') do set "VERCEL_USER=%%i"
echo ✓ 已登录 Vercel (!VERCEL_USER!)
echo.

REM 检查部署状态
echo [检查 4/4] 检查项目是否已部署...
if exist ".vercel" (
    echo ✓ 项目已部署过
    echo.
    echo 正在获取部署历史...
    echo.
    vercel ls --token %VERCEL_TOKEN% 2>nul || vercel ls
    echo.
) else (
    echo [!] 项目还未部署
    echo.
    echo 解决方法：
    echo 1. 确保已登录 Vercel（已确认 ✓）
    echo 2. 双击运行 deploy-2.bat 完成部署
    echo 3. 部署完成后会显示你的 URL
    echo.
)

REM 显示当前目录
echo ==========================================
echo   当前项目目录
echo ==========================================
echo.
echo %cd%
echo.

REM 检查依赖
echo ==========================================
echo   依赖检查
echo ==========================================
echo.
if exist "node_modules" (
    echo ✓ 依赖已安装
) else (
    echo [!] 依赖未安装
    echo.
    echo 如需本地开发，请运行：
    echo npm install
    echo npm run dev
    echo.
)

REM 检查环境变量
if exist ".env.local" (
    echo ✓ 环境变量文件存在
) else (
    echo [!] 环境变量文件不存在
    echo.
    echo 可以复制 .env.local.example 创建配置文件
    echo.
)

echo ==========================================
echo   检查完成
echo ==========================================
echo.
pause
