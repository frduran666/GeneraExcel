IF OBJECT_ID('[dbo].[uSP_GET_EmpresasUsuario]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[uSP_GET_EmpresasUsuario]
	PRINT ('Procedimiento [dbo].[uSP_GET_EmpresasUsuario] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_GET_EmpresasUsuario]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[uSP_GET_EmpresasUsuario]  
	@pi_IdUsuario int
as 
begin
	set nocount on 

	DECLARE	@query nvarchar(max)
	
	select	@query = ''
	
	select	@query = @query + '
	SELECT	TOP 1 
			IdUsuario = ' + convert(varchar(30), @pi_IdUsuario) + '
	,		IdEmpresa = a.IdEmpresa
	,		NombreEmpresa = b.Nombre
	,		BaseDatos = b.BaseDatos
	from	DS_Rep_UsuarioEmpresa a
		inner join DS_Rep_Empresa b
			on a.IdEmpresa = b.Id
	WHERE	a.IdUsuario = ' + convert(varchar(30), @pi_IdUsuario) + '
	'

	exec sp_executesql @query
	
	set nocount OFF
end  
GO
GO

IF OBJECT_ID('[dbo].[uSP_GET_EmpresasUsuario]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[uSP_GET_EmpresasUsuario] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[uSP_GET_EmpresasUsuario]')
END
