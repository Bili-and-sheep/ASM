; sum64_simple.asm — NASM x86_64 Linux
; Modifie A et B, recompile, exécute.

SECTION .data
    A       db 2            ; <-- change ici
    B       db 7            ; <-- change ici
    outbuf  db '0', 10      ; ASCII résultat + '\n'
    outlen  equ $ - outbuf

SECTION .text
    global _start

_start:
    ; al = A
    movzx   eax, byte [rel A]
    ; al += B
    add     al, byte [rel B]

    ; si somme >= 10 → exit(1)
    cmp     al, 10
    jae     .bad

    ; somme < 10 : convertir en ASCII et écrire
    add     al, '0'                     ; 0x30
    mov     [rel outbuf], al

    ; write(1, outbuf, outlen)
    mov     rax, 1                      ; SYS_write
    mov     rdi, 1                      ; stdout
    lea     rsi, [rel outbuf]
    mov     rdx, outlen
    syscall

    ; exit(0)
    xor     edi, edi                    ; code 0
    mov     rax, 60                     ; SYS_exit
    syscall

.bad:
    ; exit(1)
    mov     edi, 1
    mov     rax, 60
    syscall