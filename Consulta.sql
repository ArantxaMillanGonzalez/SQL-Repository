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
(10, 'Chicles', 'Bubble', 'SA', 'Calle Gomas 321', '5501234567'),
(11, 'Botanas', 'Mexicanas', 'Group', 'Avenida Snacks 111', '5611111111'),
(12, 'Dulcería', 'La Especial', 'SAC', 'Calle Dulces 222', '5622222222'),
(13, 'Café', 'Selecto', 'SA', 'Zona Café 333', '5633333333'),
(14, 'Té', 'Premium', 'Group', 'Parque Tés 444', '5644444444'),
(15, 'Jugos', 'Naturales', 'SA', 'Calle Jugos 555', '5655555555'),
(16, 'Salsas', 'Gourmet', 'SAC', 'Avenida Salsas 666', '5666666666'),
(17, 'Aceitunas', 'Selectas', 'SA', 'Calle Aceitunas 777', '5677777777'),
(18, 'Encurtidos', 'La Buena', 'SAC', 'Boulevard Encurtidos 888', '5688888888'),
(19, 'Chocolate', 'Gourmet', 'SA', 'Zona Chocolate 999', '5699999999'),
(20, 'Licores', 'Finos', 'Group', 'Avenida Licores 000', '5600000000');

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
(10, 'Chicles', 'Gomas de mascar y chicles en diferentes sabores'),
(11, 'Botanas Saladas', 'Snacks variados para acompañar bebidas'),
(12, 'Dulces Artesanales', 'Dulces hechos a mano con ingredientes naturales'),
(13, 'Cafés Premium', 'Cafés de alta calidad de diferentes regiones'),
(14, 'Tés Finos', 'Tés selectos de distintas variedades'),
(15, 'Jugos Naturales', 'Jugos frescos sin conservadores'),
(16, 'Salsas Gourmet', 'Salsas artesanales de alta calidad'),
(17, 'Aceitunas Selectas', 'Aceitunas de diferentes variedades'),
(18, 'Encurtidos Especiales', 'Encurtidos de producción artesanal'),
(19, 'Chocolates Finos', 'Chocolates de alta calidad y origen'),
(20, 'Licores Finos', 'Licores selectos para ocasiones especiales');

-- Inserción de Productos 
INSERT INTO Productos (ProductoID, Nombre_P, Descripcion_P, Stock, Precio, ProveedorID, CategoriaID)
VALUES 
(1, 'Sol Brillante', 'Cerveza clara ligera con limón, 4.5% alcohol', 500, 45.00, 1, 1),
(2, 'Estrella Plateada', 'Cerveza pilsner refrescante, 5% alcohol', 400, 55.00, 1, 1),
(3, 'Toro Oscuro', 'Cerveza negra intensa, 8% alcohol', 300, 75.00, 2, 2),
(4, 'Águila Dorada', 'Cerveza rubia fuerte con 7.5% alcohol', 350, 70.00, 2, 2),
(5, 'Vino Tinto Reserva', 'Vino tinto añejo, 14% alcohol, 750ml', 200, 180.00, 3, 3),
(6, 'Ron Añejo 8 años', 'Ron oscuro premium, 40% alcohol, 750ml', 150, 350.00, 3, 3),
(7, 'Papas Crujientes', 'Papas fritas con sal, 100g', 800, 25.00, 4, 4),
(8, 'Tortillas Picantes', 'Tortillas de maíz con chile, 120g', 700, 30.00, 4, 4),
(9, 'Agua Mineral Natural', 'Agua mineral con gas, 1.5L', 1000, 20.00, 5, 5),
(10, 'Agua Purificada', 'Agua purificada sin gas, 2L', 1200, 18.00, 5, 5),
(11, 'Chocolate Delight', 'Galletas con chispas de chocolate, 150g', 600, 35.00, 6, 6),
(12, 'Galletas Saladas', 'Galletas de soda con sal, 200g', 500, 28.00, 6, 6),
(13, 'Caramelos de Leche', 'Dulces tradicionales de leche quemada', 400, 15.00, 7, 7),
(14, 'Paletas de Tamarindo', 'Paletas de tamarindo con chile, 20g', 350, 12.00, 7, 7),
(15, 'Tabaco Fino Premium', 'Cigarros de tabaco selecto, caja de 20', 100, 280.00, 8, 8),
(16, 'Cigarros Mentolados', 'Cigarros con sabor a menta, caja de 10', 150, 180.00, 8, 8),
(17, 'Cola Oscura', 'Refresco de cola sabor original, 600ml', 900, 22.00, 9, 9),
(18, 'Lima Limón', 'Refresco de lima-limón carbonatado, 600ml', 800, 20.00, 9, 9),
(19, 'Bubble Mentol', 'Chicles con sabor a menta y mentol', 500, 10.00, 10, 10),
(20, 'Frutas Tropicales', 'Chicles surtidos de frutas tropicales', 450, 12.00, 10, 10);

-- Inserción de Clientes
INSERT INTO Clientes (ClienteID, Nombre_Cli, Ap_Cli, Am_Cli, Fecha_nacimiento_Cli, Correo_Cli, Direccion_Cli, Telefono_Cli)
VALUES 
(1, 'Juan', 'García', 'López', '1995-03-15', 'juan.garcia@gmail.com', 'Calle Principal 123', '5512345678'),
(2, 'María', 'Rodríguez', 'Martínez', '1992-07-22', 'maria.rodriguez@gmail.com', 'Avenida Central 456', '5523456789'),
(3, 'Carlos', 'Hernández', 'Pérez', '1998-11-05', 'carlos.hernandez@gmail.com', 'Calle Secundaria 789', '5534567890'),
(4, 'Ana', 'López', 'García', '1990-09-10', 'ana.lopez@gmail.com', 'Boulevard Norte 234', '5545678901'),
(5, 'Pedro', 'Martínez', 'Sánchez', '1993-05-20', 'pedro.martinez@gmail.com', 'Calle Este 567', '5556789012'),
(6, 'Laura', 'Pérez', 'Rodríguez', '1996-12-01', 'laura.perez@gmail.com', 'Avenida Sur 890', '5567890123'),
(7, 'Miguel', 'Sánchez', 'López', '1994-08-15', 'miguel.sanchez@gmail.com', 'Calle Oeste 123', '5578901234'),
(8, 'Isabel', 'Gómez', 'Fernández', '1997-04-25', 'isabel.gomez@gmail.com', 'Boulevard Sur 456', '5589012345'),
(9, 'Jorge', 'Fernández', 'Gómez', '1991-06-30', 'jorge.fernandez@gmail.com', 'Avenida Norte 789', '5590123456'),
(10, 'Sofia', 'Díaz', 'Pérez', '1999-02-14', 'sofia.diaz@gmail.com', 'Calle Principal 321', '5501234567'),
(11, 'Andrés', 'Morales', 'Jiménez', '1993-08-21', 'andres.morales@hotmail.com', 'Avenida Roble 123', '5612345678'),
(12, 'Carolina', 'Ramos', 'Cruz', '1995-11-09', 'carolina.ramos@yahoo.com', 'Calle Pino 456', '5623456789'),
(13, 'Francisco', 'Flores', 'Herrera', '1991-04-17', 'francisco.flores@gmail.com', 'Boulevard Cedro 789', '5634567890'),
(14, 'Patricia', 'Ortiz', 'Reyes', '1994-07-28', 'patricia.ortiz@outlook.com', 'Calle Encino 234', '5645678901'),
(15, 'Ramón', 'Castañeda', 'Mendoza', '1996-09-12', 'ramon.castañeda@gmail.com', 'Avenida Fresno 567', '5656789012'),
(16, 'Teresa', 'Vázquez', 'Silva', '1992-12-05', 'teresa.vazquez@hotmail.com', 'Calle Sauce 890', '5667890123'),
(17, 'Alberto', 'Méndez', 'Ríos', '1997-03-19', 'alberto.mendez@gmail.com', 'Boulevard Álamo 123', '5678901234'),
(18, 'Cecilia', 'Rivas', 'Molina', '1998-06-24', 'cecilia.rivas@yahoo.com', 'Avenida Nogal 456', '5689012345'),
(19, 'Héctor', 'Navarro', 'Soto', '1990-10-31', 'hector.navarro@gmail.com', 'Calle Olivo 789', '5690123456'),
(20, 'Alicia', 'Delgado', 'Romero', '1999-01-08', 'alicia.delgado@outlook.com', 'Boulevard Tilo 234', '5601234567');

-- Inserción de Empleados 
INSERT INTO Clientes (ClienteID, Nombre_Cli, Ap_Cli, Am_Cli, Fecha_nacimiento_Cli, Correo_Cli, Direccion_Cli, Telefono_Cli)
VALUES 
(1, 'Juan', 'García', 'López', '1995-03-15', 'juan.garcia@gmail.com', 'Calle Principal 123', '5512345678'),
(2, 'María', 'Rodríguez', 'Martínez', '1992-07-22', 'maria.rodriguez@gmail.com', 'Avenida Central 456', '5523456789'),
(3, 'Carlos', 'Hernández', 'Pérez', '1998-11-05', 'carlos.hernandez@gmail.com', 'Calle Secundaria 789', '5534567890'),
(4, 'Ana', 'López', 'García', '1990-09-10', 'ana.lopez@gmail.com', 'Boulevard Norte 234', '5545678901'),
(5, 'Pedro', 'Martínez', 'Sánchez', '1993-05-20', 'pedro.martinez@gmail.com', 'Calle Este 567', '5556789012'),
(6, 'Laura', 'Pérez', 'Rodríguez', '1996-12-01', 'laura.perez@gmail.com', 'Avenida Sur 890', '5567890123'),
(7, 'Miguel', 'Sánchez', 'López', '1994-08-15', 'miguel.sanchez@gmail.com', 'Calle Oeste 123', '5578901234'),
(8, 'Isabel', 'Gómez', 'Fernández', '1997-04-25', 'isabel.gomez@gmail.com', 'Boulevard Sur 456', '5589012345'),
(9, 'Jorge', 'Fernández', 'Gómez', '1991-06-30', 'jorge.fernandez@gmail.com', 'Avenida Norte 789', '5590123456'),
(10, 'Sofia', 'Díaz', 'Pérez', '1999-02-14', 'sofia.diaz@gmail.com', 'Calle Principal 321', '5501234567'),
(11, 'Andrés', 'Morales', 'Jiménez', '1993-08-21', 'andres.morales@hotmail.com', 'Avenida Roble 123', '5612345678'),
(12, 'Carolina', 'Ramos', 'Cruz', '1995-11-09', 'carolina.ramos@yahoo.com', 'Calle Pino 456', '5623456789'),
(13, 'Francisco', 'Flores', 'Herrera', '1991-04-17', 'francisco.flores@gmail.com', 'Boulevard Cedro 789', '5634567890'),
(14, 'Patricia', 'Ortiz', 'Reyes', '1994-07-28', 'patricia.ortiz@outlook.com', 'Calle Encino 234', '5645678901'),
(15, 'Ramón', 'Castañeda', 'Mendoza', '1996-09-12', 'ramon.castañeda@gmail.com', 'Avenida Fresno 567', '5656789012'),
(16, 'Teresa', 'Vázquez', 'Silva', '1992-12-05', 'teresa.vazquez@hotmail.com', 'Calle Sauce 890', '5667890123'),
(17, 'Alberto', 'Méndez', 'Ríos', '1997-03-19', 'alberto.mendez@gmail.com', 'Boulevard Álamo 123', '5678901234'),
(18, 'Cecilia', 'Rivas', 'Molina', '1998-06-24', 'cecilia.rivas@yahoo.com', 'Avenida Nogal 456', '5689012345'),
(19, 'Héctor', 'Navarro', 'Soto', '1990-10-31', 'hector.navarro@gmail.com', 'Calle Olivo 789', '5690123456'),
(20, 'Alicia', 'Delgado', 'Romero', '1999-01-08', 'alicia.delgado@outlook.com', 'Boulevard Tilo 234', '5601234567');

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
(10, '2024-01-24 13:15:00', 10, 'MORA950718HDF'),
(11, '2024-01-25 09:00:00', 11, 'SOLI860425HDF'),
(12, '2024-01-26 14:30:00', 12, 'VELA900531HDF'),
(13, '2024-01-27 10:45:00', 13, 'CANO870612HDF'),
(14, '2024-01-28 16:20:00', 14, 'RUIZ880723HDF'),
(15, '2024-01-29 11:15:00', 15, 'MENDE890814HDF'),
(16, '2024-01-30 13:40:00', 16, 'ACOSA900925HDF'),
(17, '2024-01-31 15:10:00', 17, 'VARG911026HDF'),
(18, '2024-02-01 08:50:00', 18, 'SANT920127HDF'),
(19, '2024-02-02 12:25:00', 19, 'GONZ930228HDF'),
(20, '2024-02-03 17:05:00', 20, 'HERN940329HDF'),
(21, '2024-02-04 09:35:00', 1, 'GAML850313HDF'),
(22, '2024-02-05 11:50:00', 2, 'RODM920721HDF'),
(23, '2024-02-06 14:10:00', 3, 'HEPA880405HDF'),
(24, '2024-02-07 10:20:00', 4, 'LOGA950812HDF'),
(25, '2024-02-08 16:45:00', 5, 'PELA870925HDF'),
(26, '2024-02-09 13:30:00', 6, 'SAZA900102HDF'),
(27, '2024-02-10 15:55:00', 7, 'GOFA910311HDF'),
(28, '2024-02-11 08:15:00', 8, 'FELA930514HDF'),
(29, '2024-02-12 12:40:00', 9, 'DIPA940617HDF'),
(30, '2024-02-13 17:20:00', 10, 'MORA950718HDF'),
(31, '2024-02-14 09:45:00', 11, 'SOLI860425HDF'),
(32, '2024-02-15 14:05:00', 12, 'VELA900531HDF'),
(33, '2024-02-16 10:55:00', 13, 'CANO870612HDF'),
(34, '2024-02-17 16:15:00', 14, 'RUIZ880723HDF'),
(35, '2024-02-18 11:35:00', 15, 'MENDE890814HDF'),
(36, '2024-02-19 13:50:00', 16, 'ACOSA900925HDF'),
(37, '2024-02-20 15:25:00', 17, 'VARG911026HDF'),
(38, '2024-02-21 08:40:00', 18, 'SANT920127HDF'),
(39, '2024-02-22 12:15:00', 19, 'GONZ930228HDF'),
(40, '2024-02-23 16:50:00', 20, 'HERN940329HDF'),
(41, '2024-02-24 10:00:00', 1, 'GAML850313HDF'),
(42, '2024-02-25 14:30:00', 2, 'RODM920721HDF'),
(43, '2024-02-26 09:15:00', 3, 'HEPA880405HDF'),
(44, '2024-02-27 15:40:00', 4, 'LOGA950812HDF'),
(45, '2024-02-28 11:20:00', 5, 'PELA870925HDF'),
(46, '2024-02-29 13:45:00', 6, 'SAZA900102HDF'),
(47, '2024-03-01 16:35:00', 7, 'GOFA910311HDF'),
(48, '2024-03-02 08:55:00', 8, 'FELA930514HDF'),
(49, '2024-03-03 12:05:00', 9, 'DIPA940617HDF'),
(50, '2024-03-04 17:15:00', 10, 'MORA950718HDF'),
(51, '2024-03-05 09:25:00', 11, 'SOLI860425HDF'),
(52, '2024-03-06 14:50:00', 12, 'VELA900531HDF'),
(53, '2024-03-07 10:35:00', 13, 'CANO870612HDF'),
(54, '2024-03-08 16:10:00', 14, 'RUIZ880723HDF'),
(55, '2024-03-09 11:55:00', 15, 'MENDE890814HDF'),
(56, '2024-03-10 13:20:00', 16, 'ACOSA900925HDF'),
(57, '2024-03-11 15:45:00', 17, 'VARG911026HDF'),
(58, '2024-03-12 08:30:00', 18, 'SANT920127HDF'),
(59, '2024-03-13 12:45:00', 19, 'GONZ930228HDF'),
(60, '2024-03-14 17:00:00', 20, 'HERN940329HDF'),
(61, '2024-03-15 09:50:00', 1, 'GAML850313HDF'),
(62, '2024-03-16 14:15:00', 2, 'RODM920721HDF'),
(63, '2024-03-17 10:40:00', 3, 'HEPA880405HDF'),
(64, '2024-03-18 15:55:00', 4, 'LOGA950812HDF'),
(65, '2024-03-19 11:10:00', 5, 'PELA870925HDF'),
(66, '2024-03-20 13:35:00', 6, 'SAZA900102HDF'),
(67, '2024-03-21 16:25:00', 7, 'GOFA910311HDF'),
(68, '2024-03-22 08:45:00', 8, 'FELA930514HDF'),
(69, '2024-03-23 12:30:00', 9, 'DIPA940617HDF'),
(70, '2024-03-24 17:35:00', 10, 'MORA950718HDF'),
(71, '2024-03-25 09:05:00', 11, 'SOLI860425HDF'),
(72, '2024-03-26 14:40:00', 12, 'VELA900531HDF'),
(73, '2024-03-27 10:15:00', 13, 'CANO870612HDF'),
(74, '2024-03-28 16:30:00', 14, 'RUIZ880723HDF'),
(75, '2024-03-29 11:45:00', 15, 'MENDE890814HDF'),
(76, '2024-03-30 13:55:00', 16, 'ACOSA900925HDF'),
(77, '2024-03-31 15:20:00', 17, 'VARG911026HDF'),
(78, '2024-04-01 08:35:00', 18, 'SANT920127HDF'),
(79, '2024-04-02 12:50:00', 19, 'GONZ930228HDF'),
(80, '2024-04-03 16:05:00', 20, 'HERN940329HDF'),
(81, '2024-04-04 09:40:00', 1, 'GAML850313HDF'),
(82, '2024-04-05 14:20:00', 2, 'RODM920721HDF'),
(83, '2024-04-06 10:55:00', 3, 'HEPA880405HDF'),
(84, '2024-04-07 15:30:00', 4, 'LOGA950812HDF'),
(85, '2024-04-08 11:15:00', 5, 'PELA870925HDF'),
(86, '2024-04-09 13:40:00', 6, 'SAZA900102HDF'),
(87, '2024-04-10 16:50:00', 7, 'GOFA910311HDF'),
(88, '2024-04-11 08:25:00', 8, 'FELA930514HDF'),
(89, '2024-04-12 12:35:00', 9, 'DIPA940617HDF'),
(90, '2024-04-13 17:45:00', 10, 'MORA950718HDF'),
(91, '2024-04-14 09:30:00', 11, 'SOLI860425HDF'),
(92, '2024-04-15 14:55:00', 12, 'VELA900531HDF'),
(93, '2024-04-16 10:25:00', 13, 'CANO870612HDF'),
(94, '2024-04-17 16:40:00', 14, 'RUIZ880723HDF'),
(95, '2024-04-18 11:50:00', 15, 'MENDE890814HDF'),
(96, '2024-04-19 13:10:00', 16, 'ACOSA900925HDF'),
(97, '2024-04-20 15:35:00', 17, 'VARG911026HDF'),
(98, '2024-04-21 08:20:00', 18, 'SANT920127HDF'),
(99, '2024-04-22 12:55:00', 19, 'GONZ930228HDF'),
(100, '2024-04-23 16:15:00', 20, 'HERN940329HDF');

--  Inserción de DetallePedido 
INSERT INTO DetallePedido (PedidoID, ProductoID, Descuento, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 0.10, 12, 45.00),
(1, 3, 0.05, 6, 75.00),
(1, 17, 0.00, 4, 22.00),
(2, 5, 0.15, 3, 180.00),
(2, 6, 0.10, 2, 350.00),
(2, 7, 0.00, 8, 25.00),
(3, 3, 0.00, 10, 75.00),
(3, 4, 0.10, 8, 70.00),
(3, 15, 0.05, 2, 280.00),
(4, 17, 0.00, 15, 22.00),
(4, 18, 0.10, 10, 20.00),
(4, 13, 0.00, 20, 15.00),
(4, 14, 0.05, 15, 12.00),
(5, 1, 0.10, 20, 45.00),
(5, 2, 0.05, 15, 55.00),
(5, 11, 0.00, 8, 35.00),
(5, 12, 0.10, 6, 28.00),
(6, 9, 0.00, 10, 20.00),
(6, 10, 0.10, 12, 18.00),
(6, 19, 0.00, 25, 10.00),
(6, 20, 0.05, 20, 12.00),
(7, 5, 0.20, 4, 180.00),
(7, 6, 0.15, 3, 350.00),
(7, 8, 0.00, 10, 30.00),
(8, 1, 0.05, 15, 45.00),
(8, 2, 0.10, 10, 55.00),
(8, 3, 0.00, 8, 75.00),
(8, 4, 0.05, 6, 70.00),
(9, 17, 0.00, 20, 22.00),
(9, 18, 0.10, 18, 20.00),
(9, 11, 0.00, 12, 35.00),
(10, 7, 0.00, 10, 25.00),
(10, 8, 0.10, 8, 30.00),
(10, 13, 0.00, 15, 15.00),
(10, 19, 0.00, 20, 10.00),
(10, 20, 0.05, 18, 12.00),
(11, 2, 0.00, 8, 55.00),
(11, 4, 0.10, 5, 70.00),
(12, 9, 0.05, 12, 20.00),
(12, 14, 0.00, 10, 12.00),
(12, 16, 0.00, 3, 180.00),
(13, 1, 0.10, 15, 45.00),
(13, 5, 0.00, 2, 180.00),
(13, 12, 0.05, 8, 28.00),
(14, 3, 0.00, 10, 75.00),
(14, 6, 0.15, 2, 350.00),
(14, 18, 0.00, 12, 20.00),
(15, 7, 0.00, 20, 25.00),
(15, 10, 0.10, 15, 18.00),
(15, 19, 0.00, 30, 10.00),
(16, 4, 0.05, 8, 70.00),
(16, 8, 0.00, 12, 30.00),
(16, 11, 0.00, 6, 35.00),
(17, 2, 0.10, 10, 55.00),
(17, 13, 0.00, 25, 15.00),
(17, 15, 0.05, 3, 280.00),
(18, 1, 0.00, 18, 45.00),
(18, 5, 0.10, 3, 180.00),
(18, 9, 0.00, 20, 20.00),
(19, 17, 0.05, 16, 22.00),
(19, 20, 0.00, 22, 12.00),
(20, 3, 0.00, 12, 75.00),
(20, 6, 0.10, 3, 350.00),
(20, 14, 0.00, 18, 12.00),
(21, 7, 0.05, 15, 25.00),
(21, 10, 0.00, 10, 18.00),
(22, 4, 0.00, 6, 70.00),
(22, 8, 0.10, 8, 30.00),
(22, 19, 0.00, 20, 10.00),
(23, 1, 0.10, 10, 45.00),
(23, 2, 0.00, 8, 55.00),
(23, 12, 0.05, 6, 28.00),
(24, 5, 0.00, 4, 180.00),
(24, 11, 0.10, 5, 35.00),
(24, 18, 0.00, 15, 20.00),
(25, 3, 0.05, 8, 75.00),
(25, 9, 0.00, 12, 20.00),
(25, 16, 0.10, 2, 180.00),
(26, 6, 0.00, 4, 350.00),
(26, 13, 0.05, 20, 15.00),
(26, 17, 0.00, 18, 22.00),
(27, 1, 0.00, 14, 45.00),
(27, 4, 0.10, 7, 70.00),
(27, 15, 0.00, 2, 280.00),
(28, 2, 0.05, 12, 55.00),
(28, 8, 0.00, 10, 30.00),
(28, 19, 0.10, 25, 10.00),
(29, 5, 0.00, 3, 180.00),
(29, 7, 0.05, 18, 25.00),
(29, 14, 0.00, 15, 12.00),
(30, 3, 0.10, 6, 75.00),
(30, 10, 0.00, 14, 18.00),
(30, 20, 0.00, 20, 12.00),
(31, 1, 0.05, 16, 45.00),
(31, 6, 0.00, 2, 350.00),
(31, 12, 0.10, 7, 28.00),
(32, 4, 0.00, 9, 70.00),
(32, 11, 0.05, 8, 35.00),
(32, 17, 0.00, 14, 22.00),
(33, 2, 0.10, 10, 55.00),
(33, 5, 0.00, 5, 180.00),
(33, 18, 0.05, 12, 20.00),
(34, 7, 0.00, 12, 25.00),
(34, 9, 0.10, 15, 20.00),
(34, 16, 0.00, 4, 180.00),
(35, 3, 0.05, 7, 75.00),
(35, 8, 0.00, 9, 30.00),
(35, 13, 0.10, 22, 15.00),
(36, 1, 0.00, 20, 45.00),
(36, 6, 0.05, 3, 350.00),
(36, 15, 0.00, 5, 280.00),
(37, 4, 0.10, 8, 70.00),
(37, 10, 0.00, 12, 18.00),
(37, 19, 0.05, 28, 10.00),
(38, 2, 0.00, 9, 55.00),
(38, 5, 0.10, 4, 180.00),
(38, 14, 0.00, 16, 12.00),
(39, 7, 0.05, 14, 25.00),
(39, 11, 0.00, 6, 35.00),
(39, 17, 0.10, 20, 22.00),
(40, 3, 0.00, 11, 75.00),
(40, 8, 0.05, 8, 30.00),
(40, 12, 0.00, 10, 28.00),
(41, 1, 0.10, 13, 45.00),
(41, 9, 0.00, 16, 20.00),
(41, 18, 0.05, 14, 20.00),
(42, 5, 0.00, 5, 180.00),
(42, 6, 0.10, 2, 350.00),
(42, 13, 0.00, 18, 15.00),
(43, 2, 0.05, 12, 55.00),
(43, 4, 0.00, 8, 70.00),
(43, 15, 0.10, 3, 280.00),
(44, 7, 0.00, 16, 25.00),
(44, 10, 0.05, 14, 18.00),
(44, 20, 0.00, 24, 12.00),
(45, 3, 0.10, 9, 75.00),
(45, 11, 0.00, 8, 35.00),
(45, 19, 0.05, 30, 10.00),
(46, 1, 0.00, 18, 45.00),
(46, 8, 0.10, 12, 30.00),
(46, 14, 0.00, 20, 12.00),
(47, 5, 0.05, 4, 180.00),
(47, 6, 0.00, 3, 350.00),
(47, 17, 0.10, 16, 22.00),
(48, 2, 0.00, 14, 55.00),
(48, 9, 0.05, 18, 20.00),
(48, 12, 0.00, 8, 28.00),
(49, 4, 0.10, 7, 70.00),
(49, 7, 0.00, 15, 25.00),
(49, 16, 0.05, 3, 180.00),
(50, 3, 0.00, 10, 75.00),
(50, 11, 0.10, 6, 35.00),
(50, 18, 0.00, 12, 20.00),
(51, 1, 0.05, 15, 45.00),
(51, 5, 0.00, 3, 180.00),
(51, 13, 0.10, 20, 15.00),
(52, 6, 0.00, 4, 350.00),
(52, 8, 0.05, 10, 30.00),
(52, 20, 0.00, 25, 12.00),
(53, 2, 0.10, 8, 55.00),
(53, 7, 0.00, 12, 25.00),
(53, 14, 0.05, 18, 12.00),
(54, 4, 0.00, 9, 70.00),
(54, 10, 0.10, 16, 18.00),
(54, 17, 0.00, 14, 22.00),
(55, 3, 0.05, 7, 75.00),
(55, 5, 0.00, 5, 180.00),
(55, 19, 0.10, 28, 10.00),
(56, 1, 0.00, 20, 45.00),
(56, 9, 0.05, 15, 20.00),
(56, 12, 0.00, 10, 28.00),
(57, 6, 0.10, 3, 350.00),
(57, 11, 0.00, 8, 35.00),
(57, 15, 0.05, 4, 280.00),
(58, 2, 0.00, 10, 55.00),
(58, 8, 0.10, 12, 30.00),
(58, 18, 0.00, 16, 20.00),
(59, 4, 0.05, 7, 70.00),
(59, 7, 0.00, 14, 25.00),
(59, 13, 0.10, 22, 15.00),
(60, 3, 0.00, 12, 75.00),
(60, 5, 0.05, 4, 180.00),
(60, 20, 0.00, 26, 12.00),
(61, 1, 0.10, 16, 45.00),
(61, 10, 0.00, 18, 18.00),
(61, 16, 0.05, 3, 180.00),
(62, 6, 0.00, 5, 350.00),
(62, 9, 0.10, 20, 20.00),
(62, 14, 0.00, 15, 12.00),
(63, 2, 0.05, 12, 55.00),
(63, 7, 0.00, 16, 25.00),
(63, 17, 0.10, 18, 22.00),
(64, 4, 0.00, 8, 70.00),
(64, 11, 0.05, 7, 35.00),
(64, 19, 0.00, 30, 10.00),
(65, 3, 0.10, 9, 75.00),
(65, 8, 0.00, 12, 30.00),
(65, 15, 0.05, 4, 280.00),
(66, 1, 0.00, 14, 45.00),
(66, 5, 0.10, 4, 180.00),
(66, 12, 0.00, 9, 28.00),
(67, 6, 0.05, 3, 350.00),
(67, 10, 0.00, 15, 18.00),
(67, 18, 0.10, 14, 20.00),
(68, 2, 0.00, 11, 55.00),
(68, 7, 0.05, 18, 25.00),
(68, 13, 0.00, 24, 15.00),
(69, 4, 0.10, 6, 70.00),
(69, 9, 0.00, 22, 20.00),
(69, 20, 0.05, 28, 12.00),
(70, 3, 0.00, 10, 75.00),
(70, 8, 0.10, 14, 30.00),
(70, 16, 0.00, 4, 180.00),
(71, 1, 0.05, 18, 45.00),
(71, 6, 0.00, 4, 350.00),
(71, 11, 0.10, 8, 35.00),
(72, 5, 0.00, 5, 180.00),
(72, 10, 0.05, 16, 18.00),
(72, 17, 0.00, 20, 22.00),
(73, 2, 0.10, 12, 55.00),
(73, 7, 0.00, 14, 25.00),
(73, 14, 0.05, 18, 12.00),
(74, 4, 0.00, 8, 70.00),
(74, 9, 0.10, 20, 20.00),
(74, 19, 0.00, 32, 10.00),
(75, 3, 0.05, 7, 75.00),
(75, 8, 0.00, 12, 30.00),
(75, 15, 0.10, 5, 280.00),
(76, 1, 0.00, 16, 45.00),
(76, 6, 0.05, 3, 350.00),
(76, 12, 0.00, 10, 28.00),
(77, 5, 0.10, 4, 180.00),
(77, 11, 0.00, 7, 35.00),
(77, 18, 0.05, 16, 20.00),
(78, 2, 0.00, 10, 55.00),
(78, 7, 0.10, 16, 25.00),
(78, 13, 0.00, 20, 15.00),
(79, 4, 0.05, 9, 70.00),
(79, 10, 0.00, 18, 18.00),
(79, 20, 0.10, 26, 12.00),
(80, 3, 0.00, 12, 75.00),
(80, 8, 0.05, 10, 30.00),
(80, 16, 0.00, 3, 180.00),
(81, 1, 0.10, 14, 45.00),
(81, 6, 0.00, 4, 350.00),
(81, 9, 0.05, 20, 20.00),
(82, 5, 0.00, 5, 180.00),
(82, 12, 0.10, 8, 28.00),
(82, 17, 0.00, 18, 22.00),
(83, 2, 0.05, 11, 55.00),
(83, 7, 0.00, 14, 25.00),
(83, 14, 0.10, 16, 12.00),
(84, 4, 0.00, 8, 70.00),
(84, 10, 0.05, 15, 18.00),
(84, 19, 0.00, 28, 10.00),
(85, 3, 0.10, 9, 75.00),
(85, 11, 0.00, 8, 35.00),
(85, 15, 0.05, 4, 280.00),
(86, 1, 0.00, 16, 45.00),
(86, 8, 0.10, 12, 30.00),
(86, 18, 0.00, 14, 20.00),
(87, 6, 0.05, 3, 350.00),
(87, 9, 0.00, 18, 20.00),
(87, 13, 0.10, 22, 15.00),
(88, 2, 0.00, 12, 55.00),
(88, 7, 0.05, 16, 25.00),
(88, 20, 0.00, 24, 12.00),
(89, 4, 0.10, 7, 70.00),
(89, 5, 0.00, 4, 180.00),
(89, 16, 0.05, 3, 180.00),
(90, 3, 0.00, 10, 75.00),
(90, 10, 0.10, 14, 18.00),
(90, 12, 0.00, 10, 28.00),
(91, 1, 0.05, 18, 45.00),
(91, 6, 0.00, 4, 350.00),
(91, 17, 0.10, 16, 22.00),
(92, 5, 0.00, 5, 180.00),
(92, 8, 0.05, 12, 30.00),
(92, 19, 0.00, 30, 10.00),
(93, 2, 0.10, 10, 55.00),
(93, 7, 0.00, 14, 25.00),
(93, 14, 0.05, 20, 12.00),
(94, 4, 0.00, 8, 70.00),
(94, 11, 0.10, 7, 35.00),
(94, 15, 0.00, 4, 280.00),
(95, 3, 0.05, 9, 75.00),
(95, 9, 0.00, 22, 20.00),
(95, 18, 0.10, 14, 20.00),
(96, 1, 0.00, 16, 45.00),
(96, 6, 0.05, 3, 350.00),
(96, 13, 0.00, 24, 15.00),
(97, 5, 0.10, 4, 180.00),
(97, 10, 0.00, 16, 18.00),
(97, 20, 0.05, 26, 12.00),
(98, 2, 0.00, 12, 55.00),
(98, 7, 0.10, 18, 25.00),
(98, 12, 0.00, 10, 28.00),
(99, 4, 0.05, 7, 70.00),
(99, 8, 0.00, 14, 30.00),
(99, 16, 0.10, 4, 180.00),
(100, 3, 0.00, 10, 75.00),
(100, 6, 0.05, 3, 350.00),
(100, 11, 0.00, 8, 35.00),
(100, 17, 0.10, 18, 22.00);