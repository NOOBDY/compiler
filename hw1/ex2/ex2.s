    .data
format: .string "%d\n"
    .text
    .globl main

main:
    # 4 + 6
    mov $4, %rsi
    add $6, %rsi

    movq $format, %rdi
    mov $0, %rax
    call printf

    # 21 * 2
    mov $21, %rax
    mov $2, %rcx
    mul %rcx
    mov %rax, %rsi

    movq $format, %rdi
    mov $0, %rax
    call printf

    # 4 + 7 / 2
    mov $7, %rax
    mov $2, %rcx
    div %rcx
    add $4, %rax
    mov %rax, %rsi

    movq $format, %rdi
    mov $0, %rax
    call printf

    # 3 - 6 * (10 / 5)
    mov $10, %rax
    mov $5, %rcx
    div %rcx
    mov $6, %rcx
    mul %rcx
    mov $3, %rcx
    sub %rax, %rcx
    mov %rcx, %rsi

    movq $format, %rdi
    mov $0, %rax
    call printf

    mov $0, %rax
    ret
