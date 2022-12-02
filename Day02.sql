--Bir tablodan YENI birini olusturma

CREATE TABLE notlar
AS
SELECT isim,not_ort FROM ogrenciler;

SELECT * FROM notlar;

--Tablo icine veri girme

INSERT INTO notlar (isim,not_ort) VALUES ('Yasin',66.66);
INSERT INTO notlar (isim,not_ort) VALUES ('Hakan',91);
INSERT INTO notlar (isim,not_ort) VALUES ('Adem',45.5);
INSERT INTO notlar (isim,not_ort) VALUES ('Sumeyye',99.66);
INSERT INTO notlar (isim,not_ort) VALUES ('Kamil',66.56);
INSERT INTO notlar (isim,not_ort) VALUES ('Kamile',64.66);
INSERT INTO notlar (isim,not_ort) VALUES ('Nur',66.68);


--CONSTRAINTS

--UNIQUE

CREATE TABLE talebeler(
ogrenci_no char (7) UNIQUE,
	isim varchar(40) NOT NULL,
	soyisim varchar (20),
	not_ort real,
	kayit_tarihi date

);

select * from talebeler;

INSERT INTO talebeler VALUES ('1','Tarik','Sonverdi',66.68,'2002-12-04');
INSERT INTO talebeler VALUES ('3','','Kilic',66.68,'2003-12-04');
INSERT INTO talebeler VALUES ('2','Furkan','Borak',66.68,'2004-12-04');

--Not null oldugu icin burada hata aldik
INSERT INTO talebeler(soyisim) VALUES ('Nas');

--Primary Key atamasi
--1. Yol
CREATE TABLE calisanlar(
ogrenci_no char (7) PRIMARY KEY,
	isim varchar(40) NOT NULL,
	soyisim varchar (20),
	not_ort real,
	kayit_tarihi date

);

--2.Yol
CREATE TABLE calisanlar1(
ogrenci_no char (7),
	isim varchar(40) NOT NULL,
	soyisim varchar (20),
	not_ort real,
	kayit_tarihi date,
	CONSTRAINT ogrenci PRIMARY KEY (ogrenci_no)

);
--3.Yol
CREATE TABLE calisanlar1(
ogrenci_no char (7),
	isim varchar(40) NOT NULL,
	soyisim varchar (20),
	not_ort real,
	kayit_tarihi date,
	PRIMARY KEY (ogrenci_no)

);

CREATE TABLE tedarikciler3 (
tedarikci_id char(10) PRIMARY KEY,
tedarikci_isim varchar(40),
iletisim_isim varchar(40));

--Foreign Key atamasi
CREATE TABLE urunler (
tedarikci_id char(10),
urun_id char (10),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

--ORNEK 2:
--“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. 
--“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
--“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. 
--“adres_id” field‘i ile Foreign Key oluşturun.
CREATE TABLE calisanlar2 (
id char(10) PRIMARY KEY,
isim varchar(40) UNIQUE,
maas varchar(40) NOT NULL,
ise_baslama date);

CREATE TABLE adresler (
adres_id char(10),
sokak varchar(40),
cadde varchar(40),
sehir varchar(40),
FOREIGN KEY (adres_id) REFERENCES calisanlar2(id)
);
INSERT INTO calisanlar2 VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--Isim Unique oldugu icin calismadi
INSERT INTO calisanlar2 VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--Maas not null oldugu icin calismadi
INSERT INTO calisanlar2 VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('10007', 'CAN', 5000, '2018-04-14');--Isim unique oldugu icin eklemedi
INSERT INTO calisanlar2 VALUES('10009', 'cem', '', '2018-04-14');--Javada
INSERT INTO calisanlar2 VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar2 VALUES('', 'osman can', 2000, '2018-04-14');--Primary key unique olmali
INSERT INTO calisanlar2 VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--Primary key unique degil
INSERT INTO calisanlar2 VALUES( null, 'filiz ' ,12000, '2018-04-14');--Primary key null olamaz

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');--Primary Keyi olmayan bir yere eklemeye calisiyoruz.
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar2;
SELECT * FROM adresler;

--CHECK
CREATE TABLE calisanlar3 (
id char(10) PRIMARY KEY,
isim varchar(40) UNIQUE,
maas int CHECK (maas>3000) NOT NULL,
ise_baslama date);

--= ==> Equal to sign
--> ==> Greater than sign
--< ==> Less than sign
-->= ==> Greater than or equal to sign
--<= ==> Less than or equal to sign
--< > ==> Not Equal to sign 
--AND ==> And operator
--OR ==> Or operator

--DQL --Where Kullanimi

--Hepsini getiren
SELECT * FROM calisanlar2;

--Sadece isimleri getirir
SELECT isim FROM calisanlar2;

--Maasi 5000den buyuk olanlarin isimleri listelemek
SELECT isim FROM calisanlar2 WHERE maas>'5000';

--Calisanlar tablosunda ismi VEli Han olan tum verileri listeleyiniz.
SELECT * FROM calisanlar2 WHERE isim='Veli Han';

--Calisanlar maasi 5000 olanlarin tum verilerini listeleyiniz.
SELECT * FROM calisanlar2 WHERE maas='5000';

--DML DELETE KOMUTU
--Her seyi silmek adina
select * from adresler;
DELETE FROM adresler;

--Sehri antep olan verileri silelim
DELETE FROM adresler Where sehir='Antep';


--
CREATE TABLE ogrencilerhepsi
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrencilerhepsi VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrencilerhepsi VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrencilerhepsi VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrencilerhepsi VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrencilerhepsi VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrencilerhepsi VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

SELECT * FROM ogrencilerhepsi;

DELETE FROM ogrencilerhepsi WHERE isim ='Nesibe Yilmaz' OR isim ='Mustafa Bak';












