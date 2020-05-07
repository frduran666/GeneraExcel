using BLL;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using OfficeOpenXml.Table;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using UTIL;
using UTIL.Models;

namespace AmmeralReporteVentas.UTIL.Excel
{
    public class EXCEL : FuncionesEXCEL
    {
        List<string> estilosAll = new List<string>();
        ControlDisofi controlDisofi = null;

        public EXCEL(ControlDisofi controlDisofi) : base()
        {
            this.controlDisofi = controlDisofi;
        }

        public string generarExcelReporteVentas(string baseDatos, string ruta, DateTime fechaDesde, DateTime fechaHasta)
        {
            DataTable tabla = controlDisofi.obtenerExcelVentas(baseDatos, fechaDesde, fechaHasta);

            LogUser.agregarLog("Tabla: " + (tabla == null ? "null" : (tabla.Rows.Count + "")));

            string rutaCompletaArchivo = generarExcel(ruta, "#FFDA68", tabla, "Reporte Ventas");

            return rutaCompletaArchivo;
        }

        private string generarExcel(string ruta, string colorHoja, DataTable datos, string nombreHoja)
        {
            string rutaCompletaArchivo = "";
            rutaCompletaArchivo = ruta + "excel_" + DateTime.Now.ToString("yyyyMMdd_HHmmss.fff") + ".xlsx";

            ExcelPackage pck = new ExcelPackage();

            TablaHojaModel tablaHoja1 = new TablaHojaModel();
            tablaHoja1.ConColumna = true;
            tablaHoja1.X = 0;
            tablaHoja1.Y = 0;
            tablaHoja1.Tabla = datos;

            pck = crearHoja(pck, new List<TablaHojaModel>() { tablaHoja1 }, nombreHoja, colorHoja);


            if (pck.Workbook.Worksheets.Count == 0)
            {
                TablaHojaModel tablaHojaDefault = new TablaHojaModel();
                tablaHojaDefault.ConColumna = false;
                tablaHojaDefault.X = 0;
                tablaHojaDefault.Y = 0;
                tablaHojaDefault.Tabla = new DataTable();

                pck = crearHoja(pck, new List<TablaHojaModel>() { tablaHojaDefault }, "SIN DATOS", null);
            }

            byte[] dataByte = pck.GetAsByteArray();

            File.WriteAllBytes(rutaCompletaArchivo, dataByte);

            return rutaCompletaArchivo;
        }

        private ExcelPackage crearHoja(ExcelPackage excelPackage, List<TablaHojaModel> datas, string nombreHoja, string colorHoja)
        {
            ExcelPackage excelPackageTemp = excelPackage;
            ExcelWorksheet hojaEstilo = excelPackageTemp.Workbook.Worksheets.Add(nombreHoja);

            hojaEstilo = crearCuerpo(hojaEstilo, datas);

            hojaEstilo.Cells.AutoFitColumns();
            if (colorHoja != null && colorHoja != "")
            {
                Color colFromHex = System.Drawing.ColorTranslator.FromHtml(colorHoja);
                hojaEstilo.TabColor = colFromHex;
            }

            return excelPackageTemp;
        }
        private ExcelWorksheet crearCuerpo(ExcelWorksheet hojaEstilo, List<TablaHojaModel> datas)
        {
            hojaEstilo.Cells["A1"].Value = "Template for PBI";
            hojaEstilo.Cells["A2"].Value = "";
            for (int z = 0; z < datas.Count; z++)
            {
                if (datas[z].ConColumna)
                {
                    for (int y = 0; y < datas[z].Tabla.Columns.Count; y++)
                    {
                        string celda = obtenerPosicionExcel(datas[z].X, datas[z].Y + y).nombreCelda;
                        hojaEstilo.Cells[celda].Value = datas[z].Tabla.Columns[y];

                        hojaEstilo.Cells[celda].Style.Border.Top.Style = ExcelBorderStyle.Medium;
                        hojaEstilo.Cells[celda].Style.Border.Left.Style = ExcelBorderStyle.Medium;
                        hojaEstilo.Cells[celda].Style.Border.Right.Style = ExcelBorderStyle.Medium;
                        hojaEstilo.Cells[celda].Style.Border.Bottom.Style = ExcelBorderStyle.Medium;
                    }
                }

                NumberFormatInfo nfi = new CultureInfo("is-IS", false).NumberFormat;
                nfi = (NumberFormatInfo)nfi.Clone();
                nfi.CurrencySymbol = "";
                nfi.CurrencyPositivePattern = 0;
                nfi.CurrencyDecimalSeparator = ".";


                for (int x = 0; x < datas[z].Tabla.Rows.Count; x++)
                {
                    for (int y = 0; y < datas[z].Tabla.Columns.Count; y++)
                    {
                        string celda = obtenerPosicionExcel((datas[z].ConColumna ? ((datas[z].X + 1) + x) : ((datas[z].X) + x)), datas[z].Y + y).nombreCelda;

                        //hojaEstilo.Cells[celda].Value = datas[z].Tabla.Rows[x][y];

                        hojaEstilo.Cells[celda].Value = string.Format(nfi,"{0:n}", datas[z].Tabla.Rows[x][y]); //"{0:C}"

                        hojaEstilo.Cells[celda].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        hojaEstilo.Cells[celda].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        hojaEstilo.Cells[celda].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        hojaEstilo.Cells[celda].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    }
                }
            }

            return hojaEstilo;
        }
    }
}