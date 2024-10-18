Create database QL_CuaHangBanLapTop
Use QL_CuaHangBanLapTop
Go 

---------------------------------------------------------------------
-- Tạo bảng Sản phẩm
CREATE TABLE SanPham (
    MaSanPham NVARCHAR(11) PRIMARY KEY,
    TenSanPham NVARCHAR(255) NOT NULL,
    Hang NVARCHAR(255) NOT NULL,
    CPU NVARCHAR(100),
    RAM NVARCHAR(50),
    BoNho NVARCHAR(50),
    Gia DECIMAL(10, 2) NOT NULL CHECK (Gia >= 0), -- Ràng buộc kiểm tra giá không âm
    SoLuongTon INT NOT NULL CHECK (SoLuongTon >= 0), -- Ràng buộc kiểm tra số lượng không âm
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng Khách hàng
CREATE TABLE KhachHang (
    MaKhachHang NVARCHAR(11) PRIMARY KEY,
    Ten NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(15),
    DiaChi NVARCHAR(255),
    Email NVARCHAR(100) UNIQUE, -- Ràng buộc độc nhất cho Email
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng Nhân viên
CREATE TABLE NhanVien (
    MaNhanVien NVARCHAR(11) PRIMARY KEY,
    Ten NVARCHAR(255) NOT NULL,
    ChucVu NVARCHAR(100),
    ThongTinLienHe NVARCHAR(255),
    VaiTro NVARCHAR(50) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng Nhà cung cấp
CREATE TABLE NhaCungCap (
    MaNhaCungCap NVARCHAR(11) PRIMARY KEY,
    TenNhaCungCap NVARCHAR(255) NOT NULL,
    DiaChi NVARCHAR(255),
    ThongTinLienHe NVARCHAR(255),
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng Hóa đơn
CREATE TABLE HoaDon (
    MaHoaDon NVARCHAR(11) PRIMARY KEY,
    MaKhachHang NVARCHAR(11),
    MaNhanVien NVARCHAR(11),
    NgayLap DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(10, 2) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- Tạo bảng Chi tiết hóa đơn
CREATE TABLE ChiTietHoaDon (
    MaChiTietHoaDon NVARCHAR(11) PRIMARY KEY,
    MaHoaDon NVARCHAR(11),
    MaSanPham NVARCHAR(11),
    SoLuong INT NOT NULL,
    GiaBan DECIMAL(10, 2) NOT NULL,
    TongTien AS (SoLuong * GiaBan),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

CREATE TABLE DonDatHang (
    MaDonDatHang NVARCHAR(11) PRIMARY KEY,
    MaNhaCungCap NVARCHAR(11) NOT NULL,
    MaNhanVien NVARCHAR(11) NOT NULL, -- Thêm thuộc tính Người tạo
    NgayDat DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(50) NOT NULL DEFAULT 'Chưa hoàn thành', -- Chưa hoàn thành, Hoàn thành, Đã hủy
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien) -- Khóa ngoại đến bảng Nhân viên
);

CREATE TABLE ChiTietDonDatHang (
    MaChiTietDonDatHang NVARCHAR(11) PRIMARY KEY,
    MaDonDatHang NVARCHAR(11) NOT NULL,
    MaSanPham NVARCHAR(11) NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    GiaBan DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDonDatHang) REFERENCES DonDatHang(MaDonDatHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng Nhập hàng
CREATE TABLE NhapHang (
    MaNhapHang NVARCHAR(11) PRIMARY KEY,
    MaDonDatHang NVARCHAR(11) NOT NULL,
    MaSanPham NVARCHAR(11) NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    GiaNhap DECIMAL(10, 2) NOT NULL CHECK (GiaNhap >= 0),
    NgayNhap DATETIME DEFAULT GETDATE(),
    NgayTao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaDonDatHang) REFERENCES DonDatHang(MaDonDatHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);


-- Tạo bảng Bảo hành
CREATE TABLE BaoHanh (
    MaBaoHanh NVARCHAR(11) PRIMARY KEY,
    MaSanPham NVARCHAR(11),
    MaKhachHang NVARCHAR(11),
    NgayYeuCau DATETIME DEFAULT GETDATE(),
    ChiTietVanDe NVARCHAR(255),
    TrangThai NVARCHAR(50),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Tạo bảng Tài khoản người dùng
CREATE TABLE TaiKhoanNguoiDung (
    MaTaiKhoan NVARCHAR(11) PRIMARY KEY,
    TenDangNhap NVARCHAR(50) NOT NULL UNIQUE, -- Ràng buộc độc nhất cho Username
    MatKhauHash NVARCHAR(255) NOT NULL UNIQUE,
    MaNhanVien NVARCHAR(11) UNIQUE,
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);


---------------------------------------------------------------------

INSERT INTO SanPham VALUES
('P001', 'Acer Swift 3', 'Acer', 'Intel Core i7-1165G7', '16GB', '512GB SSD', 21000.00, 10, GETDATE(), GETDATE()),
('P002', 'Dell XPS 13', 'Dell', 'Intel Core i7-1185G7', '16GB', '1TB SSD', 25000.00, 5, GETDATE(), GETDATE()),
('P003', 'HP Spectre x360', 'HP', 'Intel Core i7-1165G7', '16GB', '512GB SSD', 23000.00, 8, GETDATE(), GETDATE()),
('P004', 'Lenovo ThinkPad X1 Carbon', 'Lenovo', 'Intel Core i7-1165G7', '16GB', '1TB SSD', 26000.00, 6, GETDATE(), GETDATE()),
('P005', 'ASUS ZenBook 14', 'ASUS', 'Intel Core i7-1165G7', '16GB', '512GB SSD', 22000.00, 12, GETDATE(), GETDATE()),
('P006', 'Microsoft Surface Laptop 4', 'Microsoft', 'Intel Core i7-1185G7', '16GB', '1TB SSD', 24000.00, 9, GETDATE(), GETDATE()),
('P007', 'Acer Predator Helios 300', 'Acer', 'Intel Core i7-11800H', '16GB', '1TB SSD', 27000.00, 7, GETDATE(), GETDATE()),
('P008', 'Dell G5 15', 'Dell', 'Intel Core i7-10750H', '16GB', '512GB SSD', 19000.00, 14, GETDATE(), GETDATE()),
('P009', 'HP Omen 15', 'HP', 'AMD Ryzen 7 5800H', '16GB', '1TB SSD', 20000.00, 11, GETDATE(), GETDATE()),
('P010', 'Lenovo Legion 5', 'Lenovo', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', 21000.00, 10, GETDATE(), GETDATE()),
('P011', 'ASUS ROG Zephyrus G14', 'ASUS', 'AMD Ryzen 9 5900HS', '32GB', '1TB SSD', 28000.00, 5, GETDATE(), GETDATE()),
('P012', 'Acer Aspire 7', 'Acer', 'AMD Ryzen 5 3550H', '8GB', '512GB SSD', 13000.00, 20, GETDATE(), GETDATE()),
('P013', 'Dell Inspiron 15 3000', 'Dell', 'Intel Core i3-1115G4', '8GB', '256GB SSD', 9000.00, 25, GETDATE(), GETDATE()),
('P014', 'HP Pavilion Gaming 15', 'HP', 'AMD Ryzen 5 4600H', '8GB', '512GB SSD', 14000.00, 15, GETDATE(), GETDATE()),
('P015', 'Lenovo IdeaPad Gaming 3', 'Lenovo', 'Intel Core i5-11300H', '8GB', '512GB SSD', 15000.00, 10, GETDATE(), GETDATE()),
('P016', 'ASUS VivoBook 14', 'ASUS', 'Intel Core i5-1135G7', '8GB', '256GB SSD', 12000.00, 18, GETDATE(), GETDATE()),
('P017', 'Microsoft Surface Pro 7', 'Microsoft', 'Intel Core i5-1035G4', '8GB', '128GB SSD', 14000.00, 9, GETDATE(), GETDATE()),
('P018', 'Acer Chromebook 14', 'Acer', 'Intel Celeron N3450', '4GB', '64GB eMMC', 6000.00, 30, GETDATE(), GETDATE()),
('P019', 'HP Chromebook x360', 'HP', 'Intel Pentium Gold 4417U', '4GB', '64GB eMMC', 7000.00, 25, GETDATE(), GETDATE()),
('P020', 'Lenovo Flex 5', 'Lenovo', 'AMD Ryzen 5 4500U', '16GB', '256GB SSD', 14000.00, 12, GETDATE(), GETDATE()),
('P021', 'ASUS Chromebook Flip C434', 'ASUS', 'Intel Core m3-8100Y', '4GB', '64GB eMMC', 8000.00, 20, GETDATE(), GETDATE()),
('P022', 'Dell Latitude 7420', 'Dell', 'Intel Core i7-1165G7', '16GB', '1TB SSD', 30000.00, 4, GETDATE(), GETDATE()),
('P023', 'HP Elite Dragonfly', 'HP', 'Intel Core i5-8265U', '16GB', '512GB SSD', 29000.00, 3, GETDATE(), GETDATE()),
('P024', 'Lenovo ThinkBook 14s', 'Lenovo', 'AMD Ryzen 7 5800H', '16GB', '512GB SSD', 23000.00, 8, GETDATE(), GETDATE()),
('P025', 'ASUS TUF Gaming A15', 'ASUS', 'AMD Ryzen 7 5800H', '16GB', '1TB SSD', 25000.00, 6, GETDATE(), GETDATE()),
('P026', 'Acer Swift 5', 'Acer', 'Intel Core i7-1165G7', '16GB', '1TB SSD', 24000.00, 9, GETDATE(), GETDATE()),
('P027', 'Dell Inspiron 14', 'Dell', 'Intel Core i5-1135G7', '8GB', '256GB SSD', 13000.00, 15, GETDATE(), GETDATE()),
('P028', 'HP Envy x360', 'HP', 'AMD Ryzen 5 4500U', '16GB', '512GB SSD', 18000.00, 10, GETDATE(), GETDATE()),
('P029', 'Lenovo Yoga 9i', 'Lenovo', 'Intel Core i7-1185G7', '16GB', '1TB SSD', 27000.00, 5, GETDATE(), GETDATE()),
('P030', 'ASUS ROG Strix G15', 'ASUS', 'AMD Ryzen 9 5900HX', '32GB', '1TB SSD', 32000.00, 4, GETDATE(), GETDATE());
Go


INSERT INTO KhachHang VALUES
('C001', N'Nguyễn Hứu Ân', '0901234567', N'123 Nguyễn Thị Minh Khai, Quận 1, TP.HCM', 'nguyenhuuan@gmail.com', GETDATE(), GETDATE()),
('C002', N'Trần Thị Bình', '0912345678', N'456 Lê Văn Sĩ, Quận 3, TP.HCM', 'tranthibinh@gmail.com', GETDATE(), GETDATE()),
('C003', N'Lê Ngọc Sơn', '0923456789', N'789 Điện Biên Phủ, Quận Bình Thạnh, TP.HCM', 'lengocson@gmail.com', GETDATE(), GETDATE()),
('C004', N'Phạm Thị Dung', '0934567890', N'321 Trần Hưng Đạo, Quận 5, TP.HCM', 'phamthidung@gmail.com', GETDATE(), GETDATE()),
('C005', N'Ngô Hải Đăng', '0945678901', N'654 Nam Kỳ Khởi Nghĩa, Quận 10, TP.HCM', 'ngohaidang@gmail.com', GETDATE(), GETDATE());
Go

INSERT INTO NhanVien VALUES
('E001', N'Nguyễn Văn An', N'Nhân viên bán hàng', '0901234567', N'Bán hàng', GETDATE(), GETDATE()),
('E002', N'Trần Thị Ngọc Anh', N'Quản lý kho', '0912345678', N'Quản lý', GETDATE(), GETDATE()),
('E003', N'Lê Văn Hải', N'Kỹ thuật viên', '0923456789', N'Kỹ thuật', GETDATE(), GETDATE()),
('E004', N'Phạm Thị Yến Nhi', N'Nhân viên hỗ trợ', '0934567890', N'Hỗ trợ khách hàng', GETDATE(), GETDATE()),
('E005', N'Ngô Văn Quang', N'Quản lý cửa hàng', '0945678901', N'Quản lý', GETDATE(), GETDATE());
Go

INSERT INTO NhaCungCap VALUES
('S001', N'Công ty TNHH Acer Việt Nam', N'123 Phạm Văn Đồng, TP.HCM', '0901122334', GETDATE(), GETDATE()),
('S002', N'Công ty TNHH Dell Việt Nam', N'456 Trường Chinh, TP.HCM', '0902233445', GETDATE(), GETDATE()),
('S003', N'Công ty TNHH HP Việt Nam', N'789 Điện Biên Phủ, TP.HCM', '0903344556', GETDATE(), GETDATE()),
('S004', N'Công ty TNHH Lenovo Việt Nam', N'321 Trần Hưng Đạo, TP.HCM', '0904455667', GETDATE(), GETDATE()),
('S005', N'Công ty TNHH ASUS Việt Nam', N'654 Nam Kỳ Khởi Nghĩa, TP.HCM', '0905566778', GETDATE(), GETDATE());
Go

INSERT INTO HoaDon VALUES
('HD001', 'C001', 'E001', 15000.00, GETDATE(), GETDATE()),
('HD002', 'C002', 'E002', 17000.00, GETDATE(), GETDATE()),
('HD003', 'C003', 'E001', 20000.00, GETDATE(), GETDATE()),
('HD004', 'C004', 'E003', 12000.00, GETDATE(), GETDATE()),
('HD005', 'C005', 'E004', 18000.00, GETDATE(), GETDATE());
Go

INSERT INTO ChiTietHoaDon VALUES
('CT001', 'HD001', 'P001', 1, 15000.00),
('CT002', 'HD002', 'P002', 1, 17000.00),
('CT003', 'HD003', 'P003', 1, 20000.00),
('CT004', 'HD004', 'P004', 1, 12000.00),
('CT005', 'HD005', 'P005', 1, 18000.00);
Go

INSERT INTO NhapHang VALUES
('NH001', 'P001', 'S001', 10, 15000.00, GETDATE(), GETDATE(), GETDATE()),
('NH001', 'P002', 'S001', 5, 17000.00, GETDATE(), GETDATE(), GETDATE()),
('NH001', 'P003', 'S001', 7, 20000.00, GETDATE(), GETDATE(), GETDATE()),
('NH002', 'P004', 'S002', 15, 16000.00, GETDATE(), GETDATE(), GETDATE()),
('NH002', 'P005', 'S002', 12, 18000.00, GETDATE(), GETDATE(), GETDATE()),
('NH002', 'P006', 'S002', 8, 21000.00, GETDATE(), GETDATE(), GETDATE()),
('NH003', 'P007', 'S003', 20, 14000.00, GETDATE(), GETDATE(), GETDATE()),
('NH003', 'P008', 'S003', 18, 19000.00, GETDATE(), GETDATE(), GETDATE()),
('NH003', 'P009', 'S003', 5, 22000.00, GETDATE(), GETDATE(), GETDATE()),
('NH004', 'P010', 'S004', 25, 15500.00, GETDATE(), GETDATE(), GETDATE()),
('NH004', 'P011', 'S004', 10, 17500.00, GETDATE(), GETDATE(), GETDATE()),
('NH004', 'P012', 'S004', 8, 20500.00, GETDATE(), GETDATE(), GETDATE()),
('NH005', 'P013', 'S005', 30, 16500.00, GETDATE(), GETDATE(), GETDATE()),
('NH005', 'P014', 'S005', 15, 18500.00, GETDATE(), GETDATE(), GETDATE()),
('NH005', 'P015', 'S005', 12, 21500.00, GETDATE(), GETDATE(), GETDATE());
Go

INSERT INTO BaoHanh VALUES
('W001', 'P001', 'C001', N'Màn hình bị lỗi', N'Đang xử lý', GETDATE()),
('W002', 'P002', 'C002', N'Pin không sạc', N'Đã hoàn thành', GETDATE()),
('W003', 'P003', 'C003', N'Bàn phím hỏng', N'Đang xử lý', GETDATE()),
('W004', 'P004', 'C004', N'Quạt tản nhiệt không hoạt động', N'Đang xử lý', GETDATE()),
('W005', 'P005', 'C005', N'Âm thanh không rõ', N'Đã hoàn thành', GETDATE());
Go

INSERT INTO TaiKhoanNguoiDung VALUES
('U001', 'vanan001', 'an1234', 'E001', GETDATE(), GETDATE()),
('U002', 'ngocanh002', 'anh1234', 'E002', GETDATE(), GETDATE()),
('U003', 'hai003', 'hai1234', 'E003', GETDATE(), GETDATE()),
('U004', 'yennhi004', 'nhi1234', 'E004', GETDATE(), GETDATE()),
('U005', 'quang005', 'quang1234', 'E005', GETDATE(), GETDATE());
Go

SELECT * FROM SanPham
SELECT * FROM KhachHang
SELECT * FROM NhanVien
SELECT * FROM NhaCungCap
SELECT * FROM HoaDon
SELECT * FROM ChiTietHoaDon
SELECT * FROM NhapHang
SELECT * FROM DonDatHang
SELECT * FROM ChiTietDonDatHang
SELECT * FROM BaoHanh
SELECT * FROM TaiKhoanNguoiDung

DROP TABLE SanPham
DROP TABLE KhachHang
DROP TABLE NhanVien
DROP TABLE NhaCungCap
DROP TABLE HoaDon
DROP TABLE ChiTietHoaDon
DROP TABLE NhapHang
DROP TABLE DonDatHang
DROP TABLE ChiTietDonDatHang
DROP TABLE BaoHanh
DROP TABLE TaiKhoanNguoiDung

---------------------------------------------------------------------
-- Nhập hàng và tăng số lượng tồn kho.
CREATE PROCEDURE NhapKho
    @ProductID NVARCHAR(11),   -- Mã sản phẩm
    @Quantity INT,             -- Số lượng nhập
    @SupplierID NVARCHAR(11),  -- Mã nhà cung cấp
    @ImportPrice DECIMAL(10, 2) -- Giá nhập
AS
BEGIN
    -- Tăng số lượng tồn kho
    UPDATE Inventory
    SET StockQuantity = StockQuantity + @Quantity,
        LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
    
    -- Lưu vào bảng nhập kho
    INSERT INTO ProductImports (ImportID, ProductID, SupplierID, Quantity, ImportPrice, ImportDate, CreatedAt, UpdatedAt)
    VALUES ('NH001', @ProductID, @SupplierID, @Quantity, @ImportPrice, GETDATE(), GETDATE(), GETDATE());
END;

-------------------------------------------------------------------------------
-- Xuất hàng và giảm số lượng tồn kho.
CREATE PROCEDURE XuatKho
    @ProductID NVARCHAR(11),   -- Mã sản phẩm
    @Quantity INT              -- Số lượng xuất
AS
BEGIN
    -- Giảm số lượng tồn kho
    UPDATE Inventory
    SET StockQuantity = StockQuantity - @Quantity,
        LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
    
    -- Lưu vào bảng xuất kho
    INSERT INTO ProductExports (ExportID, ProductID, Quantity, ExportDate, CreatedAt, UpdatedAt)
    VALUES ('XK001', @ProductID, @Quantity, GETDATE(), GETDATE(), GETDATE());
END;


----------------------------------------------------------------------------
-- Tạo Trigger để cập nhật UpdatedAt khi có thay đổi
----------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateTimestamp_Products
ON Products
AFTER UPDATE
AS
BEGIN
    UPDATE Products
    SET UpdatedAt = GETDATE()
    WHERE ProductID IN (SELECT ProductID FROM inserted);
END;

----------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateTimestamp_Customers
ON Customers
AFTER UPDATE
AS
BEGIN
    UPDATE Customers
    SET UpdatedAt = GETDATE()
    WHERE CustomerID IN (SELECT CustomerID FROM inserted);
END;

----------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateTimestamp_Invoices
ON Invoices
AFTER UPDATE
AS
BEGIN
    UPDATE Invoices
    SET UpdatedAt = GETDATE()
    WHERE InvoiceID IN (SELECT InvoiceID FROM inserted);
END;

----------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateTimestamp_ProductImports
ON ProductImports
AFTER UPDATE
AS
BEGIN
    UPDATE ProductImports
    SET UpdatedAt = GETDATE()
    WHERE ImportID IN (SELECT ImportID FROM inserted);
END;


DECLARE @ProductID NVARCHAR(11)
DECLARE @minStockLevel INT = 10 -- Ngưỡng tối thiểu tồn kho
