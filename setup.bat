@echo off
echo Checking for Node.js...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is not installed or not in your PATH.
    echo Please install Node.js from https://nodejs.org/ and restart your terminal.
    pause
    exit /b 1
)

echo Installing Backend Dependencies...
cd backend
call npm install
if %errorlevel% neq 0 (
    echo Error installing backend dependencies.
    pause
    exit /b 1
)

echo Installing Frontend Dependencies...
cd ../frontend
call npm install
if %errorlevel% neq 0 (
    echo Error installing frontend dependencies.
    pause
    exit /b 1
)

echo.
echo Setup Complete!
echo.
echo To start the servers:
echo 1. Open a terminal in 'backend' and run: npm run dev
echo 2. Open a terminal in 'frontend' and run: npm run dev
echo.
pause
