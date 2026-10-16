@echo off
setlocal
title Centralisation Client 1.1.0.5
set "CLIENT_PORT=5176"
pushd "%~dp0"
if errorlevel 1 exit /b 1
if exist "client-updater.local.json" (
  powershell.exe -NoLogo -NoProfile -NonInteractive -Command "$ErrorActionPreference='Stop'; $p=Join-Path (Get-Location) 'client-updater.local.json'; $c=Get-Content -LiteralPath $p -Raw | ConvertFrom-Json; & $c.toolPath recover-client $p; exit $LASTEXITCODE"
  if errorlevel 1 (
    echo Client recovery failed. Contact the administrator.
    pause
    popd
    exit /b 1
  )
)
if not exist "CentralisationClient.exe" (
  echo CentralisationClient.exe is missing. Extract the entire release folder.
  pause
  popd
  exit /b 1
)
"%~dp0CentralisationClient.exe" --port %CLIENT_PORT%
set "CLIENT_EXIT=%ERRORLEVEL%"
if not "%CLIENT_EXIT%"=="0" (
  echo.
  echo Client startup failed. See the error above.
  pause
)
popd
exit /b %CLIENT_EXIT%
