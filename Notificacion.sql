/* genearar una notificacion cuando un elemento de el detalle de la factura ha sido actualizado */

ALTER PROCEDURE Actualiza_factura
@ProductId int ,
@OrderID int ,
@UnitPrice money,
@Quantity int,
@Discount float
AS 
	BEGIN
	Declare @username varchar(20)
	Set @username = SUSER_SNAME()
	UPDATE [Order Details] SET UnitPrice = @UnitPrice,
								Quantity = @Quantity,
								Discount = @Discount
								WHERE ProductID = @ProductId  AND OrderID = @OrderID
		
		raiserror(50070, 1,1,@OrderID ,@ProductId, @username)
	END
	


----OrderID - ProductID - Login(que realiza la actualizacion)

--Creando Notificacion personalizada
sp_addmessage 50070, 1, 'El registro con OrderID: %d y ProductID = %d, ha sido modificado en la tabla ''[Order Details] '' ejecutado por el usurario usuari %s',
'us_english', 'true'


raiserror(50070, 1,1,10248,15, '3M3')

EXEC Actualiza_factura 10248, 6 ,15, 20 , 0



CREATE LOGIN Contador with password = '12345'


sp_adduser Contador , Contador

USE Northwind

GRANT EXECUTE on Actualiza_factura to Contador

sp_helplogins Contador






