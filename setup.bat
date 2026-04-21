@echo off
setlocal enabledelayedexpansion

echo ========================================
echo   Hexo Blog Environment Setup
echo ========================================
echo.
echo This will configure the NODE_PATH used by all bat files.
echo.

REM Check if node is already in PATH
where node >nul 2>&1
if not errorlevel 1 (
    for /f "tokens=*" %%i in ('where node') do (
        set FOUND_NODE=%%i
        goto :found
    )
)
goto :manual

:found
for %%i in ("!FOUND_NODE!") do set FOUND_DIR=%%~dpi
set FOUND_DIR=!FOUND_DIR:~0,-1!
echo Found node.exe at: !FOUND_NODE!
echo Directory: !FOUND_DIR!
echo.
set /p USE_FOUND=Use this path? (Y/N, default Y):
if /i "!USE_FOUND!"=="" set USE_FOUND=Y
if /i "!USE_FOUND!"=="Y" (
    set NODE_PATH=!FOUND_DIR!
    goto :save
)

:manual
echo.
echo Enter the full path to your Node.js directory.
echo Example: C:\Program Files\nodejs
echo Example: C:\Users\username\.workbuddy\binaries\node\versions\20.18.0
echo.
set /p NODE_PATH=Node.js path:
if "!NODE_PATH!"=="" (
    echo Error: NODE_PATH cannot be empty.
    pause
    exit /b 1
)

:save
echo.
echo Saving to config.bat...
(
    echo @echo off
    echo set NODE_PATH=!NODE_PATH!
    echo set PATH=%%NODE_PATH%%;%%PATH%%
) > "%~dp0config.bat"

echo Adding to user environment variable...
setx PATH "%PATH%;!NODE_PATH!" >nul 2>&1

echo.
echo ========================================
echo   Setup complete!
echo   NODE_PATH = !NODE_PATH!
echo ========================================
echo.
pause
