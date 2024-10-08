	.data
format: .string "n = %d\n"
	.text
	.globl main

main:
	movq $format, %rdi
	mov $42, %rsi
	mov $0, %rax
	call printf

	mov $0, %rax
	ret
