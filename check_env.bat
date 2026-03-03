@echo off
echo ========================================================
echo       Environment Check for Renovation Platform
echo ========================================================

echo.
echo Checking for Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [FAIL] Git is NOT installed or not in your PATH.
    echo        Please download and install Git from: https://git-scm.com/downloads
) else (
    echo [PASS] Git is installed.
    git --version
)

echo.
echo Checking for Node.js...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [FAIL] Node.js is NOT installed or not in your PATH.
    echo        Please download and install Node.js (LTS) from: https://nodejs.org/
) else (
    echo [PASS] Node.js is installed.
    node -v
)

echo.
echo ========================================================
echo Summary:
echo If you see any [FAIL] messages above, please install the missing software
echo and RESTART your terminal or IDE for the changes to take effect.
echo ========================================================
pause
