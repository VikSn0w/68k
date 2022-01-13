ORG    $8000
LIMIT   dc.w   9  

    ORG    $8200
START:                  
    clr.w    D0
    clr.w    D1
    move.w   LIMIT, D1
    sub.w    #1, D1
    
LOOP:
    add.w    #1, D0 ; D0++
    cmp.w    D0, D1 ; D0 < D1
	  BLT ENDLOOP
	  BRA LOOP
	
ENDLOOP:	
    SIMHALT
    END    START
