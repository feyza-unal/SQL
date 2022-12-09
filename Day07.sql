-- DISTINCT -->sütun içerisinde geçen dataları tekrarsız olarak gösteren kod
			-->çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun
(
	urun_id INT,
	musteri_isim VARCHAR(50), 
	urun_isim VARCHAR(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz

--GROUP BY ile
SELECT urun_isim FROM musteri_urun
GROUP BY urun_isim

--DISTINCT ile
SELECT DISTINCT urun_isim
FROM musteri_urun

-- Tabloda kaç farklı meyve vardır
SELECT urun_isim,COUNT(urun_isim) AS urun_sayisi FROM musteri_urun
GROUP BY urun_isim

SELECT COUNT(DISTINCT urun_isim) AS urun_cesidi_sayisi FROM musteri_urun

-- FETCH NEXT (SAYI) ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 3

SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

-- Musteri urun tablosundan ilk kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 1

-- Müsteri urun tablosundan son üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC --> son 3 kayit icin listeyi ters cevirdik
LIMIT 3

-- Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
SELECT * FROM musteri_urun ORDER BY urun_id
OFFSET 3 FETCH NEXT 4 ROW ONLY

-------------------------------------------------------------------------------------------
-- EN yüksek maası alan müsteriyi listeleyiniz
CREATE TABLE maas
(
	id INT, 
	musteri_isim VARCHAR(50),
	maas INT
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);
SELECT * FROM maas

-- En yüksek maası alan müsteriyi listeleyiniz
SELECT * FROM maas ORDER BY maas DESC
LIMIT 1 

-- Maas tablosundan en yüksek ikinci maası listeleyiniz
SELECT * FROM maas ORDER BY maas DESC
OFFSET 1 LIMIT 1  --> satir atlamak istedigimizde OFFSET kullaniriz

--yada
SELECT * FROM maas ORDER BY maas desc
OFFSET 1 
FETCH NEXT 1 ROW ONLY

-- Maas tablosundan en düşük dördüncü maası listeleyiniz
SELECT * FROM maas ORDER BY maas
OFFSET 3 LIMIT 1

-------------------------------------------------------------------------------------------

-- ALTER TABLE -->Tablolar üzerinde değişiklik yapma 

CREATE TABLE personel(
	id INT,
	isim VARCHAR(50),  
	sehir VARCHAR(50),  
	maas INT,  
	sirket VARCHAR(20),
	CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel

--ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel 
ADD zipcode VARCHAR(30),

ALTER TABLE personel
ADD address varchar(50) DEFAULT 'Turkiye' 
	--> DEFAULT yazarsak oluşturduğumuz sütüna belirttiğimiz veriyi tüm satırlara girer

--DROP tablodan sutun silme
ALTER TABLE personel
DROP COLUMN zipcode

ALTER TABLE personel
DROP address, DROP sirket --> İki sutunu birden sildik

--RENAME COLUMN sutun adi degistirme
ALTER TABLE personel
RENAME COLUMN sehir TO il

--RENAME tablonun ismini degistirme
ALTER TABLE personel
RENAME TO calisan
	--> artik personel tablosunun adi degistigi icin calisan ismini kullanarak tabloyu cagirmaliyiz

SELECT * FROM calisan

--TYPE/SET(modify) sutunlarin ozelliklerini degistirme
ALTER TABLE calisan
ALTER COLUMN il TYPE VARCHAR(30),
ALTER COLUMN maas SET NOT NULL;

/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek
TYPE istedigimiz_veriTipi USING(maas::istedigimiz_veriTipi) bu formatı kullanırız
TYPE VARCHAR(30) USING(maas::VARCHAR(30))
*/

ALTER TABLE calisan
ALTER COLUMN maas
TYPE VARCHAR(30) USING(maas::VARCHAR(30)) --> '::' ile casting yaptik

-- TRANSACTION (BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve Transaction'ı sonlardık için
COMMIT komutunu çalıştırmalıyız
*/
CREATE TABLE ogrenciler
(
	id SERIAL,	--> Serial data türü otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
				--> INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım 
				--	veri değeri yerine DEFAULT yazarız
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu REAL       
);
BEGIN;
INSERT INTO ogrenciler VALUES(default, 'Ali Can', 'Hasan',75.5);  
INSERT INTO ogrenciler VALUES(default, 'Merve Gul', 'Ayse',85.3);
SAVEPOINT x;
INSERT INTO ogrenciler VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
SAVEPOINT y;
INSERT INTO ogrenciler VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;
SELECT * FROM ogrenciler

/*
NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar yanlış 
bir veriyi düzelmek veya bizim için önemli olan verilerden
sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu kullanırız 
ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka "COMMIT" komutu kullanılır.
*/