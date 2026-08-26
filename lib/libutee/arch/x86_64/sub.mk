cppflags-y += -I$(sub-dir)/../..

srcs-y += utee_syscalls_64.S

#ifneq ($(sm),ldelf)
#srcs-y += stack_guard.c
#cflags-stack_guard.c-y += -fno-stack-protector
#subdirs-y += gprof
#endif #$(sm-$(sm)-is-ld)

