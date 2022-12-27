CREATE TABLE hastaneler (
id VARCHAR(10) PRIMARY KEY,
ISIM VARCHAR(50),
SEHIR VARCHAR(20),
	OZEL CHAR(5)
);
Select * FROM hastaneler;
Select * FROM hastalar;
Select * FROM bolumler;
Select * FROM hasta_kayitlar;


INSERT INTO hastaneler VALUES('H101','ACI MADEM HASTANESI','ISTANBUL','Y');
INSERT INTO hastaneler VALUES('H102','HASZEKI HASTANESI','ISTANBUL','N');
INSERT INTO hastaneler VALUES('H103','MEDIKOL HASTANESI','IZMIR','Y');
INSERT INTO hastaneler VALUES('H104','FATIH HASTANESI','ANKARA','Y');

CREATE TABLE hastalar(
tc_kmlk CHAR(11) PRIMARY KEY,
ISIM VARCHAR(30),
Teshis VARCHAR(30)
);

INSERT INTO hastalar VALUES('12345678901','Ali Can','Gizli Seker');
INSERT INTO hastalar VALUES('45678901121','Ayse Yilmaz','Hipertansiyon');
INSERT INTO hastalar VALUES('78901123451','Steve Job','Pankreatit');
INSERT INTO hastalar VALUES('12365498712','Tom Hanks','COVID19');

CREATE TABLE bolumler(
bolum_id CHAR(4),
bolum_adi VARCHAR(30),
CONSTRAINT bolum_id PRIMARY KEY(bolum_id)
);
DROP TABLE hasta_kayitlar;

INSERT INTO bolumler VALUES ('DHL','Dahiliye');
INSERT INTO bolumler VALUES ('KBB','Kulak Burun Bogaz');
INSERT INTO bolumler VALUES('NRJ','Noroloji');
INSERT INTO bolumler VALUES('GAST','Gastroloji');
INSERT INTO bolumler VALUES('KARD','Kardiyoloji');
INSERT INTO bolumler VALUES('PSK','Psikiyatri');
INSERT INTO bolumler VALUES('GOZ','Goz Hastaliklari');

CREATE TABLE hasta_kayitlar(
kimlik_no CHAR(30),
hasta_isim VARCHAR(30),
hastane_adi VARCHAR(30),
bolum_adi VARCHAR(30),
teshis VARCHAR(30),	
CONSTRAINT kimlik_no PRIMARY KEY (kimlik_no)
);

INSERT INTO hasta_kayitlar (kimlik_no,hasta_isim)VALUES ('1111','NONAME');
INSERT INTO hasta_kayitlar (kimlik_no,hasta_isim)VALUES ('2222','NONAME');
INSERT INTO hasta_kayitlar (kimlik_no,hasta_isim)VALUES ('3333','NONAME');

Select * FROM p;

--hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.

UPDATE hasta_kayitlar SET hasta_isim = 'Salvadore Dali', hastane_adi='John Hopins',bolum_adi='Noroloji',teshis='Parkinson',kimlik_no='99991111222' WHERE kimlik_no='3333';

--hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.

UPDATE hasta_kayitlar 
SET hasta_isim = (SELECT isim FROM hastalar WHERE isim= 'Ali Can'),
hastane_adi = (SELECT ISIM FROM hastaneler WHERE id= 'H104'),
bolum_adi = (SELECT bolum_adi FROM bolumler WHERE bolum_id = 'DHL'),
teshis= (SELECT teshis FROM hastalar WHERE isim='Ali Can'),
kimlik_no = (SELECT tc_kmlk FROM hastalar WHERE isim='Ali Can')
WHERE kimlik_no='1111';

--hasta_kayıtlar tablosundaki ‘2222’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.

UPDATE hasta_kayitlar
SET hasta_isim = (SELECT isim FROM hastalar WHERE isim= 'Ayse Yilmaz'),
hastane_adi = (SELECT ISIM FROM hastaneler WHERE id= 'H103'),
bolum_adi = (SELECT bolum_adi FROM bolumler WHERE bolum_id = 'KBB'),
teshis= (SELECT teshis FROM hastalar WHERE isim='Tom Hanks'),
kimlik_no = (SELECT tc_kmlk FROM hastalar WHERE isim='Steve Job')
WHERE kimlik_no='2222';







