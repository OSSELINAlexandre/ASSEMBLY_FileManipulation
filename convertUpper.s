.section .data
	.equ SYS_READ,  0
	.equ SYS_WRITE, 1
	.equ SYS_OPEN,  2
	.equ SYS_CLOSE, 3	
	.equ O_RDONLY,  0
	.equ O_CREAT_WRONLY_TRUNC, 03101

.section .bss
	.equ   BUFFER_SIZE, 500
	.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text
	.equ ST_SIZE_RESERVE, 16
	.equ ST_FD_IN, -8
	.equ ST_FD_OUT, -16
	.equ ST_ARGV_1, 16
	.equ ST_ARGV_2, 24

.global _start

_start:
	mov %rsp, %rbp
	subq $ST_SIZE_RESERVE, %rsp

Open_Files:
Open_Input_File:
	movq $SYS_OPEN, %rax
	movq ST_ARGV_1(%rbp), %rdi
	movq $O_RDONLY, %rsi
	movq $0, %rdx
	syscall

Store_FileDescriptor_In:
	movq %rax, ST_FD_IN(%rbp)

Open_Output_File:
	movq $SYS_OPEN, %rax
	movq ST_ARGV_2(%rbp), %rdi
	movq $O_CREAT_WRONLY_TRUNC, %rsi
	movq $0, %rdx
	syscall

Store_FileDescriptor_Out:
	movq %rax, ST_FD_OUT(%rbp)

Reading_From_Int:
	movq $SYS_READ, %rax
	movq ST_FD_IN(%rbp), %rdi
	movq $BUFFER_DATA, %rsi
	movq $BUFFER_SIZE, %rdx
	syscall

	pushq $BUFFER_DATA
	pushq %rax
	callq Conversion_To_Upper
	

Writing_To_Out:
	movq $SYS_WRITE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	movq $BUFFER_DATA, %rsi
	movq $BUFFER_SIZE, %rdx
	syscall	
		
Close_Input_File:
	movq $SYS_CLOSE, %rax
	movq ST_FD_IN(%rbp), %rdi
	syscall

Close_Output_File:
	movq $SYS_CLOSE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	syscall
		
Exit_System:
	movq $60, %rax
	movq $69, %rdi
	syscall

			
Conversion_To_Upper:

#%rax - beginning of buffer
#%rbx - length of buffer
#%rdi - current buffer offset
#%cl  - current byte being examined (first part of %rcx)

	.equ LOWERCASE_A, 'a'
	.equ LOWERCASE_Z, 'z'
	.equ UPPER_CONVERSION, 'A' - 'a'
	
	pushq %rbp
	movq  %rsp, %rbp
	movq  24(%rbp), %rax	
	movq  16(%rbp), %rbx
	movq  $0, %rdi

conversion:
	movb (%rax,%rdi,1), %cl
	cmpb $'a' , %cl
	jl   Next_Byte
	cmpb $'z' , %cl
	jg   Next_Byte
	addb $UPPER_CONVERSION, %cl
	movb %cl, (%rax,%rdi,1)

Next_Byte:
	incq  %rdi	
	cmpq %rdi, %rbx
	jne conversion
	
end_loop:
	movq %rbp, %rsp
	popq %rbp
	retq
	
