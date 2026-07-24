	.file	"matmul.c"
	.text
	.p2align 4,,15
	.type	main._omp_fn.1, @function
main._omp_fn.1:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$64, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	call	omp_get_num_threads
	movl	%eax, %ebx
	call	omp_get_thread_num
	movl	%eax, %ecx
	movl	$4096, %eax
	cltd
	idivl	%ebx
	cmpl	%edx, %ecx
	jl	.L2
.L19:
	imull	%eax, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	cmpl	%eax, %edx
	jge	.L37
	sall	$2, %eax
	movl	%eax, 60(%rsp)
	movq	A(%rip), %rax
	leal	0(,%rdx,4), %r15d
	movq	%rax, 48(%rsp)
	movq	C(%rip), %rax
	sall	$16, %edx
	movq	%rax, 40(%rsp)
	movq	B(%rip), %rax
	movl	%edx, %r14d
	movq	%rax, 32(%rsp)
.L7:
	cmpl	$16380, %r15d
	movl	$16380, %r12d
	cmovle	%r15d, %r12d
	addl	$4, %r12d
	cmpl	%r12d, %r15d
	jge	.L4
	movslq	%r14d, %rax
	movq	40(%rsp), %rbx
	salq	$2, %rax
	addq	%rax, %rbx
	addq	48(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	32(%rsp), %r13
	movq	%rbx, 24(%rsp)
	sall	$14, %r12d
	xorl	%ebx, %ebx
.L8:
	leal	4(%rbx), %r10d
	xorl	%r9d, %r9d
	cmpl	%ebx, %r10d
	jle	.L6
.L5:
	leal	4(%r9), %edi
	cmpl	%r9d, %edi
	jle	.L9
	movq	16(%rsp), %r8
	movq	24(%rsp), %rsi
	movl	%r14d, %r11d
	.p2align 4,,10
	.p2align 3
.L11:
	movq	%r13, %rcx
	movq	%rbx, %rdx
	.p2align 4,,10
	.p2align 3
.L10:
	vmovss	(%r8,%rdx,4), %xmm1
	movq	%r9, %rax
.L14:
	vmovss	(%rcx,%rax,4), %xmm0
	vfmadd213ss	(%rsi,%rax,4), %xmm1, %xmm0
	vmovss	%xmm0, (%rsi,%rax,4)
	incq	%rax
	cmpl	%eax, %edi
	jg	.L14
	incq	%rdx
	addq	$65536, %rcx
	cmpl	%edx, %r10d
	jg	.L10
	addl	$16384, %r11d
	addq	$65536, %rsi
	addq	$65536, %r8
	cmpl	%r12d, %r11d
	jne	.L11
.L9:
	addq	$4, %r9
	addq	$16, 8(%rsp)
	addq	$16, (%rsp)
	cmpq	$16384, %r9
	jne	.L5
.L6:
	addq	$4, %rbx
	addq	$262144, %r13
	cmpq	$16384, %rbx
	jne	.L8
.L4:
	addl	$4, %r15d
	addl	$65536, %r14d
	cmpl	%r15d, 60(%rsp)
	jg	.L7
.L37:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L2:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L19
	.cfi_endproc
.LFE25:
	.size	main._omp_fn.1, .-main._omp_fn.1
	.p2align 4,,15
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB24:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	call	omp_get_num_threads
	movl	%eax, %ebx
	call	omp_get_thread_num
	movl	%eax, %ecx
	movl	$16384, %eax
	cltd
	idivl	%ebx
	cmpl	%edx, %ecx
	jl	.L41
.L43:
	imull	%eax, %ecx
	addl	%edx, %ecx
	leal	(%rax,%rcx), %edx
	cmpl	%edx, %ecx
	jge	.L44
	leal	-1(%rax), %edx
	movl	%ecx, %eax
	sall	$14, %eax
	movq	C(%rip), %rcx
	incq	%rdx
	cltq
	salq	$16, %rdx
	leaq	(%rcx,%rax,4), %rdi
	xorl	%esi, %esi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	memset
.L44:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L41:
	.cfi_restore_state
	incl	%eax
	xorl	%edx, %edx
	jmp	.L43
	.cfi_endproc
.LFE24:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.p2align 4,,15
	.globl	tempo_em_segundos
	.type	tempo_em_segundos, @function
tempo_em_segundos:
.LFB22:
	.cfi_startproc
	subq	%rsi, %rcx
	subq	%rdi, %rdx
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sdq	%rcx, %xmm0, %xmm0
	vcvtsi2sdq	%rdx, %xmm1, %xmm1
	vfmadd132sd	.LC0(%rip), %xmm1, %xmm0
	ret
	.cfi_endproc
.LFE22:
	.size	tempo_em_segundos, .-tempo_em_segundos
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Erro ao alocar mem\303\263ria\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Execu\303\247\303\243o %d: %.6f s (descartada \342\200\223 warm-up)\n"
	.section	.rodata.str1.1
.LC4:
	.string	"Execu\303\247\303\243o %d: %.6f s\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	call	srand
	movl	$1073741824, %edi
	call	malloc
	movl	$1073741824, %edi
	movq	%rax, %rbp
	movq	%rax, A(%rip)
	call	malloc
	movl	$1073741824, %edi
	movq	%rax, %rbx
	movq	%rax, B(%rip)
	call	malloc
	testq	%rbp, %rbp
	sete	%cl
	testq	%rbx, %rbx
	sete	%dl
	orb	%dl, %cl
	movq	%rax, C(%rip)
	jne	.L58
	movl	$65536, %ebp
	testq	%rax, %rax
	je	.L58
.L48:
	leaq	-65536(%rbp), %rbx
	.p2align 4,,10
	.p2align 3
.L51:
	call	rand
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ss	%eax, %xmm0, %xmm0
	movq	A(%rip), %rax
	vmulss	.LC2(%rip), %xmm0, %xmm0
	vmovss	%xmm0, (%rax,%rbx)
	call	rand
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ss	%eax, %xmm0, %xmm0
	movq	B(%rip), %rax
	vmulss	.LC2(%rip), %xmm0, %xmm0
	vmovss	%xmm0, (%rax,%rbx)
	addq	$4, %rbx
	cmpq	%rbp, %rbx
	jne	.L51
	leaq	65536(%rbx), %rbp
	cmpq	$1073807360, %rbp
	jne	.L48
	xorl	%ebx, %ebx
.L52:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	movl	$main._omp_fn.0, %edi
	call	GOMP_parallel
	movq	%rsp, %rsi
	movl	$1, %edi
	call	clock_gettime
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	movl	$main._omp_fn.1, %edi
	call	GOMP_parallel
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	8(%rsp), %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	movq	16(%rsp), %rax
	vxorpd	%xmm1, %xmm1, %xmm1
	subq	(%rsp), %rax
	vcvtsi2sdq	%rax, %xmm1, %xmm1
	vfmadd132sd	.LC0(%rip), %xmm1, %xmm0
	testl	%ebx, %ebx
	je	.L64
	movl	$2, %esi
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	cmpl	$1, %ebx
	jne	.L54
	movq	A(%rip), %rdi
	call	free
	movq	B(%rip), %rdi
	call	free
	movq	C(%rip), %rdi
	call	free
	xorl	%eax, %eax
.L62:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L64:
	.cfi_restore_state
	movl	$1, %esi
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
.L54:
	incl	%ebx
	jmp	.L52
.L58:
	movq	stderr(%rip), %rcx
	movl	$24, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	$1, %eax
	jmp	.L62
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.comm	C,8,8
	.comm	B,8,8
	.comm	A,8,8
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	3894859413
	.long	1041313291
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC2:
	.long	805306368
	.ident	"GCC: (GNU) 8.5.0 20210514 (Red Hat 8.5.0-18)"
	.section	.note.GNU-stack,"",@progbits
