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
SELECT calisan_id AS ID, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar

--2.yol
SELECT calisan_id AS ID, concat(calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar

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
SELECT name FROM insanlar WHERE name IS NULL

-- Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar WHERE name IS NOT NULL

-- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz



