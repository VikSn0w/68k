    ORG    $8000
ARRAY   dc.w   1,2,3,4,5,6,7,8,9,10
ARRAYF  ds.w   10
LIMIT   dc.w   8

    ORG    $8200
START:                  
    clr.w    D0 ;index array
    clr.w    D1 ;index arrayf
    clr.w    D2 ;LIMIT
    clr.w    D7 ;foo
    
    move.w   LIMIT, D2

    lea ARRAY, A0
    lea ARRAYF, A1

LOOP:
    move.w   (A0, D0),D7 ;D7 = A0[D0]
    btst     #0,D7       ;verify if odd
    bne      IF

ENDLOOP:
    add.w    #2,D0       ;D0 += 2
    dbra     D2,LOOP     ;itera fino a D2 uguale a -1
    jmp ENDCYCLE
    
IF:
    move.w (A0, D0),(A1, D1) ;A1[D1] = A0[D0]
    add.w  #2, D1            ;D1 += 2
    jmp ENDLOOP
    
ENDCYCLE:
    SIMHALT
    END    START
