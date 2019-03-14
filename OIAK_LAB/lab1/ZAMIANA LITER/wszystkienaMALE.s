#zamiana na duze litery
SYSCALL32 = 0x80
EXIT = 1
STDIN = 0
STDOUT = 1
READ = 3
WRITE = 4
BUF_SIZE = 80

.data
.comm BUF, 80 #deklaracja bufora wejscia
.comm BUF_OUT, 80 #bufor wyjscia

.text
tekst: .ascii "Wprowadz ciag liter: \n"
tekst_len = .-tekst
tekst2: .ascii "Zamiana na duze litery: "
tekst2_len = .-tekst2

.globl _start
_start:
#wyswietlenie zmiennej tekst na konsoli
movl $WRITE, %eax
movl $STDOUT, %ebx
movl $tekst, %ecx
movl $tekst_len, %edx
int $SYSCALL32

movl $READ, %eax #odczyt lancucha z wejscia standardowego
movl $STDIN, %ebx
movl $BUF, %ecx
movl $BUF_SIZE, %edx
int $SYSCALL32 #w eax liczba wczytanych znakow

mov %eax, %esi

out:
movl $WRITE, %eax
movl $STDOUT, %ebx
movl $tekst2, %ecx
movl $tekst2_len, %edx
int $SYSCALL32

dec %esi
xor %ebx, %ebx
jmp loop

loop:
movb BUF(,%ebx,1), %al
xor $0x20, %al
movb %al, BUF_OUT(,%ebx,1)
inc %ebx
cmp %esi, %ebx
jl loop

movl $WRITE, %eax #wyswietlenie zawartosci bufora
movl $STDOUT, %ebx
movl $BUF_OUT, %ecx
movl $BUF_SIZE, %edx
int $SYSCALL32

exit:
movl $EXIT, %eax
int $SYSCALL32
