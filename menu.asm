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
	ranaactual DWORD 0
	opcionmenu2 DWORD ?
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
	msg_instrucciones1 BYTE "El juego consta de mover 3 ranas del mismo color al lado contrario de su posición inicial.", 0Ah,0
	msg_instrucciones2 BYTE "Las ranas del color AZUL son 'a' y las ranas de color ROJO son 'b'.", 0Ah,0
	msg_instrucciones3 BYTE "Toma en cuenta lo siguiente:", 0Ah,0
	msg_instrucciones5 BYTE "I.Solo pueden moverse un espacio a la vez, y debe seleccionar el numero de posicion para saltar.", 0Ah,0
	msg_instrucciones6 BYTE "III Las ranas de distinta especie pueden saltarse otra rana si existe un espacio vacio adelante.", 0Ah,0
	msg_instrucciones7 BYTE "III.Sin embargo, las ranas de la misma especie no pueden saltarse entre ellas.", 0Ah,0
	selection BYTE "Seleccione una opcion: ",0
	ingreso BYTE "Ingrese la posicion de la rana (Es el numero debajo de la letra): ",0
	msg_posiciones BYTE "|| 0 |||| 1 |||| 2 |||| 3 |||| 4 |||| 5 |||| 6 ||",0Ah,0
	hacersaltar BYTE "Opcion 1. Hacer Saltar rana",0Ah,0
	hacersalir BYTE "Opcion 2. Volver a menu principal",0Ah,0
	listanumer DWORD 1,1,1,0,2,2,2
	msg_movnovalido BYTE "Movimiento no valido",0Ah,0

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
	
	push OFFSET saltodelinea
	call printf
	add esp, 4

	; Selecccion de opcion

	.IF respuesta_menu == 2
		call Printinstrucciones
		jmp menuprincial ;hacemos que regrese al menu principal.
	.ELSEIF respuesta_menu == 1 ;si es la uno comenzamos el juego
		jmp OPCION1 ;hacemos que regrese al menu principal.
	.ELSEIF respuesta_menu == 3
		jmp finalizar
	.ENDIF
	
OPCION1:
	
	call interfazopcion1 ;imprimimos toda la interfaz
    ;Leemos que opcion eligio
    lea eax,opcionmenu2
    push eax
    push offset fmt
    call scanf
	add esp, 8
	
	.IF opcionmenu2 == 1 ;si presiona 1 la devuelve al menu principal
		call JUEGO
		jmp OPCION1

	.ELSEIF opcionmenu2 == 2 ;si presiona 2 vuelve al menu principal
		jmp menuprincial
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



    pop esi
    mov esp, ebp
	pop ebp
    ret
arrayPrint endp

;aqui iprimimos las opciones, y tambien el array
interfazopcion1 proc
	push ebp
    mov ebp, esp
    push esi
	
	push OFFSET saltodelinea
	call printf
	add esp, 4
	
	call arrayPrint ;imprime el array


	push OFFSET hacersaltar
	call printf
	add esp, 4

	push OFFSET hacersalir
	call printf
	add esp, 4

	push OFFSET selection
	call printf
	add esp, 4
	

	pop esi
    mov esp, ebp
	pop ebp
    ret
interfazopcion1 endp

JUEGO proc ;subrutina
	push ebp
    mov ebp, esp
    push esi
	
	push OFFSET ingreso
	call printf
	add esp, 4

	;Leemos la rana
    lea eax,ranaactual
    push eax
    push offset fmt
    call scanf
	add esp, 8

	;===========AQUI MULTIPLICAMOS LA DIRECCION X4===========
    mov eax, 0
    mov eax, ranaactual
    imul eax,4
    mov ranaactual,eax
    mov esi,0
    mov ebx,0

    ;ranaactual
    mov esi,ranaactual
    ;ranaactual

	;=============VAMOS A VER SI PUEDE O NO AVANZAR LA RANA==============
    ;NOTA ojo es mejor comparar que rana es con la lista de numeros
    mov eax,0
    mov ebx,0
    mov eax,listanumer[esi]
    .IF eax == 1 ;SI ES UNA RANA A
        
        mov ebx,listanumer[esi+4] ;seleccionamos el esi anterior
        mov ecx,listanumer[esi+8] ;seleccionamos 2 espacios despues
        ;mejor comparemos con los numeros , y si usemos el siguiente numero
        .IF ebx == 0 ;si la siguiente posicion es un espacio en blanco
            mov listanumer[esi+4],1 ;la posicion en blanco le colocamos un uno
            mov listanumer[esi],0 ;donde estaba ahora estara vacio
        .ELSEIF ebx == 1 ;si enfrente de ella hay una rana de su mismo tipo
            push offset msg_movnovalido
            call printf
			add esp, 4
        .ELSEIF ecx == 0 ;osea si 2 espacios despues es un espacio en blanco
            mov listanumer[esi+8],1
            mov listanumer[esi],0
        .ELSE
            push offset msg_movnovalido
            call printf
			add esp, 4
        .ENDIF
    .ELSEIF eax == 2 ; SI ES UNA RANA B
        mov ebx,listanumer[esi-4] ;seleccionamos el esi anterior ojo se resta porque esta en la punta
        mov ecx,listanumer[esi-8] ;seleccionamos 2 espacios despues
        .IF ebx == 0 ;si la siguiente posicion es un espacio en blanco
            
            mov listanumer[esi-4],2 ;la posicion en blanco le colocamos un uno
            mov listanumer[esi],0 ;donde estaba ahora estara vacio
        .ELSEIF ebx == 2 ;si enfrente de ella hay una rana de su mismo tipo
            push offset msg_movnovalido
            call printf
			add esp, 4
        .ELSEIF ecx == 0 ;osea si 2 espacios despues es un espacio en blanco
            
            mov listanumer[esi-8],2
            mov listanumer[esi],0
        .ELSE
            push offset msg_movnovalido
            call printf
			add esp, 4
        .ENDIF
    .ENDIF
    ;====================

	pop esi
    mov esp, ebp
	pop ebp
	ret
JUEGO endp



end