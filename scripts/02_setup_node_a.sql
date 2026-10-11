-- Ràng buộc riêng cho Máy A (Khoa K1)
ALTER TABLE lop ADD CONSTRAINT chk_lop_khoa_a CHECK (makhoa = 'K1' AND malop LIKE 'K1_%');
ALTER TABLE sinhvien ADD CONSTRAINT chk_sv_khoa_a CHECK (masv LIKE 'K1_%');