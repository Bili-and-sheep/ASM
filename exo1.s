; sum_push.s — x86_64 Linux, NASM/Intel
; Affiche (digit '\n') si A+B < 10 → exit(0)
; Sinon n'affiche rien → exit(1)

; === paramètres modifiables ===
%define A  2
%define B  7

section .text
global _start
_start:
    ; AL = A + B (on travaille en 8 bits puisque ce sont des chiffres 0..9)
    mov     al, A
    add     al, B

    ; si somme >= 10 → erreur (exit 1)
    cmp     al, 10
    jae     .bad

    ; somme < 10 : convertir en ASCII et fabriquer le buffer 2 octets
    add     al, '0'        ; AL = '0' + (A+B)
    mov     ah, 10         ; AH = '\n' (LF = 10)
    movzx   rax, ax        ; remettre le haut de RAX à 0 (propre)

    ; Empiler 8 octets, mais seuls les 2 premiers nous intéressent : [AL][AH]
    ; En mémoire (little-endian) à [RSP] ça fera: digit, '\n', ...
    push    rax

    ; write(1, RSP, 2)  → affiche "digit\n"
    mov     rax, 1         ; SYS_write
    mov     rdi, 1         ; fd = stdout
    mov     rsi, rsp       ; buffer = top of stack
    mov     rdx, 2         ; length = 2 bytes
    syscall

    add     rsp, 8         ; nettoyer la pile (optionnel mais propre)

    ; exit(0)
    mov     rax, 60        ; SYS_exit
    xor     edi, edi       ; rdi=0
    syscall

.bad:
    ; exit(1)
    mov     rax, 60
    mov     edi, 1
    syscall
