/**Luis Alvarez
   CIS 356
   Assignment P001
   Due 9/15/17
**/

.data
base:
x: .word 0
str: .asciz "%c"
.set offset_of_x, x - base
.set offset_of_str, str - base

//nine: .asciz "0"
//littleA: .asciz "a"
//BigA: .asciz "A"

.text

.global main

main:
    
    push {r9, lr}
    data_seg .req r9 
    ldr data_seg, data_seg_address
    
    mov r0, #0
    str r0, [data_seg, #offset_of_x]

while: 
    ldr r0, [data_seg, #offset_of_x]
    cmp r0, #10
    beq exit
    
    
    mov r1, r0
    add r0, data_seg, #offset_of_str
    bl printf
    
    ldr r0, [data_seg, #offset_of_x]
    add r0, r0, #1
    str r0, [data_seg, #offset_of_x]  
    b while
    
exit:
    pop {lr}
    bx lr

//base
data_seg_address: .word base
