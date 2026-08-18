/* SPDX-License-Identifier: BSD-2-Clause */
/*
 *  Copyright (c) 2021 Intel Corporation
 */

#include <tee_syscall_numbers.h>
#include <asm.S>

.section .text

.macro UTEE_SYSCALL name, scn, num_args
FUNC \name , :

    .if \num_args > TEE_SVC_MAX_ARGS
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

#Femi: Need to test this
FUNC _utee_panic, :
    pushq %rbp
    movq  %rsp, %rbp
    movq  %rsp, %rsi      # second argument = pointer to frame
    call  __utee_panic
END_FUNC _utee_panic


#include <utee_syscalls_asm.S>
.section .note.GNU-stack,"",@progbits
