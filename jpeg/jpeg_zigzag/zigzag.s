	.file	"zigzag.c"
	.text
	.p2align 4,,15
.globl zigzag
	.type	zigzag, @function
zigzag:
.LFB659:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$360, %rsp
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	15(%rsp), %rax
	andq	$-16, %rax
	movq	%rdi, (%rax)
	movq	%rcx, 24(%rax)
	leaq	-160(%rbp), %rcx
	movq	%rsi, 8(%rax)
	movq	%rdx, 16(%rax)
	movq	%r8, 32(%rax)
	movq	%r9, 40(%rax)
	movq	16(%rbp), %rdx
	movq	%rdx, 48(%rax)
	movq	24(%rbp), %rdx
	movq	%rdx, 56(%rax)
	leaq	-288(%rbp), %rdx
	movw	$0, -288(%rbp)
	movw	$1, -286(%rbp)
	movw	$256, -284(%rbp)
	leaq	128(%rdx), %rdi
	movw	$512, -282(%rbp)
	movw	$257, -280(%rbp)
	movw	$2, -278(%rbp)
	movw	$3, -276(%rbp)
	movw	$258, -274(%rbp)
	movw	$513, -272(%rbp)
	movw	$768, -270(%rbp)
	movw	$1024, -268(%rbp)
	movw	$769, -266(%rbp)
	movw	$514, -264(%rbp)
	movw	$259, -262(%rbp)
	movw	$4, -260(%rbp)
	movw	$6, -258(%rbp)
	movw	$260, -256(%rbp)
	movw	$515, -254(%rbp)
	movw	$770, -252(%rbp)
	movw	$1025, -250(%rbp)
	movw	$1280, -248(%rbp)
	movw	$1536, -246(%rbp)
	movw	$1281, -244(%rbp)
	movw	$1026, -242(%rbp)
	movw	$771, -240(%rbp)
	movw	$516, -238(%rbp)
	movw	$261, -236(%rbp)
	movw	$6, -234(%rbp)
	movw	$7, -232(%rbp)
	movw	$262, -230(%rbp)
	movw	$517, -228(%rbp)
	movw	$772, -226(%rbp)
	movw	$1027, -224(%rbp)
	movw	$1282, -222(%rbp)
	movw	$1537, -220(%rbp)
	movw	$1792, -218(%rbp)
	movw	$1793, -216(%rbp)
	movw	$1538, -214(%rbp)
	movw	$1283, -212(%rbp)
	movw	$1028, -210(%rbp)
	movw	$773, -208(%rbp)
	movw	$518, -206(%rbp)
	movw	$263, -204(%rbp)
	movw	$519, -202(%rbp)
	movw	$774, -200(%rbp)
	movw	$1029, -198(%rbp)
	movw	$1284, -196(%rbp)
	movw	$1539, -194(%rbp)
	movw	$1794, -192(%rbp)
	movw	$1795, -190(%rbp)
	movw	$1540, -188(%rbp)
	movw	$1285, -186(%rbp)
	movw	$1030, -184(%rbp)
	movw	$775, -182(%rbp)
	movw	$1031, -180(%rbp)
	movw	$1286, -178(%rbp)
	movw	$1541, -176(%rbp)
	movw	$1796, -174(%rbp)
	movw	$1797, -172(%rbp)
	movw	$1542, -170(%rbp)
	movw	$1287, -168(%rbp)
	movw	$1543, -166(%rbp)
	movw	$1798, -164(%rbp)
	movw	$1799, -162(%rbp)
	.p2align 4,,10
	.p2align 3
.L2:
	movzwl	(%rdx), %ebx
	.cfi_offset 3, -24
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	2(%rdx), %ebx
	movw	%si, (%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	4(%rdx), %ebx
	movw	%si, 2(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	6(%rdx), %ebx
	movw	%si, 4(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	8(%rdx), %ebx
	movw	%si, 6(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	10(%rdx), %ebx
	movw	%si, 8(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	12(%rdx), %ebx
	movw	%si, 10(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movzwl	14(%rdx), %ebx
	addq	$16, %rdx
	movw	%si, 12(%rcx)
	movzbl	%bh, %esi
	andl	$15, %ebx
	movq	(%rax,%rsi,8), %rsi
	movzwl	(%rsi,%rbx,2), %esi
	movw	%si, 14(%rcx)
	addq	$16, %rcx
	cmpq	%rdi, %rdx
	jne	.L2
	movzwl	-160(%rbp), %ecx
	movq	(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-158(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-156(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-154(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-152(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-150(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-148(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-146(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-144(%rbp), %ecx
	movq	8(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-142(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-140(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-138(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-136(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-134(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-132(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-130(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-128(%rbp), %ecx
	movq	16(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-126(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-124(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-122(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-120(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-118(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-116(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-114(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-112(%rbp), %ecx
	movq	24(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-110(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-108(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-106(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-104(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-102(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-100(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-98(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-96(%rbp), %ecx
	movq	32(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-94(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-92(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-90(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-88(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-86(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-84(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-82(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-80(%rbp), %ecx
	movq	40(%rax), %rdx
	movw	%cx, (%rdx)
	movzwl	-78(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-76(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-74(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-72(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-70(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-68(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-66(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-64(%rbp), %ecx
	movq	48(%rax), %rdx
	movq	56(%rax), %rax
	movw	%cx, (%rdx)
	movzwl	-62(%rbp), %ecx
	movw	%cx, 2(%rdx)
	movzwl	-60(%rbp), %ecx
	movw	%cx, 4(%rdx)
	movzwl	-58(%rbp), %ecx
	movw	%cx, 6(%rdx)
	movzwl	-56(%rbp), %ecx
	movw	%cx, 8(%rdx)
	movzwl	-54(%rbp), %ecx
	movw	%cx, 10(%rdx)
	movzwl	-52(%rbp), %ecx
	movw	%cx, 12(%rdx)
	movzwl	-50(%rbp), %ecx
	movw	%cx, 14(%rdx)
	movzwl	-48(%rbp), %edx
	movw	%dx, (%rax)
	movzwl	-46(%rbp), %edx
	movw	%dx, 2(%rax)
	movzwl	-44(%rbp), %edx
	movw	%dx, 4(%rax)
	movzwl	-42(%rbp), %edx
	movw	%dx, 6(%rax)
	movzwl	-40(%rbp), %edx
	movw	%dx, 8(%rax)
	movzwl	-38(%rbp), %edx
	movw	%dx, 10(%rax)
	movzwl	-36(%rbp), %edx
	movw	%dx, 12(%rax)
	movzwl	-34(%rbp), %edx
	movw	%dx, 14(%rax)
	movq	-24(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L6
	movq	-8(%rbp), %rbx
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L6:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE659:
	.size	zigzag, .-zigzag
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"NO SSE!!\n"
	.text
	.p2align 4,,15
.globl zigzag_array
	.type	zigzag_array, @function
zigzag_array:
.LFB660:
	.cfi_startproc
	movq	%rbx, -48(%rsp)
	movq	%rbp, -40(%rsp)
	movq	%rcx, %rbx
	.cfi_offset 6, -48
	.cfi_offset 3, -56
	movq	%r12, -32(%rsp)
	movq	%r13, -24(%rsp)
	movq	%rdx, %r13
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	movq	%r14, -16(%rsp)
	movq	%r15, -8(%rsp)
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	stderr(%rip), %rcx
	movq	80(%rsp), %rbp
	movq	%rdi, %r15
	.cfi_offset 15, -16
	.cfi_offset 14, -24
	movq	88(%rsp), %r12
	movq	%rsi, %r14
	movl	$9, %edx
	movl	$1, %esi
	movl	$.LC0, %edi
	movq	%r8, 8(%rsp)
	movq	%r9, (%rsp)
	call	fwrite
	movq	(%rsp), %r9
	movq	8(%rsp), %r8
	movq	%rbx, %rcx
	movq	%r12, 88(%rsp)
	movq	%rbp, 80(%rsp)
	movq	%r13, %rdx
	movq	%r14, %rsi
	movq	%r15, %rdi
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r12
	movq	48(%rsp), %r13
	movq	56(%rsp), %r14
	movq	64(%rsp), %r15
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	jmp	zigzag
	.cfi_endproc
.LFE660:
	.size	zigzag_array, .-zigzag_array
	.ident	"GCC: (Ubuntu/Linaro 4.5.2-8ubuntu4) 4.5.2"
	.section	.note.GNU-stack,"",@progbits
