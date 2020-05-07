using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmmeralReporteVentas.UTIL.Excel
{
    public class PosicionExcel
    {
        public int x { get; set; }
        public int y { get; set; }
        public string columna { get; set; }
        public int fila { get; set; }
        public string nombreCelda { get; set; }
    }
}