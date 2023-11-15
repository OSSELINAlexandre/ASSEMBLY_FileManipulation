.include "linux.s"

.equ ST_WRITE_BUFFER, 16
.equ ST_FILEDES, 24

.global write_to_file
.type write_to_file, @function
write_to_file:
	pushq %rbp
	movq  %rsp, %rbp
	
	movq $SYS_WRITE, %rax
	movq ST_FILEDES(%rbp), %rdi
	movq ST_WRITE_BUFFER(%rbp), %rsi
	movq $324, %rdx
	syscall	
	
	movq %rbp, %rsp
	popq %rbp
	ret
