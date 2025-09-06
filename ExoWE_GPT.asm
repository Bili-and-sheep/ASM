; add_write.asm
; NASM x86-64 Linux
; Calcule A + B, affiche le chiffre résultat, puis exit(0)

%define A 2           ; premier opérande (0..9)
%define B 2           ; second  opérande (0..9)

section .bss
outbuf  resb 2         ; [chiffre][\n]

section .text
global _start

_start:
    ; somme dans RAX
    mov     rax, A
    add     rax, B            ; rax = A + B

    ; conversion en ASCII : '0' (=0x30) + valeur
    add     al, '0'           ; seul l'octet bas (AL) nous intéresse

    ; préparer le buffer à écrire: chiffre + newline
    mov     [outbuf], al
    mov     byte [outbuf+1], 10

    ; syscall write(1, outbuf, 2)
    mov     rax, 1            ; SYS_write
    mov     rdi, 1            ; fd = stdout
    mov     rsi, outbuf       ; buffer
    mov     rdx, 2            ; longueur = 2 (chiffre + '\n')
    syscall

    ; exit(0)
    mov     rax, 60           ; SYS_exit
    xor     rdi, rdi          ; code de retour = 0
    syscall
