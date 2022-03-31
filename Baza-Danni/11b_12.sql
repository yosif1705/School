DROP DATABASE IF EXISTS `TaxiCompany`;
CREATE DATABASE `TaxiCompany`;
USE `TaxiCompany`;

CREATE TABLE address(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(128) NOT NULL
);

CREATE TABLE category(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(16) NOT NULL
);

CREATE TABLE client(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(64) NOT NULL,
	phone_number VARCHAR(64) NOT NULL
);

CREATE TABLE experience(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    driving_years INTEGER NOT NULL,
    category VARCHAR(3) NOT NULL
);

CREATE TABLE driver(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(32) NOT NULL,
	last_name VARCHAR(32) NOT NULL,
	age INTEGER NOT NULL,
	rating FLOAT NOT NULL DEFAULT 0.0,
    experience_id INTEGER NOT NULL,
    
    CONSTRAINT `fk_driver_experience` FOREIGN KEY (experience_id) REFERENCES experience(id)
);

CREATE TABLE car(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	make VARCHAR(32) NOT NULL,
	model VARCHAR(32),
	`year` INTEGER DEFAULT 0 NOT NULL,
	mileage INTEGER DEFAULT 0 ,
	`condition` CHAR NOT NULL,
	category_id INTEGER NOT NULL,
	
    CONSTRAINT `fk_car_category` FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE TABLE payment_type(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(128) NOT NULL
);

CREATE TABLE course(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	from_address_id INTEGER NOT NULL,
	start DATETIME NOT NULL,
	car_id INTEGER NOT NULL,
	client_id INTEGER NOT NULL,
    payment_type_id INTEGER NOT NULL,
    bill DECIMAL(10,2) DEFAULT 0,
	
    CONSTRAINT `fk_course_address` FOREIGN KEY (from_address_id) REFERENCES address(id),
	CONSTRAINT `fk_course_car` FOREIGN KEY (car_id) REFERENCES car(id),
	CONSTRAINT `fk_course_client` FOREIGN KEY (client_id) REFERENCES client(id),
    CONSTRAINT `fk_course_payment_type` FOREIGN KEY (payment_type_id) REFERENCES payment_type(id)
);

CREATE TABLE car_driver(
	car_id INTEGER NOT NULL,
	driver_id INTEGER NOT NULL,
	
    CONSTRAINT `pk_car_driver` PRIMARY KEY(car_id,driver_id),
	CONSTRAINT `fk_car_driver_car` FOREIGN KEY (car_id) REFERENCES car(id),
	CONSTRAINT `fk_car_driver_driver` FOREIGN KEY (driver_id) REFERENCES driver(id)
);

INSERT INTO address (`name`)
VALUES
('24402 Warner Place'),
('4 La Follette Plaza'),
('700 Monterey Avenue'),
('93124 Comanche Way'),
('57659 Karstens Junction'),
('361 Caliangt Court'),
('88941 Starling Drive'),
('34 Briar Crest Crossing'),
('2 Cascade Lane'),
('40 Havey Road');


INSERT INTO category (`name`) 
VALUES
('Hatchback'),
('Coupe'),
('Cabrio'),
('Sedan'),
('SUV');

INSERT INTO experience (driving_years, category)
VALUES
(10,'B1'),
(12,'B1'),
(17,'B'),
(7,'B'),
(15,'B1'),
(18,'B1'),
(5,'B'),
(32,'B1'),
(1,'B'),
(33,'B1');

INSERT INTO client (full_name, phone_number) 
VALUES
('Kalindi Keningham', '(704) 2502909'),
('Lois Leidl', '(933) 4279635'),
('Casi Farens', '(933) 4275652'),
('Janna Kellert', '(353) 9465732'),
('Conny Barnwille', '(603) 3665240'),
('Pierrette Dunmuir', '(259) 2916404'),
('Jasen Yeldham', '(615) 5756557'),
('Josi Hammelberg', '(481) 7459411'),
('Ursulina Partner', '(794) 3735520'),
('Meris Shale', '(842) 4350411');


INSERT INTO driver (first_name, last_name, age, rating, experience_id) 
VALUES
('Alexander', 'Jubb', 40, 3.3, 10),
('Cullan', 'Geram', 54, 1.5, 9),
('Germana', 'Emburey', 38, 9.2, 8),
('Janka', 'Loblie', 48, 7.5, 7),
('Krystal', 'Cuckson', 54, 9.0, 6),
('Susy', 'Borrel', 42, 3.7, 5),
('Saxon', 'Veldman', 43, 3.2, 4),
('Lenore', 'Romera', 19, 6.9, 3),
('Enrichetta', 'Jeremiah', 60, 4.4, 2),
('Delaney', 'Stove', 24, 6.9,1);


INSERT INTO car (make, model, `year`, mileage, `condition`, category_id)
VALUES
('Land Rover', 'Range Rover', 2021, 550259, 'A', 3),
('GMC', 'Sierra 3500', 2012, 275538, 'A', 4),
('Infiniti', 'IPL G', 2004, NULL, 'B', 1),
('Pontiac', 'Grand Prix', 2020, 703642, 'C', 1),
('Volkswagen', 'Touareg', 2016, 300933, 'B', 4),
('Pontiac', 'Grand Prix', 2006, 676236, 'B', 5),
('BMW', '745', 2001, 696455, 'C', 2),
('Chevrolet', 'S10', 2015, 529397, 'C', 2),
('Toyota', 'Yaris', 2013, 832895, 'B', 2),
('Volkswagen', 'Passat', 2002, 62139, 'C', 1);

INSERT INTO payment_type(type_name)
VALUES
('credit card'),
('cash'),
('app'),
('gift card'),
('club card');

INSERT INTO course (from_address_id, `start`, car_id, client_id, bill, payment_type_id)
VALUES
(1, '2020-01-01 01:26:11', 10, 1, 46.92, 1),
(2, '2020-04-26 17:51:13', 9, 2, 14.47, 2),
(3, '2020-02-18 14:00:01', 8, 3, 44.01, 3),
(4, '2020-03-22 04:23:48', 7, 4, 24.24, 4),
(5, '2021-04-17 12:30:28', 6, 5, 45.83, 5),
(6, '2020-09-21 22:50:50', 5, 6, 18.23, 4),
(7, '2020-10-16 04:58:11', 4, 7, 21.93, 3),
(8, '2020-01-13 05:32:42', 3, 8, 21.56, 2),
(9, '2020-02-06 22:32:14', 2, 9, 40.49, 1),
(10, '2020-06-06 22:44:50', 1, 10, 15.56 , 1);


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