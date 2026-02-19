@echo off
chcp 936 >nul
echo.
echo ==========================================
echo   Pokemon NFT Gallery - 一键部署向导
echo ==========================================
echo.

:menu
echo.
echo 请选择要执行的操作：
echo.
echo 1️⃣  检查部署状态
echo 2️⃣  登录 Vercel
echo 3️⃣  部署到 Vercel
echo 4️⃣  完整流程（检查→登录→部署）
echo 0️⃣  退出
echo.
set /p choice="请选择 (0-4): "

if "%choice%"=="1" goto check
if "%choice%"=="2" goto login
if "%choice%"=="3" goto deploy
if "%choice%"=="4" goto full
if "%choice%"=="0" goto exit

echo.
echo 无效选择，请重新输入
goto menu

:check
echo.
echo ==========================================
echo   正在检查部署状态...
echo ==========================================
echo.
call check-status-v2.bat
goto menu

:login
echo.
echo ==========================================
echo   正在登录 Vercel...
echo ==========================================
echo.
call login-helper-v2.bat
goto menu

:deploy
echo.
echo ==========================================
echo   正在部署到 Vercel...
echo ==========================================
echo.
call deploy-2-v2.bat
goto menu

:full
echo.
echo ==========================================
echo   完整部署流程
echo ==========================================
echo.
echo 步骤 1/3：检查状态
echo.
call check-status-v2.bat

echo.
echo.
echo ==========================================
echo   步骤 2/3：登录 Vercel
echo ==========================================
echo.
call login-helper-v2.bat

echo.
echo.
echo ==========================================
echo   步骤 3/3：部署到 Vercel
echo ==========================================
echo.
call deploy-2-v2.bat

echo.
echo ==========================================
echo   全部完成！
echo ==========================================
echo.
pause
goto menu

:exit
echo.
echo 再见！
echo.
exit /b 0
