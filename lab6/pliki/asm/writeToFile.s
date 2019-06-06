# Otwieranie pliku:
#   - eax -> kod funkcji (5)
#   - ebx -> char * (nazwa pliku)
#   - ecx -> tryb dostępu
#   - edx -> kod dostępu (maska ósemkowa)

# Tryby dostępu (kod bitowy w postaci ósemkowej):
#       - 00 -> read only
#       - 01 -> write only
#       - 02 -> read-write
#       - 0100 -> utworzenie przy otwarciu nieistniejącego pliku
#       - 01000 -> trunc
#       - 02000 -> append

# Zapisywanie do pliku:
#   - eax -> kod funkcji (4)
#   - ebx -> numer pliku
#   - ecx -> adres bufora
#   - edx -> rozmiar bufora

# Zamykanie pliku:
#   - eax -> kod funkcji(6)
#   - ebx -> deskryptor pliku

SYSCALL32 = 0x80
WRITE = 4
OPEN = 5
CLOSE = 6
ALL_ACCESS = 0666
CREATE_WRITE_APP = 02101
.global writeToFile
.type writeToFile, @function
writeToFile:
pushl %ebp
movl %esp, %ebp
pushl %ebx

# Otwarcie pliku
movl $OPEN, %eax
movl 8(%ebp), %ebx
movl $CREATE_WRITE_APP, %ecx
movl $ALL_ACCESS, %edx
int $SYSCALL32

pushl %eax  # Zapisanie deskryptora pliku

# Zapisywanie
movl %eax, %ebx
movl $WRITE, %eax
movl 12(%ebp), %ecx
movl 16(%ebp), %edx
int $SYSCALL32

popl %ebx   # Zdjęcie deskryptora pliku ze stosu
pushl %eax  # Zapis wartości zwróconej z sys_write

# Zamknięcie pliku
movl $CLOSE, %eax
int $SYSCALL32

popl %eax 
popl %ebx
leave 
ret
