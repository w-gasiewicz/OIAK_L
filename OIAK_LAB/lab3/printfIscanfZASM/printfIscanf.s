.bss
.comm int_x, 4

.text
text_string: .ascii "Numer to : %s \n\0"
scanf_format: .ascii "%s"

.global main
main:
push $int_x
push $scanf_format
call scanf
add $8, %esp

#push $int_x
push $20
push $text_string
call printf
add $8, %esp

call exit

