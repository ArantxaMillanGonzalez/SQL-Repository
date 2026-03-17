--Funciones agregados: regresan un solo valor sobre los valores de una columna
--sum
--count
--max
--min
--avg

create view vw_orderdetails2 as
select * from vw_orderdetails
go

drop view vw_orderdetails2

select * from vw_products order by productname

--total de productos, todos los renglones
select COUNT (*) from vw_products

--suma de todos los precios de los productos
select SUM (unitprice) from vw_products

--clave maxima de productos
select MAX(productid) from vw_products

--clave minima de productos
select MIN(productid) from vw_products

--fecha mas grande de ordenes
select MAX(orderdate) from orders

--fecha mas pequeña de ordenes
select MIN(orderdate) from orders

select MIN(productname) from products
select MAX(productname) from products

------------------AGRUPAMIENTO
--Consulta con el nombre del proveedor y cuantos productos surte
select productname, categoryname, companyname
from vw_products
order by companyName

--Primero agrupamos por nombre del proveedor
select companyName
from vw_products
group by companyname --busca los proveedores distintos

--ahora se aplica la funcion count sobre el group by
select companyname, total = count(*)
from vw_products
group by companyname --busca los proveedores distintos

--consulta con el nombre de la categoria y cuantos productos contiene
select productname, categoryname, companyname
from vw_products
order by categoryname

select categoryName
from vw_products
order by categoryname --busca los proveedores distintos

select categoryname, total = count(*)
from vw_products
group by categoryName

select COUNT (*) from vw_products

--consulta con el nombre del producto y total de piezas vendidas
select orderid, productname, quantity, unitprice
from vw_orderdetails2
order by productname

select * from vw_orderdetails

--muestra los productos distintos
select productname
from vw_orderdetails2
group by productname

--Muestra los productos distintos y suma las piezas vendidas
select productname, piezas = sum(quantity)
from vw_orderdetails2
group by productname
order by productname

select Piezas = sum(quantity) from vw_orderdetails2


--consulta con el folio de la orden y el importe total de la venta
select orderid, productname, quantity, unitprice
from vw_orderdetails2

--muestra las ordenes distintas
select orderid
from vw_orderdetails2
group by orderid

select orderid, importe = sum(quantity*unitprice)
from vw_orderdetails2
group by orderid

select importe = sum(quantity*unitprice)
from vw_orderdetails2

--10 ordenes mas caras
select orderid,'importe'=sum(quantity*unitprice)
from vw_orderdetails2
group by orderid
order by sum(quantity*unitprice)

--clausula having

--consulta con el nombre de la categoria y total de productos que surte
--mosrar solo las categorias que tengan menos de 10 productos

--muestra el agrupamiento las categorias distintas
select categoryname, total = count(*)
from vw_products
group by categoryName

--marca error

select categoryname, total = count(*)
from vw_products
where count(*) < 10
group by categoryName

--es necesario incluir la funcion de agregado en la clausula having
select categoryname, total = count(*)
from vw_products
group by categoryName
having count(*) < 10

--consulta con el nombre del proveedor y total de productos que surte
--mostrar solo los proveedores que su nombre empiece con m,n
--y que surtan entre 1 y 2 productos
select companyname, count(*)
from vw_products
where companyname like'(mn)%'
group by companyname
having count(*) between 1 and 2

--consulta con el nombre del cliente, total de ordenes realizadas e importe total de ventas
--mostrar solo los clientes con un importe total mayor a 10,000

select orderid, nomcliente, productname, quantity, unitprice
from vw_orderdetails2
order by nomcliente

select nomcliente, mal = count(*),
correcto = count(distinct orderid),imp = sum(quantity*unitprice)
from vw_orderdetails2
group by nomcliente
having sum(quantity*unitprice)>10000
order by nomcliente

--NOMBRE DEL EMPLEADO, TOTAL DE ORDENES REALIZADAS, TOTAL DE ORDENES REALIZADAS, TOTAL DE CLIENTES ATENDIDOS E
--IMPORTE DE VENTA

select orderid, firstname, lastname, customerid, nomcliente, productname, quantity, unitprice
from vw_orderdetails2
ORDER BY firstname

SELECT FIRSTNAME +''+LASTNAME,
ORDENESMAL = COUNT(*),
ORDENES = COUNT(DISTINCT ORDERID),
CLIENTES = COUNT(DISTINCT CUSTOMERID),
IMPORTE = SUM(QUANTITY*UNITPRICE)
FROM VW_ORDERDETAILS2
GROUP BY FIRSTNAME, LASTNAME
ORDER BY FIRSTNAME

--CONSUTA CON EL AÑO, TOTAL DE ORDENES REALIZADAS E IMPORTE DE VENTAS
--MOSTRAR SOLO LOS AÑOS CON UN IMPORTE MAYOR A 600,000
select orderid, orderdate, año = year(orderdate), mes = month(orderdate), productname,
quantity, unitprice
from vw_orderdetails2

select año = year(orderdate),
Ordenes = count(distinct orderid),
Importe = sum(quantity * unitprice)
from vw_orderdetails2
group by year(orderdate)
having sum(quantity * unitprice) > 600000

--consulta con el año, toal de ordenes realizadas e importe 

select año = year(orderdate),
Ordenes = count(distinct orderid),
Importe = sum(quantity * unitprice),
Lunes = datepart(distinct orderdate) = 1,
Martes = datepart(distinct orderdate) = 2,
Miercoles = datepart( distinct orderdate) = 3,
Jueves = datepart(distinct orderdate) = 4,
Viernes = datepart(distinct orderdate) = 5
from vw_orderdetails2
group by year(orderdate), datepart(orderdate)
having sum(quantity * unitprice) > 600000

--BUSQUEDAS VERTICALES
--Consulta con el nombre del cliente, el importe total de ventas,
--importe de 1996, importe 1997, e importe 1998
select orderid, nomcliente, quantity, unitprice from vw_orderdetails2
order by nomcliente

select nomcliente, total = sum(quantity*unitprice)
from vw_orderdetails2
group by nomcliente

--estructura de case when
case when condicion then "verdadero" else "falso" END

case when condicion then
"verdadero"
else
"falso"
END

--consulta con el nombre del producto y una columna que diga si el producto es caro (mas de 50)
--o barato (menos de 50)
select productname, unitprice, tipo = 
case when unitprice >= 50 then 'Caro' else 'Barato' END
from products

--
select nomcliente,
total = isnull(sum (quantity*unitprice),0),
total96 = sum(case when year(orderdate) = 1996 then quantity*unitprice else 0 end),
total97 = sum(case when year(orderdate) = 1997 then quantity*unitprice else 0 end),
total98 = sum(case when year(orderdate) = 1998 then quantity*unitprice else 0 end)
from vw_orderdetails2 d right outer join customers c on c.customerid = d.customerid
group by c.companyname


--Solucion con vistas
CREATE VIEW vw_importes AS
SELECT
ORDERID, IMPORTE = SUM(QUANTITY*UNITPRICE),
RANGO =
CASE WHEN 
SUM(QUANTITY*UNITPRICE) >= 0 AND SUM(QUANTITY*UNITPRICE) <= 500 THEN '1-0 A 500' ELSE
CASE WHEN
SUM(QUANTITY*UNITPRICE) >= 500 AND SUM(QUANTITY*UNITPRICE) <= 1000 THEN '2.-501 A 1000' ELSE
CASE WHEN
SUM(QUANTITY*UNITPRICE) >= 1000 AND SUM(QUANTITY*UNITPRICE) <= 2000 THEN '3.-1001 A 2000' ELSE
'4.- MAS DE 2000' END END END
FROM vw_orderdetails2
GROUP BY orderid
GO

SELECT*FROM vw_importes
ORDER BY rango
GO

--resultado
SELECT 'RANGO DEL IMPORTE' = RANGO, 'TOTAL ORDENES' = COUNT(*)
FROM VW_IMPORTES
GROUP BY RANGO

--consulta con el nombre del dia de la semana, total de ordenes realizadas e
--importe de venta de ese dia

select datename(dw, orderdate),
Total = count(distinct orderid),
Importe = sum(quantity*unitprice)
from vw_orderdetails2
group BY datename(dw, orderdate), datepart(dw,orderdate)
order by datepart(dw, orderdate)

--la consulta anterior no muestra todos los dia de la semana
CREATE view vw_dias as
SELECT clave = 1, nombre = 'Domingo'
union
select 2, 'Lunes'
union
select 3, 'Martes'
union
select 4, 'Miercoles'
union
select 5, 'Jueves'
union
select 6, 'Viernes'
union
select 7, 'Sabado'
GO

select * from vw_dias

select
Dia = d.nombre,
Ordenes = count(distinct OD.orderid),
Importe = isnull(sum(OD.quantity * OD.unitprice),0)
from vw_orderdetails2 OD right outer join vw_dias D on D.clave = datepart(dw, OD.orderdate)
group by D.clave, D.nombre
order by D.clave


