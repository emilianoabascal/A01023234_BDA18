DELIMITER $$
CREATE PROCEDURE
`COUNTCUSTUMERS`()
BEGIN
	declare contador int default 0;
	SELECT count(*) into contador from customers;
    select contador;
END$$
DELIMITER ;