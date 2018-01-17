DELIMITER $$
CREATE PROCEDURE
`productLineFetcher`(IN ln varchar(50))
BEGIN
	declare line varchar(50);
	set line = concat(ln, "%");
  	SELECT * From products where productLine like line;
END$$
DELIMITER ;