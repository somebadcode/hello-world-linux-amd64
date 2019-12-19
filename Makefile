ASM=nasm
LD=ld
LDFLAGS=--strip-all -static --no-dynamic-linker --pic-executable 

all: hello

main.o: src/main.asm
	@mkdir --parent ./build
	@$(ASM) -f elf64 -o build/main.o src/main.asm

hello: main.o
	@mkdir --parent ./bin
	@$(LD) $(LDFLAGS) --output bin/hello build/main.o

clean:
	@rm --recursive --force ./bin ./build

run: hello
	@bin/hello
