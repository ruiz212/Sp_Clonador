USE Northwind
Go
/*Realizar un prosedimiento almasenado que actualise el precio de venta en la tabla producto Notificar al correo electronico el id del producto , precio anterior 
precio actualizado fecha de actualizacion y el usuario */
SELECT * FROM Products

CREATE PROCEDURE sp_ActualizarPrecio 
@ProductID INT,
@NewPrice money
AS
	BEGIN
	Declare @username varchar(20)
	Set @username = SUSER_SNAME()
	Declare @precioActual money
	set @precioActual = ( SELECT UnitPrice FROM Products where ProductID = @ProductID)



	END



	sp_addmessage 50070, 1, 'El producto con ProductID = %d, ha sido modificado en la tabla ''[Products] '' con un precio anterior  ejecutado por el usurario usuari %s',
'us_english', 'true'


