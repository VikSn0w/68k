    ORG    $8000
ARRAY   ds.w   5

    ORG    $8100
SIZE    dc.w   10

    ORG    $8200
START:
   clr D0 ;i
   clr D1 ;j
   clr D2 ;min
   clr D3 ;temp
   clr D4 ;limit1
   clr D5 ;limit2
   clr D6 ;a[min]
    
   move.w SIZE, D4
   sub.w  #4, D4
   
   move.w SIZE, D5
   sub.w  #2, D5 
   
   move.w #0, D0 ;i = 0
   
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
   
   clr D0
   
FOR1:
    move.w D0, D2 ;min = i
    move.w D0, D1 ;j = i
    add.w  #2, D1 ;j += 1

FOR2:
   move.w (A0, D2),D6 ;tmp = a[min]
   cmp.w (A0, D1),D6  ;a[j] < tmp
   BLT ELSE
   
IF:
   move.w D1, D2 ;min = j

CHECK2:
   add.w #2, D1  ;j++
   cmp.w D1, D5  ;j < limit2(5)
   BLT ENDFOR2
   BRA FOR2

ENDFOR2:
   move.w (A0, D2),D3       ;temp = a[min]
   move.w (A0, D0),(A0, D2) ;a[min] = a[i]
   move.w D3,(A0, D0)       ;a[i] = temp
   add.w #2, D0
   
   cmp.w D0, D4  ;i < limit1(4)
   BLT ENDFOR1
   BRA FOR1

ELSE:
   jmp CHECK2
   
ENDFOR1:
    SIMHALT
    END    START
