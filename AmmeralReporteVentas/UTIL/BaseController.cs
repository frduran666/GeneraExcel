using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL;
using UTIL.Models;

namespace AmmeralReporteVentas.UTIL
{
    public class BaseController : Controller
    {
        private ControlDisofi _control = new ControlDisofi();

        public string baseDatosUsuario()
        {
            LogUser.agregarLog(Newtonsoft.Json.JsonConvert.SerializeObject(SessionVariables.SESSION_DATOS_USUARIO));
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel.BaseDatos;
            //return "ast";
        }
        public UsuarioEmpresaModel EmpresaUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel;
        }
        public UsuarioModel obtenerUsuario()
        {
            return SessionVariables.SESSION_DATOS_USUARIO;
        }

        public ControlDisofi controlDisofi()
        {
            return _control;
        }

        public ActionResult DescargarArchivo(string path, string nombreArchivo = "")
        {
            byte[] fileBytes = System.IO.File.ReadAllBytes(path);
            string fileName = new System.IO.FileInfo(path).Name;
            string fileExtension = new System.IO.FileInfo(path).Extension;

            nombreArchivo = nombreArchivo == "" ? fileName : nombreArchivo;

            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, nombreArchivo + fileExtension);
        }
    }
}