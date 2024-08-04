 //-----------------------------------------------------
//SFU, ICTIC
//KTbo2-10
//Patychkina Elizaveta Vadimovna
//Laba 4
//9.04.2024
//-----------------------------------------------------
#include <def21060.h>
//#include <matrix.h>
#include <asm_sprt.h>
#include "constants.h"

.global _SetupSPORT;
.global _ReadIOPReg;
.global ProcessBuffer;
.extern _vecvadd;

.section/dm seg_dmda;

//setting TSB blocks for input1
.var InBuffer11[cnN2];
.var InBuffer12[cnN2];
.var TCB_input11[8] = 0, 0, 0, InBuffer12-0x200000, TCB_input12+7, @InBuffer11, 1, InBuffer11;
.var TCB_input12[8] = 0, 0, 0, InBuffer11-0x200000, TCB_input11+7, @InBuffer12, 1, InBuffer12;

//setting TSB blocks for input2
.var InBuffer21[cnN2];
.var InBuffer22[cnN2];
.var TCB_input21[8] = 0, 0, 0, InBuffer22-0x200000, TCB_input22+7, @InBuffer21, 1, InBuffer21;
.var TCB_input22[8] = 0, 0, 0, InBuffer21-0x200000, TCB_input21+7, @InBuffer22, 1, InBuffer22;

//setting TSB blocks for output
.var OutBuffer1[cnN2];
.var OutBuffer2[cnN2];
.var TCB_output1[8] = 0, 0, 0, OutBuffer2-0x200000, TCB_output2+7, @OutBuffer1, 1, OutBuffer1;
.var TCB_output2[8] = 0, 0, 0, OutBuffer1-0x200000, TCB_output1+7, @OutBuffer2, 1, OutBuffer2;



.var A_Buffer[cnN2];		//Buffer for A
.var B_Buffer[cnN2];		//Buffer for B

.section/pm seg_pmco;

//-----------------------------------------------				
//init ports
//-----------------------------------------------
_SetupSPORT:
		R1=1;
		R4 = PASS R4;
		
		If NE jump receive;
			//receive
		DM(RDIV0) = R12;
		R12 = TCB_input11+7;
		DM(CP0) = R12;
		DM(SRCTL0) = R8;
		jump finish;		
receive:
		comp(R4,R1);
		if NE jump trans;
		DM(RDIV1) = R12;
		R12 = TCB_input21+7;
		DM(CP1) = R12;
		DM(SRCTL1) = R8;
		jump finish;
		jump finish;
trans:
		DM(TDIV0) = R12;		
		R12 = TCB_output1+7;
		DM(CP2) = R12;
		DM(STCTL0) = R8;
		R8 = -1;			
		DM(TX0) = R8;
finish:	alter(1);
	leaf_exit;

_SetupSPORT.end:
				nop;	
//-----------------------------------------------				
//read from IOP-registra
//-----------------------------------------------				
_ReadIOPReg:
			//save I8
		puts = I8;
		
		I8 = R4;		
		R0 = pm(I8, M13);
		
		I8 = gets(1);				
		alter(1);				
		
		leaf_exit;
		
_ReadIOPReg.end:
				nop;
//-----------------------------------------------					
//void ProcessBuffer (int* InBuffer1,int* InBuffer2,int *OutBuffer);
//-----------------------------------------------								
ProcessBuffer:
		save_reg;
		I0 = A_Buffer;
		I1 = B_Buffer;
		M0 = 1;
		I2 = R4;
		I3 = R8;
		I4 = R12;
	//read cnN2 count from input1 and input2. In float
		LCNTR = cnN2, DO xxx UNTIL LCE;
			R0 = DM(I2, M0);
			R1 = DM(I3, M0);
			F2 = FLOAT R0;
			F3 = FLOAT R1;
			DM(I0, M0) = F2;
xxx:	DM(I1,M0) = F3;

		//cjump _matmmltf (db);
		//	dm(I7, M7) = R2;
		//	dm(I7, M7) = PC;
			
		
//read cnN2 count from output. From float in int
LCNTR = cnN2, DO yyy UNTIL LCE;
			F0 = DM(I4, M1);
			R1 = TRUNC F0;
yyy:	DM(I4, M0) = R1;

		restore_reg;
		leaf_exit;

ProcessBuffer.end:					
				nop;				

				
							