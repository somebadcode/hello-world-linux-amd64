# Hello, World!

Ever wondered what the smallest piece of assembly language code that is
required to write "Hello, World!" to standard output? Look no further!
Well, it's not the smallest piece, it does include rudimentary error handling
in case the write operation to standard output fails; for some reason.

## Requirements

### Platform
Linux for 64-bit x86

### Tools
* `nasm` (Netwide Assembler)
* `ld` (The GNU linker)
* `make` (GNU make utility)

## Build

### With make
`make`

### Without make
```
mkdir --parents --verbose ./{build,bin}
nasm -f elf64 -o build/main.o src/main.asm
ld --strip-all -static --no-dynamic-linker --pic-executable --output bin/hello build/main.o
```

The final binary will be `bin/hello`

## Run
`make run`
or
`bin/hello`
