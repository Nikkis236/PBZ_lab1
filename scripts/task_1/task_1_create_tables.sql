CREATE DATABASE lab1;

USE lab1;


CREATE TABLE teacher (
	id VARCHAR(4) PRIMARY KEY,
    last_name VARCHAR(25),
    chair VARCHAR(25),
    post VARCHAR(25),
    speciality VARCHAR(30),
    phone_number INT
);
INSERT INTO teacher (id, last_name, chair, post, speciality, phone_number) VALUES
('221Л', 'Фролов', 'Доцент', 'ЭВМ', 'АСОИ, ЭВМ', 487 ),
('222Л', 'Костин', 'Доцент', 'ЭВМ', 'ЭВМ', 543 ),
('225Л', 'Бойко', 'Профессор', 'АСУ', 'АСОИ, ЭВМ', 112 ),
('430Л', 'Глазов', 'Ассистент', 'ТФ', 'СД', 421 ),
('110Л', 'Петров', 'Ассистент', 'Экономика', 'Международная экономика', 324 );




CREATE TABLE subject (
	id VARCHAR(3) PRIMARY KEY,
    name VARCHAR(25),
    hours INT,
    speciality VARCHAR(30),
    semester INT
);
INSERT INTO subject (id, name, hours, speciality, semester) VALUES
('12П', 'Мини ЭВМ', 36, 'ЭВМ', 1 ),
('14П', 'ПЭВМ', 72, 'ЭВМ', 2 ),
('17П', 'СУБД ПК', 48, 'АСОИ', 4 ),
('18П', 'ВКСС', 52, 'АСОИ', 6 ),
('34П', 'Физика', 30, 'СД', 6 ),
('22П', 'Аудит', 24, 'Бухучета', 3 );
 


CREATE TABLE student_group (
	id VARCHAR(3) PRIMARY KEY,
    name VARCHAR(25),
    student_count INT,
    speciality VARCHAR(30),
    headman VARCHAR(25)
);
INSERT INTO student_group (id, name, student_count, speciality, headman) VALUES
('8Г', 'Э-12', 18, 'ЭВМ', 'Иванова' ),
('7Г', 'Э-15', 22, 'ЭВМ', 'Сеткин' ),
('4Г', 'АС-9', 24, 'АСОИ', 'Балабанов' ),
('3Г', 'АС-8', 20, 'АСОИ', 'Чижов' ),
('17Г', 'С-14', 29, 'СД', 'Амросов' ),
('12Г', 'М-6', 16, 'Международная экономика', 'Трубин' ),
('10Г', 'Б-4', 21, 'Бухучета', 'Зязюткин' );



CREATE TABLE teacher_subject_group (
	group_id VARCHAR(3) REFERENCES student_group(id) ON DELETE CASCADE,
    subject_id VARCHAR(3) REFERENCES subject(id) ON DELETE CASCADE,
    teacher_id VARCHAR(4) REFERENCES teacher(id) ON DELETE CASCADE,
    audience INT
);
INSERT INTO teacher_subject_group (group_id, subject_id, teacher_id, audience) VALUES
('8Г', '12П', '222Л', 112 ), ('8Г', '14П', '221Л', 220 ), ('8Г', '17П', '222Л', 112 ),
('7Г', '14П', '221Л', 220 ), ('7Г', '17П', '222Л', 241 ), ('7Г', '18П', '225Л', 210 ),
('4Г', '12П', '222Л', 112 ), ('4Г', '18П', '225Л', 210 ), ('3Г', '12П', '222Л', 112 ),
('3Г', '17П', '221Л', 241 ), ('3Г', '18П', '225Л', 210 ), ('17Г', '12П', '222Л', 112 ),
('17Г', '22П', '110Л', 220 ), ('17Г', '34П', '430Л', 118 ), ('12Г', '12П', '222Л', 112 ),
('12Г', '22П', '110Л', 210), ('10Г', '12П', '222Л', 210 ), ('10Г', '22П', '110Л', 210 );