GLOBAL _start

SECTION .rodata
  message db "Hello, World!", 0x0A
  .length equ $-message

  ; system calls
  __NR_WRITE equ 1
  __NR_EXIT  equ 60

  ; file descriptors
  STDOUT     equ 1

SECTION .text
  _start:
    mov rax, __NR_WRITE
    mov rdi, STDOUT
    lea rsi, [rel message]  ; the buffer to write
    mov rdx, message.length ; the length of the buffer
    syscall

    ; Since only rax, rcx and r11 are preserved, the length of
    ; the message remains in rdx and this enables us to directly
    ; compare the return value with the expected value (the length).
    ; This saves us one instruction. Includes a conditional
    ; move instead of a jump which acounts avoid a branch.

    xor rdi, rdi       ; default exit code (zero).
    mov rcx, 1         ; error exit code (1, non-zero).
    cmp rax, rdx       ; check if bytes written == length.
    cmovne rdi, rcx    ; non-zero exit code if bytes written != length.

    mov rax, __NR_EXIT
    syscall

