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
	subq	$224, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	call	omp_get_num_threads
	movl	%eax, %ebx
	call	omp_get_thread_num
	movl	%eax, %ecx
	movl	$512, %eax
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
	sall	$5, %eax
	movl	%eax, 60(%rsp)
	movq	A(%rip), %rax
	movl	%edx, %ebx
	movq	%rax, 48(%rsp)
	movq	C(%rip), %rax
	sall	$5, %ebx
	sall	$19, %edx
	movl	%ebx, 76(%rsp)
	movq	%rax, 88(%rsp)
	movl	%edx, 72(%rsp)
	movq	B(%rip), %r15
.L7:
	movl	76(%rsp), %eax
	movl	$16352, %edx
	cmpl	$16352, %eax
	cmovle	%eax, %edx
	addl	$32, %edx
	cmpl	%edx, %eax
	jge	.L4
	movslq	72(%rsp), %rax
	movq	88(%rsp), %rbx
	sall	$14, %edx
	leaq	32(%rbx,%rax,4), %rsi
	salq	$2, %rax
	addq	%rax, %rbx
	addq	48(%rsp), %rax
	movq	%r15, 96(%rsp)
	movq	%rsi, 24(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%rax, 32(%rsp)
	movl	%edx, 120(%rsp)
	movq	$0, 104(%rsp)
.L8:
	movq	24(%rsp), %rsi
	movq	104(%rsp), %rbx
	movq	%rsi, 64(%rsp)
	movl	%ebx, %eax
	movq	96(%rsp), %rsi
	addl	$32, %eax
	movl	%eax, 204(%rsp)
	movq	%rsi, 80(%rsp)
	movq	$0, 112(%rsp)
	cmpl	%ebx, %eax
	jle	.L6
.L5:
	movq	112(%rsp), %rsi
	leal	32(%rsi), %ebx
	cmpl	%esi, %ebx
	jle	.L9
	movl	$32, %edi
	movl	%edi, %edx
	movl	%edi, 196(%rsp)
	andl	$-8, %edi
	movl	%edi, 192(%rsp)
	addl	%esi, %edi
	leal	2(%rdi), %esi
	movl	%esi, 184(%rsp)
	leal	3(%rdi), %esi
	movl	%esi, 180(%rsp)
	leal	4(%rdi), %esi
	movl	%esi, 176(%rsp)
	leal	5(%rdi), %esi
	movl	%esi, 156(%rsp)
	leal	6(%rdi), %esi
	movl	%esi, 152(%rsp)
	movl	72(%rsp), %esi
	movq	64(%rsp), %rcx
	movl	%esi, 124(%rsp)
	movq	32(%rsp), %rsi
	shrl	$3, %edx
	movl	%edi, 188(%rsp)
	movq	%rcx, 208(%rsp)
	movq	%rsi, 216(%rsp)
	movl	$31, 200(%rsp)
	salq	$5, %rdx
	movq	40(%rsp), %r14
	leaq	-32(%rcx), %rax
	movq	%rdx, %r12
	leal	1(%rdi), %r13d
	.p2align 4,,10
	.p2align 3
.L11:
	movl	124(%rsp), %edi
	movl	188(%rsp), %edx
	movq	88(%rsp), %rsi
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %r10
	leal	0(%r13,%rdi), %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %r11
	movl	184(%rsp), %edx
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 168(%rsp)
	movl	180(%rsp), %edx
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 160(%rsp)
	movl	176(%rsp), %edx
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 144(%rsp)
	movl	156(%rsp), %edx
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 136(%rsp)
	movl	152(%rsp), %edx
	addl	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdi
	movq	%rdi, 128(%rsp)
	movq	80(%rsp), %rdx
	movq	96(%rsp), %rdi
	movq	104(%rsp), %rsi
	.p2align 4,,10
	.p2align 3
.L10:
	movq	216(%rsp), %rcx
	leaq	32(%rdx), %r8
	vmovss	(%rcx,%rsi,4), %xmm1
	movl	%esi, %ecx
	sall	$14, %ecx
	cmpq	%r8, %rax
	setnb	%r9b
	cmpq	208(%rsp), %rdx
	setnb	%r8b
	orb	%r8b, %r9b
	je	.L21
	xorl	%r8d, %r8d
	cmpl	$6, 200(%rsp)
	vbroadcastss	%xmm1, %ymm2
	jbe	.L21
	.p2align 4,,10
	.p2align 3
.L16:
	vmovups	(%rdx,%r8), %ymm0
	vfmadd213ps	(%rax,%r8), %ymm2, %ymm0
	vmovups	%ymm0, (%rax,%r8)
	addq	$32, %r8
	cmpq	%r12, %r8
	jne	.L16
	movl	192(%rsp), %r8d
	cmpl	%r8d, 196(%rsp)
	je	.L18
	movl	188(%rsp), %r9d
	leal	(%rcx,%r9), %r8d
	movslq	%r8d, %r8
	vmovss	(%r15,%r8,4), %xmm0
	vfmadd213ss	(%r10), %xmm1, %xmm0
	vmovss	%xmm0, (%r10)
	cmpl	%ebx, %r13d
	jge	.L18
	leal	0(%r13,%rcx), %r8d
	movslq	%r8d, %r8
	vmovss	(%r15,%r8,4), %xmm0
	movl	184(%rsp), %r9d
	vfmadd213ss	(%r11), %xmm1, %xmm0
	vmovss	%xmm0, (%r11)
	cmpl	%r9d, %ebx
	jle	.L18
	leal	(%rcx,%r9), %r8d
	movslq	%r8d, %r8
	movq	168(%rsp), %r9
	vmovss	(%r15,%r8,4), %xmm0
	vfmadd213ss	(%r9), %xmm1, %xmm0
	vmovss	%xmm0, (%r9)
	movl	180(%rsp), %r9d
	cmpl	%r9d, %ebx
	jle	.L18
	leal	(%rcx,%r9), %r8d
	movslq	%r8d, %r8
	movq	160(%rsp), %r9
	vmovss	(%r15,%r8,4), %xmm0
	vfmadd213ss	(%r9), %xmm1, %xmm0
	vmovss	%xmm0, (%r9)
	movl	176(%rsp), %r9d
	cmpl	%r9d, %ebx
	jle	.L18
	leal	(%rcx,%r9), %r8d
	movslq	%r8d, %r8
	movq	144(%rsp), %r9
	vmovss	(%r15,%r8,4), %xmm0
	vfmadd213ss	(%r9), %xmm1, %xmm0
	vmovss	%xmm0, (%r9)
	movl	156(%rsp), %r9d
	cmpl	%r9d, %ebx
	jle	.L18
	leal	(%rcx,%r9), %r8d
	movslq	%r8d, %r8
	movq	136(%rsp), %r9
	vmovss	(%r15,%r8,4), %xmm0
	vfmadd213ss	(%r9), %xmm1, %xmm0
	vmovss	%xmm0, (%r9)
	movl	152(%rsp), %r9d
	cmpl	%r9d, %ebx
	jle	.L18
	addl	%r9d, %ecx
	movq	128(%rsp), %r9
	movslq	%ecx, %rcx
	vmovss	(%r9), %xmm3
	vfmadd132ss	(%r15,%rcx,4), %xmm3, %xmm1
	vmovss	%xmm1, (%r9)
.L18:
	incq	%rsi
	addq	$65536, %rdx
	addq	$65536, %rdi
	cmpl	%esi, 204(%rsp)
	jg	.L10
	addl	$16384, 124(%rsp)
	addq	$65536, %r14
	addq	$65536, 216(%rsp)
	addq	$65536, 208(%rsp)
	movl	124(%rsp), %edi
	addq	$65536, %rax
	cmpl	120(%rsp), %edi
	jne	.L11
.L9:
	addq	$32, 112(%rsp)
	subq	$-128, 80(%rsp)
	subq	$-128, 64(%rsp)
	movq	112(%rsp), %rax
	cmpq	$16384, %rax
	jne	.L5
.L6:
	addq	$32, 104(%rsp)
	addq	$2097152, 96(%rsp)
	movq	104(%rsp), %rax
	cmpq	$16384, %rax
	jne	.L8
.L4:
	addl	$32, 76(%rsp)
	addl	$524288, 72(%rsp)
	movl	76(%rsp), %eax
	cmpl	%eax, 60(%rsp)
	jg	.L7
	vzeroupper
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
	.p2align 4,,10
	.p2align 3
.L21:
	.cfi_restore_state
	movq	112(%rsp), %rcx
	.p2align 4,,10
	.p2align 3
.L14:
	vmovss	(%rdi,%rcx,4), %xmm0
	vfmadd213ss	(%r14,%rcx,4), %xmm1, %xmm0
	vmovss	%xmm0, (%r14,%rcx,4)
	incq	%rcx
	cmpl	%ecx, %ebx
	jg	.L14
	jmp	.L18
.L2:
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
