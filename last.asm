section .text
    global _start

print:
    push rbp        ;prologue
    mov rbp, rsp

    mov rax, 1      ; syscall: write
    mov rdi, 1      ; file descriptor: stdout
    push 0x30      ; push '0' character
    mov rsi, rsp    ; pointer to buffer
    mov rdx, 8      ; number of bytes
    syscall
    
    leave           ;epilogue
    ret

_start:
    call print
exit:
    ; push rbp
    ; mov rbp, rsp

    mov rax, 60     ; syscall: exit
    mov rdi, 0      ; status: 0
    syscall
