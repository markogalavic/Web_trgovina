from flask import Flask, render_template, request, redirect, url_for
import mysql.connector


app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def Login():
    err =" "

    if request.method == 'POST':
        
        web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
        
        korisnik = request.form['username']
        lozinka = request.form['password']

        krusor = web.cursor()         
        krusor.execute("select ime,lozinka from login where ime ='"+korisnik+"' and lozinka='" +lozinka+ "';")
       
        if krusor.fetchone() == None:
            err = "Došlo je do pogreške!"
           
        else:
            print("uspjesno prijavita osoba!")
            return render_template("početna.html")
            
    return render_template("prijava.html", err = err)


@app.route("/admin",  methods=['GET', 'POST'])
def admin():

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("select ime,prezime,email,korisnicko_ime,lozinka from shop_admin")
    data = krusor.fetchall()

    return render_template("admin.html",data=data,lendata= len(data))


@app.route("/admin/dodajad", methods=["POST"])
def dodaj_admin():
 
    ime=request.form['ime']
    prezime=request.form['prezime']
    email=request.form['email']
    kor_ime=request.form['k_ime']
    lozinka=request.form['lozinka']

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into shop_admin(ime,prezime,email,korisnicko_ime,lozinka) values (%s,%s,%s,%s,%s)", 
                    [ime,prezime,email,kor_ime,lozinka])
    web.commit()
    web.close()
    
    return redirect(url_for('admin'))


@app.route("/kupac",  methods=['GET', 'POST'])
def kupac():

    kazaliste = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = kazaliste.cursor()  
    krusor.execute("select ime,prezime,oib,datum_rodenja,mobitel,email,adresa,grad,drzava,korisnicko_ime,lozinka from kupac")
    data = krusor.fetchall()

    return render_template("kupac.html",data=data,lendata= len(data))


@app.route("/kupac/dodajkup", methods=['POST'])
def dodaj_gl():

    ime=request.form['ime']
    prezime=request.form['prezime']
    oib=request.form['oib']
    d_rod=request.form['datum_rodenja']
    mobitel=request.form['mobitel']
    email=request.form['email']
    adresa=request.form['adresa']
    grad=request.form['grad']
    drzava=request.form['drzava']
    kor_ime=request.form['korisnicko_ime']
    lozinka=request.form['lozinka']

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into kupac(ime,prezime,oib,datum_rodenja,mobitel,email,adresa,grad,drzava,korisnicko_ime,lozinka) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", 
                    [ime,prezime,oib,d_rod,mobitel,email,adresa,grad,drzava,kor_ime,lozinka])
    web.commit()
    web.close()
    
    return redirect(url_for('kupac'))


@app.route("/dobavljac", methods=['GET','POST'])
def dobavljac():
 
    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("select ime,prezime from dobavljac")
    data = krusor.fetchall()

    return render_template("dobavljac.html",data=data,lendata= len(data))


@app.route("/dobavljac/dodajdob", methods=['POST'])
def dodaj_dobavljac():
 
    ime=request.form['ime']
    prezime=request.form['prezime']


    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into dobavljac(ime,prezime) values (%s,%s)", 
                    [ime,prezime])
    web.commit()
    web.close()

    return redirect(url_for('dobavljac'))


@app.route("/proizvod", methods=['GET', 'POST'])
def proizvod():
    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("select naziv,aktivan,kolicina_u_skladistu,cijena from proizvod")
    data = krusor.fetchall()

    return render_template("proizvod.html",data=data,lendata= len(data))

@app.route("/proizvod/dodajpro", methods=["POST"])
def dodaj_pro():
 
    naziv=request.form['naziv']
    aktivan=request.form['aktivan']
    kol_pro=request.form['kol_pro']
    cijena=request.form['cijena']
    vrsta=request.form['vrsta']
    dobavljac=request.form['dobavljac']

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into proizvod(id_vrsta,id_dobavljac,naziv,aktivan,kolicina_u_skladistu, cijena) values (%s,%s,%s,%s,%s,%s)", 
                    [vrsta,dobavljac,naziv,aktivan,kol_pro,cijena])
    web.commit()
    web.close()
    
    return redirect(url_for('proizvod'))


@app.route("/racun", methods=['GET','POST'])
def racun():
    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("select id_narudzba,broj, iznos,datum,placeno from racun")
    data = krusor.fetchall()

    return render_template("racun.html",data=data,lendata= len(data))


@app.route("/racun/dodajrac", methods=["POST"])
def dodaj_rac():
 
    
    broj=request.form['broj']
    iznos=request.form['iznos']
    datum=request.form['datum']
    placeno=request.form['placeno']
    idnar=request.form['idnar']

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into racun(id_narudzba,broj,iznos,datum,placeno) values (%s,%s,%s,%s,%s)", 
                    [idnar,broj,iznos,datum,placeno])
    web.commit()
    web.close()
    
    return redirect(url_for('racun'))


@app.route("/narudzba")
def narudzba():
    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("select id_admin,id_kupac,id_dostavljac,id_proizvod,id_metoda_placanja,kolicina, datum_narudzbe,datum_isporuke,komentar,stanje from narudzba")
    data = krusor.fetchall()

    return render_template("narudzba.html",data=data,lendata= len(data))


@app.route("/narudzba/dodajnar", methods=["POST"])
def dodaj_nar():
 
    
    kol=request.form['kolicina']
    datn=request.form['dat_nar']
    dati=request.form['dat_isp']
    kom=request.form['komentar']
    st=request.form['stanje']
    idad=request.form['id_admin']
    idkup=request.form['id_kupac']
    iddos=request.form['id_dostavljac']
    idpro=request.form['id_proizvod']
    idmpl=request.form['id_metoda_placanja']

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.execute("insert into narudzba(id_admin,id_kupac,id_dostavljac,id_proizvod,id_metoda_placanja,kolicina,datum_narudzbe,datum_isporuke,komentar,stanje) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", 
                    [idad,idkup,iddos,idpro,idmpl,kol,datn,dati,kom,st])
    web.commit()
    web.close()
    
    return redirect(url_for('narudzba'))


@app.route("/procedura")
def procedura():

    return render_template("procedura.html")


@app.route("/procedura/unos")
def procedura_unos():

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.callproc("dodaj_proizvod",['7', '6', 'frizider', 'D', '11', 199.99])
    web.commit()
    web.close()
    return redirect(url_for('procedura'))


@app.route("/procedura/unos2")
def procedura_unos2():

    web = mysql.connector.connect(host = 'localhost', database = 'sustav_za_upravljanje_web_trgovinom', user = 'root', password = 'root')
    krusor = web.cursor()  
    krusor.callproc("dodaj_dobavljaca",['Mario', 'Marić'])
    web.commit()
    web.close()
    return redirect(url_for('procedura'))

@app.route("/racunica")
def racunica():

    return render_template("racunica.html")


@app.route("/racunica/unos3")
def racunica_unos():
    kazaliste = mysql.connector.connect(host = 'localhost', database = 'kazaliste', user = 'root', password = 'root')
    krusor = kazaliste.cursor()  
    krusor.execute("SELECT dobavljac.ime AS 'Ime dodavljača', dobavljac.prezime AS 'Prezime dobavljača', proizvod.naziv AS 'Proizvod', proizvod.cijena AS 'Cijena', kupac.ime AS 'Ime kupca', kupac.prezime AS 'Prezime kupca',metoda_placanja.metoda AS 'Metoda plaćanja', narudzba.kolicina AS 'Kolicina', narudzba.datum_narudzbe AS 'Datum narudžbe', narudzba.datum_isporuke AS 'Datum isporuke',racun.broj AS 'Broj računa', racun.iznos AS 'Iznos', (racun.iznos/(SELECT SUM(racun.iznos) FROM racun))*100 AS Postotak FROM dobavljac INNER JOIN proizvod ON dobavljac.id = proizvod.id_dobavljac INNER JOIN narudzba ON proizvod.id = narudzba.id_proizvod INNER JOIN kupac ON narudzba.id_kupac = kupac.id INNER JOIN metoda_placanja ON narudzba.id_metoda_placanja = metoda_placanja.id INNER JOIN racun ON narudzba.id = racun.id_narudzba;")
    data = krusor.fetchall()

    return render_template("racunica.html",data=data,lendata= len(data))


@app.route("/pocetak")
def pocetak():
    return render_template("traka.html")


@app.route("/vrati")
def vrati():
    return redirect(url_for('Login')), render_template("prijava.html")


if __name__ == '__main__':
    app.run(debug=True)





