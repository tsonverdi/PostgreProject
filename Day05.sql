--GROUP BY
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

Delete from personel;

--Isme gore toplam maaslari bulun
SELECT isim, sum(maas) as toplam_maas from personel Group By isim;

--Sehre gore personel tablosundaki isimleri gruplayiniz
SELECT isim, count(sehir) from personel GROUP BY isim;

--Sirketlere gore maasi 5binden fazla olan personel sayisi
SELECT sirket, count(*) as personel_sayisi from personel WHERE maas>5000 GROUP BY sirket;

--HAVING CLAUSE
-- HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.
/*HAVING CLAUSE yalnizca group by ile kullanilir. Eger grouplamadan sonra bir sart varsa having clause kullaniriz.
*/
--Her sirketin min maaslarini eger 4000den buyukse goster.
SELECT sirket,min(maas) as en_az_maas from personel group by sirket HAVING MIN(maas)>4000;

-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz

SELECT isim, sum(maas) as toplam_maas from personel GROUP BY isim HAVING SUM(maas)>10000;

--Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir, count(isim) as personel_sayisi from personel GROUP by sehir HAVING count(isim)>1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir, MAX(maas) as en_yuksek_maas from personel GROUP by sehir HAVING max(maas)<5000;

--UNION CLAUSE
--Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i ayni 
--olmalidir.

-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz

SELECT maas, isim as iscivesehirismi from personel WHERE maas>5000 UNION SELECT maas, sehir as iscivesehirismi from personel where maas>5000;

--Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
--bir tabloda gosteren sorgu yaziniz

SELECT maas,isim as maas_isim from personel WHERE isim='Mehmet Ozturk' UNION SELECT maas ,isim as maas_isim from personel where sehir='Istanbul' Order by maas ASC;

--2 Tablodan DAta birlestirme
DROP TABLE personel;

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id));

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);

select * from personel_bilgi;

select * from personel;

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

--SORU: id’si 12345678 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi 
--tablosundan da tel ve cocuk sayisini yazdirin

SELECT sehir AS Sehir_tel, maas as cocuk_sayisi_veya_maas from personel WHERE id='123456789' 
UNION 
SELECT tel, cocuk_sayisi from personel_bilgi where id='123456789';

--UNION ALL
--) Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz

SELECT isim, maas from personel WHERE maas<5000 UNION ALL
SELECT isim, maas from personel WHERE maas<5000; 
--TEkrarli yazdirir.

--INTERSECT
--KESISEN kismi getirir.
---Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin

SELECT id from personel WHERE sehir IN('Istanbul','Ankara') INTERSECT SELECT id from personel_bilgi where cocuk_sayisi IN (2,3) ORDER BY id ASC;

--) Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin

SELECT isim FROM personel WHERE sirket='Honda' INTERSECT SELECT isim FROM personel WHERE sirket='Ford' INTERSECT SELECT isim FROM personel WHERE sirket='Tofas';

--EXCEPT OPERATOR(MINUS KOMUTU)
--5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket from personel where maas<5000 EXCEPT SELECT isim,sirket FROM personel WHERE sirket='Honda';


	


