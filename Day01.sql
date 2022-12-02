-- DATABASE(VeriTabani) Olusturma

--create dataBase ogrenci;

--DDL - DATA DEFINITION LANG.
--CREATE (TABLO OLUSTURMA)

CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25), 
not_ort real,        --ondalikli sayilar kullanilir
kayit_tarih date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA

CREATE TABLE ogrenci_notlari
AS
-- benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin normal tablo 
--olusturken ki parantezler yerine AS kullanip SELECT ile almak istedigimiz verileri aliriz
SELECT isim,soyisim,not_ort FROM ogrenciler2

-- DML - DATA MANIPULATION LANG.
--INSERT (database e veri ekleme)

INSERT INTO ogrenciler2 VALUES ('1234567','Said','ILHAN',85.5,now());  --bugunun tarihini istersek now()
INSERT INTO ogrenciler2 VALUES ('1234567','Said','ILHAN',85.5,'2022-12-01');

--BIR TABLOYA PARCALI VERI EKLEMEK

INSERT INTO ogrenciler2 (isim,soyisim) VALUES('Erol','EVREN');

--DQL - DATA QUERY LANG.
--SELECT 

SELECT * FROM ogrenciler2;  -- * tumu anlamina gelir