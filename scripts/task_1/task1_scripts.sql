

/*1.1.	Получить полную информацию обо всех преподавателях. */
SELECT * FROM teacher;

/*1.2.	Получить полную информацию обо всех студенческих группах на специальности ЭВМ.*/
SELECT * FROM student_group 
WHERE speciality = 'ЭВМ';

/*1.3.	Получить личный номер преподавателя и номера аудиторий, в которых они преподают предмет с кодовым номером 18П.*/
SELECT DISTINCT teacher_id, audience FROM teacher_subject_group 
WHERE subject_id = '18П';



/*1.4.	Получить  номера предметов и названия предметов, которые ведет преподаватель Костин.*/

SELECT DISTINCT subject_id, subject.name 
FROM teacher_subject_group JOIN subject ON subject_id = subject.id
WHERE teacher_id = (
	SELECT id FROM teacher WHERE last_name = 'Костин'
);


/*1.5.	Получить номер группы, в которой ведутся предметы преподавателем Фроловым. */

SELECT  group_id
FROM teacher_subject_group
WHERE teacher_id = (
	SELECT id FROM teacher WHERE last_name = 'Фролов'
);

/*1.6.	Получить информацию о предметах, которые ведутся на специальности АСОИ.*/

SELECT  id, name, hours, semester
FROM subject
WHERE speciality = 'АСОИ';

/*1.7.	 Получить информацию о преподавателях, которые ведут предметы на специальности АСОИ.*/

SELECT DISTINCT teacher_id, id, last_name, chair, post, speciality, phone_number 
FROM teacher_subject_group JOIN teacher ON teacher_id = teacher.id
WHERE subject_id in (
	SELECT id FROM subject WHERE speciality = 'АСОИ'
);

/*1.8.	Получить фамилии преподавателей, которые ведут предметы в 210 аудитории.*/

SELECT DISTINCT  last_name
FROM teacher
WHERE id in (
	SELECT teacher_id FROM teacher_subject_group WHERE audience = 210
);

/*1.9.	Получить названия предметов и названия групп, которые ведут занятия в аудиториях с 100 по 200. */

SELECT DISTINCT student_group.name, subject.name 
FROM teacher_subject_group 
JOIN student_group ON group_id = student_group.id
JOIN subject ON subject_id = subject.id 
WHERE audience BETWEEN 100 AND 200;

/*1.10.	Получить пары номеров групп с одной специальности.*/

SELECT t1.id, t2.id FROM student_group t1, student_group t2
WHERE t1.speciality = t2.speciality AND t1.id > t2.id;



/*1.11.	Получить общее количество студентов, обучающихся на специальности ЭВМ.*/

SELECT SUM(student_count)
FROM student_group
where speciality = 'ЭВМ';

/*1.12.	Получить номера преподавателей, обучающих студентов по специальности ЭВМ.*/

SELECT DISTINCT teacher_id
FROM teacher_subject_group
WHERE group_id in (
	SELECT id FROM student_group WHERE speciality = 'ЭВМ'
);

/*1.13.	Получить номера предметов, изучаемых всеми студенческими группами.*/

SELECT subject_id FROM teacher_subject_group
GROUP BY subject_id
HAVING COUNT(subject_id) = (SELECT COUNT(id) FROM student_group);

/*1.14.	Получить фамилии преподавателей, преподающих те же предметы, что и преподаватель преподающий предмет с номером 14П.*/
SELECT DISTINCT last_name FROM teacher WHERE id in (
	SELECT DISTINCT teacher_id FROM teacher_subject_group WHERE subject_id in (
		SELECT DISTINCT subject_id FROM teacher_subject_group WHERE teacher_id in (
			SELECT teacher_id FROM teacher_subject_group WHERE subject_id = '14П'
		)
	)
);


/*1.15.	Получить информацию о предметах, которые не ведет преподаватель с личным номером 221П.*/

SELECT DISTINCT subject.id, subject.name, hours, speciality, semester FROM subject
JOIN teacher_subject_group ON subject.id = teacher_subject_group.subject_id
WHERE teacher_id != '221Л';

/*1.16.	 Получить информацию о предметах, которые не изучаются в группе М-6.*/

SELECT DISTINCT subject.id, subject.name, hours, speciality, semester FROM subject
JOIN teacher_subject_group ON subject.id = teacher_subject_group.subject_id
WHERE group_id != (
	SELECT id FROM student_group WHERE name = 'М-6'
);

/*1.17.	Получить информацию о доцентах, преподающих в группах 3Г и 8Г.*/
SELECT * FROM teacher WHERE id IN (
	SELECT DISTINCT teacher_id FROM teacher_subject_group where group_id = '3Г' or group_id = '8Г'
) AND chair = 'Доцент';


/*1.18.	 Получить номера предметов, номера преподавателей, номера групп, в которых ведут занятия преподаватели с кафедры ЭВМ, имеющих специальность АСОИ.*/
SELECT subject_id, teacher_id, group_id FROM teacher_subject_group WHERE teacher_id in (
	SELECT id FROM teacher WHERE post = 'ЭВМ' AND speciality like 'АСОИ%'
);

/*1.19.	Получить номера групп с такой же специальностью, что и специальность преподавателей.*/
SELECT DISTINCT group_id, teacher_id FROM teacher_subject_group
JOIN teacher ON teacher.id = teacher_id
JOIN student_group ON student_group.id = group_id
WHERE teacher.speciality = student_group.speciality;

/*1.20.	 Получить номера преподавателей с кафедры ЭВМ, преподающих предметы по специальности, совпадающей со специальностью студенческой группы. */
SELECT DISTINCT teacher_id FROM teacher_subject_group
JOIN teacher ON teacher.id = teacher_id
JOIN student_group ON student_group.id = group_id
JOIN subject ON subject.id = subject_id
WHERE teacher.speciality = 'ЭВМ' and subject.speciality = student_group.speciality;

/*1.21.	Получить специальности студенческой группы, на которых работают преподаватели кафедры АСУ.*/
SELECT DISTINCT student_group.speciality FROM student_group
JOIN teacher_subject_group ON group_id = student_group.id
JOIN teacher ON teacher.id = teacher_subject_group.teacher_id
WHERE teacher.speciality LIKE '%АСОИ%';

/*1.22.	Получить номера предметов, изучаемых группой АС-8.*/
SELECT subject_id FROM teacher_subject_group WHERE group_id IN (
	SELECT id from student_group WHERE name = 'АС-8'
);

/*1.23.	Получить номера студенческих групп, которые изучают те же предметы, что и студенческая группа АС-8.*/
SELECT DISTINCT group_id FROM teacher_subject_group WHERE subject_id in (
	SELECT DISTINCT subject_id FROM teacher_subject_group WHERE group_id IN(
		SELECT id from student_group WHERE name = 'АС-8'
	)
);



/*1.24.	Получить номера студенческих групп, которые не изучают предметы, преподаваемых в студенческой группе АС-8.*/
SELECT DISTINCT group_id FROM teacher_subject_group WHERE subject_id not in (
	SELECT DISTINCT subject_id FROM teacher_subject_group WHERE group_id IN(
		SELECT id from student_group WHERE name = 'АС-8'
	)
);
    
/*1.25.	Получить номера студенческих групп, которые не изучают предметы, преподаваемых преподавателем 430Л.*/
SELECT DISTINCT group_id FROM teacher_subject_group WHERE group_id not in (
	SELECT DISTINCT group_id FROM teacher_subject_group WHERE teacher_id = '430Л'
);

/*1.26.	Получить номера преподавателей, работающих с группой Э-15, но не преподающих предмет 12П.*/
SELECT teacher_id FROM teacher_subject_group
JOIN student_group ON student_group.id = teacher_subject_group.group_id
WHERE student_group.name = 'Э-15' AND teacher_subject_group.subject_id != '12П';

