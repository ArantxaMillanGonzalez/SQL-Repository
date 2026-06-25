-- Creación Base de Datos

create database Cerveceria
GO

use Cerveceria

--Creacion tablas/entidades
create table Clientes (
        ClienteID int not null,
        Nombre_Cli varchar(20),
        Ap_Cli varchar(20),
        Am_Cli varchar(20),
        Fecha_nacimiento_Cli datetime,
        Correo_Cli nvarchar(30),
        Direccion_Cli varchar(50),
        Telefono_Cli char(10)
)
GO

create table Empleados(
    RFC char(13) not null,
    Nombre_Em varchar(20),
    Ap_Em varchar(20),
    Am_Em varchar(20),
    Fecha_Nacimiento_Em datetime,
    Fecha_Contratacion_Em datetime,
    Puesto varchar(20),
    Sueldo numeric(10,3),
    Telefono_Em char(10)

)
GO

create table Pedidos(
    PedidoID int not null,
    Fecha_Pedido datetime, 
    ClienteID int not null,
    RFC char(13) not null
)
GO

create table Categorias(
    CategoriaID int not null,
    Nombre_Cat varchar(20),
    Descripcion_Cat varchar(50)
)
GO

create  table Proveedores(
    ProveedorID int not null,
    Nombre_Pr varchar(20),
    Ap_Pr varchar(20),
    Am_Pr varchar(20),
    Direccion_Pr varchar(50),
    Telefono_pr char(10)
) 
GO

create table Productos(
    ProductoID int not null,
    Nombre_P varchar(20),
    Descripcion_P varchar(50),
    Stock int,
    Precio numeric(10,2),
    ProveedorID int not null,
    CategoriaID int not null
)
GO

create table DetallePedido(

    PedidoID int not null,
    ProductoID int not null,
    Descuento numeric(3,2),
    Cantidad int,
    PrecioUnitario numeric(10,2)
)
GO

 -- Constraints PKs
Alter table Clientes
ADD CONSTRAINT PK_Cliente PRIMARY KEY(ClienteID)
GO

Alter table Empleados 
ADD constraint PK_Emp PRIMARY KEY(RFC)
GO

Alter table Pedidos 
ADD CONSTRAINT PK_Pedido Primary key(PedidoID)
GO

alter table Proveedores 
ADD constraint PK_prov PRIMARY KEY(ProveedorID)
GO

alter table Categorias 
ADD CONSTRAINT PK_cat PRIMARY KEY(CategoriaID)
GO

Alter table Productos 
ADD CONSTRAINT PK_Producto PRIMARY KEY(ProductoID)
GO

Alter table DetallePedido
ADD constraint PK_Detalle primary key(PedidoID, ProductoID)
GO

--Constraints FKs 
Alter table Pedidos
ADD Constraint PK_RFC FOREIGN KEY (RFC) references Empleados(RFC),
    Constraint PK_Cliente FOREIGN KEY (ClienteID) references Clientes(ClienteID)
GO

Alter table Productos
ADD constraint FK_Prov FOREIGN KEY (ProveedorID) references Proveedores(ProveedorID),
    CONSTRAINT FK_Cat FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
GO

Alter table DetallePedido
ADD CONSTRAINT FK_Product FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    constraint FK_Pedido foreign KEY (PedidoID) REFERENCES Pedidos(PedidoID)
GO
-- Constraint Check Default Unique

Alter table Clientes
ADD constraint CK_Telefono_Cli CHECK (LEN(Telefono_Cli)=10),
    constraint CK_Mayor_Cli CHECK(datediff(yyyy, Fecha_nacimiento_Cli, getdate())>=18),
    CONSTRAINT DF_Direccion DEFAULT 'Sin domicilio' for Direccion_Cli,
    constraint UNIQUE_Telefono_cli unique(Telefono_Cli)
GO

Alter table Empleados 
    ADD constraint CK_Telefono_Em CHECK (LEN(Telefono_Em)=10),
        constraint CK_RFC_Em CHECK (LEN(RFC)=13),
        constraint CK_Mayor_Em CHECK(datediff(yyyy, Fecha_Nacimiento_Em, Fecha_Contratacion_Em)>=18),
        constraint UNIQUE_Telefono_Em unique(Telefono_Em),
        constraint DF_Puesto DEFAULT 'Vendedor' for Puesto
GO

alter table Proveedores
ADD constraint CK_Telefono_Pr CHECK (LEN(Telefono_Pr)=10),
    constraint UNIQUE_Telefono_Pr unique(Telefono_Pr)
GO

Alter table DetallePedido
ADD constraint CK_PrecioU Check(PrecioUnitario>0),
    constraint CK_Cantidad Check(Cantidad>0)
GO

Alter table Productos
ADD CONSTRAINT CK_Precio Check(Precio>0)
