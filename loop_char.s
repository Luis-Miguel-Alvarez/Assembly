/*Luis Alvarez
CIS 356
Assignment p001
Due: 9/15/17
Program uses loops and segment jumps to print out the digits followed
followed by the upper and lower case alpabet. Memory is used to store 
values needed to maintain proper loop flow and printing of chars*/

//data segment sets up space and adrress tracking for the three variables 
.data
        .align 2
base:
x:      .word 0
comp:   .word 0
str:    .asciz "%c "
        .set   offset_of_x, x - base
        .set   offset_of_str, str - base
        .set   offset_of_comp, comp - base
        
        .text
        .global main
main:
        push    {r9, lr}
        data_seg .req r9 // set data_seg as an alias for the register r9
        ldr     data_seg, data_seg_address
        b setNum

//while loop uses the starting and ending variables to control loop flow
//loads and stores before and after branches ensure that everything is kept track of
while:  ldr     r0, [data_seg, #offset_of_x]
        ldr     r1, [data_seg, #offset_of_comp]
        cmp     r0, r1
        bge     setLoop

        // printf(str, x) - str is address of str; x is value of x
        add     r0, data_seg, #offset_of_str
        ldr     r1, [data_seg, #offset_of_x]
        bl      printf

        ldr     r0, [data_seg, #offset_of_x]
        add     r0, r0, #1
	    str     r0, [data_seg, #offset_of_x]

        b       while

//Roundabout way of moving on to next set of chars to print without redundancy of while loop
setLoop:
        cmp r1, #58
        beq setUpper
        cmp r1, #91 
        beq setLower
        cmp r1, #123
        beq done

//following labels move the while loop onto the next set of chars to print
setNum:
        add r0, data_seg, #offset_of_str
        mov r1, #10
        bl printf
        mov r0, #48
        str r0, [data_seg, #offset_of_x]
        mov r1, #58
        str r1, [data_seg, #offset_of_comp]
        b while    
        
setUpper:
        add r0, data_seg, #offset_of_str
        mov r1, #10
        bl printf
        mov r0, #65
        str r0, [data_seg, #offset_of_x]
        mov r0, #91
        str r0, [data_seg, #offset_of_comp]
        b while 
        
setLower:
        add r0, data_seg, #offset_of_str
        mov r1, #10
        bl printf
        mov r0, #97
        str r0, [data_seg, #offset_of_x]
        mov r0, #123
        str r0, [data_seg, #offset_of_comp]
        b while 
        
done:
        .unreq   data_seg
        pop     {r9, lr}
        bx      lr  /* return from main using lr */
data_seg_address:   .word base
