SYSCALL32 = 0x80
SYSEXIT = 1
STDIN = 0
READ = 3
STDOUT = 1
WRITE = 4
BUF_SIZE = 254

.code32

.globl _start
.text
_start:
movl $4, %eax
pushl %eax

call factorial_reg
addl $4, %esp

movl $SYSEXIT, %eax
movl $0, %ebx
int $SYSCALL32


.type factorial @function
factorial:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %eax
cmpl $1, %eax
je end_factorial
decl %eax
pushl %eax
call factorial
ret_adr:
movl 8(%ebp), %ebx
mull %ebx
end_factorial:
movl %ebp, %esp
popl %ebp
ret

###########################################################

.type factorial_iter @function# deklaracja funkcjifactorial:
factorial_iter:
pushl %ebp# “stary” wskaźnik powiązania dynamicznego na stos 
movl %esp, %ebp# nowy wskaźnik: szczyt stosu – tu się rozpoczyna nowy
movl 8(%ebp), %ebx# parametr (z wnętrza stosu) do %eax
movl $1, %eax
start:
mull %ebx# kolejne obliczenie (ew. imull %ebx, %eax)
decl %ebx
cmpl $1, %ebx# warunek końca (1!=1), 1 to jednocześnie wartość pocz
je end
jg start
end: 
movl %ebp, %esp# przywrócenie wskaźnika szczytu stosu (i oczyszczenie)
popl %ebp# odtworzenie “starego” wskaźnik powiązania 
ret

###########################################################
.type factorial_reg @function
factorial_reg:
pushl %ebp 
movl %esp, %ebp
movl %eax, %ebx
movl $1, %eax
start_reg:
mull %ebx
decl %ebx
cmpl $1, %ebx
je end_reg
jg start_reg
end_reg: 
movl %ebp, %esp
popl %ebp
ret
