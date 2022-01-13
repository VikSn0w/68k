	  ORG    $8000
MESSAGE dc.b 'Hello World', 0

    ORG    $8200
START:
    lea     MESSAGE, A1
    move.b  #14, D0
    trap    #15

    move.b  #9, D0
    trap    #15
    
    SIMHALT
    END START
