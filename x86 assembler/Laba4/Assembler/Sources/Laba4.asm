	model SMALL											; Определение типа модели памяти

	stack 100h											; Определение сегмента стека размером 256 байт
	dataseg												; Определение сегмента данных
	input_message db 0Ah,0Dh,'Enter the line:',0Ah,0Dh,'$'	; 
	output_message db 0Ah,0Dh,'Result:',0Ah,0Dh,'$'			; 
	BUFFER db 100 dup('$')									; Буфер ввода
	MUSOR db 100 dup('$')									; Дополнительная строковая переменная
	codeseg												; Определение сегмент кода
START:
	mov AX, @DATA										; В регистра AX смещение для данных
	mov DS, AX											; Установить регистр DS равный AX то ест теперь там смещение
	lea DX,input_message                          	    ; Адрес output_message строки – в DX
	mov AH,09h 											; Номер функции – в AH (вывод)
	int 21h												; Вызов функции
	lea DX,BUFFER										; Адрес буфера – в DX
	mov AH,0Ah 											; Номер функции – в AH (ввод)
	int 21h  											; Вызов функции
	xor AX, AX											; Очистить значение региста AX
	lea BX, BUFFER+2									; В BX адрес BUFFER строки смещенный на 2 (введенная строка)
	xor CX, CX                                          ; Очистить значение региста СX
	mov CL,BUFFER+1										; В CX записать длину строки
	mov SI, 0											; SI = 0
	mov DI, CX											; DI = длина строки
	dec DI												; DI = DI - 1 (индекс последнего символа строки)
SWAP:
    cmp SI, DI											; Сравниваем SI и DI
    jns PRINT_RESULT									; Если SI>=DI переходим по метке (SF = 0)

    mov AL, [BX+SI]										; AL = символ SI смещения
    xchg AL, [BX+DI]									; Меняем значение AL и символ SI смещения
    mov [BX+SI], AL										; символ SI смещения = символ SI смещения до изменения

    inc SI												; SI = SI + 1
    dec DI												; DI = DI - 1	
    jmp SWAP											; Переход по метке SWAP

PRINT_RESULT:
    mov AH, 09h											; Номер функции – в AH (вывод)
    lea DX, output_message								; Адрес output_message строки – в DX
    int 21h												; Вызов функции
	
    mov AH, 09h											; Номер функции – в AH (вывод)
    lea DX, BUFFER+2									; Адрес BUFFER строки смещенный на 2 – в DX
    int 21h												; Вызов функции
	
	lea DX,MUSOR										; Адрес MUSOR строки – в DX
	mov AH,0Ah 											; Номер функции – в AH
	int 21h  											; Вызов функции
QUIT: 
	exitcode 0											; Возврат управления операционной системе, код возврата 0
	end													; Конец программы