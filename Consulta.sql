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


-- Inserción de Proveedores
INSERT INTO Proveedores (ProveedorID, Nombre_Pr, Ap_Pr, Am_Pr, Direccion_Pr, Telefono_Pr)
VALUES 
(1, 'Cervezas', 'Suaves', 'SA', 'Zona Industrial Norte 123', '5512345678'),
(2, 'Cervezas', 'Fuertes', 'Group', 'Parque Logístico Sur 456', '5523456789'),
(3, 'Coctelería', 'Premium', 'SAC', 'Avenida Licores 789', '5534567890'),
(4, 'Sabritas', 'Mexicanas', 'SA', 'Boulevard Snacks 234', '5545678901'),
(5, 'Agua', 'Pura', 'Vital', 'Zona Hidrológica 567', '5556789012'),
(6, 'Galletas', 'Dulces', 'SA', 'Calle Horneados 890', '5567890123'),
(7, 'Dulces', 'Tradicionales', 'SAC', 'Avenida Azucar 123', '5578901234'),
(8, 'Cigarros', 'Selectos', 'SA', 'Zona Tabacalera 456', '5589012345'),
(9, 'Refrescos', 'Gaseosos', 'Group', 'Parque Bebidas 789', '5590123456'),
(10, 'Chicles', 'Bubble', 'SA', 'Calle Gomas 321', '5501234567');

-- Inserción de Categorías 
INSERT INTO Categorias (CategoriaID, Nombre_Cat, Descripcion_Cat)
VALUES 
(1, 'Cervezas Suaves', 'Cervezas ligeras y refrescantes, bajo contenido alcohólico'),
(2, 'Cervezas Fuertes', 'Cervezas con alto contenido alcohólico y sabor intenso'),
(3, 'Coctelería', 'Bebidas espirituosas para cocteles y consumo directo'),
(4, 'Sabritas', 'Botanas y snacks salados para acompañar'),
(5, 'Agua', 'Agua purificada y mineral en diferentes presentaciones'),
(6, 'Galletas', 'Galletas dulces y saladas para cualquier ocasión'),
(7, 'Dulces', 'Confitería y dulces tradicionales mexicanos'),
(8, 'Cigarros', 'Tabaco y productos para fumadores'),
(9, 'Refrescos', 'Bebidas carbonatadas y gaseosas'),
(10, 'Chicles', 'Gomas de mascar y chicles en diferentes sabores');

-- Inserción de Productos 
INSERT INTO Productos (ProductoID, Nombre_P, Descripcion_P, Stock, Precio, ProveedorID, CategoriaID)
VALUES 
-- Categoría 1: Cervezas Suaves 
(1, 'Sol Brillante', 'Cerveza clara ligera con limón, 4.5% alcohol', 500, 45.00, 1, 1),
(2, 'Estrella Plateada', 'Cerveza pilsner refrescante, 5% alcohol', 400, 55.00, 1, 1),

-- Categoría 2: Cervezas Fuertes 
(3, 'Toro Oscuro', 'Cerveza negra intensa, 8% alcohol', 300, 75.00, 2, 2),
(4, 'Águila Dorada', 'Cerveza rubia fuerte con 7.5% alcohol', 350, 70.00, 2, 2),

-- Categoría 3: Coctelería 
(5, 'Vino Tinto Reserva', 'Vino tinto añejo, 14% alcohol, 750ml', 200, 180.00, 3, 3),
(6, 'Ron Añejo 8 años', 'Ron oscuro premium, 40% alcohol, 750ml', 150, 350.00, 3, 3),

-- Categoría 4: Sabritas 
(7, 'Papas Crujientes', 'Papas fritas con sal, 100g', 800, 25.00, 4, 4),
(8, 'Tortillas Picantes', 'Tortillas de maíz con chile, 120g', 700, 30.00, 4, 4),

-- Categoría 5: Agua 
(9, 'Agua Mineral Natural', 'Agua mineral con gas, 1.5L', 1000, 20.00, 5, 5),
(10, 'Agua Purificada', 'Agua purificada sin gas, 2L', 1200, 18.00, 5, 5),

-- Categoría 6: Galletas 
(11, 'Chocolate Delight', 'Galletas con chispas de chocolate, 150g', 600, 35.00, 6, 6),
(12, 'Galletas Saladas', 'Galletas de soda con sal, 200g', 500, 28.00, 6, 6),

-- Categoría 7: Dulces 
(13, 'Caramelos de Leche', 'Dulces tradicionales de leche quemada', 400, 15.00, 7, 7),
(14, 'Paletas de Tamarindo', 'Paletas de tamarindo con chile, 20g', 350, 12.00, 7, 7),

-- Categoría 8: Cigarros 
(15, 'Tabaco Fino Premium', 'Cigarros de tabaco selecto, caja de 20', 100, 280.00, 8, 8),
(16, 'Cigarros Mentolados', 'Cigarros con sabor a menta, caja de 10', 150, 180.00, 8, 8),

-- Categoría 9: Refrescos 
(17, 'Cola Oscura', 'Refresco de cola sabor original, 600ml', 900, 22.00, 9, 9),
(18, 'Lima Limón', 'Refresco de lima-limón carbonatado, 600ml', 800, 20.00, 9, 9),

-- Categoría 10: Chicles 
(19, 'Bubble Mentol', 'Chicles con sabor a menta y mentol', 500, 10.00, 10, 10),
(20, 'Frutas Tropicales', 'Chicles surtidos de frutas tropicales', 450, 12.00, 10, 10);

-- Inserción de Clientes
INSERT INTO Clientes (ClienteID, Nombre_Cli, Ap_Cli, Am_Cli, Fecha_nacimiento_Cli, Correo_Cli, Direccion_Cli, Telefono_Cli)
VALUES 
(1, 'Juan', 'García', 'López', '1995-03-15', 'juan.garcia@email.com', 'Calle Principal 123', '5512345678'),
(2, 'María', 'Rodríguez', 'Martínez', '1992-07-22', 'maria.rodriguez@email.com', 'Avenida Central 456', '5523456789'),
(3, 'Carlos', 'Hernández', 'Pérez', '1998-11-05', 'carlos.hernandez@email.com', 'Calle Secundaria 789', '5534567890'),
(4, 'Ana', 'López', 'García', '1990-09-10', 'ana.lopez@email.com', 'Boulevard Norte 234', '5545678901'),
(5, 'Pedro', 'Martínez', 'Sánchez', '1993-05-20', 'pedro.martinez@email.com', 'Calle Este 567', '5556789012'),
(6, 'Laura', 'Pérez', 'Rodríguez', '1996-12-01', 'laura.perez@email.com', 'Avenida Sur 890', '5567890123'),
(7, 'Miguel', 'Sánchez', 'López', '1994-08-15', 'miguel.sanchez@email.com', 'Calle Oeste 123', '5578901234'),
(8, 'Isabel', 'Gómez', 'Fernández', '1997-04-25', 'isabel.gomez@email.com', 'Boulevard Sur 456', '5589012345'),
(9, 'Jorge', 'Fernández', 'Gómez', '1991-06-30', 'jorge.fernandez@email.com', 'Avenida Norte 789', '5590123456'),
(10, 'Sofia', 'Díaz', 'Pérez', '1999-02-14', 'sofia.diaz@email.com', 'Calle Principal 321', '5501234567');

-- Inserción de Empleados 
INSERT INTO Empleados (RFC, Nombre_Em, Ap_Em, Am_Em, Fecha_Nacimiento_Em, Fecha_Contratacion_Em, Puesto, Sueldo, Telefono_Em)
VALUES 
('GAML850313HDF', 'Luis', 'García', 'Martínez', '1985-03-13', '2015-06-01', 'Gerente', 15000.500, '5511111111'),
('RODM920721HDF', 'Ana', 'Rodríguez', 'Díaz', '1992-07-21', '2018-09-15', 'Vendedor', 8000.000, '5522222222'),
('HEPA880405HDF', 'Carlos', 'Hernández', 'Páez', '1988-04-05', '2016-11-01', 'Vendedor', 7500.000, '5533333333'),
('LOGA950812HDF', 'María', 'López', 'García', '1995-08-12', '2019-03-10', 'Vendedor', 7000.000, '5544444444'),
('PELA870925HDF', 'Roberto', 'Pérez', 'Lara', '1987-09-25', '2017-07-01', 'Supervisor', 12000.000, '5555555555'),
('SAZA900102HDF', 'Laura', 'Sánchez', 'Zavala', '1990-01-02', '2018-12-01', 'Vendedor', 7500.000, '5566666666'),
('GOFA910311HDF', 'Jorge', 'Gómez', 'Fajardo', '1991-03-11', '2019-08-15', 'Vendedor', 7000.000, '5577777777'),
('FELA930514HDF', 'Patricia', 'Fernández', 'Lozano', '1993-05-14', '2020-01-20', 'Vendedor', 7200.000, '5588888888'),
('DIPA940617HDF', 'Miguel', 'Díaz', 'Palacios', '1994-06-17', '2019-10-01', 'Vendedor', 7800.000, '5599999999'),
('MORA950718HDF', 'Isabel', 'Moreno', 'Ramos', '1995-07-18', '2020-04-15', 'Vendedor', 7000.000, '5500000000');

-- Inserción de Pedidos
INSERT INTO Pedidos (PedidoID, Fecha_Pedido, ClienteID, RFC)
VALUES 
(1, '2024-01-15 10:30:00', 1, 'GAML850313HDF'),
(2, '2024-01-16 11:45:00', 2, 'RODM920721HDF'),
(3, '2024-01-17 09:20:00', 3, 'HEPA880405HDF'),
(4, '2024-01-18 14:15:00', 4, 'LOGA950812HDF'),
(5, '2024-01-19 16:30:00', 5, 'PELA870925HDF'),
(6, '2024-01-20 10:00:00', 6, 'SAZA900102HDF'),
(7, '2024-01-21 12:20:00', 7, 'GOFA910311HDF'),
(8, '2024-01-22 15:45:00', 8, 'FELA930514HDF'),
(9, '2024-01-23 11:30:00', 9, 'DIPA940617HDF'),
(10, '2024-01-24 13:15:00', 10, 'MORA950718HDF');

--  Inserción de DetallePedido 
INSERT INTO DetallePedido (PedidoID, ProductoID, Descuento, Cantidad, PrecioUnitario)
VALUES 
-- Pedido 1
(1, 1, 0.10, 12, 45.00),
(1, 3, 0.05, 6, 75.00),
(1, 17, 0.00, 4, 22.00),

-- Pedido 2
(2, 5, 0.15, 3, 180.00),
(2, 6, 0.10, 2, 350.00),
(2, 7, 0.00, 8, 25.00),

-- Pedido 3
(3, 3, 0.00, 10, 75.00),
(3, 4, 0.10, 8, 70.00),
(3, 15, 0.05, 2, 280.00),

-- Pedido 4
(4, 17, 0.00, 15, 22.00),
(4, 18, 0.10, 10, 20.00),
(4, 13, 0.00, 20, 15.00),
(4, 14, 0.05, 15, 12.00),

-- Pedido 5
(5, 1, 0.10, 20, 45.00),
(5, 2, 0.05, 15, 55.00),
(5, 11, 0.00, 8, 35.00),
(5, 12, 0.10, 6, 28.00),

-- Pedido 6
(6, 9, 0.00, 10, 20.00),
(6, 10, 0.10, 12, 18.00),
(6, 19, 0.00, 25, 10.00),
(6, 20, 0.05, 20, 12.00),

-- Pedido 7
(7, 5, 0.20, 4, 180.00),
(7, 6, 0.15, 3, 350.00),
(7, 8, 0.00, 10, 30.00),

-- Pedido 8
(8, 1, 0.05, 15, 45.00),
(8, 2, 0.10, 10, 55.00),
(8, 3, 0.00, 8, 75.00),
(8, 4, 0.05, 6, 70.00),

-- Pedido 9 
(9, 17, 0.00, 20, 22.00),
(9, 18, 0.10, 18, 20.00),
(9, 11, 0.00, 12, 35.00),

-- Pedido 10
(10, 7, 0.00, 10, 25.00),
(10, 8, 0.10, 8, 30.00),
(10, 13, 0.00, 15, 15.00),
(10, 19, 0.00, 20, 10.00),
(10, 20, 0.05, 18, 12.00);
