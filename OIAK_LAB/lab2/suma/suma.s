SYSCALL32 = 0x80
SYSEXIT = 1
STDIN = 0
READ = 3
STDOUT = 1
WRITE = 4
BUF_SIZE = 254

.globl main
.text
main:
movl $4, %eax
movl $6, %ebx
#pushl %eax

call sum
#addl $4, %esp

movl $SYSEXIT, %eax
movl $0, %ebx
int $SYSCALL32

.type sum @function
sum:
pushl %ebp 
movl %esp, %ebp

#movl %eax, %ebx
#movl %ecx, %edx

start_reg:
add %ebx, %eax

end_sum: 
movl %ebp, %esp
popl %ebp
ret
