using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmmeralReporteVentas.UTIL
{
    public class ActualizacionJS
    {
        private static string parametro = "";
        private static bool paso = false;

        public static string obtenerParametro()
        {
            if (!paso)
            {
                parametro = "ac=" + DateTime.Now.ToString("yyyyMMddhhmmss");
                paso = true;
            }

            return parametro;
        }
    }
}