@echo off
call "%~dp0config.bat"
setlocal enabledelayedexpansion

set POSTS_DIR=%~dp0my-blog\source\_posts
set IMAGES_DIR=%~dp0my-blog\source\images

set /p OLD_NAME=Current filename (without .md):
if "%OLD_NAME%"=="" (
    echo Name cannot be empty.
    pause
    exit /b
)

if not exist "%POSTS_DIR%\%OLD_NAME%.md" (
    echo File not found: %POSTS_DIR%\%OLD_NAME%.md
    pause
    exit /b
)

set /p NEW_NAME=New filename (without .md):
if "%NEW_NAME%"=="" (
    echo Name cannot be empty.
    pause
    exit /b
)

if exist "%POSTS_DIR%\%NEW_NAME%.md" (
    echo File already exists: %POSTS_DIR%\%NEW_NAME%.md
    pause
    exit /b
)

:: Rename the .md file
rename "%POSTS_DIR%\%OLD_NAME%.md" "%NEW_NAME%.md"
echo Renamed: %OLD_NAME%.md -^> %NEW_NAME%.md

:: Fix title and image paths via helper script
powershell -ExecutionPolicy Bypass -File "%~dp0rename-post-helper.ps1" -PostsDir "%POSTS_DIR%" -OldName "%OLD_NAME%" -NewName "%NEW_NAME%"

:: Rename images folder if it exists
if exist "%IMAGES_DIR%\%OLD_NAME%" (
    rename "%IMAGES_DIR%\%OLD_NAME%" "%NEW_NAME%"
    echo Renamed images folder: %OLD_NAME% -^> %NEW_NAME%
)

echo Done!
timeout /t 2 >nul
