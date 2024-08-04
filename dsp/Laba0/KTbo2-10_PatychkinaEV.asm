/*************************************************************/
/*                   SFU, ICTIS, MOP EVM                     */
/*                        IPO SRViIV						 */
/*                         KTbo2-10                          */
/*                 Patychkina Elizaveta Vadimovna            */
/*                          Laba 0                           */
/*************************************************************/
#include "def21060.h"    
#define N 13750
#define CONST 125

//------------------------------------------------------
// Source Vector 
//0x30000
.SECTION/DM     dm_data; 
.VAR input[N];
//------------------------------------------------------


//------------------------------------------------------
// Source Vector 2 and Result Vector
//0x24000
.SECTION/PM     pm_data;  
.VAR output[N];
//------------------------------------------------------

//------------------------------------------------------
//0x20004 - 0x20007
.SECTION/PM     pm_irq_svc;
		nop; 
		jump start; 
		nop;
		nop;
//------------------------------------------------------

//------------------------------------------------------
//0x20100
.SECTION/PM     pm_code;
start:  
		I0 = input;
		I1 = input;
		M0 = 1;
		M1 = 125;
		I8 = output;
		I9 = output;
		M8 = 1;
		M9 = 125;
		R2 = CONST;
		R2 = lshift R2 by 8; 
		R3 = 0x0000FF00; 
        R2 = R2 AND R3;
        R4 = 0x00FF00FF; 

		LCNTR = 110, DO xxx UNTIL LCE;
			I0 = I1;
			I8 = I9;
			LCNTR = 125, DO yyy UNTIL LCE;
				R1 = DM(I0, M0);
				R5 = R1 AND R3;
				R6 = R1 AND R4;
				R7 = R5 + R2;
				R8 = R3 - R7;
				IF LT JUMP next_1;
				R5 = R7;
				JUMP next_2;
next_1:			R5 = R3;
next_2:			R1 = R5 OR R6; 
yyy:			PM(I8, M8) = R1;
			MODIFY(I1, M1);	
xxx:		MODIFY(I9, M9);	
						
wait:	IDLE;
        jump wait;