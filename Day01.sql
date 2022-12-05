-- DATABASE(VeriTabani) Olusturma

--DDL - DATA DEFINITION LANG.
--CREATE (TABLO OLUSTURMA)

CREATE TABLE ogrenciler
(
	ogrenci_no CHAR(7),
	isim VARCHAR(20),
	soyisim VARCHAR(25), 
	not_ort REAL, --> ondalikli sayilarda kullanilir
	kayit_tarih DATE
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA

CREATE TABLE ogrenci_notlari  -->ogrenci_notlari adinda yeni tablomuza isim verdik
AS  --> AS, bir sütunu veya tabloyu baska bir isimle yeniden kullanmak icin
SELECT isim,soyisim,not_ort FROM ogrenciler
	--> benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin normal tablo 
	--> olusturken kullandigimiz parantezler yerine AS kullanip SELECT ile almak istedigimiz verileri aliriz

SELECT * FROM ogrenci_notlari



-- DML - DATA MANIPULATION LANG.
--INSERT (database'e veri ekleme)

INSERT INTO ogrenciler VALUES ('1234567','Said','ILHAN',85.5,now());  --> bugunun tarihini istersek now()
INSERT INTO ogrenciler VALUES ('1234567','Said','ILHAN',85.5,'2022-12-01');

--BIR TABLOYA PARCALI VERI EKLEMEK

INSERT INTO ogrenciler(isim,soyisim) VALUES('Erol','EVREN');

--DQL - DATA QUERY LANG.
--SELECT 

SELECT * FROM ogrenciler;  --> * tumu anlamina gelir