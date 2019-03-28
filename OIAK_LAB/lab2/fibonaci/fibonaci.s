SYSCALL32 = 0x80
SYSEXIT = 1
STDIN = 0
READ = 3
STDOUT = 1
WRITE = 4
BUF_SIZE = 254
FIRTS = 1

.code32

.globl _start
.text
_start:
movl $19, %eax
pushl %eax

call fibonaci_reg
addl $4, %esp

movl $SYSEXIT, %eax
movl $0, %ebx
int $SYSCALL32


.type fibonaci @function
fibonaci:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %eax
cmpl $1, %eax
je end_fibonaci
decl %eax
pushl %eax
call fibonaci
ret_adr:
movl 8(%ebp), %ebx
mull %ebx
end_fibonaci:
movl %ebp, %esp
popl %ebp
ret

###########################################################

.type fibonaci_iter @function# deklaracja funkcjifactorial:
fibonaci_iter:
pushl %ebp# “stary” wskaźnik powiązania dynamicznego na stos 
movl %esp, %ebp# nowy wskaźnik: szczyt stosu – tu się rozpoczyna nowy
movl 8(%ebp), %ebx# parametr (z wnętrza stosu) do %eax

movl $0, %eax #pierwszy wyraz 
movl $1, %ecx #drugi wyraz i tu bd wynik

start:
add %eax, %ecx
movl %ecx, %edx
sub %eax, %edx
movl %edx, %eax
decl %ebx
cmpl $1, %ebx# warunek końca (1!=1), 1 to jednocześnie wartość pocz
je end
jg start

end: 
movl %ebp, %esp# przywrócenie wskaźnika szczytu stosu (i oczyszczenie)
popl %ebp# odtworzenie “starego” wskaźnik powiązania 
ret

###########################################################
.type fibonaci_reg @function
fibonaci_reg:
pushl %ebp 
movl %esp, %ebp
movl %eax, %ebx #przekazany parametr w ebx

movl $0, %eax #pierwszy wyraz 
movl $1, %ecx #drugi wyraz i tu bd wynik

start_reg:
add %eax, %ecx
movl %ecx, %edx
sub %eax, %edx
movl %edx, %eax
decl %ebx
cmpl $1, %ebx# warunek końca (1!=1), 1 to jednocześnie wartość pocz
je end_reg
jg start_reg

end_reg: 
movl %ebp, %esp
popl %ebp
ret
