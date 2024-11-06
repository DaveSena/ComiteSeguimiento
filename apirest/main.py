import sqlite3
from flask import Flask, jsonify, request, render_template
from api.cnxSqlite import cnxsqlite
from config import configura
from flask_mail import Mail, Message
from flask_sqlalchemy import SQLAlchemy
from flask_mysqldb import MySQL, MySQLdb
import mysql.connector

app = Flask(__name__)
app.config['SECRET_KEY'] = 'password'

app.config['MAIL_SERVER'] = 'lau3232435124@gmail.com'
app.config['MAIL_PORT'] = 5000
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'lau3232435124@gmail.com'
app.config['MAIL_PASSWORD'] = 'password'

mail = Mail(app)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '1234'
app.config['MYSQL_DB'] = 'comite'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
mysql=MySQL(app)

@app.route("/citarComite", methods=['POST'])
def Citar():
    Usuario_id = request.form['Identificacion']
    Usuario = Usuario.query.get(Usuario_id)
    if Usuario:
        subject = "Nueva citación"
        body = f"Hola {Usuario.Nombre}, has sido citado a comite el día"


# Ruta para obtener la lista de fichas de aprendices
@app.route("/reportarAprendizcoordinacion", methods=['GET'])
def TraerFicha():
    try:
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        sql = """
            SELECT Identificacion, Nombre, ProgramaFormacion, Ficha 
            FROM usuario 
            WHERE id_rol = 4
        """
        cur.execute(sql)
        resultados = cur.fetchall()
        cur.close()
        return jsonify(resultados)
    except MySQLdb.Error as e:
        print(f"Error en la consulta MySQL: {e}")
        return jsonify({"error": "Error al consultar la base de datos"}), 500


# Ruta para registrar un nuevo proceso de reporte de aprendices rol coordinación
@app.route("/reportarAprendizcoordinacion/i", methods=['POST'])
def iniciarProceso():
    try:
        Identificacion = request.form.get('Identificacion')
        TipoFalta = request.form.get('TipoFalta')
        CausasReporte = request.form.get('CausasReporte')
        Faltas = request.form.get('Faltas')
        EvidenciaPDF = request.form.get('EvidenciaPDF')
        TipoFalta = request.form.get('TipoFalta')

        cur = mysql.connection.cursor()
        sql = """
            SELECT Ficha, Identificacion, Nombre, ProgramaFormacion
            FROM Usuario
            WHERE Identificacion = %s AND Role = 4
        """
        cur.execute(sql, (Identificacion,))
        usuario_data = cur.fetchone()

        if usuario_data:
            Ficha = usuario_data['Ficha']
            Nombre = usuario_data['Nombre']
            ProgramaFormacion = usuario_data['ProgramaFormacion']
            TipoFalta = usuario_data['TipoFalta']

            cur.execute("""
                INSERT INTO Reporte (Ficha, Identificacion, Nombre, ProgramaFormacion, TipoFalta, CausasReporte, Faltas, EvidenciaPDF)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (Ficha, Identificacion, Nombre, ProgramaFormacion, TipoFalta, CausasReporte, Faltas, EvidenciaPDF))

            mysql.connection.commit()
            cur.close()

            return jsonify({"message": "Proceso de reporte iniciado correctamente"})
        else:
            cur.close()
            return jsonify({"error": "No se encontró el aprendiz con la identificación proporcionada o no tiene el rol adecuado."}), 404
    except MySQLdb.Error as e:
        return jsonify({"error": str(e)}), 500



# Ruta para consultar reportes de aprendices por coordinación
@app.route("/consultarcoordinacion/i", methods=["POST"])
def consultarAprendiz():
    try:
        Identificacion = request.form.get('Identificacion')
        cur = mysql.connection.cursor()
        sql = "SELECT * FROM Reporte WHERE Identificacion = %s"
        cur.execute(sql, (Identificacion,))
        Reporte = cur.fetchall()
        cur.close()

        if Reporte:
            return render_template("busqueda_historial.html", reportes=Reporte)
        else:
            msgitos = "No existen reportes para este aprendiz"
            return render_template("alertas.html", msgito=msgitos)
    except MySQLdb.Error as e:
        return str(e), 500




# Ruta para crear un acta
@app.route("/registrarActa/i", methods=["POST"])
def CrearActa():
    try:
        datos = request.get_json()
        IdActa = datos['IdActa']
        FechaActa = datos['FechaActa']
        Hora = datos['Hora']
        DetallesActa = datos['DetallesActa']
        IdPlanMejora = datos['PlanMejora']

        con = sqlite3.connect("./comite.db")
        cur = con.cursor()

        cur.execute("INSERT INTO Acta (IdActa, FechaActa, Hora, DetallesActa, PlanMejora) VALUES (%s, %s, %s, %s, %s)", (IdActa, FechaActa, Hora, DetallesActa, IdPlanMejora))
        con.commit()
        con.close()

        return "Acta creada correctamente"
    except Exception as e:
        return str(e), 500


if __name__ == '__main__':
    app.run(debug=True, port=configura['PUERTOREST'], host='0.0.0.0')
