using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Data;

namespace PK.Models
{
    public class Baza
    {
        SqlConnection con;
        SqlCommand comm;
        SqlConnectionStringBuilder pol;
        SqlDataReader red;
        public string test = "x";

        public Baza()
        {
            pol = new SqlConnectionStringBuilder
            {
                DataSource = @"DESKTOP-L0C1C7J\SQLEXPRESS",                        /// tutaj logowanie do bazy jeśli nie ma autoryzacji windows
                UserID = "",
                Password = "",
                IntegratedSecurity = true,
                InitialCatalog = "Sklep"
            };

            Test();
        }

        private void Test()
        {
            con = new SqlConnection(pol.ConnectionString);
            try
            {
                con.Open();
                test = "połączenie nawiązane";
                con.Close();
            }
            catch (SqlException exc)
            {
                test = exc.Message.ToString();
            }
        }

        public IEnumerable<Lista> Zapytanie(int typ, int kategoria)
        {
            string zapytanie = @"SELECT  P.id,P.nazwa,P.cena_netto,P.Stawka_podatku,P.opis_produktu,P.rok_produkcji,P.Autor,R.nazwa,K.nazwa,P.id_kat,P.Rodzaj_produkcji 
                                FROM Produkt P,Rodzaj R,Kategoria K
                                WHERE (P.Rodzaj_produkcji=" + typ + " AND P.id_kat=" + kategoria + ") AND (P.Rodzaj_produkcji=R.ID AND P.id_kat=K.id)";
            using (comm = new SqlCommand(zapytanie, con))
            {
                try
                {
                    con.Open();
                    List<Lista> wynik = new List<Lista>();
                    red = comm.ExecuteReader();
                    while (red.Read())
                    {
                        Lista lista = new Lista
                        {
                            ID = red.GetInt32(0),
                            Nazwa = red.GetString(1),
                            Cena_netto = red.GetDecimal(2),
                            Stawka = red.GetDouble(3),
                            Opis_produktu = red.GetString(4),
                            Rok = red.GetInt32(5),
                            Autor = red.GetString(6),
                            Typ2 = red.GetString(7),
                            Kat2 = red.GetString(8),
                            Typ = red.GetInt32(9),
                            Kat = red.GetInt32(10),
                        };

                        wynik.Add(lista);
                    }
                    con.Close();
                    return wynik;
                }
                catch (Exception exc)
                {
                    con.Close();
                    throw exc;
                }
            }
        }

        public bool Rejestruj(Osoba osoba) //dodac sprawdzanie dublowania konta
        {
            bool weryfikacja;
            if (!Sprawdz_czy_zajety(osoba))
            {
                using (comm = new SqlCommand("Rejestr", con))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.Add("@a1", SqlDbType.VarChar).Value = osoba.Login;
                    comm.Parameters.Add("@a2", SqlDbType.VarChar).Value = osoba.Haslo;
                    comm.Parameters.Add("@a3", SqlDbType.VarChar).Value = osoba.Imie;
                    comm.Parameters.Add("@a4", SqlDbType.VarChar).Value = osoba.Nazwisko;
                    comm.Parameters.Add("@a5", SqlDbType.VarChar).Value = osoba.Miasto;
                    comm.Parameters.Add("@a6", SqlDbType.VarChar).Value = osoba.Miejscowosc;
                    comm.Parameters.Add("@a7", SqlDbType.VarChar).Value = osoba.Wojewodztwo;
                    comm.Parameters.Add("@a8", SqlDbType.VarChar).Value = osoba.Mail;
                    comm.Parameters.Add("@a9", SqlDbType.VarChar).Value = osoba.Kod;
                    comm.Parameters.Add("@a10", SqlDbType.VarChar).Value = osoba.Ulica;
                    comm.Parameters.Add("@a11", SqlDbType.VarChar).Value = osoba.Nr_domu;
                    try
                    {
                        con.Open();
                        comm.ExecuteNonQuery();
                        weryfikacja = true;
                    }
                    catch
                    {
                        weryfikacja = false;
                    }
                    finally
                    {
                        con.Close();
                    }

                }
            }
            else
            {
                weryfikacja = false;
            }
            return weryfikacja;
        }

        public (string,int) Loguj(string log, string has)
        {
            string zapytanie = "SELECT TOP 1 id,login FROM Klient WHERE (login LIKE '" + log + "') AND (haslo LIKE HASHBYTES('SHA1','" + has+"'))";
            using (comm = new SqlCommand(zapytanie, con))
            {
                try
                {
                    string login=null;
                    int id=0;
                    con.Open();
                    red = comm.ExecuteReader();
                     while (red.Read())
                    {
                    id = red.GetInt32(0);
                    login = red.GetString(1);
                    }                     
                    con.Close();
                    return (login,id);
                }
                catch (SqlException exc)
                {
                    con.Close();
                    throw exc;
                }
            }
        }

        private bool Sprawdz_czy_zajety(Osoba osoba)
        {
            bool zajety=false;
            using (comm = new SqlCommand("Spr_klienta", con))
            {
                comm.CommandType = CommandType.StoredProcedure;

                comm.Parameters.Add("@a1", SqlDbType.VarChar).Value = osoba.Login;
                try
                {
                    con.Open();
                    if((int)comm.ExecuteScalar()>0)
                        zajety = true;
                }
                catch
                {
                    zajety = false;
                }
                finally
                {
                    con.Close();
                }

            }

            return zajety;
        }

        public List<int> Kupione(int log)
        {
            List<int> zakupione = new List<int>();
            string zapytanie = "SELECT id_produkt FROM Koszyk where id_klient="+ log+ " AND id_Zamowienie IS NOT NULL";
            using (comm = new SqlCommand(zapytanie, con))
            {
                try
                {
                    con.Open();
                    red = comm.ExecuteReader();
                    while (red.Read())
                    {
                        zakupione.Add(red.GetInt32(0));
                    }
                    con.Close();
                }
                catch (Exception exc)
                {
                    con.Close();
                    throw exc;
                }

            }

            return zakupione;
        }

        public List<int> Koszyk(int log)
        {
            List<int> Koszyk = new List<int>();
            string zapytanie = "SELECT id_produkt FROM Koszyk where id_klient=" + log;
            using (comm = new SqlCommand(zapytanie, con))
            {
                try
                {
                    con.Open();
                    red = comm.ExecuteReader();
                    while (red.Read())
                    {
                        Koszyk.Add(red.GetInt32(0));
                    }
                    con.Close();
                }
                catch (Exception exc)
                {
                    con.Close();
                    throw exc;
                }

            }

            return Koszyk;
        }

        public bool DodajDoKoszyka(int id,int p)
        {
            int wykonanie;
            string zapytanie = "INSERT INTO Koszyk VALUES ("+id+",null,"+p+")";
            using (comm = new SqlCommand(zapytanie, con))
            {
                con.Open();
                try
                {
                    wykonanie = (int)comm.ExecuteScalar();
                    if (wykonanie == 1)
                        return true;
                    else
                        return false;
                }
                catch(Exception e)
                {
                    return false;
                }
                finally
                {
                    con.Close();
                }
                
            }
        }
        public bool UsunZKoszyka(int id, int p)
        {
            int wykonanie;
            string zapytanie = "DELETE FROM Koszyk WHERE id_klient="+id+"  AND  id_produkt="+p+ " AND id_Zamowienie IS NULL";
            using (comm = new SqlCommand(zapytanie, con))
            {
                con.Open();
                try
                {
                    wykonanie = (int)comm.ExecuteScalar();
                    if (wykonanie == 1)
                        return true;
                    else
                        return false;
                }
                catch (Exception e)
                {
                    return false;
                }
                finally
                {
                    con.Close();
                }

            }
        }

        public List<Lista> ZakupLista(int id)
        {
            string zapytanie =@"SELECT  P.id,P.nazwa,P.cena_netto,P.Stawka_podatku,R.nazwa 
                                FROM Produkt P, Rodzaj R, Koszyk K 
                                WHERE (P.Rodzaj_produkcji=R.id AND K.id_produkt=P.id) AND (K.id_klient="+id+" AND K.id_Zamowienie IS NULL)";
            using (comm = new SqlCommand(zapytanie, con))
            {
                try
                {
                    con.Open();
                    List<Lista> wynik = new List<Lista>();
                    red = comm.ExecuteReader();
                    while (red.Read())
                    {
                        Lista lista = new Lista
                        {
                            ID = red.GetInt32(0),
                            Nazwa = red.GetString(1),
                            Cena_netto = red.GetDecimal(2),
                            Stawka = red.GetDouble(3),
                            Typ2 = red.GetString(4),
                        };

                        wynik.Add(lista);
                    }
                    con.Close();
                    return wynik;
                }
                catch (Exception exc)
                {
                    con.Close();
                    throw exc;
                }
            }
        }

        public bool Zamowienie(int id)
        {
            bool zamowienie = false;
            using (comm = new SqlCommand("PotwZam", con))
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                try
                {
                    con.Open();
                    comm.ExecuteScalar();
                    zamowienie = true;
                }
                catch
                {
                    zamowienie = false;
                }
                finally
                {
                    con.Close();
                }
            }
            return zamowienie;
        }
    }
}
