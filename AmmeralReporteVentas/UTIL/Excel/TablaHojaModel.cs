using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AmmeralReporteVentas.UTIL.Excel
{
    public class TablaHojaModel
    {
        public int X { get; set; }
        public int Y { get; set; }
        public bool ConColumna { get; set; }
        public DataTable Tabla { get; set; }
    }
}