# ThingsBoard Community Edition (Docker)

Cấu hình ThingsBoard CE sử dụng Docker và Docker Compose trên Windows.

## 1. Khởi chạy ThingsBoard

- **Cách 1**: Chạy file `start.bat`
- **Cách 2**: Chạy lệnh trong terminal tại thư mục này:
  ```bash
  docker compose up -d
  ```

> *Lưu ý:* Quá trình khởi động lần đầu của ThingsBoard sẽ mất từ 1 - 3 phút để khởi tạo database và các service bên trong.
> Xem logs quá trình khởi động:
> ```bash
> docker compose logs -f
> ```

## 2. Truy cập Web UI

- URL: **http://localhost:9090**

### Tài khoản mặc định của ThingsBoard:
- **System Administrator (Quản trị hệ thống):**
  - Email: `sysadmin@thingsboard.org`
  - Password: `sysadmin`
- **Tenant Administrator (Quản trị viên Tenant):**
  - Email: `tenant@thingsboard.org`
  - Password: `tenant`
- **Customer User (Khách hàng mẫu):**
  - Email: `customer@thingsboard.org`
  - Password: `customer`

## 3. Cấu hình cổng kết nối (Port Mapping) trong file `.env`

- `TB_PORT=9090`: Cổng Web UI ThingsBoard
- `TB_MQTT_PORT=1884`: Cổng MQTT Broker của ThingsBoard. 
  *(Mặc định để `1884` do máy có thể đang chạy một broker khác như Mosquitto ở cổng `1883`. Nếu muốn dùng `1883`, bạn chỉ cần đổi giá trị này thành `1883` sau khi tắt Mosquitto).*
- `TB_COAP_PORT=5683`: Cổng giao thức CoAP

## 4. Dừng ThingsBoard

- **Cách 1**: Chạy file `stop.bat`
- **Cách 2**: Chạy lệnh:
  ```bash
  docker compose down
  ```
