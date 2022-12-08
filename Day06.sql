/*
--JOINS:  iki tablodaki dataları birleştirmeye yarar.
--JOINS tabloları birleştirmeye, UNION sorgulamaları birleştirmeye yarar.
--5 tane JOINS var.
-- 1) INNER JOIN : iki tablodaki ortak dataları gösterir.
-- 2) LEFT JOIN : ilk tabloda var olan dataları gösterir.
-- 3) RIGHT JOIN :ikinci tabloda var olan dataları gösterir.
-- 4) FULL JOIN: iki tablodaki var olan tüm dataları gösterir.
-- 5) SELF JOIN: tabloyu kendi kendiyle birleştirme işlemi.
*/
------------------------------------------------------------------------------------

CREATE TABLE sirketler  (
	sirket_id INT,  
	sirket_isim VARCHAR(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');


CREATE TABLE siparisler  (
	siparis_id INT,  
	sirket_id INT,  
	siparis_tarihi DATE
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

SELECT * FROM sirketler
SELECT * FROM siparisler

------------------------------------------------------------------------------------

-- INNER JOIN --> iki tablodaki ortak dataları gösterir.

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirket_isim,siparis_id,siparis_tarihi 
FROM sirketler JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id 

--------------------
--LEFT JOIN 	-->ilk tablodaki tüm datalar gösterilir.
				-->İlk tablodaki datalara ikinci tablodan
				-->gelen ek datalar var ise bu ek datalar ortak datalar için gösterilir ancak ortak olmayan
				-->datalar için o kısımlar boş bırakılır.

-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id 

--------------------
--RIGHT JOIN 	-->ilk tablodaki tüm datalar gösterilir.
				-->İlk tablodaki datalara ikinci tablodan
				-->gelen ek datalar var ise bu ek datalar ortak datalar için gösterilir 
				-->ancak ortak olmayan datalar için o kısımlar boş bırakılır.

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--------------------
--FULL JOIN 	-->iki tablodada var olan tüm datalar gösterilir. genellikle bazı datalar
				-->boş kalabilir.
				
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--------------------
--SELF JOIN --> tek tablo uzerinde calisiyoruz (bir tablodan yeni bir tablo olusturmak gibi)

CREATE TABLE personel  (
	id INT,
	isim VARCHAR(20),  
	title VARCHAR(60),  
	yonetici_id INT
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT p1.isim AS personel_ismi, p2.isim AS yonetici_ismi --> sol sutun ismini personel_ismi, sag sutun ismini yonetici_ismi yaptik
FROM personel p1 INNER JOIN personel p2 -->personel tablosunda p1 ve p2 isimli (hayali) tablolar turettik
ON p1.yonetici_id = p2.id

------------------------------------------------------------------------------------
-- LIKE CONDITION

-->LIKE gibi demek J% : J ile başlasın devamı ne olursa olsun demektir.
-->LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
-->LIKE yerine ~~ sembollerini kullanabiliriz. ILIKE yerine ~~* sembollerini kullanırız

--> % : Bir veya birden fazla karakter gösterir.
--> _ : Sadece bir karakteri temsil eder, ne olduğu önemli değil.
--> [ ] : sembol içine koyulan harflerden herhangi birisi olabilir manasında
--> ^ : ile başlayan manasında
--> (*) : herşey manasında
--> ( $): ile biter anlaminda

CREATE TABLE musteriler  (
	id INT UNIQUE,
	isim VARCHAR(50) NOT NULL,
	gelir INT
);

INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1007, 'erhan', 92000);

--Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ILIKE 'A%'
SELECT * FROM musteriler WHERE isim ~~* 'a%'

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim LIKE '%e'
SELECT isim,gelir FROM musteriler WHERE isim ~~ '%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim LIKE '%er%'

--Ismi 5 harfli olup son 4 harfi '-atma' olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE '%atma'

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '_a%'

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim ~~ '__s%'

----------------------------------------
-- REGEXP_LIKE (~) KULLANIMI
--> (%): Bir veya birden fazla karakter gösterir.
--> (_): Sadece bir karakteri temsil eder, ne olduğu önemli değil.
--> [ ] : sembol içine koyulan harflerden herhangi birisi olabilir manasında
--> (^ ): ile başlayan manasında
--> (*) : herşey manasında
--> ( $): ile biter anlaminda

CREATE TABLE kelimeler(
	id INT UNIQUE,
	kelime VARCHAR(50) NOT NULL,  
	Harf_sayisi INT
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5); 

-- Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdirin
SELECT * FROM kelimeler WHERE kelime ~* 'h[ai]t'

-- Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdirin
SELECT * FROM kelimeler WHERE kelime ~* 'h[a-k]t'

-- a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '^[as]'

-- m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '[mf]$'

------------------------------------------------------------------------------------
--UPPER: Bir sütundaki dataların büyük harfle yazılmasını sağlar.
--LOWER: Bir sütundaki dataların küçük harfle yazılmasını sağlar.
--INITCAP: Bir sütundaki dataların ilk harfini büyük yapar diğerlerini küçük.
------------------------------------------------------------------------------------

-- Kelimeler tablosundaki kelime sutunundaki verileri önce hepsi büyük harf,
-- sonra küçük harf ve ilk harfleri büyük harf olucak şekilde yazdıralım
SELECT UPPER(kelime) AS buyuk_harfli FROM kelimeler 

SELECT LOWER(kelime) AS kucuk_harfli FROM kelimeler

SELECT INITCAP(kelime) AS bas_harfi_buyuk FROM kelimeler

-- Musteriler tablosundan bütün isimleri büyük harf yapınız
SELECT UPPER(isim) FROM musteriler


-->Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
-->select lower(title),UPPER(isim) from personel şekilde yapabiliriz
SELECT LOWER(title),UPPER(isim) FROM personel


