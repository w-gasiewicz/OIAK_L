# Funkcja pobiera kolejne elementy tablicy asm_mod_array
# dodaje do kazdego elementu 1
# Znaczenie rejestrow:
#
# %edi - indeks kolejnego elementu tablicy: 0,1,2,...,4
# %ecx - ilesc elementow tablicy
# %eax - wskaznik na poczatek tablicy
# %edx - pamiec tymczasowa
#
.section .text
.globl asm_mod_array
.type asm_mod_array, @function
asm_mod_array:
pushl %ebp                 # zabezpieczamy stary %ebp
movl %esp, %ebp            # nowy base pointer = %esp (szczyt stosu)
movl 8(%ebp),%eax          # pierwszy par. - wskaznik na poczatek tablicy do %eax
movl 12(%ebp),%ecx         # rozmiar tablicy do %ecx
xorl %edi, %edi            # zerujemy indeks biezacy w %edi
movl $0, %ebx
 
start_loop:                # start petli
cmpl %edi, %ecx            # czy koniec tablicy 
je loop_exit               # skok do koniec 
movl (%eax,%edi,4), %edx   # przesylamy biezacy element tablicy do %edx 
addl %edx, %ebx              # dodaj do elementu 1 
movl %ebx, (%eax,%edi,4)   # overwrite old element with new value
incl %edi                  # increment the index, moving through the array.
jmp start_loop             # jump to loop beginning
 
loop_exit:                 # function epilogue
movl %ebp, %esp
popl %ebp
ret                        # pop the return address and jmp to it
