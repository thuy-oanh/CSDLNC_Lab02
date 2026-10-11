-- =====================================================================
-- 05_queries_node_a.sql : Bộ truy vấn Q1 - Q6 trên Node A (qlsv_a)
-- =====================================================================

-- Q1. Đọc sinh viên Khoa K2 từ site_b.sinhvien
SELECT * FROM site_b.sinhvien;

-- Q2. Danh sách toàn bộ sinh viên toàn trường kèm lớp và khoa
SELECT sv.masv, sv.hoten, sv.ngaysinh, l.tenlop, l.makhoa, sv.hocbong
FROM v_sinhvien sv
JOIN v_lop l ON sv.malop = l.malop
ORDER BY l.makhoa, sv.masv;

-- Q3. Danh sách sinh viên có học bổng > 0
SELECT sv.masv, sv.hoten, l.tenlop, l.makhoa, sv.hocbong
FROM v_sinhvien sv
JOIN v_lop l ON sv.malop = l.malop
WHERE sv.hocbong > 0
ORDER BY sv.hocbong DESC;

-- Q4. Điểm trung bình của từng sinh viên toàn trường
SELECT sv.masv, sv.hoten, l.makhoa,
       ROUND(AVG(dk.diem), 2) AS diem_trung_binh,
       COUNT(dk.mamon) AS so_mon_da_hoc
FROM v_sinhvien sv
JOIN v_lop l ON sv.malop = l.malop
JOIN v_dangky dk ON sv.masv = dk.masv
WHERE dk.diem IS NOT NULL
GROUP BY sv.masv, sv.hoten, l.makhoa
ORDER BY l.makhoa, diem_trung_binh DESC;

-- Q5. Thống kê số lượng sinh viên theo từng khoa
SELECT l.makhoa, COUNT(sv.masv) AS so_luong_sinh_vien
FROM v_lop l
JOIN v_sinhvien sv ON l.malop = sv.malop
GROUP BY l.makhoa;

-- Q6. Danh sách sinh viên đạt điểm xuất sắc (>= 8.5) theo môn học
SELECT mh.tenmon, sv.masv, sv.hoten, l.makhoa, dk.diem
FROM v_dangky dk
JOIN v_sinhvien sv ON dk.masv = sv.masv
JOIN v_lop l ON sv.malop = l.malop
JOIN v_monhoc mh ON dk.mamon = mh.mamon
WHERE dk.diem >= 8.5
ORDER BY mh.tenmon, dk.diem DESC;