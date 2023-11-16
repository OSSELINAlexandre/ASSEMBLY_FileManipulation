.include "linux.s"
.include "records_definition.s"

.section .data

filename:
	.ascii "data.dat\0"

.section .bss
	
	lcomm buffer_data, 1000
	
.section .text

.global _start

_start:
	movq %rsp, %rbp
	subq  $FILEDESCRIPTOR_LOCATION, %rsp
	
open_input_file:
	movq $SYS_OPEN, %rax
	movq $filename, %rdi
	movq $O_RDONLY, %rsi
	movq $0, %rdx
	syscall
	
	movq  %rax, FILEDESCRIPTOR_LOCATION(%rbp)
	
	pushq $buffer_data
	pushq FILEDESCRIPTOR_LOCATION(%rbp)
	callq read_from_file
	
.write_output:
	movq $1, %rax
	movq $1, %rdi
	leaq $buffer, %rsi
	movq $1000, %rdx
	syscall	

close_file:
	movq $SYS_CLOSE, %rax
	movq FILEDESCRIPTOR_LOCATION(%rbp), %rdi
	syscall
	
exit_system:
	movq $60, %rax
	movq $0, %rdi
	syscall
	
