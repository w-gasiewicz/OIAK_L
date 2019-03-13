.section .text
.type dark, @function # rozjasnianie obrazu
.global dark
dark:
push %rbp
mov %rsp, %rbp

mov %rdi, %rax #wskaznik na tablice pixeli obrazu 
mov %rdx, %rcx #ilosc iteracji
mov %rsi, %rdx #wskaznik na wyjsciowa tablice
xor %rdi, %rdi

movq $0x7f7f7f7f7f7f7f7f, %r8 #maska do przyciemniania
movq %r8, %mm0 

petla: 
movq (%rax,%rdi,8), %mm1 # zaadowanie kolejnych 8 bajtów do rejestru MMX
psubusb %mm0, %mm1 #odejmowanie z nasyceniem (przyciemnienie)
movq %mm1, (%rdx,%rdi,8) # zwrot wyniku
inc %rdi # przesuwamy indeks pikseli bitmapy 
dec %rcx # zmiejszamy liczbê iteracji
cmp $0, %rcx
jnz petla # powtarzamy dopóki ecx != 0

emms # czycimy status rejestrów MMX

mov %rbp, %rsp
pop %rbp
ret
