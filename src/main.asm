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

    ; Since all register except rax, rcx and r11 are preserved, the length of
    ; the message is still stored inside rdx and this enables us to directly
    ; compare the return value with the expected value (the length). This saves
    ; us one instruction below.
    ; In addition, a conditional move instead of a jump enables us to avoid
    ; a branch.

    xor rdi, rdi       ; default exit code
    mov rcx, 1         ; error exit code
    cmp rax, rdx       ; check if bytes written == length
    cmovne rdi, rcx    ; non-zero exit code if bytes written != length

    mov rax, __NR_EXIT
    syscall
