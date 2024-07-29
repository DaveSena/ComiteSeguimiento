import json,requests
from config import configura   
class Usuario:
    url=None
    res=None
    data=None
    def __init__(self,murl=configura['SERVER_NAME']):
        self.url=murl

    def ListarTodos(self):
        self.res=requests.get(self.url+"/to")
        data1=json.loads(self.res.content)
        return data1
    def ListarUno(self,cual=0):    
        self.res=requests.get(self.url+"/"+str(cual))
        data1=json.loads(self.res.content)
        if data1!=[]:
            return(data1)
        else:
            return False  
    def ListarJson(self):    
        self.res=requests.get(self.url+"/menus")
        data1=json.loads(self.res.content)
        if data1!=[]:
            return(data1)
        else:
            return False  
    def Inserte(self,data):
            response = requests.post(self.url+"/i", json=data)
    def Borra(self,cual):
        response = requests.delete(self.url+"/d/"+str(cual))
    def Actualiza(self,data):
        response = requests.put(self.url+"/u", json=data)
