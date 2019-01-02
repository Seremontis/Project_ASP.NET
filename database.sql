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
		Odwo³uje siê do najprostszych rozwi¹zañ fabularnych i 
		bazuje przede wszystkim na konsekwentnym budowaniu napiêcia.',
		2014,'John R.Leonetti',1, 1),
		('Obecnoœæ 2',25,0.23,'Lorraine i Ed Warren udaj¹ siê do 
		pó³nocnej czêœci Londynu, aby pomóc samotnej matce wychowuj¹cej 
		czwórkê dzieci, której dom jest nawiedzany przez z³oœliwe duchy.',
		2016,'James Wan',1, 1),
		('Zakonnica',23,0.18,'Kobieta ginie w niewyjaœnionych okolicznoœciach. 
		Jej dawne przyjació³ki podejrzewaj¹, ¿e chodzi o tajemnicê sprzed lat.',
		2018,'Corin Hardy',1, 1),
		('Ciche miejsce',19,0.12,'Piêcioosobowa rodzina stara siê przetrwaæ w 
		œwiecie pe³nym potworów, które stanowi¹ œmiertelne niebezpieczeñstwo, 
		a zwabia je najmniejszy ha³as.',2018,'John Krasinksi',1, 1),
		('Sierociniec',12,0.23,'Laura z mê¿em i adoptowanym synem wprowadza siê 
		do pustego sierociñca. Ich dziecko zaczyna bawiæ siê z niewidzialnymi kolegami.',
		2007,'J.A. Bayona',1, 1),
		('Wkrêceni',19,0.24,'Zwolnieni pracownicy fabryki samochodów postanawiaj¹ 
		wydaæ swoje odprawy na szalony wyjazd do Warszawy.',
		2013,'Piotr Wereœniak',1, 2),
		('Porady na zdrady',11,0.11,'Dwie kobiety, Kalina i Fretka, 
		zostawione przez swoich partnerów zak³adaj¹ firmê, w której chc¹ 
		zajmowaæ siê rozwi¹zywaniem problemów z niewiernoœci¹ facetów.',
		2017,'Ryszard Zatorski',1, 2),
		('Gwiazd naszych wina',32,0.12,'Cierpi¹ca na raka tarczycy Hazel 
		za namow¹ rodziców idzie na spotkanie grupy wsparcia.',
		2014,'Josh Boone',1, 3),
		('Nowe oblicze Greya',12,0.12,'Christian i Ana wiod¹ pe³ne dostatku i 
		mi³oœci ¿ycie. Ich spokój zak³óca jej by³y szef, który chce siê na niej zemœciæ.',
		2018,'James Foley',1, 3),
		('Ka¿dego dnia',34,0.22,'16-letnia dziewczyna poznaje ch³opaka, 
		który dzieli siê z ni¹ niezwyk³¹ tajemnic¹. Nastolatek ka¿dego dnia budzi 
		siê w ciele kogoœ innego.',2018,'Michael Sucsy',1, 3),
		('Zanim siê pojawi³eœ',12,0.18,'Dziewczynê z ma³ego miasteczka zaczyna 
		³¹czyæ wiêŸ ze sparali¿owanym mê¿czyzn¹, którym siê opiekuje.',
		2016,'Thea Sharrock',1, 3),
		('Iniemamocni 2',11,0.11,'Podczas gdy Bob Parr zmaga siê z problemami 
		wychowawczymi swoich dzieci, jego ¿ona Helen, znana tak¿e, jako Elastyna, 
		realizuje swe aspiracje, podejmuj¹c pracê w lidze antyprzestêpczej.',
		2018, 'Brad Bird',1, 4),
		('Ant-Man i Osa',32,0.12,'Ant-man i Osa próbuj¹ odkryæ tajemnice 
		przesz³oœci doktora Hanka Pyma i Hope van Dyne.',
		2018,'Peyton Reed',1, 4),
		('Deadpool',11,0.31,'By³y ¿o³nierz oddzia³ów specjalnych zostaje 
		poddany niebezpiecznemu eksperymentowi. Niebawem uwalnia swoje alter 
		ego i rozpoczyna polowanie na cz³owieka, który niemal zniszczy³ jego ¿ycie. ',
		2016,'Tim Miller',1, 4),
		('SIEDEM DUSZ',15,0.12,'Ben Thomas pragnie odkupiæ swoje winy.
		W tym celu wyrusza w niezwyk³¹ podró¿ z zamiarem ocalenia siedmiorga ludzi.',
		2008,'Gabriele Muccino',1, 5),
		('WSZYSTKO GRA',12,0.13,'Chris Wilton, m³ody, wywodz¹cy siê z biednej 
		irlandzkiej rodziny instruktor tenisa, dostaje szansê awansu spo³ecznego.',
		2005,'Woody Allen',1, 5),
		('Opowieœci z krypty',42,0.08,'Klasyczne ju¿ opowieœci grozy powsta³e 
		na bazie serii komiksów z lat 50. Odcinki nie s¹ powi¹zane ze sob¹ 
		fabularnie, ka¿dy opowiada inn¹ historiê – s¹ wœród nich epizody gore, 
		opowieœci o duchach i trochê science fiction.',
		1989,'Russel Mulcahy', 1,5),
		('Z Archiwum X',9,0.11,'Zakwalifikowanie „Z archiwum X” do 
		jakiegokolwiek rodzaju jest raczej niemo¿liwe, za to zaskakuj¹co 
		wiele odcinków tego serialu to prawdziwe, niczym niezafa³szowane horrory, 
		które mo¿na uznaæ za klasyki gatunku.',
		1993,'Chris Carter',2, 1),
		('Królestwo',20,0.23,'ultowy ju¿ miniserial Larsa von Triera – 
		bardzo dziwny, bardzo oniryczny i bardzo europejski. „Królestwo” 
		to surrealistyczne po³¹czenie serialu medycznego z duszn¹ atmosfer¹ 
		prawdziwego horroru i specyficznym, bardzo czarnym humorem.',
		1994,'Lars von Trier',2, 1),
		('Breaking Bad',20,0.24,'Gdy nauczyciel chemii dowiaduje siê, ¿e ma raka, 
		postanawia rozpocz¹æ produkcjê metamfetaminy, by finansowo zabezpieczyæ 
		swoj¹ rodzinê. ',2008,'Vince Gilligan',2, 2),
		('Rick i Morty',12,0.14,'Ekscentryczny naukowiec Rick udaje siê ze 
		swoim wnukiem Mortym do najdziwniejszych miejsc w galaktyce i alternatywnych 
		rzeczywistoœciach.',2013,'Dan Harmon',2, 2),
		('Miasteczko Twin Peaks ',32,0.13,'W Twin Peaks zostaje odnalezione 
		cia³o uczennicy - Laury Palmer. Do miasteczka przyje¿d¿a agent 
		federalny Dale Cooper i rozpoczyna œledztwo.',
		1990, 'David Lynch',2, 3),
		('Rzym ',33,0.13,'Opowieœæ o ¿yciu zarówno wybitnych jak i 
		zwyczajnych rzymian rozgrywaj¹ca siê w ostatnich dniach istnienia 
		Rzymskiej Republiki.',2005,'William J. MacDonald',2, 3),
		('S³owo na L',11,0.15,'S³owo na L to opowieœæ o ¿yciu i mi³oœci grupy 
		lesbijek, oraz ich przyjació³ i rodzin. Odkrywa przed widzami, 
		wydawaæ by siê mog³o nieznany œwiat, który okazuje siê byæ im bli¿szy 
		ni¿ by siê tego spodziewali.',2004,'Ilene Chaiken',2, 3),
		('The Punisher',12,0.32,'Wspomnienia o zamordowanej rodzinie drêcz¹ce 
		Franka Castle a popychaj¹ go ku krwawej zemœcie i zwalczaniu 
		przestêpczoœci wszelkimi dostêpnymi sposobami.',2017,'Steve Lightfoor',2, 4),
		('Synowie Anarchii',11,0.02,'Jax Teller, wiceprezydent i syn za³o¿yciela 
		motocyklowego gangu, odnajduje stare dzienniki ojca. Pod ich wp³ywem 
		postanawia dokonaæ zmian w klubie. ',2008,'Kurt Sutter',2, 4),
		('Archer',12,0.13,'Sterling Archer, cz³onek tajnej agencji wywiadowczej 
		ISIS, zmaga siê z problemami dnia codziennego, próbuj¹c 
		przy tym uratowaæ œwiat przed sob¹.',2009,'Adam Reed',2, 4),
		('Tu¿ przed tragedi¹',32,0.13,'"Katastrofy nie zdarzaj¹ siê same. 
		S¹ skutkiem ³añcucha krytycznych wydarzeñ." Serial dokumentalny 
		odtwarzaj¹cy i poddaj¹cy naukowej analizie znane oraz te mniej 
		rozpowszechnione tragiczne wydarzenia z najnowszej historii œwiata.',
		2004,'Paul Burgess',2, 5)

	go

/*Procedura rejestracji u¿ytkownika i inne*/
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