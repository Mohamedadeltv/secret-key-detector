mov al,77 ;ascii of letter 'w' 
mov [00],al 
mov al,69 ;ascii of letter 'i'
mov [01],al
mov al,6E ;ascii of letter 'n'
mov [02],al 
mov al,0  
mov [03],al 
mov al,6C ;ascii of letter 'l' 
mov [04],al 
mov al,6F ;ascii of letter 'o' 
mov [05],al 
mov al,73 ;ascii of letter 's' 
mov [06],al 
mov al,65 ;ascii of letter 'e' 
mov [07],al 
mov al,0  




	

 CLO		; Close unwanted windows.

	IN	00	; Wait for key press - Store it in AL.
	sub AL,30

	mov DL,0

again:	
	add DL,AL
	dec AL
	jnZ again
	
	CMP DL,6
	JZ HERE1
	CMP DL,3
	JZ HERE1
	CMP DL,1
	JZ HERE1


incorrect:
	CLO			; Close all peripheral windows
MOV	CL,C0		; Video ram base address
	MOV	BL,04		; Offset of text string

START2:				; Text output to vdu
	MOV	AL,[BL]		; Text pointer into AL
	CMP	AL,0		; At end yet
	JZ	end1; Jump out of loop
	MOV	[CL],AL		; AL into video memory
	INC	CL		; Next video location
	INC	BL		; Next text character
	JMP	START2; Not there yet

HERE1:
	
	CLO			; Close all peripheral windows
	MOV	CL,C0		; Video ram base address
	add 	DL,30
	MOV	[CL],DL

	CLO			; Close all peripheral windows
	MOV	CL,C0		; Video ram base address
	MOV	BL,00		; Offset of text string

START1:				; Text output to vdu
	MOV	AL,[BL]		; Text pointer into AL
	CMP	AL,0		; At end yet
	JZ	next1		; Jump out of loop
	MOV	[CL],AL		; AL into video memory
	INC	CL		; Next video location
	INC	BL		; Next text character
	JMP	START1		; Not there yet



next1:

	CLO 
	IN	00	; Wait for key press - Store it in AL.
	CMP	AL,[00]	; Was it the Enter key? (ASCII 0D)
	JZ	next2; No - jump back.  Yes - end. 
	JMP incorrect
next2:

	IN	00	; Wait for key press - Store it in AL.
	CMP	AL,[01]	; Was it the Enter key? (ASCII 0D)
	JZ	next3	; No - jump back.  Yes - end. 
	JMP incorrect

next3:

	IN	00	; Wait for key press - Store it in AL.
	CMP	AL,[02]	; Was it the Enter key? (ASCII 0D)
	JZ	OPEN	; No - jump back.  Yes - end. 
	JMP OPEN



OPEN: 
       mov bl,10        ; Turn off all the traffic lights.
again2:  
        MOV AL,0	; Copy 00000000 into the AL register.
	OUT 01		; Send AL to Port One (The traffic lights).
			; Turn on all the traffic lights.
	MOV AL,ff	; Copy 00100100 into the AL register.
	OUT 01
	dec bl
	JNZ again2;	; Send AL to Port One (The traffic lights).
jmp end1


OPEN2: 
       mov bl,02       ; Turn off all the traffic lights.
again3:  
        MOV AL,0	; Copy 00000000 into the AL register.
	OUT 01		; Send AL to Port One (The traffic lights).
			; Turn on all the traffic lights.
	MOV AL,ff	; Copy 00110000 into the AL register.
	OUT 01
	dec bl
	JNZ again3;	; Send AL to Port One (The traffic lights).




END1:
END

