IF OBJECT_ID('[dbo].[uSP_Login]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[uSP_Login]
	PRINT ('Procedimiento [dbo].[uSP_Login] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_Login]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[uSP_Login]  
	@pv_Usuario varchar(100)
,	@pv_Contrasena varchar(100)
,	@pv_ContrasenaMD5 varchar(100)
as 
begin
	set nocount on       
	DECLARE	@query nvarchar(max)
	
	select	@query = ''
	begin try
		select	@query = @query + '
		SELECT	TOP 1 
				Id = usr.Id
		,		CodigoUsuario = usr.CodigoUsuario
		,		NombreUsuario = usr.NombreUsuario
		,		Nombres = usr.NombreCompleto
		,		tipoUsuario = tipo.Nombre
		,		Email = usr.email
		,		IdTipo = usr.IdTipo
		,		UrlInicio = tipo.UrlInicio
		,		CentroCosto = usr.CentroCosto
		FROM	[DS_Rep_Usuarios] AS usr
			LEFT JOIN [DS_Rep_TipoUsuario] AS tipo ON usr.IdTipo=tipo.Id
		--WHERE usr.Usuario=''' + @pv_Usuario + ''' AND PWDCOMPARE(''' + @pv_ContrasenaMD5 + ''',usr.Contrasena) = 1
		'

		exec( @query)
	end try
	begin catch
		print (error_message())
	end catch
	
	set nocount OFF       
end  
GO
GO

IF OBJECT_ID('[dbo].[uSP_Login]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[uSP_Login] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[uSP_Login]')
END
/*
[dbo].[uSP_Login]  
	@pv_Usuario = 'reporte'
,	@pv_Contrasena = '1234'
,	@pv_ContrasenaMD5 = '81dc9bdb52d04dc20036dbd8313ed055'
*/