.data

control_word: .short 0

.text

.global status_word, increase_precision, decrease_precision, get_control_word
.type increase_precision, @function
.type get_control_word, @function

increase_precision:
    fstcw control_word
    orw  $0b0000001000000000, control_word         # set double precision
    andw $0b1111111011111111, control_word
    fldcw control_word
    ret

decrease_precision: 
    fstcw control_word
    andw $0b1111110011111111, control_word         # set single precision
    fldcw control_word
    ret


