/**Luis Alvarez
   CIS 356
   Assignment P001
   Due 9/15/17
**/

.data
base:
x: .asciz "0"
.set offset_of_x, x - base

//nine: .asciz "0"
//littleA: .asciz "a"
//BigA: .asciz "A"

.text

.global main

main:
    
    push {r9, lr}
    data_seg .reg r9 
    ldr data_seg, data_seg_address
    
    mov r0, x
    str r0, [data_seg, #offset_of_x]

while: 
    ldr r0, [data_seg, #offset_of_x]
    cmp r0, #10
    beq exit
    
    bl printf
    add r0, r0, #1
    str r0, [data_seg, #offset_of_x]  
    b while
    
exit:
    pop {lr}
    bx lr

//base
data_seg_address: .word base
