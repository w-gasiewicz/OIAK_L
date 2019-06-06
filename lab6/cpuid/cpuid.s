.data

.text

.global cpuid
.type cpuid, @function

cpuid:	
	push %ebp
	mov %esp, %ebp
	mov 8(%ebp), %edi
	mov $1, %eax	

wersja:
	cmp $2, %edi
	je rdzenie
	

	cmp $3, %edi
	je rozsz

	
	cmp $4, %edi
	je wyposazenie_p
	
	cpuid #model, rodzina, typ 158 str
	push %eax
	jmp wyjscie

rdzenie: #
	cpuid
	mov %ebx, %eax
	push %eax
	jmp wyjscie

rozsz: #context id, thermal monitor 160str
	cpuid
	mov %ecx, %eax
	push %eax
	jmp wyjscie

wyposazenie_p: #np fpu de 162 str dok.
	cpuid
	mov %edx, %eax
	push %eax
	jmp wyjscie

wyjscie:	
	mov %ebp, %esp
	pop %ebp
	ret
