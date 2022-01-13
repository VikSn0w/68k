    ORG    $8000
ARRAY   ds.w   7

    ORG    $8100
SIZE    dc.b   14 ;numbers of elements of the array

    ORG    $8200
START:
   clr D0 ;i = 0
   clr D1 ;N Array = 0
   clr D2 ;swap = 0
   clr D3 ;foo 1
   clr D4 ;foo 2
   clr D5 ;foo 3
   
   move.b SIZE, D1
   sub.b  #4, D1
   
   lea ARRAY, A0
   
   move.w #5, (A0, D0)
   add.w  #2, D0

   move.w #1, (A0, D0)
   add.w  #2, D0

   move.w #3, (A0, D0)
   add.w  #2, D0

   move.w #4, (A0, D0)
   add.w  #2, D0

   move.w #7, (A0, D0)
   add.w  #2, D0
   
   move.w #6, (A0, D0)
   add.w  #2, D0

   move.w #2, (A0, D0)
   add.w  #2, D0       
   
   clr D0 ;i = 0
   
   move.b #1, D2 ;swap = 1 (putting 1 as "true" and 0 as "false")
   
WHILE:
    move.b #0, D2 ;swap = 0
    clr D0 ;i = 0
FOR:
    move.w (A0, D0),D3
    add.w  #2,D0
    move.w (A0, D0),D4
    
    cmp.w D3,D4  ;a[i] > a[i+1]
    BGT ELSE
IF:
    move.w D3, D5 ;temp = a[i]
    move.w D4, D3 ;a[i] = a[i+1]
    move.w D5, D4 ;a[i+1] = temp
    move.w D4, (A0, D0) 
    sub.w  #2, D0 ;i -= 1
    move.w D3, (A0, D0) 
    move.b #1, D2 ;swap = 1
ELSE:
    cmp.w D0, D1  ;i < N Array
    BLT ENDFOR
    BRA FOR
ENDFOR:    
    cmp.b #1, D2  ;if swap = 1
    BNE DONE
    BRA WHILE
    
DONE:
    SIMHALT
    END    START
