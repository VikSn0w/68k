    ORG    $8000
ARRAY   dc.w   1,2,3,4,5,6,7,8,9
LIMIT   dc.w   8

    ORG    $8200
START:                  
    clr.w    D0 ;registro indice
    clr.w    D1 ;registro per il loop LIMIT
    clr.w    D2 ;registro accumulatore (somma)
    clr.w    D7 ;registro di appoggio per la somma
    
    move.w   LIMIT, D1

    lea ARRAY, A0
    
LOOP:
    move.w   (A0, D0), D7 ;D7 = A0[D0]
    add.w    D7, D2       ;D2 += D7
    add.w    #2, D0       ;D0 += 2
    DBRA     D1, LOOP ;itera fino a Di uguale a -1
    
    SIMHALT
    END    START
