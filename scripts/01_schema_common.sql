-- =====================================================================
-- 01_schema_common.sql : Cấu trúc chung cho CẢ HAI máy (A và B)
-- Chạy trên qlsv_a (Máy A) và qlsv_b (Máy B). Không chứa cấu hình riêng từng khoa.
-- =====================================================================

-- 1. Bảng MONHOC (bản sao giống nhau ở cả hai máy)
CREATE TABLE IF NOT EXISTS monhoc (
    mamon    VARCHAR(20)  PRIMARY KEY,
    tenmon   VARCHAR(100) NOT NULL,
    sotinchi INT          NOT NULL CHECK (sotinchi > 0)
);

-- 2. Bảng LOP
CREATE TABLE IF NOT EXISTS lop (
    malop  VARCHAR(20)  PRIMARY KEY,
    tenlop VARCHAR(100) NOT NULL,
    makhoa VARCHAR(10)  NOT NULL CHECK (makhoa IN ('K1', 'K2')),
    -- Mã lớp phải bắt đầu bằng <makhoa>_ (K1_ hoặc K2_)
    CONSTRAINT chk_lop_prefix CHECK (LEFT(malop, 3) = makhoa || '_')
);

-- 3. Bảng SINHVIEN
CREATE TABLE IF NOT EXISTS sinhvien (
    masv     VARCHAR(20)  PRIMARY KEY,
    hoten    VARCHAR(100) NOT NULL,
    ngaysinh DATE,
    malop    VARCHAR(20)  NOT NULL,
    hocbong  NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (hocbong >= 0),
    CONSTRAINT chk_sv_prefix CHECK (masv ~ '^K[12]_'),
    CONSTRAINT fk_sinhvien_lop FOREIGN KEY (malop) REFERENCES lop(malop)
);

-- 4. Bảng DANGKY
CREATE TABLE IF NOT EXISTS dangky (
    masv   VARCHAR(20) NOT NULL,
    mamon  VARCHAR(20) NOT NULL,
    hocki  INT         NOT NULL CHECK (hocki IN (1, 2, 3)),
    namhoc INT         NOT NULL CHECK (namhoc > 0),   -- năm bắt đầu của năm học
    diem   NUMERIC(4, 2) CHECK (diem IS NULL OR (diem >= 0 AND diem <= 10)),
    PRIMARY KEY (masv, mamon, hocki, namhoc),
    CONSTRAINT fk_dangky_sinhvien FOREIGN KEY (masv)  REFERENCES sinhvien(masv),
    CONSTRAINT fk_dangky_monhoc   FOREIGN KEY (mamon) REFERENCES monhoc(mamon)
);
