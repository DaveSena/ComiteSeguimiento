import json,requests
from services.apicnx import Usuario       

u1= Usuario("http://127.0.0.1:5000/usua")
#print(u1.ListarUno(16))

#print(u1.ListarTodosC())

emp={
    "NOMBRE":"Soila","APELLIDO":"Vaca del corrar"
}
u1.Inserte(emp)
#u1.Borra(39)


emp={
    "IDUSUARIO":39,"NOMBRE":"Soila","APELLIDO":"Vaca del Corral"
}
#u1.Actualiza(emp)
''''''
x=u1.ListarTodos()
print(x)
print(len(u1.ListarTodos()))
print(x[2][1],x[2][2])
a=input("Oprima una tecla para continuar......")

