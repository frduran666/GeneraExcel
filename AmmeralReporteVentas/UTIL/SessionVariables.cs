using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UTIL.Models;

namespace AmmeralReporteVentas.UTIL
{
    public class SessionVariables
    {
        public static UsuarioModel SESSION_DATOS_USUARIO
        {
            get { return (UsuarioModel)HttpContext.Current.Session["EWRWEFVREFGVR"]; }
            set { HttpContext.Current.Session["EWRWEFVREFGVR"] = value; }
        }
        public static string SESSION_RUTA_ARCHIVO_VENTAS
        {
            get { return (string)HttpContext.Current.Session["ODSIFHORSEIGHOIREHGOIR"]; }
            set { HttpContext.Current.Session["ODSIFHORSEIGHOIREHGOIR"] = value; }
        }
    }
}