ASM=nasm
LD=ld
LDFLAGS=--strip-all -static --no-dynamic-linker --pic-executable 

all: hello

main.o: src/main.asm
	@mkdir ./build
	@$(ASM) -f elf64 -O0 -o build/main.o src/main.asm

hello: main.o
	@mkdir ./bin
	@$(LD) $(LDFLAGS) --output bin/hello build/main.o

clean:
	@rm --recursive --force ./bin ./build

run: hello
	@bin/hello
