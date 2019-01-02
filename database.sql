Create database Sklep

GO

USE Sklep

GO

CREATE TABLE Kategoria
(
	id			INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nazwa		VARCHAR(30),
)

GO

CREATE TABLE Rodzaj
(
	id			INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nazwa		VARCHAR(30),
)

GO

CREATE TABLE Produkt
(
	id					INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nazwa				VARCHAR(50),
	cena_netto			MONEY,
	Stawka_podatku		FLOAT,
	opis_produktu		TEXT,
	rok_produkcji		int,
	Autor				VARCHAR(50),
	Rodzaj_produkcji	int FOREIGN KEY REFERENCES Rodzaj(id),
	id_kat				int FOREIGN KEY REFERENCES Kategoria(id)
)

Go



CREATE TABLE Klient
(
	id					INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	login				VARCHAR(15),
	haslo				VARCHAR(15),
	imie				VARCHAR(60),
	nazwisko			VARCHAR(70),	
	miasto				VARCHAR(60),
	miejscowosc			VARCHAR(60),
	wojewodzctwo		VARCHAR(30),
	email				VARCHAR(30),
	kod_pocztowy		VARCHAR(6),
	Ulica				VARCHAR(50),
	nr_mieszkania		VARCHAR(5)
)


GO

CREATE TABLE Zamowienie
(
	id							INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	zamowienie_nr				INT,
	Data_zlozenia_zamowienia	DATETIME2
)

GO

CREATE TABLE Koszyk
(
	id					INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	id_klient			int FOREIGN KEY REFERENCES Klient(id),
	id_Zamowienie		int FOREIGN KEY REFERENCES Zamowienie(id),
	id_produkt			int FOREIGN KEY REFERENCES Produkt(id)
)


GO

INSERT INTO  Kategoria (nazwa)
	VALUES 
		('Horror'),
		('Komedia'),
		('Romans'),
		('Akcja'),	
		('Tragedia')

GO

INSERT INTO  Rodzaj (nazwa)
	VALUES 
		('Film'),
		('Serial')

GO

INSERT INTO  Produkt (nazwa,cena_netto,Stawka_podatku,opis_produktu,rok_produkcji,Autor,Rodzaj_produkcji,id_kat)
	VALUES
		('Annabel',20,0.13,'to bardzo klasyczny horror. 
		Odwo�uje si� do najprostszych rozwi�za� fabularnych i 
		bazuje przede wszystkim na konsekwentnym budowaniu napi�cia.',
		2014,'John R.Leonetti',1, 1),
		('Obecno�� 2',25,0.23,'Lorraine i Ed Warren udaj� si� do 
		p�nocnej cz�ci Londynu, aby pom�c samotnej matce wychowuj�cej 
		czw�rk� dzieci, kt�rej dom jest nawiedzany przez z�o�liwe duchy.',
		2016,'James Wan',1, 1),
		('Zakonnica',23,0.18,'Kobieta ginie w niewyja�nionych okoliczno�ciach. 
		Jej dawne przyjaci�ki podejrzewaj�, �e chodzi o tajemnic� sprzed lat.',
		2018,'Corin Hardy',1, 1),
		('Ciche miejsce',19,0.12,'Pi�cioosobowa rodzina stara si� przetrwa� w 
		�wiecie pe�nym potwor�w, kt�re stanowi� �miertelne niebezpiecze�stwo, 
		a zwabia je najmniejszy ha�as.',2018,'John Krasinksi',1, 1),
		('Sierociniec',12,0.23,'Laura z m�em i adoptowanym synem wprowadza si� 
		do pustego sieroci�ca. Ich dziecko zaczyna bawi� si� z niewidzialnymi kolegami.',
		2007,'J.A. Bayona',1, 1),
		('Wkr�ceni',19,0.24,'Zwolnieni pracownicy fabryki samochod�w postanawiaj� 
		wyda� swoje odprawy na szalony wyjazd do Warszawy.',
		2013,'Piotr Were�niak',1, 2),
		('Porady na zdrady',11,0.11,'Dwie kobiety, Kalina i Fretka, 
		zostawione przez swoich partner�w zak�adaj� firm�, w kt�rej chc� 
		zajmowa� si� rozwi�zywaniem problem�w z niewierno�ci� facet�w.',
		2017,'Ryszard Zatorski',1, 2),
		('Gwiazd naszych wina',32,0.12,'Cierpi�ca na raka tarczycy Hazel 
		za namow� rodzic�w idzie na spotkanie grupy wsparcia.',
		2014,'Josh Boone',1, 3),
		('Nowe oblicze Greya',12,0.12,'Christian i Ana wiod� pe�ne dostatku i 
		mi�o�ci �ycie. Ich spok�j zak��ca jej by�y szef, kt�ry chce si� na niej zem�ci�.',
		2018,'James Foley',1, 3),
		('Ka�dego dnia',34,0.22,'16-letnia dziewczyna poznaje ch�opaka, 
		kt�ry dzieli si� z ni� niezwyk�� tajemnic�. Nastolatek ka�dego dnia budzi 
		si� w ciele kogo� innego.',2018,'Michael Sucsy',1, 3),
		('Zanim si� pojawi�e�',12,0.18,'Dziewczyn� z ma�ego miasteczka zaczyna 
		��czy� wi� ze sparali�owanym m�czyzn�, kt�rym si� opiekuje.',
		2016,'Thea Sharrock',1, 3),
		('Iniemamocni 2',11,0.11,'Podczas gdy Bob Parr zmaga si� z problemami 
		wychowawczymi swoich dzieci, jego �ona Helen, znana tak�e, jako Elastyna, 
		realizuje swe aspiracje, podejmuj�c prac� w lidze antyprzest�pczej.',
		2018, 'Brad Bird',1, 4),
		('Ant-Man i Osa',32,0.12,'Ant-man i Osa pr�buj� odkry� tajemnice 
		przesz�o�ci doktora Hanka Pyma i Hope van Dyne.',
		2018,'Peyton Reed',1, 4),
		('Deadpool',11,0.31,'By�y �o�nierz oddzia��w specjalnych zostaje 
		poddany niebezpiecznemu eksperymentowi. Niebawem uwalnia swoje alter 
		ego i rozpoczyna polowanie na cz�owieka, kt�ry niemal zniszczy� jego �ycie. ',
		2016,'Tim Miller',1, 4),
		('SIEDEM DUSZ',15,0.12,'Ben Thomas pragnie odkupi� swoje winy.
		W tym celu wyrusza w niezwyk�� podr� z zamiarem ocalenia siedmiorga ludzi.',
		2008,'Gabriele Muccino',1, 5),
		('WSZYSTKO GRA',12,0.13,'Chris Wilton, m�ody, wywodz�cy si� z biednej 
		irlandzkiej rodziny instruktor tenisa, dostaje szans� awansu spo�ecznego.',
		2005,'Woody Allen',1, 5),
		('Opowie�ci z krypty',42,0.08,'Klasyczne ju� opowie�ci grozy powsta�e 
		na bazie serii komiks�w z lat 50. Odcinki nie s� powi�zane ze sob� 
		fabularnie, ka�dy opowiada inn� histori� � s� w�r�d nich epizody gore, 
		opowie�ci o duchach i troch� science fiction.',
		1989,'Russel Mulcahy', 1,5),
		('Z Archiwum X',9,0.11,'Zakwalifikowanie �Z archiwum X� do 
		jakiegokolwiek rodzaju jest raczej niemo�liwe, za to zaskakuj�co 
		wiele odcink�w tego serialu to prawdziwe, niczym niezafa�szowane horrory, 
		kt�re mo�na uzna� za klasyki gatunku.',
		1993,'Chris Carter',2, 1),
		('Kr�lestwo',20,0.23,'ultowy ju� miniserial Larsa von Triera � 
		bardzo dziwny, bardzo oniryczny i bardzo europejski. �Kr�lestwo� 
		to surrealistyczne po��czenie serialu medycznego z duszn� atmosfer� 
		prawdziwego horroru i specyficznym, bardzo czarnym humorem.',
		1994,'Lars von Trier',2, 1),
		('Breaking Bad',20,0.24,'Gdy nauczyciel chemii dowiaduje si�, �e ma raka, 
		postanawia rozpocz�� produkcj� metamfetaminy, by finansowo zabezpieczy� 
		swoj� rodzin�. ',2008,'Vince Gilligan',2, 2),
		('Rick i Morty',12,0.14,'Ekscentryczny naukowiec Rick udaje si� ze 
		swoim wnukiem Mortym do najdziwniejszych miejsc w galaktyce i alternatywnych 
		rzeczywisto�ciach.',2013,'Dan Harmon',2, 2),
		('Miasteczko Twin Peaks ',32,0.13,'W Twin Peaks zostaje odnalezione 
		cia�o uczennicy - Laury Palmer. Do miasteczka przyje�d�a agent 
		federalny Dale Cooper i rozpoczyna �ledztwo.',
		1990, 'David Lynch',2, 3),
		('Rzym ',33,0.13,'Opowie�� o �yciu zar�wno wybitnych jak i 
		zwyczajnych rzymian rozgrywaj�ca si� w ostatnich dniach istnienia 
		Rzymskiej Republiki.',2005,'William J. MacDonald',2, 3),
		('S�owo na L',11,0.15,'S�owo na L to opowie�� o �yciu i mi�o�ci grupy 
		lesbijek, oraz ich przyjaci� i rodzin. Odkrywa przed widzami, 
		wydawa� by si� mog�o nieznany �wiat, kt�ry okazuje si� by� im bli�szy 
		ni� by si� tego spodziewali.',2004,'Ilene Chaiken',2, 3),
		('The Punisher',12,0.32,'Wspomnienia o zamordowanej rodzinie dr�cz�ce 
		Franka Castle a popychaj� go ku krwawej zem�cie i zwalczaniu 
		przest�pczo�ci wszelkimi dost�pnymi sposobami.',2017,'Steve Lightfoor',2, 4),
		('Synowie Anarchii',11,0.02,'Jax Teller, wiceprezydent i syn za�o�yciela 
		motocyklowego gangu, odnajduje stare dzienniki ojca. Pod ich wp�ywem 
		postanawia dokona� zmian w klubie. ',2008,'Kurt Sutter',2, 4),
		('Archer',12,0.13,'Sterling Archer, cz�onek tajnej agencji wywiadowczej 
		ISIS, zmaga si� z problemami dnia codziennego, pr�buj�c 
		przy tym uratowa� �wiat przed sob�.',2009,'Adam Reed',2, 4),
		('Tu� przed tragedi�',32,0.13,'"Katastrofy nie zdarzaj� si� same. 
		S� skutkiem �a�cucha krytycznych wydarze�." Serial dokumentalny 
		odtwarzaj�cy i poddaj�cy naukowej analizie znane oraz te mniej 
		rozpowszechnione tragiczne wydarzenia z najnowszej historii �wiata.',
		2004,'Paul Burgess',2, 5)

	go

/*Procedura rejestracji u�ytkownika i inne*/
Create Procedure Rejestr( 
	@a1 varchar(50),
	@a2 varchar(50),
	@a3 varchar(50),
	@a4 varchar(50),
    @a5 varchar(50), 
	@a6 varchar(50),
    @a7 varchar(50),
	@a8 varchar(50),
	@a9 varchar(50),
	@a10 varchar(50),
	@a11 varchar(50) )
  AS
  Insert into Klient VALUES (@a1,@a2,@a3,@a4,@a5,@a6,@a7,@a8,@a9,@a10,@a11);
go

Create Procedure Spr_klienta 
	@a1 varchar(50)
  AS
 SELECT * FROM Klient WHERE login LIKE @a1;
go


CREATE PROCEDURE PotwZam @id int
AS
INSERT INTO Zamowienie VALUES (CURRENT_TIMESTAMP)
UPDATE Koszyk SET id_Zamowienie=(SELECT TOP 1 id FROM Zamowienie Order by id DESC) WHERE id_Zamowienie IS NULL AND  id_klient=@id;
go