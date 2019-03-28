EXIT = 1
STDIN = 0
STDOUT = 1
READ = 3
WRITE = 4

.data
.comm buf_in, 80
.comm buf_out, 80

.text
.global main
main:
	movl $READ, %eax
	movl $STDIN, %ebx
	movl $buf_in, %ecx
	movl $80, %edx
	int $0x80

	movl %eax, %ebx
	dec %ebx			#liczba wczytanych znaków, potęgi 10
	xor %esi, %esi		
	xor %ecx, %ecx

wartosc:
	xor %eax, %eax
	movb buf_in(, %esi, 1), %al	#1 znak do cl
	andb $15, %al			#zamieniamy na wartość
	inc %esi	
	push %esi
		pozycja:
			cmp %esi, %ebx
			je dalej						
			
			movl $10, %edx
			mul %edx
			
			inc %esi
			jmp pozycja		
dalej:	
	pop %esi
	add %eax, %ecx		#wynik w ecx			
	cmp %esi, %ebx	
	jne wartosc

	movl %ecx, %eax
	movl $0, %ecx
	#movb $0xA, buf_out(, %ecx, 1)
	movl $79, %ecx	
petla:
	mov $2, %ebx
	xor %edx, %edx
	div %ebx
	add $'0', %dl
	mov %dl, buf_out(, %ecx, 1)
	dec %ecx
	cmp $0, %eax
	jne petla

wyjscie:
	movl $WRITE, %eax
	movl $STDOUT, %ebx
	movl $buf_out, %ecx
	movl $80, %edx
	int $0x80	

	movl $EXIT, %eax
	int $0x80
