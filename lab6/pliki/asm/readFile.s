# Otwieranie pliku:
#   - eax -> kod funkcji (5)
#   - ebx -> char * (nazwa pliku)
#   - ecx -> tryb dostępu
#   - edx -> kod dostępu (maska ósemkowa)

#   Tryby dostępu (kod bitowy w postaci ósemkowej):
#       - 00 -> read only
#       - 01 -> write only
#       - 02 -> read-write
#       - 0100 -> utworzenie przy otwarciu nieistniejącego pliku
#       - 01000 -> trunc
#       - 02000 -> append

# Wczytywanie z pliku:
#   - eax -> kod funkcji (3)
#   - ebx -> numer pliku uzyskany z sys_open
#   - ecx -> adres bufora, do którego nastąpi wczytanie bajtów
#   - edx -> rozmiar bufora

# Zamykanie pliku:
#   - eax -> kod funkcji(6)
#   - ebx -> deskryptor pliku

SYSCALL32 = 0x80
READ = 3
OPEN = 5
CLOSE = 6
READ_ACESS = 0444
READ_ONLY = 00
.global readFile
.type readFile, @function
readFile:

pushl %ebp
movl %esp, %ebp
pushl %ebx
# Argumenty funkcji:
#   - nazwa pliku
#   - adres bufora, do którego wczytujemy plik
#   - rozmiar bufora

# Otwarcie pliku
movl $OPEN, %eax
movl 8(%ebp), %ebx
movl $READ_ONLY, %ecx
movl $READ_ACESS, %edx
int $SYSCALL32

pushl %eax  # Zapisanie deskryptora pliku

# Wczytywanie
movl %eax, %ebx
movl $READ, %eax
movl 12(%ebp), %ecx
movl 16(%ebp), %edx
int $SYSCALL32

popl %ebx   # Zdjęcie deskryptora pliku ze stosu
pushl %eax  # Zapisanie liczby wczytanych bajtów

# Zamknięcie pliku
movl $CLOSE, %eax
int $SYSCALL32

popl %eax 
popl %ebx

leave 
ret
