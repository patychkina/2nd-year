	model  SMALL
	stack  100h
dataseg
	Ask1  db 0Ah,0Dh,'Enter first:$'	; приглашение на ввод первого числа
	Ask2  db 0Ah,0Dh,'Enter second:$'	; приглашение на ввод второго числа ;
	Zero db 0h                       	; байтовая переменная = 0
	Empty db '$'						; переменная пустой строки
	Buf1  db 11
	Len1  db ?							; длина 1 строки
    str1 db 100 dup( ? )				; буфер 1
    Buf2  db 11
	Len2  db ?							; длина 2 строки
    str2 db 100 dup( ? )				; буфер 2
	AskCont db 0Ah,0Dh
	db 'Exit - Esc, Next - all '
	db '$'
	ResT  db 0Ah,0Dh,'Result: $'		; приглашение на вывод результата 
	LenR  db 0							; длина строки результата
    strR db 100 dup( ? )				; буфер строки результата
codeseg
startupcode

BEGIN1:
	mov AX, @DATA				; В регистра AX смещение для данных
	lea  DX, Ask1 				; в DX занести адрес строки
	mov  AH, 09h 				; в АН занести номер функции (вывод)
	int  21h  					; вызов прерывания 
	
    lea DX, Buf1				; Ввод первой строки
    mov AH, 0Ah
    int 21h
	
	cmp  Len1, 0 				; сравниваем длину строки 1 с нулем
	je  BEGIN1					; если равен нулю, то вводим заново

BEGIN2:
	lea  DX, Ask2 				; в DX занести адрес строки
	mov  AH, 09h 				; в АН занести номер функции (вывод)
	int  21h  					; вызов прерывания 
	
    lea DX, Buf2				; Ввод второй строки
    mov AH, 0Ah
    int 21h

	cmp  Len2, 0 				; сравниваем длину строки 2 с нулем
	je  BEGIN2					; если равен нулю, то вводим заново
	
	xor CX, CX					; обнуляем CX
	xor BX, BX					; обнуляем BX
	xor AX, AX					; обнуляем AX
	lea BX, str1				; загружаем в BX srt1
	mov CL, Len1				; загружаем в CL длину первой строки
	mov DI, 0					; DI = 0
LOOP_STR:
	mov AL, [BX][DI] 			; загружаем текущий символ из str1 в AL
    lea SI, str2 				; устанавливаем SI на начало str2
    
    call remove_char			; вызываем подпрограмму remove_char

    inc DI 						; увеличиваем BX для перехода к следующему символу str1
    loop LOOP_STR 				; продолжаем цикл, пока не обработаем все символы

	lea     DX, ResT			; Вывод продложения для результата
	mov     AH, 09h 
	int     21h 
	
	xor DX,DX					; обнуляем регистр DX
	mov DL, LenR				; в DL загружаем длину строки результата
	cmp DL, Zero				; сравниваем длину строки результата с нулем
	je output1					; если длина = 0 выводим пустую строку
	jmp output2					; если длина != 0 выводим результат
	
output1:						; Вывод пустой строки
	xor DX,DX
	lea DX, Empty				
    mov AH, 09h	
    int 21h
	jmp CONTINUATION
	
output2:						; Вывод результата после удаления символов
	xor DX,DX
    lea DX, str2
    mov AH, 09h
    int 21h


CONTINUATION:					;Запрос на продолжение работы 
	xor DX,DX
	lea     DX, AskCont 
	mov     AH, 09h 
	int     21h 
	mov     AH, 08h 
	int     21h 
	cmp     AL, 27  			;ESC 
	je      QUIT 
	jmp     BEGIN1 				;Конец работы 
QUIT:   
exitcode  0 

; Процедура remove_char
; Удаляет все вхождения определенного символа из строки str1 и сохраняет результат в str2
; Вход:
;   - str1: исходная строка, из которой нужно удалить символ
;   - Len1: длина исходной строки str1
;   - AL: символ, который нужно удалить из str1
; Выход:
;   - str2: результат удаления символа из str1
;   - LenR: обновленная длина строки str2
; Регистры:
;   - Используемые регистры: SI, DI, CX, BX, AL, DL
;   - Измененные регистры: SI, DI, CX, BX, AL, DL
;   - Сохраненные регистры: BX, CX
remove_char proc near
	push CX      				; Сохраняем регистр CX
    push DI      				; Сохраняем регистр DI
    push BX      				; Сохраняем регистр BX

    xor CX, CX       			; CX будет счетчиком для подсчета удаленных символов
    mov DI, 0       			; DI будет указывать на текущий символ для проверки
    xor DX, DX					; обнуляем регистр DX
	mov AH, 0					; заносим 0 в регистр AH, для счета длины новой строки
    lea BX, strR       			; BX будет указывать на текущий символ для записи
    mov CL, Len2				; загружаем в CL длину второй строки

    remove_loop:
		mov DL, byte ptr[SI]	; в DL заносим текущий символ строки
		cmp AL, DL				; сравниваем символы первой и второй строки
		je skip_char			; если равны переходим по метке
		mov [BX][DI], DL		
		inc DI
		inc AH
		
	skip_char:
		inc SI
		loop remove_loop
    remove_done: 
		mov LenR, AH
		cmp AH, Zero			; сравниваем длину новой строки с нулем
		je next					; если длина = 0 то выходим из подпрограммы, освобождая стек
		call copy_str			; иначе меняем местами str2 и strR
	next:
		pop BX       			; Восстанавливаем регистр BX
		pop DI       			; Восстанавливаем регистр DI
		pop CX       			; Восстанавливаем регистр CX
		ret
remove_char endp

; Процедура copy_str
; Копирует содержимое строки strR в строку str2 и обновляет её длину
; Вход:
;   - strR: исходная строка, которую нужно скопировать
;   - LenR: длина исходной строки strR
; Выход:
;   - str2: копия строки strR
;   - Len2: обновленная длина строки str2
; Регистры:
;   - Используемые регистры: SI, DI, CX, AL, DL
;   - Измененные регистры: SI, DI, CX, DL
;   - Сохраненные регистры: CX
; Примечание: Строки str2 и strR должны быть null-terminated, т.е. завершаться символом '$'
copy_str proc near
push CX
    lea SI, str2     			; устанавливаем SI на начало str2
    lea DI, strR     			; устанавливаем DI на начало strR
    xor CX, CX       			; обнуляем счетчик
	mov CL, LenR				; загружаем в регистр CX длину strR

COPY_LOOP:
    mov AL, [DI]     			; загружаем текущий символ из str2 в AL
    mov [SI], AL     			; копируем символ в strR
    inc SI           			; увеличиваем SI для перехода к следующему символу str2
    inc DI           			; увеличиваем DI для перехода к следующему символу strR

    loop COPY_LOOP   			; продолжаем цикл

COPY_DONE:
    mov DL, LenR				; заменяем значение длины второй строки на новое значение
	mov Len2, DL				
	mov byte ptr [SI], '$' 		; устанавливаем знак завершения строки в конце str2
	pop CX
	ret
copy_str endp
end