# Obliczenie wyrazenia z = z + x*y z uzyciem FPU 
#  
# kompilacja: gcc -m32 -nostdlib -g add-test.s -o add-test 
# obserwacja pod gdb: 
# gdb -tui add-test 
SYSEXIT=1 
EXIT_SUCCESS=0 
.att_syntax noprefix 
.data 
x: .double 2 
y: .double 3 
z: .double 4 
.text 
.globl _start 
_start: 
fldl    x 
fldl    y 
fmulp   st, st(1) 
fldl    z 
faddp   st, st (1) 
fstpl   z 
mov $SYSEXIT, %eax 
mov $EXIT_SUCCESS, %ebx 
int $0x80 
