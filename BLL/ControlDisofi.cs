using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTIL.Models;

namespace BLL
{
    public class ControlDisofi
    {
        private FactoryAcceso _Control = new FactoryAcceso();

        public List<UsuarioModel> login(UsuarioModel usuario)
        {
            return _Control.login(usuario);
        }
        public List<UsuarioEmpresaModel> obtenerEmpresasUsuario(UsuarioModel usuario)
        {
            return _Control.obtenerEmpresasUsuario(usuario);
        }
        public DataTable obtenerExcelVentas(string baseDatos, DateTime fechaDesde, DateTime fechaHasta)
        {
            return _Control.obtenerExcelVentas(baseDatos, fechaDesde, fechaHasta);
        }
    }
}
