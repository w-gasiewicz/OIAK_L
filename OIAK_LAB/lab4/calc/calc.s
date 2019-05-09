.section .text
 
.globl suma
suma:
# prolog - nowa ramka stosu
push %ebp
movl %esp, %ebp
# laduj a do st(0)
fldl 8(%ebp)
#laduj b do st(0), w st(1) jest a
fldl 16(%ebp)
# dodaj st(0) + st(1) -> st(0)
faddp
# wynik w st(0)
# przywracamy stos
mov %ebp, %esp
pop %ebp
# powrot
ret
 
.globl roznica
roznica:
push %ebp
movl %esp, %ebp
fldl 16(%ebp)
fldl 8(%ebp)
fsubp
mov %ebp, %esp
pop %ebp
ret
 
.globl mnozenie
mnozenie:
push %ebp
movl %esp, %ebp
fldl 16(%ebp)
fldl 8(%ebp)
fmulp
mov %ebp, %esp
pop %ebp
ret
 
.globl dzielenie
dzielenie:
push %ebp
movl %esp, %ebp
fldl 16(%ebp)
fldl 8(%ebp)
fdivp
mov %ebp, %esp
pop %ebp
ret
 
.globl pierwiastek
pierwiastek:
push %ebp
movl %esp, %ebp
fldl 8(%ebp)
fsqrt
mov %ebp, %esp
pop %ebp
ret
 
.globl sinus
sinus:
push %ebp
movl %esp, %ebp
fldl 8(%ebp)
fsin
mov %ebp, %esp
pop %ebp
ret

.global reset_fpu, status_word
.type status_word, @function
.type reset_fpu, @function

reset_fpu:
    finit
    ret

status_word:
    fstsw %ax
    ret

.globl heron
heron:
fldl 8(%ebp) #liczba do spierwiastkowania

ret
