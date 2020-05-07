using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL.Models
{
    public class UsuarioModel
    {
        public int Id { get; set; }
        public string Nombres { get; set; }
        public int IdTipo { get; set; }
        public string CodigoUsuario { get; set; }
        public string CentroCosto { get; set; }
        public string UrlInicio { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }
        public string Cliente { get; set; }
        public string NombreCliente { get; set; }
        public string Email { get; set; }
        public UsuarioEmpresaModel UsuarioEmpresaModel { get; set; }
    }
}
