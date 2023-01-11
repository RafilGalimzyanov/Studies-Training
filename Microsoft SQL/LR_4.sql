CREATE TABLE Workers
(
	person_number INT UNIQUE,
	surname VARCHAR(20) NOT NULL,
	position VARCHAR(30) NOT NULL,
	experience FLOAT DEFAULT 0,
	PRIMARY KEY(person_number)
);

CREATE TABLE Projects
(
	project_code INT UNIQUE,
	title VARCHAR(30) NOT NULL,
	"start date" DATE,
	price FLOAT CHECK(price > 0),
	PRIMARY KEY(project_code)
);

CREATE TABLE Participations
(
	worker INT NOT NULL,
	project INT FOREIGN KEY REFERENCES Projects(project_code),
	duration INT CHECK(duration >0),
	work_price INT NOT NULL
);

INSERT INTO Workers (person_number, surname, position, experience)
VALUES 
(1, 'Хисматуллин', 'Директор', 20),
(2, 'Петров', 'Программист', 5),
(3, 'Сидоров', 'Программист', 3),
(4, 'Васютин', 'Программист', 2),
(5, 'Докудовский', 'Программист', 1),
(6, 'Иванов', 'Программист', 1),
(7, 'Марков', 'Инженер', 2),
(8, 'Загиров', 'Инженер', 6),
(9, 'Горшкова', 'Инженер', 4),
(10, 'Сафиуллин', 'Инженер', 5),
(11, 'Кислинский', 'Инженер', 5),
(12, 'Санников', 'Инженер', 3),
(13, 'Емельянов', 'Проектировщик', 3),
(14, 'Астраханцева', 'Проектировщик', 3),
(15, 'Александров', 'Проектировщик', 6),
(16, 'Буньков', 'Проектировщик', 7),
(17, 'Тукбаев', 'Конструктор', 8),
(18, 'Алакшин', 'Конструктор', 4),
(19, 'Смирнов', 'Конструктор', 2),
(20, 'Ямолдин', 'Конструктор', 7);

INSERT INTO Projects
VALUES
(1, 'Арбитраж-бот', '2023-01-01', '30000'),
(2, 'Умный дом', '2022-01-16', '100000'),
(3, 'Дрон', '2019-11-06', '200000'),
(4, 'Лазер', '2018-06-01', '600000'),
(5, 'ПО 1', '2013-01-01', '900000'),
(6, 'ПО 2', '2015-01-01', '800000'),
(7, 'ПО 3', '2016-01-01', '800000'),
(8, 'Софт информационной защиты', '2018-01-01', '100000'),
(9, 'Чат бот', '2013-01-01', '30000'),
(10, 'Микроконтроллер ПО', '2015-01-01', '100000'),
(11, 'Спектрометр ПО', '2016-01-01', '900000'),
(12, 'Усилитель сигнала', '2017-01-01', '50000'),
(13, 'Шумоподавление', '2018-01-01', '50000'),
(14, 'Фурье преобразования', '2019-01-01', '60000'),
(15, 'Численное решение ПО', '2020-01-01', '70000'),
(16, 'Шумомер ПО', '2021-01-01', '70000'),
(17, 'Сигнализация', '2022-01-01', '100000'),
(18, 'Машинное зрение', '2022-01-01', '1000000'),
(19, 'Автопилот', '2014-01-01', '1000000'),
(20, 'Бортовой компьютер', '2019-01-01', '200000');

INSERT INTO Participations
VALUES
(1, 20, 10, 20000),
(1, 19, 8, 15000),
(1, 16, 20, 40000),
(2, 18, 13, 20000),
(2, 17, 40, 30000),
(3, 17, 50, 20000),
(3, 16, 20, 15000),
(4, 15, 22, 18000),
(4, 14, 15, 19000),
(5, 14, 16, 20000),
(6, 13, 12, 25000),
(7, 12, 8, 16000),
(8, 11, 8, 19000),
(9, 10, 18, 20000),
(10, 9, 11, 30000),
(10, 8, 9, 12000),
(11, 8, 10, 40000),
(12, 7, 13, 40000),
(13, 6, 13, 40000),
(14, 6, 14, 40000),
(15, 5, 18, 370000),
(16, 4, 16, 34000),
(17, 4, 11, 32000),
(18, 3, 7, 32000),
(19, 2, 19, 80000),
(20, 1, 17, 60000);

-- LR4

SELECT person_number, surname, position, experience, project
FROM Workers
INNER JOIN Participations
ON worker = person_number;

SELECT title, [start date], surname, price
FROM Projects
INNER JOIN Participations
ON project = project_code
INNER JOIN Workers
ON worker = person_number;

SELECT person_number, surname, position, experience, project_code, price
FROM Workers
LEFT JOIN Participations
ON person_number = worker
LEFT JOIN Projects
ON project_code = project;

SELECT project_code, title, [start date], price, person_number, duration
FROM Projects
LEFT JOIN Participations
ON project_code = project
LEFT JOIN Workers
ON worker = person_number;

SELECT surname, title, duration, price
FROM Projects
LEFT JOIN Participations
ON project_code = project
RIGHT JOIN Workers
ON worker = person_number;

SELECT person_number, surname, position, experience, project_code, price
FROM Workers
LEFT JOIN Participations
ON worker = person_number
LEFT JOIN Projects
ON project_code = project;

SELECT person_number
FROM Workers AS W
JOIN Participations AS P
ON W.person_number = P.worker
WHERE P.project = 1 AND P.project = 3;

SELECT W.surname, Pr.title, 
Pr.price AS 'Оплата, руб', Pr.price/70 AS 'Оплата, $', Pr.price/80 AS 'Оплата, евро'
FROM Workers AS W
LEFT JOIN Participations AS P
ON P.worker = W.person_number
LEFT JOIN Projects AS Pr
ON Pr.project_code = P.project;

SELECT W.surname, COUNT(*) AS 'Количество проектов'
FROM Workers AS W
LEFT JOIN Participations AS P
ON P.worker = W.person_number
LEFT JOIN Projects AS Pr
ON Pr.project_code = P.project
GROUP BY surname;

SELECT AVG(Pr.price) AS 'Средняя стоимость проектов Иванова'
FROM Workers AS W
LEFT JOIN Participations AS P
ON P.worker = W.person_number
LEFT JOIN Projects AS Pr
ON Pr.project_code = P.project
WHERE W.surname = 'Иванов';

SELECT * 
FROM Workers AS W
WHERE W.experience > (
SELECT experience
FROM Workers
WHERE surname = 'Александров'
);

SELECT *
FROM Projects AS Pr
WHERE Pr.price >= (
SELECT AVG(price)
FROM Projects
);

SELECT W.surname, Pr.title, Pr.price
FROM Workers AS W
LEFT JOIN Participations AS P
ON P.worker = W.person_number
LEFT JOIN Projects AS Pr
ON Pr.project_code = P.project
WHERE Pr.price = (
SELECT MAX(price)
FROM Projects
);

SELECT W.surname
FROM Workers AS W
LEFT JOIN Participations AS P
ON P.worker = W.person_number
LEFT JOIN Projects AS Pr
ON Pr.project_code = P.project
WHERE P.project = 0;

SELECT W.surname
FROM Workers AS W
WHERE W.experience >= ALL (
SELECT experience
FROM Workers
);

SELECT *
FROM Projects AS Pr
WHERE Pr.[start date] > ANY (
SELECT [start date]
FROM Projects
);

SELECT *
FROM Workers AS W
WHERE W.person_number IN (
SELECT worker
FROM Participations
);

SELECT *
FROM Workers AS W
WHERE W.person_number NOT IN (
SELECT worker
FROM Participations
);

SELECT Pr.title
FROM Projects AS Pr
LEFT JOIN Participations AS P
ON P.project = Pr.project_code
LEFT JOIN Workers AS W
ON W.person_number = P.worker
WHERE W.experience > 10;