#szyfr xorem
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
tekst2: .ascii "Zakodowana xorem wiadomosc: "
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

dec %eax
xor %ecx, %ecx

szyfr:
mov BUF(,%ecx,1), %r9d
xor $1, %r9d
mov %r9d, BUF_OUT(,%ecx,1)
inc %r12d
inc %ecx
cmp %r12d, %eax
jg szyfr

#ponizej wyswietlenie tekstu2 i zaszyfrowanej wiadomosci
out:
movl $WRITE, %eax
movl $STDOUT, %ebx
movl $tekst2, %ecx
movl $tekst2_len, %edx
int $SYSCALL32

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $BUF_OUT, %ecx
movl %r12d, %edx
int $SYSCALL32

movl $EXIT, %eax
int $SYSCALL32
