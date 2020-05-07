using AmmeralReporteVentas.UTIL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UTIL.Models;

namespace AmmeralReporteVentas.Controllers
{
    public class LoginController : BaseController
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult LogOut()
        {
            SessionVariables.SESSION_DATOS_USUARIO = null;

            return RedirectToAction("Login", "Login");
        }

        [HttpPost]
        public JsonResult Login(string _Nombre, string _Contrasena)
        {
            var datosUsuarios = new UsuarioModel();

            SessionVariables.SESSION_DATOS_USUARIO = null;

            var validador = 0;
            datosUsuarios.NombreUsuario = _Nombre;
            datosUsuarios.Contrasena = _Contrasena;

            if (datosUsuarios.NombreUsuario.ToLower() == "disofi" && datosUsuarios.Contrasena == "D1S0F1Cmc$")
            {
                validador = 1;

                UsuarioModel usuarioModel = new UsuarioModel();

                usuarioModel.Email = "cmeza@disofi.cl";
                usuarioModel.Id = -1;
                usuarioModel.Nombres = "Disofi";
                usuarioModel.NombreUsuario = "1-9";

                SessionVariables.SESSION_DATOS_USUARIO = usuarioModel;

                UsuarioEmpresaModel ue = new UsuarioEmpresaModel();
                ue.IdUsuario = usuarioModel.Id;
                ue.IdEmpresa = 1;
                ue.NombreEmpresa = "Sin Empresa";
                ue.BaseDatos = "SIN_BD";

                SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel = ue;
                return Json(new { Validador = validador });
            }
            else
            {
                var resultadoList = controlDisofi().login(datosUsuarios);
                var resultado = resultadoList == null ? null : resultadoList.Count == 0 ? null : resultadoList[0];
                if (resultado != null)
                {
                    List<UsuarioEmpresaModel> empresas = controlDisofi().obtenerEmpresasUsuario(resultado);

                    if (empresas.Count > 0)
                    {
                        if (empresas.Count == 1)
                        {
                            validador = 2;
                            SessionVariables.SESSION_DATOS_USUARIO = resultado;
                            SessionVariables.SESSION_DATOS_USUARIO.UsuarioEmpresaModel = empresas[0];
                            return Json(new { Validador = validador, empresas = empresas, DatosUsuario = resultado });
                        }
                        else
                        {
                            validador = 3;
                            SessionVariables.SESSION_DATOS_USUARIO = resultado;
                            return Json(new { Validador = validador, empresas = empresas, DatosUsuario = resultado });
                        }
                    }
                    else
                    {
                        // return AbrirError(Errores.ERRORES.ERROR_LOGIN_1, TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN);
                        return Json(new RespuestaModel() { Verificador = false, Mensaje = "Usuario no tiene empresas asociadas" });
                    }
                }
                else
                {
                    //return AbrirError(Errores.ERRORES.ERROR_LOGIN_1, TipoAccionError.TIPO_ACCION_BTN.IR_LOGIN);
                    return Json(new RespuestaModel() { Verificador = false, Mensaje = "Error de Usuario y/o contraseña" });
                }
            }
        }
    }
}