/**Luis Alvarez
   CIS 356
   Assignment P001
   Due 9/15/17
**/

.data
.align 2
base:
x: .word 0
str: .asciz "A number %d"
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
    cmp r0, #99
    ble exit
    
    add r0, data_seg, #offset_of_str
    ldr r1, [data_seg, #offset_of_x]
    bl printf
    
    ldr r0, [data_seg, #offset_of_x]
    add r0, r0, #1
    str r0, [data_seg, #offset_of_x]  
    b while
    
exit:
    .unreq data_seg
    pop {r9, lr}
    bx lr

//base
data_seg_address: .word base
