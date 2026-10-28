@echo off
chcp 65001 >nul
echo ========================================================
echo   Khởi chạy giả lập dữ liệu cảm biến lên ThingsBoard
echo ========================================================
powershell -ExecutionPolicy Bypass -File "%~dp0simulate_sensors.ps1" -DeviceToken A1_TEST_TOKEN -ServerUrl http://localhost:9090
pause
