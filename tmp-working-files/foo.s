	.file	"foo.cpp"
	.text
	.p2align 4
	.globl	_Z3sumP3Foo
	.type	_Z3sumP3Foo, @function
_Z3sumP3Foo:
.LFB0:
	.cfi_startproc
	endbr64
	leaq	400(%rdi), %rax
	pxor	%xmm1, %xmm1
	pxor	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	(%rdi), %xmm0
	movdqa	%xmm4, %xmm2
	addq	$16, %rdi
	pcmpgtd	%xmm0, %xmm2
	movdqa	%xmm0, %xmm3
	punpckldq	%xmm2, %xmm3
	punpckhdq	%xmm2, %xmm0
	paddq	%xmm3, %xmm1
	paddq	%xmm0, %xmm1
	cmpq	%rdi, %rax
	jne	.L2
	movdqa	%xmm1, %xmm0
	psrldq	$8, %xmm0
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	ret
	.cfi_endproc
.LFE0:
	.size	_Z3sumP3Foo, .-_Z3sumP3Foo
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
