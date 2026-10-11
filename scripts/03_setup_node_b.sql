-- Ràng buộc riêng cho Máy B (Khoa K2)
ALTER TABLE lop ADD CONSTRAINT chk_lop_khoa_b CHECK (makhoa = 'K2' AND malop LIKE 'K2_%');
ALTER TABLE sinhvien ADD CONSTRAINT chk_sv_khoa_b CHECK (masv LIKE 'K2_%');
