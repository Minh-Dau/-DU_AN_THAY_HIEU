/*CREATE TABLE nguoidung (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tai_khoan VARCHAR(50) NOT NULL,
    sdt VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mat_khau TEXT NOT NULL,
    dia_chi TEXT NULL,
    anh_dai_dien TEXT NULL,
    key_ma_hoa TEXT NULL,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    trang_thai BOOLEAN DEFAULT 1,
    ngay_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP
);
*/

/*
INSERT INTO nguoidung (tai_khoan, sdt, email, mat_khau, dia_chi, anh_dai_dien, key_ma_hoa)
VALUES ('tai_khoan_mau', '0123456789', 'email@example.com', 'mat_khau_ma_hoa', 'dia_chi_mau', 'anh_dai_dien_url', 'key_ma_hoa_mau');
*/

--SELECT * FROM nguoidung;
