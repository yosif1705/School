DROP SCHEMA IF EXISTS taxi_company;
CREATE DATABASE taxi_company;
USE taxi_company;
 
CREATE TABLE address(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(100) NOT NULL
);
 
CREATE TABLE category(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(10) NOT NULL
);
 
CREATE TABLE client(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
full_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(20) NOT NULL
);
 
CREATE TABLE driver(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
age INTEGER NOT NULL,
rating FLOAT NOT NULL DEFAULT 5.5
);
 
CREATE TABLE luxury(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(50)
);
 
CREATE TABLE car(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
make VARCHAR(20) NOT NULL,
model VARCHAR(20),
`year` INTEGER DEFAULT 0 NOT NULL,
mileage INTEGER DEFAULT 0 ,
`condition` CHAR NOT NULL,
category_id INTEGER NOT NULL,
luxury_id INTEGER NOT NULL,
CONSTRAINT `fk_cars_category`
FOREIGN KEY (category_id) REFERENCES category(id),
CONSTRAINT `fk_cars_luxury`
FOREIGN KEY (luxury_id) REFERENCES luxury(id)
);
 
CREATE TABLE course(
id INTEGER PRIMARY KEY AUTO_INCREMENT,
from_address_id INTEGER NOT NULL,
start DATETIME NOT NULL,
bill DECIMAL(10,2) DEFAULT 10,
car_id INTEGER NOT NULL,
client_id INTEGER NOT NULL,
done varchar(30) DEFAULT 'no',
CONSTRAINT `fk_courses_addresses`
FOREIGN KEY (from_address_id) REFERENCES address(id),
CONSTRAINT `fk_courses_cars`
FOREIGN KEY (car_id) REFERENCES car(id),
CONSTRAINT `fk_courses_clients`
FOREIGN KEY (client_id) REFERENCES client(id)
);
 
CREATE TABLE car_driver(
car_id INTEGER NOT NULL,
driver_id INTEGER NOT NULL,
CONSTRAINT `pk_cars_drivers`
PRIMARY KEY(car_id,driver_id),
CONSTRAINT `fk_cars_drivers_cars`
FOREIGN KEY (car_id) REFERENCES car(id),
CONSTRAINT `fk_cars_drivers_drivers`
FOREIGN KEY (driver_id) REFERENCES driver(id)
);
 
INSERT INTO address (`name`)
VALUES
('ул. Горна Баня 560, Варна'),
('ул. Бенковска 23, София'),
('ул. Зора 10, Враца'),
('ул. Барутен Погреб 33, София'),
('ул. Иван Вазов 2, София'),
('ул. Джоу Байдън 420, Варна'),
('ул. Селски Щницел 33, София'),
('ул. Сомчо Куцоненов, Варна'),
('ул. Саламандър 23, Перник'),
('ул. Калъфово 12, София');
 
 
INSERT INTO category (`name`) 
VALUES
('Хечбек'),
('Купе'),
('Кабриолет'),
('Седан'),
('Джип');
 
 
INSERT INTO client (full_name, phone_number) 
VALUES
('Герасим Вазев', '0893765801'),
('Георги Иванов', '0883322115'),
('Александър Пръчков', '0881239875'),
('Йоан Василев', '0889548234'),
('Виктория Седелова', '08812352341'),
('Гергана Маркова', '0982916404'),
('Пламен Огнянов', '0885756557'),
('Ивет Вазова', '0987459411'),
('Христо Ботев', '0883735520'),
('Дамяна Гошева', '0984350411');
 
 
 
INSERT INTO driver (first_name, last_name, age, rating) 
VALUES
('Драгомир' , 'Недялков' , 40 , 3.3),
('Виктория' , 'Сланинкова' , 54 , 1.5),
('Август' , 'Самсонов' , 38 , 9.2),
('Надежда' , 'Нейкова' , 48 , 7.5),
('Роси' , 'Шестакова' , 54 , 9.0),
('Владимир' , 'Келешев' , 42 , 3.7),
('Велислав' , 'Гьоков' , 43 , 3.2),
('Милко' , 'Четрафилсков' , 19 , 6.9),
('Христомир' , 'Милачков' , 60 , 4.4),
('Орлин' , 'Чанталиев' , 24 , 6.9);
 
insert into luxury (category) VALUES
('Low Class'),('Middle class'),('High class'),('Super class');
 
INSERT INTO car (make, model, `year`, mileage, `condition`, category_id, luxury_id)
VALUES
('Land Rover', 'Range Rover', 2021, 550259, 'A', 3, 3),
('GMC', 'Sierra 3500', 2012, 275538, 'A', 4, 4),
('Infiniti', 'IPL G', 2004, 12345, 'B', 1, 4),
('Pontiac', 'Grand Prix', 2020, 703642, 'C', 1, 1),
('Volkswagen', 'Touareg', 2016, 300933, 'B', 4, 2),
('Pontiac', 'Grand Prix', 2006, 676236, 'B', 5, 1),
('BMW', '745', 2001, 696455, 'C', 2, 3),
('Chevrolet', 'S10', 2015, 529397, 'C', 2, 3),
('Toyota', 'Yaris', 2013, 832895, 'B', 2, 1),
('Volkswagen', 'Passat', 2002, 62139, 'C', 1, 2);
 
INSERT INTO course (from_address_id, `start`, car_id, client_id, bill, done)
VALUES
(1, '2020-01-01 01:26:11', 10, 1, 46.92, 'yes'),
(2, '2020-04-26 17:51:13', 9, 2, 14.47, 'yes'),
(3, '2020-02-18 14:00:01', 8, 3, 44.01, 'yes'),
(4, '2020-03-22 04:23:48', 7, 4, 24.24, 'yes'),
(5, '2021-04-17 12:30:28', 6, 5, 45.83, 'yes'),
(6, '2020-09-21 22:50:50', 5, 6, 18.23, 'yes'),
(7, '2020-10-16 04:58:11', 4, 7, 21.93, 'yes'),
(8, '2020-01-13 05:32:42', 3, 8, 21.56, 'yes'),
(9, '2020-02-06 22:32:14', 2, 9, 40.49, 'yes'),
(10, '2020-06-06 22:44:50', 1, 10, 15.56, 'yes');


INSERT INTO car_driver (car_id, driver_id) 
VALUES
(1, 10),
(2, 9),
(3, 8),
(4, 7),
(5, 6),
(6, 5),
(7, 4),
(8, 3),
(9, 2),
(10, 1);

--------------------
-- SELECT QUERIES --

SELECT bill FROM course;

SELECT CONCAT(d.first_name,' ',d.last_name) AS `Name`, d.rating,CONCAT(ca.make,' ',ca.model) AS `Car`,c.done,a.`name` AS address FROM course c 
JOIN car ca ON c.car_id=ca.id
JOIN car_driver cd ON cd.car_id=ca.id
JOIN driver d ON d.id=cd.driver_id
JOIN address a ON a.id=c.from_address_id
WHERE c.done='yes';

SELECT CONCAT(d.first_name,' ',d.last_name) AS `Name`, SUM(c.bill) AS 'Monthly money' FROM course c 
JOIN car ca ON c.car_id=ca.id
JOIN car_driver cd ON cd.car_id=ca.id
JOIN driver d ON d.id=cd.driver_id
WHERE month(c.`start`)=10
GROUP BY d.id;

select d.*, c.done from driver d
JOIN car_driver cd ON cd.driver_id=d.id
JOIN car ca ON ca.id=cd.car_id
JOIN course c ON c.car_id=ca.id
WHERE c.done='yes';

SELECT CONCAT(c.make,' ',c.model) AS Car,c.`year`,c.mileage,c.`condition`,ca.`name`,l.category from car c
JOIN category ca ON ca.id=c.category_id
JOIN luxury l ON l.id=c.luxury_id;
