	.text
	.file	"matrix.c"
	.globl	f                               # -- Begin function f
	.p2align	4, 0x90
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$15, -8(%rbp)
	jne	.LBB0_2
# %bb.1:
	movl	$0, -4(%rbp)
	jmp	.LBB0_13
.LBB0_2:
	movl	-12(%rbp), %eax
	shll	$4, %eax
	orl	-8(%rbp), %eax
	movl	%eax, -16(%rbp)
	movslq	-16(%rbp), %rcx
	leaq	memo(%rip), %rax
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.LBB0_4
# %bb.3:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_13
.LBB0_4:
	movl	$0, -24(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -28(%rbp)
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	cmpl	$15, -28(%rbp)
	jge	.LBB0_12
# %bb.6:                                #   in Loop: Header=BB0_5 Depth=1
	movl	-28(%rbp), %ecx
	movl	$1, %eax
                                        # kill: def $cl killed $ecx
	shll	%cl, %eax
	movl	%eax, -32(%rbp)
	movl	-12(%rbp), %eax
	andl	-32(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB0_8
# %bb.7:                                #   in Loop: Header=BB0_5 Depth=1
	jmp	.LBB0_11
.LBB0_8:                                #   in Loop: Header=BB0_5 Depth=1
	movslq	-8(%rbp), %rcx
	leaq	m(%rip), %rax
	imulq	$60, %rcx, %rcx
	addq	%rcx, %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movl	-8(%rbp), %edi
	addl	$1, %edi
	movl	-12(%rbp), %esi
	subl	-32(%rbp), %esi
	callq	f
	movl	%eax, %ecx
	movl	-40(%rbp), %eax                 # 4-byte Reload
	addl	%ecx, %eax
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.LBB0_10
# %bb.9:                                #   in Loop: Header=BB0_5 Depth=1
	movl	-36(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB0_10:                               #   in Loop: Header=BB0_5 Depth=1
	jmp	.LBB0_11
.LBB0_11:                               #   in Loop: Header=BB0_5 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB0_5
.LBB0_12:
	movl	-24(%rbp), %edx
	movslq	-16(%rbp), %rcx
	leaq	memo(%rip), %rax
	movl	%edx, (%rax,%rcx,4)
	movl	-24(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB0_13:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
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
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	xorl	%edi, %edi
	movl	$32767, %esi                    # imm = 0x7FFF
	callq	f
	movl	%eax, %esi
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	m,@object                       # @m
	.section	.rodata,"a",@progbits
	.globl	m
	.p2align	4, 0x0
m:
	.long	7                               # 0x7
	.long	53                              # 0x35
	.long	183                             # 0xb7
	.long	439                             # 0x1b7
	.long	863                             # 0x35f
	.long	497                             # 0x1f1
	.long	383                             # 0x17f
	.long	563                             # 0x233
	.long	79                              # 0x4f
	.long	973                             # 0x3cd
	.long	287                             # 0x11f
	.long	63                              # 0x3f
	.long	343                             # 0x157
	.long	169                             # 0xa9
	.long	583                             # 0x247
	.long	627                             # 0x273
	.long	343                             # 0x157
	.long	773                             # 0x305
	.long	959                             # 0x3bf
	.long	943                             # 0x3af
	.long	767                             # 0x2ff
	.long	473                             # 0x1d9
	.long	103                             # 0x67
	.long	699                             # 0x2bb
	.long	303                             # 0x12f
	.long	957                             # 0x3bd
	.long	703                             # 0x2bf
	.long	583                             # 0x247
	.long	639                             # 0x27f
	.long	913                             # 0x391
	.long	447                             # 0x1bf
	.long	283                             # 0x11b
	.long	463                             # 0x1cf
	.long	29                              # 0x1d
	.long	23                              # 0x17
	.long	487                             # 0x1e7
	.long	463                             # 0x1cf
	.long	993                             # 0x3e1
	.long	119                             # 0x77
	.long	883                             # 0x373
	.long	327                             # 0x147
	.long	493                             # 0x1ed
	.long	423                             # 0x1a7
	.long	159                             # 0x9f
	.long	743                             # 0x2e7
	.long	217                             # 0xd9
	.long	623                             # 0x26f
	.long	3                               # 0x3
	.long	399                             # 0x18f
	.long	853                             # 0x355
	.long	407                             # 0x197
	.long	103                             # 0x67
	.long	983                             # 0x3d7
	.long	89                              # 0x59
	.long	463                             # 0x1cf
	.long	290                             # 0x122
	.long	516                             # 0x204
	.long	212                             # 0xd4
	.long	462                             # 0x1ce
	.long	350                             # 0x15e
	.long	960                             # 0x3c0
	.long	376                             # 0x178
	.long	682                             # 0x2aa
	.long	962                             # 0x3c2
	.long	300                             # 0x12c
	.long	780                             # 0x30c
	.long	486                             # 0x1e6
	.long	502                             # 0x1f6
	.long	912                             # 0x390
	.long	800                             # 0x320
	.long	250                             # 0xfa
	.long	346                             # 0x15a
	.long	172                             # 0xac
	.long	812                             # 0x32c
	.long	350                             # 0x15e
	.long	870                             # 0x366
	.long	456                             # 0x1c8
	.long	192                             # 0xc0
	.long	162                             # 0xa2
	.long	593                             # 0x251
	.long	473                             # 0x1d9
	.long	915                             # 0x393
	.long	45                              # 0x2d
	.long	989                             # 0x3dd
	.long	873                             # 0x369
	.long	823                             # 0x337
	.long	965                             # 0x3c5
	.long	425                             # 0x1a9
	.long	329                             # 0x149
	.long	803                             # 0x323
	.long	973                             # 0x3cd
	.long	965                             # 0x3c5
	.long	905                             # 0x389
	.long	919                             # 0x397
	.long	133                             # 0x85
	.long	673                             # 0x2a1
	.long	665                             # 0x299
	.long	235                             # 0xeb
	.long	509                             # 0x1fd
	.long	613                             # 0x265
	.long	673                             # 0x2a1
	.long	815                             # 0x32f
	.long	165                             # 0xa5
	.long	992                             # 0x3e0
	.long	326                             # 0x146
	.long	322                             # 0x142
	.long	148                             # 0x94
	.long	972                             # 0x3cc
	.long	962                             # 0x3c2
	.long	286                             # 0x11e
	.long	255                             # 0xff
	.long	941                             # 0x3ad
	.long	541                             # 0x21d
	.long	265                             # 0x109
	.long	323                             # 0x143
	.long	925                             # 0x39d
	.long	281                             # 0x119
	.long	601                             # 0x259
	.long	95                              # 0x5f
	.long	973                             # 0x3cd
	.long	445                             # 0x1bd
	.long	721                             # 0x2d1
	.long	11                              # 0xb
	.long	525                             # 0x20d
	.long	473                             # 0x1d9
	.long	65                              # 0x41
	.long	511                             # 0x1ff
	.long	164                             # 0xa4
	.long	138                             # 0x8a
	.long	672                             # 0x2a0
	.long	18                              # 0x12
	.long	428                             # 0x1ac
	.long	154                             # 0x9a
	.long	448                             # 0x1c0
	.long	848                             # 0x350
	.long	414                             # 0x19e
	.long	456                             # 0x1c8
	.long	310                             # 0x136
	.long	312                             # 0x138
	.long	798                             # 0x31e
	.long	104                             # 0x68
	.long	566                             # 0x236
	.long	520                             # 0x208
	.long	302                             # 0x12e
	.long	248                             # 0xf8
	.long	694                             # 0x2b6
	.long	976                             # 0x3d0
	.long	430                             # 0x1ae
	.long	392                             # 0x188
	.long	198                             # 0xc6
	.long	184                             # 0xb8
	.long	829                             # 0x33d
	.long	373                             # 0x175
	.long	181                             # 0xb5
	.long	631                             # 0x277
	.long	101                             # 0x65
	.long	969                             # 0x3c9
	.long	613                             # 0x265
	.long	840                             # 0x348
	.long	740                             # 0x2e4
	.long	778                             # 0x30a
	.long	458                             # 0x1ca
	.long	284                             # 0x11c
	.long	760                             # 0x2f8
	.long	390                             # 0x186
	.long	821                             # 0x335
	.long	461                             # 0x1cd
	.long	843                             # 0x34b
	.long	513                             # 0x201
	.long	17                              # 0x11
	.long	901                             # 0x385
	.long	711                             # 0x2c7
	.long	993                             # 0x3e1
	.long	293                             # 0x125
	.long	157                             # 0x9d
	.long	274                             # 0x112
	.long	94                              # 0x5e
	.long	192                             # 0xc0
	.long	156                             # 0x9c
	.long	574                             # 0x23e
	.long	34                              # 0x22
	.long	124                             # 0x7c
	.long	4                               # 0x4
	.long	878                             # 0x36e
	.long	450                             # 0x1c2
	.long	476                             # 0x1dc
	.long	712                             # 0x2c8
	.long	914                             # 0x392
	.long	838                             # 0x346
	.long	669                             # 0x29d
	.long	875                             # 0x36b
	.long	299                             # 0x12b
	.long	823                             # 0x337
	.long	329                             # 0x149
	.long	699                             # 0x2bb
	.long	815                             # 0x32f
	.long	559                             # 0x22f
	.long	813                             # 0x32d
	.long	459                             # 0x1cb
	.long	522                             # 0x20a
	.long	788                             # 0x314
	.long	168                             # 0xa8
	.long	586                             # 0x24a
	.long	966                             # 0x3c6
	.long	232                             # 0xe8
	.long	308                             # 0x134
	.long	833                             # 0x341
	.long	251                             # 0xfb
	.long	631                             # 0x277
	.long	107                             # 0x6b
	.long	813                             # 0x32d
	.long	883                             # 0x373
	.long	451                             # 0x1c3
	.long	509                             # 0x1fd
	.long	615                             # 0x267
	.long	77                              # 0x4d
	.long	281                             # 0x119
	.long	613                             # 0x265
	.long	459                             # 0x1cb
	.long	205                             # 0xcd
	.long	380                             # 0x17c
	.long	274                             # 0x112
	.long	302                             # 0x12e
	.long	35                              # 0x23
	.long	805                             # 0x325
	.size	m, 900

	.type	memo,@object                    # @memo
	.local	memo
	.comm	memo,2097152,16
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"solution = %d\n"
	.size	.L.str, 15

	.ident	"clang version 18.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym f
	.addrsig_sym printf
	.addrsig_sym m
	.addrsig_sym memo
