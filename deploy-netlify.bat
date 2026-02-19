@echo off
setlocal enabledelayedexpansion

echo ========================================
echo   Pokemon NFT Gallery - Netlify Deploy
echo ========================================
echo.

if "%1"=="" (
    echo Usage: deploy-netlify.bat ^<NETLIFY_TOKEN^>
    echo.
    echo To get your Netlify token:
    echo 1. Go to https://app.netlify.com/user/applications
    echo 2. Create a new personal access token
    echo 3. Run: deploy-netlify.bat your_token_here
    echo.
    pause
    exit /b 1
)

set NETLIFY_TOKEN=%1

echo Using Netlify token: %NETLIFY_TOKEN:~0,10%...
echo.

REM Set Netlify auth token
set NETLIFY_AUTH_TOKEN=%NETLIFY_TOKEN%

REM Deploy to Netlify
echo [Step 1] Initializing Netlify site...
netlify sites:create --name pokemon-nft-gallery --token=%NETLIFY_AUTH_TOKEN%

if errorlevel 1 (
    echo Warning: Site init may have issues, continuing...
)

echo.
echo [Step 2] Deploying to production...
netlify deploy --prod --token=%NETLIFY_AUTH_TOKEN%

if errorlevel 1 (
    echo.
    echo ERROR: Deployment failed!
    echo Please check:
    echo 1. Your token is valid
    echo 2. You have network connection
    echo 3. The build is successful (run: npm run build)
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Deployment Complete!
echo ========================================
echo.
echo Your site should be available at:
echo   https://pokemon-nft-gallery.netlify.app
echo.
echo Check Netlify dashboard for exact URL and logs.
echo.
pause
