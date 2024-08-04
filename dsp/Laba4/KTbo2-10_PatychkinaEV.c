 //-----------------------------------------------------
//SFU, ICTIC
//KTbo2-10
//Patychkina Elizaveta Vadimovna
//Laba 4
//9.04.2024
//-----------------------------------------------------
 #include <def21060.h>
 #include <signal.h>
 #include <matrix.h>
 #include "constants.h"
 
 
 //first param - R4
 //second param - R8
 //third param - R12
 	//init ports output and input
 extern void SetupSPORT(int, int, int);
 	//read value IOP-registr
 extern int ReadIOPReg(int);
 
 extern "asm" ProcessBuffer(int *, int *, int *);

 
 void SPORT0_DMA_Receive_Handler(int sig)
 {
 	int *ptrInBuffer1;
	int *ptrInBuffer2;
 	int *ptrOutBuffer;
 		//active input buffer
 	ptrInBuffer1 = (int *)ReadIOPReg(GP0);
 	ptrInBuffer1 += 0x20000;
 	ptrInBuffer1 -= cnN2;
 		//active input buffer
 	ptrInBuffer2 = (int *)ReadIOPReg(GP1);
 	ptrInBuffer2 += 0x20000;
 	ptrInBuffer1 -= cnN2;
 	//active output buffer
 	ptrOutBuffer = (int *)ReadIOPReg(GP2);
 	ptrOutBuffer += 0x20000;
 	ptrInBuffer1 -= cnN2;
 	//PP obrabotki buffer
 	ProcessBuffer(ptrInBuffer1, ptrInBuffer2, ptrOutBuffer);	
 	return;
 }
 

int main()
{
	//Obrabotchik preryvania
	interrupt(SIG_SPR1I, SPORT0_DMA_Receive_Handler);
	
	//setting DMA input1
	SetupSPORT(0, 0xC05F1, 0);
	//setting DMA input2
	SetupSPORT(1, 0xC05F1, 0);
	//setting DMA output
	SetupSPORT(2, 0xC05F1, 0);
	
	return 0;
}
