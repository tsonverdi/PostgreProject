--JOINS
/* 2 Tablodaki datalari Birlestirmek icin kullanilir.
Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir 
Tablolar icin ise JOIN kullanilir*/

/*
	NOT :
	1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
	2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
	3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
 */


CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  sirket_id int,  siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55,  105, '2020-04-21');

select * from sirketler;
select * from siparisler;

--) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi FROM sirketler INNER JOIN siparisler ON sirketler.sirket_id=siparisler.sirket_id;



--) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi FROM siparisler LEFT JOIN sirketler ON sirketler.sirket_id=siparisler.sirket_id;


/*
	NOT :
	1)Right Join’de ikinci tablodaki tum record’lar gosterilir.
	2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir
	ancak ortak olmayan datalar icin o kisimlar bos kalir
 */
 
 --) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi FROM siparisler RIGHT JOIN sirketler ON sirketler.sirket_id=siparisler.sirket_id;
 
 /*
	NOT :
	1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
	2) Bir tabloda olup otekinde olmayan data’lar bos kalir
*/
SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi FROM siparisler FULL JOIN sirketler ON sirketler.sirket_id=siparisler.sirket_id;

/*SELF JOINS*/


CREATE TABLE personel1 
(
id int,
isim varchar(20), 
title varchar(60), 
yonetici_id int
);

select * from personel1;

INSERT INTO personel1 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel1 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel1 VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel1 VALUES(4, 'Fatma Can', 'CEO', 5);

--TEk tablo uzerinden her personelin yanina yonetici ismini yazdiran bir tablo olusturun

SELECT p1.isim as personel_isim, p2.isim as yonetici_isim from personel1 p1 INNER JOIN personel1 p2 ON p1.yonetici_id = p2.id;

-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/
DROP TABLE musteriler cascade;

CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ali', 72000);

--Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE 'A%';
SeLECT * FROM musteriler WHERE isim ~~ 'A%';

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

SELECT isim,gelir FROM musteriler WHERE isim LIKE '%e';

--Ismi A veya a harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim ILIKE 'A%';

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

SELECT isim, gelir FROM musteriler WHERE isim LIKE '%er%';

--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE '_atma';

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE '_a%';

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE '__s%';

--Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE '__s_';

-- Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE 'F___%';

--Ikinci harfi a,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler WHERE isim LIKE '_a_m%';

/*3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
(REGEXP_LIKE) PostgreSQL de  ~  karekteri ile kullanilir*/

CREATE TABLE kelimeler 
(
id int UNIQUE,
kelime varchar(50) NOT NULL, 
Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'KUusf', 5);


--Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~ 'h[ai]t';

--: Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~ 'h[a-k]t';

--Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~ '[mi]';

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~ '^[as]';

--m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~ '[mf]$';

--NOT LIKE

--ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%';

--a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime NOT LIKE '%a%';

--ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime !~~ '_de%';

--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime !~ '[_eio]';

/*LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmezi sağlar
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~*
NOT REGEXP_LIKE = !~
*/

/*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
*/

SELECT UPPER(kelime) from kelimeler;

SELECT LOWER(kelime) FROM kelimeler;

SELECT INITCAP(kelime) FROM kelimeler;












