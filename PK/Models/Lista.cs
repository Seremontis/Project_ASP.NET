using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PK.Models
{
    public struct Lista
    {
        public int ID { get; set; }
        public string Nazwa { get; set; }
        public decimal Cena_netto { get; set; }
        public double Stawka { get; set; }   
        public string Opis_produktu { get; set; }
        public int Rok { get; set; }
        public string Autor { get; set; }
        public string Typ2 { get; set; }
        public string Kat2 { get; set; }
        public int Typ { get; set; }
        public int Kat { get; set; }
    }
}
