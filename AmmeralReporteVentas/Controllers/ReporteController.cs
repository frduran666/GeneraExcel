using AmmeralReporteVentas.UTIL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL;

namespace AmmeralReporteVentas.Controllers
{
    public class ReporteController : BaseController
    {
        // GET: Reporte
        public ActionResult Index()
        {
            return View();
        }

        // GET: Reporte
        public ActionResult ReporteVentas()
        {
            return View();
        }


        [HttpPost]
        public JsonResult GenerarReporteVentas(string fechaDesde, string fechaHasta)
        {
            try
            {
                string mapPath = System.Web.Hosting.HostingEnvironment.MapPath("~/ArchivosTemporales/");

                DateTime fechaDesdeDT = DateTime.Parse(fechaDesde);
                DateTime fechaHastaDT = DateTime.Parse(fechaHasta);

                string path = new AmmeralReporteVentas.UTIL.Excel.EXCEL(controlDisofi()).generarExcelReporteVentas(baseDatosUsuario(), mapPath, fechaDesdeDT, fechaHastaDT);

                SessionVariables.SESSION_RUTA_ARCHIVO_VENTAS = path;

                return Json(new { Verificador = true });
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                var frame = st.GetFrame(0);

                var line = frame.GetFileLineNumber();
                var file = frame.GetFileName();

                LogUser.agregarLog(file + "");
                LogUser.agregarLog(line + "");
                LogUser.agregarLog(ex.Message);
                return Json(new { Verificador = false });
            }
        }

        public ActionResult DescargarArchivoVentas()
        {
            string path = SessionVariables.SESSION_RUTA_ARCHIVO_VENTAS;
            return DescargarArchivo(path, "Reporte Ventas");
        }

    }
}