//-----------------------------------------------------
//SFU, ICTIC
//KTbo2-10
//Patychkina Elizaveta Vadimovna
//Laba 2
//26.03.2024
//-----------------------------------------------------
#include <def21060.h>

#define N 2
#define K 1
#define M 32
//-----------------------------------------------------
//Seg DM
.SECTION/DM		dm_data;
.VAR in;
.VAR out;
.VAR MASS[N];
//-----------------------------------------------------
//Seg PM
.SECTION/DM		pm_data;
.VAR U[N+1] = "limits01.dat";
.VAR D[N] = "levels01";
//-----------------------------------------------------
//  RESET
.SECTION/PM pm_irq_svc;
	nop;
	jump start;
	nop;
	nop;

	
//-----------------------------------------------------
//Time
.SECTION/PM pm_irq_tmz;
		R1= DM(in);
		call (func);
		rti;
		nop;

//-----------------------------------------------------
// Ñåãìåíò êîäà
.SECTION/PM pm_code;
start:
		I1 = MASS;
		M1 = 1;
		R3 = 0; //last ostat
		I8 = U; //array U
		M8 = 1;
		I9 = D; //array D
		
		R4 = 1;//const = 1
		R0 = 0; //const = 0
		R15 = 255; //const = 255;
		R2 = -1; //const -1 
		R9 = K;
		R10 = 0;//for count pack;
		R14 = 0; //mask for pack;

		TPERIOD = 10;
		TCOUNT = 10;
		
		BIT SET MODE2 TIMEN; //ãëîáàëüíîå ðàçðåøåíèå ïðåðûâàíèÿ
		BIT SET MODE1 IRPTEN; //âêëþèòü òàéìåð
		BIT SET IMASK TMZHI; 
				
wait: IDLE;
	  jump wait;
	  
func:

	R4 = 1;//const = 1
	R0 = 0; //const = 0
	R15 = 255; //const = 255;
	R2 = -1; //const -1 
///////////////////////////////////////
	R7 = R1 + R3;
	R8 = R7 - R0;
	if GE jump next;
	R7 = R0;
	R8 = R7 - R0;
	if GE jump next_2;
next:
	R8 = R15 - R7;
	if GE jump next_2;
	R7 = R15;
next_2:
call (number_kvant);
R12 = R12 + R2;
DM(I1, M1) = R12;
R3 = R7 - R13;
	call (pack_num_kvant);
	nop;
rts;


//find kvant number
number_kvant:
	I8 = U; //array U
	M8 = 1;
	I9 = D; //array D	
	R1 = 0;//number kvant
	R11 = 0; //flag
	R12 = 0;//last kvant
	R13 = 0;//last count
	LCNTR = N, DO xxx UNTIL LCE;
		R6 = PM(I8, M8);
		R5 = PM(I9, M8);
		R8 = R7 - R6;
		if GE jump end;
		R11 = 1;
end: 
		R8 = R11 - R4;
		if EQ jump yyy (LA);
		R1 = R1 + 1;
		R12 = R1;
		R13 = R5;
xxx:nop;
yyy:
	rts;

	
//pack kvant number	
	
pack_num_kvant:
		R2 = M;
		R12 = lshift R12 by R10;
		R14 = R14 or R12;
	R8 = R10;
	R10 = R10 + R9;
	comp(R10 , R2);
	if NE jump skip;
		DM(out) = R14;
		R10 = 0;
		R14 = 0;
skip:

rts;	
  
