-- =====================================================================
-- Ràng buộc riêng cho Máy A (Khoa K1) - chạy SAU 01_schema_common.sql
-- Lưu ý: trong LIKE, '_' là ký tự đại diện nên phải escape thành '\_'
-- =====================================================================
ALTER TABLE lop      DROP CONSTRAINT IF EXISTS chk_lop_khoa_a;
ALTER TABLE sinhvien DROP CONSTRAINT IF EXISTS chk_sv_khoa_a;

ALTER TABLE lop ADD CONSTRAINT chk_lop_khoa_a
    CHECK (makhoa = 'K1' AND malop LIKE 'K1\_%' ESCAPE '\');

ALTER TABLE sinhvien ADD CONSTRAINT chk_sv_khoa_a
    CHECK (masv LIKE 'K1\_%' ESCAPE '\');
