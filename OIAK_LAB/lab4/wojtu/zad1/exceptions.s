.data

zero: .int 0
number: .float 5
.text

.global div_zero, reset_fpu, status_word
.type div_zero, @function
.type status_word, @function
.type reset_fpu, @function

div_zero:
    fld number
    fdiv zero
    
    fstsw %ax
    ret

reset_fpu:
    finit
    ret

status_word:
    fstsw %ax
    ret
