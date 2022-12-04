--CREATE DATABASE BATCH103; -->baska databasede olusturduk

-- tablo olusturma
CREATE TABLE students(
	student_id CHAR(5) PRIMARY KEY,
	student_name VARCHAR,
	email_adress VARCHAR NOT NULL,
	student_age NUMERIC(2) CHECK(student_age>0),
	--> NUMERIC(2)En fazla 2 rakam girilmeli
	--> CHECK(student_age>0) negatif deger almayacak
	phone_number CHAR(10) UNIQUE --> son satira ',' koymuyoruz
)

SELECT * FROM students; --> tablonun tamamini gosterir
DROP TABLE students; --> tabloyu tamemen siler
 
-- tabloya veri ekleme
INSERT INTO students VALUES('11111','Tom Hanks','th@gmail.com',15,'1234567890');  -->string olan ifadeleri '' arasina yazariz

INSERT INTO students VALUES('11111','Brad Pitt','bp@gmail.com',18,'2345678901');  
	--> daha once ayni student_id'yi girdigimiz icin error verir (primary key)
	--> SQL state: 23505 hatasi verdi. hatayi google'da artirsak hata hakkinda bilgi alabiliriz

INSERT INTO students VALUES('22222','Brad Pitt','bp@gmail.com',18,'2345678901');  

INSERT INTO students VALUES('113','Tom Hanks',null,123,'1234567890');  
	--> 113 kabul eder, cunku CHAR(5) en fazla 5 anlamindadir.
	--> email null olamaz. hata verir.
	--> yas en fazla 2 basamak olabilir, cunku NUMERIC(2) dedik. hata verir.
	--> phone_number UNIQUE dedik. daha once kullanildigi icin hata verir.
	--> konsolda hatalarin hepsini gostermez yalniz birini gosterir.

INSERT INTO students VALUES('113','Tom Hanks','th@gmail.com',12,'3456789012');  

-- istedigimiz alanlar icin tabloya veri ekleme (for specific fields)
INSERT INTO students(student_id,email_adress,phone_number) VALUES('11114','abc@gmail.com','4567890123');  
	--> once girecegimiz alanlari belirtip sonra ekledik.
	
	--> hepsine bilgi gireceksek girecegimiz verilerin siralamasi onemli.
	--> istedigimiz alanlara veri gireceksek belirtirken istedigimiz sirada yazabiliriz.
INSERT INTO students(email_adress, phone_number,student_id) VALUES('xyz@gmail.com','5678901234','11115');


-- varolan datayi guncelleme

--EXAMPLE: student id'si 113 olan veriyi 11113 yap.
UPDATE students  	       --> update yapmak icin students tablosuna gittik
SET students_id = '11113'  --> degistirmek istedigimiz son degeri girdik
WHERE student_id = '113';  --> WHERE ile student_id'si 113 olan field'a git. bu degeri degistirecegiz
						   --> SET degistirmek anlaminda
	
--EXAMPLE 2: Tom Hanks'i Antony Quinn yap.
UPDATE students 
SET student_name = 'Antony Quinn'
WHERE student_name = 'Tom Hanks';
	-->iki tom hanks'i de degistirdi

--EXAMPLE 3: bp@gmail.com'u null yap
UPDATE students
SET email_adress = null
WHERE email_adress = 'bp@gmail.com';
	--> hata verir. email_adress alani null alamaz NOT NULL kisitlamasi(constraint) verdik
	
--EXAMPLE 4: Tum student_age'leri tablodaki en buyuk yasa cevir
UPDATE students
SET student_age = (SELECT MAX(student_age) FROM students);
	-->SELECT MAX(student_age) ile student_age'deki max degeri sectik
	--> en buyuk yas 18di tum yaslar 18 oldu.

SELECT * FROM students

--EXAMPLE 5: parent tablosu olusturup; parent_id, parent_name, 
--			 student_id, parent_adress, parent_dob field'lari olusturalim
CREATE TABLE parents(
	parent_id CHAR(5) PRIMARY KEY,
	parent_name TEXT,
	student_id CHAR(5),
	parent_adress TEXT,
	parent_dob DATE
)

SELECT * FROM parents

--EXAMPLE 6: parents tablosuna 4 kayit ekle
INSERT INTO parents VALUES('21111','Mark Hanks','11111','Miami, FL','1994-10-23');
INSERT INTO parents VALUES('21112','Angoe Smith','11112','New York, USA','1987-02-20');
INSERT INTO parents VALUES('21113','John Walker','11113','Berlin, Germany','1977-12-10');
INSERT INTO parents VALUES('21114','Mary Star','11114','Istanbul, Turkey','1990-03-12');

--EXAMPLE 7: tum dogum tarihlerini minimum olana cevir.
UPDATE parents
SET parent_dob = (SELECT MIN(parent_dob) FROM parents); 


CREATE TABLE pupils(
	student_id CHAR(5) PRIMARY KEY,
	pupil_name VARCHAR,
	email_adress VARCHAR NOT NULL,
	pupil_age NUMERIC(2) CHECK(pupil_age>0),
	phone_number CHAR(10) UNIQUE,
	CONSTRAINT student_id_fk FOREIGN KEY(student_id) REFERENCES parents(parents_id) -->parents tablosuyla iliski kurduk 
	--> FOREIGN KEY(student_id) ile iliski kurmak istedigimiz field'i yazdik
	--> REFERENCES(adresi/yerini belirtiyor) ile parents tablosundan parent_id field'ini alacagimizi soyledik 
)






