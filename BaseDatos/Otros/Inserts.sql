INSERT INTO DS_Rep_TipoUsuario(Nombre, UrlInicio)
select	'Administrador', '' union all
select	'Reporte', ''
GO
INSERT INTO DS_Rep_Usuarios(NombreUsuario, Contrasena, NombreCompleto, CodigoUsuario, Email, IdTipo, CentroCosto)
SELECT	'reporte', '81dc9bdb52d04dc20036dbd8313ed055', 'Reporte', null, null, 2, null
GO
INSERT INTO DS_Rep_Empresa(Nombre, BaseDatos)
select	'Ammeral', 'ABC'
GO
INSERT INTO DS_Rep_UsuarioEmpresa(IdUsuario, IdEmpresa)
select	1, 1
GO