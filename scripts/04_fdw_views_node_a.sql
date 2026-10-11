-- =====================================================================
-- 04_fdw_views_node_a.sql : Cấu hình FDW và Lớp View Thống Nhất trên Node A
-- =====================================================================

-- 1. Bật extension FDW
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- 2. Dọn dẹp cấu hình cũ
DROP SCHEMA IF EXISTS site_b CASCADE;
DROP USER MAPPING IF EXISTS FOR postgres SERVER server_b;
DROP SERVER IF EXISTS server_b CASCADE;

-- 3. Tạo Foreign Server trỏ sang Máy B
CREATE SERVER server_b
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host '26.225.100.60', port '5432', dbname 'qlsv_b');

-- 4. Ánh xạ quyền người dùng sang user b_reader
CREATE USER MAPPING FOR postgres
    SERVER server_b
    OPTIONS (user 'b_reader', password 'Password_Reader_123');

-- 5. Tạo schema site_b để chứa các bảng ngoại
CREATE SCHEMA site_b;

-- 6. Import các bảng từ Máy B vào schema site_b
IMPORT FOREIGN SCHEMA public
    LIMIT TO (lop, sinhvien, monhoc, dangky)
    FROM SERVER server_b
    INTO site_b;

-- 7. Xây dựng 4 View Thống Nhất Toàn Cục
CREATE OR REPLACE VIEW v_lop AS
SELECT malop, tenlop, makhoa FROM lop
UNION ALL
SELECT malop, tenlop, makhoa FROM site_b.lop;

CREATE OR REPLACE VIEW v_sinhvien AS
SELECT masv, hoten, ngaysinh, malop, hocbong FROM sinhvien
UNION ALL
SELECT masv, hoten, ngaysinh, malop, hocbong FROM site_b.sinhvien;

CREATE OR REPLACE VIEW v_dangky AS
SELECT masv, mamon, hocki, namhoc, diem FROM dangky
UNION ALL
SELECT masv, mamon, hocki, namhoc, diem FROM site_b.dangky;

CREATE OR REPLACE VIEW v_monhoc AS
SELECT mamon, tenmon, sotinchi FROM monhoc;