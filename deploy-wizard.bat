@echo off
setlocal enabledelayedexpansion
chcp 936 >nul
cls

:main
echo ==========================================
echo   Pokemon NFT Gallery - Deploy Wizard
echo ==========================================
echo.
echo Please select an option:
echo.
echo [1] Check deployment status
echo [2] Login to Vercel
echo [3] Deploy to Vercel
echo [4] Full process (Check - Login - Deploy)
echo [0] Exit
echo.

set /p "choice=Enter your choice (0-4): "

if not defined choice (
    echo Error: No input received
    goto main
)

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto login_vercel
if "%choice%"=="3" goto deploy_project
if "%choice%"=="4" goto full_process
if "%choice%"=="0" goto exit_script

echo.
echo Invalid choice: %choice%
echo Please try again
echo.
pause
goto main

:check_status
cls
echo ==========================================
echo   Step 1: Checking Deployment Status
echo ==========================================
echo.
call check-status-v2.bat
echo.
pause
goto main

:login_vercel
cls
echo ==========================================
echo   Step 2: Logging into Vercel
echo ==========================================
echo.
call login-helper-v2.bat
echo.
pause
goto main

:deploy_project
cls
echo ==========================================
echo   Step 3: Deploying to Vercel
echo ==========================================
echo.
call deploy-2-v2.bat
echo.
pause
goto main

:full_process
cls
echo ==========================================
echo   Full Deployment Process
echo ==========================================
echo.

echo [Step 1/3] Checking status...
echo.
call check-status-v2.bat

if errorlevel 1 (
    echo.
    echo Error occurred during status check!
    echo Press any key to return to menu...
    pause >nul
    goto main
)

echo.
echo ==========================================
echo   [Step 2/3] Logging into Vercel...
echo ==========================================
echo.
call login-helper-v2.bat

if errorlevel 1 (
    echo.
    echo Error occurred during login!
    echo Press any key to return to menu...
    pause >nul
    goto main
)

echo.
echo ==========================================
echo   [Step 3/3] Deploying to Vercel...
echo ==========================================
echo.
call deploy-2-v2.bat

if errorlevel 1 (
    echo.
    echo Error occurred during deployment!
) else (
    echo.
    echo ==========================================
    echo   Deployment Complete!
    echo ==========================================
)
echo.
pause
goto main

:exit_script
cls
echo.
echo Thank you for using Pokemon NFT Gallery Deploy Wizard!
echo.
timeout /t 2 >nul
exit /b 0
