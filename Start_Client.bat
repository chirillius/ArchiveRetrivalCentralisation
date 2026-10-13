@echo off
setlocal
title Centralisation Client 1.1.0.0
set "CLIENT_PORT=5176"
pushd "%~dp0"
if errorlevel 1 exit /b 1
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
