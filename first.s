	 AREA     factorial, CODE, READONLY
     IMPORT printMsg
	 IMPORT printComma
	 IMPORT printNextline
     IMPORT printMessage	 
	 EXPORT __main
	 EXPORT __COSINE
	 EXPORT __SINE
	 EXPORT __DRAWSPIRAL
		ENTRY 

		
__main  FUNCTION

; r is started from 1 to 2400 value as it will take 8 loops 2400/360=8 
		VLDR.F32 S17,=1.0				;radius starting value
		VMOV.F32 R0,S17
		VLDR.F32 S18,=3000.0				
		VMOV.F32 R1,S18
		VLDR.F32 S19,=3000.0				
		VMOV.F32 R2,S19
		BL printMessage
		
		BL __DRAWSPIRAL	
		
L2		VLDR.F32 S17,=1.0				;radius starting value
		VMOV.F32 R0,S17
		VLDR.F32 S18,=7500.0				
		VMOV.F32 R1,S18
		VLDR.F32 S19,=7500.0				
		VMOV.F32 R2,S19
		
		BL __DRAWSPIRAL2	

stop    B stop                              ; stop program
     ENDFUNC

__DRAWSPIRAL FUNCTION						
		VLDR.F32 S20,=1.0					;angle increment
		VLDR.F32 S21,=360.0					;max angle value
		VLDR.F32 S25,=2160.0  				;max radius value
		VLDR.F32 S24,=1						;radius increment
		VLDR.F32 S11,=0.0 					;This isthe input for sine and cosine
CORDC	VMOV.F32 R0,S11
		;BL printMsg		
		;BL printComma
		BL __SINE							
		VMUL.F32 S5,S5,S17					
		VADD.F32 S5,S5,S19					
		VMOV.F32 R0,S5			;x value
		BL printMsg		
		BL printComma
		BL __COSINE							
		VMUL.F32 S5,S5,S17					
		VADD.F32 S5,S5,S18					
		VMOV.F32 R0,S5			;y value
		BL printMsg
		BL printNextline
		VADD.F32 S11,S11,S20					;angle increement by 1
		VADD.F32 S17,S17,S24                 ;radius increment by 0.5
		VCMP.F32 S11,S21						;for initializing angle to 0
		VMRS APSR_nzcv, FPSCR
		IT EQ;
		VMOVEQ.f32 S11,S20;
		VCMP.F32 S17,S25						;max Radius reaches 2400
		VMRS APSR_nzcv, FPSCR
		BNE CORDC		
		
		B L2
		
		ENDFUNC
		
__DRAWSPIRAL2 FUNCTION						
		VLDR.F32 S20,=1.0					;angle increment
		VLDR.F32 S21,=360.0					;max angle value
		VLDR.F32 S25,=1520.0  				;max radius value
		VLDR.F32 S24,=1						;radius increment
		VLDR.F32 S11,=0.0 					;This isthe input for sine and cosine
CORDC2	VMOV.F32 R0,S11
		;BL printMsg		
		;BL printComma
		BL __SINE							
		VMUL.F32 S5,S5,S17					
		VADD.F32 S5,S5,S19					
		VMOV.F32 R0,S5			;x value
		BL printMsg		
		BL printComma
		BL __COSINE							
		VMUL.F32 S5,S5,S17					
		VADD.F32 S5,S5,S18					
		VMOV.F32 R0,S5			;y value
		BL printMsg
		BL printNextline
		VADD.F32 S11,S11,S20					;angle increement by 1
		VADD.F32 S17,S17,S24                 ;radius increment by 0.5
		VCMP.F32 S11,S21						;for initializing angle to 0
		VMRS APSR_nzcv, FPSCR
		IT EQ;
		VMOVEQ.f32 S11,S20;
		VCMP.F32 S17,S25						;max Radius reaches 2400
		VMRS APSR_nzcv, FPSCR
		BNE CORDC2		
		
		BX lr
		
		ENDFUNC
		
__SINE FUNCTION			;Here input is S11 and output is S5 = sin()
        VLDR.F32 S1,=90.0
        VMOV.F32 S0,S11
        VCMP.F32 S11,S1
		VMRS APSR_nzcv, FPSCR
		BLT SINPI
        VLDR.F32 S1,=180.0		
		VSUB.F32 S0,S1,S11
        VLDR.F32 S1,=270.0
		VCMP.F32 S11,S1
		VMRS APSR_nzcv, FPSCR
        BLT SINPI
		VLDR.F32 S1,=360.0
        VSUB.F32 S0,S11,S1   				;Stores angle range from -PI/2 to PI/2
SINPI   VLDR.F32 S7,=3.14159265
		VLDR.F32 S8,=180.0
		VLDR.F32 S6,=1.0
		MOV R1,#20         					;terms number
		VMUL.F32 S1,S0,S7
		VDIV.F32 S1,S1,S8					;x=PI*(theta)/180
		VMUL.F32 S2,S1,S1					;x^2
		VNEG.F32 S2,S2						;-x^2
		VMOV.F32 S3,S1						;S3 is the current term in the series
		VLDR.F32 S4,=2.0
		VMOV.F32 S5,S1		                

MULSIN	VMUL.F32 S3,S3,S2					;S3*(-x^2)
		VDIV.F32 S3,S3,S4					
		VADD.F32 S4,S4,S6					
		VDIV.F32 S3,S3,S4					
		VADD.F32 S4,S4,S6		
		VADD.F32 S5,S5,S3					
		SUB R1,R1,#1						
		CMP R1,#0
		BNE MULSIN							;Branch for next Term calculation
		                                    ;S5 = SIN(X) is the final answer
		VMOV.F32 R0,S5
		BX lr		
	ENDFUNC

	
__COSINE FUNCTION							
		VLDR.F32 S7,=3.14159265
		VLDR.F32 S8,=180.0
		VLDR.F32 S6,=1.0
		MOV R1,#20         					;NUMBER OF TERMS IN COMPUTATION
		VMUL.F32 S1,S11,S7
		VDIV.F32 S1,S1,S8					;x=PI*(theta)/180
		VMUL.F32 S2,S1,S1					;x^2
		VNEG.F32 S2,S2						;-x^2		
		VLDR.F32 S1,=1.0
		VMOV.F32 S3,S1						;S3 stores the current term
		VLDR.F32 S4,=1.0
		VMOV.F32 S5,S1		                
MULCOS	VMUL.F32 S3,S3,S2					;S3*(-x^2)
		VDIV.F32 S3,S3,S4					
		VADD.F32 S4,S4,S6					
		VDIV.F32 S3,S3,S4					
		VADD.F32 S4,S4,S6					
		VADD.F32 S5,S5,S3					;S5 stores cos(X)		
		SUB R1,R1,#1						 
		CMP R1,#0
		BNE MULCOS			
		BX lr		
	ENDFUNC	
	


	 END