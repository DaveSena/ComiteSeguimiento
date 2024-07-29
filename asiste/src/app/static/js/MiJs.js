
    function Ir1(cual){
        location.href=cual
       }
        function Confirmar(que,donde){
            if (confirm(que))
              location.href=donde
        }
       function Va(tipo){
        
        if(tipo=="i")
        document.forms['mio'].action="/niveles/i"
        if(tipo=="u"){
         
         document.forms['mio'].action="/niveles/u"   
        }
        
        document.forms['mio'].submit();    
     
       }
   