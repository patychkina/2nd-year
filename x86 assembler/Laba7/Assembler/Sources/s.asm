	.model small ; memory model 
	.486 		 ; 486 processor instructions enabled 
locals __ 
stack 100h 	      

dataseg
Left dt ? 		; А 
Right dt ?      ; В 
Ex dt ? 		; Погрешность 
Root dt ? 		; Корень 
Lval dt ? 		; Значение в А 
Mval dt ? 		; Значение в М 
Rval dt ? 		; Значение в В 
mdiv dw 2 		; Переменная для деления на 2 
SNC db 0Ah,0Dh,'Sign does not change.$' 
AskCont db 0Ah,0Dh,'Continue (y/n)?$' 
binp db 40 		; Максимальное кол-во 
len1 db ? 		; Раельное кол-во 
b1d db 40 dup(?); Кол-во памяти 
Enta db 0Ah, 0Dh, 'Enter a: $' 
Entb db 0Ah, 0Dh, 'Enter b: $' 
Ente db 0Ah, 0Dh, 'Enter e: $' 
rsl db 0Ah, 0Dh, 'Result: ' 
resstr db 40 dup(?) 

	codeseg 
	start: startupcode 
finit 		; Инициализация сопроцессора 
push DS 
pop ES 		; ES = DS 

Beg: lea DX, Enta 
mov AH, 9 
int 21h 			; Вывод Enta 
lea DX, binp 		; Вводим первое число 
mov AH, 0ah 
int 21h 
push offset Left 	; (для перевода из строки в число 
					;типа long double и занесение в Left) занести в стек адрес Left 
push offset b1d 	; занести в стек адрес первого символа введенного числа 
call StrToLongDouble 

lea DX, Entb 
mov AH, 9 
int 21h 
lea DX, binp 
mov AH, 0ah 
int 21h 
push offset Right 
push offset b1d 
call StrToLongDouble 

lea DX, Ente 
mov AH, 9 
int 21h 
lea DX, binp 
mov AH, 0ah 
int 21h 
push offset Ex 
push offset b1d 
call StrToLongDouble 

Calc: lea DI, Lval 
lea BX, Mval 
lea SI, Rval 
push DI ; F(A) 
push offset Left 		; A 
call CubicFunc 			; Вычисляем F(A) и заносим в DI 
push SI 
push offset Right 
call CubicFunc 
mov AX, word ptr[DI+8] 	; Заносим в АХ DI 
xor AX, word ptr[SI+8] 	; Исключающее или для f(L) и f(R) 
rcl AX, 1 				; Циклический сдвиг влево на 1 
jc R0 					; CF = 1 ? Есть ли перенос? 
lea DX, SNC 
jmp Kstr 

R0: fld Ex 				; Стэк: e 
fld Lval 				; Стэк: f(L), e 
fabs 					; Стэк: abs(f(L)), e 
fcomp ST(1) 			; Стэк: e. Сравнивание модуля значения 
						;функции с экспонентой и выталкивание модуля 
fstsw AX 				; Загрузка регистра SWR в АХ 
and AH, 45h 			; Сохраняются только C0/2/3 флаги 
jz R1 					; Если |f(L)| > e, продолжаем 
ffree ST(0) 			; f(L) - корень 
fld Left 				; Заносим в стек А 
fstp Root 				; выводим А из стека в переменную корня 
jmp Rfnd 				; Выход на конец 

R1: fld Rval 			; Стэк: f(R), e 
fabs 					; Стэк: abs(f(R)), e 
fcomp ST(1) 			; Стэк: e 
fstsw AX 
ffree ST(0) 			; Стэк: пустой 
and AH, 45h 
jz R2 					; |f(R)| > e, continue 
fld Right 
fstp Root 				; Move Rx to Root 
jmp Rfnd 

R2: fld Left 			; Стэк: А 
fld Right 				; Стэк: В,А 
faddp ST(1) 			; Стэк: В + А 
fidiv mdiv 				; Стэк: (Lx + Rx) / 2 
fstp Root 				; Временное занесение середины отрезка в переменнуб корня 

push BX 
push offset Root 
call CubicFunc 			; Calculate f(M) 
mov AX, word ptr[DI+8] 
xor AX, word ptr[BX+8]  ; XOR f(А) и f(B) - исключающее или. 
fld Root 				; Заносим MidValue в Стэк 
rcl AX, 1 				; Shift XOR-ed sign to CF 
jc R3 					; CF = 1 ? корень между L и М 
fstp Left 				; Новые границы: средняя, правая 
jmp R4 

R3: fstp Right 			; Новые границы: левая, средняя

R4: push DI 			;Пересчитываем значение в новых точках и отправляемся в R0 
push offset Left 		;(цикл с делением отрезка на 2) 
call CubicFunc 
push SI 
push offset Right 
call CubicFunc 
jmp R0 

Rfnd: push offset resstr ; преобразование полученного результата в строку 
push offset Root 
call LongDoubleToStr 

lea DX, rsl 
Kstr: mov AH, 9 
int 21h 
lea DX, AskCont 
mov AH, 9 
int 21h 
mov AH, 8 
int 21h 
cmp AL, 'y' 
jz Beg ; Пользователь ввёл 'y'
 
quit: exitcode 0

StrToLongDouble proc near 
push bp 		;
mov bp, sp 	    ;  Для передвижения по стеку
sub sp, 2 		; выделяем 2 байта в стеке 
push ax bx dx cx di 
pushf 
mov word ptr[bp-2], 10  ; помещаем в выделенные 2 байта 10 
fild word ptr[bp-2] 	; заталкиваем в стек сопроцессора 10 
fldz 					; заталкиваем в стек сопроцессора 0 
mov di, 0 
mov bx, [bp+4] 			; помещаем в bx адрес из стека(первый символ введеного числа) 
cmp byte ptr[bx], '-' 
jne @@BPN 				; проверка на знак числа 
inc bx 
mov di, 1 
@@BPN: movsx ax, byte ptr [bx] ; копируем в AX с расширением знака
 
cmp ax, '.' ; проверка на разделитель целой и дробной части(.) 
je @@PNT1 
cmp ax, 0dh ; проверка на знак конца строки (код клавиши ENTER) 
jne @@CNT 
fxch st(1) ; 0 и 10 меняю местами 
fstp st(0) ; сохраняю число 10 в st(0) и ваталкиваю из стека сопроцессора верхний элемент 
jmp @@REN 
@@CNT: sub ax, '0' 
mov word ptr[bp-2], ax 
fmul st(0), st(1) ; умножаем число на вершине стека на 10 
fiadd word ptr[bp-2] ; добавляем к числу на вершине стека то что было в ax 
inc bx 
jmp @@BPN 

@@PNT1: xor cx, cx 

@@BEG: inc bx 
movsx ax, byte ptr [bx] 
cmp ax, 0dh 
je @@END 
loop @@BEG 

@@END: dec bx 
fxch st(1) 
fldz 

@@APN: movsx ax, [bx] 
cmp ax, '.' 
je @@PNT2 
sub ax, '0' 
mov word ptr[bp-2], ax 
fiadd word ptr[bp-2] 
fdiv st(0), st(1) 
dec bx 
jmp @@APN
 
@@PNT2: fxch st(1) ; меняем число st(1) и st(0) местами 
fstp st(0) ; выталкиваем st(0) 
faddp st(1) ; складываем целую и дробную части 

@@REN: cmp di, 1 
jne @@CYK ; если флаг di поднят, то меняем знак числа 
fchs 

@@CYK: mov bx, [bp+6] ; помещаем в bx адрес из стека 
fstp tbyte ptr [bx] ; помещаем по адресу из стека число 
popf 
pop di cx dx bx ax 
add sp, 2 
pop bp 
ret 4 
StrToLongDouble endp 

LongDoubleToStr proc near 
push bp 
mov bp, sp 
sub sp, 4 ; выделяем 4 байта в стеке 
push ax bx dx cx di 
pushf 
fnstcw [bp-4] ; сохраним значение регистра управления 
fnstcw [bp-2] 
and word ptr[bp-2], 1111001111111111b 
or word ptr[bp-2], 0000110000000000b 
fldcw [bp-2] ; Запись нового значения регистра управления 
mov bx, [bp+4] 
fld tbyte ptr[bx] ; заталкиваем в стек сопроцессора число 
ftst ; сравнение st(0) c нулем и установка в регистре 
	 ;состояния CWR битов С2,C3,C0 
fstsw ax ; загрузка в AX CWR 
and ah, 1 ;проверка С0 
cmp ah, 1 
jne @@NBE 
mov bx, [bp+6] 
mov byte ptr[bx], '-' 
inc word ptr[bp+6] 
@@NBE: fabs ; заносим в st(0) модуль st(0) 
fst st(1) ; заносим в st(1) st(0) 
fst st(2) ; заносим в sr(2) st(0) 
frndint ; Округляет до целого значение в ST(0) в 
		;соответствии с порядком округления, заданным регистром CWR 
fsub st(2), st(0) ; вычетание из st(2) st(0) (получаем остаток) 
mov word ptr[bp-2], 10 
fild word ptr[bp-2] 
fxch st(1) ;меняю целую часть с 10 
xor cx, cx 
@@BG: fprem ;нахожу частичный остаток st(0) 
fist word ptr[bp-2] ;сохраняю число из вершины стека сопроцессора и выталкиваю её 
push word ptr[bp-2] ;записываю число в стек 
fxch st(2) ;меняю st(0) и st(2) содержимым 
fdiv st(0), st(1) 
frndint ;округляем до целого содержимое st(0) 
fst st(2) 
inc cx 
ftst ; сравнить st(0) c 0 
fstsw ax ; ST -> AX 
sahf ; AH в флаги 
jnz @@BG ; если 14 бит SR == 0 (6 бит AH) (если zf == 0 прыжок) 
mov ax, cx 
mov bx, [bp+6] 
@@BFG: pop dx 
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
@@BFR: fmul st(0), st(1) 
fst st(2) 
frndint 
fsub st(2), st(0) 
fist word ptr [bp-2] 
fxch st(2) 
mov ax, [bp-2] 
add ax, '0' 
inc bx 
mov byte ptr[bx], al 
loop @@BFR 
@@NIL: cmp byte ptr[bx], '0' 
jne @@CNR 
dec bx 
jmp @@NIL 
@@CNR: inc bx 
@@CNE: mov byte ptr[bx], '$' 
fstp st(0) 
fstp st(0) 
fstp st(0) 
fstp st(0) 
fldcw [bp-4] ; восстановим настройки сопроцессора 
popf 
pop di cx dx bx ax 
add sp, 4 
pop bp 
ret 4 
LongDoubleToStr endp 

CubicFunc proc near 
arg __Xptr: word, __ResPtr: word = __ArgSize 
local __temp: word = __LocSize 
; Функция вычисляет f(x) = x^3 + 7x^2 - 16x - 112 
push BP 
mov BP, SP 
sub SP, __LocSize 
push DI 

mov DI, __Xptr 
fld tbyte ptr[DI] 	; Стэк: x 
mov DI, __ResPtr 
fst ST(1) 			; Стэк: x, x 
fst ST(2) 			; Стэк: x, x, x 
fmul ST(1), ST 		; Стэк: x, x^2, x 
mov __temp, -16 
fimul __temp 		; Стэк: -16x, x^2, x 
fxch ST(1) 			; Стэк: x^2, -16x, x 
fmul ST(2), ST 		; Стэк: x^2, -16x, x^3 
mov __temp, 7 
fimul __temp 		; Стэк: 7x^2, -16x, x^3 
mov __temp, -112 
fiadd __temp 		; Стэк: -112 + 7x^2, -16x, x^3
 
faddp ST(1) 		; Стэк: -112 + 7x^2 -16x, x^3 
faddp ST(1) 		; Стэк: -112 + 7x^2 -16x + x^3 
fstp tbyte ptr[DI] 

pop DI 
add SP, __LocSize 
mov SP, BP 
pop BP 
ret __ArgSize
CubicFunc endp 

end start
