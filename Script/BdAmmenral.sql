USE [SC_ATENCION]
GO
/****** Object:  StoredProcedure [dbo].[uSP_Login]    Script Date: 05-05-2020 11:07:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_Login]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
Create procedure [dbo].[uSP_Login]  
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

USE [SC_ATENCION]
GO
/****** Object:  StoredProcedure [dbo].[uSP_GET_ExcelVentas]    Script Date: 05-05-2020 11:07:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_GET_ExcelVentas]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
Create procedure [dbo].[uSP_GET_ExcelVentas]  
	@pv_BaseDatos varchar(100)
,	@pv_FechaDesde datetime
,	@pv_FechaHasta datetime
as 
begin
	set nocount on 
	
	DECLARE	@query01 nvarchar(max)
	DECLARE	@query02 nvarchar(max)
	DECLARE	@query03 nvarchar(max)
	DECLARE	@query04 nvarchar(max)
	DECLARE	@query05 nvarchar(max)
	DECLARE	@query06 nvarchar(max)
	
	select	@query01 = ''
	select	@query02 = ''
	select	@query03 = ''
	select	@query04 = ''
	select	@query05 = ''
	select	@query06 = ''
	





	select	@query01 = @query01 + '
	select	[Company_ID] = ''22610''
	--,		[Tipo] = isnull(a.tipo, '''')
	,		[Customer_No] = isnull(a.codaux, '''')
	,		[SalesOrder_No] = ''''
	,		[Invoice_No] = isnull(a.folio, 0)
	,		[Invoice_LineNo] = isnull(a.linea,0)
	--,		[C.Costos] = isnull(a.CentroDeCosto, '''')
	,		[Customer_SalesPerson] = isnull(a.VenDes, '''')
	,		[Production_location] = isnull(a.CodBode,'''')
	,		[MarketSegment_MainCode] = isnull(a.DirAux,''S/N'')
	,		[ConfiguredItem_No] = ''''
	,		[ConfiguredItem_UOM] = ''''
	,		[ConfiguredItem_Qty] = isnull(a.CantFacturada, 0)
	,		[Item_No] = isnull(a.CodProd, '''')
	,		[Item_QtyPer] = ''''
	,		[Item_Qty] = isnull(a.cantFacturada,0)
	,		[MasterItem] = ''1''
	,		[Item_Length] = ''''
	,		[Item_Width] = ''''
	,		[Item_M2] = ''''
	--,		[Descrip.Producto] = isnull(a.desprod, '''')
	--,		[CodGrupo] = isnull(a.CodGrupo, '''')
	--,		[DesGrupo] = isnull(a.DesGrupo, '''')
	--,		[CodSubGr] = isnull(a.CodSubGr, '''')
	--,		[DesSubGr] = isnull(a.DesSubGr, '''')	
	,		[GrossSalesValue] = isnull(a.preunimb, 0)
	,		[DiscountAmount] = isnull(a.TotalDescMov,0) --Cambiar por descuento por linea
	,		[NetSalesValue] = isnull(a.TotLinea, 0)
	,		[ActualCost] = isnull(a.costoTotalProm, 0)
	,		[WasteAmount] = ''''
	,		[PostingDate] = isnull(convert(varchar(20), a.fecha, 103), '''')
	--,		[CostoProm] = isnull(a.CostoProm, 0)
	,		[Currency] = ''CLP''
	,		[ShipTo_Customer_No] = isnull(a.codaux,'''')
	,		[Customer_SalesPersonCode] = isnull(a.CodVendedor, '''')
	,		[Invoicing Currency] = isnull(a.DesMon,'''')
	,		[Bill to Customer_No] = isnull(a.codaux,'''')
	--,		[Descrip.Vendedor] = isnull(a.VenDes, '''')
	--,		[TipoDocto] = isnull(a.tipoDocto, '''')
	--,		[Fecha Vencimiento] = isnull(convert(varchar(20), a.fechaVenc, 103), '''')
	--,		[Cod.Caja] = isnull(a.codcaja, '''')
	--,		[Descrip.Caja] = isnull(a.descaja, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(convert(varchar(20), a.FecHoraCreacionVW, 103), '''')
	--,		[aaaaaaaaaaaaaa] = isnull(convert(varchar(20), a.linea, 103), '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.eskit, 0)
	--,		[aaaaaaaaaaaaaa] = isnull(a.kit, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.CKit, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.DKit, '''')
	--,		[TipoCambio] = isnull(a.TipoCambio, '''')
	--,		[Partida] = isnull(a.Partida, '''')
	--,		[Pieza] = isnull(a.Pieza, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.CatDes, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.DetProd, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.TotalBoleta, 0)
	--,		[ValorconDescuento] = isnull(a.ValorconDescuento, 0)
	--,		[aaaaaaaaaaaaaa] = isnull(a.CODKIT, '''')
	--,		[aaaaaaaaaaaaaa] = isnull(a.Nombrekit, '''')
		from	('
	select	@query02 = @query02 + '
				select	distinct 
						gsaen.tipo
				,		gsaen.codcaja
				,		gsaen.CentroDeCosto
				,		caja.descaja
				,		gsaen.FecHoraCreacionVW
				,		gmovi.linea
				,		gmovi.TotalDescMov -- Cambiar por descuento por linea
				,		gsaen.codaux
				,		cwt.NomAux
				,		cwt.DirAux
				,		gsaen.folio as folio
				,		gsaen.codbode
				,		gmovi.CodProd
				,		prod.esconfig as eskit
				,		gmovi.kit
				,		(
							case	when gmovi.kit is null 
										then gmovi.codprod 
									else gmovi.kit 
							end
						) as CKit
				,		(
							case	when gmovi.kit is null 
										then prod.desprod 
									else PKIT.DesProd 
							end
						) as DKit
				,		prod.desprod
				,		prod.CodGrupo
				,		grupo.DesGrupo 
				,		prod.CodSubGr
				,		subGrupo.DesSubGr
				,		gmovi.CantFacturada
				,		gmovi.preunimb
				,		round(gmovi.TotLinea, 1) as TotLinea
				,		gsaen.fecha
				,		'''' as TipoCambio
				--,		[dbo].costoprom(gmovi.CodProd, gsaen.fecha) as CostoProm
				,		CostoProm = 
						ISNULL((
							select	CostoUnitario 
							from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
							where	CodProd = gmovi.CodProd 
							AND		Fecha =		isnull((
													select	max(Fecha) 
													from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
													where	CodProd = gmovi.CodProd
													and		fecha <= gsaen.fecha
												), convert(datetime,''01/01/1900'',103))
						), 0)
				--,		(gmovi.cantFacturada * dbo.costoprom(gmovi.CodProd, gsaen.fecha)) as costoTotalProm
				,		costoTotalProm = 
						(gmovi.cantFacturada * 
						ISNULL((
							select	CostoUnitario 
							from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
							where	CodProd = gmovi.CodProd 
							AND		Fecha =		isnull((
													select	max(Fecha) 
													from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
													where	CodProd = gmovi.CodProd
													and		fecha <= gsaen.fecha
												), convert(datetime,''01/01/1900'',103))
						), 0))
				,		gmovi.Partida
				,		gmovi.Pieza
				,		descCl.CatDes
				,		gsaen.CodVendedor
				,		vendedor.VenDes
				,		cast(gmovi.DetProd as varchar(max)) AS DetProd
				,		gmovi.TotalBoleta
				,		round((gmovi.TotLinea - ((((gmovi.TotLinea * 100) / gsaen.SubTotal) * gsaen.TotalDesc) / 100)), 1) as ValorconDescuento
				,		case	when gsaen.SubTipoDocto=''A'' then ''Afecto''
								when gsaen.SubTipoDocto = ''E'' then ''Exento''
								when gsaen.SubTipoDocto = ''x'' then ''Exportacion''
								when gsaen.SubTipoDocto = ''T'' then ''Docto Electronico''
								when gsaen.SubTipoDocto = ''L'' then ''Liquidacion''
								when gsaen.SubTipoDocto = ''N'' then ''Liquidacion Factura''
								when gsaen.SubTipoDocto = ''O'' then ''Liquidacion electronica''
								when gsaen.SubTipoDocto = ''C'' then ''Documento Interno de Venta''
								else ''--''
						end AS tipoDocto
				,		IsNull(GMOVI.KIT, '''') as CODKIT
				,		IsNull(
								(
									SELECT DesProd FROM 
									[' + @pv_BaseDatos + '].softland.iw_tprod
									WHERE codprod = GMOVI.KIT
								), '''') as Nombrekit
				,		GSAEN.fechaVenc'
				select	@query03 = @query03 + '
				FROM	[' + @pv_BaseDatos + '].[softland].IW_GMOVI GMOVI
					LEFT JOIN [' + @pv_BaseDatos + '].[softland].IW_TPROD PROD 
						ON GMOVI.CODPROD = PROD.CODPROD
					LEFT JOIN [' + @pv_BaseDatos + '].[softland].IW_TPROD PKIT 
						ON GMOVI.KIT = PKIT.CODPROD
					INNER JOIN [' + @pv_BaseDatos + '].[softland].IW_GSAEN GSAEN 
						ON GMOVI.NROINT = GSAEN.NROINT AND GSAEN.TIPO = GMOVI.Tipo
					left join [' + @pv_BaseDatos + '].[softland].cwtauxi cwt 
						ON gsaen.codaux = cwt.codaux
					left join [' + @pv_BaseDatos + '].[softland].cwtvend vendedor 
						ON vendedor.VenCod = GSAEN.CodVendedor 
					left join [' + @pv_BaseDatos + '].[softland].cwtcvcl cl 
						ON cl.CodAux = GSAEN.CodAux 
					left join [' + @pv_BaseDatos + '].[softland].cwtcgau descCl 
						ON descCl.CatCod = cl.CatCli 
					left join [' + @pv_BaseDatos + '].[softland].iw_tgrupo grupo 
						ON grupo.CodGrupo = prod.CodGrupo 
					left join [' + @pv_BaseDatos + '].[softland].iw_tsubgr subGrupo 
						ON subGrupo.CodSubGr = prod.CodSubGr 
					INNER JOIN [' + @pv_BaseDatos + '].[softland].vw_tcaja caja 
						ON caja.codCaja = gsaen.CodCaja
				WHERE	GSAEN.tipo != ''s'' 
				and		GSAEN.tipo != ''n'' 
				and		GSAEN.tipo != ''e'' 
				and		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103)
				AND		GSAEN.Estado = ''V'''
				select	@query04 = @query04 + '
				--union all
				select	distinct 
						gsaen.tipo
				,		gsaen.codcaja 
				,		'''' as descaja 
				,		gsaen.CentroDeCosto
				,		gmovi.linea 
				,		gmovi.TotalDescMov -- Cambiar por descuento por linea
				,		gsaen.FecHoraCreacionVW
				,		gsaen.codaux
				,		cwt.NomAux
				,		cwt.DirAux
				,		mone.DesMon
				,		gsaen.folio
				,		gsaen.codbode
				,		gmovi.CodProd
				,		prod.esconfig as eskit 
				,		gmovi.kit 
				,		(case when gmovi.kit is null then gmovi.codprod else gmovi.kit end) as CKit 
				,		(case when gmovi.kit is null then prod.desprod else PKIT.DesProd end) as DKit
				,		prod.desprod 
				,		prod.CodGrupo
				,		grupo.DesGrupo 
				,		prod.CodSubGr 
				,		subGrupo.DesSubGr 
				,		gmovi.CantFacturada
				,		gmovi.preunimb 
				,		round(gmovi.TotLinea,1) as TotLinea
				,		gsaen.fecha
				,		'''' as TipoCambio 
				--,		[dbo].costoprom(gmovi.CodProd,gsaen.fecha) as CostoProm 
				,		CostoProm = 
						ISNULL((
							select	CostoUnitario 
							from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
							where	CodProd = gmovi.CodProd 
							AND		Fecha =		isnull((
													select	max(Fecha) 
													from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
													where	CodProd = gmovi.CodProd
													and		fecha <= gsaen.fecha
												), convert(datetime,''01/01/1900'',103))
						), 0)
				--,		(gmovi.cantFacturada * dbo.costoprom(gmovi.CodProd,gsaen.fecha) ) as costoTotalProm 
				,		costoTotalProm = 
						(gmovi.cantFacturada * 
						ISNULL((
							select	CostoUnitario 
							from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
							where	CodProd = gmovi.CodProd 
							AND		Fecha =		isnull((
													select	max(Fecha) 
													from	[' + @pv_BaseDatos + '].softland.IW_CostoP 
													where	CodProd = gmovi.CodProd
													and		fecha <= gsaen.fecha
												), convert(datetime,''01/01/1900'',103))
						), 0))
				,		gmovi.Partida 
				,		gmovi.Pieza 
				,		descCl.CatDes 
				,		gsaen.CodVendedor 
				,		vendedor.VenDes 
				,		cast(gmovi.DetProd as varchar(max)) AS DetProd 
				,		gmovi.TotalBoleta 
				,		round((gmovi.TotLinea - ((((gmovi.TotLinea * 100) / gsaen.SubTotal) * gsaen.TotalDesc) / 100)), 1) as ValorconDescuento
				,		case	when gsaen.SubTipoDocto = ''A'' then ''Afecto'' 
								when gsaen.SubTipoDocto = ''E'' then ''Exento'' 
								when gsaen.SubTipoDocto = ''x'' then ''Exportacion'' 
								when gsaen.SubTipoDocto = ''T'' then ''Docto Electronico'' 
								when gsaen.SubTipoDocto = ''L'' then ''Liquidacion'' 
								when gsaen.SubTipoDocto = ''N'' then ''Liquidacion Factura'' 
								when gsaen.SubTipoDocto = ''O'' then ''Liquidacion electronica'' 
								when gsaen.SubTipoDocto = ''C'' then ''Documento Interno de Venta'' 
								else ''''
						end AS tipoDocto
				,		IsNull(GMOVI.KIT, '''') as CODKIT
				,		IsNull(
								(
									SELECT DesProd FROM 
									[' + @pv_BaseDatos + '].softland.iw_tprod
									WHERE codprod = GMOVI.KIT
								), '''') as Nombrekit 
				,		GSAEN.fechaVenc'
				select	@query05 = @query05 + '
				FROM	[' + @pv_BaseDatos + '].[softland].IW_GMOVI GMOVI 
					LEFT JOIN [' + @pv_BaseDatos + '].[softland].IW_TPROD PROD 
						ON GMOVI.CODPROD = PROD.CODPROD 
					LEFT JOIN [' + @pv_BaseDatos + '].[softland].IW_TPROD PKIT 
						ON GMOVI.KIT = PKIT.CODPROD 
					INNER JOIN [' + @pv_BaseDatos + '].[softland].IW_GSAEN GSAEN 
						ON GMOVI.NROINT = GSAEN.NROINT 
						AND GSAEN.TIPO = GMOVI.Tipo 
					left join [' + @pv_BaseDatos + '].[softland].cwtauxi cwt 
						ON gsaen.codaux = cwt.codaux 
					left join [' + @pv_BaseDatos + '].[softland].cwtvend vendedor 
						ON vendedor.VenCod = GSAEN.CodVendedor  
					left join [' + @pv_BaseDatos + '].[softland].cwtcvcl cl 
						ON cl.CodAux = GSAEN.CodAux  
					left join [' + @pv_BaseDatos + '].[softland].cwtcgau descCl 
						ON descCl.CatCod = cl.CatCli  
					left join [' + @pv_BaseDatos + '].[softland].iw_tgrupo grupo 
						ON grupo.CodGrupo = prod.CodGrupo  
					left join [' + @pv_BaseDatos + '].[softland].iw_tsubgr subGrupo 
						ON subGrupo.CodSubGr = prod.CodSubGr  
					left join [' + @pv_BaseDatos + '].softland.cwtmone mone
						on GSAEN.CodMoneda = mone.CodMon
				WHERE	GSAEN.tipo!=''s''
				AND		GSAEN.tipo!=''a''
				AND		GSAEN.tipo!=''e''
				AND		GSAEN.tipo!=''b''
				AND		GSAEN.tipo!=''n''
				AND		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103) 
				AND		GSAEN.Estado = ''V''
			) a
	order by a.folio desc
	'
	exec (@query01 + @query04 + @query05)
	set nocount OFF
end  

USE [SC_ATENCION]
GO
/****** Object:  StoredProcedure [dbo].[uSP_GET_EmpresasUsuario]    Script Date: 05-05-2020 11:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_GET_EmpresasUsuario]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
Create procedure [dbo].[uSP_GET_EmpresasUsuario]  
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
