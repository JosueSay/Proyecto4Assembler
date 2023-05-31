; Universidad del Valle de Guatemala
; Josue Say - 22801, Mathew Cordero - 22982, Javier Chen - 22153, Pedro Guzman - 22111
; Descripcion; Mostrar menu del juego
; 24/05/2023

;============
;|| HEADER ||
;============
.386
.model flat, stdcall, C
.stack 4096

;==========
;|| DATA ||
;==========
.data
	;======================================
	; || Variables para mostrar opciones ||
	;======================================
	saltodelinea byte " ",0Ah,0
	msg_bienvenida BYTE "Bienvenido al juego de ranas. Escoge la opcion que desees:",0Ah ,0
	msg_opcion1 BYTE "Opcion 1. Ingresar al juego", 0Ah, 0
	msg_opcion2 BYTE "Opcion 2. Brindar instrucciones",0Ah ,0
	msg_opcion3 BYTE "Opcion 3. Salir del juego", 0Ah, 0
	respuesta_menu BYTE 0
	n DWORD 7 ;numero de ranas
	fmt3 byte "%d",0Ah,0
	;==========================================
	;|| Variables para mostrar instrucciones ||
	;==========================================
	msg_instrucciones1 BYTE "El juego consta de mover 3 ranas del mismo color al lado contrario de su posición inicial.", 0
	msg_instrucciones2 BYTE "Las ranas del color AZUL son 'a' y las ranas de color ROJO son 'b'.", 0Ah,0
	msg_instrucciones3 BYTE "Toma en cuenta lo siguiente:", 0Ah,0
	msg_instrucciones4 BYTE "\ti.	Las ranas no pueden retroceder", 0Ah,0
	msg_instrucciones5 BYTE "\tii.	Solo pueden moverse un espacio a la vez.", 0Ah,0
	msg_instrucciones6 BYTE "\tiii.	Las ranas de distinta especie pueden saltarse otra rana si existe un espacio vacio adelante.", 0Ah,0
	msg_instrucciones7 BYTE "\tiv.	Sin embargo, las ranas de la misma especie no pueden saltarse entre ellas.", 0Ah,0

	msg_estadoI1 BYTE "=================================================",0Ah,0
	msg_estadoI2 BYTE "|| a || a || a ||---|| b || b || b ||",0
	msg_posiciones BYTE "|| 1 |||| 2 |||| 3 |||| 4 |||| 5 |||| 6 |||| 7 ||",0Ah,0
	msg_estadoI3 BYTE "=================================================",0Ah,0
	
	listanumer DWORD 2,0,1,1,1,2,2
	;===========
	;|| RANAS ||
	;===========
	; Ranas de la izquierda
	ranasA BYTE  " a ", 0
	; Espacio entre ranas
	espacio BYTE "---", 0
	; Ranas de la derecha
    ranasB BYTE  " b ", 0
	espaciado BYTE "||",0
	; Constante de formato para la función scanf
	fmt db "%d", 0
	
;==========
;|| CODE ||
;==========
.code
main proc
	; Declaración de librerias y funciones
	includelib libucrt.lib
	includelib legacy_stdio_definitions.lib
	includelib libcmt.lib
	includelib libvcruntime.lib

	extrn printf:near
	extrn scanf:near
	extrn exit:near

menuprincial:

	push OFFSET saltodelinea
	call printf
	add esp, 4

	push OFFSET msg_bienvenida
	call printf
	add esp, 4

	push OFFSET msg_opcion1
	call printf
	add esp, 4

	push OFFSET msg_opcion2
	call printf
	add esp, 4

	push OFFSET msg_opcion3
	call printf
	add esp, 4

	
	; Adquiere la respuesta del usuario
	push OFFSET respuesta_menu
	push OFFSET fmt
	call scanf
	add esp, 8

	

	; Selecccion de opcion

	.IF respuesta_menu == 2
		call Printinstrucciones
		jmp menuprincial ;hacemos que regrese al menu principal.
	.ELSEIF respuesta_menu == 1 ;si es la uno comenzamos el juego
		call arrayPrint
		jmp menuprincial ;hacemos que regrese al menu principal.
	.ENDIF
	
	

	finalizar:
		push 0
		call exit
	ret
main endp

Printinstrucciones proc ;subrutina
	push ebp
    mov ebp, esp
    push esi
	
	push OFFSET msg_instrucciones1
	call printf
	add esp, 4
	
	push OFFSET msg_instrucciones2
	call printf
	add esp, 4

	push OFFSET msg_instrucciones3
	call printf
	add esp, 4
	
	push OFFSET msg_instrucciones4
	call printf
	add esp, 4
	
	push OFFSET msg_instrucciones5
	call printf
	add esp, 4
	
	push OFFSET msg_instrucciones6
	call printf
	add esp, 4

	push OFFSET msg_instrucciones7
	call printf
	add esp, 4

	pop esi
    mov esp, ebp
	pop ebp
	ret
Printinstrucciones endp

arrayPrint proc ;subrutina
	push offset msg_estadoI1		; Pasar el otro espaciado
	call printf	
	add esp, 4

	push ebp
    mov ebp, esp
    push esi
    
    mov esi, offset listanumer
    mov ebx, sizeof listanumer
label1:

	push offset espaciado		; Pasar el otro espaciado
	call printf	
	add esp, 4
	mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax
	.IF eax == 1 ;si es una rana A	
		push offset ranasA		; imprime rana A
		call printf	
		add esp, 4
		
	.ELSEIF eax == 2
		push offset ranasB		; Imprime rana B
		call printf	
		add esp, 4

	.ELSEIF eax == 0
		push offset espacio		; Imprime rana B
		call printf	
		add esp, 4
	.ENDIF
	push offset espaciado		; espaciado 
	call printf	
	add esp, 4
    
	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	cmp ebx,0			; Aún hay elementos en el array?
	jne label1			; Sí, entonces repetir proceso desde label1
	
	push offset saltodelinea		; Pasar el otro espaciado
	call printf	
	add esp, 4

	
	push offset msg_posiciones		; Pasar el otro espaciado
	call printf	
	add esp, 4

	push offset msg_estadoI3		; Pasar el otro espaciado
	call printf	
	add esp, 4

    pop esi
    mov esp, ebp
	pop ebp
    ret
arrayPrint endp

end