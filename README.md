nasm -f elf64 FileName.asm -o FileName.o
ld FileName.o -o FileName
./FileName
echo $?