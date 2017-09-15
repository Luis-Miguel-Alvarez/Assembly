/*
  
 */
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
        //b setLower


while:  ldr     r0, [data_seg, #offset_of_x]
        ldr     r1, [data_seg, #offset_of_comp]
        cmp     r0, r1
        
        ble done

        // printf(str, x) - str is address of str; x is value of x
        add     r0, data_seg, #offset_of_str
        ldr     r1, [data_seg, #offset_of_x]
        bl      printf

        ldr     r0, [data_seg, #offset_of_x]
        add     r0, r0, #1
	    str     r0, [data_seg, #offset_of_x]

        b       while
        
setNum:
        add r0, data_seg, #offset_of_str
        mov r1, #10
        bl printf
        mov r0, #48
        str r0, [data_seg, #offset_of_x]
        mov r1, #57
        str r1, [data_seg, #offset_of_comp]
        b while    
        
/*setLower:
        add r0, data_seg, #offset_of_str
        mov r1, #10
        bl printf
        str r1, [data_seg, #offset_of_comp]
        mov r0, #48
        str r0, [data_seg, #offset_of_x]
        b while 
*/

done:
        .unreq   data_seg
        pop     {r9, lr}
        bx      lr                                 /* return from main using lr */
data_seg_address:   .word base
