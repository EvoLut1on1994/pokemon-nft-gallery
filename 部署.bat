@echo off
chcp 936 >nul
cls
echo ==========================================
echo   Pokemon NFT Gallery - 部署脚本
echo ==========================================
echo.
echo 正在执行完整部署流程...
echo.

echo [1/3] 检查部署状态...
call check-status-v2.bat
if errorlevel 1 goto error

echo.
echo [2/3] 登录 Vercel...
echo 请按照提示操作，复制登录链接到浏览器
call login-helper-v2.bat
if errorlevel 1 goto error

echo.
echo [3/3] 部署到 Vercel...
call deploy-2-v2.bat
if errorlevel 1 goto error

echo.
echo ==========================================
echo   部署完成！
echo ==========================================
echo.
timeout /t 5 >nul
exit /b 0

:error
echo.
echo ==========================================
echo   部署过程中出现错误
echo ==========================================
echo.
timeout /t 5 >nul
exit /b 1
