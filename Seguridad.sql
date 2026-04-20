---Seguridad
CREATE LOGIN AdministradorVentas  WITH PASSWORD = '1234'
GO

USE Northwind
go 
sp_adduser AdministradorVentas ,AdmiVentas

GRANT SELECT ON customers to AdmiVentas WITH GRANT OPTION


CREATE LOGIN Vendedor WITH PASSWORD = '1234'

sp_adduser Vendedor , ven


REVOKE SELECT ON Customers To AdmiVentas CASCADE

CREATE ROLE  RolVenta;
GO

GRANT UPDATE , INSERT ON Orders TO RolVenta

GRANT SELECT ON Orders TO RolVenta



sp_addrolemember RolVenta , Ven


CREATE SCHEMA PRODUCCION
GO


ALTER SCHEMA PRODUCCION TRANSFER [dbo].[Order Details]
GO


SELECT * FROM PRODUCCION.Orders
go

GRANT SELECT , INSERT , UPDATE ON SCHEMA::PRODUCCION TO RolVenta






