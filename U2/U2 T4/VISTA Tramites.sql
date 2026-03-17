--vw_usuarios -------------> usuarios, colonias, municipios, estados

CREATE view vw_usuarios AS
SELECT u.usuid, u.usuNombre, u.usuApellidos, u.usuDomicilio, u.usuTelefono, u.usuCorreo,
c.colid, c.colNombre,
m.munid, m.munNombre,
es.edoid, es.edoNombre
FROM usuarios u
INNER JOIN	colonias c on u.COLID = c.COLID
INNER JOIN	MUNICIPIOS m on c.MUNID = m.MUNID
INNER JOIN	ESTADOS es on m.EDOID = es.EDOID
go

select * from vw_usuarios
GO


--vw_ventanillas ------------> ventanillas, tipos

CREATE VIEW vw_ventanillas AS
SELECT v.venID, v.venNombre,
ti.tipid, ti.tipNombre
FROM ventanillas v
INNER JOIN tipos ti on v.tipoid = ti.tipid
GO

select * from vw_ventanillas
go

--vw_empleados  --------->  empleados, departamentos, dependencias

CREATE VIEW vw_empleados AS
SELECT emp.empID, emp.empNombre, emp.empApellidos, emp.empTelefono, emp.empCorreo, j.jefeid,
dep.depID, dep.depNombre, dep.depDomicilio, dep.depTelefono,
den.denID, den.denNombre, den.denDomicilio, den.denTelefono

FROM empleados emp
INNER JOIN empleados j on j.jefeid = emp.empid
INNER JOIN departamentos dep on dep.depid = emp.depid
INNER JOIN dependencias den on den.denid = dep.denID
GO

select * from vw_empleados
go

--vw_tramitesxregistro-----------> tramitesxregistro, tramites, familias
CREATE VIEW vw_tramitesxregistro AS
SELECT tr.folio, tr.tramID , tr.fechafinal, tr.costo,
t.tramid as tramiteID, t.tramNombre, t.tramDescripcion, t.tramCosto,
f.famid, f.famNombre

FROM tramitesxregistro tr
INNER JOIN tramites t on t.tramid = tr.tramid
INNER JOIN familias f on f.famid = t.famid
GO

select * from vw_tramitesxregistro
GO

--vw_registro ---------------> registro, vw_ventanillas, vw_usuarios, vw_empleados, vw_tramitesxregistro
CREATE VIEW vw_registro AS
SELECT r.folio as registro_folio, r.fechaCaptura,

vven.venID, vven.venNombre,
vven.tipid, vven.tipNombre,

vusu.usuid, vusu.usuNombre, vusu.usuApellidos, vusu.usuDomicilio, vusu.usuTelefono, vusu.usuCorreo,
vusu.colid, vusu.colNombre,
vusu.munid, vusu.munNombre,
vusu.edoid, vusu.edoNombre,

vemp.empID, vemp.empNombre, vemp.empApellidos, vemp.empTelefono, vemp.empCorreo, vemp.jefeid,
vemp.depID, vemp.depNombre, vemp.depDomicilio, vemp.depTelefono,
vemp.denID, vemp.denNombre, vemp.denDomicilio, vemp.denTelefono,

vtr.folio, vtr.tramID , vtr.fechafinal, vtr.costo,
vtr.tramid as tramiteID, vtr.tramNombre, vtr.tramDescripcion, vtr.tramCosto,
vtr.famid, vtr.famNombre

FROM registro r
INNER JOIN vw_ventanillas vven on vven.venid = r.venid
INNER JOIN vw_usuarios vusu on vusu.usuid = r.usuid
INNER JOIN vw_tramitesxregistro vtr on vtr.folio = r.folio
INNER JOIN vw_empleados vemp on vemp.empid = r.empid
GO

select * from vw_registro
GO