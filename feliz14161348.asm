
SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
	msg1 db "ingrese un numero", 0xA,0xD
	len1 equ $- msg1
	
	salida1 db "Es Feliz :)", 0xA, 0xD
	lnsalida1 equ $- salida1
	
	salida2 db "No es Feliz :(", 0xA, 0xD
	lnsalida2 equ $- salida2
	
	infelices db 17, 25, 29, 50, 58, 85, 89
	lninfelices equ $- infelices
	
	felices db 0, 0
	len equ $-felices

	felices2 db 0, 0
	lenfelices2 equ $-felices2
	
segment .bss
	sumacuadrados resb 2
	resdiv resb 2
	reciduo resb 2
	cuadrado1 resb 2
	cuadrado2 resb 2
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
    
    mov esi, felices ;arreglo de numeros felices
    mov edi, 0 ; contador del arreglo
   
   digitos:
      ;guardamos los numeros felices en el arreglo
      mov al, [num1+edi]
      sub al, '0'
      mov [esi+edi], al
   
      add edi, 1
	
      mov al, [num1+edi]
      sub al, '0'
      mov [esi+edi], al
      
      cmp edi, len1
      
    jb digitos
      ;========================
      
      mov ebp, felices ;movemos el arreglo
      mov edi , 0 ; contador
      
      ciclo:
      
      mov ax, [ebp+edi]
      mul ax
      mov [cuadrado1], ax
      
      add edi, 1
      
      mov ax, [ebp+edi]
      mul ax
      mov [cuadrado2], al
        
    ;suma de los cuadrados
      mov eax, [cuadrado1]
      ;sub eax, 48
      mov ebx, [cuadrado2]
      ;sub ebx, 48
      add eax, ebx ; sumamos los cuadrados
      ;add eax, '0'
      mov [sumacuadrados], eax ; guardamos la suma en num1
      
      ;mov [num1], [sumacuadrados]
      
      mov ah, 0
      mov al, [sumacuadrados]
      
      cmp al, 1
   
      je salir
      
      mov ebp, infelices
      mov edi, 0
      
      cicloinfelices:

	cmp al, [ebp+edi]
	je salir2
      
	add edi, 1
	
	cmp edi, lninfelices
      
      jb cicloinfelices
      
      
      mov dl, 10
      div dl

      ;add al, '0'
      mov [felices2+0], al

      ;add ah, '0'
      mov [felices2+1], ah

      mov ebp, felices2
      mov edi,0
    
      mov ebp, felices2
      mov edi, 0
    
    mov ebp, felices2
    mov edi,0

    
 jmp ciclo
  
    salir:
    
     mov eax, 4
     mov ebx, 0
     mov ecx, salida1
     mov edx, lnsalida1
     int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
    salir2:
    
     mov eax, 4
     mov ebx, 0
     mov ecx, salida2
     mov edx, lnsalida2
     int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
    