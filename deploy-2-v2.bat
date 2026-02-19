@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   Pokemon NFT Gallery - 部署到 Vercel V2
echo ==========================================
echo.

REM 检查登录状态
echo [步骤 1/6] 检查登录状态...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 还未登录 Vercel
    echo.
    echo 解决方法：
    echo 1. 双击运行 login-helper-v2.bat 完成登录
    echo 2. 登录成功后，重新运行此脚本
    echo.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('vercel whoami') do set "VERCEL_USER=%%i"
echo ✓ 已登录 Vercel (!VERCEL_USER!)
echo.

REM 检查当前目录
echo [步骤 2/6] 检查项目目录...
if exist "package.json" (
    echo ✓ 在正确的项目目录
    echo.
) else (
    echo [错误] 未找到 package.json
    echo.
    echo 请确保在项目根目录运行此脚本：
    echo C:\Users\liudo\.openclaw\workspace\pokemon-nft-gallery
    echo.
    pause
    exit /b 1
)

REM 安装依赖
echo [步骤 3/6] 安装项目依赖...
echo.
echo 这可能需要几分钟时间，请耐心等待...
echo.
call npm install
if %errorlevel% neq 0 (
    echo.
    echo ==========================================
    echo   [错误] 依赖安装失败
    echo ==========================================
    echo.
    echo 可能的原因：
    echo 1. 网络连接问题
    echo 2. npm 源访问失败
    echo 3. 权限问题
    echo.
    echo 解决方法：
    echo 1. 检查网络连接
    echo 2. 尝试清除缓存: npm cache clean --force
    echo 3. 尝试更换 npm 源: npm config set registry https://registry.npmmirror.com
    echo.
    pause
    exit /b 1
)
echo.
echo ✓ 依赖安装完成
echo.

REM 构建项目
echo [步骤 4/6] 构建项目...
echo.
echo 这可能需要几分钟时间，请耐心等待...
echo.
call npm run build
if %errorlevel% neq 0 (
    echo.
    echo ==========================================
    echo   [错误] 项目构建失败
    echo ==========================================
    echo.
    echo 可能的原因：
    echo 1. 代码错误
    echo 2. TypeScript 类型错误
    echo 3. 配置文件问题
    echo.
    echo 解决方法：
    echo 1. 检查上面的错误信息
    echo 2. 运行 npm run dev 本地测试
    echo 3. 检查 package.json 中的构建命令
    echo.
    pause
    exit /b 1
)
echo.
echo ✓ 项目构建完成
echo.

REM 部署到Vercel
echo [步骤 5/6] 部署到 Vercel...
echo.
echo ==========================================
echo   部署配置
echo ==========================================
echo.
echo 请按提示操作：
echo.
echo 1. 选择团队（Team）
echo    - 如果有多个团队，使用方向键选择
echo    - 按空格键选中
echo    - 按 Enter 确认
echo    - 通常选择个人账户（个人）
echo.
echo 2. 输入项目名称
echo    - 按Enter使用默认名称
echo    - 或输入自定义名称
echo.
echo 3. 确认部署配置
echo    - 检查显示的配置信息
echo    - 按 Enter 确认
echo.
echo ==========================================
echo.
echo 正在开始部署...
echo.
call vercel --prod

if %errorlevel% neq 0 (
    echo.
    echo ==========================================
    echo   [错误] Vercel 部署失败
    echo ==========================================
    echo.
    echo 可能的原因：
    echo 1. Vercel CLI 版本问题
    echo 2. 网络连接问题
    echo 3. 账户配额问题（免费版有限制）
    echo.
    echo 解决方法：
    echo 1. 检查 Vercel 账户状态
    echo 2. 检查网络连接
    echo 3. 尝试手动运行: vercel --prod
    echo.
    pause
    exit /b 1
)

REM 获取部署URL
echo.
echo [步骤 6/6] 获取部署信息...
echo.
echo ==========================================
echo   部署完成！🎉
echo ==========================================
echo.
echo 请查看上面的输出，找到你的部署 URL
echo 格式通常是：
echo.
echo   https://pokemon-nft-gallery-xxx.vercel.app
echo.
echo ==========================================
echo.
echo 后续操作：
echo.
echo 1. 访问你的网站并测试功能
echo 2. 如需配置 API 密钥：
echo    - 访问 https://vercel.com/dashboard
echo    - 选择你的项目
echo    - 进入 Settings → Environment Variables
echo    - 添加必要的环境变量
echo.
echo 3. 下次更新代码时，只需执行：
echo    git add .
echo    git commit -m "更新描述"
echo    git push
echo    或者直接运行: vercel --prod
echo.
echo ==========================================
echo   提示
echo ==========================================
echo.
echo - 首次访问可能需要等待几秒启动
echo - 免费版有睡眠机制，长时间无访问会休眠
echo - 可以在 Vercel 控制台查看部署日志
echo - 建议收藏你的部署 URL
echo.
pause
