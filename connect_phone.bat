@echo off
chcp 65001 >nul
echo ========================================================
echo   KẾT NỐI ĐIỆN THOẠI VỚI SERVER THINGSBOARD QUA USB
echo ========================================================

set ADB="C:\Users\letie\AppData\Local\Android\Sdk\platform-tools\adb.exe"

if not exist %ADB% (
    echo [LỖI] Không tìm thấy adb.exe tại đường dẫn Android SDK!
    pause
    exit /b
)

echo Đang kiểm tra thiết bị cắm cáp USB...
%ADB% devices

echo.
echo Đang mở chuyển tiếp cổng (adb reverse)...
%ADB% reverse tcp:9090 tcp:9090
%ADB% reverse tcp:1884 tcp:1884

echo.
echo Danh sách cổng đang chuyển tiếp:
%ADB% reverse --list

echo.
echo ========================================================
echo [THÀNH CÔNG] Điện thoại đã được kết nối với ThingsBoard!
echo Bây giờ bạn có thể thao tác Đăng nhập / Đăng ký trên App.
echo ========================================================
pause
