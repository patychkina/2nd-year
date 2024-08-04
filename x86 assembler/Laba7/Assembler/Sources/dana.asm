Laboratory task 7, 5th variant 
model small
.486 ;директива разрешает ассемблирование инструкций процессора        
stack 100h        
dataseg      
; Переменные для A                
askA        db 'Enter the number A: $'
bufA          db 10
lenA        db ?
bufferA         db 10 dup(?)
A           dq 0
; Переменные для B  
askB        db 'Enter the number B: $' 
bufB          db 10
lenB        db ?
bufferB         db 10 dup(?)
B           dq 0
; Переменные для Е 
askE        db 'Enter the number E: $'
bufE          db 10
lenE        db ?
bufferE         db 10 dup(?)
E           dq 0
; Переменные для результата
isError      db 'The equation has no roots on a given segment.$'
isSuccess    db 'The root of the equation is $'
result      db 10 dup(?) 
root        dq 0 
; Вспомогательные переменные
num         dq 2
y1          dq 0
y2          dq 0
y1y2        dq 0
isEnter      db 0Dh, 0Ah, '$'    

codeseg
start:
	startupcode            
	finit  ;инициализация сопроцессора
enterAB:
    ;Ввод А        
	mov AH, 09h
    lea DX, askA
    int 21h

	mov AH, 0Ah
    lea DX, bufA
    int 21h
	
	mov AH, 09h
    lea DX, isEnter
    int 21h
     
	;Ввод В 	 
	mov AH, 09h
    lea DX, askB
    int 21h
           
	mov AH, 0Ah
    lea DX, bufB
    int 21h
           
	mov AH, 09h
    lea DX, isEnter
    int 21h
            
	push offset A
	push offset bufferA
	call StrToDouble
	
	push offset B
	push offset bufferB
	call StrToDouble
	
	fld A 
	fld B
	fcom 
	fstsw AX   
	sahf
	jb enterAB 

enterE:  
	;вводим Е        
	mov AH, 09h
	lea DX, askE
	int 21h

	mov AH, 0Ah
	lea DX, bufE
	int 21h

	mov AH, 09h
	lea DX, isEnter
	int 21h			
            
	push offset E
	push offset bufferE
	call StrToDouble
	
	fld E
	ftst 
	fstsw ax 
	sahf
	jbe enterE 
 
checkRoot: ;проверка на сходимость f(a)*f(b)<0
	fld A
	call function
	fst y1 

	
	fld B 
	call function
	fst y2 
	
	fld y1 
	fld y2 
	fmul 

	fst y1y2 
	fcom
	fstsw ax 
	sahf
	ja endNoRoot 
            
find_root:                       
	call findRoot
	fst root 
	push offset result
	push offset root
	call DoubleToStr 

	mov AH, 09h
	lea DX, isSuccess
	int 21h

	mov AH, 09h
	lea DX, result
	int 21h

	jmp quit

            
endNoRoot:
	mov AH, 09h
	lea DX, isError
	int 21h

quit: 
	mov AH, 0Ah
	lea DX, bufA
	int 21h
	mov AH, 09h
	
	lea DX, isEnter
	int 21h
	exitcode 0


;Действие: 
	;Нахождение корня функции на отрезке методом деления отрезка пополам с точностью E
;Параметры:
	;Входные параметры: ST(0) <- E, ST(1) <- A, ST(2) <- B
;Возвращает:
	;ST(0)

;Подпрограмма для нахождения корня уравнения			
findRoot proc near
startDo:
checkLoop:          
	fld B ;добавить в ST(0)  B
	fld A ;добавить в ST(0) A
	fsub ;записать в ST(0) A-B
	fld E ;добавить в ST(0) E           
	fcom ;сравнить ST(0) и ST(1)
	fstsw ax ;загрузить регистр SWR в AX
	sahf ; загрузить AH в младший байт регистра флагов
	ja endDo
	fld A
	call function
	fst y1 ;y1 <- ST(0)
	fld A 
	fld B
	fadd  ;записать в ST(0) A+B
	fild num  ;добавить в ST(0) 2
	fdiv ;записать в ST(0) (A+B)/2    
	fst root ;root <- ST(0)
	
	fld root ;ST(0)<- root 
	call function  
	fst y2 ;y2 <- ST(0)
	
	fld y1 ;ST(0)<- y1
	fld y2 ;ST(0)<- y2
	fmul ;ST(0)<- y1*y2
	fst y1y2 ;y1y2 <- ST(0)
	fcom ;сравнить ST(0) и ST(1)
	fstsw ax   ;загрузить регистр SWR в AX
	sahf ; загрузить AH в младший байт регистра флагов
	ja lessZero
	
	jmp moreZero
lessZero:            
	fld root ;ST(0)<- root 
	fst A ;A <- ST(0)
	jmp startDo
	
moreZero:            
	fld root ;ST(0)<- root 
	fst B  ;B <- ST(0)
	jmp startDo
	
endDo:
	fld A ;добавить в ST(0) A
	fld B ;добавить в ST(0)  B
	fadd  ;записать в ST(0) A+B
	fild num  ;добавить в ST(0) 2
	fdiv ;записать в ST(0) (A+B)/2 
	ret
findRoot endp


; Подпрограмма, выполняющая вычисление функции f(x)=x^3–8x^2+x+42
;Действие: 
	;Вычисляет функцию от заданного значения
;Параметры:
	;Входные параметры: ST(0)
;Возвращает:
	;ST(0)  
function proc near
	push bp 
	mov bp, sp ;заносим вершину стека
	sub sp, 8 ;выделяем 8 байт стека
	
	fst qword ptr[bp-8] 
	fld qword ptr[bp-8] 

	fmul qword ptr[bp-8]
	fmul qword ptr[bp-8] 
	fxch st(1) ;Обмен вершины стека ST(0) с другим регистром стека ST(I)


	sub sp, 2

	mov word ptr[bp-10], 8
	fild word ptr[bp-10] ;Загрузка числа из памяти в вершину стека сопроцессора

	fmul qword ptr[bp-8]
	fmul qword ptr[bp-8]
	fchs ;меняем знак                       

	faddp st(2), st(0)  ;Сложение ST(i) и ST(0) с выталкиванием значения из ST(0). Результат помещается в ST(i – 1)


	mov word ptr[bp-10], 1
	fild word ptr[bp-10] ;Загрузка числа из памяти в вершину стека сопроцессора    

	fmul
	faddp                       
	
	mov word ptr[bp-10], 42
	fild word ptr[bp-10]
	fadd                       

	add sp, 2
	add sp, 8
	pop bp
	ret
function endp
function proc near
	push bp 
	mov bp, sp ;заносим вершину стека
	sub sp, 8 ;выделяем 8 байт стека
	fst qword ptr [bp-8] ; сохраняем значение из вершины стека в локальной переменной

    fld qword ptr [bp-8] ; загружаем значение обратно в вершину стека
    fmul ST(0), ST(0)    ; умножаем x на x (x^2)
    fst ST(3)            ; копируем x^2 в четвертую позицию стека

    mov word ptr [bp-10], 7
    fild word ptr [bp-10] ; загружаем 7 в вершину стека
    fmul ST(3), ST(0)     ; умножаем x^2 на 7

    mov word ptr [bp-10], 9
    fild word ptr [bp-10] ; загружаем 9 в вершину стека
    fmul ST(2), ST(0)     ; умножаем x на 9

    fsubp                ; вычитаем 9x из 7x^2

    fld qword ptr [bp-8] ; загружаем x обратно в вершину стека
    fmul ST(0), ST(0)    ; умножаем x на x (x^2)
    fmul ST(0), ST(0)    ; умножаем x^2 на x (x^3)
    fsubp                ; вычитаем x^3 из предыдущего результата


    mov word ptr [bp-10], 49 ; загружаем 49 в вершину стека
    fild word ptr [bp-10] ; загружаем 49 в вершину стека
    fsubp                ; вычитаем 49 из предыдущего результата



    add sp, 8            ; освобождаем выделенное место на стеке

	pop bp
	ret
function endp

;Подпрограмма для перевода вещественного типа к строковому
DoubleToStr proc near
	push bp
	mov bp, sp
	sub sp, 4 
	push ax bx dx cx di
	pushf
	fnstcw [bp-4] 
	fnstcw [bp-2] 

	and word ptr [bp - 2], 1111001111111111b 
	or word ptr [bp - 2], 0000110000000000b
	fldcw [bp - 2] 
	mov bx, [bp + 4]
	fld qword ptr[bx] 
	ftst
	fstsw ax
	and ah, 1
	cmp ah, 1
	jne @@NBE
	mov bx, [bp + 6]
	mov byte ptr[bx], '-'
	inc word ptr[bp + 6]
            
@@NBE: 
	fabs
	fst st(1)
	fst st(2)
	frndint
	fsub st(2), st(0)
	mov word ptr[bp - 2], 10
	fild word ptr[bp - 2]
	fxch st(1)
	xor cx, cx
	
@@BG: 
	fprem
	fist word ptr [bp - 2]
	push word ptr [bp - 2]
	fxch st(2)
	fdiv st(0), st(1)
	frndint
	fst st(2)
	inc cx
	ftst 
	fstsw ax 
	sahf 
	
	jnz @@BG ; если 14 бит SR == 0 (6 бит AH) (если zf == 0 прыжок)
	mov ax, cx
	mov bx, [bp + 6]
	
@@BFG: 
	pop dx
	add dx, '0'
	mov byte ptr[bx], dl
	inc bx
	loop @@BFG
	fxch st(3)
	fst st(2)
	ftst
	fstsw ax
	sahf
	jz @@CNE
	mov byte ptr[bx], '.'
	mov cx, 16
	
@@BFR: 
	fmul st(0), st(1)
	fst st(2)
	frndint
	fsub st(2), st(0)
	fist word ptr [bp - 2]
	fxch st(2)
	mov ax, [bp - 2]
	add ax, '0'
	inc bx
	mov byte ptr[bx], al
	loop @@BFR
	
@@NIL: 
	cmp byte ptr[bx], '0'
	jne @@CNR
	dec bx
	jmp @@NIL
	
@@CNR: 
	inc bx
	
@@CNE: 
	mov byte ptr[bx], '$'
	fstp st(0)
	fstp st(0) 
	
	fstp st(0)
	fstp st(0)
	fldcw [bp - 4] 
	popf
	pop di cx dx bx ax
	add sp, 4
	pop bp
	ret
DoubleToStr endp

;Подпрограмма для перевода строкового типа к вещественному
StrToDouble proc near
	push bp
	mov bp, sp
	sub sp, 2 
	push ax bx dx cx di
	pushf
	mov word ptr[bp - 2], 10 
	fild word ptr[bp - 2] 
	fldz 
	mov di, 0
	mov bx, [bp + 4] 
	cmp byte ptr[bx], '-'
	jne @@BPN
	inc bx
	mov di, 1
	
@@BPN: 

	movsx ax, byte ptr [bx]
	cmp ax, '.'
	je @@PNT1
	cmp ax, 0dh
	jne @@CNT
	fxch st(1)
	fstp st(0)
	jmp @@REN
	
@@CNT: 
	sub ax, '0'
	mov word ptr[bp - 2], ax
	fmul st(0), st(1) 
	fiadd word ptr[bp - 2] 
	inc bx
	jmp @@BPN
	
@@PNT1:
	xor cx, cx
	
@@BEG: 
	inc bx 
	movsx ax, byte ptr [bx]
	cmp ax, 0dh
	je @@END
	loop @@BEG
	
@@END: 
	dec bx
	fxch st(1)
	fldz
	
@@APN: 
	movsx ax, [bx]
	cmp ax, '.'
	je @@PNT2
	sub ax, '0'
	mov word ptr[bp - 2], ax
	fiadd word ptr[bp - 2] 
	fdiv st(0), st(1)
	dec bx
	jmp @@APN
	
@@PNT2:
	fxch st(1) 
	fstp st(0) 
	faddp st(1) 
	
@@REN:
	cmp di, 1
	jne @@CYK
	fchs
	
@@CYK: 
	mov bx, [bp + 6]
	fstp qword ptr [bx] 
	popf
	pop di cx dx bx ax
	add sp, 2
	pop bp
	ret
StrToDouble endp
		end start
