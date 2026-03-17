--1.- NOMBRE DE LA PAIS Y TOTAL DE ESTADOS QUE CONTIENE.

SELECT paisNombre, TOTAL_ESTADOS= COUNT (edoId)
FROM VW_CLIENTES
GROUP BY  paisNombre

--2.- NOMBRE DEL ESTADO, TOTAL DE PEDIDOS REALIZADOS E IMPORTE TOTAL.
Select edoNombre, 'Total Pedidos Realizados' = COUNT(folio), 'Importe Total' = SUM(importe)
FROM VW_Pedidos
GROUP BY edoNombre

--3.- AÑO, TOTAL DE PEDIDOS REALIZADOS E IMPORTE TOTAL.

SELECT YEAR(FECHA), 'TOTAL PEDIDOS'=COUNT (FOLIO), 'IMPORTE TOTAL'= SUM(Importe)
FROM VW_Pedidos
GROUP BY YEAR(FECHA)


--4.- MES Y TOTAL DE PEDIDOS REALIZADOS. MOSTRAR TODOS LOS MESES, SI NO TIENE CITAS, MOSTAR EN CERO.
CREATE view vw_meses as
SELECT clave = 1, nombre = 'Enero'
union
select 2, 'Febrero'
union
select 3, 'Marzo'
union
select 4, 'Abril'
union
select 5, 'Mayo'
union
select 6, 'Junio'
union
select 7, 'Julio'
union
select 8, 'Agosto'
union
select 9, 'Septiembre'
union
select 10, 'Octubre'
union
select 11, 'Noviembre'
union
select 12, 'Diciembre'
GO

SELECT 'Mes' = month(fecha), 'Total de pedidos realizados' = COUNT(Folio)
FROM VW_Pedidos vwp
RIGHT OUTER JOIN vw_meses m on m.clave = datepart(month, fecha)
GROUP BY month(fecha)

--5.- NOMBRE DEL EMPLEADO, TOTAL DE PEDIDOS REALIZADOS E IMPORTE TOTAL.

SELECT empNombre, COUNT(Folio), 'Total pedidos'= SUM(importe)
FROM VW_PEDIDOS
GROUP BY empNombre

--6.- NOMBRE DEL CLIENTE, TOTAL DE PEDIDOS REALIZADOS E IMPORTE TOTAL.


SELECT clNombre, COUNT(Folio), 'Total pedidos'= SUM(importe)
FROM VW_PEDIDOS
GROUP BY ClNombre

--7.- NOMBRE DEL ESTADO Y TOTAL DE PEDIDOS REALIZADOS POR MES DEL AÑO 2020. POR EJEMPLO 

select edoNombre, 'Enero'= sum(case when month(fecha)= 1 then 1 else 0 end),
'Febrero'= sum(case when month(fecha)= 2 then 1 else 0 end),
'Marzo'= sum(case when month(fecha)= 3 then 1 else 0 end),
'Abril'= sum(case when month(fecha)= 4 then 1 else 0 end),
'Mayo'= sum(case when month(fecha)= 5 then 1 else 0 end),
'Junio'= sum(case when month(fecha)= 6 then 1 else 0 end),
'Julio'= sum(case when month(fecha)= 7 then 1 else 0 end),
'AGOSTO'= sum(case when month(fecha)= 8 then 1 else 0 end),
'SEPTIEMBRE'= sum(case when month(fecha)= 9 then 1 else 0 end),
'OCTUBRE'= sum(case when month(fecha)= 10 then 1 else 0 end),
'NOVIEMBRE'= sum(case when month(fecha)= 11 then 1 else 0 end),
'DICIEMBRE'= sum(case when month(fecha)= 12 then 1 else 0 end)
from VW_PEDIDOS
WHERE YEAR(FECHA)= 2020
group by edoNombre
GO


-- 8.- AÑO, Y TOTAL DE PEDIDOS REALIZADOS POR DIA DE LA SEMANA.


select YEAR(FECHA), 'DOMINGO'= sum(case when DATEPART(WEEKDAY,fecha)= 1 then 1 else 0 end),
'LUNES'= sum(case when DATEPART(WEEKDAY, fecha)= 2 then 1 else 0 end),
'MARTES'= sum(case when DATEPART(WEEKDAY,fecha)= 3 then 1 else 0 end),
'MIERCOLES'= sum(case when DATEPART(WEEKDAY,fecha)= 4 then 1 else 0 end),
'JUEVES'= sum(case when DATEPART(WEEKDAY,fecha)= 5 then 1 else 0 end),
'VIERNES'= sum(case when DATEPART(WEEKDAY, fecha)= 6 then 1 else 0 end),
'SABADO'= sum(case when DATEPART(WEEKDAY, fecha)= 7 then 1 else 0 end)
from VW_PEDIDOS
group by YEAR(FECHA)
GO

-- 9.- AÑO Y TOTAL DE PEDIDOS REALIZADOS POR ESTADO.
Select 'Estado' = edonombre, 'Total de pedidos' = COUNT(Folio), 'Año' = datepart(year,fecha)
From vw_pedidos 
GROUP BY edoNombre, datepart(year,fecha)
GO


--10.- REALIZAR EL SIGUIENTE REPORTE CON TODOS LOS CLIENTES


SELECT ClNombre, TOTAL= COUNT(FOLIO), 'IMPORTE 0 A 500' = sum(CASE WHEN importe > 0 and importe <=500 then 1 else 0 END),
'IMPORTE 501 A 1000' = sum(CASE WHEN importe > 500 and importe <=1000 then 1 else 0 END),
'IMPORTE 1001 A 2000' = sum(CASE WHEN importe >1000 and importe <=2000 then 1 else 0 END),
'IMPORTE MAS DE 2000' = sum(CASE WHEN importe > 2000  then 1 else 0 END)
from vw_pedidos
group by clNombre
GO