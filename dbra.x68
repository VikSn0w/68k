    ORG    $8000
LIMIT   dc.w   9  

    ORG    $8200
START:                  
    clr.w    D0
    clr.w    D1
    move.w   LIMIT, D1

LOOP:
    add.w    #1, D0
    dbra     D1, LOOP ;itera fino a D1 uguale a -1
    
    SIMHALT
    END    START
