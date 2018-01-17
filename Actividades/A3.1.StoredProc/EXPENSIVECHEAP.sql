DELIMITER $$
CREATE PROCEDURE
`ExpensiveCheap`()
BEGIN

DECLARE BARATO VARCHAR(50);
DECLARE CARO VARCHAR(50);
Select productname into Barato from products varato
order by buyPrice DESC LIMIT 1;

Select productname into Caro from products  caro
order by buyPrice ASC LIMIT 1;
SELECT BARATO, CARO;
	
END$$
DELIMITER ;