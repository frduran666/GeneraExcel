using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    [Serializable]
    public class CapturaExcepciones : Exception
    {
        public CapturaExcepciones(Exception e)
        {
        }
    }
}
