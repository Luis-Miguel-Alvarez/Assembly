/* Luis Alvarez
 * Assignment II
 * CIS 356
 */
 
 //Inital print test worked...sorta only "abc" printed out zeros which is fine 
 //but remember print f can only take 4 peramaters so break it up to fix it.
 
 

//Program goes through nested loops to print out a truth table
 
.data
       .align 2

base:
a:     .word 0
b:     .word 0
c:     .word 0
top:   .asciz "| a | b | c | a&b&c | a|b|c | a|b&c |\n"
values: .asciz "| %d | %d | %d |   %d   |   %d   |   %d   |\n"
       .set offset_a , a - base  
       .set offset_b , b - base
       .set offset_c , c - base
       .set offset_top , top - base
       .set offset_values , values - base
       
.text
.global main

main:
       push {r9, lr}
       data_seg .req r9
       ldr data_seg, data_seg_address
       
loopA:
       ldr r1, [data_seg, #offset_a]
       cmp r1, #2
       bne loopB
       
loopB:
       ldr r2, [data_seg, #offset_b]
       cmp r2, #2
       bne loopC

loopC:
       ldr r3, [data_seg, #offset_c]
       cmp r3, #2
       bne printLoop
       
printLoop:
       add r0, data_seg, #offset_values
       bl printf
       
exit:
    .unreq data_seg
    pop {r9, lr}
    bx lr
    
data_seg_address: .word base
