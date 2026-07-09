@echo off
REM ============================================================
REM Gongyuan Film Filter PORTABLE launcher
REM No Python needed. Double-click to run.
REM FIRST 250 BYTES 100% ASCII - do NOT add Chinese/emoji here.
REM ============================================================
setlocal
cd /d "%~dp0"
echo.
echo ============================================================
echo   Gongyuan Film Filter PORTABLE
echo ============================================================
echo.
echo [1/3] Starting backend gy_backend\main.exe ...
start /b "" "%~dp0gy_backend\main.exe"
echo.
echo [2/3] Waiting 5 seconds for backend startup ...
timeout /t 5 /nobreak >nul
echo.
echo [3/3] Opening browser at http://localhost:8000/ ...
start "" http://localhost:8000/
echo.
echo ============================================================
echo   This PC .......: http://localhost:8000/
echo   Same-WiFi phone: read the IP printed below
echo ============================================================
echo.
REM --- LAN IP via ipconfig+findstr (no PowerShell needed)
set "FOUND_IP="
for /f "tokens=2 delims=:" %%%%i in ('ipconfig ^| findstr /R /C:"IPv4" 2^>nul') do @for /f "tokens=1" %%%%j in ("%%%%i") do (
  if not defined FOUND_IP (
    echo "%%%%j" | findstr /B /C:"127." >nul
    if errorlevel 1 (
      echo "%%%%j" | findstr /B /C:"169.254." >nul
      if errorlevel 1 (
        set "FOUND_IP=%%%%j"
      )
    )
  )
)
if defined FOUND_IP (
  echo   Phone browser (same WiFi): http://%%FOUND_IP%%:8000/
  echo.
) else (
  echo   (No LAN IPv4 found - phone mode not available)
  echo.
)
echo   Backend log scrolls in the console - minimise it if desired.
echo   Press ANY key to close THIS window (backend keeps running).
pause >nul
exit /b 0
