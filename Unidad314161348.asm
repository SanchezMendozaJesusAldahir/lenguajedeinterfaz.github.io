SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
	msg1 db "ingrese un numero", 0xA,0xD
	len1 equ $- msg1

segment .bss
	num1 resb 2

section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point

    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80
	
    mov eax, SYS_LEE
    mov ebx, STDIN
    mov ecx, num1
    mov edx, 2
    int 0x80

while:
   
    mov di, 2
    mov al, [num1]
    sub al, 48
    mov dx, 0
    div di
    cmp dx,0
 
    je espar
	mov al, [num1]
        sub al, 48
	mov bl, 3
	mul bl
        add al, 1
	add al, '0'
	mov [num1], al
	
	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, num1
	mov edx, 2
	int 0x80

    espar:
	mov al, [num1]
        sub al, 48
	mov bl, 2
	div bl
	add al, '0'
	mov [num1], al
        
        mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, num1
	mov edx, 2
	int 0x80

   mov bl, [num1]
   sub bl, 48
   cmp bl,1

ja while

  ;mov eax, SYS_PRINT
  ;mov ebx, STDOUT
  ;mov ecx, num1
  ;mov edx, 2
  ;int 0x80

salir:
    mov eax, SYS_SALIDA
    int 0x80
