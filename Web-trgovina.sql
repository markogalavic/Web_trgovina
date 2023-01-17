DROP DATABASE IF EXISTS sustav_za_upravljanje_web_trgovinom;

CREATE DATABASE sustav_za_upravljanje_web_trgovinom;

USE sustav_za_upravljanje_web_trgovinom;

CREATE TABLE login (
id INTEGER PRIMARY KEY,
ime VARCHAR(50),
lozinka VARCHAR(50)
);

INSERT INTO login VALUES (
1, 'Marko', 'marko'
);


CREATE TABLE shop_admin(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	ime VARCHAR(20) NOT NULL,
	prezime VARCHAR(20) NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	korisnicko_ime VARCHAR(20) UNIQUE NOT NULL,                       
	lozinka BLOB
);

CREATE TABLE web_trgovina(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	kontakt_broj INTEGER UNIQUE NOT NULL,
	stanje NUMERIC(10, 2) NOT NULL
);

CREATE TABLE dobavljac(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	ime VARCHAR(20) NOT NULL,
	prezime VARCHAR(20) NOT NULL
);

CREATE TABLE vrsta_proizvoda(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    naziv_vrste VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE proizvod(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_vrsta INTEGER NOT NULL,
    id_dobavljac INTEGER NOT NULL,
    naziv VARCHAR(20) UNIQUE NOT NULL,
    aktivan CHAR(1) NOT NULL,
    kolicina_u_skladistu INTEGER NOT NULL,
    cijena NUMERIC(10, 2) NOT NULL,
    CHECK(aktivan IN ('D', 'N'))
);

CREATE TABLE kupac(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	ime VARCHAR(20) NOT NULL,
	prezime VARCHAR(20) NOT NULL,
    oib CHAR(12) UNIQUE NOT NULL,
    datum_rodenja DATETIME NOT NULL,
    mobitel INTEGER UNIQUE NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	adresa VARCHAR(50) NOT NULL,
    grad VARCHAR (20) NOT NULL,
    drzava VARCHAR(20) NOT NULL,
	korisnicko_ime VARCHAR(20) UNIQUE NOT NULL,            
	lozinka BLOB
);

CREATE TABLE dostavljac(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	ime VARCHAR(20) NOT NULL,
	prezime VARCHAR(20) NOT NULL
);

CREATE TABLE metoda_placanja(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	metoda VARCHAR(20) NOT NULL,
	CHECK(metoda IN ('Kartično', 'Gotovina'))
);

CREATE TABLE ured(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_admin INTEGER NOT NULL,
    adresa VARCHAR(50) NOT NULL,
    grad VARCHAR(20) NOT NULL,
    drzava VARCHAR(20) NOT NULL,
    CONSTRAINT ured_shop_admin_fk FOREIGN KEY (id_admin) REFERENCES shop_admin(id) ON DELETE CASCADE
);

CREATE TABLE narudzba(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_admin INTEGER NOT NULL,
    id_kupac INTEGER NOT NULL,
    id_dostavljac INTEGER NOT NULL,
    id_proizvod INTEGER NOT NULL,
    id_metoda_placanja INTEGER NOT NULL,
    kolicina INTEGER NOT NULL,
	datum_narudzbe DATETIME NOT NULL,
	datum_isporuke DATETIME NOT NULL,
    komentar VARCHAR(100),
    stanje VARCHAR(15) DEFAULT 'placeno' NOT NULL,

    CHECK(stanje IN ('placeno', 'neplaceno'))
);

CREATE TABLE racun(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_narudzba INTEGER NOT NULL,
    broj CHAR(5) UNIQUE NOT NULL,
    iznos NUMERIC(10, 2) NOT NULL,
    datum DATETIME NOT NULL,
    placeno CHAR(1) NOT NULL,
    CHECK(placeno IN ('D', 'N'))
);

/* == Unos podataka == */
INSERT INTO shop_admin (ime, prezime, email, korisnicko_ime, lozinka) VALUES
('Cody', 'Warner', 'codywarner@gmail.com', 'cody123', '123456789'),
('Virgil', 'Brock', 'virgilbrock@gmail.com', 'virgil123', '123456789'),
('Pippa', 'Nielsen', 'pippanielsen@gmail.com', 'pippa123', '123456789'),
('Shayla', 'Ryan', 'shaylaryan@gmail.com', 'shayla123', '123456789'),
('Cian', 'Harvey', 'cianharvey@gmail.com', 'cian123', '123456789'),
('Miguel', 'Tanner', 'migueltanner@gmail.com', 'miguel123', '123456789'),
('Saad', 'Mcknight', 'saadmcknight@gmail.com', 'saad123', '123456789'),
('Harold', 'James', 'haroldjames@gmail.com', 'harold123', '123456789'),
('Wiktor', 'Bell', 'wiktorbell@gmail.com', 'wiktor123', '123456789'),
('Teresa', 'Bird', 'teresabird@gmail.com', 'teresa123', '123456789');

INSERT INTO web_trgovina (kontakt_broj, stanje) VALUES ('0975165925', 21420.50);

INSERT INTO dobavljac (ime, prezime) VALUES	('Hallie', 'Best'),
											('Sadie', 'Brooks'),
											('Natasha', 'Cole'),
											('Cheryl', 'Donaldson'),
											('Alexia', 'Pittman'),
											('Marcus', 'Medina');

INSERT INTO vrsta_proizvoda (naziv_vrste) VALUES ('računalo'),
												 ('laptop'),
												 ('mobitel'),
												 ('periferija'),
												 ('komponenta'),
												 ('konzola');

INSERT INTO proizvod (id_vrsta, id_dobavljac, naziv, aktivan, kolicina_u_skladistu, cijena) VALUES
('1', '1', 'računalo_uredsko', 'D', '10', '3499.99'),
('1', '2', 'računalo_gaming', 'D', '12', '5309.99'),
('2', '3', 'laptop_hp_omen', 'D', '20', '4999.99'),
('2', '4', 'laptop_lenovo', 'D', '4', '3999.99'),
('3', '5', 'iphone14', 'N', '28', '7999.99'),
('3', '6', 'samsung_s22', 'D', '19', '5799.99'),
('4', '1', 'miš', 'D', '100', '99.99'),
('4', '2', 'tipkovnica', 'D', '80', '189.99'),
('5', '3', 'grafička_kartica', 'D', '16', '3129.99'),
('5', '4', 'procesor', 'D', '41', '1129.99'),
('6', '5', 'play_station5', 'D', '7', '5349.99'),
('6', '6', 'nintendo_switch', 'D', '10', '1999.99');

INSERT INTO kupac (ime, prezime, oib, datum_rodenja, mobitel, email, adresa, grad, drzava, korisnicko_ime, lozinka) VALUES
('Rico', 'Lambert', '93864786339', STR_TO_DATE('15.10.1978.', '%d.%m.%Y.'), '0982943416', 'ricolambert@gmail.com', '3176 Sigley Road', 'Lenora', 'Kansas', 'rico123', '12345678'),
('Anita', 'Finch', '87782840970', STR_TO_DATE('05.10.2001.', '%d.%m.%Y.'), '0975974499', 'anitafinch@gmail.com', '2769 Oakwood Avenue', 'New York', 'New York', 'anita123', '12345678'),
('Harris', 'Rich', '17663456360', STR_TO_DATE('12.07.1975.', '%d.%m.%Y.'), '098802861', 'harrisrich@gmail.com', '331 Morris Street', 'Karnes City', 'Texas', 'harris123', '12345678'),
('Khalid', 'Tyler', '43926607313', STR_TO_DATE('07.11.1987.', '%d.%m.%Y.'), '0952038025', 'khalidtyler@gmail.com', '4438 Michael Street', 'Houston', 'Texas', 'khalid123', '12345678'),
('Hayley', 'Lindsey', '98484528799', STR_TO_DATE('08.08.1999.', '%d.%m.%Y.'), '0984006859', 'hayleylindsey@gmail.com', '578 Carolina Avenue', 'Grand Junction', 'Colorado', 'hayley123', '12345678'),
('Cain', 'Bryant', '57817497723', STR_TO_DATE('22.11.1995.', '%d.%m.%Y.'), '0989723343', 'cainbryant@gmail.com', '4451 Prospect Street', 'Camden', 'New Jersey', 'cain123', '12345678'),
('Bryony', 'Townsend', '84054708687', STR_TO_DATE('28.02.1982.', '%d.%m.%Y.'), '0988378873', 'bryonytownsend@gmail.com', '2388 Oakdale Avenue', 'Plant City', 'Florida', 'bryony123', '12345678');

INSERT INTO dostavljac (ime, prezime) VALUES ('Aimee', 'Beard'),
											 ('Lilly', 'Cain'),
											 ('Saarah', 'Kay'),
											 ('Vanea', 'Ryanss'),
											 ('Coral', 'Trujillo'),
											 ('Evelyn', 'Cook');
                                             
INSERT INTO metoda_placanja (metoda) VALUES	('Gotovina'),
											('Kartično');

INSERT INTO ured (id_admin, adresa, grad, drzava) VALUES ('1', '869 Stark Hollow Road', 'Glenwood Springs', 'Colorado'),
														 ('2', '2296 Alexander Avenue', 'San Jose', 'California'),
														 ('3', '2709 Center Avenue', 'Fresno', 'California'),
														 ('4', '4663 Camden Street', 'Reno', 'Nevada');

INSERT INTO narudzba (id_admin, id_kupac, id_dostavljac, id_proizvod, id_metoda_placanja, kolicina, datum_narudzbe, datum_isporuke, komentar, stanje) VALUES
(1, 3, 6, 8, 1, 2, STR_TO_DATE('05.10.2022.', '%d.%m.%Y.'), STR_TO_DATE('08.10.2022.', '%d.%m.%Y.'), 'posao', 'placeno'),
(2, 5, 2, 1, 2, 1, STR_TO_DATE('15.11.2022.', '%d.%m.%Y.'), STR_TO_DATE('18.11.2022.', '%d.%m.%Y.'), 'posao', 'placeno'),
(3, 2, 2, 2, 2, 1, STR_TO_DATE('20.12.2022.', '%d.%m.%Y.'), STR_TO_DATE('23.12.2022.', '%d.%m.%Y.'), 'poklon', 'neplaceno'),
(4, 4, 5, 4, 1, 1, STR_TO_DATE('10.10.2022.', '%d.%m.%Y.'), STR_TO_DATE('13.10.2022.', '%d.%m.%Y.'), 'posao', 'placeno'),
(5, 7, 1, 3, 1, 1, STR_TO_DATE('13.11.2022.', '%d.%m.%Y.'), STR_TO_DATE('16.11.2022.', '%d.%m.%Y.'), 'poklon', 'placeno'),
(6, 2, 3, 12, 2, 1, STR_TO_DATE('02.12.2022.', '%d.%m.%Y.'), STR_TO_DATE('05.12.2022.', '%d.%m.%Y.'), 'poklon', 'placeno'),
(7, 1, 4, 10, 1, 2, STR_TO_DATE('08.10.2022.', '%d.%m.%Y.'), STR_TO_DATE('11.10.2022.', '%d.%m.%Y.'), 'posao', 'placeno'),
(8, 6, 1, 6, 2, 1, STR_TO_DATE('25.11.2022.', '%d.%m.%Y.'), STR_TO_DATE('28.11.2022.', '%d.%m.%Y.'), 'poklon', 'placeno'),
(9, 3, 5, 11, 1, 1, STR_TO_DATE('14.12.2022.', '%d.%m.%Y.'), STR_TO_DATE('17.12.2022.', '%d.%m.%Y.'), 'poklon', 'placeno');

INSERT INTO racun (id_narudzba, broj, iznos, datum, placeno) VALUES (1, '00001', 289.98, STR_TO_DATE('05.10.2022.', '%d.%m.%Y.'), 'D'),
																	(2, '00002', 3499.99, STR_TO_DATE('15.11.2022.', '%d.%m.%Y.'), 'D'),
																	(3, '00003', 5309.99, STR_TO_DATE('20.12.2022.', '%d.%m.%Y.'), 'N'),
																	(4, '00004', 3999.99, STR_TO_DATE('10.10.2022.', '%d.%m.%Y.'), 'D'),
																	(5, '00005', 4999.99, STR_TO_DATE('13.11.2022.', '%d.%m.%Y.'), 'D'),
																	(6, '00006', 1999.99, STR_TO_DATE('02.12.2022.', '%d.%m.%Y.'), 'D'),
																	(7, '00007', 4259.98, STR_TO_DATE('08.10.2022.', '%d.%m.%Y.'), 'D'),
																	(8, '00008', 5799.99, STR_TO_DATE('25.11.2022.', '%d.%m.%Y.'), 'D'),
																	(9, '00009', 5349.99, STR_TO_DATE('14.12.2022.', '%d.%m.%Y.'), 'D');



/*-------------------------------------------- UPITI --------------------------------------------*/ # Tedi Pačić
/* Upit koji prikazuje račune izadne u proteklih mjesec dana */
SELECT *
	FROM racun
    WHERE datum > NOW() - INTERVAL 1  MONTH;


/* Upit koji prikazuje ukupnu potrošnju kupca */
SELECT kupac.id, kupac.ime, kupac.prezime, SUM(narudzba.kolicina*proizvod.cijena) AS ukupna_potrosnja_kupca
	FROM narudzba INNER JOIN proizvod ON narudzba.id_proizvod = proizvod.id
				  INNER JOIN kupac ON narudzba.id_kupac = kupac.id
    GROUP BY id_kupac;


/* Upit koji prikazuje proizvode iste vrste */
SELECT proizvod.id, proizvod.naziv, naziv_vrste
	FROM proizvod INNER JOIN vrsta_proizvoda ON proizvod.id_vrsta = vrsta_proizvoda.id
	WHERE proizvod.id_vrsta = 2;


/* Upit koji prikazuje proizvode kojih ima najmanje na skaldištu */
SELECT *
	FROM proizvod
    ORDER BY kolicina_u_skladistu ASC
    LIMIT 5;


/* Upit koji prikazuje proizvode sortirane po cijeni od najviše do najniže */
SELECT *
	FROM proizvod
    ORDER BY cijena DESC;


/* Upit koji prikazuje najtraženiji proizvod */
SELECT proizvod.naziv, COUNT(*) AS najtrazeniji_proizvod
	FROM narudzba INNER JOIN proizvod ON narudzba.id_proizvod = proizvod.id
	GROUP BY proizvod.naziv
	ORDER BY id_proizvod DESC
	LIMIT 1;


/* Upit koji prikazuje koliko je vremena potrebno da bi se proizvod dostavio */
SELECT id, DATEDIFF(datum_isporuke, datum_narudzbe) AS vrijeme_dostave_u_danima
	FROM narudzba;


/* Upit koji prikazuje narudžbe plaćene u gotovini */
SELECT *
	FROM narudzba INNER JOIN metoda_placanja ON narudzba.id_metoda_placanja = metoda_placanja.id
    WHERE metoda_placanja.metoda = 'Gotovina';


/* Upit koji vraća shop_admina koji je izdao najviše narudžba */
SELECT s.* 
	FROM shop_admin s
    JOIN narudzba n ON s.id = n.id_admin
    GROUP BY s.id
    ORDER BY COUNT(*) DESC
    LIMIT 1;



/*-------------------------------------------- POGLEDI --------------------------------------------*/ # Tedi Pačić
/* Pogled koji prikazuje plaćene narudzbe */
DROP VIEW IF EXISTS placene_narudzbe;

CREATE VIEW placene_narudzbe AS
	SELECT kupac.id, kupac.ime, kupac.prezime, narudzba.stanje
		FROM kupac INNER JOIN narudzba ON kupac.id = narudzba.id_kupac
		WHERE narudzba.stanje = 'placeno';


/* Pogled koji prikazuje narudžbe koje nisu plaćene */
DROP VIEW IF EXISTS neplacene_narudzbe;

CREATE VIEW neplacene_narudzbe AS
	SELECT kupac.id, kupac.ime, kupac.prezime, narudzba.stanje
		FROM kupac INNER JOIN narudzba ON kupac.id = narudzba.id_kupac
		WHERE narudzba.stanje = 'neplaceno';


/* Pogled koji prikazuje broj plaćenih narudžbi */
DROP VIEW IF EXISTS broj_placenih_narudzba;

CREATE VIEW broj_placenih_narudzba AS
  SELECT 0 AS id, COUNT(*)
	FROM narudzba AS n
    WHERE n.stanje = 'placeno';


/* Pogled koji prikazuje broj narudžbi koje nisu plaćene */
DROP VIEW IF EXISTS broj_neplacenih_narudzba;

CREATE VIEW broj_neplacenih_narudzba AS
  SELECT 0 AS id, COUNT(*)
	FROM narudzba AS n
    WHERE n.stanje = 'neplaceno';


/* Pogled koji prikazuje narudžbe koje se plaćaju gotovinom */
DROP VIEW IF EXISTS gotovinsko_placanje;

CREATE VIEW gotovinsko_placanje AS
	SELECT *	
		FROM narudzba INNER JOIN metoda_placanja ON narudzba.id_metoda_placanja = metoda_placanja.id
		WHERE metoda_placanja.metoda = 'Gotovina';


/* Pogled koji dohvaća sve narudžbe isporučene 2022. */
DROP VIEW IF EXISTS sve_narudzbe;

CREATE VIEW sve_narudzbe AS
	SELECT *
		FROM narudzba
        WHERE datum_isporuke BETWEEN '01.01.2022.' AND '31.12.2022.';



/*-------------------------------------------- PROCEDURE --------------------------------------------*/ # Tedi Pačić
/* Procedura za izračun najmanje i najveće cijene proizvoda */
DELIMITER //
CREATE PROCEDURE cijena(OUT min_cijena DECIMAL(10, 2), OUT max_cijena DECIMAL(10, 2))
BEGIN
	DECLARE cur CURSOR FOR
		SELECT MIN(cijena), MAX(cijena)
			FROM proizvod;

	OPEN CUR;
		FETCH cur INTO min_cijena, max_cijena;
	CLOSE cur;

END //
DELIMITER ;

CALL cijena(@min_cijena, @max_cijena);

SELECT @min_cijena, @max_cijena FROM DUAL;

/* Procedura za dodavanje dobavljača */
DROP PROCEDURE IF EXISTS dodaj_dobavljaca;

DELIMITER //
CREATE PROCEDURE dodaj_dobavljaca(n_ime VARCHAR(30), n_prezime VARCHAR(30))
BEGIN

	INSERT INTO dobavljac(ime, prezime) VALUES (n_ime, n_prezime);
    
END //
DELIMITER ;

SELECT * FROM dobavljac;

CALL dodaj_dobavljaca('Mario', 'Marić');

SELECT * FROM dobavljac;


/* Procedura za uklanjanje dobavljača */
DROP PROCEDURE IF EXISTS ukloni_dobavljaca;

DELIMITER //
CREATE PROCEDURE ukloni_dobavljaca(n_ime VARCHAR(30), n_prezime VARCHAR(30))
BEGIN

	DELETE ime, prezime FROM dobavljac WHERE (ime = n_ime, prezime = n_prezime);
    
END //
DELIMITER ;

SELECT * FROM dobavljac;

CALL ukloni_dobavljaca('Mario', 'Marić');

SELECT * FROM dobavljac;


/* Procedura za izračun akcijske cijene proizvoda */
DROP PROCEDURE IF EXISTS akcija;

DELIMITER //
CREATE PROCEDURE akcija(OUT akcijska_cijena DECIMAL(10, 2))
BEGIN

    SELECT * , 10 / cijena AS akcijska_cijena
		FROM proizvod;

END //
DELIMITER ;

CALL akcija(@akcijska_cijena);

SELECT @akcijska_cijena FROM DUAL;



/*-------------------------------------------- FUNKCIJE --------------------------------------------*/ # Leon Stanić
/* Funkcija koja kreira broj računa uz autoincrement (ne prima id kao parametar) */
DROP FUNCTION IF EXISTS kreiraj_broj_racuna_autoincrement;

DELIMITER //
CREATE FUNCTION kreiraj_broj_racuna_autoincrement () RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE novi_id INTEGER DEFAULT NULL;
    
    SELECT (id + 1) INTO novi_id
		FROM racun
		ORDER BY id DESC
		LIMIT 1;
        
	IF novi_id IS NULL THEN
		SET novi_id = 1;
	END IF;
        
	RETURN kreiraj_broj_racuna_autoincrement(novi_id);
END //
DELIMITER ;

# Primjer
SELECT kreiraj_broj_racuna_autoincrement();

SELECT * FROM racun;

INSERT INTO racun (id_narudzba, broj, iznos, datum, placeno) VALUES
('10', kreiraj_broj_racuna_autoincrement(), '400.00', STR_TO_DATE('05.10.2022.', '%d.%m.%Y.'), 'D');


/* Funkcija koja kreira broj računa u slučaju da ne koristimo autoincrement */
DROP FUNCTION IF EXISTS kreiraj_broj_racuna;

DELIMITER //
CREATE FUNCTION kreiraj_broj_racuna (id_racuna INTEGER) RETURNS INTEGER
DETERMINISTIC
BEGIN

	IF (id_racuna BETWEEN 1 AND 9) THEN
		RETURN CONCAT("00000", id_racuna);
	ELSEIF (id_racuna BETWEEN 10 AND 99) THEN
		RETURN CONCAT("0000", id_racuna);
	ELSEIF (id_racuna BETWEEN 100 AND 999) THEN
		RETURN CONCAT("000", id_racuna);
	ELSEIF (id_racuna BETWEEN 1000 AND 9999) THEN
		RETURN CONCAT("00", id_racuna);
	ELSEIF (id_racuna BETWEEN 10000 AND 99999) THEN
		RETURN CONCAT("0", id_racuna);
	ELSEIF (id_racuna BETWEEN 100000 AND 999999) THEN
		RETURN CONVERT(id_racuna, CHAR);
    END IF;

END //
DELIMITER ;

# Primjer
SELECT kreiraj_broj_racuna(10);

SELECT * FROM racun;

INSERT INTO racun (id, id_narudzba, broj, iznos, datum, placeno) VALUES
('10', '10', kreiraj_broj_racuna(id), '400.00', STR_TO_DATE('05.10.2022.', '%d.%m.%Y.', 'D'));


/* Funkcija koja prikazuje broj izdanih računa između dva datuma */
DROP FUNCTION IF EXISTS br_racuna_izmedu;

DELIMITER //
CREATE FUNCTION br_racuna_izmedu (p_datum_od DATETIME, p_datum_do DATETIME) RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(*)
				FROM racun
				WHERE datum
				BETWEEN p_datum_od AND p_datum_do);
END //
DELIMITER ;

# Primjer
SELECT br_racuna_izmedu(STR_TO_DATE('01.10.2022.', '%d.%m.%Y.'), STR_TO_DATE('31.12.2022.', '%d.%m.%Y.')) AS "Broj računa";


/* Funkcija koja vraća broj proizvoda prodanih određenom kupcu */
DROP FUNCTION IF EXISTS broj_prodanih_proizvoda;

DELIMITER //
CREATE FUNCTION broj_prodanih_proizvoda (p_id_kupac INTEGER) RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE prodani_proizvodi INTEGER;

	SELECT COUNT(*) INTO prodani_proizvodi
		FROM narudzba
		WHERE id_kupac = p_id_kupac;

    RETURN prodani_proizvodi;
END //
DELIMITER ;

SELECT *, broj_prodanih_proizvoda(id) AS "Kupio proizvoda" 
	FROM kupac;


/* Funkcija koja vraća broj prodaja određenog proizvoda */
DROP FUNCTION IF EXISTS broj_prodaja_proizvoda;

DELIMITER //
CREATE FUNCTION broj_prodaja_proizvoda (p_id_proizvod INTEGER) RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE broj_prodaja INTEGER;

	SELECT COUNT(*) INTO broj_prodaja
		FROM narudzba
		WHERE id_proizvod = p_id_proizvod;

    RETURN broj_prodaja;
END //
DELIMITER ;

SELECT *, broj_prodaja_proizvoda(id) AS "Broj prodaja" 
	FROM proizvod;



/*-------------------------------------------- PROCEDURE --------------------------------------------*/ # Leon Stanić
/* Procedura koja provjerava postoji li dovoljna količina određenog proizvoda u skladištu */
DROP PROCEDURE IF EXISTS provjeri_kolicinu_u_skladistu;

DELIMITER //
CREATE PROCEDURE provjeri_kolicinu_u_skladistu (IN p_id_proizvod INTEGER, IN p_kolicina_proizvoda INTEGER)
BEGIN
	DECLARE l_kolicina_u_skladistu INTEGER;
	DECLARE l_id_proizvod INTEGER;
	DECLARE l_naziv_proizvoda VARCHAR (50);
	DECLARE l_kolicina INTEGER;
	DECLARE greska VARCHAR(100) DEFAULT "Količina u skladištu preniska za proizvod: ";

	DECLARE cur CURSOR FOR
		SELECT id, kolicina_u_skladistu
			FROM proizvod
			WHERE id_proizvod = p_id_proizvod;

	DECLARE EXIT HANDLER FOR NOT FOUND BEGIN END;

	OPEN cur;
		provjeri_kolicinu: LOOP
			FETCH cur INTO l_id_proizvod, l_kolicina;

			SELECT kolicina_u_skladistu INTO l_kolicina_u_skladistu
				FROM proizvod
				WHERE id = l_id_proizvod;

			IF (l_kolicina_u_skladistu - l_kolicina * p_kolicina_proizvoda) < 0 THEN
				SELECT naziv INTO l_naziv_proizvoda
					FROM proizvod
					WHERE id = l_id_proizvod;

				SET greska = CONCAT(greska, l_naziv_proizvoda);

				SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = greska;
			END IF;

		END LOOP provjeri_kolicinu;
	CLOSE cur;

END //
DELIMITER ;


/* Procedura koja smanjuje količinu proizvoda u skladištu na današnji datum */
DROP PROCEDURE IF EXISTS smanji_kolicinu_u_skladistu;

DELIMITER //
CREATE PROCEDURE smanji_kolicinu_u_skladistu (IN p_id_proizvod INTEGER, IN p_kolicina_proizvoda INTEGER)
BEGIN
	DECLARE l_id_proizvod INTEGER;
	DECLARE l_kolicina INTEGER;

	DECLARE cur CURSOR FOR
		SELECT id_proizvod, kolicina
			FROM narudzba
			WHERE id_proizvod = p_id_proizvod AND datum_narudzbe = NOW();

	DECLARE EXIT HANDLER FOR NOT FOUND BEGIN END;

	OPEN cur;
		smanji_kolicinu: LOOP
			FETCH cur INTO l_id_proizvod, l_kolicina;

			UPDATE proizvod
				SET kolicina_u_skladistu = kolicina_u_skladistu - l_kolicina * p_kolicina_proizvoda
				WHERE proizvod.id = l_id_proizvod;

		END LOOP smanji_kolicinu;
	CLOSE cur;

END //
DELIMITER ;


/* Procedura koja "briše" proizvod iz skladišta -> postavlja atribut aktivan na 'N' */
DROP PROCEDURE IF EXISTS obrisi_proizvod;

DELIMITER //
CREATE PROCEDURE obrisi_proizvod (p_id_proizvoda INTEGER)
BEGIN
	IF (SELECT COUNT(*)
			FROM proizvod
            WHERE id = p_id_proizvoda) = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ne postoji proizvod sa tim id-em!';

	ELSEIF (SELECT COUNT(*)
			FROM proizvod
            WHERE id = p_id_proizvoda
				AND aktivan = 'N') = 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proizvod je već neaktivan!';

	ELSE
		UPDATE proizvod
			SET aktivan = 'N'
			WHERE id = p_id_proizvoda;
    END IF;
END //
DELIMITER ;

# Provjera
SELECT * FROM proizvod;

CALL obrisi_proizvod(5);

SELECT * FROM proizvod;


/* Procedura koja dodaje proizvod u skladište */
DROP PROCEDURE IF EXISTS dodaj_proizvod;

DELIMITER //
CREATE PROCEDURE dodaj_proizvod (p_id_vrsta INTEGER, p_id_dobavljac INTEGER, p_naziv_proizvoda VARCHAR(70),
								 p_aktivan CHAR(1), p_kolicina_u_skladistu INTEGER, p_cijena DECIMAL(10, 2))
BEGIN
	-- aktivan proizvod s tim nazivom već postoji -> javlja grešku:
	IF (SELECT COUNT(*)
			FROM proizvod
			WHERE naziv = p_naziv_proizvoda
            AND aktivan = 'D') > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proizvod već postoji!';

	-- neaktivan proizvod s tim nazivom već postoji -> aktivira ga:
	ELSEIF (SELECT COUNT(*)
			FROM proizvod
			WHERE naziv = p_naziv_proizvoda
				AND aktivan = 'N') > 0 THEN
		UPDATE proizvod
			SET aktivan = 'D'
            WHERE naziv = p_naziv_proizvoda;

	-- inače -> dodaje proizvod:
    ELSE
		INSERT INTO proizvod (id_vrsta, id_dobavljac, naziv, aktivan, kolicina_u_skladistu, cijena) VALUES
        (p_id_vrsta, p_id_dobavljac, p_naziv_proizvoda, p_aktivan, p_kolicina_u_skladistu, p_cijena);
    END IF;

END //
DELIMITER ;

# Provjera
SELECT * FROM proizvod;

CALL dodaj_proizvod('3', '1', 'samsung_Z_fold', 'D', '5', 9999.99);

SELECT * FROM proizvod;


/* Procedura koji stavlja određeni račun u status plaćeno */
DROP PROCEDURE IF EXISTS podmiri_racun;

DELIMITER //
CREATE PROCEDURE podmiri_racun (p_id INTEGER)
BEGIN
	DECLARE l_placeno CHAR(1);

	SELECT placeno INTO l_placeno
		FROM racun
		WHERE id = p_id;

	IF l_placeno = 'D' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Račun je već plaćen!'; 

	ELSEIF l_placeno IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ne postoji račun sa tim id-em!';

	ELSE
		UPDATE racun
			SET placeno = 'D'
			WHERE id = p_id;
	END IF;

END //
DELIMITER ;

# Provjera
SELECT * FROM racun;

CALL podmiri_racun(3);

SELECT * FROM racun;



/*-------------------------------------------- OKIDAČI --------------------------------------------*/ # Leon Stanić
/* Okidač koji provjerava ima li dovoljno proizvoda u skladištu,
zatim izračunava cijenu prodanih proizvoda i ukupni iznos računa */
DROP TRIGGER IF EXISTS bi_narudzba;

DELIMITER //
CREATE TRIGGER bi_narudzba
    BEFORE INSERT ON narudzba
    FOR EACH ROW
BEGIN	
    DECLARE l_cijena_proizvoda DECIMAL(10, 2);

    CALL provjeri_kolicinu_u_skladistu(NEW.id_proizvod, NEW.kolicina);

    SELECT cijena INTO l_cijena_proizvoda
		FROM proizvod
        WHERE proizvod.id = NEW.id_proizvod;

	SET l_cijena_proizvoda = l_cijena_proizvoda * NEW.kolicina;

    UPDATE racun
		SET iznos = iznos + l_cijena_proizvoda
		WHERE id = NEW.id;

END //
DELIMITER ;


/* Okidač koji će spriječiti unos netočnih datuma za narudžbu */
DROP TRIGGER IF EXISTS bi_narudzba_datum;

DELIMITER //
CREATE TRIGGER bi_narudzba_datum
	BEFORE INSERT ON narudzba
	FOR EACH ROW
BEGIN
	DECLARE l_datum_narudzbe DATE DEFAULT NEW.datum_narudzbe;
    DECLARE l_datum_isporuke DATE DEFAULT NEW.datum_isporuke;

	IF l_datum_narudzbe >= l_datum_isporuke THEN  
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Greška u datumima!';
	END IF;

END //
DELIMITER ;


/* Okidač koji provjerava ispravnost emaila administratora */
DROP TRIGGER IF EXISTS bi_provjera_email_admin;

DELIMITER //
CREATE TRIGGER bi_provjera_email_admin
    BEFORE INSERT ON shop_admin
    FOR EACH ROW
BEGIN

	IF NEW.email NOT LIKE '%_@%_.__%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email nije ispravan!';
	END IF;

END //
DELIMITER ;


/* Okidač koji provjerava ispravnost emaila kupaca */
DROP TRIGGER IF EXISTS bi_provjera_email_kupac;

DELIMITER //
CREATE TRIGGER bi_provjera_email_kupac
    BEFORE INSERT ON kupac 
    FOR EACH ROW
BEGIN

	IF NEW.email NOT LIKE '%_@%_.__%' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email nije ispravan!';
	END IF;

END //
DELIMITER ;


/* Okidač koji zabranjuje izmjenu plaćenih računa */
DROP TRIGGER IF EXISTS bu_izmjena_placenih_racuna;

DELIMITER //
CREATE TRIGGER bu_izmjena_placenih_racuna
	BEFORE UPDATE ON racun
	FOR EACH ROW
BEGIN

	IF OLD.placeno = 'D' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Račun se ne može mijenjati jer je plaćen!';
	END IF;

END //
DELIMITER ;


/* Okidač koji zabranjuje izmjenu podataka narudžbe ako je račun plaćen */
DROP TRIGGER IF EXISTS bu_izmjena_podataka_narudzbe;

DELIMITER //
CREATE TRIGGER bu_izmjena_podataka_narudzbe
	BEFORE UPDATE ON narudzba
	FOR EACH ROW
BEGIN

	IF (SELECT placeno
			FROM racun
			WHERE OLD.racun.placeno = 'D') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Podaci narudžbe se ne mogu mijenjati jer je račun plaćen!';
	END IF;

END //
DELIMITER ;


# ---------------------------------------- Sučelje/procedure/upiti ---------------------------------------------------------
-- ---------------/* Procedura koja dodaje proizvod u skladište */--------------------------------------------
DROP PROCEDURE IF EXISTS dodaj_proizvod;

DELIMITER //
CREATE PROCEDURE dodaj_proizvod (p_id_vrsta INTEGER, p_id_dobavljac INTEGER, p_naziv_proizvoda VARCHAR(70),
								 p_aktivan CHAR(1), p_kolicina_u_skladistu INTEGER, p_cijena DECIMAL(10, 2))
BEGIN
	-- aktivan proizvod s tim nazivom već postoji -> javlja grešku:
	IF (SELECT COUNT(*)
			FROM proizvod
			WHERE naziv = p_naziv_proizvoda
            AND aktivan = 'D') > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proizvod već postoji!';

	-- neaktivan proizvod s tim nazivom već postoji -> aktivira ga:
	ELSEIF (SELECT COUNT(*)
			FROM proizvod
			WHERE naziv = p_naziv_proizvoda
				AND aktivan = 'N') > 0 THEN
		UPDATE proizvod
			SET aktivan = 'D'
            WHERE naziv = p_naziv_proizvoda;

	-- inače -> dodaje proizvod:
    ELSE
		INSERT INTO proizvod (id_vrsta, id_dobavljac, naziv, aktivan, kolicina_u_skladistu, cijena) VALUES
        (p_id_vrsta, p_id_dobavljac, p_naziv_proizvoda, p_aktivan, p_kolicina_u_skladistu, p_cijena);
    END IF;

END //
DELIMITER ;

# Provjera
SELECT * FROM proizvod;

CALL dodaj_proizvod('7', '6', 'frizider', 'D', '11', 199.99);
SELECT * FROM dobavljac;
SELECT * FROM proizvod;

-- ----------------------------------/* Procedura za dodavanje dobavljača */-----------------------------------------------------
DROP PROCEDURE IF EXISTS dodaj_dobavljaca;

DELIMITER //
CREATE PROCEDURE dodaj_dobavljaca(n_ime VARCHAR(30), n_prezime VARCHAR(30))
BEGIN

	INSERT INTO dobavljac(ime, prezime) VALUES (n_ime, n_prezime);
    
END //
DELIMITER ;

SELECT * FROM dobavljac;

CALL dodaj_dobavljaca('Mario', 'Marić');

SELECT * FROM dobavljac;

-- ----------------------------------------- Sučelje/Upiti --------------------------------------------------------

#--------------------------------------Upit koji prikazuje računicu web trgovine-------------------------------------------------------------
SELECT dobavljac.ime AS 'Ime dodavljača', dobavljac.prezime AS 'Prezime dobavljača', proizvod.naziv AS 'Proizvod', proizvod.cijena AS 'Cijena', kupac.ime AS 'Ime kupca', kupac.prezime AS 'Prezime kupca',
 metoda_placanja.metoda AS 'Metoda plaćanja', narudzba.kolicina AS 'Kolicina', narudzba.datum_narudzbe AS 'Datum narudžbe', narudzba.datum_isporuke AS 'Datum isporuke',
 racun.broj AS 'Broj računa', racun.iznos AS 'Iznos', (racun.iznos/(SELECT SUM(racun.iznos) FROM racun))*100 AS Postotak
FROM dobavljac
INNER JOIN proizvod ON dobavljac.id = proizvod.id_dobavljac
INNER JOIN narudzba ON proizvod.id = narudzba.id_proizvod
INNER JOIN kupac ON narudzba.id_kupac = kupac.id
INNER JOIN metoda_placanja ON narudzba.id_metoda_placanja = metoda_placanja.id
INNER JOIN racun ON narudzba.id = racun.id_narudzba;

#-----------------Upit koji će prikazati ukupan iznos po kupljenom proizvodu--------------------------------------------------------
SELECT SUM(r.iznos) as ukupan_iznos, COUNT(r.placeno) as broj_placenih_racuna, p.naziv as naziv_proizvoda
FROM racun r
INNER JOIN narudzba n ON r.id_narudzba = n.id
INNER JOIN proizvod p ON n.id_proizvod = p.id
WHERE r.placeno = 'D'
GROUP BY p.naziv;

#----------------------------------Upit koji prikazuje postotke obavljenih narudžbi dobavljača-------------------------------------------
SELECT dobavljac.ime, dobavljac.prezime, COUNT(narudzba.id) AS broj_narudzbi,
(COUNT(narudzba.id) / (SELECT COUNT(narudzba.id) FROM narudzba) * 100) AS postotak_narudzbi 
FROM dobavljac
INNER JOIN proizvod ON proizvod.id_dobavljac = dobavljac.id
INNER JOIN narudzba ON narudzba.id_proizvod = proizvod.id
GROUP BY dobavljac.ime, dobavljac.prezime
ORDER BY broj_narudzbi DESC;

SELECT id, DATEDIFF(datum_isporuke, datum_narudzbe) AS vrijeme_dostave_u_danima
FROM narudzba;
