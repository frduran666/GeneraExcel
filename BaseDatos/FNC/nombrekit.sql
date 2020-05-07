IF OBJECT_ID('[dbo].[nombrekit]') IS NOT NULL BEGIN
	DROP FUNCTION [dbo].[nombrekit]
	PRINT ('Funcion [dbo].[nombrekit] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Funcion											*/
/*-- Nombre				: [dbo].[nombrekit]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create FUNCTION [dbo].[nombrekit](@codprod varchar(60))
RETURNS varchar(50)
AS
BEGIN

declare 
@valor varchar(max)


	
		set @valor=	(
					SELECT DesProd FROM 
					[TFEJA1].softland.iw_tprod
					WHERE 
					codprod = @codprod
					)



return  @valor
END
GO

IF OBJECT_ID('[dbo].[nombrekit]') IS NOT NULL BEGIN
	PRINT ('Funcion [dbo].[nombrekit] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear funcion [dbo].[nombrekit]')
END
