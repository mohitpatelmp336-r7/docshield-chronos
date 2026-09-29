@echo off
setlocal
title DocShield Chronos - Full Stack
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js is required. Install Node.js LTS, then run this file again.
  pause
  exit /b 1
)

if not exist "node_modules\.bin\vite.cmd" (
  echo Installing project dependencies. This may take a few minutes the first time...
  call npm install
  if errorlevel 1 (
    echo.
    echo Dependency installation failed. Check your internet connection and try again.
    pause
    exit /b 1
  )
)

echo.
echo Starting DocShield Chronos...
start "" cmd /c "npm run start"
timeout /t 4 /nobreak >nul
start "" "http://127.0.0.1:8080/"
echo.
echo The app is running at http://127.0.0.1:8080/
echo Close the terminal running Vite when you are finished.
pause
