//------------------------------------
//SFU, ICTIC
//KTbo2-10
//Patychkina Elizaveta Vadimovna
//Laba 1
//19.03.2024
//------------------------------------
#include <def21060.h>
#define N 2
#define count 4
#define const 32
//------------------------------------
//Segment DM
//------------------------------------
.SECTION/DM		dm_data;
.VAR input[N*32] = "input.dat";
//------------------------------------
//Segment PM
//------------------------------------
.SECTION/PM		pm_data;
.VAR output[N*32];  //Promegutochny array
.VAR result [N];    // Result array
//------------------------------------
// RESET
//------------------------------------
.SECTION/PM pm_irq_svc;
	nop;
	jump start;
	nop;
	nop;
//------------------------------------
// Segment Code
//------------------------------------
.SECTION/PM pm_code;
start:
	I1 = input;
	M1 =1 ;
	I8 = output;
	M8 = 1;
	R0 = 0; //const = 0
	R1 = 1; //const = 1
	R4 = count; //const = 4
	R5 = 0; //last
	R6 = 1; //(0/1) change 
	I9 = result;
	LCNTR = N*32, DO xxx UNTIL LCE;	 		
				R2 = DM(I1, M1);
				R3 = R5 - R2; //COMP
				IF EQ jump next_1; // if same go to next_1
					R6 = R1;		//if difrent
					jump next_2;
				next_1:
			    	R6 = R0; //if same
			    next_2:	
			    R5 = R2;	//fix last		
	xxx: PM(I8, M8) = R6; //write bit
	
	I8 = output;
	LCNTR = N, DO out UNTIL LCE;
	R10 = 0x1;	
	R11= 0x0; //mask
		LCNTR = const, DO in UNTIL LCE;
			R12 = PM(I8, M8);
			COMP(R0, R12);
			IF EQ jump next_3;
				R11 = R11 or R10; // if bit = 1, fix bit in mask 
			next_3:
		in: R10 = lshift R10 by 1; //change position
	out: PM(I9, M8) = R11; //write number(hex) in result
wait: IDLE;
	  jump wait;
