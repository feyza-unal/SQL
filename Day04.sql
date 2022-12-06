DROP TABLE calisanlar CASCADE
DROP VIEW max_min_maas

--------------------------------------

--Alias 

CREATE TABLE calisanlar(
	calisan_id CHAR(9),
	calisan_isim VARCHAR(50),
	calisan_dogdugu_sehir VARCHAR(50)
);

INSERT INTO calisanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM calisanlar

-->Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS ID, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar;

--2.yol
SELECT calisan_id AS ID, concat(calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar;

--------------------------------------
-- IS NULL CONDITION
-- Arama yapilan field’da NULL degeri almis kayitlari getirir
DROP TABLE insanlar
CREATE TABLE insanlar
(
	ssn CHAR(9),
	name VARCHAR(50),  
	adres VARCHAR(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar

-- Name sutununda null olan değerleri listeleyelim
SELECT name FROM insanlar WHERE name IS NULL;

-- Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar WHERE name IS NOT NULL;

-- Insanlar tablosunda null değer almış verileri no name olarak değiştiriniz
UPDATE insanlar
SET name='no name'
WHERE name is null;

DROP TABLE IF EXISTS insanlar

----------------------------------------------------------------------------

-- ORDER BY KOMUTU
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar (ASC)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

CREATE TABLE insanlar
(
	ssn CHAR(9),
	isim VARCHAR(50),
	soyisim VARCHAR(50),  
	adres VARCHAR(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

SELECT * FROM insanlar

--Insanlar tablosundaki datalari adres’e gore siralayin  
SELECT * FROM insanlar ORDER BY adres;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
SELECT * FROM insanlar WHERE isim='Mine' ORDER BY ssn;

-->NOT : Order By komutundan sonra field(sutun) ismi yerine field(sutun) numarasi da kullanilabilir

--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
SELECT * FROM insanlar WHERE soyisim='Bulut' ORDER BY 2 ; -->isim 2. sutun

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
SELECT * FROM insanlar ORDER BY 1 DESC ; --> ssn 1. sutun

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar ORDER BY isim, soyisim DESC; --> yada isim'den sonra ASC yazabiliriz

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eğer sutun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız 
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH (soyisim);
SELECT isim,soyisim FROM insanlar ORDER BY LENGTH (soyisim) DESC;

--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH(isim||soyisim);
--yada
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar ORDER BY LENGTH(isim) + LENGTH(soyisim);
--yada
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH(isim) + LENGTH(soyisim);
--yada
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar ORDER BY LENGTH (concat(isim,soyisim));

----------------------------------------------------------------------------

-- GROUP BY KULLANIMI
CREATE TABLE manav
(
	isim VARCHAR(50),  
	urun_adi VARCHAR(50),  
	urun_miktar INT
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

SELECT * FROM manav

--Isme gore alinan toplam urunleri listeleyiniz
SELECT isim,SUM(urun_miktar) AS aldigi_toplam_urun FROM manav GROUP BY isim;

--Isme gore alinan toplam urunleri bulun ve urunleri büyükten küçüğe listeleyiniz
SELECT isim,SUM(urun_miktar) AS aldigi_toplam_urun FROM manav 
GROUP BY isim 
ORDER BY aldigi_toplam_urun DESC;

--Urun ismine gore urunu alan toplam kisi sayisi
SELECT urun_adi,COUNT(isim) FROM manav
GROUP BY urun_adi;
--yada
SELECT isim,COUNT(urun_adi) FROM manav
GROUP BY isim

