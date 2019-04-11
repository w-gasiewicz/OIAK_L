.text 
.globl rdtsc 
rdtsc: 
push %rbx 
xor %rax, %rax 
      cpuid 
rdtsc 
pop %rbx 
ret 
