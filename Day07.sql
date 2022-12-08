-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT DISTINCT musteri_isim FROM musteri_urun;

-- FETCH NEXT (SAYI) ROW ONLY- OFFSET
-- 1) Tabloyu urun_id ye gore siralayiniz
-- 2) Sirali tablodan ilk 3 kaydi listeleyin

--Musteri urun tablosun ilk uc kaydi getirin

SELECT * FROM musteri_urun ORDER BY urun_id LIMIT 3;

SELECT * FROM musteri_urun ORDER BY urun_id FETCH NEXT 3 ROWS ONLY;

CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);

INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);


--En yuksek maas

SELECT max(maas) as en_yuksek_maas FROM maas;

--En yuksek ikinci

SELECT * FROM maas ORDER BY maas DESC offset 1 LIMIT 1;

-- Maas tablosundan en dusuk 4. maasi listeleyiniz

SELECT musteri_isim ,maas FROM maas ORDER BY maas offset 3 FETCH FIRST 2 ROWS ONLY;

/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
	DDL
 */
DROP TABLE personel cascade;
SELECT * FROM personel_tablosu;
CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');



ALTER TABLE personel ADD ulke_isim varchar(30) DEFAULT 'Germany';

--EKLEME

ALTER TABLE personel ADD satin_alim_tarihi date  DEFAULT now();


--3) DROP tablodan sutun silme

ALTER TABLE personel DROP COLUMN ulke_isim;

ALTER TABLE personel DROP sehir, DROP isim;

--4) RENAME

ALTER TABLE personel RENAME sirket TO sirket_ismi;

--5) Tablo ismi degistirme

ALTER TABLE personel RENAME TO personel_tablosu;

--7) Data tipini chardan inte cevirme

ALTER TABLE personel_tablosu ALTER COLUMN sirket_ismi TYPE int USING(sirket_ismi::int);

ALTER TABLE personel_tablosu ALTER COLUMN maas TYPE varchar(30) USING (maas::varchar(30));

UPDATE personel_tablosu SET sirket_ismi=null WHERE id=123456710;
 
--TRANSACTION Begin

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

SELECT * FROM ogrenciler2;

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

DELETE FROM ogrenciler2;
DROP TABLE ogrenciler2;

/*Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.*/