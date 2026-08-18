/* SPDX-License-Identifier: BSD-2-Clause */
/*
 *  Copyright (c) 2021 Intel Corporation
 */

#include <asm.S>

.section .text

.macro LDELF_SYSCALL name, scn, num_args
FUNC \name , :

    .if \num_args > 8
    .error "Too many arguments for syscall"
    .endif

    /* callee-save registers */
    pushq %rbp
    pushq %rbx
    pushq %r15
    pushq %r14
    pushq %r13
    pushq %r12

    /* save registers that syscall clobbers */
    movq %rcx, %r10
    pushq %r11

    movq $(\scn), %rax

    /* save the 7th arg */
    movq 64(%rsp), %r12
    /* save the 8th arg */
    movq 72(%rsp), %r13

    syscall

1:  popq %r11
    popq %r12
    popq %r13
    popq %r14
    popq %r15
    popq %rbx
    popq %rbp

    retq
END_FUNC \name
.endm

FUNC _ldelf_panic, :
    call __ldelf_panic
    /* Not reached */
END_FUNC _ldelf_panic

#include "syscalls_asm.S"
.section .note.GNU-stack,"",@progbits
