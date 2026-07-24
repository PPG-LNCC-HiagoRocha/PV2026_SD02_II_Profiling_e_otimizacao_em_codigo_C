	.file	"matmul.c"
	.text
	.p2align 4,,15
	.type	main._omp_fn.1, @function
main._omp_fn.1:
.LFB25:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	call	omp_get_num_threads
	movl	%eax, %ebx
	call	omp_get_thread_num
	movl	%eax, %ecx
	movl	$2048, %eax
	cltd
	idivl	%ebx
	cmpl	%edx, %ecx
	jl	.L2
.L19:
	imull	%eax, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	cmpl	%eax, %edx
	jge	.L1
	sall	$3, %eax
	leal	0(,%rdx,8), %esi
	sall	$17, %edx
	movq	B(%rip), %r15
	movl	%eax, 108(%rsp)
	movq	A(%rip), %rax
	movl	%esi, 92(%rsp)
	movq	%rax, 112(%rsp)
	movq	C(%rip), %rax
	movl	%edx, 104(%rsp)
	movq	%rax, 72(%rsp)
.L7:
	movl	92(%rsp), %eax
	movl	$16376, %edx
	cmpl	$16376, %eax
	cmovle	%eax, %edx
	addl	$8, %edx
	cmpl	%edx, %eax
	jge	.L4
	movslq	104(%rsp), %rax
	movq	72(%rsp), %rsi
	sall	$14, %edx
	movq	%r15, 64(%rsp)
	movl	%edx, 88(%rsp)
	movq	$0, 56(%rsp)
	leaq	16(%rsi,%rax,4), %rcx
	salq	$2, %rax
	addq	%rax, %rsi
	addq	112(%rsp), %rax
	movq	%rcx, 136(%rsp)
	movq	%rsi, 120(%rsp)
	movq	%rax, 128(%rsp)
.L8:
	movq	136(%rsp), %rcx
	movq	56(%rsp), %rsi
	movq	$0, 48(%rsp)
	movl	%esi, %eax
	movq	%rcx, 96(%rsp)
	movq	64(%rsp), %rcx
	addl	$8, %eax
	movl	%eax, 12(%rsp)
	movq	%rcx, 80(%rsp)
	cmpl	%esi, %eax
	jle	.L6
.L5:
	movq	48(%rsp), %rdx
	leal	8(%rdx), %r10d
	cmpl	%edx, %r10d
	jle	.L9
	movl	$8, %ecx
	movq	96(%rsp), %rbx
	movq	128(%rsp), %r12
	movl	$7, 16(%rsp)
	movl	%ecx, %esi
	movl	%ecx, 20(%rsp)
	andl	$-4, %ecx
	movq	120(%rsp), %r9
	movl	%ecx, 24(%rsp)
	addl	%edx, %ecx
	shrl	$2, %esi
	leaq	-16(%rbx), %rax
	movl	%ecx, 28(%rsp)
	leal	1(%rcx), %r14d
	addl	$2, %ecx
	salq	$4, %rsi
	movl	%ecx, 40(%rsp)
	movl	104(%rsp), %ecx
	movq	%r12, %r13
	movq	%rbx, (%rsp)
	movl	%ecx, 44(%rsp)
	.p2align 4,,10
	.p2align 3
.L11:
	movl	44(%rsp), %ecx
	movl	28(%rsp), %edx
	movq	72(%rsp), %rbx
	movq	64(%rsp), %r8
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	(%rbx,%rdx,4), %rbp
	leal	(%r14,%rcx), %edx
	movslq	%edx, %rdx
	leaq	(%rbx,%rdx,4), %r12
	movl	40(%rsp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	(%rbx,%rdx,4), %rcx
	movq	80(%rsp), %rdx
	movq	%rcx, 32(%rsp)
	movq	56(%rsp), %rcx
	.p2align 4,,10
	.p2align 3
.L10:
	leaq	16(%rdx), %r11
	movl	%ecx, %edi
	movss	0(%r13,%rcx,4), %xmm1
	sall	$14, %edi
	cmpq	%r11, %rax
	setnb	%bl
	cmpq	(%rsp), %rdx
	setnb	%r11b
	orb	%r11b, %bl
	je	.L21
	movaps	%xmm1, %xmm2
	xorl	%r11d, %r11d
	cmpl	$2, 16(%rsp)
	shufps	$0, %xmm2, %xmm2
	jbe	.L21
	.p2align 4,,10
	.p2align 3
.L16:
	movups	(%rdx,%r11), %xmm0
	movups	(%rax,%r11), %xmm3
	mulps	%xmm2, %xmm0
	addps	%xmm3, %xmm0
	movups	%xmm0, (%rax,%r11)
	addq	$16, %r11
	cmpq	%rsi, %r11
	jne	.L16
	movl	24(%rsp), %r11d
	cmpl	%r11d, 20(%rsp)
	je	.L18
	movl	28(%rsp), %ebx
	leal	(%rdi,%rbx), %r11d
	movslq	%r11d, %r11
	movss	(%r15,%r11,4), %xmm0
	mulss	%xmm1, %xmm0
	addss	0(%rbp), %xmm0
	movss	%xmm0, 0(%rbp)
	cmpl	%r10d, %r14d
	jge	.L18
	leal	(%r14,%rdi), %r11d
	movl	40(%rsp), %ebx
	movslq	%r11d, %r11
	movss	(%r15,%r11,4), %xmm0
	mulss	%xmm1, %xmm0
	addss	(%r12), %xmm0
	movss	%xmm0, (%r12)
	cmpl	%ebx, %r10d
	jle	.L18
	addl	%ebx, %edi
	movq	32(%rsp), %rbx
	movslq	%edi, %rdi
	mulss	(%r15,%rdi,4), %xmm1
	addss	(%rbx), %xmm1
	movss	%xmm1, (%rbx)
.L18:
	addq	$1, %rcx
	addq	$65536, %rdx
	addq	$65536, %r8
	cmpl	%ecx, 12(%rsp)
	jg	.L10
	addl	$16384, 44(%rsp)
	addq	$65536, %r9
	movl	44(%rsp), %ecx
	addq	$65536, %r13
	addq	$65536, (%rsp)
	addq	$65536, %rax
	cmpl	88(%rsp), %ecx
	jne	.L11
.L9:
	addq	$8, 48(%rsp)
	movq	48(%rsp), %rax
	addq	$32, 80(%rsp)
	addq	$32, 96(%rsp)
	cmpq	$16384, %rax
	jne	.L5
.L6:
	addq	$8, 56(%rsp)
	movq	56(%rsp), %rax
	addq	$524288, 64(%rsp)
	cmpq	$16384, %rax
	jne	.L8
.L4:
	addl	$8, 92(%rsp)
	movl	92(%rsp), %eax
	addl	$131072, 104(%rsp)
	cmpl	%eax, 108(%rsp)
	jg	.L7
.L1:
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L21:
	.cfi_restore_state
	movq	48(%rsp), %rdi
	.p2align 4,,10
	.p2align 3
.L14:
	movss	(%r8,%rdi,4), %xmm0
	mulss	%xmm1, %xmm0
	addss	(%r9,%rdi,4), %xmm0
	movss	%xmm0, (%r9,%rdi,4)
	addq	$1, %rdi
	cmpl	%edi, %r10d
	jg	.L14
	jmp	.L18
.L2:
	addl	$1, %eax
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
	jl	.L40
.L42:
	imull	%eax, %ecx
	addl	%edx, %ecx
	leal	(%rax,%rcx), %edx
	cmpl	%edx, %ecx
	jge	.L39
	leal	-1(%rax), %edx
	movl	%ecx, %eax
	movq	C(%rip), %rcx
	xorl	%esi, %esi
	sall	$14, %eax
	addq	$1, %rdx
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	cltq
	salq	$16, %rdx
	leaq	(%rcx,%rax,4), %rdi
	jmp	memset
.L39:
	.cfi_restore_state
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L40:
	.cfi_restore_state
	addl	$1, %eax
	xorl	%edx, %edx
	jmp	.L42
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
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	subq	%rdi, %rdx
	cvtsi2sdq	%rcx, %xmm0
	mulsd	.LC0(%rip), %xmm0
	cvtsi2sdq	%rdx, %xmm1
	addsd	%xmm1, %xmm0
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
	movq	%rax, C(%rip)
	sete	%dl
	orb	%dl, %cl
	jne	.L56
	movl	$65536, %ebp
	testq	%rax, %rax
	je	.L56
.L46:
	leaq	-65536(%rbp), %rbx
	.p2align 4,,10
	.p2align 3
.L49:
	call	rand
	pxor	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	.LC2(%rip), %xmm0
	movq	A(%rip), %rax
	movss	%xmm0, (%rax,%rbx)
	call	rand
	pxor	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	.LC2(%rip), %xmm0
	movq	B(%rip), %rax
	movss	%xmm0, (%rax,%rbx)
	addq	$4, %rbx
	cmpq	%rbp, %rbx
	jne	.L49
	leaq	65536(%rbx), %rbp
	cmpq	$1073807360, %rbp
	jne	.L46
	xorl	%ebx, %ebx
.L50:
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
	pxor	%xmm0, %xmm0
	subq	8(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	mulsd	.LC0(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm0
	testl	%ebx, %ebx
	je	.L61
	movl	$2, %esi
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	cmpl	$1, %ebx
	jne	.L52
	movq	A(%rip), %rdi
	call	free
	movq	B(%rip), %rdi
	call	free
	movq	C(%rip), %rdi
	call	free
	xorl	%eax, %eax
.L45:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L61:
	.cfi_restore_state
	movl	$1, %esi
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
.L52:
	addl	$1, %ebx
	jmp	.L50
.L56:
	movl	$24, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	movq	stderr(%rip), %rcx
	call	fwrite
	movl	$1, %eax
	jmp	.L45
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
