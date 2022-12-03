CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25), 
not_ort real, --ondalikli sayilar kullanilir
kayit_tarih date
);

-- VAROLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA 
CREATE TABLE NOTLAR
AS 
SELECT isim, not_ort FROM ogrenciler2;

SELECT * FROM notlar;

--INSERT->TABLO ICINE VERI EKLEME
INSERT INTO notlar VALUES ('Ali',45.5);
INSERT INTO notlar VALUES ('Musa',60);
INSERT INTO notlar VALUES ('Hakan',75);
INSERT INTO notlar VALUES ('Adem',95);
INSERT INTO notlar VALUES ('Sumeyye',55.5);

--CONSTRAINT 
--UNIQUE -> tekrarsiz
--NOT NULL -> bos gecmemek icin

CREATE TABLE ogrenciler4
(
ogrenci_no char(7) UNIQUE,
isim varchar(20) NOT null,
soyisim varchar(25), 
not_ort real, 
kayit_tarih date
);
SELECT * FROM ogrenciler4

INSERT INTO ogrenciler4 VALUES ('1234567','Erol','Evren',75.5,now());
INSERT INTO ogrenciler4 VALUES ('1234567','Ali','Veli',75.5,now());

--PARCALI VERI EKLEME
INSERT INTO ogrenciler4 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5);
--not null kisitlamasi oldugu icin bu veri eklenemez (kod hata verir)

--PRIMARY KEY atamasi
CREATE TABLE ogrenciler5
(
ogrenci_no char(7) PRIMARY KEY,
isim varchar(20),
soyisim varchar(25), 
not_ort real, 
kayit_tarih date
);

--PRIMARY KEY ATAMASI 2. YOL
CREATE TABLE ogrenciler6
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25), 
not_ort real, 
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no)		
);

-- FOREIGN KEY
/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)	
);

CREATE TABLE urunler(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

CREATE TABLE urunler(
tedarikci_id char(5),
urun_id char(5),
CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

SELECT * FROM tedarikciler3;
SELECT * FROM urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” 
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” 
fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(15),
cadde varchar(15),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --unique cons. old. icin kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --not null cons. old icin kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); 
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --2. hicligi kabul etmiyor - unique
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --primary key

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

-- CHECK CONSTRAINT
CREATE TABLE calisanlar2
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000) NOT NULL,
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');

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
DELETE FROM calisanlar; -- Eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmeli
DELETE FROM adresler;

--adresler tablosundan sehri antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler7(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler7 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler7 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler7 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler7 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler7 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler7 VALUES(127, 'Mustafa Bak', 'Ali', 99);
DELETE FROM ogrenciler7 WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';

SELECT * FROM ogrenciler7;