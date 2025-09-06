; sum64_simple.asm — NASM x86_64 Linux
; Objectif :
;   - Lire deux octets A et B (0..9 recommandés).
;   - Calculer S = A + B.
;   - Si S < 10 : afficher le caractère ASCII correspondant (S + '0'), + newline.
;                 puis exit(0).
;   - Sinon     : ne rien afficher, exit(1).
;
; Assemblage / édition de liens :
;   nasm -f elf64 sum64_simple.asm -o sum64_simple.o
;   ld sum64_simple.o -o sum64_simple
; Exécution :
;   ./sum64_simple
;   echo $status     ; (fish) 0 si OK, 1 si erreur

default rel                 ; facultatif, mais pratique pour éviter d’écrire [rel ...]
                            ; (si tu préfères garder [rel], supprime cette ligne)

SECTION .data
    ; === Variables d’entrée ===
    ; Modifie A et B puis recompile.
    ; Ce sont des octets (0..255). Utilise 0..9 pour respecter la contrainte S < 10.
    A       db 2            ; Exemple : 2
    B       db 7            ; Exemple : 7

    ; === Tampon de sortie ===
    ; outbuf[0] : le caractère ASCII du résultat (sera patché)
    ; outbuf[1] : '\n' (LF = 10)
    outbuf  db '0', 10
    outlen  equ $ - outbuf  ; = 2 octets (calculé à l’assemblage)

SECTION .text
    global _start

_start:
    ; Charger A dans eax avec extension zéro :
    ;  - 'byte [A]' lit 1 octet en mémoire
    ;  - 'movzx eax, ...' place l’octet dans eax (32 bits) et remet le reste à 0
    movzx   eax, byte [A]    ; eax = A, al = A

    ; Ajouter B (1 octet) dans al (8 bits)
    add     al, byte [B]     ; al = A + B

    ; Si la somme >= 10, on considère que c’est "non valide" et on sort avec code 1
    cmp     al, 10
    jae     .bad

    ; Somme < 10 : convertir en ASCII
    ; Un chiffre 0..9 devient '0'..'9' en ajoutant 0x30
    add     al, '0'          ; al = '0' + (A+B)

    ; Écrire ce caractère dans outbuf[0]
    mov     [outbuf], al

    ; Appel système write(1, outbuf, outlen)
    ;  rax=1 (SYS_write), rdi=1 (stdout), rsi=adresse du buffer, rdx=taille
    mov     rax, 1           ; SYS_write
    mov     rdi, 1           ; fd = stdout
    lea     rsi, [outbuf]    ; &outbuf
    mov     rdx, outlen      ; 2 octets : le chiffre + '\n'
    syscall

    ; Succès : exit(0)
    xor     edi, edi         ; rdi = 0
    mov     rax, 60          ; SYS_exit
    syscall

.bad:
    ; Échec : exit(1)
    mov     edi, 1           ; code de sortie = 1
    mov     rax, 60          ; SYS_exit
    syscall