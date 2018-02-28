#MYSQL

#1.-
#༼ つ ◕_◕ ༽つ LELEL
#2.-

	CREATE TABLE `sakila`.`LOG_FILM` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`tipo` VARCHAR(45) NULL DEFAULT 'UPDATE',
		`filmId` VARCHAR(45) NULL,
		`last_value` VARCHAR(45) NULL,
		`new_Value` VARCHAR(45) NULL,
		`Timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY (`id`));

#3.- 
	USE `sakila`;
	DROP procedure IF EXISTS `logger`;

	DELIMITER $$
	USE `sakila`$$
	CREATE DEFINER=`root`@`localhost` PROCEDURE `logger`(in fid INT, in nvalue INT, in lvalue INT)
	BEGIN
		declare filmid  int;
		declare nv  INT;
		declare lv  INT;
		
		set filmid = fid;
		set nv = nvalue;
		set lv = lvalue;
		insert into LOG_FILM (filmid, last_value, new_Value) values (filmid,lv, nv);
	END$$

	DELIMITER ;
	
#4.-

	DELIMITER $$

	create trigger cambiador
	AFTER UPDATE 
		ON  FILM for each row
		BEGIN
			call logger(new.film_id, old.original_language_id, new.original_language_id);
		END$$
		
	DELIMITER; 
	
#5.-

	DELIMITER $$
	CREATE PROCEDURE lenguajesOriginales()
		BEGIN
			DECLARE done int DEFAULT FALSE;
			DECLARE ID int;
			DECLARE CUR CURSOR FOR SELECT film_id FROM film;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
			OPEN cur;
			read_loop: LOOP
				FETCH cur INTO id;
				if done then
					leave read_loop;
				END IF;
				IF (SELECT CATEGORY_ID FROM FILM_CATEGORY WHERE FILM_ID = ID) = 6 THEN UPDATE FILM SET ORIGINAL_LANGUAGE_ID = 2 WHERE FILM_ID = ID;
				ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = id AND actor_id = 3) = 1 THEN UPDATE film SET ORIGINAL_LANGUAGE_ID = 4 WHERE film_id = id;
				ELSEIF (SELECT CATEGORY_ID FROM film_category WHERE film_id = id) = 9 THEN UPDATE film SET ORIGINAL_LANGUAGE_ID = 3 WHERE film_id = id;
				ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = id AND actor_id = 31) = 1 THEN UPDATE film SET ORIGINAL_LANGUAGE_ID = 6 WHERE film_id = id;
	            ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = id AND actor_id = 34) = 1 THEN UPDATE film SET ORIGINAL_LANGUAGE_ID = 5 WHERE film_id = id;
				ELSE UPDATE film SET ORIGINAL_LANGUAGE_ID = 1 WHERE film_id = id;
				END IF;
			END LOOP;
			CLOSE cur;
		END $$
	DELIMITER;
	
#DB2
#6.-


CREATE TABLE maryGomitas(id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),nombre VARCHAR(150) NOT NULL,precio DECIMAL(10,6) NOT NULL,cstart DATE NOT NULL,cend DATE NOT NULL,period business_time(cstart, cend),PRIMARY KEY(ID, business_time WITHOUT overlaps));

INSERT INTO gomitas (nombre, precio, cstart, cend) VALUES('g1', 12, '2018-1-1', '2019-1-1'),('g2', 20, '2018-1-1', '2019-1-1'),('g3', 4, '2018-1-1', '2019-1-1'),('g4', 19, '2018-1-1', '2019-1-1'),('g5', 76, '2018-1-1', '2019-1-1'),('g6', 110, '2018-1-1', '2019-1-1'),('g7', 131, '2018-1-1', '2019-1-1'),('g8', 124, '2018-1-1', '2019-1-1'),('g9', 133, '2018-1-1', '2019-1-1'),('g10', 114, '2018-1-1', '2019-1-1'),('g11', 115, '2018-1-1', '2019-1-1'),('g12', 416, '2018-1-1', '2019-1-1');

UPDATE maryGomitas
FOR PORTION OF BUSINESS_TIME FROM '2018-2-1' to '2019-1-1' SET PRICE = PRICE*1.45;
UPDATE maryGomitas FOR PORTION OF BUSINESS_TIME FROM '2018-2-15' to '2019-1-1' SET PRICE = (PRICE/1.45)*1.1;
UPDATE maryGomitas FOR PORTION OF BUSINESS_TIME FROM '2018-4-25' to '2019-1-1' SET PRICE = PRICE*1.45;
UPDATE maryGomitas FOR PORTION OF BUSINESS_TIME FROM '2018-5-5' to '2019-1-1' SET PRICE = (PRICE/1.45)*1.1;
UPDATE maryGomitas FOR PORTION OF BUSINESS_TIME FROM '2018-10-25' to '2019-1-1' SET PRICE = PRICE*1.45;
UPDATE maryGomitas FOR PORTION OF BUSINESS_TIME FROM '2018-11-5' to '2019-1-1' SET PRICE = (PRICE/1.45)*1.1;
SELECT * from gomitas WHERE NAME='g8';
SELECT SUM(PRICE)/COUNT(*) as AVG from gomitas WHERE NAME='g8';
SELECT MAX(PRICE) as MAX from maryGomitas WHERE NAME='g8';
SELECT MIN(PRICE) as MAX from maryGomitas WHERE NAME='g8';
	


