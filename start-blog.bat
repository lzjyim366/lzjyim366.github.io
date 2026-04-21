@echo off
call "%~dp0config.bat"

echo Starting Hexo blog server...
cd /d "%~dp0my-blog"
start "" http://localhost:4001
start "Hexo Server" cmd /k "set PATH=%NODE_PATH%;%PATH% && hexo server -p 4001"
