import sqlite3
class cnxsqlite:
    def Consultar(self,bd,sql):
        con = sqlite3.connect(bd)
        cur = con.cursor()
        res=cur.execute(sql)
        todo=res.fetchall()
        con.close() 
        return todo   
    def ConsultarUno(self,bd,sql):
        con = sqlite3.connect(bd)
        todo={}
        cur = con.cursor()
        res=cur.execute(sql)
        nombres_columnas = [str(descripcion[0]) for descripcion in cur.description]
        primer_resultado = res.fetchone()
        for i,valor in enumerate(primer_resultado):
            nombrecol=nombres_columnas[i]
            todo[nombrecol]=valor
        con.close() 
        return todo  
    def ConsultarJson(self,bd,sql):
        con = sqlite3.connect(bd)
        todo=[]
        cur = con.cursor()
        res=cur.execute(sql)
        nombres_columnas = [descripcion[0] for descripcion in cur.description]
        print(nombres_columnas)
        primer_resultado = res.fetchall()
    
        for i,valor in enumerate(primer_resultado):
            aux1=valor
            aux2= nombres_columnas
            aux3=dict(zip(aux2,aux1))   
            todo.append(aux3)
        con.close() 
        return list(todo)  
    def Ejecutar(self,bd,sql):
        con = sqlite3.connect(bd)
        cur = con.cursor()
        res=cur.execute(sql)
        con.commit()
        con.close()