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
	
	; Inicio
	msg_estado1 DWORD "========================================="
	msg_estado1 DWORD "|| a || b || c ||---|| d || e || f || g ||"
	msg_estado1 DWORD "========================================="


	; Cambio
	msg_estado1 DWORD "========================================="
	msg_estado1 DWORD "|| %s || %s || %s ||---|| %s || %s || %s || %s ||"
	msg_estado1 DWORD "========================================="



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







	ret
main endp
end











