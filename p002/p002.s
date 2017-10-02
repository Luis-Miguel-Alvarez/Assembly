/* Luis Alvarez
 * Assignment II
 * CIS 356
 */
 

//Program goes through nested loops to print out a truth table
 
 //Data segment sets up storage of strings and variables for neat printing
.data
       .align 2
base:
a:     .word 0
b:     .word 0
c:     .word 0
top:   .asciz "| a | b | c | a&b&c | a|b|c | a|b&c |\n"
//Row broken up into two so we work in our contraint of 4 parameters for printf
values: .asciz "| %d | %d | %d "
results: .asciz "|   %d   |   %d   |   %d   |\n"
       .set offset_a , a - base  
       .set offset_b , b - base
       .set offset_c , c - base
       .set offset_top , top - base
       .set offset_values , values - base
       .set offset_results , results - base
       
.text
.global main

//Main prints out top of table for labeling
main:
       push {r9, lr}
       data_seg .req r9
       ldr data_seg, data_seg_address
       add r0, data_seg, #offset_top
       bl printf
 
//Loops call and return to each other for incrementing each variable at
//the right instances
loopA:
       ldr r1, [data_seg, #offset_a]
       cmp r1, #2
       beq exit
       
       bl loopB
       
       add r1, r1, #1
       str r1, [data_seg, #offset_a]
       mov r2, #0
       str r2, [data_seg, #offset_b]
       mov r3, #0
       str r3, [data_seg, #offset_c]
       
       b loopA

       
loopB:
       ldr r2, [data_seg, #offset_b]
       cmp r2, #2
       bxeq lr 
       
       bl loopC
      
       add r2, r2, #1
       str r2, [data_seg, #offset_b]
       mov r3, #0
       str r3, [data_seg, #offset_c]
       cmp r2, #2
       beq loopA
       b loopB


loopC:
       ldr r3, [data_seg, #offset_c]
       cmp r3, #2
       bxeq lr
      
       //load our variables after each printf to insure proper order
       add r0, data_seg, #offset_values
       bl printf
       ldr r1, [data_seg, #offset_a]
       ldr r2, [data_seg, #offset_b]
       ldr r3, [data_seg, #offset_c]
       
       bl truth
       
       
       mov r1, r4
       mov r2, r5
       mov r3, r6
       add r0, data_seg, #offset_results
       bl printf
       ldr r1, [data_seg, #offset_a]
       ldr r2, [data_seg, #offset_b]
       ldr r3, [data_seg, #offset_c]
       
       
       add r3, r3, #1
       str r3, [data_seg, #offset_c]
       cmp r3, #2
       beq loopB
       b loopC
       
truth:
       //mov r1, #0
       //mov r2, #0
       //mov r3, #0
       and r4, r1, r2
       and r4, r4, r3
       
       orr r5, r1, r2
       orr r5, r5, r3
       
       orr r6, r1, r2
       and r6, r6, r3
       
       bx lr
       
    
exit:
    .unreq data_seg
    pop {r9, lr}
    bx lr
    
data_seg_address: .word base
