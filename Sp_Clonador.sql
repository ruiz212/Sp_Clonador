
--creacion de la base de datos

CREATE DATABASE Repositorio;
GO

USE Repositorio;
GO


CREATE TABLE Recaudacion (
    RecaudacionID INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL,                     
    Año INT NOT NULL,
    Mes INT NOT NULL,
    Monto DECIMAL(18, 2) NOT NULL,              
    Descuento DECIMAL(18, 2) NOT NULL,          
    MontoNeto DECIMAL(18, 2) NOT NULL           
);


CREATE TABLE Detalle_Recudacion (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    RecaudacionID INT NOT NULL,               
    IdEmpleado INT NOT NULL,                  
    Monto DECIMAL(18, 2) NOT NULL,             
    Descuento DECIMAL(18, 2) NOT NULL,         
    MontoNeto DECIMAL(18, 2) NOT NULL,         
    Porcentaje DECIMAL(5, 2),                  
    CONSTRAINT FK_Recaudacion_Detalle 
    FOREIGN KEY (RecaudacionID) REFERENCES Recaudacion(RecaudacionID)
);
GO







CREATE PROCEDURE sp_CargarRepositorioMensual

AS
BEGIN
    
    DELETE FROM Detalle_Recudacion;
    DELETE FROM Recaudacion;


    INSERT INTO Recaudacion (Fecha, Año, Mes, Monto, Descuento, MontoNeto)
    SELECT 
        MIN(O.OrderDate), 
        YEAR(O.OrderDate), 
        MONTH(O.OrderDate),
        SUM(OD.UnitPrice * OD.Quantity),
        SUM((OD.UnitPrice * OD.Quantity) * OD.Discount),
        SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount))
    FROM Northwind.dbo.Orders O
    INNER JOIN Northwind.dbo.[Order Details] OD ON O.OrderID = OD.OrderID
    GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
    ORDER BY YEAR(O.OrderDate), MONTH(O.OrderDate);



    INSERT INTO Detalle_Recudacion (RecaudacionID, IdEmpleado, Monto, Descuento, MontoNeto, Porcentaje)
    SELECT 
        R.RecaudacionID,
        O.EmployeeID,
        SUM(OD.UnitPrice * OD.Quantity),
        SUM((OD.UnitPrice * OD.Quantity) * OD.Discount),
        SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)),
        (SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) / R.MontoNeto) * 100
    FROM Northwind.dbo.Orders O
    INNER JOIN Northwind.dbo.[Order Details] OD ON O.OrderID = OD.OrderID
    INNER JOIN Recaudacion R ON YEAR(O.OrderDate) = R.Año AND MONTH(O.OrderDate) = R.Mes
    GROUP BY R.RecaudacionID, O.EmployeeID, R.MontoNeto;

    PRINT 'Proceso de carga completado exitosamente.';
END
GO
 EXEC sp_CargarRepositorioMensual

 --Query de prueva tienen que dar el mismos resultado las dos
 USE Northwind
 go
 SELECT SUM(UnitPrice * Quantity * (1 - Discount)) 
FROM Northwind.dbo.[Order Details] OD
INNER JOIN Northwind.dbo.Orders O ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = 7 AND YEAR(O.OrderDate) = 1996;

use Repositorio
SELECT MontoNeto 
FROM Recaudacion 
WHERE Mes = 7 AND Año = 1996;