IF OBJECT_ID('[dbo].[costoprom]') IS NOT NULL BEGIN
	DROP FUNCTION [dbo].[costoprom]
	PRINT ('Funcion [dbo].[costoprom] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Funcion											*/
/*-- Nombre				: [dbo].[costoprom]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE function [dbo].[costoprom](@Producto as varchar(30),@fecha as datetime) returns decimal(18,2)
as
BEGIN

--declare @Producto varchar(20)
--declare @Fecha datetime
declare @xfec datetime
declare @xvalor decimal(18,2)

--set @Producto = 'V705D'
--set @Fecha = '2015/12/01'

set  @xfec = (select max(Fecha) from tfeja1.softland.IW_CostoP where CodProd = @Producto and fecha <= @Fecha)
set  @xfec = isnull(@xfec, convert(datetime,'01/01/1900',103))

set @xvalor = (select CostoUnitario from tfeja1.softland.IW_CostoP where  CodProd = @Producto AND Fecha = @xfec)
set @xvalor = ISNULL(@xvalor,0)

if @xvalor = NULL
set @xvalor = 0
return @xvalor

END
GO

IF OBJECT_ID('[dbo].[costoprom]') IS NOT NULL BEGIN
	PRINT ('Funcion [dbo].[costoprom] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear funcion [dbo].[costoprom]')
END
