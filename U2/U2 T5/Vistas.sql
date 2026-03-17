CREATE VIEW VW_CLIENTES AS
SELECT C.clId, C.clNombre, C.clApellidos, C.clDomicilio, C.clrfc,C.edoId, E.edoNombre, E.edoArea, C.paisId,P.paisNombre
FROM CLIENTES C
INNER JOIN ESTADOS E ON C.edoId= E.edoId AND C.paisId = E.paisId
INNER JOIN PAISES P ON E.paisId= P.paisId
GO

CREATE VIEW VW_EMPLEAD0S AS 
SELECT e.empid as empleado, J.jefeid as Jefe, E.empNombre, E.empApellidos, E.empCelular
FROM EMPLEADOS E
LEFT OUTER JOIN EMPLEADOS J ON e.empid=j.empid
go


CREATE VIEW VW_PEDIDOS AS
SELECT P.folio, P.fecha, P.importe,
P.clId, C.clNombre, C.clApellidos, C.clDomicilio, C.clrfc,C.edoId, C.edoNombre, C.edoArea, C.paisId,C.paisNombre,
E.Empleado, E.Jefe, E.empNombre, E.empApellidos, E.empCelular
FROM PEDIDOS P
INNER JOIN VW_CLIENTES C ON P.clId= C.clId
INNER JOIN VW_EMPLEAD0S E ON E.empleado= P.empid

GO

SELECT * FROM VW_CLIENTES

select * from VW_EMPLEAD0S

SELECT * FROM VW_PEDIDOS


