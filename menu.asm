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
	msg_bienvenida BYTE "Bienvenido al juego de ranas. Escoge la opcion que desees:".
	respuesta_menu BYTE 0
	msg_opcion1 BYTE "Opcion 1. Ingresar al juego"
	msg_opcion2 BYTE "Opcion 2. Brindar instrucciones"
	msg_opcion3 BYTE "Opcion 3. Salir del juego"
	
	
	;==========================================
	;|| Variables para mostrar instrucciones ||
	;==========================================
	msg_instrucciones BYTE "El juego consta de mover 3 ranas del mismo color al lado contrario de su posición inicial. "
	 
	msg_estadoI1 BYTE "======================================",0
	msg_estadoI2 BYTE "|| a || b || c ||---|| d || e || f ||",0
	msg_estadoI3 BYTE "======================================",0
	
	lista_msg_estados DWORD msg_estadoI1, msg_estadoI2, msg_estadoI3
	
	
	;===========
	;|| RANAS ||
	;===========
	; Ranas de la izquierda
	ranaB1 BYTE "a",0
	ranaB2 BYTE "b",0
	ranaB3 BYTE "c",0
	; Espacio entre ranas
	espacio
	; Ranas de la derecha
	ranaC1 BYTE "d",0
	ranaC2 BYTE "e",0
	ranaC3 BYTE "f",0
	
	

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



	

	finalizar:
		call exit

	ret
main endp
end











