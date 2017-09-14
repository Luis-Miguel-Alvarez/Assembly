/**Luis Alvarez
   CIS 356
   Assignment P001
   Due 9/15/17
**/

.data

nine: .asciz 0
littleA: .asciz 97
BigA: .asciz 65

.text

.global main

main:
    push {lr} 
    ldr r0, #0

while: 
    cmp r0, #10
    breq exit
    bl printf
    add r0, #1 
    b while
    
exit:
    pop {lr}
    bx lr
