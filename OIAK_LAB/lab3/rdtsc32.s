.text 
.globl rdtsc 
rdtsc: 
push %ebx 
xor %eax, %eax 
      cpuid 
rdtsc 
pop %ebx 
ret 
