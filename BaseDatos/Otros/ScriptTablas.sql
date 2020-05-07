DROP TABLE DS_Rep_Usuarios
DROP TABLE DS_Rep_TipoUsuario
DROP TABLE DS_Rep_Empresa
DROP TABLE DS_Rep_UsuarioEmpresa

GO

CREATE TABLE DS_Rep_Usuarios
(
	Id Int identity(1, 1)
,	NombreUsuario varchar(100)
,	NombreCompleto varchar(100)
,	Contrasena varchar(1000)
,	CodigoUsuario varchar(100)
,	Email varchar(1000)
,	IdTipo int
,	CentroCosto varchar(100)
)
CREATE TABLE DS_Rep_TipoUsuario
(
	Id int identity(1, 1)
,	Nombre varchar(100)
,	UrlInicio varchar(1000)
)
CREATE TABLE DS_Rep_Empresa
(
	Id int identity(1, 1)
,	Nombre varchar(100)
,	BaseDatos varchar(100)
)
CREATE TABLE DS_Rep_UsuarioEmpresa
(
	IdUsuario int
,	IdEmpresa int
)