# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 10:59:32 2024

@author: Administrador
"""

def longitud_valida(cadena):
  return len(cadena)>=8


def caracteres_especiales (cadena) :
    return cadena.isalpha()
    
    
def validar_contrasena(contraseña, fun1,fun2):
    a="Longitud valida" if fun1(contraseña)else "Longitud invalida"
    print(a)  
    
    a="No tiene caracteres especiales" if fun2(contraseña)else "tiene caracteres especiales"
    print(a) 

validar_contrasena(input("Ingrese contraseña:"),longitud_valida,caracteres_especiales)



