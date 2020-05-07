using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UTIL
{
    public class LogUser
    {
        public static void agregarLog(string texto)
        {
            string path;

            path = ConfigurationManager.AppSettings["RutaLog"];

            string wvarLogFile = path + "log_" + DateTime.Now.ToString("yyyyMMdd") + ".txt";

            try
            {
                StreamWriter wvarfichTMP = new StreamWriter(wvarLogFile, true);

                wvarfichTMP.WriteLine(DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss.fff") + " - " + texto);

                wvarfichTMP.Close();

                wvarfichTMP = null;
            }
            catch (Exception e)
            {
                string wvarA = e.Message.ToString();
            }
        }
    }
}
