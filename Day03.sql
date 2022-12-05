CREATE TABLE ogrenciler(
	ID INT,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu INT
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler

-- Ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
DELETE FROM ogrenciler WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';

--Veli ismi Hasan datayi silelim
DELETE FROM ogrenciler WHERE veli_isim='Hasan';

--TRANCATE -> tablodaki tum veriler geri alamayacagimiz sekilde siler. 
--Sartli silme yapmaz
TRUNCATE TABLE ogrenciler
------------------------------------------------------------------------
DROP TABLE ogrenciler
DROP TABLE notlar


CREATE TABLE ogrenciler(
	ID CHAR(3) PRIMARY KEY ,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu INT
);

CREATE TABLE notlar(
	ogrenci_id CHAR(3),
	ders_adi VARCHAR(30),
	yazili_notu INT,
	CONSTRAINT notlar_fk FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ID)
	ON DELETE CASCADE -->parent'dan veri silmek istersek kullaniriz
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

SELECT * FROM ogrenciler
SELECT * FROM notlar

--Notlar tablosundan id'si 123 olan datayi silelim
DELETE FROM notlar WHERE ogrenci_id='123';

/*
Her defasında önce child tablodaki verileri silmek yerine
ON DELETE CASCADE -> silme özelliği ile parent tablodan da veri silebiliriz.
Fakat ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablodan da silinir
*/

------------------------------------------------------------------------

CREATE TABLE musteriler (
	urun_id INT,
	musteri_isim VARCHAR(50), 
	urun_isim VARCHAR(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler

--Musteriler tablosundan urun ismi orange, apple veya apricot olan tum verileri listeleyin
SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--IN CONDITION 
SELECT * FROM musteriler WHERE urun_isim IN ('Orange','Apple','Apricot');

-- NOT IN --> Yazdığımız verilerin dışındakileri getirir
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple','Apricot');
SELECT * FROM musteriler WHERE urun_isim='Orange' AND urun_id=10

--BETWEEN CONDITION
/*BETWEEN Condition iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla
yazabilme imkani verir. Yazdigimiz 2 sinirda araliga dahildir */

-- Musteriler tablosundan urun_id'si 20 ile 40 arasında olan tüm verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 and 40;
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 and 40;

------------------------------------------------------------------------

-- SUBQUERIES --> Sorgu içinde sorgu
DROP TABLE calisanlar  
DROP TABLE adresler  --> onceden olusturdugum tablolari sildim

CREATE TABLE calisanlar
(
	ID INT, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas INT, 
	isyeri VARCHAR(20)
);

INSERT INTO calisanlar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
	marka_id INT, 
	marka_isim VARCHAR(20), 
	calisan_sayisi INT
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

SELECT * FROM calisanlar
SELECT * FROM markalar

-------------------

/*Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin. */
SELECT isim,maas,isyeri FROM calisanlar
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000); --> Sorgu icinde sorgu

-------------------

/* marka_id’si 101’den büyük olan marka çalişanlarinin 
isim, maaş ve şehirlerini listeleyiniz */

SELECT isim,maas,sehir FROM calisanlar
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id>101);

-------------------

/* Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin
isimlerini ve maaşlarini listeleyin. */

SELECT isim,maas,isyeri FROM calisanlar
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

-------------------

/*
--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
*/

SELECT marka_id, calisan_sayisi FROM markalar
WHERE marka_isim IN(SELECT isyeri FROM calisanlar WHERE sehir='Ankara');

-------------------

-- Aggregate Metotlari (SUM,COUNT, MIN, MAX, AVG)

--Calisanlar tablosunda maksimum maası listeleyiniz

SELECT MAX(maas) AS maksimum_maas FROM calisanlar;
	-->AS komutunu field'a gecici isim vermek icin kullaniriz (konsolda gostermek icin)

-------------------

--Calisanlar tablosunda minimum maası listeleyiniz
SELECT MIN(maas) AS minimum_maas FROM calisanlar;

-------------------

--Calisanlar tablosundaki maasların toplamını listeleyiniz
SELECT SUM(maas) AS maas_toplamı FROM calisanlar;

-------------------

--Calisanlar tablosundaki maasların ortalamasını listeleyiniz
SELECT AVG(maas) AS maas_ortalaması FROM calisanlar; 
--yada
SELECT ROUND(AVG(maas),2) AS maas_ortalaması FROM calisanlar;
	--> ROUND kullanarak yuvarlayabiliriz
	
-------------------

--Calisanlar tablosundaki maasların sayısı

SELECT COUNT(maas) AS maas_sayısı FROM calisanlar;
SELECT COUNT(*) AS maas_sayısı FROM calisanlar;
	--> Eğer count(*) kullanırsak tablodaki tüm satırların sayısını verir
	--> Sutun adı kullanırsak o sutundaki sayıları verir

-------------------

--AGGREGATE METHODLARDA SUBQUERY

--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz

SELECT marka_id,marka_isim,
(SELECT COUNT(sehir) AS sehir_sayisi FROM calisanlar WHERE marka_isim=isyeri) FROM markalar;

-------------------

-- VIEW Kullanımı
/*
Yaptığımız sorguları hafızaya alır ve tekrar bizden istenen sorgulama yenine
view'e atadığımız ismi SELECT komutuyla çağırırız
*/

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
CREATE VIEW sum_maas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT SUM(maas) FROM calisanlar WHERE isyeri=marka_isim) AS toplam_maas FROM markalar

SELECT * FROM sum_maas

-------------------

/* Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
 maksimum ve minumum maaşini listeleyen bir sorgu yaziniz. */
 
SELECT marka_isim,calisan_sayisi,
(SELECT MAX(maas) FROM calisanlar WHERE isyeri=marka_isim) AS en_yuksek_maas,
(SELECT MIN(maas) FROM calisanlar WHERE isyeri=marka_isim) AS en_dusuk_maas 
FROM markalar

-------------------

CREATE VIEW max_min_maas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT MAX(maas) FROM calisanlar WHERE isyeri=marka_isim) AS en_yuksek_maas,
(SELECT MIN(maas) FROM calisanlar WHERE isyeri=marka_isim) AS en_dusuk_maas
FROM markalar;

SELECT * FROM max_min_maas;
SELECT * FROM sum_maas;

---------------------------------------------------------------------------------

-- EXİSTS CONDITION

CREATE TABLE mart
(   
	urun_id INT,    
	musteri_isim VARCHAR(50), 
	urun_isim VARCHAR(50)
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
	urun_id INT,    
	musteri_isim VARCHAR(50), 
	urun_isim VARCHAR(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart
SELECT * FROM nisan

-------------------

/*
MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
*/

SELECT urun_id,musteri_isim FROM mart
WHERE EXISTS (SELECT urun_id FROM nisan WHERE mart.urun_id = nisan.urun_id)

-------------------

/*
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/

SELECT urun_isim,musteri_isim FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)

--------------------------------------------------------------------------------

--DML--> UPDATE
CREATE TABLE tedarikciler --> parent
(
	vergi_no INT PRIMARY KEY,
	firma_ismi VARCHAR(50),
	irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler --> child
(
	ted_vergino INT, 
	urun_id INT, 
	urun_isim VARCHAR(50), 
	musteri_isim VARCHAR(50),
	CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
	ON DELETE CASCADE
);  

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler
SELECT * FROM urunler

-------------------

--vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.

UPDATE tedarikciler
SET firma_ismi = 'Vestel' WHERE vergi_no=102;

-------------------

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.

UPDATE tedarikciler
SET firma_ismi = 'Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101

-------------------

--  urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.

UPDATE urunler
SET urun_isim = 'Telefon' WHERE urun_isim='Phone';

-------------------

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.

UPDATE urunler
SET urun_id = urun_id + 1 WHERE urun_id>1004;

-------------------

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.

UPDATE urunler
SET urun_id = urun_id + ted_vergino
DELETE FROM urunler

-------------------

/* urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci  tablosunda irtibat_ismi 
'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz. */

UPDATE urunler                      
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')                       
WHERE musteri_isim='Ali Bak';   

-------------------

--* Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.

UPDATE urunler                      
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi='Apple')                     
WHERE urun_isim='Laptop'                        

