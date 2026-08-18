cppflags-y += -I$(sub-dir)/../..

srcs-y += utee_syscalls_64.S

#ifneq ($(sm),ldelf)
#srcs-y += stack_guard.c
#cflags-stack_guard.c-y += -fno-stack-protector
#srcs-y += tcb.c
#srcs-y += user_ta_entry.c
#subdirs-y += gprof
#endif #$(sm-$(sm)-is-ld)

