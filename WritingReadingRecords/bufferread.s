.include "linux.s"

.equ BUFFER_POINTER, 24
.equ ST_FILEDES, 16

.global read_from_file
.type read_from_file, @function
read_from_file:
	pushq %rbp
	movq  %rsp, %rbp
	
	movq $SYS_READ, %rax
	movq ST_FILEDES(%rbp), %rdi
	movq BUFFER_POINTER(%rbp), %rsi
	movq $972, %rdx
	syscall	
	
	movq %rbp, %rsp
	popq %rbp
	retq
