.686
.model flat
public _sum
.code
_sum PROC
PUSH EBP
MOV EBP,ESP
MOV ECX,[EBP+8]
MOV EAX,0
PUSH EBX
MOV EBX,12
JECXZ koniec
ptl:
	ADD EAX,[EBP+EBX]
	ADD EBX,4
	loop ptl
koniec:
POP EBX
POP EBP
RET
_sum ENDP

END