DELIMITER $$
CREATE PROCEDURE
`ClientByName`(IN linea_customerName varchar(50))
BEGIN
  	declare line varchar (50);
  	declare contador int default 0;
    set line =concat(linea_customerName,"%");
    select count(*) into contador from customers where customerName like line;
    select contador;
END$$
DELIMITER ;