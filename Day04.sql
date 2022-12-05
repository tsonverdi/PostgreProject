select * from calisan;
select * from markalar;

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz

Select marka_id, calisan_sayisi from markalar Where marka_isim IN (Select isyeri from calisan where sehir='Ankara');

--ALIASES
select * from calisan;

--Stunlari concat etme
SELECT isim as calisan_isim, isyeri || maas as calisan_bilgisi from calisan ;

--IS NULL Condition
--Veriler arasinda null deger varsa ve biz bunu cagirmak istiyorsak.
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar;

--Name kisminda Null olan rowlari getirelim.
SELECT name from insanlar where name is null;

--Null olmayan degerleri ise is not null ile getirelim
SELECT * from insanlar where name is not null;

--Insanlar tablosunda null deger almis verileri no name olarak degistiriniz
UPDATE insanlar set name='No Name' where name is null;

--ORDER BY
/*
Tablolardaki verileri siralamak icin ORDER BY komutu kullaniriz Buyukten kucuge siralama yapabiliriz.
Default olarak Kucukten buyuge siralama yapar.
Eger buyukten kucuge siralama istersek ORDER BY komutundan sonra DESC komutunu kullaniriz.
*/

drop table if exists insanlar

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');


--Insanlar tablosundaki datalari adres’e gore siralayin

Select * FROM insanlar ORDER BY adres ASC;

SELECT * from insanlar order BY adres DESC;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin

SELECT * FROM insanlar where isim='Mine' ORDER BY ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin

SELECT * FROM insanlar where soyisim='Bulut' ORDER BY 4;

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
SELECT * FROM insanlar ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
SELECT isim,soyisim from insanlar ORDER BY LENGTH (soyisim);

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız

SELECT isim|| ' ' ||soyisim as isim_soyisim from insanlar ORDER BY LENGTH (isim || soyisim);

SELECT isim||' '|| soyisim as isim_soyisim from insanlar ORDER BY LENGTH (isim) + LENGTH (soyisim);

SELECT concat (isim,' ',soyisim) as isim_soyisim from insanlar ORDER BY LENGTH (isim || soyisim);

--GROUP BY
--Sonuclari bir veya daha fazla sutuna gore gruplamak icin SELECT komutu ile kullanirlir
CREATE TABLE manav
(
isim varchar(50),  Urun_adi varchar(50),  Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

-- Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz

SELECT isim, sum(urun_miktar) as topladigi_meyve_sayisi from manav GROUP BY isim ORDER BY topladigi_meyve_sayisi DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi

SELECT urun_adi, sum(Urun_miktar) as toplanan_meyve_sayisi from manav Group by urun_adi ORDER BY toplanan_meyve_sayisi DESC;

--Kac farkli cesit.

SELECT isim, count(urun_adi) as alidigi_farkli_urunler from manav GROUP BY isim ORDER BY alidigi_farkli_urunler DESC;



