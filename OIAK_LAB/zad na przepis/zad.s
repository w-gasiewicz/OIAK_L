.data
x: .double 0.0
y: .double 1.0 

mask = 0b0000000000000100
.text
.global returnFPU
.type returnFPU, @function
returnFPU:


mov $0, %eax
fldl x
fldl y

fdivp 
fstsw %ax
 and $mask, %ax

ret
