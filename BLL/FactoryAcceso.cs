using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTIL.Models;
using UTIL.Validaciones;

namespace BLL
{
    public class FactoryAcceso
    {
        public List<UsuarioModel> login(UsuarioModel usuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("uSP_Login", new System.Collections.Hashtable()
                {
                    { "pv_Usuario", usuario.NombreUsuario },
                    { "pv_Contrasena", usuario.Contrasena },
                    { "pv_ContrasenaMD5", HashMd5.GetMD5(usuario.Contrasena) },
                });

                return UTIL.Mapper.BindDataList<UsuarioModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<UsuarioEmpresaModel> obtenerEmpresasUsuario(UsuarioModel usuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("uSP_GET_EmpresasUsuario", new System.Collections.Hashtable()
                {
                    { "pi_IdUsuario", usuario.Id },
                });

                return UTIL.Mapper.BindDataList<UsuarioEmpresaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public DataTable obtenerExcelVentas(string baseDatos, DateTime fechaDesde, DateTime fechaHasta)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("uSP_GET_ExcelVentas", new System.Collections.Hashtable()
                {
                    { "pv_BaseDatos", baseDatos },
                    { "pv_FechaDesde", fechaDesde.ToString("yyyyMMdd") },
                    { "pv_FechaHasta", fechaHasta.ToString("yyyyMMdd") },
                });

                return data;
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
    }
}