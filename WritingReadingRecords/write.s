.include "linux.s"
.include "records_definition.s"
.include "records_to_print.s"

.section .text
.global _start

_start:
	pushq %rbp
	movq  %rsp, %rbp
	subq  $FILEDESCRIPTOR_LOCATION, %rsp
	
create_or_open_file:
	movq $SYS_OPEN, %rax
	movq $filename, %rdi
	movq $0101, %rsi
	movq $0666, %rdx
	syscall
	
	movq  %rax, FILEDESCRIPTOR_LOCATION(%rbp)
	
	pushq FILEDESCRIPTOR_LOCATION(%rbp)
	pushq $record1
	callq write_to_file
	
	pushq FILEDESCRIPTOR_LOCATION(%rbp)
	pushq $record2
	callq write_to_file
	
	pushq FILEDESCRIPTOR_LOCATION(%rbp)
	pushq $record3
	callq write_to_file
	
close_file:
	movq $SYS_CLOSE, %rax
	movq FILEDESCRIPTOR_LOCATION(%rbp), %rdi
	syscall

exit_system:
	movq $60, %rax
	movq $0, %rdi
	syscall
