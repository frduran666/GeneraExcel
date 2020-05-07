﻿IF OBJECT_ID('[dbo].[uSP_GET_ExcelVentas]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[uSP_GET_ExcelVentas]
	PRINT ('Procedimiento [dbo].[uSP_GET_ExcelVentas] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[uSP_GET_ExcelVentas]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
CREATE procedure [dbo].[uSP_GET_ExcelVentas]  
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
	select *
	from (
	select distinct
			[Tipo] = isnull(a.tipo, '''')
	,		[SubTipo] = isnull(a.SubTipoDocto, '''')
	,		[Folio] = isnull(a.folio, 0)
	,		[C.Costos] = isnull(a.CentroDeCosto, '''')
	,		[C.total_f] = isnull(a.total_f, '''')
	,		[Cliente] = isnull(a.codaux, '''')
	,		[Nombre Cliente] = isnull(a.NomAux, '''')
	,		[Cod.Producto] = isnull(a.CodProd, '''')
	,		[Descrip.Producto] = isnull(a.desprod, '''')
	,		[CodGrupo] = isnull(a.CodGrupo, '''')
	,		[DesGrupo] = isnull(a.DesGrupo, '''')
	,		[CodSubGr] = isnull(a.CodSubGr, '''')
	,		[DesSubGr] = isnull(a.DesSubGr, '''')
	,		[Cantidad] = isnull(a.CantFacturada, 0)
	,		[PrecioVenta] = isnull(a.preunimb, 0)
	,		[Total Desc] = isnull(a.TotalDescMov, 0)
	--,		[TotLinea] = isnull(a.TotLinea, 0)
	,		[Total Linea Sin Descuento] = isnull(a.TotalFinalNeto, 0)
	,		[Total Descuento por Linea] = isnull(a.TotalFinalNeto - a.DescuentoLinea, 0)
	,		[Porcentaje Desc Docto] = isnull(a.PorcentajeDescuentoDocumento, 0)
	,		[Total Linea con Descuento del Docto] = isnull((a.TotalFinalNeto - a.DescuentoLinea) - ((a.TotalFinalNeto - a.DescuentoLinea) * a.PorcentajeDescuentoDocumento / 100), 0)
	,		[Fecha] = isnull(convert(varchar(20), a.fecha, 103), '''')
	,		[CostoProm] = isnull(a.CostoProm, 0)
	,		[CostoTotalProm] = isnull(a.costoTotalProm, 0)
	,		[CodVendedor] = isnull(a.CodVendedor, '''')
	,		[Descrip.Vendedor] = isnull(a.VenDes, '''')
	,		[TipoDocto] = isnull(a.tipoDocto, '''')
	,		[Fecha Vencimiento] = isnull(convert(varchar(20), a.fechaVenc, 103), '''')

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
	--,		[aaaaaaaaaaaaaa] = isnull(a.Nombrekit, '''')'
	select	@query02 = @query02 + '
	from	(
				select	distinct 
						--top 0
						gsaen.tipo
				,		gsaen.subtipodocto
				,		gsaen.codcaja
				,		PorcentajeDescuentoDocumento =	(
															isnull(gsaen.porcDesc01, 0)
														+	isnull(gsaen.porcDesc02, 0)
														+	isnull(gsaen.porcDesc03, 0)
														+	isnull(gsaen.porcDesc04, 0)
														+	isnull(gsaen.porcDesc05, 0)
														)
				,       gsaen.total as total_f
				,		gsaen.CentroDeCosto
				,		caja.descaja
				,		gsaen.FecHoraCreacionVW
				,		gmovi.linea
				,		gsaen.codaux
				,		cwt.NomAux
				,		gsaen.folio as folio
				,		gmovi.CodProd
				,		prod.esconfig as eskit
				,		kitDetalle.PrecioFinalNeto
				,		kitDetalle.TotalFinalNeto
				,		kitDetalle.DescuentoLinea
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
				,		(case when gmovi.kit is null then gmovi.CantFacturada
							else 
							(select sum(gm.CantFacturada) 
							from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
							where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/
							(select sum(kp.cantidad) 
							from [' + @pv_BaseDatos + '].softland.iw_tprkit kp 
							where kp.CodProd=GMOVI.KIT)
							end) as CantFacturada
				,		(case when gmovi.kit is null then round(gmovi.preunimb,1) 
						else 
						(round((select SUM(gm.TotalBoleta) 
						from  [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/1.19,1))/
						( (select sum(gm.CantFacturada) 
						from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/
						(select sum(kp.cantidad) 
						from [' + @pv_BaseDatos + '].softland.iw_tprkit kp 
						where kp.CodProd=GMOVI.KIT))
						end) as preunimb
				,		(case when gmovi.kit is null then round(gmovi.TotLinea,1) 
						else
						round((select SUM(gm.TotalBoleta) 
						from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/1.19,1)
						end) as TotLinea
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
				--,		round((gmovi.TotLinea - ((((gmovi.TotLinea * 100) / gsaen.SubTotal) * gsaen.TotalDesc) / 100)), 1) as ValorconDescuento
				,		gmovi.TotalDescMov
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
					left join [' + @pv_BaseDatos + '].[softland].cwtccos cwtccos
						ON gsaen.CentroDeCosto = cwtccos.CODICC
					left join 
								(
									select	*
									,		TotalFinalNeto = Convert(int, (Cantidad * precioFinalNeto))
									,		TotalFinalTotal = Convert(int, (Cantidad * precioFinalTotal))
									from	(
												select	kit
												,		gsaen.Folio
												,		gmovi.nroint
												,		gmovi.Linea
												,		codprod = gmovi.codprod
												--,		codprod = case when kit is not null then kit else gmovi.codprod end
												,		Cantidad = gmovi.CantFacturada
												,		precioFinalNeto = case when kit is not null then (((gmovikit.Precio * 100) / (100 + impuesto.ValPctIni))) else gmovi.PreUniMB end
												,		precioFinalTotal = case when kit is not null then gmovikit.Precio else gmovi.PreUniMB * ((impuesto.ValPctIni / 100) + 1) end
												,		DescuentoLinea =  gmovi.TotalDescMov
												from	[' + @pv_BaseDatos + '].softland.iw_gsaen gsaen
													inner join [' + @pv_BaseDatos + '].softland.iw_gmovi gmovi
														on gsaen.NroInt = gmovi.NroInt
														and gsaen.Tipo = gmovi.Tipo
													left join [' + @pv_BaseDatos + '].softland.iw_gmovikit gmovikit
														on gsaen.NroInt = gmovikit.NroInt
													left join	(
	
																	select timprod.CodProd
																	,		timpval.ValPctIni
																	from [' + @pv_BaseDatos + '].softland.iw_timprod timprod
																	inner join [' + @pv_BaseDatos + '].softland.iw_timpto timpto
																		on timprod.CodImpto = timpto.CodImpto
																	inner join [' + @pv_BaseDatos + '].softland.iw_timpval timpval
																		on timpto.CodImpto = timpval.CodImpto
																	where	timpval.FecFinVig > getdate()
																) impuesto
														on gmovi.CodProd = impuesto.CodProd
												where	gmovi.Linea < 1000
												AND		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103) 
											) a
								) kitDetalle
						on GMOVI.nroint = kitDetalle.nroint
						and GMOVI.Linea = kitDetalle.Linea
						and GMOVI.CodProd = kitDetalle.CodProd
				WHERE	GSAEN.tipo != ''s'' 
				and		GSAEN.tipo != ''n'' 
				and		GSAEN.tipo != ''e'' 
				and		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103)
				AND		GSAEN.Estado = ''V'''
				select	@query04 = @query04 + '
				union all
				select	distinct 
						gsaen.tipo
				,		gsaen.subtipodocto
				,		gsaen.codcaja 
				,		PorcentajeDescuentoDocumento =	(
															isnull(gsaen.porcDesc01, 0)
														+	isnull(gsaen.porcDesc02, 0)
														+	isnull(gsaen.porcDesc03, 0)
														+	isnull(gsaen.porcDesc04, 0)
														+	isnull(gsaen.porcDesc05, 0)
														)
				,       gsaen.total as total_f
				,		'''' as descaja 
				,		gsaen.CentroDeCosto
				,		gmovi.linea 
				,		gsaen.FecHoraCreacionVW
				,		gsaen.codaux
				,		cwt.NomAux
				,		gsaen.folio
				,		gmovi.CodProd
				,		prod.esconfig as eskit 
				,		kitDetalle.PrecioFinalNeto
				,		kitDetalle.TotalFinalNeto
				,		kitDetalle.DescuentoLinea
				,		gmovi.kit 
				,		(case when gmovi.kit is null then gmovi.codprod else gmovi.kit end) as CKit 
				,		(case when gmovi.kit is null then prod.desprod else PKIT.DesProd end) as DKit
				,		prod.desprod 
				,		prod.CodGrupo
				,		grupo.DesGrupo 
				,		prod.CodSubGr 
				,		subGrupo.DesSubGr 
				,		(case when gmovi.kit is null then gmovi.CantFacturada
							else 
							(select sum(gm.CantFacturada) 
							from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
							where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/
							(select sum(kp.cantidad) 
							from [' + @pv_BaseDatos + '].softland.iw_tprkit kp 
							where kp.CodProd=GMOVI.KIT)
							end) as CantFacturada
				,		(case when gmovi.kit is null then round(gmovi.preunimb,1) 
						else 
						(round((select SUM(gm.TotalBoleta) 
						from  [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/1.19,1))/
						( (select sum(gm.CantFacturada) 
						from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/
						(select sum(kp.cantidad) 
						from [' + @pv_BaseDatos + '].softland.iw_tprkit kp 
						where kp.CodProd=GMOVI.KIT))
						end) as preunimb
				,		(case when gmovi.kit is null then round(gmovi.TotLinea,1) 
						else
						round((select SUM(gm.TotalBoleta) 
						from [' + @pv_BaseDatos + '].softland.iw_gmovi gm 
						where gm.NroInt=GMOVI.NroInt and gm.KIT=GMOVI.KIT)/1.19,1)
						end) as TotLinea
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
				--,		round((gmovi.TotLinea - ((((gmovi.TotLinea * 100) / gsaen.SubTotal) * gsaen.TotalDesc) / 100)), 1) as ValorconDescuento
				,		gmovi.TotalDescMov
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
						left JOIN [' + @pv_BaseDatos + '].[softland].vw_tcaja caja 
						ON caja.codCaja = gsaen.CodCaja
					left join [' + @pv_BaseDatos + '].[softland].cwtccos cwtccos
						ON gsaen.CentroDeCosto = cwtccos.CODICC
					left join 
								(
									select	*
									,		TotalFinalNeto = Convert(int, (Cantidad * precioFinalNeto))
									,		TotalFinalTotal = Convert(int, (Cantidad * precioFinalTotal))
									from	(
												select	kit
												,		gsaen.Folio
												,		gmovi.nroint
												,		gmovi.Linea
												,		codprod = gmovi.codprod
												--,		codprod = case when kit is not null then kit else gmovi.codprod end
												,		Cantidad = gmovi.CantFacturada
												,		precioFinalNeto = case when kit is not null then (((gmovikit.Precio * 100) / (100 + impuesto.ValPctIni))) else gmovi.PreUniMB end
												,		precioFinalTotal = case when kit is not null then gmovikit.Precio else gmovi.PreUniMB * ((impuesto.ValPctIni / 100) + 1) end
												,		DescuentoLinea =  gmovi.TotalDescMov
												from	[' + @pv_BaseDatos + '].softland.iw_gsaen gsaen
													inner join [' + @pv_BaseDatos + '].softland.iw_gmovi gmovi
														on gsaen.NroInt = gmovi.NroInt
														and gsaen.Tipo = gmovi.Tipo
													left join [' + @pv_BaseDatos + '].softland.iw_gmovikit gmovikit
														on gsaen.NroInt = gmovikit.NroInt
													left join	(
	
																	select timprod.CodProd
																	,		timpval.ValPctIni
																	from [' + @pv_BaseDatos + '].softland.iw_timprod timprod
																	inner join [' + @pv_BaseDatos + '].softland.iw_timpto timpto
																		on timprod.CodImpto = timpto.CodImpto
																	inner join [' + @pv_BaseDatos + '].softland.iw_timpval timpval
																		on timpto.CodImpto = timpval.CodImpto
																	where	timpval.FecFinVig > getdate()
																) impuesto
														on gmovi.CodProd = impuesto.CodProd
												where	gmovi.Linea < 1000
												AND		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103) 
											) a
								) kitDetalle
						on GMOVI.nroint = kitDetalle.nroint
						and GMOVI.Linea = kitDetalle.Linea
						and GMOVI.CodProd = kitDetalle.CodProd
				WHERE	GSAEN.tipo!=''s''
				AND		GSAEN.tipo!=''a''
				AND		GSAEN.tipo!=''e''
				AND		GSAEN.tipo!=''b''
				AND		GSAEN.FECHA BETWEEN CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaDesde, 112) + ''',103) AND CONVERT(DATETIME,''' + convert(varchar(8), @pv_FechaHasta, 112) + ''',103) 
				AND		GSAEN.Estado = ''V''
			) a
		) a
	--where a.[Cliente Folio] = ''10300001776''
	order by a.folio desc
	'
	exec
	(
		@query01
	+	@query02 
	+	@query03 
	+	@query04 
	+	@query05
	)
	/*
	print (@query01)
	print (@query02) 
	print (@query03) 
	print (@query04) 
	print (@query05)
	*/
	
	set nocount OFF
end  

GO
GO

IF OBJECT_ID('[dbo].[uSP_GET_ExcelVentas]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[uSP_GET_ExcelVentas] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[uSP_GET_ExcelVentas]')
END
