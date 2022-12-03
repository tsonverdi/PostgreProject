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

Select * From ogrencilerhepsi;

--Ismi mustafa bak ve nesibe yilmaz olan kayitlari silelim.

DELETE FROM ogrencilerhepsi WHERE isim = 'Mustafa Bak' OR isim='Nesibe Yilmaz';

--Veli ismi Hasan datayi silelim

DELETE FROM ogrencilerhepsi WHERE veli_isim = 'Hasan';

--TRUNCATE
--Geri alinamayacak sekilde siler

TRUNCATE TABLE ogrencilerhepsi;

--ON DELETE CASCADE--
DROP TABLE if exists talebeler; --eger tablo varsa sil
DROP TABLE if exists notlar;

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

Select * from notlar;
Select * from talebeler;

--Notlar tablosundan id'si 123 olan datayi silelim.
DELETE FROM notlar WHERE talebe_id = '123';

--Talebeler tablosundan id 126 olan datayi silelim
DELETE FROM talebeler WHERE id = '126';

--In Condition 

DROP TABLE IF EXISTS musteriler;

CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');


SELECT * FROM musteriler;

--Musteriler tablosundan urun ismi orange, apple veya apricot olan tum datalari listeleyiniz.
SELECT * FROM musteriler Where urun_isim= 'Orange' OR  urun_isim= 'Apple' OR  urun_isim= 'Apricot';


SELECT * FROM musteriler WHERE urun_isim IN('Orange','Apricot','Apple');

--NOT IN parnteze yazilanlarin disindakileri getitir.
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange','Apricot','Apple');

--BETWEEN INCLUSIVE
--id 20 ile 40 arasinda olan verileri listeleyeiniz.
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 and 40;

--Not between Inclusive
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 and 40;

-- 		SUBQUERIES
--SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur

CREATE TABLE calisan (
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
CREATE TABLE markalar (
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO calisan VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisan VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisan VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisan VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisan VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisan VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisan VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);


select * from calisan;
--Calisanlar 15000den fazla sayisi olan markalarin isim maas isyeri getir.
Select isim, maas, isyeri FROM calisan WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

--marka id 101den buyuk olan marka calisanlarinin isim maas ve sehir listele
SELECT isim, maas, sehir FROM calisan WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id>101);

--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.


--AGGREGATE METHOD
--max
SELECT max(maas) as maksimum_maas FROM calisan;

/*
Eğer bir sutuna geçici olarak bir isim vermek istersek AS komutunu yazdıktan sonra
vermek istediğimiz ismi yazarız
*/
--min
SELECT min(maas) as minimum_maas FROM calisan;

--sum
SELECT sum(maas) FROM calisan;

--avg
SELECT avg(maas) As Ortalama_Maas FROM calisan;

--round
SELECT round(avg(maas)) as Yuvarlak_Ortalama_Maas From calisan;

--Maas sayisini listeleyin
SELECT count(*) FROM calisan;

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id, marka_isim, (Select count(sehir) as sehir_sayisi from calisan WHERE marka_isim=isyeri) from markalar;
Select * from calisan;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz

CREATE view summaas
AS
SELECT marka_isim, calisan_sayisi, (SELECT sum(maas) as Toplam_Maas from calisan WHere marka_isim = isyeri) from markalar;

-- Her markanin ismini, calisan sayisini ve 
--o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim, calisan_sayisi,
(SELECT max(maas) as En_yuksek_maas from calisan where isyeri=marka_isim),
(SELECT min(maas) as En_dusuk_maas from calisan where isyeri=marka_isim)

from markalar;

--View kullanimi
CREATE view maxminmaas
AS 
SELECT marka_isim, calisan_sayisi,
(SELECT max(maas) as En_yuksek_maas from calisan where isyeri=marka_isim),
(SELECT min(maas) as En_dusuk_maas from calisan where isyeri=marka_isim)
from markalar;

SELECT * FROM maxminmaas;
SELECT * FROM summaas;

/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/

CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
/*
	MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
	URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
	MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
 */
Select * from nisan;

SELECT urun_id, musteri_isim FROM mart where exists (SELECT urun_id from nisan WHere mart.urun_id= nisan.urun_id);

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri 
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim, musteri_isim FROM nisan where exists (SELECT urun_isim from mart where mart.urun_isim=nisan.urun_isim);

--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

--UPDATE 

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');


CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler;
select * from urunler;

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.

UPDATE tedarikciler set firma_ismi='Vestel' Where vergi_no= 102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler set firma_ismi='casper',irtibat_ismi='Ali Veli' where vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler set urun_isim='Telefon' Where urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler set urun_id = urun_id + 1 WHERE urun_id>1004; 

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak
-- güncelleyiniz.

UPDATE urunler set urun_id= urun_id+ ted_vergino;

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.

UPDATE urunler set urun_isim = (SELECT firma_ismi from tedarikciler where irtibat_ismi= 'Adam Eve') where musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
Update urunler set musteri_isim = (SELECT irtibat_ismi from tedarikciler where firma_ismi = 'Apple' ) where urun_isim='Laptop';

