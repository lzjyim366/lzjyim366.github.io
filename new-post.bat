@echo off
call "%~dp0config.bat"

set /p TITLE=Article title:
if "%TITLE%"=="" (
    echo Title cannot be empty.
    pause
    exit /b
)

cd /d "%~dp0my-blog"
"%NODE_PATH%\hexo.cmd" new "%TITLE%"

set POST_PATH=%~dp0my-blog\source\_posts\%TITLE%.md
start "" "obsidian://open?path=%POST_PATH%"

echo Done! Opening %TITLE%.md in Obsidian...
timeout /t 2 >nul
