.include "linux.s"

.equ RECORD_POINTER, 16
.equ ST_FILEDESCRIPTOR, 24

.global write_to_file
.type write_to_file, @function
write_to_file:
	pushq %rbp
	movq  %rsp, %rbp
	
	movq $SYS_WRITE, %rax
	movq ST_FILEDESCRIPTOR(%rbp), %rdi
	movq RECORD_POINTER(%rbp), %rsi
	movq $324, %rdx
	syscall	
	
	movq %rbp, %rsp
	popq %rbp
	retq
