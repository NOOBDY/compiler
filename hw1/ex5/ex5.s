    .data
fmt: .string "%d\n"
    .text
    .globl main

main:
    # print (let x = 3 in x * x)
    push %rbp
    mov %rsp, %rbp
    sub $8, %rsp

    movl $3, -8(%rbp)
    mov -8(%rbp), %rax
    imul %rax, %rax

    mov %rax, %rdi
    call print_int

    mov %rbp, %rsp
    pop %rbp

    # print (let x = 3 in (let y = x + x in x * y) + (let z = x + 3 in z / z))
    push %rbp
    mov %rsp, %rbp
    sub $24, %rsp

    # x = 3
    movl $3, -8(%rbp)

    # y = x + x
    mov -8(%rbp), %rax
    add %rax, %rax
    mov %rax, -16(%rbp)

    # z = x + 3
    mov -8(%rbp), %rax
    add $3, %rax
    mov %rax, -24(%rbp)

    # x * y
    mov -8(%rbp), %rdi
    mov -16(%rbp), %rax
    imul %rax, %rdi

    # z / z
    mov -24(%rbp), %rax
    idiv %rax, %rax

    add %rax, %rdi

    call print_int

    mov %rbp, %rsp
    pop %rbp

    mov $0, %rax
    ret

print_int:
    push %rbp
    mov %rsp, %rbp

    mov %rdi, %rsi
    movq $fmt, %rdi
    mov $0, %rax
    call printf

    mov %rbp, %rsp
    pop %rbp
    ret
