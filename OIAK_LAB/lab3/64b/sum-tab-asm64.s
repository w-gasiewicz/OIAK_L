.section .text
.globl asm_mod_array64
.type asm_mod_array64, @function
asm_mod_array64:
push %rbp                 # zabezpieczamy stary %ebp
mov %rsp, %rbp            # nowy base pointer = %esp (szczyt stosu)
mov %rdi, %rax          # wskaznik na poczatek tablicy do %eax
mov %rsi, %rcx         # rozmiar tablicy do %ecx
xor %rdi, %rdi            # zerujemy indeks biezacy w %edi
mov $0, %ebx
 
start_loop:                
cmp %rdi, %rcx             
je loop_exit               
mov (%rax,%rdi,4), %rdx   # przesylamy biezacy element tablicy do %edx 
add %rdx, %rbx              
mov %rbx, (%rax,%rdi,4)   # wstawiamy nowa wartosc
inc %rdi                  # zwiekszamy licznik
jmp start_loop             
 
loop_exit:             
mov %rbp, %rsp
pop %rbp
ret                  
