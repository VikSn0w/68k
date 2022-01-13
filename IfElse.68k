/--------------- If-Else condition A > B ----------------/
	ORG    $8000
A       dc.w   10
B       dc.w   20

LIMIT   dc.w   9  

    ORG    $8200
START:
    clr.w    D0
    clr.w    D1
    
	move.w   A, D0 ;copy A in D0
  move.w   B, D1 ;copy B in D1
    
	cmp.w    D0, D1 ;
  BGT ELSE        ;BGT - branch greater than
IF:
    move.w  D0, D3
    jmp ENDIF
    
ELSE:    
    move.w  D1, D3
    
ENDIF:
    SIMHALT             
    END    START    
