  
/*21.	Получить номера деталей, поставляемых для какого-либо проекта в Лондоне.*/

SELECT DISTINCT detail_id
FROM detail_for_project
JOIN projects ON project_id = projects.id
WHERE projects.city = 'Таллин';


/*22.	Получить номера проектов, использующих по крайней мере одну деталь, имеющуюся у поставщика П1.*/
SELECT DISTINCT project_id FROM detail_for_project WHERE detail_id = ANY (
SELECT DISTINCT detail_id FROM detail_for_project WHERE supplier_id = 'П1'
);
    
    
    
 /*3.	Получить номера поставщиков, которые обеспечивают проект ПР1.*/
SELECT DISTINCT supplier_id
FROM detail_for_project
WHERE project_id = 'ПР1';
       
 /*8.	Получить все такие тройки "номера поставщиков-номера деталей-номера проектов", для которых никакие из двух выводимых поставщиков, деталей и проектов не размещены в одном городе.*/
SELECT DISTINCT supplier_id, detail_id, project_id
FROM detail_for_project
JOIN projects ON project_id = projects.id
JOIN details ON detail_id = details.id
JOIN suppliers ON supplier_id = suppliers.id
WHERE suppliers.city != details.city AND suppliers.city != projects.city AND details.city != projects.city;


/*30.	Получить номера деталей, поставляемых для лондонских проектов.*/
SELECT DISTINCT detail_id
FROM detail_for_project
JOIN projects ON project_id = projects.id
WHERE projects.city = 'Псков';


/*12.	Получить номера деталей, поставляемых для всех проектов, обеспечиваемых поставщиком из того же города, где размещен проект.*/
SELECT DISTINCT detail_id
FROM detail_for_project
JOIN projects ON project_id = projects.id
JOIN suppliers ON supplier_id = suppliers.id
WHERE suppliers.city = projects.city;


 /*16.	Получить общее количество деталей Д1, поставляемых поставщиком П1.*/
SELECT COUNT(detail_id)
FROM detail_for_project
WHERE detail_id = 'Д1' AND supplier_id = 'П1';


/*32.	Получить номера проектов, обеспечиваемых по крайней мере всеми деталями поставщика П1.*/

SELECT DISTINCT project_id FROM detail_for_project 
WHERE detail_id IN (
	SELECT DISTINCT detail_id FROM detail_for_project 
	WHERE supplier_id = 'П1'
);

/*26.	Получить номера проектов, для которых среднее количество поставляемых деталей Д1 больше, чем наибольшее количество любых деталей, поставляемых для проекта ПР1.*/



SELECT project_id FROM detail_for_project
WHERE (
  SELECT AVG(amount) FROM detail_for_project 
  WHERE detail_id = 'Д1') > (
    SELECT MAX(amount) FROM detail_for_project 
    WHERE project_id = 'ПР1');



/*17.	Для каждой детали, поставляемой для проекта, получить номер детали, номер проекта и соответствующее общее количество.*/

SELECT  project_id, detail_id, sum(amount)
FROM detail_for_project
group by project_id, detail_id
order by project_id;
