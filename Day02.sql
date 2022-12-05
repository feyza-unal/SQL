-- VAROLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA 
CREATE TABLE notlar
AS 
SELECT isim, not_ort FROM ogrenciler;

SELECT * FROM notlar;

--INSERT ->TABLO ICINE VERI EKLEME
INSERT INTO notlar VALUES ('Ali',45.5);
INSERT INTO notlar VALUES ('Musa',60);
INSERT INTO notlar VALUES ('Hakan',75);
INSERT INTO notlar VALUES ('Adem',95);
INSERT INTO notlar VALUES ('Sumeyye',55.5);

--> CONSTRAINT(kisitlamalar)
--UNIQUE -> tekrarsiz
--NOT NULL -> bos gecmemek icin

DROP TABLE ogrenciler --> tabloyu temizledik

CREATE TABLE ogrenciler
(
	ogrenci_no CHAR(7) UNIQUE,
	isim VARCHAR(20) NOT NULL,
	soyisim VARCHAR(25), 
	not_ort REAL, 
	kayit_tarih DATE
);

SELECT * FROM ogrenciler

INSERT INTO ogrenciler VALUES ('1234567','Erol','Evren',75.5,now());
INSERT INTO ogrenciler VALUES ('1234567','Ali','Veli',75.5,now()); --> ogrenci_no UNIQUE olmali hata verir
INSERT INTO ogrenciler VALUES ('2345671','Cem','Veli',90,now());

--PARCALI VERI EKLEME
INSERT INTO ogrenciler (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5);
	-->not null kisitlamasi oldugu icin bu veri eklenemez (kod hata verir)

DROP TABLE ogrenciler

--PRIMARY KEY atamasi
CREATE TABLE ogrenciler
(
	ogrenci_no CHAR(7) PRIMARY KEY,
	isim VARCHAR(20),
	soyisim VARCHAR(25), 
	not_ort REAL, 
	kayit_tarih DATE
);

--PRIMARY KEY ATAMASI 2. YOL
CREATE TABLE ogrenciler6
(
	ogrenci_no CHAR(7),
	isim VARCHAR(20),
	soyisim VARCHAR(25), 
	not_ort REAL, 
	kayit_tarih DATE
	CONSTRAINT ogr PRIMARY KEY(ogrenci_no)		
);

-- FOREIGN KEY
/*
“tedarikciler” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler(
	tedarikci_id CHAR(5) PRIMARY KEY,
	tedarikci_ismi VARCHAR(20),
	iletisim_isim VARCHAR(20)	
);

CREATE TABLE urunler(
	tedarikci_id CHAR(5),
	urun_id CHAR(5),
	FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler(tedarikci_id) 
	--> tedarikci_id'yi tedarikciler firmasindan aldik
);

--> FK kullanimi 2. yol
CREATE TABLE urunler(
	tedarikci_id CHAR(5),
	urun_id CHAR(5),
	CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler(tedarikci_id)
);

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” 
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” 
fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar(
	ID CHAR(5) PRIMARY KEY,
	isim VARCHAR(20) UNIQUE,
	maas INT NOT NULL,
	ise_baslama DATE
);

CREATE TABLE adresler(
	adres_id CHAR(5),
	sokak VARCHAR(15),
	cadde VARCHAR(15),
	sehir VARCHAR(15),
	FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -->unique cons. old. icin kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -->not null cons. old icin kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -->unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --> maas null olamaz
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -->2. hicligi kabul etmiyor - unique
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -->primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -->primary key

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM CALISANLAR;
SELECT * FROM ADRESLER;

DROP TABLE calisanlar --> Eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmeli
DROP TABLE adresler --> once  bunu yani child'i silmeliyiz


-- CHECK CONSTRAINT
CREATE TABLE calisanlar
(
	ID VARCHAR(15) PRIMARY KEY,
	isim VARCHAR(30) UNIQUE,
	maas INT CHECK (maas>10000) NOT NULL,
	ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');

-- DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;

--Calisanlar tablosundan maasi 5000den buyuk olanlari listeleyiniz
SELECT isim,maas FROM calisanlar WHERE maas>5000;

--Calisanlar tablosundan ismi Veli Han olan  tum verileri listeleyin
SELECT * FROM calisanlar WHERE isim='Veli Han'

--Calisanlar tablosunda maasi 5000 olan tum verileri listeleyin
SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar; --> Eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmeli
DELETE FROM adresler;

--adresler tablosundan sehri antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';


-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
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

DELETE FROM ogrenciler WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';

SELECT * FROM ogrenciler;