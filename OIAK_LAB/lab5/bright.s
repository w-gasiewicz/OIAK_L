.section .text
.type bright, @function # rozjanianie obrazu
.global bright
bright:
push %rbp
mov %rsp, %rbp

mov %rdi, %rax 
mov %rdx, %rcx
mov %rsi, %rdx
xor %rdi, %rdi

mov $0x0, %r8
#movq %r8, %mm0 # za³adowanie wektora??? do rejestru MMX

petla: #error w movq
movq (%rax,%rdi,8), %r9 # za³adowanie kolejnych 8 bajtów do rejestru MMX
#paddusb %mm0, %mm1 # dodanie z nasyceniem (rozjanienie)
#pxor %mm0, %mm1
movq %r9, (%rdx,%rdi,8) # zwrot wyniku
inc %rdi # przesuwamy indeks pikseli bitmapy 
dec %rcx # zmiejszamy liczbê iteracji
cmp $0, %rcx
jnz petla # powtarzamy dopóki ecx != 0
#emms # czycimy status rejestrów MMX
mov %rbp, %rsp
pop %rbp
ret
