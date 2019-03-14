mask = 0x2f2f2f2f2f2f2f2f
.section .text
.type bright, @function # rozjasnianie obrazu
.global bright
bright:
push %rbp
mov %rsp, %rbp

mov %rdi, %rax #wskaznik na tablice pixeli obrazu 
mov %rdx, %rcx #ilosc iteracji
mov %rsi, %rdx #wskaznik na wyjsciowa tablice
xor %rdi, %rdi

movq $mask, %r8 #maska do rozjasnienia
movq %r8, %mm0 

petla: 
movq (%rax,%rdi,8), %mm1 # zaadowanie kolejnych 8 bajtów do rejestru MMX
paddusb %mm0, %mm1 # dodanie z nasyceniem (rozjanienie)
movq %mm1, (%rdx,%rdi,8) # zwrot wyniku
inc %rdi # przesuwamy indeks pikseli bitmapy 
dec %rcx # zmiejszamy liczbê iteracji
cmp $0, %rcx
jnz petla # powtarzamy dopóki ecx != 0

emms # czycimy status rejestrów MMX

mov %rbp, %rsp
pop %rbp
ret
