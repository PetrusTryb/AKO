.686
.XMM
.model flat
.data
dwa qword 2.0
trzy qword 3.0
cztery qword 4.0
r_kwadrat qword 0.0f
v1 qword 0.0f
.code
_cysterna PROC
push ebp
mov ebp,esp
finit
push esi
lea esi,[ebp+16]; D
fld QWORD PTR [esi]; st(0)=D
fld dwa; st(0)=2, st(1)=D
fdivp st(1), st(0); st(0)=D/2=R
fst st(1);st(0)=st(1)=R
fmul st(0),st(0)
fmul st(1),st(0);st(0)=R^2 st(1)=R^3
fstp r_kwadrat

fld cztery;st(0)=4, st(1)=R^3
fld trzy;st(0)=3, st(1)=4, st(2)=R^3
fdivp st(1),st(0); st(0)=4/3, st(1)=R^3
fldpi; st(0)=pi, st(1)=4/3, st(2)=R^3
fmulp st(1),st(0); st(0)=4/3pi st(1)=R^3
fmulp st(1),st(0); st(0)=V1
fstp v1

lea esi,[ebp+8]; L
fld QWORD PTR [esi]; st(0)=L
lea esi, [ebp+16]
fld QWORD PTR [esi]; st(0)=D, st(1)=L
fsubp st(1),st(0); st(0)=L-D=H
fldpi; st(0)=pi, st(1)=H
fld r_kwadrat; st(0)=R^2, st(1)=pi, st(2)=H
fmulp st(1),st(0); st(0)=pi*R^2, st(1)=H
fmulp st(1),st(0); st(0)=pi*R^2*H=v2
fld v1; st(0)=v1, st(1)=v2
faddp st(1),st(0);st(0)=v1+v2=V

pop esi
pop ebp
ret
_cysterna ENDP
END