    .data
str_fmt:    .string "%s\n"
int_fmt:    .string "%d\n"
true:       .string "true"
false:      .string "false"
    .text
    .globl main

main:
    # true && false
    mov $1, %rax
    mov $1, %rcx
    and %rcx, %rax

    mov %rax, %rdi
    call print_bool

    # if 3 <> 4 then 10 * 2 else 14
    mov $3, %rax
    mov $4, %rcx
    cmp %rcx, %rax
    jz main_else

    mov $10, %rax
    mov $2, %rcx
    mul %rcx
    mov %rax, %rdi
    jmp main_finally
main_else:
    mov $14, %rdi
main_finally:
    call print_int

    # 2 = 3 || 4 <= 2 * 3
    mov $2, %rax
    cmp $3, %rax
    je first_true

    mov $2, %rbx
    imul $3, %rbx
    cmp $4, %rbx
    jge second_true

    mov $0, %rcx
    jmp end

first_true:
    mov $1, %rcx
    jmp end

second_true:
    mov $1, %rcx

end:
    mov %rcx, %rax
    call print_bool

    mov $0, %rax
    ret

print_bool:
    push %rbp
    mov %rsp, %rbp

    cmp $1, %rdi
    jnz print_bool_else

    movq $true, %rsi
    jmp print_bool_finally
print_bool_else:
    movq $false, %rsi
print_bool_finally:
    movq $str_fmt, %rdi
    mov $0, %rax
    call printf

    mov %rbp, %rsp
    pop %rbp
    ret

print_int:
    push %rbp
    mov %rsp, %rbp

    mov %rdi, %rsi
    movq $int_fmt, %rdi
    mov $0, %rax
    call printf

    mov %rbp, %rsp
    pop %rbp
    ret
