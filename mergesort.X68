; Merge Sort Implementation for Motorola 68000
; Sorts an array of 32-bit integers in ascending order

        ORG     $1000

; Data section
ARRAY_SIZE      EQU     8               ; Number of elements to sort
ELEMENT_SIZE    EQU     4               ; Size of each element (32-bit)

; Test array - modify these values as needed
TEST_ARRAY:
        DC.L    64, 34, 25, 12, 22, 11, 90, 5

; Temporary array for merging (same size as original)
TEMP_ARRAY:
        DS.L    ARRAY_SIZE

; String constants for output
HEADER_MSG:     DC.B    'Merge Sort Demo',13,10,0
BEFORE_MSG:     DC.B    'Array before sorting: ',0
AFTER_MSG:      DC.B    'Array after sorting:  ',0
SPACE_MSG:      DC.B    ' ',0
NEWLINE_MSG:    DC.B    13,10,0
SORT_CALL_MSG:  DC.B    'Sorting range [',0
TO_MSG:         DC.B    ' to ',0
BRACKET_MSG:    DC.B    ']',13,10,0
MERGE_CALL_MSG: DC.B    'Merging [',0
MID_MSG:        DC.B    '] and [',0
DONE_MSG:       DC.B    'Recursion complete for range [',0
                DC.B    0               ; Pad to even boundary

; Main program entry point
START:
        ; Print header message
        LEA     HEADER_MSG,A1
        MOVE.B  #14,D0                  ; TRAP task number for string output
        TRAP    #15
        
        ; Print "before" message
        LEA     BEFORE_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        ; Print array before sorting
        LEA     TEST_ARRAY,A0
        MOVE.L  #ARRAY_SIZE,D1
        JSR     PRINT_ARRAY
        
        ; Print newline
        LEA     NEWLINE_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        ; Initialize parameters for merge_sort
        LEA     TEST_ARRAY,A0           ; A0 = pointer to array
        MOVE.L  #0,D0                   ; D0 = left index (0)
        MOVE.L  #ARRAY_SIZE-1,D1        ; D1 = right index (size-1)
        LEA     TEMP_ARRAY,A1           ; A1 = pointer to temp array
        
        ; Call merge sort
        JSR     MERGE_SORT
        
        ; Print "after" message
        LEA     AFTER_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        ; Print array after sorting
        LEA     TEST_ARRAY,A0
        MOVE.L  #ARRAY_SIZE,D1
        JSR     PRINT_ARRAY
        
        ; Print final newline
        LEA     NEWLINE_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        ; Program ends here - array is now sorted
        STOP    #$2700

;--------------------------------------------------------------------
; MERGE_SORT - Recursive merge sort function
; Parameters:
;   A0 = pointer to array
;   D0 = left index
;   D1 = right index  
;   A1 = pointer to temporary array
; Modifies: D0, D1, D2, A0, A1 (and stack for recursion)
;--------------------------------------------------------------------
MERGE_SORT:
        ; Print debug info - entering function
        MOVEM.L D0-D2/A0-A1,-(SP)       ; Save registers for debug output
        
        LEA     SORT_CALL_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Restore for getting left index
        MOVE.L  D0,D1                   ; D1 = left index for printing
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     TO_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Restore for getting right index
        MOVE.L  D1,D1                   ; D1 = right index for printing
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     BRACKET_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP)+,D0-D2/A0-A1       ; Restore registers
        
        ; Check if left < right (base case check)
        CMP.L   D0,D1
        BLE     MS_DONE                 ; If left >= right, return
        
        ; Save registers on stack
        MOVEM.L D0-D2/A0-A1,-(SP)
        
        ; Calculate middle point: mid = (left + right) / 2
        MOVE.L  D0,D2                   ; D2 = left
        ADD.L   D1,D2                   ; D2 = left + right
        LSR.L   #1,D2                   ; D2 = (left + right) / 2 = mid
        
        ; First recursive call: merge_sort(array, left, mid)
        MOVE.L  D2,D1                   ; Set right = mid for first call
        JSR     MERGE_SORT
        
        ; Restore registers for second call
        MOVEM.L (SP),D0-D2/A0-A1        ; Restore without popping
        
        ; Recalculate mid for second call
        MOVE.L  D0,D2                   ; D2 = left
        ADD.L   D1,D2                   ; D2 = left + right
        LSR.L   #1,D2                   ; D2 = mid
        
        ; Second recursive call: merge_sort(array, mid+1, right)
        MOVE.L  D2,D0                   ; D0 = mid
        ADDQ.L  #1,D0                   ; D0 = mid + 1 (new left)
        JSR     MERGE_SORT
        
        ; Restore registers for merge call
        MOVEM.L (SP)+,D0-D2/A0-A1       ; Restore and pop from stack
        
        ; Calculate mid again for merge call
        MOVE.L  D0,D2                   ; D2 = left
        ADD.L   D1,D2                   ; D2 = left + right
        LSR.L   #1,D2                   ; D2 = mid
        
        ; Print merge debug info
        MOVEM.L D0-D2/A0-A1,-(SP)       ; Save registers
        
        LEA     MERGE_CALL_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get left index
        MOVE.L  D0,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     TO_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get mid index
        MOVE.L  D2,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     MID_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get mid+1 index
        MOVE.L  D2,D1
        ADDQ.L  #1,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     TO_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get right index
        MOVE.L  D1,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     BRACKET_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP)+,D0-D2/A0-A1       ; Restore registers
        
        ; Call merge to combine the two sorted halves
        JSR     MERGE
        
MS_DONE:
        ; Print completion message
        MOVEM.L D0-D2/A0-A1,-(SP)       ; Save registers
        
        LEA     DONE_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get left index
        MOVE.L  D0,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     TO_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP),D0-D2/A0-A1        ; Get right index
        MOVE.L  D1,D1
        MOVE.B  #3,D0
        TRAP    #15
        
        LEA     BRACKET_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVEM.L (SP)+,D0-D2/A0-A1       ; Restore registers
        RTS

;--------------------------------------------------------------------
; MERGE - Merge two sorted subarrays
; Parameters:
;   A0 = pointer to array
;   D0 = left index
;   D1 = right index
;   D2 = mid index
;   A1 = pointer to temporary array
; Modifies: D0-D7, A0-A2
;--------------------------------------------------------------------
MERGE:
        MOVEM.L D0-D7/A0-A2,-(SP)       ; Save all working registers
        
        ; Initialize indices
        MOVE.L  D0,D3                   ; D3 = i = left (left array index)
        MOVE.L  D2,D4                   ; D4 = j = mid
        ADDQ.L  #1,D4                   ; D4 = j = mid + 1 (right array index)
        MOVE.L  D0,D5                   ; D5 = k = left (merged array index)
        
        ; A2 will point to current position in temp array
        MOVE.L  A1,A2                   ; A2 = temp array base
        MOVE.L  D5,D6                   ; Calculate offset
        LSL.L   #2,D6                   ; D6 = k * 4 (element size)
        ADD.L   D6,A2                   ; A2 = temp[k]
        
MERGE_LOOP:
        ; Check if left subarray is exhausted
        CMP.L   D2,D3                   ; Compare i with mid
        BGT     COPY_RIGHT              ; If i > mid, copy remaining right elements
        
        ; Check if right subarray is exhausted
        CMP.L   D1,D4                   ; Compare j with right
        BGT     COPY_LEFT               ; If j > right, copy remaining left elements
        
        ; Compare elements from both subarrays
        MOVE.L  A0,A3                   ; A3 = array base
        MOVE.L  D3,D6                   ; Calculate left element offset
        LSL.L   #2,D6                   ; D6 = i * 4
        ADD.L   D6,A3                   ; A3 = &array[i]
        MOVE.L  (A3),D6                 ; D6 = array[i]
        
        MOVE.L  A0,A3                   ; A3 = array base  
        MOVE.L  D4,D7                   ; Calculate right element offset
        LSL.L   #2,D7                   ; D7 = j * 4
        ADD.L   D7,A3                   ; A3 = &array[j]
        MOVE.L  (A3),D7                 ; D7 = array[j]
        
        ; Compare and copy smaller element
        CMP.L   D7,D6                   ; Compare array[i] with array[j]
        BLE     COPY_LEFT_ELEM          ; If array[i] <= array[j], copy left element
        
        ; Copy right element
        MOVE.L  D7,(A2)+                ; temp[k] = array[j], increment A2
        ADDQ.L  #1,D4                   ; j++
        BRA     MERGE_NEXT
        
COPY_LEFT_ELEM:
        ; Copy left element
        MOVE.L  D6,(A2)+                ; temp[k] = array[i], increment A2
        ADDQ.L  #1,D3                   ; i++
        
MERGE_NEXT:
        ADDQ.L  #1,D5                   ; k++
        BRA     MERGE_LOOP
        
COPY_LEFT:
        ; Copy remaining elements from left subarray
        CMP.L   D2,D3                   ; Check if i <= mid
        BGT     COPY_DONE
        
        MOVE.L  A0,A3                   ; A3 = array base
        MOVE.L  D3,D6                   ; Calculate offset
        LSL.L   #2,D6                   ; D6 = i * 4
        ADD.L   D6,A3                   ; A3 = &array[i]
        MOVE.L  (A3),(A2)+              ; temp[k] = array[i]
        
        ADDQ.L  #1,D3                   ; i++
        ADDQ.L  #1,D5                   ; k++
        BRA     COPY_LEFT
        
COPY_RIGHT:
        ; Copy remaining elements from right subarray
        CMP.L   D1,D4                   ; Check if j <= right
        BGT     COPY_DONE
        
        MOVE.L  A0,A3                   ; A3 = array base
        MOVE.L  D4,D6                   ; Calculate offset
        LSL.L   #2,D6                   ; D6 = j * 4
        ADD.L   D6,A3                   ; A3 = &array[j]
        MOVE.L  (A3),(A2)+              ; temp[k] = array[j]
        
        ADDQ.L  #1,D4                   ; j++
        ADDQ.L  #1,D5                   ; k++
        BRA     COPY_RIGHT
        
COPY_DONE:
        ; Copy merged elements back to original array
        MOVE.L  D0,D3                   ; D3 = i = left
        MOVE.L  A1,A2                   ; A2 = temp array base
        MOVE.L  D0,D6                   ; Calculate temp array offset
        LSL.L   #2,D6                   ; D6 = left * 4
        ADD.L   D6,A2                   ; A2 = &temp[left]
        
COPY_BACK_LOOP:
        CMP.L   D1,D3                   ; Check if i <= right
        BGT     MERGE_DONE
        
        ; Copy temp[i] back to array[i]
        MOVE.L  A0,A3                   ; A3 = array base
        MOVE.L  D3,D6                   ; Calculate array offset
        LSL.L   #2,D6                   ; D6 = i * 4
        ADD.L   D6,A3                   ; A3 = &array[i]
        MOVE.L  (A2)+,(A3)              ; array[i] = temp[i]
        
        ADDQ.L  #1,D3                   ; i++
        BRA     COPY_BACK_LOOP
        
MERGE_DONE:
        MOVEM.L (SP)+,D0-D7/A0-A2       ; Restore all registers
        RTS

;--------------------------------------------------------------------
; PRINT_ARRAY - Print array elements to console
; Parameters:
;   A0 = pointer to array
;   D1 = number of elements to print
; Modifies: D0-D2, A0-A1
;--------------------------------------------------------------------
PRINT_ARRAY:
        MOVEM.L D0-D2/A0-A1,-(SP)       ; Save registers
        
        MOVE.L  D1,D2                   ; D2 = counter (number of elements)
        SUBQ.L  #1,D2                   ; Adjust for DBRA (counts from n-1 to 0)
        
PRINT_LOOP:
        ; Get current array element
        MOVE.L  (A0)+,D1                ; D1 = current array element, advance pointer
        
        ; Print the number
        MOVE.B  #3,D0                   ; TRAP task for number output
        TRAP    #15
        
        ; Check if this is the last element
        TST.L   D2
        BEQ     PRINT_ARRAY_DONE        ; If counter is 0, don't print space
        
        ; Print space separator
        LEA     SPACE_MSG,A1
        MOVE.B  #14,D0                  ; TRAP task for string output
        TRAP    #15
        
        DBRA    D2,PRINT_LOOP           ; Decrement counter and loop
        
PRINT_ARRAY_DONE:
        MOVEM.L (SP)+,D0-D2/A0-A1       ; Restore registers
        RTS

        END     START
*~Font name~Courier New~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
