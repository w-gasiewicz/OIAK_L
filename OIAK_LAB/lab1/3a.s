#przekonwertowanie liczby 10 na 16
SYSCALL32 = 0x80
EXIT = 1
STDIN = 0
STDOUT = 1
READ = 3
WRITE = 4
BUF_SIZE = 80
START_DIGIT = 0x30

.data
.comm BUF, 80 #deklaracja bufora wejscia
.comm BUF_OUT, 80 #bufor wyjscia

.text
tekst: .ascii "Wprowadz liczbe w sys. dziesietnym: \n"
tekst_len = .-tekst
tekst2: .ascii "Szesnastkowo: "
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

#odczyt z ascii na liczbe  w rejestrze
movl %eax, %edi
sub $2, %edi
movl $1, %edi
movl $0, %r8d
jmp loop

loop:
cmp $0, %edi
jl toAscii
movl $0, %eax
mov BUF(,%edi,1), %al
sub $START_DIGIT, %al

mul %edi
add %eax, %r8d

movl %edi, %eax
movl $10, %ebx
mul %ebx
movl %eax, %esi
dec %edi
jmp loop

toAscii:
movl %r8d, %eax
movl $16, %ebx
movl $0, %ecx
jmp convertLoop

convertLoop:
movl $0, %edx
div %ebx
add $START_DIGIT, %edx
mov %dl, BUF_OUT(,%ecx,1)

#dec %eax
inc  %ecx
cmp $0, %eax
jne convertLoop

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
movl $BUF_SIZE, %edx
int $SYSCALL32

movl $EXIT, %eax
int $SYSCALL32
