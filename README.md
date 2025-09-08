```bash
nasm -f elf64 FileName.asm -o FileName.o
```

```bash
ld FileName.o -o FileName 
```

```bash
./FileName 
```

```bash
echo $?
```

```bash
objdump -M intel FileName.out -d
```
