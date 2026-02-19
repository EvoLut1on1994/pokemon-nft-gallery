@echo off
cls
echo ==========================================
echo   Pokemon NFT Gallery - 部署脚本
echo ==========================================
echo.
echo 当前目录: %CD%
echo.
echo 正在执行完整部署流程...
echo.
pause

echo.
echo [1/3] 检查部署状态...
echo.
call check-status-v2.bat
if errorlevel 1 (
    echo.
    echo !!! 检查状态失败 !!!
    echo.
    pause
    goto error
)

echo.
echo [2/3] 登录 Vercel...
echo.
echo 请按照提示操作，复制登录链接到浏览器
echo.
call login-helper-v2.bat
if errorlevel 1 (
    echo.
    echo !!! 登录失败 !!!
    echo.
    pause
    goto error
)

echo.
echo [3/3] 部署到 Vercel...
echo.
call deploy-2-v2.bat
if errorlevel 1 (
    echo.
    echo !!! 部署失败 !!!
    echo.
    pause
    goto error
)

echo.
echo ==========================================
echo   部署完成！
echo ==========================================
echo.
echo 请保存您的 Vercel 项目 URL
echo.
pause
exit /b 0

:error
echo.
echo ==========================================
echo   部署过程中出现错误
echo ==========================================
echo.
echo 请检查错误信息并重试
echo.
pause
exit /b 1
