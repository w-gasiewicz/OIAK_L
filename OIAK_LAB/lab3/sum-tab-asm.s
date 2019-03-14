.section .text
.globl asm_mod_array
.type asm_mod_array, @function
asm_mod_array:
pushl %ebp                 # zabezpieczamy stary %ebp
movl %esp, %ebp            # nowy base pointer = %esp (szczyt stosu)
movl 8(%ebp),%eax          # wskaznik na poczatek tablicy do %eax
movl 12(%ebp),%ecx         # rozmiar tablicy do %ecx
xorl %edi, %edi            # zerujemy indeks biezacy w %edi
movl $0, %ebx
 
start_loop:                
cmpl %edi, %ecx             
je loop_exit               
movl (%eax,%edi,4), %edx   # przesylamy biezacy element tablicy do %edx 
addl %edx, %ebx              
movl %ebx, (%eax,%edi,4)   # wstawiamy nowa wartosc
incl %edi                  # zwiekszamy licznik
jmp start_loop             
 
loop_exit:             
movl %ebp, %esp
popl %ebp
ret                  
