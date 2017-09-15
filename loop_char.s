/*
  @file loop_char.s

  Improved to make the calculations of addresses easier to follow
  (and, hopefully, update). Also moved declaration of x before str so
  that there only need be one .align
 */
        .data
        .align 2
base:
x:      .word 0
str:    .asciz "\n%c "

        .set   offset_of_x, x - base
        .set    offset_of_str, str - base

        .text
        .global main
main:
        push    {r9, lr}
        data_seg .req r9 // set data_seg as an alias for the register r9
        ldr     data_seg, data_seg_address

        mov     r0, #65
	    str     r0, [data_seg, #offset_of_x]

while:  ldr     r0, [data_seg, #offset_of_x]
        cmp     r0, #90
        bgt     done

        // printf(str, x) - str is address of str; x is value of x
        add     r0, data_seg, #offset_of_str
        ldr     r1, [data_seg, #offset_of_x]
        bl      printf

        // x++;
        ldr     r0, [data_seg, #offset_of_x]
        add     r0, r0, #1
	str     r0, [data_seg, #offset_of_x]

        // }
        b       while

done:
        .unreq   data_seg
        pop     {r9, lr}
        bx      lr                                 /* return from main using lr */
data_seg_address:   .word base
