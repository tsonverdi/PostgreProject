--Database Olusturma 

Create database tarik;

--DDL - Data Definition Language
--TABLO OLUSTURMA
--Hangi database terminalinde calistirisak orada olusur tables.
CREATE TABLE ogrenciler(
ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real, --ondalikli icin kullanilir.
	kayit_tarihi date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMAK
CREATE TABLE ogrenci_notlari
AS SELECT isim,soyisim,not_ort
--Bencer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin 
--AS SELECT kullaniriz
FROM ogrenciler;--Nerden alacagimizi soyledigimiz yer

INSERT INTO ogrenciler VALUES ('1082022','Tarik','Sonverdi',55.55,now());
INSERT INTO ogrenciler VALUES ('1082023','Hasan','Cetin',55.55,'2020-12-11');
--Sadece belirli fieldlara ekleme yapabilmek icin
INSERT INTO ogrenciler(isim,soyisim) VALUES('Enes','Turksoy');
--Yazdirmak icin
SELECT * from ogrenciler;
