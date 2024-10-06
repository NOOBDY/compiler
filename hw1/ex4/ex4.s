    .data
fmt: .string "%d\n"
x: .long 0
y: .long 0
    .text
    .globl main

main:
    movl $2, x(%rip)
    mov x(%rip), %rax
    imul %rax, %rax
    mov %rax, y(%rip)

    mov x(%rip), %rcx
    mov y(%rip), %rax
    add %rcx, %rax
    mov %rax, %rdi
    call print_int

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
