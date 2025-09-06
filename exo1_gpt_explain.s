; =========================================================
; Programme assembleur NASM x86-64 Linux
; Calcule A + B, affiche le résultat (1 chiffre max), puis
; quitte avec un code de retour 0.
; =========================================================

; --- constantes : tu peux changer ces valeurs ---
%define A 2       ; premier nombre (0..9)
%define B 3       ; deuxième nombre (0..9)

; --- section mémoire réservée ---
section .bss
outbuf  resb 2    ; réserve 2 octets :
                  ; - outbuf[0] : le chiffre à afficher
                  ; - outbuf[1] : le saut de ligne '\n'

; --- section contenant le code ---
section .text
global _start     ; point d’entrée du programme (Linux démarre ici)

_start:
    ; ----------------------------
    ; Étape 1 : additionner A et B
    ; ----------------------------
    mov     rax, A        ; charge la valeur A dans le registre RAX
                          ; ex: A=2 → RAX = 2
    add     rax, B        ; ajoute B → RAX = A + B
                          ; ex: B=3 → RAX = 5

    ; ----------------------------------------
    ; Étape 2 : convertir le nombre en ASCII
    ; ----------------------------------------
    ; ASCII du chiffre '0' = 48 (0x30)
    ; Donc pour obtenir le caractère du chiffre,
    ; on fait : valeur numérique + 48
    ;
    ; Exemple : 5 + '0' = 53 → caractère '5'
    add     al, '0'       ; AL = partie basse de RAX (8 bits)
                          ; AL contient maintenant le caractère ASCII

    ; ------------------------------------------------
    ; Étape 3 : préparer le buffer pour l’affichage
    ; ------------------------------------------------
    mov     [outbuf], al  ; met le caractère (chiffre) dans outbuf[0]
    mov     byte [outbuf+1], 10  ; met '\n' (ASCII 10) dans outbuf[1]

    ; -------------------------------------------------
    ; Étape 4 : appel système write
    ; write(fd=1, buffer, taille)
    ; -------------------------------------------------
    mov     rax, 1        ; numéro du syscall = 1 (write)
    mov     rdi, 1        ; fd=1 → stdout (l’écran)
    mov     rsi, outbuf   ; adresse du buffer (notre texte)
    mov     rdx, 2        ; longueur = 2 octets (chiffre + '\n')
    syscall               ; appel du kernel Linux

    ; ---------------------------------------
    ; Étape 5 : quitter proprement le programme
    ; ---------------------------------------
    mov     rax, 60       ; numéro du syscall = 60 (exit)
    xor     rdi, rdi      ; met 0 dans RDI → code de retour = 0
    syscall               ; appel du kernel → fin du programme
