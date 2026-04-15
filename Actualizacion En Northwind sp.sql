USE Northwind
Go
/*Realizar un prosedimiento almasenado que actualise el precio de venta en la tabla producto Notificar al 
correo electronico el id del producto , precio anterior 
precio actualizado fecha de actualizacion y el usuario */
SELECT * FROM Products

CREATE PROCEDURE sp_ActualizarPrecio
    @ProductID INT,
    @NewPrice money
AS
BEGIN
  
    DECLARE @username varchar(20) = SUSER_SNAME();
    
  
    DECLARE @precioActual money;
    SET @precioActual = (SELECT UnitPrice FROM Products WHERE ProductID = @ProductID);
    
 
    DECLARE @date DATETIME = GETDATE();

   
    UPDATE Products 
    SET UnitPrice = @NewPrice
    WHERE ProductID = @ProductID;

  
    DECLARE @strPrecioActual VARCHAR(20) = CAST(@precioActual AS VARCHAR(20));
    DECLARE @strNewPrice VARCHAR(20) = CAST(@NewPrice AS VARCHAR(20));
    DECLARE @strDate VARCHAR(30) = CONVERT(VARCHAR(30), @date, 120);


    RAISERROR(50071, 1, 1, @ProductID, @strPrecioActual, @strNewPrice, @strDate, @username);

END



	sp_addmessage 50071, 1, 'El producto con ProductID = %d, ha sido modificado
en la tabla ''[Products]'' con un precio anterior de: %s y un precio nuevo de: %s el dia: %s ejecutado por el usuario: %s',
'us_english', 'true', 'REPLACE'



SELECT GETDATE();

raiserror(50071, 1,1,1,'18','20 ', 'hoy' , '3M3')

EXEC sp_ActualizarPrecio 1 ,20

SELECT * FROM Products

ALTER LOGIN Auditor with password = '12345'

GRANT EXEC ON sp_ActualizarPrecio TO Auditor
