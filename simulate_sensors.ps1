param(
    [string]$DeviceToken = "A1_TEST_TOKEN",
    [string]$ServerUrl = "http://localhost:9090",
    [int]$IntervalSec = 3
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "      SIMULATOR CẢM BIẾN NÔNG NGHIỆP -> THINGSBOARD       " -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Server URL   : $ServerUrl"
Write-Host "Device Token : $DeviceToken"
Write-Host "Chu kỳ gửi   : $IntervalSec giây/lần"
Write-Host "Nhấn Ctrl+C để dừng mô phỏng.`n" -ForegroundColor DarkGray

$endpoint = "$ServerUrl/api/v1/$DeviceToken/telemetry"

$rnd = New-Object System.Random

while ($true) {
    # Tạo giá trị cảm biến biến thiên ngẫu nhiên theo thực tế
    $temp  = [Math]::Round(28.0 + $rnd.NextDouble() * 5.0, 1)    # 28.0 - 33.0 °C
    $humi  = [Math]::Round(70.0 + $rnd.NextDouble() * 15.0, 1)   # 70.0 - 85.0 %
    $ph    = [Math]::Round(6.2 + $rnd.NextDouble() * 1.0, 1)     # 6.2 - 7.2 pH
    $n     = [Math]::Round(70.0 + $rnd.NextDouble() * 20.0, 1)   # 70 - 90 mg/kg
    $p     = [Math]::Round(35.0 + $rnd.NextDouble() * 15.0, 1)   # 35 - 50 mg/kg
    $k     = [Math]::Round(45.0 + $rnd.NextDouble() * 15.0, 1)   # 45 - 60 mg/kg
    $water = [Math]::Round(18.0 + $rnd.NextDouble() * 8.0, 1)    # 18 - 26 cm
    $ec    = [Math]::Round(1.1 + $rnd.NextDouble() * 0.5, 2)     # 1.1 - 1.6 mS/cm

    $payload = @{
        temp  = $temp
        humi  = $humi
        ph    = $ph
        n     = $n
        p     = $p
        k     = $k
        water = $water
        ec    = $ec
    } | ConvertTo-Json -Compress

    $timestamp = (Get-Date).ToString("HH:mm:ss")
    try {
        $res = Invoke-RestMethod -Uri $endpoint -Method Post -ContentType "application/json" -Body $payload -TimeoutSec 5
        Write-Host "[$timestamp] [OK] Đã gửi telemetry: Temp=${temp}°C, Humi=${humi}%, pH=$ph, N=$n, P=$p, K=$k, Water=${water}cm, EC=$ec" -ForegroundColor Green
    } catch {
        Write-Host "[$timestamp] [LỖI] Không gửi được: $($_.Exception.Message)" -ForegroundColor Red
    }

    Start-Sleep -Seconds $IntervalSec
}
