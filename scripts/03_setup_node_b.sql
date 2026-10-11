-- =====================================================================
-- Ràng buộc riêng cho Máy B (Khoa K2) - chạy SAU 01_schema_common.sql
-- Lưu ý: trong LIKE, '_' là ký tự đại diện nên phải escape thành '\_'
-- =====================================================================
ALTER TABLE lop      DROP CONSTRAINT IF EXISTS chk_lop_khoa_b;
ALTER TABLE sinhvien DROP CONSTRAINT IF EXISTS chk_sv_khoa_b;

ALTER TABLE lop ADD CONSTRAINT chk_lop_khoa_b
    CHECK (makhoa = 'K2' AND malop LIKE 'K2\_%' ESCAPE '\');

ALTER TABLE sinhvien ADD CONSTRAINT chk_sv_khoa_b
    CHECK (masv LIKE 'K2\_%' ESCAPE '\');
