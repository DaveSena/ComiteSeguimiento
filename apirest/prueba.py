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
    """, (Ficha, Identificacion, Nombre, ProgramaFormacion, Coordinacion,TipoFalta, CausasReporte, Faltas, EvidenciaPDF))

    mysql.connection.commit()
    cur.close()


    u2.Inserte(datos)
    msgitos = "Reporte creado satisfactoriamente" 
    print(datos)
    return render_template("alertas.html", msgito=msgitos)