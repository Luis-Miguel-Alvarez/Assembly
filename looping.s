//Short and simple assembly programs.
//Material for studying

//Looping print

.data

.align 2 //Not entirely sure if this even needs to be here

base:
//Believe this is for setting up the loop counter.
counter: .word 1 
//%d is where the variable will be printed "d" indicates decimal
text: .asciz "This has been printed out %d times. \n" 

//Paired with last line somehow. Helps keep track of where our int and
//string are being stored.
.set offset_counter, counter - base
.set offset_text, text - base


.text
.global main

main: 

push {r9, lr}
data_seg .req r9 //set r9 to name data_seg
//put into data_seg (r9) what's in data_seg_address (base)
ldr data_seg, data_seg_address

while:
ldr r0, [data_seg, #offset_counter]

//Compare int thats in r0 with 5. if greater of equal jump to exit
cmp r0, #6
bge exit

//otherwise print out the string
//printf needs the string to be in r0 & the variable in r1
mov r1, r0
add r0, data_seg, #offset_text //why add and not ldr here??
bl printf

//we printed but all registers are messed up after call to printf so fix 'em
ldr r0, [data_seg, #offset_counter]
add r0, r0, #1
str r0, [data_seg, #offset_counter]

b while

exit:
.unreq data_seg //dont think this is really needed
pop {r9, lr}
bx lr


//I think this is paired with the .set and offsets above.
data_seg_address: .word base



