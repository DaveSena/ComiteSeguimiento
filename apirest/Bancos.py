class CuentaBancaria:
    
    def __init__(self,cta,titular,saldo,mon):
      self.__cta=cta
      self.__titular=titular
      self.__saldo=saldo
      self.__moneda=mon
    def depositar(self,valor):
      self.__saldo+=valor
    
    def retiro(self,valor):
      if self.__saldo>=valor:
        self.__saldo-=valor
    
    def transferir(self,ctas:CuentaBancaria,valor):
      if self.__moneda!=ctas.__moneda:
        raise ValueError("No se puede transferencia con diferente montedas")
      if self.__saldo>=valor:
        ctas.depositar(valor)
        self.retiro(valor)
      else:
        print("Fondos Insuficientes")
    def getSaldo(self):
      return self.__saldo 
c1=CuentaBancaria(1234,'Sandra',1000,"PCOL")
c1.depositar(500)
c1.retiro(200)
print(c1.getSaldo())
c2=CuentaBancaria(567,'Ulda',200,"PCOL")
c1.transferir(c2,150)
print(c1.getSaldo())
print(c2.getSaldo())
