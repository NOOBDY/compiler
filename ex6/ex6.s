	.text
	.file	"ex6.c"
	.globl	isqrt                           # -- Begin function isqrt
	.p2align	4, 0x90
	.type	isqrt,@function
isqrt:                                  # @isqrt
	.cfi_startproc
# %bb.0:
	xorl	%eax, %eax
	testl	%edi, %edi
	jle	.LBB0_3
# %bb.1:
	movl	$1, %ecx
	movl	$2, %edx
	.p2align	4, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	incl	%eax
	addl	%edx, %ecx
	incl	%ecx
	addl	$2, %edx
	cmpl	%edi, %ecx
	jle	.LBB0_2
.LBB0_3:
	retq
.Lfunc_end0:
	.size	isqrt, .Lfunc_end0-isqrt
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	leaq	.L.str(%rip), %rbx
	xorl	%ebp, %ebp
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_4:                                #   in Loop: Header=BB1_1 Depth=1
	movq	%rbx, %rdi
	movl	%ebp, %esi
	xorl	%eax, %eax
	callq	printf@PLT
	incl	%ebp
	cmpl	$21, %ebp
	je	.LBB1_5
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
	movl	$0, %edx
	testl	%ebp, %ebp
	je	.LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	xorl	%edx, %edx
	movl	$1, %eax
	movl	$2, %ecx
	.p2align	4, 0x90
.LBB1_3:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	incl	%edx
	addl	%ecx, %eax
	incl	%eax
	addl	$2, %ecx
	cmpl	%ebp, %eax
	jle	.LBB1_3
	jmp	.LBB1_4
.LBB1_5:
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"sqrt(%2d) = %2d\n"
	.size	.L.str, 17

	.ident	"clang version 18.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
