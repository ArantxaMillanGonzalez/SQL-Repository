CREATE DATABASE PEDIDOS
GO

USE PEDIDOS 

 CREATE TABLE PAISES(
 paisId int not null,
 paisNombre nvarchar(40) not null)
 go


 CREATE TABLE ESTADOS (
 paisId int not null,
 edoId int not null,
 edoNombre nvarchar(30)not null, 
 edoArea nvarchar(30) not null )
 go

 CREATE TABLE CLIENTES (
 clId int not null,
 clNombre nvarchar(30) not null,
 clApellidos nvarchar(30) not null,
 clDomicilio nvarchar(50) not null,
 clrfc char(13) not null,
 paisId int not null,
 edoId int not null)
 go


CREATE TABLE EMPLEADOS(
empid int not null,
empNombre nvarchar(30) not null,
empApellidos nvarchar(30) not null,
empCelular char(10) NULL,
jefeid int null)
go


 CREATE TABLE PEDIDOS (
 folio int not null,
 fecha date not null,
 clId int not null,
 empid int not null,
 importe numeric (10,2) not null)
 go

 --pk

 ALTER TABLE PAISES ADD 
 CONSTRAINT pk_paisId PRIMARY KEY(paisId)
 GO

 ALTER TABLE ESTADOS ADD
 CONSTRAINT pk_paisId_edoId PRIMARY KEY(paisId, edoId)
 GO

 ALTER TABLE CLIENTES ADD
 CONSTRAINT PK_clId PRIMARY KEY(clId)
 GO

 ALTER TABLE EMPLEADOS ADD
 CONSTRAINT PK_empid PRIMARY KEY(empId)
 GO

 ALTER TABLE PEDIDOS ADD
 CONSTRAINT PK_folio PRIMARY KEY (folio)
 GO


 --fk
  ALTER TABLE ESTADOS ADD
 CONSTRAINT Fk_paisId FOREIGN KEY(paisId) REFERENCES PAISES(paisId)
 GO

 ALTER TABLE CLIENTES ADD
 CONSTRAINT fK_paisId_edoId FOREIGN KEY (paisId, edoId) REFERENCES ESTADOS(paisId, edoId)
 GO

 ALTER TABLE EMPLEADOS ADD
 CONSTRAINT fk_jefeId FOREIGN KEY(jefeId) REFERENCES EMPLEADOS (empid)

 
 ALTER TABLE PEDIDOS ADD
 CONSTRAINT fk_clId FOREIGN KEY (clId) REFERENCES CLIENTES(clId),
 CONSTRAINT fk_empId FOREIGN KEY (empId) REFERENCES EMPLEADOS(empId)
 GO

 --UNIQUE

 ALTER TABLE CLIENTES ADD
 CONSTRAINT u_clrfc UNIQUE(clrfc)
 GO

 ALTER TABLE EMPLEADOS ADD
 CONSTRAINT U_empCelular UNIQUE(empCelular)
 GO
 --CHECK

 ALTER TABLE PEDIDOS ADD
 CONSTRAINT CC_importe CHECK(importe>0)
 GO

 ALTER TABLE CLIENTES ADD
 CONSTRAINT CC_clrfc CHECK(LEN(clrfc)=13)
 GO

 ALTER TABLE EMPLEADOS ADD
 CONSTRAINT CC_empCelular CHECK(LEN(empCelular)=10)
 GO
