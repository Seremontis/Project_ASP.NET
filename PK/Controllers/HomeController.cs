using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PK.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using System.Collections;

namespace PK.Controllers
{
    public class HomeController : Controller
    {
        private Baza baza;


        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }

        public IActionResult Index1(string login = null, string haslo = null,bool rejestracja=false)
        {
            if (rejestracja == false)
            {
                if (HttpContext.Session.GetString("Login") == null)
                {
                    if (login == null && haslo == null)
                    {
                        HttpContext.Session.Clear();
                        return RedirectToAction("Index");
                    }

                    baza = new Baza();
                    string loginn = baza.Loguj(login, haslo).Item1;
                    int id = baza.Loguj(login, haslo).Item2;

                    if (loginn != null && loginn != "")
                    {
                        HttpContext.Session.SetString("Login", loginn);
                        HttpContext.Session.SetInt32("Loginid", id);
                    }
                    else
                        ViewData["logowanie"] = "Logowanie nie przebiegła pomyślnie";
                }
                else
                {
                    return View();
                }
            }               
            else
                ViewData["logowanie"] = "Logowanie nie przebiegła pomyślnie";
            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        public IActionResult Searchfilter(int typ, int kategoria)
        {

            baza = new Baza();
            List<int> kupione=new List<int>();
            List<int> koszyk = new List<int>();
            IEnumerable<Lista> wynik = baza.Zapytanie(typ, kategoria);
            ViewData["typ2"] = wynik.First().Typ2.ToString();
            ViewData["kat2"] = wynik.First().Kat2.ToString();
            ViewData["typ"] = typ;
            ViewData["kat"] = kategoria;
            if (HttpContext.Session.GetString("Login") != null && HttpContext.Session.GetString("Login") != "")
            {
                kupione=new List<int>(baza.Kupione((int)HttpContext.Session.GetInt32("Loginid")));
                ViewData["zakupione"] = kupione.ToArray();
                
                koszyk = new List<int>(baza.Koszyk((int)HttpContext.Session.GetInt32("Loginid")));
                ViewData["koszyk"] =koszyk.ToArray();
            }
            return View(wynik);
        }

        public IActionResult SearchAdd(int a, int typp, int kategoriaa)
        {
            baza = new Baza();
            baza.DodajDoKoszyka((int)HttpContext.Session.GetInt32("Loginid"), a);
            var routeValues = new RouteValueDictionary {
              { "typ", typp },
              { "kategoria",  kategoriaa }
            };

            return RedirectToAction("Searchfilter", "Home", routeValues);
        }
        public IActionResult SearchRem(int a, int typp, int kategoriaa)
        {
            baza = new Baza();
            baza.UsunZKoszyka((int)HttpContext.Session.GetInt32("Loginid"), a);
            if (typp != 0 && kategoriaa != 0)
            {
                var routeValues = new RouteValueDictionary {
              { "typ", typp },
              { "kategoria",  kategoriaa }
                };

                return RedirectToAction("Searchfilter", "Home", routeValues);
            }
            else
            {
                return RedirectToAction("Podsumowanie", "Home");
            }

    }

        [HttpPost]
        public IActionResult Rejestracja(Osoba osoba = null,bool uruchom=false)
        {
            if(osoba!=null && uruchom!=true)
            {
                baza = new Baza();
                
                bool spr = baza.Rejestruj(osoba);
                if (spr)
                    return RedirectToAction("Index");
                else
                {
                    ViewData["blad"] = "Podane dane mogą być już zajęte bądź też nie ma obecnie połącznia z serwerem";
                }
                
            }
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult Podsumowanie()
        {
            baza = new Baza();
            IEnumerable<Lista> wynik = baza.ZakupLista((int)HttpContext.Session.GetInt32("Loginid"));
            return View(wynik);
        }

        public IActionResult ZatwierdzZam()
        {
            baza = new Baza();
            bool wynik = baza.Zamowienie((int)HttpContext.Session.GetInt32("Loginid"));
            if (wynik == true)
            {
                HttpContext.Session.SetInt32("WykZam", 1);
            }
            else
            {
                HttpContext.Session.SetInt32("WykZam", 0);
            }
            return RedirectToAction("Index1");
        }
    }
}
