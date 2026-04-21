@echo off
echo Stopping Hexo blog server...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":4001 " ^| findstr "LISTENING"') do (
    tasklist /FI "PID eq %%a" /FO CSV 2>nul | findstr /i "node.exe" >nul
    if not errorlevel 1 (
        taskkill /PID %%a /T /F >nul 2>&1
    )
)
echo Done.
pause
