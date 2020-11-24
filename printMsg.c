#include "stm32f4xx.h"
#include <string.h>
#include <stdio.h>

void printMsg(int a)
{
	 float a1=*((float*) &a);
	 
	 char Msg1[100];
	 
	 char *ptr;
	 sprintf(Msg1, "%f, \n", a1);
	 
	 ptr = Msg1 ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   
	 }
   }
void printNextline()
{
	ITM_SendChar('\n')	 ;
}
void printComma()
{
	
	 ITM_SendChar(',')	 ;
}

void printMessage(int r,int center_x,int center_y)
{
	 char Msg1[100]="";
	 
	 char *ptr;

	 //printNextl();

	 strcpy(Msg1,"Radius varies from 1 to 2400");
	 
	 ptr = Msg1 ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   
	 }
	// printMsg(center_y);
	 printNextline();
	 
	 strcpy(Msg1,"X-coordinate,Y-cordinate");
	 
	 ptr = Msg1 ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   
	 }
	 printNextline();
	
}	