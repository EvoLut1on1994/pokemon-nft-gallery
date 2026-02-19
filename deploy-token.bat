@echo off
echo ========================================
echo   Netlify Token Deployment Script
echo ========================================
echo.

REM Check if NETLIFY_AUTH_TOKEN is set
if "%NETLIFY_AUTH_TOKEN%"=="" (
    echo ERROR: NETLIFY_AUTH_TOKEN environment variable not set!
    echo.
    echo Please set it first:
    echo   set NETLIFY_AUTH_TOKEN=your_token_here
    echo.
    pause
    exit /b 1
)

echo Using Netlify token for authentication...
echo.

REM Deploy to Netlify
echo [1/3] Initializing Netlify project...
netlify init --manual --name pokemon-nft-gallery --token=%NETLIFY_AUTH_TOKEN% --prod-dir=.next --functions-dir=.next

if errorlevel 1 (
    echo.
    echo ERROR: Netlify init failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Deploying to production...
netlify deploy --prod --token=%NETLIFY_AUTH_TOKEN%

if errorlevel 1 (
    echo.
    echo ERROR: Deployment failed!
    pause
    exit /b 1
)

echo.
echo [3/3] Verifying deployment...
netlify status --token=%NETLIFY_AUTH_TOKEN%

echo.
echo ========================================
echo   Deployment Successful!
echo ========================================
echo.
echo Check your Netlify dashboard for the site URL.
echo.
pause
