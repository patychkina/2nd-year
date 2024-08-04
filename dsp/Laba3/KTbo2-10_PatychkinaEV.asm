//-----------------------------------------------------
//SFU, ICTIC
//KTbo2-10
//Patychkina Elizaveta Vadimovna
//Laba 3
//2.04.2024
//-----------------------------------------------------
#include <def21060.h>

#define N 4
#define S 8
//-----------------------------------------------------
//Segment DM
.SECTION/DM		dm_data;
.VAR in_buf1[1];
.VAR in_buf2[1];
.VAR in_selector[2] = in_buf1, in_buf2;
.VAR TCB_Block1[8] = 0, 0, 0, 0,
					TCB_Block2+S-1,
					@in_buf1,
					1, 
					in_buf1;
					
.VAR TCB_Block2[8] = 0, 0, 0, 0,
					TCB_Block1+S-1,
					@in_buf2,
					1, 
					in_buf2;			

.VAR TCB_BlockOut1[8] = 0, 0, 0, 0,
					TCB_BlockOut2+S-1,
					@out_buf1,
					1, 
					out_buf1;
					
.VAR TCB_BlockOut2[8] = 0, 0, 0, 0,
					TCB_BlockOut1+S-1,
					@out_buf2,
					1, 
					out_buf2;

.VAR out_selector[2] = out_buf1, out_buf2;
.VAR out_buf1[N];
.VAR out_buf2[N];
//-----------------------------------------------------
//The handler RESET
.SECTION/PM pm_irq_svc;
	nop;
	jump start;
	nop;
	nop;	
//-----------------------------------------------------
//The handler SPORT0 (DMA channel)
.SECTION/PM pm_irq_spr0;
	M1 = R10;
	jump func(db);
		I0 = DM (M1, I1); //now input buffer
		I7 = DM (M1, I5);//now output buffer


//-----------------------------------------------------
// Segment  code
.SECTION/PM pm_code;
start:
		M2 = R13;
		I7 = DM (M2, I5);//now output buffer
		//two input buffers
		I1 = in_selector;
		//two output buffers
		I5 = out_selector;
		M0 = 1;

		R10 = 0; //0 - first buffer, 1 - second buffer for input
		R11 = 0; //0 - first buffer, 1 - second buffer for output
		R15 = 0; //last
		
		R0 = 4;
		DM(RDIV0) = R0;	//div for input
		R0 = 1;
 		DM(TDIV0) = R0;	//div for output
 			

			//Setting up DMA channel # 0 for input
		R0 = TCB_Block1 + 7;
		DM(CP0) = R0;
			//Setting up SPORT0 Receive
		R0 = 0x00C05F1; //SPEN = 1
						//SLEN = 31 (=32) 
						//ICLK = 1
						//SDEN, SCHEN = 1
		DM(SRCTL0) = R0;
			//Setting up DMA channel # 0 for output
		R0 = TCB_BlockOut1 + 7;
		DM(CP2) = R0;
	
			//Setting up SPORT0 Receive
		R0 = 0x00C05F1; //SPEN = 1
						//SLEN = 31 (=32) 
						//ICLK = 1
						//SDEN, SCHEN = 1
		DM(STCTL0) = R0;

		
		BIT SET IMASK SPR0I;
		BIT SET MODE1 IRPTEN;	
//-----------------------------------------------------	
			
		//forever cycle	
wait: IDLE;
	  jump wait;
//-----------------------------------------------------
//The subroutine obrabatyvaev chislo i vyvodit N chisel
//Input values R2
//Spoiling R1, R3, R4, R5, R6, R8
//Output values R7 
//-----------------------------------------------------

func:
	R2 = DM(I0, M0);  //read tekushee znachenie
	R1 = 0x1; //menyat
	R3 = 0x0; //mask 
	LCNTR = N, DO xxx UNTIL LCE;
		R3 = R3 or R1;
xxx: R1 = lshift R1 by 1;
	R1 = R2 and R3;//deltas
	R3 = not R3;
	R4 = R2 and R3;//C
	LCNTR = N, DO yyy UNTIL LCE;
		R4 = lshift R4 by -1;
yyy: 
	R5 = 1;
	R6 = -1;
	R7 = 1;//schet
	R3 = 0x1;
	LCNTR = N, DO zzz UNTIL LCE;
		R2 = R1 and R3;
		COMP(R2, R5);
		if EQ jump next_1;
			R7 = R6 * R4(SSI);
		next_1:
			COMP(R2, R5);
			if NE jump next_2;
			R7 = R5 * R4(SSI);
		next_2:
		R1 = lshift R1 by -1;
		R7 = R7 + R15;
		R15 = R7;
		R14 = 1;		
zzz:	DM(I7,M0)= R7;
	R14 = 1;		
	R10 = R10 xor R14;
	rti;
		
			