import sqlite3
from flask import Flask, flash, jsonify,request,redirect, url_for, render_template, url_for,  Response, session
import json,requests
from flask import render_template, send_from_directory
from flask_mysqldb import MySQL, MySQLdb
from services.apicnx import Usuario 
from config import configura    
from flask_sqlalchemy import SQLAlchemy
import os
from functools import wraps
from email.mime.multipart import MIMEMultipart
import smtplib
from email.mime.text import MIMEText
from flask_mail import Mail, Message

app=Flask(__name__, template_folder='templates')
app.secret_key = 'some_secret-key'

app.config['MYSQL_HOST']= 'localhost'
app.config['MYSQL_USER']= 'root'
app.config['MYSQL_PASSWORD']= '1234'
app.config['MYSQL_DB']= 'comite'
app.config['MYSQL_CURSORCLASS']= 'DictCursor'

mysql=MySQL(app)
########## inicio

@app.route('/')
def index():
    return redirect (url_for("loginUsuarios"))

@app.route('/login')
def loginUsuarios():
    return render_template ("login.html")

#finalizado login
@app.route('/acceso-login', methods=["GET", "POST"])
def FuncionL():
    if request.method == 'POST' and 'txtDocumento' in request.form and 'txtPassword' in request.form:
        _Identificacion = request.form['txtDocumento']
        _Password = request.form['txtPassword']

        if not _Identificacion or not _Password:
            return render_template('login.html', mensaje="Los campos no deben estar vacíos")
        
        cur = mysql.connection.cursor()
        try:
            cur.execute('SELECT * FROM usuario WHERE Identificacion = %s AND password = %s', (_Identificacion,_Password))
            account = cur.fetchone()
        finally:
            cur.close()

        if account:
            session['Logeado'] = True
            session['id'] = account['Identificacion']
            session['id_rol'] = account['id_rol']
            session['password'] = account['password']

            if session['id_rol'] == 1:
                return render_template("inicio_coordinacion.html")
            elif session['id_rol'] == 2:
                return render_template("inicio_instructor.html")
            elif session['id_rol'] == 3:
                return render_template("Inicio_relator.html")
            elif session['id_rol'] == 4:
                return render_template("inicio_Aprendiz.html")

            return render_template("login.html")
        else:
            return render_template('login.html', mensaje="El usuario no existe o la contraseña es incorrecta")

    return render_template('login.html')
#finalizado login


#tabla de usuarios Actualizar, eliminar #/coordinador
@app.route('/usuarios', methods=["GET","POST"])
def usuarios():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM usuario")
    usuario = cur.fetchall()
    cur.close()

    return render_template("control_U.html", usuario=usuario)

#tabla de usuarios Instructor
@app.route('/usuariosInstructor', methods=["GET","POST"])
def usuariosInstructor():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM usuario WHERE id_rol=4 ")
    usuario = cur.fetchall()
    cur.close()

    return render_template("Control_U_Instructor.html", usuario=usuario)

#funcion eliminar y editar
@app.route('/eliminarUsuario/<int:id>', methods=["GET", "POST"])
def eliminarUsuario(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM usuario WHERE Identificacion = %s", (id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('usuarios')) 


@app.route('/editarUsuario/<int:id>', methods=["GET", "POST"])
def editarUsuario(id):
    cur = mysql.connection.cursor()

    if request.method == "POST":
        _Correo = request.form['Correo']
        _Password = request.form['password']
        _Rol = request.form['id_rol']
        _Identificacion = request.form['Identificacion']

        cur.execute("""
            UPDATE usuario
            SET Correo = %s,
                password = %s,
                id_rol = %s,
                Identificacion = %s
                where Identificacion = %s
        """, (_Correo, _Password, _Rol, _Identificacion, id,))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('usuarios'))

    else:
        cur.execute("SELECT * FROM usuario WHERE Identificacion = %s", (id,))
        usuario = cur.fetchone()
        cur.close()
        return render_template("editarUsuario.html", usuario=usuario)



#######Contraseñas
def get_usuario_por_email(email):
    conn = sqlite3.connect("comite.db")
    cur = conn.cursor()
    cur.execute("SELECT * FROM Usuario WHERE correo = %s", (email,))
    Usuario = cur.fetchone()
    conn.close()
    return Usuario

@app.route('/OlvidoContraseña', methods=['GET', 'POST'])
def olvidarContraseña():
    if request.method == 'POST':
        email = request.form['email']
        
        usuario = get_usuario_por_email(email)
        
        if usuario:
            return redirect(url_for('ConfrimarCorreo'))
        else:
            return redirect(url_for('Nousuario'))
    
    return render_template("olvidarContraseña.html")


@app.route('/NoEncontrado')
def Nousuario():
    return render_template("NoUsuario.html")

@app.route('/ConfirmacionCorreo')
def ConfrimarCorreo():
    return render_template("ConfirmacionCorreo.html")


##### Routes Coordinación
# Ruta para rechazar un caso
@app.route("/rechazoCaso", methods=["GET"])
def rechazoCaso():
    f = requests.get("http://127.0.0.1:5000/rechazoCaso")
    fichas = f.json()
    print(fichas)
    return render_template("rechazo_caso.html", fichas=fichas)

@app.route("/rechazoCaso", methods=["GET", "POST"])
def rechazoCaso2():
    f = requests.get("http://127.0.0.1:5000/rechazoCaso")
    fichas = f.json()
    print(fichas)
    return render_template("rechazo_caso.html", fichas=fichas)



# Ruta de la página de Inicio rol coordinación 


@app.route('/iniciocoordinacion')
def incioCoordinacion():
    return render_template("inicio_coordinacion.html")


#Ruta para Registrar aprendiz rol coordinación

@app.route('/registro')
def registro():
    cur = mysql.connection.cursor()

    cur.execute("SELECT DISTINCT Ficha FROM usuario WHERE Ficha IS NOT NULL AND Ficha != 0")
    fichas = cur.fetchall()

    cur.execute("SELECT DISTINCT ProgramaFormacion FROM usuario WHERE ProgramaFormacion IS NOT NULL AND ProgramaFormacion != ''")
    programas_formacion = cur.fetchall()

    cur.close()

    fichas = [ficha['Ficha'] for ficha in fichas]
    programas_formacion = [programa['ProgramaFormacion'] for programa in programas_formacion]
    
    return render_template("layout/coordinacionLayout/registrarCoordinacion.html", fichas=fichas, programas_formacion=programas_formacion)





@app.route('/crear-registro', methods=["POST"])
def crear_registro():
    Correo = request.form['Correo']
    password = request.form['password']
    Identificacion = request.form.get('Identificacion')
    Nombre = request.form.get('Nombre')
    Direccion = request.form.get('Direccion')
    Telefono = request.form.get('Telefono')
    Ficha = request.form.get('Ficha')
    ProgramaFormacion = request.form.get('ProgramaFormacion')
    id_rol = request.form.get('id_rol')

    if id_rol == '4':
        if not Ficha or not Ficha.isdigit():
            return render_template("layout/coordinacionLayout/registrarCoordinacion.html", mensaje3="Ficha es obligatorio y debe ser un número válido.")
        Ficha = int(Ficha)
    else:
        Ficha = None

    cur = mysql.connection.cursor()

    try:
        print(Correo, password, Identificacion, Nombre, Direccion, Telefono, Ficha, ProgramaFormacion, id_rol ) 
        cur.execute("""
            INSERT INTO usuario (Correo, password, Identificacion, Nombre, Direccion, Telefono, Ficha, ProgramaFormacion, id_rol) 
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """, (Correo, password, Identificacion, Nombre, Direccion, Telefono, Ficha, ProgramaFormacion, id_rol))
        
        mysql.connection.commit()
        return render_template("layout/coordinacionLayout/registrarCoordinacion.html", mensaje3="Usuario registrado exitosamente.")

    except Exception as e:
        print(f"Error: {e}")
        if "1062" in str(e):
            return render_template("layout/coordinacionLayout/registrarCoordinacion.html", mensaje4="El usuario ya existe.")
        else:
            return render_template("layout/coordinacionLayout/registrarCoordinacion.html", mensaje4="Ocurrió un error durante el registro.")




# Ruta para traer las fichas rol coordinación
@app.route("/reportarAprendizcoordinacion", methods=["GET"])
def reportarCoordinacion():
    f = requests.get("http://127.0.0.1:5000/reportarAprendizcoordinacion")
    fichas = f.json()
    print(fichas)
    return render_template("reportar_coordinacion.html", fichas=fichas)

# Ruta para guardar el reporte del aprendiz rol coordinación

@app.route("/reportarAprendizcoordinacion/i", methods=['POST'])
def iniciarCoordinacion():
    Ficha = request.form.get('Ficha')
    Identificacion = request.form.get('Identificacion')
    Nombre = request.form.get('Nombre')
    ProgramaFormacion = request.form.get('ProgramaFormacion')
    Coordinacion = request.form.get('Coordinacion')
    TipoFalta = request.form.get('TipoFalta')
    CausasReporte = request.form.get('CausasReporte')
    Faltas = request.form.get('Faltas')
    EvidenciaPDF = request.files.get('EvidenciaPDF')
    evidencia_pdf_path = None
    
    uploads_dir = 'uploads'
    if not os.path.exists(uploads_dir):
        os.makedirs(uploads_dir)
    
    if EvidenciaPDF:
        evidencia_pdf_path = os.path.join(uploads_dir, EvidenciaPDF.filename)
        EvidenciaPDF.save(evidencia_pdf_path)

    u2 = Usuario("http://127.0.0.1:5000/reportarAprendizcoordinacion")
    datos = {
        "Ficha": Ficha, 
        "Identificacion": Identificacion, 
        "Nombre": Nombre, 
        "ProgramaFormacion": ProgramaFormacion, 
        "Coordinacion": Coordinacion, 
        "TipoFalta": TipoFalta, 
        "CausasReporte": CausasReporte, 
        "Faltas": Faltas, 
        "EvidenciaPDF": evidencia_pdf_path
    }

    cur = mysql.connection.cursor()
    cur.execute("""
    INSERT INTO reporte (Ficha, Identificacion, Nombre, ProgramaFormacion,Coordinacion, TipoFalta, CausasReporte, Faltas, EvidenciaPDF)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s,%s)
    """, (Ficha, Identificacion, Nombre, ProgramaFormacion, Coordinacion, TipoFalta, CausasReporte, Faltas, evidencia_pdf_path))

    mysql.connection.commit()
    cur.close()


    u2.Inserte(datos)
    msgitos = "Reporte creado satisfactoriamente" 
    print(datos)
    return render_template("alertas.html", msgito=msgitos)

@app.route('/eliminarReporte/<int:id>', methods=['POST'])
def eliminarReporte(id):
    cur = mysql.connection.cursor()
    sql = "DELETE FROM reporte WHERE IdReporte = %s"
    cur.execute(sql, (id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('procesosCoordinacion'))

## Ruta para mostrar los Procesos pendientes rol coordinación  16-09-024 listo
@app.route("/procesosPendientescoordinacion/i")
def procesosCoordinacion(): 
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM reporte")
    resultados = cursor.fetchall()
    
    #Traer pdf db
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT EvidenciaPDF FROM reporte")
    PDF = cursor.fetchall()
    print (PDF)
    if resultados:
        reporte = [{
            'IdReporte': row['IdReporte'],
            'Identificacion': row['Identificacion'],
            'Nombre': row['Nombre'],
            'Ficha': row['Ficha'],
            'ProgramaFormacion': row['ProgramaFormacion'],
            'Coordinacion': row['Coordinacion'],
            'TipoFalta': row['TipoFalta'],
            'CausasReporte': row['CausasReporte'],
            'Faltas': row['Faltas'],
            'EvidenciaPDF': PDF,
        } for row in resultados]
        return render_template("procesos_coordinacion.html", reportes=reporte)
    else:
        msgitos="No hay reportes pendientes"
        return render_template("alertas.html",msgito=msgitos)


# Ruta para relizar la citación del aprendiz rol coordinación 

@app.route("/citacioncoordinacion", methods=["GET", "POST"])
def citacion():
    # correo de la base de datos
    # cursor = mysql.cursor()
    # cursor.execute("SELECT Correo FROM Usuarios WHERE id = %s", (Identificacion,))
    # Correo = cursor.fetchone()
    if request.method == "POST":
        Asunto = request.form.get("Asunto", "").strip()
        Correo = request.form.get("Correo", "").strip()
        FechaCitacion = request.form.get("FechaCitacion", "").strip()
        HoraCitacion= request.form.get("HoraCitacion", "").strip()
        
        servidor = smtplib.SMTP("smtp.gmail.com", 587)
        servidor.starttls()
        servidor.login("cielonicolemunarfino@gmail.com", "rt u t c k o k d q y y d l o o ")


        msg = MIMEText(f"Cordial saludo:\n Se encuentra citado a comite debio a {Asunto}\n  Fecha citacion: {FechaCitacion}\n Hora Citacion: {HoraCitacion}")

        msg["From"] = "cielonicolemunarfino@gmail.com"
        msg["To"] = Correo
        msg["Subject"] = "Citacion a comite"
        servidor.sendmail ("cielonicolemunarfino@gmail.com", Correo, msg.as_string())

        servidor.quit ()
        msgitos="Se ha enviado la citación al aprendiz" 
        return render_template("alertas.html",msgito=msgitos)

    else: 
        return render_template("citacion_coordinacion.html")


# Ruta para Consultar Historial del aprendiz rol coordianción 

@app.route("/consultarcoordinacion/", methods=["GET", "POST"])
def historialCoordinacion():
    return render_template("consultar_coordinacion.html", N=0)

@app.route("/consultarcoordinacion/<int:id>", methods=["GET", "POST"])
def historialCoordinacion2(id=0):
    return render_template("consultar_coordinacion.html", N=id)

@app.route("/resultadoHistorial/")
def resultadoHistorial():
    return render_template("busqueda_historial.html")

@app.route("/consultarcoordinacion/i", methods=["POST"])
def consultarAprendiz():
    Identificacion = request.form.get('Identificacion')

    cur = mysql.connection.cursor()
    sql = "SELECT * FROM reporte WHERE Identificacion = %s"
    cur.execute(sql, (Identificacion,))
    Reporte = cur.fetchall()
    cur.close()

    if Reporte:
        Reporte = [{
            "IdReporte": row['IdReporte'],
            "Identificacion": row['Identificacion'],
            "Nombre": row['Nombre'],
            "Ficha": row['Ficha'],
            "ProgramaFormacion": row['ProgramaFormacion'],
            "Coordinacion": row['Coordinacion'],
            "TipoFalta": row['TipoFalta'],
            "CausasReporte": row['CausasReporte'],
            "Faltas": row['Faltas'],
            "EvidenciaPDF": row['EvidenciaPDF']
        } for row in Reporte]

        return render_template("busqueda_historial.html", reportes=Reporte)
    else:
        return render_template("busqueda_historial.html", mensaje='No se encontró ningún reporte para la cédula proporcionada.', redir=True)


############


######## Routes Instructor

# Ruta de Inicio del rol instructor 

@app.route("/inicioinstructor")
def inicioInstructor():
    return render_template("inicio_instructor.html")


# Ruta para Reportar aprendiz rol instructor 
@app.route("/reportarAprendizinstructor/", methods=["GET"])
def reportarInstructor2():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Reporte")
    fichas = cur.fetchall()
    cur.close()
    print(f"These are the IDs: {fichas}")
    return render_template("reportar_Instructor.html", fichas=fichas)


@app.route("/reportarAprendizinstructor/i", methods=['POST'])
def iniciarInstructor():
    Ficha = request.form.get('Ficha')
    Identificacion = request.form.get('Identificacion')
    Nombre = request.form.get('Nombre')
    ProgramaFormacion = request.form.get('ProgramaFormacion')
    Coordinacion = request.form.get('Coordinacion')
    TipoFalta = request.form.get('TipoFalta')
    CausasReporte = request.form.get('CausasReporte')
    Faltas = request.form.get('Faltas')
    EvidenciaPDF = request.files.get('EvidenciaPDF')
    evidencia_pdf_path = None

    uploads_dir = 'uploads'
    if not os.path.exists(uploads_dir):
        os.makedirs(uploads_dir)

    if EvidenciaPDF:
        evidencia_pdf_path = os.path.join(uploads_dir, EvidenciaPDF.filename)
        EvidenciaPDF.save(evidencia_pdf_path)

    cur = mysql.connection.cursor()
    cur.execute("""
        INSERT INTO reporte (Ficha, Identificacion, Nombre, ProgramaFormacion,Coordinacion, TipoFalta, CausasReporte, Faltas, EvidenciaPDF)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (Ficha, Identificacion, Nombre, ProgramaFormacion, Coordinacion, TipoFalta, CausasReporte, Faltas, evidencia_pdf_path))

    mysql.connection.commit()
    cur.close()

    msgito1 = "Reporte creado satisfactoriamente"
    return render_template("reportar_instructor.html", msgito1="Reporte creado")



# Ruta para consultar historial del aprendiz rol instructor 

@app.route("/consultarHistorialinstructor")
def consultarInstructor():
    return render_template("consultar_instructor.html")

@app.route("/consultarHistorialinstructor/",methods=["GET","POST"])
def consultarIntructor(id=0):
    return render_template("consultar_instructor.html", N=id)

@app.route("/resultadoHistorialinstructor/")
def resultadoHistorialinstructor():
    return render_template("busqueda_instructor.html")


@app.route("/consultarHistorialinstructor/i", methods=["POST"])
def consultarAprendizinstructor():
    Identificacion=request.form.get('Identificacion')

    cur = mysql.connection.cursor()

    sql="select * from reporte where Identificacion = %s"
    cur.execute(sql, (Identificacion,))

    Reporte = cur.fetchall()

    cur.close()

    if Reporte:
        Reporte= [{
        "IdReporte": row['IdReporte'],
        "Identificacion": row['Identificacion'],
        "Nombre": row['Nombre'],
        "Ficha": row['Ficha'],
        "ProgramaFormacion": row['ProgramaFormacion'],
        "Coordinacion": row['Coordinacion'],
        "TipoFalta": row['TipoFalta'],
        "CausasReporte": row['CausasReporte'],
        "Faltas": row['Faltas'],
        "EvidenciaPDF": row['EvidenciaPDF']
        } for row in Reporte]


        return render_template("busqueda_instructor.html", reportes= Reporte)
        

    else:

        msgitos="No existen reportes para este aprendiz" 
        return render_template("alertas.html",msgito=msgitos)


####### Routes Aprendiz

#Ruta inicio aprendiz 

@app.route("/inicioaprendiz")
def inicioAprendiz():
    return render_template("inicio_aprendiz.html")


#Ruta historial del aprendiz 

# @app.route("/historialAprendiz/", methods=["GET", "POST"])
# def historialCoordinacion():
#     return render_template("historial_aprendiz.html", N=0)

# @app.route("/historialAprendiz/<int:Identificacion>", methods=["GET", "POST"])
# def historialCoordinacion2(Identificacion=0):
#     return render_template("historial_aprendiz.html", N=Identificacion)

# @app.route("/resultadoHistorial/")
# def resultadoHistorial():
#     return render_template("busqueda_historial.html")

@app.route("/historialAprendiz/", methods=["GET","POST"])
def historialAprendiz():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM reporte ")
    resultados = cursor.fetchall()
    
    if resultados:
        reporte = [{
            'IdReporte': row['IdReporte'],
            'Identificacion': row['Identificacion'],
            'Nombre': row['Nombre'],
            'Ficha': row['Ficha'],
            'ProgramaFormacion': row['ProgramaFormacion'],
            'Coordinacion': row['Coordinacion'],
            'TipoFalta': row['TipoFalta'],
            'CausasReporte': row['CausasReporte'],
            'Faltas': row['Faltas'],
            'EvidenciaPDF': row['EvidenciaPDF'],
        } for row in resultados]
        return render_template("historial_aprendiz.html",reportes= reporte)
    else:
        msgitos="No hay reportes pendientes"
        return render_template("alertas.html",msgito=msgitos)
    

#Ruta descargos aprendiz

class Datos(mysql):
    Descargos = request.form.get('Descargos')
    Evidencias = request.files.get('Evidencias')

    def __init__ (self, Descargos, Evidencias):
        self.Descargos = Descargos
        self.Evidencias = Evidencias 

@app.route("/descargosAprendiz",methods=["GET","POST"])
def descargosAprendiz():

    if request.method == 'POST':
        Datos = request.files['fileUpload']
        upload = Datos(Evidencias= Datos.Evidencias, data=Datos.read())
        mysql.session.add(upload)
        mysql.session.commit()
    files_available = Datos.query.all()
    return render_template('inicio_aprendiz.html', files = files_available)       




########## Routes Relator
@app.route('/ini_relator')
def Rechazo():
    return render_template('Inicio_relator.html')

#Ruta acta relator 

@app.route("/actarelator")
def actaRelator():
    return render_template("acta_relator.html")

#Ruta para registrar acta (modificar)

@app.route("/registrarActa/i", methods=["POST"])
def CrearActa():
    datos = request.get_json()
    IdActa=datos['IdActa']
    FechaActa=datos['FechaActa']
    Hora=datos['Hora']
    DetallesActa=datos['DetallesActa']
    IdPlanMejora=datos['PlanMejora']

    print(f"Datos recibidos: IdActa={IdActa}, FechaActa={FechaActa}, Hora={Hora}, DetallesActa={DetallesActa}, IdPlanMejora={IdPlanMejora}")

    con = sqlite3.connect("./comite.db")
    cur = con.cursor()
    
    cur.execute("insert into Acta (IdActa, FechaActa, Hora, DetallesActa, PlanMejora) VALUES(%s, %s, %s, %s, %s, %s)",IdActa, FechaActa, Hora, DetallesActa, IdPlanMejora)
    con.commit()
    con.close()
    msgitos="Acta creada satisfactoriamente" 
    return render_template("alertas.html",msgito=msgitos)
   
#Ruta para mostrar procesos relator 

@app.route("/procesosrelator")
def procesosRelator():
    return render_template("procesos_relator.html")




if __name__=='__main__':
    app.run(debug=True,host='0.0.0.0',port=configura['PUERTOAPP'])    
    