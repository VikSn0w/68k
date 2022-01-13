        ORG    $8000
VAL1  dc.b 10
VAL2  dc.b 10
RES   dc.w $1000 

    ORG    $8200
START:
    movea.w RES, A0 ;sposta l'indirizzo contenuto in RES in A0
    
    clr  (A0)       ;inizializza a 0 la locazione di memoria puntata da A0
    
    move.b VAL1, D0 
    move.b VAL2, D1
    
    add.b  D1, D0
    add.b  D0, (A0) ;aggiunge D0 alla locazione di memoira puntata da A0, quindi D0 + 0
    
    SIMHALT
    END START
