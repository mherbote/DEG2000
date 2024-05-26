'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1


                                	TITLE	'S o f t w a r e  T R A C E   D E G 2 0 0 0'
                                	PAGE	87
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-1


                                
                                ;	PN	ST37
                                ;****************************************************************
                                ;*               S o f t w a r e  T R A C E   D E G 2 0 0 0     *
                                ;*  Version      -----------------------------------------------*
                                ;*               uebernommen aus  : Rolf Dieter Klein           *
                                ;*                           "u-Computer Hard- u. Softw.praxis" *
                                ;*               aufbereitet durch: M. Herbote - K EAW  ZFT(WFT)*
                                ;*  V 1 . 2      -----------------------------------------------*
                                ;*               Stand            : 01.Maerz 1985               *
                                ;****************************************************************
  0001                          V1	EQU	1	;1  ...  B W S  mit 80 Spalten
                                			;2  ...  B W S  mit 64 Spalten
                                
  0000'                         BWSA	EQU	$		;BER	00800H
                                	ORG	BWSA+00800H
                                
  0800'   C3 0EEC'              	JP	MAIN
  0803'   56 31 2E 32           	DB	'V1.2/010385'
  0807'   2F 30 31 30           
  080B'   33 38 35              
                                
  080E'   C3 000B               SYSTB:	JP	0000BH	;SY.SYSTB
                                
  0811'   C3 6F03               TA1:	JP	06F03H
  0814'   C3 6F06               TA2:	JP	06F06H
  0817'   C3 7C00               PRIO:	JP	07C00H
                                
  081A'   E5                    BWSUS:	PUSH	HL
  081B'   D5                    	PUSH	DE
  081C'   C5                    	PUSH	BC
  081D'   F5                    	PUSH	AF
  081E'   21 0000'              	LD	HL,BWSA
  0821'   11 3000               	LD	DE,03000H
  0824'   01 0800               	LD	BC,800H
  0827'   CD 083B'              	CALL	BWSU1
  082A'   21 0DB2               	LD	HL,00DB2H
  082D'   11 1233'              	LD	DE,RPOS
  0830'   01 0006               	LD	BC,6
  0833'   CD 083B'              	CALL	BWSU1
  0836'   F1                    	POP	AF
  0837'   C1                    	POP	BC
  0838'   D1                    	POP	DE
  0839'   E1                    	POP	HL
  083A'   C9                    	RET
                                
  083B'   7E                    BWSU1:	LD	A,(HL)
  083C'   08                    	EX	AF,AF'
  083D'   1A                    	LD	A,(DE)
  083E'   77                    	LD	(HL),A
  083F'   08                    	EX	AF,AF'
  0840'   12                    	LD	(DE),A
  0841'   23                    	INC	HL
  0842'   13                    	INC	DE
  0843'   0B                    	DEC	BC
  0844'   78                    	LD	A,B
  0845'   B1                    	OR	C
  0846'   20 F3                 	JR	NZ,BWSU1
  0848'   C9                    	RET
                                
                                
  0849'   E3                    SAVE:	EX	(SP),HL
  084A'   F5                    	PUSH	AF
  084B'   C5                    	PUSH	BC
  084C'   D5                    	PUSH	DE
  084D'   DD E5                 	PUSH	IX
  084F'   FD E5                 	PUSH	IY
  0851'   E9                    	JP	(HL)
                                
  0852'   E1                    LOAD:	POP	HL
  0853'   FD E1                 	POP	IY
  0855'   DD E1                 	POP	IX
  0857'   D1                    	POP	DE
  0858'   C1                    	POP	BC
  0859'   F1                    	POP	AF
  085A'   E3                    	EX	(SP),HL
  085B'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-2


                                
  085C'   CD 0849'              CIN:	CALL	SAVE	;Konsoleninput
  085F'   3A 156D'              	LD	A,(CST)
  0862'   B7                    	OR	A
  0863'   20 03                 	JR	NZ,CIN1
  0865'   CD 0878'              	CALL	CSTS1
  0868'   CD 0811'              CIN1:	CALL	TA1
  086B'   28 FB                 	JR	Z,CIN1
  086D'   AF                    	XOR	A
  086E'   32 156D'              	LD	(CST),A
  0871'   CD 0852'              	CALL	LOAD
  0874'   3A 156B'              	LD	A,(TK)
  0877'   C9                    	RET
                                
  0878'   CD 0811'              CSTS1:	CALL	TA1
  087B'   20 FB                 	JR	NZ,CSTS1
  087D'   CD 0814'              	CALL	TA2
  0880'   FE CD                 	CP	0CDH
  0882'   CA 0FB7'              	JP	Z,SYTB
  0885'   FE 1E                 	CP	01EH
  0887'   28 15                 	JR	Z,CSTS3
  0889'   FE 80                 	CP	080H
  088B'   28 15                 	JR	Z,CST10
  088D'   FE 7F                 	CP	07FH
  088F'   30 E7                 	JR	NC,CSTS1
  0891'   FE 20                 	CP	' '
  0893'   38 E3                 	JR	C,CSTS1
  0895'   32 156B'              CSTS2:	LD	(TK),A
  0898'   3E FF                 	LD	A,-1
  089A'   32 156D'              	LD	(CST),A
  089D'   C9                    	RET
  089E'   3E 0D                 CSTS3:	LD	A,00DH
  08A0'   18 F3                 	JR	CSTS2
  08A2'   CD 081A'              CST10:	CALL	BWSUS
  08A5'   CD 0811'              CST11:	CALL	TA1
  08A8'   28 FB                 	JR	Z,$-3
  08AA'   CD 0811'              	CALL	TA1
  08AD'   20 FB                 	JR	NZ,$-3
  08AF'   CD 0814'              	CALL	TA2
  08B2'   FE 80                 	CP	80H
  08B4'   20 EF                 	JR	NZ,CST11
  08B6'   CD 081A'              	CALL	BWSUS
  08B9'   CD 0811'              	CALL	TA1
  08BC'   28 FB                 	JR	Z,$-3
  08BE'   18 B8                 	JR	CSTS1
                                
  08C0'   CD 0849'              CSTS:	CALL	SAVE	;Konsolenstatus
  08C3'   CD 0811'              	CALL	TA1
  08C6'   20 05                 	JR	NZ,CSTS4
  08C8'   CD 0878'              	CALL	CSTS1
  08CB'   18 04                 	JR	CSTS5
  08CD'   AF                    CSTS4:	XOR	A
  08CE'   32 156D'              	LD	(CST),A
  08D1'   CD 0852'              CSTS5:	CALL	LOAD
  08D4'   3A 156D'              	LD	A,(CST)
  08D7'   B7                    	OR	A
  08D8'   C9                    	RET
                                
  08D9'   CD 0849'              CON:	CALL	SAVE
  08DC'   CD 04C6               	CALL	004C6H	;SY.RESC
  08DF'   79                    	LD	A,C
  08E0'   FE 0D                 	CP	00DH
  08E2'   28 1B                 	JR	Z,CON9
  08E4'   FE 0C                 	CP	00CH
  08E6'   28 0E                 	JR	Z,CON2
  08E8'   FE 0A                 	CP	00AH
  08EA'   28 05                 	JR	Z,CON1
  08EC'   CD 06E3               	CALL	006E3H	;SY.AEIN
  08EF'   18 0E                 	JR	CON9
                                
  08F1'   CD 0193               CON1:	CALL	00193H	;IN.FKT2 (CNZA)
  08F4'   18 09                 	JR	CON9
                                
  08F6'   CD 0625               CON2:	CALL	00625H	;SY.BILO
  08F9'   21 0000               	LD	HL,0
  08FC'   22 0DB2               	LD	(ZPOS),HL
  08FF'   CD 04B0               CON9:	CALL	004B0H	;SY.SETC
  0902'   CD 0852'              	CALL	LOAD
  0905'   C9                    	RET
                                
  0906'   CD 0849'              LIST:	CALL	SAVE
  0909'   79                    	LD	A,C
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-3


  090A'   FE 0C                 	CP	00CH
  090C'   28 13                 	JR	Z,STX3
  090E'   FE 0D                 	CP	00DH
  0910'   28 2A                 	JR	Z,STX9
  0912'   FE 0A                 	CP	00AH
  0914'   20 23                 	JR	NZ,STX2
  0916'   0E 1E                 	LD	C,1EH
  0918'   CD 0817'              	CALL	PRIO
  091B'   21 156C'              	LD	HL,ZZ
  091E'   35                    	DEC	(HL)
  091F'   20 1B                 	JR	NZ,STX9
  0921'   7E                    STX3:	LD	A,(HL)
  0922'   FE 45                 	CP	69
  0924'   28 16                 	JR	Z,STX9
  0926'   C6 03                 	ADD	A,3
  0928'   47                    	LD	B,A
  0929'   0E 1E                 	LD	C,1EH
  092B'   C5                    STX4:	PUSH	BC
  092C'   CD 0817'              	CALL	PRIO
  092F'   C1                    	POP	BC
  0930'   10 F9                 	DJNZ	STX4
  0932'   3E 45                 	LD	A,69
  0934'   32 156C'              	LD	(ZZ),A
  0937'   18 03                 	JR	STX9
  0939'   CD 0817'              STX2:	CALL	PRIO
  093C'   CD 0852'              STX9:	CALL	LOAD
  093F'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-4


                                
  0940'   F5                    C04:	PUSH	AF	;Zeichenausgabe auf BWS / Drucker
  0941'   3A 1239'              	LD	A,(ST2)
  0944'   B7                    	OR	A
  0945'   20 04                 	JR	NZ,C042	;891C
  0947'   F1                    	POP	AF
  0948'   C3 08D9'              	JP	CON
                                
  094B'   F1                    C042:	POP	AF
  094C'   C3 0906'              	JP	LIST
                                
  094F'   CD 0C56'              C041:	CALL	C50
  0952'   CD 0940'              	CALL	C04
  0955'   C3 0C57'              	JP	C51
                                
  0958'   06 00                 C05:	LD	B,0	;Befehlslaenge ermitteln
  095A'   E5                    	PUSH	HL
  095B'   D1                    	POP	DE
  095C'   7E                    	LD	A,M
  095D'   E6 DF                 	AND	0DFH
  095F'   FE DD                 	CP	0DDH
  0961'   28 57                 	JR	Z,J093
  0963'   7E                    	LD	A,M
  0964'   FE CB                 	CP	0CBH
  0966'   28 4E                 	JR	Z,J092
  0968'   FE ED                 	CP	0EDH
  096A'   28 40                 	JR	Z,J091
  096C'   7E                    	LD	A,M
  096D'   FE C3                 	CP	0C3H
  096F'   28 78                 	JR	Z,J11
  0971'   FE CD                 	CP	0CDH
  0973'   28 74                 	JR	Z,J11
  0975'   E6 EF                 	AND	0EFH
  0977'   FE 22                 	CP	022H
  0979'   28 6E                 	JR	Z,J11
  097B'   FE 2A                 	CP	02AH
  097D'   28 6A                 	JR	Z,J11
  097F'   E6 CF                 	AND	0CFH
  0981'   FE 01                 	CP	001H
  0983'   28 64                 	JR	Z,J11
  0985'   E6 C7                 	AND	0C7H
  0987'   FE C2                 	CP	0C2H
  0989'   28 5E                 	JR	Z,J11
  098B'   FE C4                 	CP	0C4H
  098D'   28 5A                 	JR	Z,J11
  098F'   7E                    	LD	A,M
  0990'   E6 F7                 	AND	0F7H
  0992'   FE 10                 	CP	010H
  0994'   28 54                 	JR	Z,J12
  0996'   FE D3                 	CP	0D3H
  0998'   28 50                 	JR	Z,J12
  099A'   E6 E7                 	AND	0E7H
  099C'   FE 20                 	CP	020H
  099E'   28 4A                 	JR	Z,J12
  09A0'   E6 C7                 	AND	0C7H
  09A2'   FE 06                 	CP	006H
  09A4'   28 44                 	JR	Z,J12
  09A6'   FE C6                 	CP	0C6H
  09A8'   28 40                 	JR	Z,J12
  09AA'   18 3F                 	JR	J13
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-5


                                
  09AC'   23                    J091:	INC	HL
  09AD'   7E                    	LD	A,M
  09AE'   E6 C7                 	AND	0C7H
  09B0'   FE 43                 	CP	043H
  09B2'   28 34                 	JR	Z,J10
  09B4'   18 34                 	JR	J12
                                
  09B6'   18 32                 J092:	JR	J12
                                
  09B8'   18 2E                 J09:	JR	J10
                                
  09BA'   23                    J093:	INC	HL
  09BB'   7E                    	LD	A,M
  09BC'   FE CB                 	CP	0CBH
  09BE'   28 F8                 	JR	Z,J09
  09C0'   FE 21                 	CP	021H
  09C2'   28 24                 	JR	Z,J10
  09C4'   E6 FE                 	AND	0FEH
  09C6'   FE 34                 	CP	034H
  09C8'   28 1F                 	JR	Z,J11
  09CA'   E6 F8                 	AND	0F8H
  09CC'   FE 70                 	CP	070H
  09CE'   28 19                 	JR	Z,J11
  09D0'   7E                    	LD	A,M
  09D1'   E6 CF                 	AND	0CFH
  09D3'   FE 06                 	CP	006H
  09D5'   28 11                 	JR	Z,J10
  09D7'   E6 C7                 	AND	0C7H
  09D9'   FE 02                 	CP	002H
  09DB'   28 0B                 	JR	Z,J10
  09DD'   7E                    	LD	A,M
  09DE'   D6 40                 	SUB	040H
  09E0'   E6 87                 	AND	087H
  09E2'   FE 06                 	CP	006H
  09E4'   28 03                 	JR	Z,J11
  09E6'   18 02                 	JR	J12
  09E8'   04                    J10:	INC	B
  09E9'   04                    J11:	INC	B
  09EA'   04                    J12:	INC	B
  09EB'   04                    J13:	INC	B
  09EC'   EB                    	EX	DE,HL
  09ED'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-6


                                
  09EE'   ED 43 1582'           C06:	LD	(DDBC),BC	;USER - Register retten
  09F2'   ED 53 1584'           	LD	(DDDE),DE
  09F6'   22 1586'              	LD	(DDHL),HL
  09F9'   F5                    	PUSH	AF
  09FA'   C1                    	POP	BC
  09FB'   ED 43 1588'           	LD	(DDAF),BC
  09FF'   08                    	EX	AF,AF'
  0A00'   D9                    	EXX
  0A01'   ED 43 157A'           	LD	(DDBCS),BC
  0A05'   ED 53 157C'           	LD	(DDDES),DE
  0A09'   22 157E'              	LD	(DDHLS),HL
  0A0C'   F5                    	PUSH	AF
  0A0D'   C1                    	POP	BC
  0A0E'   ED 43 1580'           	LD	(DDAFS),BC
  0A12'   ED 57                 	LD	A,I
  0A14'   32 1570'              	LD	(DDI),A
  0A17'   ED 5F                 	LD	A,R
  0A19'   32 1571'              	LD	(DDR),A
  0A1C'   DD 22 1576'           	LD	(DDIX),IX
  0A20'   FD 22 1578'           	LD	(DDIY),IY
  0A24'   CD 081A'              	CALL	BWSUS
  0A27'   2A 123A'              	LD	HL,(ST3)
  0A2A'   C9                    	RET
                                
  0A2B'   22 123A'              C07:	LD	(ST3),HL	;USER - Register laden
  0A2E'   CD 081A'              	CALL	BWSUS
  0A31'   FD 2A 1578'           	LD	IY,(DDIY)
  0A35'   DD 2A 1576'           	LD	IX,(DDIX)
  0A39'   3A 1570'              	LD	A,(DDI)
  0A3C'   ED 47                 	LD	I,A
  0A3E'   3A 1571'              	LD	A,(DDR)
  0A41'   ED 4F                 	LD	R,A
  0A43'   ED 4B 1580'           	LD	BC,(DDAFS)
  0A47'   C5                    	PUSH	BC
  0A48'   F1                    	POP	AF
  0A49'   2A 157E'              	LD	HL,(DDHLS)
  0A4C'   ED 5B 157C'           	LD	DE,(DDDES)
  0A50'   ED 4B 157A'           	LD	BC,(DDBCS)
  0A54'   D9                    	EXX
  0A55'   08                    	EX	AF,AF'
  0A56'   ED 4B 1588'           	LD	BC,(DDAF)
  0A5A'   C5                    	PUSH	BC
  0A5B'   F1                    	POP	AF
  0A5C'   2A 1586'              	LD	HL,(DDHL)
  0A5F'   ED 5B 1584'           	LD	DE,(DDDE)
  0A63'   ED 4B 1582'           	LD	BC,(DDBC)
  0A67'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-7


                                
  0A68'   AF                    J20:	XOR	A	;Unterprogramme fuer USER-Befehl
  0A69'   06 04                 	LD	B,4
  0A6B'   11 0A8B'              	LD	DE,USBEF+3
  0A6E'   12                    	LD	(DE),A
  0A6F'   1B                    	DEC	DE
  0A70'   10 FC                 	DJNZ	$-02	;8A5A
  0A72'   D5                    	PUSH	DE
  0A73'   CD 0958'              	CALL	C05
  0A76'   D1                    	POP	DE
  0A77'   7E                    	LD	A,M
  0A78'   13                    	INC	DE
  0A79'   12                    	LD	(DE),A
  0A7A'   23                    	INC	HL
  0A7B'   10 FA                 	DJNZ	$-04	;8A63
  0A7D'   CD 0A2B'              	CALL	C07
  0A80'   ED 73 1569'           	LD	(STSP),SP
  0A84'   ED 7B 1574'           	LD	SP,(DDSP)
  0A88'   00                    USBEF:	NOP
  0A89'   00                    	NOP
  0A8A'   00                    	NOP
  0A8B'   00                    	NOP
  0A8C'   ED 73 1574'           	LD	(DDSP),SP
  0A90'   ED 7B 1569'           	LD	SP,(STSP)
  0A94'   CD 09EE'              	CALL	C06
  0A97'   C9                    	RET
                                
  0A98'   7E                    J21:	LD	A,M
  0A99'   23                    	INC	HL
  0A9A'   ED 73 1569'           	LD	(STSP),SP
  0A9E'   ED 7B 1574'           	LD	SP,(DDSP)
  0AA2'   E5                    	PUSH	HL
  0AA3'   ED 73 1574'           	LD	(DDSP),SP
  0AA7'   ED 7B 1569'           	LD	SP,(STSP)
  0AAB'   26 00                 	LD	H,0
  0AAD'   E6 38                 	AND	038H
  0AAF'   6F                    	LD	L,A
  0AB0'   C9                    	RET
                                
  0AB1'   23                    J22:	INC	HL
  0AB2'   23                    	INC	HL
  0AB3'   23                    	INC	HL
  0AB4'   ED 73 1569'           	LD	(STSP),SP
  0AB8'   ED 7B 1574'           	LD	SP,(DDSP)
  0ABC'   E5                    	PUSH	HL
  0ABD'   ED 73 1574'           	LD	(DDSP),SP
  0AC1'   ED 7B 1569'           	LD	SP,(STSP)
  0AC5'   2B                    	DEC	HL
  0AC6'   7E                    	LD	A,M
  0AC7'   2B                    	DEC	HL
  0AC8'   6E                    	LD	L,M
  0AC9'   67                    	LD	H,A
  0ACA'   C9                    	RET
                                
  0ACB'   2A 1586'              J23:	LD	HL,(DDHL)
  0ACE'   C9                    	RET
                                
  0ACF'   2A 1576'              J24:	LD	HL,(DDIX)
  0AD2'   C9                    	RET
                                
  0AD3'   2A 1578'              J25:	LD	HL,(DDIY)
  0AD6'   C9                    	RET
                                
  0AD7'   ED 73 1569'           J26:	LD	(STSP),SP
  0ADB'   ED 7B 1574'           	LD	SP,(DDSP)
  0ADF'   E1                    	POP	HL
  0AE0'   ED 73 1574'           	LD	(DDSP),SP
  0AE4'   ED 7B 1569'           	LD	SP,(STSP)
  0AE8'   C9                    	RET
                                
  0AE9'   23                    J27:	INC	HL
  0AEA'   7E                    	LD	A,M
  0AEB'   23                    	INC	HL
  0AEC'   66                    	LD	H,M
  0AED'   6F                    	LD	L,A
  0AEE'   C9                    	RET
                                
  0AEF'   23                    J28:	INC	HL
  0AF0'   7E                    	LD	A,M
  0AF1'   23                    	INC	HL
  0AF2'   4F                    	LD	C,A
  0AF3'   B7                    	OR	A
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-8


  0AF4'   FA 0AFB'              	JP	M,J29
  0AF7'   06 00                 	LD	B,0
  0AF9'   09                    	ADD	HL,BC
  0AFA'   C9                    	RET
                                
  0AFB'   06 FF                 J29:	LD	B,0FFH
  0AFD'   09                    	ADD	HL,BC
  0AFE'   C9                    	RET
                                
  0AFF'   ED 4B 1582'           J30:	LD	BC,(DDBC)
  0B03'   05                    	DEC	B
  0B04'   ED 43 1582'           	LD	(DDBC),BC
  0B08'   20 E5                 	JR	NZ,J28
  0B0A'   23                    	INC	HL
  0B0B'   23                    	INC	HL
  0B0C'   C9                    	RET
                                
  0B0D'   7E                    J31:	LD	A,M
  0B0E'   E6 38                 	AND	038H
  0B10'   F6 C2                 	OR	0C2H
  0B12'   32 0B1B'              	LD	(USB1),A
  0B15'   ED 4B 1588'           	LD	BC,(DDAF)
  0B19'   C5                    	PUSH	BC
  0B1A'   F1                    	POP	AF
  0B1B'   00                    USB1:	NOP
  0B1C'   0AB1'                 	DW	J22
  0B1E'   23                    	INC	HL
  0B1F'   23                    	INC	HL
  0B20'   23                    	INC	HL
  0B21'   C9                    	RET
                                
  0B22'   7E                    J32:	LD	A,M
  0B23'   32 0B2C'              	LD	(USB2),A
  0B26'   ED 4B 1588'           	LD	BC,(DDAF)
  0B2A'   C5                    	PUSH	BC
  0B2B'   F1                    	POP	AF
  0B2C'   00                    USB2:	NOP
  0B2D'   0AE9'                 	DW	J27
  0B2F'   23                    	INC	HL
  0B30'   23                    	INC	HL
  0B31'   23                    	INC	HL
  0B32'   C9                    	RET
                                
  0B33'   7E                    J33:	LD	A,M
  0B34'   E6 38                 	AND	038H
  0B36'   F6 C2                 	OR	0C2H
  0B38'   32 0B41'              	LD	(USB3),A
  0B3B'   ED 4B 1588'           	LD	BC,(DDAF)
  0B3F'   C5                    	PUSH	BC
  0B40'   F1                    	POP	AF
  0B41'   00                    USB3:	NOP
  0B42'   0AD7'                 	DW	J26
  0B44'   23                    	INC	HL
  0B45'   C9                    	RET
                                
  0B46'   7E                    J34:	LD	A,M
  0B47'   E6 18                 	AND	018H
  0B49'   F6 C2                 	OR	0C2H
  0B4B'   32 0B54'              	LD	(USB4),A
  0B4E'   ED 4B 1588'           	LD	BC,(DDAF)
  0B52'   C5                    	PUSH	BC
  0B53'   F1                    	POP	AF
  0B54'   00                    USB4:	NOP
  0B55'   0AEF'                 	DW	J28
  0B57'   23                    	INC	HL
  0B58'   23                    	INC	HL
  0B59'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-9


                                
                                ;****************************************************************
                                ;*               einen  USER - Befehl  ausfuehren               *
                                ;****************************************************************
  0B5A'   7E                    C08:	LD	A,M
  0B5B'   FE C9                 	CP	0C9H
  0B5D'   CA 0AD7'              	JP	Z,J26
  0B60'   FE CD                 	CP	0CDH
  0B62'   CA 0AB1'              	JP	Z,J22
  0B65'   FE C3                 	CP	0C3H
  0B67'   CA 0AE9'              	JP	Z,J27
  0B6A'   FE 18                 	CP	018H
  0B6C'   CA 0AEF'              	JP	Z,J28
  0B6F'   FE 10                 	CP	010H
  0B71'   CA 0AFF'              	JP	Z,J30
  0B74'   FE E9                 	CP	0E9H
  0B76'   CA 0ACB'              	JP	Z,J23
  0B79'   E6 E7                 	AND	0E7H
  0B7B'   FE 20                 	CP	020H
  0B7D'   28 C7                 	JR	Z,J34
  0B7F'   E6 C7                 	AND	0C7H
  0B81'   FE C2                 	CP	0C2H
  0B83'   28 9D                 	JR	Z,J32
  0B85'   FE C4                 	CP	0C4H
  0B87'   CA 0B0D'              	JP	Z,J31
  0B8A'   FE C7                 	CP	0C7H
  0B8C'   CA 0A98'              	JP	Z,J21
  0B8F'   FE C0                 	CP	0C0H
  0B91'   28 A0                 	JR	Z,J33
  0B93'   7E                    	LD	A,M
  0B94'   FE ED                 	CP	0EDH
  0B96'   20 10                 	JR	NZ,J35
  0B98'   23                    	INC	HL
  0B99'   7E                    	LD	A,M
  0B9A'   2B                    	DEC	HL
  0B9B'   FE 4D                 	CP	04DH
  0B9D'   CA 0AD7'              	JP	Z,J26
  0BA0'   FE 45                 	CP	045H
  0BA2'   CA 0AD7'              	JP	Z,J26
  0BA5'   C3 0A68'              J341:	JP	J20
                                
  0BA8'   7E                    J35:	LD	A,M
  0BA9'   E6 DF                 	AND	0DFH
  0BAB'   FE DD                 	CP	0DDH
  0BAD'   20 F6                 	JR	NZ,J341
  0BAF'   23                    	INC	HL
  0BB0'   7E                    	LD	A,M
  0BB1'   2B                    	DEC	HL
  0BB2'   FE E9                 	CP	0E9H
  0BB4'   20 EF                 	JR	NZ,J341
  0BB6'   7E                    	LD	A,M
  0BB7'   FE DD                 	CP	0DDH
  0BB9'   CA 0ACF'              	JP	Z,J24
  0BBC'   C3 0AD3'              	JP	J25
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-10


                                
  0BBF'   7E                    C09:	LD	A,M	;Vektor mit  CON / LIST  ausgeben
  0BC0'   B7                    	OR	A	;Vektorende wird durch 00H angezeigt
  0BC1'   C8                    	RET	Z
  0BC2'   4F                    	LD	C,A
  0BC3'   23                    	INC	HL
  0BC4'   CD 0940'              	CALL	C04
  0BC7'   18 F6                 	JR	C09
                                
  0BC9'   7C                    C10:	LD	A,H
  0BCA'   CD 0C07'              	CALL	C15
  0BCD'   7D                    	LD	A,L
  0BCE'   18 37                 	JR	C15
                                
  0BD0'   F5                    C11:	PUSH	AF
  0BD1'   1F                    	RRA
  0BD2'   1F                    	RRA
  0BD3'   1F                    	RRA
  0BD4'   1F                    	RRA
  0BD5'   CD 0BD9'              	CALL	C12
  0BD8'   F1                    	POP	AF
  0BD9'   E6 0F                 C12:	AND	00FH
  0BDB'   C6 30                 	ADD	A,030H
  0BDD'   FE 3A                 	CP	03AH
  0BDF'   38 02                 	JR	C,C13
  0BE1'   C6 07                 	ADD	A,007H
                                
  0BE3'   4F                    C13:	LD	C,A
  0BE4'   C3 0940'              	JP	C04
                                
  0BE7'   CD 0C56'              C131:	CALL	C50
  0BEA'   CD 0BE3'              	CALL	C13
  0BED'   C3 0C57'              	JP	C51
                                
  0BF0'   CD 0C56'              C111:	CALL	C50
  0BF3'   CD 0BD0'              	CALL	C11
  0BF6'   C3 0C57'              	JP	C51
                                
  0BF9'   0E 0A                 C14:	LD	C,00AH
  0BFB'   C3 0940'              	JP	C04
                                
  0BFE'   CD 0C56'              C141:	CALL	C50
  0C01'   CD 0BF9'              	CALL	C14
  0C04'   C3 0C57'              	JP	C51
                                
  0C07'   CD 0BD0'              C15:	CALL	C11
  0C0A'   0E 20                 	LD	C,' '
  0C0C'   C3 0940'              	JP	C04
                                
  0C0F'   C5                    C16:	PUSH	BC
  0C10'   78                    	LD	A,B
  0C11'   CD 0BD0'              	CALL	C11
  0C14'   C1                    	POP	BC
  0C15'   79                    	LD	A,C
  0C16'   18 EF                 	JR	C15
                                
  0C18'   CD 0C56'              C161:	CALL	C50
  0C1B'   CD 0C0F'              	CALL	C16
  0C1E'   C3 0C57'              	JP	C51
                                
  0C21'   E5                    C17:	PUSH	HL
  0C22'   21 0000               	LD	HL,0
  0C25'   CD 085C'              C171:	CALL	CIN
  0C28'   CD 0BE3'              	CALL	C13
  0C2B'   CD 0C41'              	CALL	C18
  0C2E'   38 21                 	JR	C,J36
  0C30'   29                    	ADD	HL,HL
  0C31'   29                    	ADD	HL,HL
  0C32'   29                    	ADD	HL,HL
  0C33'   29                    	ADD	HL,HL
  0C34'   B5                    	OR	L
  0C35'   6F                    	LD	L,A
  0C36'   18 ED                 	JR	C171
                                
  0C38'   CD 0C56'              C172:	CALL	C50
  0C3B'   CD 0C21'              	CALL	C17
  0C3E'   C3 0C57'              	JP	C51
                                
  0C41'   D6 30                 C18:	SUB	030H
  0C43'   D8                    	RET	C
  0C44'   FE 17                 	CP	017H
  0C46'   3F                    	CCF
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-11


  0C47'   D8                    	RET	C
  0C48'   FE 0A                 	CP	00AH
  0C4A'   3F                    	CCF
  0C4B'   D0                    	RET	NC
  0C4C'   D6 07                 	SUB	007H
  0C4E'   FE 0A                 	CP	00AH
  0C50'   C9                    	RET
                                
  0C51'   79                    J36:	LD	A,C
  0C52'   E5                    	PUSH	HL
  0C53'   C1                    	POP	BC
  0C54'   E1                    	POP	HL
  0C55'   C9                    	RET
                                
  0C56'   C9                    C50:	RET
                                
  0C57'   C9                    C51:	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-12


                                
                                ;****************************************************************
                                ;*               Kopfzeilen ausgeben                            *
                                ;****************************************************************
  0C58'                         C60	EQU	$
  0C58'   CD 0BBF'              	CALL	C09
                                
                                	IF	V1 AND 1
  0C5B'   21 0E50'              	LD	HL,TXT11
  0C5E'   CD 0BBF'              	CALL	C09
                                	ENDIF
                                
  0C61'   CD 0BF9'              	CALL	C14
  0C64'   21 0E61'              	LD	HL,TXT12
  0C67'   CD 0BBF'              	CALL	C09
                                
                                	IF	V1 AND 1
  0C6A'   21 0E83'              	LD	HL,TXT13
  0C6D'   CD 0BBF'              	CALL	C09
                                	ENDIF
                                
  0C70'   CD 0BF9'              	CALL	C14
                                
                                	IF	V1 AND 2
                                	LD	HL,TXT11
                                	CALL	C09
                                	LD	HL,TXT13
                                	CALL	C09
                                	CALL	C14
                                	ENDIF
                                
  0C73'   CD 0BF9'              	CALL	C14
  0C76'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-13


                                
  0C77'                         C211	EQU	$
  0C77'   3A 1238'              	LD	A,(ST1)
  0C7A'   B7                    	OR	A
  0C7B'   C8                    	RET	Z
  0C7C'   32 1239'              	LD	(ST2),A
  0C7F'   CD 0C87'              	CALL	C21
  0C82'   AF                    	XOR	A
  0C83'   32 1239'              	LD	(ST2),A
  0C86'   C9                    	RET
                                
  0C87'   E5                    C21:	PUSH	HL	;Registeranzeige BWS bzw. Drucker
                                
  0C88'   CD 0D08'              	CALL	C30
                                
  0C8B'   3A 123C'              	LD	A,(ST4)	;Speicherbereiche anzeigen ?
  0C8E'   B7                    	OR	A
  0C8F'   28 21                 	JR	Z,J38
  0C91'   F5                    	PUSH	AF
  0C92'   21 0EA5'              	LD	HL,TXT2
  0C95'   CD 0BBF'              	CALL	C09
  0C98'   F1                    	POP	AF
  0C99'   21 1269'              	LD	HL,ST9
  0C9C'   5E                    J39:	LD	E,M
  0C9D'   23                    	INC	HL
  0C9E'   56                    	LD	D,M
  0C9F'   23                    	INC	HL
  0CA0'   EB                    	EX	DE,HL
  0CA1'   F5                    	PUSH	AF
  0CA2'   D5                    	PUSH	DE
  0CA3'   CD 0CB4'              	CALL	C22
  0CA6'   D1                    	POP	DE
  0CA7'   F1                    	POP	AF
  0CA8'   EB                    	EX	DE,HL
  0CA9'   3D                    	DEC	A
  0CAA'   20 F0                 	JR	NZ,J39
  0CAC'   CD 0BF9'              	CALL	C14
  0CAF'   CD 0BF9'              	CALL	C14
                                
  0CB2'                         J38	EQU	$
  0CB2'   E1                    	POP	HL
  0CB3'   C9                    	RET
                                
  0CB4'   E5                    C22:	PUSH	HL
  0CB5'   C1                    	POP	BC
  0CB6'   CD 0C0F'              	CALL	C16
  0CB9'   06 10                 	LD	B,16
  0CBB'   C5                    	PUSH	BC
  0CBC'   7E                    	LD	A,M
  0CBD'   CD 0C07'              	CALL	C15
  0CC0'   23                    	INC	HL
  0CC1'   C1                    	POP	BC
  0CC2'   10 F7                 	DJNZ	$-07	;8DD5
  0CC4'   CD 0BF9'              	CALL	C14
  0CC7'   C9                    	RET
                                
  0CC8'   CB 7F                 C23:	BIT	7,A	;Flags anzeigen
  0CCA'   CD 0CFC'              	CALL	C25
  0CCD'   CB 77                 	BIT	6,A
  0CCF'   CD 0CFC'              	CALL	C25
  0CD2'   CD 0CF4'              	CALL	C24
  0CD5'   CB 67                 	BIT	4,A
  0CD7'   CD 0CFC'              	CALL	C25
  0CDA'   CD 0CF4'              	CALL	C24
  0CDD'   CB 57                 	BIT	2,A
  0CDF'   CD 0CFC'              	CALL	C25
  0CE2'   CB 4F                 	BIT	1,A
  0CE4'   CD 0CFC'              	CALL	C25
  0CE7'   CB 47                 	BIT	0,A
  0CE9'   CD 0CFC'              	CALL	C25
  0CEC'   0E 20                 	LD	C,' '
  0CEE'   CD 0940'              	CALL	C04
  0CF1'   C3 0940'              	JP	C04
                                
  0CF4'   F5                    C24:	PUSH	AF
  0CF5'   0E 20                 	LD	C,' '
  0CF7'   CD 0940'              	CALL	C04
  0CFA'   F1                    	POP	AF
  0CFB'   C9                    	RET
                                
  0CFC'   F5                    C25:	PUSH	AF
  0CFD'   0E 2A                 	LD	C,'*'
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-14


  0CFF'   20 02                 	JR	NZ,$+04	;8E1A
  0D01'   0E 2E                 	LD	C,'.'
  0D03'   CD 0940'              	CALL	C04
  0D06'   F1                    	POP	AF
  0D07'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-15


                                
  0D08'   2A 1588'              C30:	LD	HL,(DDAF)	;Flags anzeigen
  0D0B'   7D                    	LD	A,L
  0D0C'   CD 0CC8'              	CALL	C23
  0D0F'   7C                    	LD	A,H	;Reg. A   anzeigen
  0D10'   CD 0C07'              	CALL	C15
  0D13'   ED 4B 1582'           	LD	BC,(DDBC)	;Reg. BC  anzeigen
  0D17'   CD 0C0F'              	CALL	C16
  0D1A'   ED 4B 1584'           	LD	BC,(DDDE)	;Reg. DE  anzeigen
  0D1E'   CD 0C0F'              	CALL	C16
  0D21'   ED 4B 1586'           	LD	BC,(DDHL)	;Reg. HL  anzeigen
  0D25'   C5                    	PUSH	BC
  0D26'   CD 0C0F'              	CALL	C16
  0D29'   CD 0940'              	CALL	C04
  0D2C'   C1                    	POP	BC
  0D2D'   0A                    	LD	A,(BC)	;Inh. HL  anzeigen
  0D2E'   CD 0C07'              	CALL	C15
  0D31'   CD 0940'              	CALL	C04
  0D34'   CD 0940'              	CALL	C04
  0D37'   ED 4B 1576'           	LD	BC,(DDIX)	;Reg. IX  anzeigen
  0D3B'   C5                    	PUSH	BC
  0D3C'   CD 0C0F'              	CALL	C16
  0D3F'   C1                    	POP	BC
  0D40'   0A                    	LD	A,(BC)	;Inh. IX  anzeigen
  0D41'   CD 0C07'              	CALL	C15
  0D44'   ED 4B 1578'           	LD	BC,(DDIY)	;Reg. IY  anzeigen
  0D48'   C5                    	PUSH	BC
  0D49'   CD 0C0F'              	CALL	C16
  0D4C'   C1                    	POP	BC
  0D4D'   0A                    	LD	A,(BC)	;Inh. IY  anzeigen
  0D4E'   CD 0C07'              	CALL	C15
  0D51'   CD 0940'              	CALL	C04
  0D54'   CD 0940'              	CALL	C04
  0D57'   3A 1570'              	LD	A,(DDI)	;Reg. I   anzeigen
  0D5A'   CD 0C07'              	CALL	C15
  0D5D'   3A 1571'              	LD	A,(DDR)	;Reg. R   anzeigen
  0D60'   CD 0C07'              	CALL	C15
  0D63'   CD 0940'              	CALL	C04
  0D66'   CD 0940'              	CALL	C04
  0D69'   CD 0940'              	CALL	C04
  0D6C'   CD 0940'              	CALL	C04
                                
                                	IF	V1 AND 1
  0D6F'   E1                    	POP	HL	;Reg. PC anzeigen
  0D70'   C1                    	POP	BC
  0D71'   C5                    	PUSH	BC
  0D72'   E5                    	PUSH	HL
  0D73'   CD 0C0F'              	CALL	C16
  0D76'   C1                    	POP	BC	;Befehl   anzeigen
  0D77'   E1                    	POP	HL
  0D78'   E5                    	PUSH	HL
  0D79'   C5                    	PUSH	BC
  0D7A'   CD 0958'              	CALL	C05
  0D7D'   7E                    C31:	LD	A,M
  0D7E'   23                    	INC	HL
  0D7F'   C5                    	PUSH	BC
  0D80'   CD 0C07'              	CALL	C15
  0D83'   C1                    	POP	BC
  0D84'   10 F7                 	DJNZ	C31
                                	ENDIF
                                
  0D86'   CD 0BF9'              	CALL	C14	;Zeilenende ausgeben
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-16


                                
  0D89'   2A 1580'              	LD	HL,(DDAFS)	;S Flags  anzeigen
  0D8C'   7D                    	LD	A,L
  0D8D'   CD 0CC8'              	CALL	C23
  0D90'   7C                    	LD	A,H	;Reg. A s anzeigen
  0D91'   CD 0C07'              	CALL	C15
  0D94'   ED 4B 157A'           	LD	BC,(DDBCS)	;Reg. BCs anzeigen
  0D98'   CD 0C0F'              	CALL	C16
  0D9B'   ED 4B 157C'           	LD	BC,(DDDES)	;Reg. DEs anzeigen
  0D9F'   CD 0C0F'              	CALL	C16
  0DA2'   ED 4B 157E'           	LD	BC,(DDHLS)	;Reg. HLs anzeigen
  0DA6'   C5                    	PUSH	BC
  0DA7'   CD 0C0F'              	CALL	C16
  0DAA'   CD 0940'              	CALL	C04
  0DAD'   C1                    	POP	BC
  0DAE'   0A                    	LD	A,(BC)	;Inh. HLs anzeigen
  0DAF'   CD 0C07'              	CALL	C15
  0DB2'   CD 0940'              	CALL	C04
  0DB5'   CD 0940'              	CALL	C04
                                
                                	IF	V1 AND 1
  0DB8'   ED 4B 1574'           	LD	BC,(DDSP)	;Reg. SP  anzeigen
  0DBC'   C5                    	PUSH	BC
  0DBD'   CD 0C0F'              	CALL	C16
  0DC0'   CD 0940'              	CALL	C04
  0DC3'   CD 0940'              	CALL	C04
  0DC6'   CD 0940'              	CALL	C04
  0DC9'   D1                    	POP	DE	;Inh. Keller anzeigen
  0DCA'   1B                    	DEC	DE
  0DCB'   1B                    	DEC	DE
  0DCC'   1B                    	DEC	DE
  0DCD'   1B                    	DEC	DE
  0DCE'   06 05                 	LD	B,5
  0DD0'   C5                    C32:	PUSH	BC
  0DD1'   1A                    	LD	A,(DE)
  0DD2'   4F                    	LD	C,A
  0DD3'   13                    	INC	DE
  0DD4'   1A                    	LD	A,(DE)
  0DD5'   47                    	LD	B,A
  0DD6'   13                    	INC	DE
  0DD7'   CD 0C0F'              	CALL	C16
  0DDA'   C1                    	POP	BC
  0DDB'   10 F3                 	DJNZ	C32
                                	ENDIF
                                
  0DDD'   CD 0BF9'              	CALL	C14	;Zeilenende ausgeben
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-17


                                
                                	IF	V1 AND 2
                                	POP	HL	;Reg. PC anzeigen
                                	POP	BC
                                	PUSH	BC
                                	PUSH	HL
                                	CALL	C16
                                	POP	BC	;Befehl   anzeigen
                                	POP	HL
                                	PUSH	HL
                                	PUSH	BC
                                	CALL	C05
                                C31:	LD	A,M
                                	INC	HL
                                	PUSH	BC
                                	CALL	C15
                                	POP	BC
                                	DJNZ	C31
                                	LD	BC,(DDSP)	;Reg. SP  anzeigen
                                	PUSH	BC
                                	CALL	C16
                                	CALL	C04
                                	CALL	C04
                                	CALL	C04
                                	POP	DE	;Inh. Keller anzeigen
                                	DEC	DE
                                	DEC	DE
                                	DEC	DE
                                	DEC	DE
                                	LD	B,5
                                C32:	PUSH	BC
                                	LD	A,(DE)
                                	LD	C,A
                                	INC	DE
                                	LD	A,(DE)
                                	LD	B,A
                                	INC	DE
                                	CALL	C16
                                	POP	BC
                                	DJNZ	C32
                                	CALL	C14	;Zeilenende ausgeben
                                	ENDIF
                                
  0DE0'   CD 0BF9'              	CALL	C14
  0DE3'   C9                    	RET
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-18


                                
                                ;****************************************************************
                                ;*               Zeichenketten                                  *
                                ;****************************************************************
  0DE4'                         TXT1	EQU	$
  0DE4'   0C                    	DB	00CH
  0DE5'   44 45 47 32           	DB	'DEG2000   Software-TRACE    V1.1  31.01.85'
  0DE9'   30 30 30 20           
  0DED'   20 20 53 6F           
  0DF1'   66 74 77 61           
  0DF5'   72 65 2D 54           
  0DF9'   52 41 43 45           
  0DFD'   20 20 20 20           
  0E01'   56 31 2E 31           
  0E05'   20 20 33 31           
  0E09'   2E 30 31 2E           
  0E0D'   38 35                 
  0E0F'   0A0A                  	DW	00A0AH
  0E11'   73 7A 5F 68           	DB	'sz_h_pnc__A__B_C__D_E__H_L__(HL_)_IX______IY________'
  0E15'   5F 70 6E 63           
  0E19'   5F 5F 41 5F           
  0E1D'   5F 42 5F 43           
  0E21'   5F 5F 44 5F           
  0E25'   45 5F 5F 48           
  0E29'   5F 4C 5F 5F           
  0E2D'   28 48 4C 5F           
  0E31'   29 5F 49 58           
  0E35'   5F 5F 5F 5F           
  0E39'   5F 5F 49 59           
  0E3D'   5F 5F 5F 5F           
  0E41'   5F 5F 5F 5F           
  0E45'   49 5F 5F 52           	DB	'I__R______'
  0E49'   5F 5F 5F 5F           
  0E4D'   5F 5F                 
  0E4F'   00                    	DB	0
  0E50'   50 43 5F 5F           TXT11:	DB	'PC___Befehl_____'
  0E54'   5F 42 65 66           
  0E58'   65 68 6C 5F           
  0E5C'   5F 5F 5F 5F           
  0E60'   00                    	DB	0
  0E61'   73 7A 5F 68           TXT12:	DB	'sz_h_pnc__A'
  0E65'   5F 70 6E 63           
  0E69'   5F 5F 41              
  0E6C'   27                    	DB	27H
  0E6D'   5F 42                 	DB	'_B'
  0E6F'   27                    	DB	27H
  0E70'   43                    	DB	'C'
  0E71'   27                    	DB	27H
  0E72'   5F 44                 	DB	'_D'
  0E74'   27                    	DB	27H
  0E75'   45                    	DB	'E'
  0E76'   27                    	DB	27H
  0E77'   5F 48                 	DB	'_H'
  0E79'   27                    	DB	27H
  0E7A'   4C                    	DB	'L'
  0E7B'   27                    	DB	27H
  0E7C'   5F 28 48 4C           	DB	'_(HL'
  0E80'   27                    	DB	27H
  0E81'   29                    	DB	')'
  0E82'   00                    	DB	0
  0E83'   5F 53 50 5F           TXT13:	DB	'_SP______-4___-2____0___+2___+4__'
  0E87'   5F 5F 5F 5F           
  0E8B'   5F 2D 34 5F           
  0E8F'   5F 5F 2D 32           
  0E93'   5F 5F 5F 5F           
  0E97'   30 5F 5F 5F           
  0E9B'   2B 32 5F 5F           
  0E9F'   5F 2B 34 5F           
  0EA3'   5F                    
  0EA4'   00                    	DB	0
  0EA5'   4D 45 4D 5F           TXT2:	DB	'MEM__0__1__2__3__4__5__6__7__8__9__A__B__C__D__E__F_'
  0EA9'   5F 30 5F 5F           
  0EAD'   31 5F 5F 32           
  0EB1'   5F 5F 33 5F           
  0EB5'   5F 34 5F 5F           
  0EB9'   35 5F 5F 36           
  0EBD'   5F 5F 37 5F           
  0EC1'   5F 38 5F 5F           
  0EC5'   39 5F 5F 41           
  0EC9'   5F 5F 42 5F           
  0ECD'   5F 43 5F 5F           
  0ED1'   44 5F 5F 45           
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-19


  0ED5'   5F 5F 46 5F           
  0ED9'   000A                  	DW	0000AH
  0EDB'   4B 6F 6D 6D           TXT3:	DB	'Kommando: '
  0EDF'   61 6E 64 6F           
  0EE3'   3A 20                 
  0EE5'   00                    	DB	0
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-20


                                
  0EE6'   0EE6'                 	DW	$
  0EE8'   54 52 41 43           	DB	'TRAC'
  0EEC'   21 122D'              MAIN:	LD	HL,STPO
  0EEF'   11 0DB2               	LD	DE,ZPOS
  0EF2'   01 0006               	LD	BC,6
  0EF5'   ED B0                 	LDIR
  0EF7'   ED 73 1574'           	LD	(DDSP),SP
  0EFB'   31 1569'              	LD	SP,STSP
  0EFE'   CD 09EE'              	CALL	C06
  0F01'   ED 7B 1574'           	LD	SP,(DDSP)
  0F05'   E1                    	POP	HL
  0F06'   22 1572'              	LD	(DDPC),HL
  0F09'   18 09                 	JR	SUB
                                
  0F0B'   0F0B'                 	DW	$
  0F0D'   54 52 41 52           	DB	'TRAR'
  0F11'   CD 081A'              	CALL	BWSUS
  0F14'   31 1569'              SUB:	LD	SP,STSP
  0F17'   3E 45                 	LD	A,69
  0F19'   32 156C'              	LD	(ZZ),A
  0F1C'   AF                    	XOR	A
  0F1D'   32 156D'              	LD	(CST),A
  0F20'   32 1238'              	LD	(ST1),A
  0F23'   32 1239'              	LD	(ST2),A
  0F26'   32 123C'              	LD	(ST4),A
  0F29'   32 123D'              	LD	(ST5),A
                                
  0F2C'   2A 1572'              	LD	HL,(DDPC)
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-21


                                
  0F2F'                         J40	EQU	$
  0F2F'   E5                    J401:	PUSH	HL
  0F30'   D5                    	PUSH	DE
  0F31'   C5                    	PUSH	BC
  0F32'   21 122D'              	LD	HL,STPO
  0F35'   11 0DB2               	LD	DE,ZPOS
  0F38'   01 0006               	LD	BC,6
  0F3B'   ED B0                 	LDIR
  0F3D'   21 0DE4'              	LD	HL,TXT1
  0F40'   CD 0C58'              	CALL	C60
  0F43'   C1                    	POP	BC
  0F44'   D1                    	POP	DE
  0F45'   E1                    	POP	HL
  0F46'   CD 0C87'              	CALL	C21
  0F49'   CD 0C77'              	CALL	C211
  0F4C'   E5                    	PUSH	HL
  0F4D'   D5                    	PUSH	DE
  0F4E'   C5                    	PUSH	BC
  0F4F'   21 0EDB'              	LD	HL,TXT3
  0F52'   CD 0BBF'              	CALL	C09
  0F55'   C1                    	POP	BC
  0F56'   D1                    	POP	DE
  0F57'   E1                    	POP	HL
  0F58'   CD 085C'              	CALL	CIN
  0F5B'   22 1572'              	LD	(DDPC),HL
  0F5E'   CD 0BE7'              	CALL	C131
  0F61'   FE 2C                 	CP	','
  0F63'   28 58                 	JR	Z,J45
  0F65'   FE 3B                 	CP	';'
  0F67'   28 5A                 	JR	Z,J44
  0F69'   FE 50                 	CP	'P'
  0F6B'   CA 0FDB'              	JP	Z,J46
  0F6E'   FE 4E                 	CP	'N'
  0F70'   CA 0FE3'              	JP	Z,J47
  0F73'   FE 55                 	CP	'U'
  0F75'   CA 1002'              	JP	Z,J49
  0F78'   FE 4D                 	CP	'M'
  0F7A'   CA 1017'              	JP	Z,J51
  0F7D'   FE 47                 	CP	'G'
  0F7F'   CA 1054'              	JP	Z,J53
  0F82'   FE 53                 	CP	'S'
  0F84'   CA 10F9'              	JP	Z,J56
  0F87'   FE 54                 	CP	'T'
  0F89'   CA 1205'              	JP	Z,J62
  0F8C'   FE 42                 	CP	'B'
  0F8E'   28 02                 	JR	Z,J41
  0F90'   18 9D                 	JR	J40
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-22


                                
  0F92'   CD 085C'              J41:	CALL	CIN	;Kommandos:  B .
  0F95'   CD 0BE7'              	CALL	C131
  0F98'   FE 4B                 	CP	'K'
  0F9A'   CA 104A'              	JP	Z,J411
  0F9D'   FE 59                 	CP	'Y'	;Kommando:  B Y E
  0F9F'   20 8E                 	JR	NZ,J40
  0FA1'   CD 085C'              	CALL	CIN
  0FA4'   CD 0BE7'              	CALL	C131
  0FA7'   FE 45                 	CP	'E'
  0FA9'   C2 0F2F'              	JP	NZ,J40
  0FAC'   CD 085C'              	CALL	CIN
  0FAF'   CD 0BE7'              	CALL	C131
  0FB2'   FE 0D                 	CP	00DH
  0FB4'   C2 0F2F'              	JP	NZ,J40
  0FB7'   CD 081A'              SYTB:	CALL	BWSUS
  0FBA'   C3 080E'              	JP	SYSTB
                                
  0FBD'   CD 0B5A'              J45:	CALL	C08	;Kommando:  ,
  0FC0'   C3 0F2F'              	JP	J40
                                
  0FC3'   E5                    J44:	PUSH	HL	;Kommando:  ;
  0FC4'   3A 1238'              	LD	A,(ST1)
  0FC7'   B7                    	OR	A
  0FC8'   28 0D                 	JR	Z,J441
  0FCA'   32 1239'              	LD	(ST2),A
  0FCD'   21 0DE5'              	LD	HL,TXT1+1
  0FD0'   CD 0C58'              	CALL	C60
  0FD3'   AF                    	XOR	A
  0FD4'   32 1239'              	LD	(ST2),A
  0FD7'   E1                    J441:	POP	HL
  0FD8'   C3 0F2F'              	JP	J40
                                
  0FDB'   CD 0C38'              J46:	CALL	C172	;Kommando:  P
  0FDE'   C5                    	PUSH	BC
  0FDF'   E1                    	POP	HL
  0FE0'   C3 0F2F'              	JP	J40
                                
  0FE3'   CD 0C38'              J47:	CALL	C172	;Kommando:  N
  0FE6'   C5                    J471:	PUSH	BC
  0FE7'   CD 0B5A'              	CALL	C08
  0FEA'   CD 08C0'              	CALL	CSTS
  0FED'   20 0F                 	JR	NZ,J48
  0FEF'   CD 0C87'              	CALL	C21
  0FF2'   CD 0C77'              	CALL	C211
  0FF5'   C1                    	POP	BC
  0FF6'   0B                    	DEC	BC
  0FF7'   78                    	LD	A,B
  0FF8'   B1                    	OR	C
  0FF9'   20 EB                 	JR	NZ,J471
  0FFB'   C3 0F2F'              	JP	J401
                                
  0FFE'   C1                    J48:	POP	BC
  0FFF'   C3 0F2F'              	JP	J40
                                
  1002'   CD 0C38'              J49:	CALL	C172	;Kommando:  U
  1005'   C5                    J50:	PUSH	BC
  1006'   CD 0B5A'              	CALL	C08
  1009'   CD 08C0'              	CALL	CSTS
  100C'   20 F0                 	JR	NZ,J48
  100E'   C1                    	POP	BC
  100F'   0B                    	DEC	BC
  1010'   78                    	LD	A,B
  1011'   B1                    	OR	C
  1012'   20 F1                 	JR	NZ,J50
  1014'   C3 0F2F'              	JP	J40
                                
  1017'   E5                    J51:	PUSH	HL
  1018'   CD 085C'              	CALL	CIN
  101B'   CD 0BE7'              	CALL	C131
  101E'   FE 43                 	CP	'C'
  1020'   20 08                 	JR	NZ,J52
  1022'   AF                    	XOR	A	;Kommando:  M C
  1023'   32 123C'              	LD	(ST4),A
  1026'   E1                    J511:	POP	HL
  1027'   C3 0F2F'              	JP	J40
                                
  102A'   FE 53                 J52:	CP	'S'
  102C'   20 F8                 	JR	NZ,J511
  102E'   3A 123C'              	LD	A,(ST4)	;Kommando:  M S
  1031'   3C                    	INC	A
  1032'   32 123C'              	LD	(ST4),A
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-23


  1035'   07                    	RLCA
  1036'   5F                    	LD	E,A
  1037'   16 00                 	LD	D,0
  1039'   21 1267'              	LD	HL,ST8
  103C'   19                    	ADD	HL,DE
  103D'   CD 0C38'              	CALL	C172
  1040'   79                    	LD	A,C
  1041'   E6 F0                 	AND	0F0H
  1043'   77                    	LD	M,A
  1044'   23                    	INC	HL
  1045'   70                    	LD	M,B
  1046'   E1                    	POP	HL
  1047'   C3 0F2F'              	JP	J40
                                
  104A'   AF                    J411:	XOR	A	;Kommando:  B K
  104B'   32 123D'              	LD	(ST5),A
  104E'   E5                    	PUSH	HL
  104F'   22 1087'              	LD	(USB90+1),HL
  1052'   18 35                 	JR	J552
                                
  1054'   AF                    J53:	XOR	A	;Kommando:  G
  1055'   32 123D'              	LD	(ST5),A
  1058'   E5                    	PUSH	HL
  1059'   CD 0C38'              	CALL	C172
  105C'   60                    	LD	H,B
  105D'   69                    	LD	L,C
  105E'   22 1087'              	LD	(USB90+1),HL
  1061'   FE 2C                 	CP	','
  1063'   28 24                 	JR	Z,J552
  1065'   FE 0D                 	CP	00DH
  1067'   28 07                 	JR	Z,J55
  1069'   E1                    J54:	POP	HL
  106A'   2A 123A'              	LD	HL,(ST3)
  106D'   C3 0F2F'              	JP	J40
                                
  1070'   3E C3                 J55:	LD	A,0C3H
  1072'   32 0FF9               	LD	(00FF9H),A
  1075'   21 10C8'              	LD	HL,J551
  1078'   22 0FFA               	LD	(00FFAH),HL
  107B'   CD 0A2B'              	CALL	C07
  107E'   ED 73 1569'           	LD	(STSP),SP
  1082'   ED 7B 1574'           	LD	SP,(DDSP)
  1086'   C3 0000               USB90:	JP	0
                                
  1089'   AF                    J552:	XOR	A
  108A'   57                    	LD	D,A
  108B'   21 123E'              	LD	HL,ST6
  108E'   CD 0C38'              J553:	CALL	C172
  1091'   5F                    	LD	E,A
  1092'   71                    	LD	M,C
  1093'   23                    	INC	HL
  1094'   70                    	LD	M,B
  1095'   23                    	INC	HL
  1096'   14                    	INC	D
  1097'   7A                    	LD	A,D
  1098'   FE 05                 	CP	5
  109A'   32 123D'              	LD	(ST5),A
  109D'   28 CA                 	JR	Z,J54
  109F'   7B                    	LD	A,E
  10A0'   FE 0D                 	CP	00DH
  10A2'   20 EA                 	JR	NZ,J553
  10A4'   21 123E'              	LD	HL,ST6
  10A7'   DD 21 1246'           	LD	IX,ST7
  10AB'   4E                    J554:	LD	C,M
  10AC'   23                    	INC	HL
  10AD'   46                    	LD	B,M
  10AE'   23                    	INC	HL
  10AF'   0A                    	LD	A,(BC)
  10B0'   DD 77 00              	LD	(IX+00),A
  10B3'   DD 23                 	INC	IX
  10B5'   3E FF                 	LD	A,0FFH
  10B7'   02                    	LD	(BC),A
  10B8'   15                    	DEC	D
  10B9'   20 F0                 	JR	NZ,J554
  10BB'   3E C3                 	LD	A,0C3H
  10BD'   32 0FF9               	LD	(00FF9H),A
  10C0'   21 10C8'              	LD	HL,J551
  10C3'   22 0FFA               	LD	(00FFAH),HL
  10C6'   18 A8                 	JR	J55
                                
  10C8'   E3                    J551:	EX	(SP),HL
  10C9'   2B                    	DEC	HL
  10CA'   22 123A'              	LD	(ST3),HL
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-24


  10CD'   E3                    	EX	(SP),HL
  10CE'   33                    	INC	SP
  10CF'   33                    	INC	SP
  10D0'   ED 73 1574'           	LD	(DDSP),SP
  10D4'   ED 7B 1569'           	LD	SP,(STSP)
  10D8'   CD 09EE'              	CALL	C06
  10DB'   3A 123D'              	LD	A,(ST5)
  10DE'   B7                    	OR	A
  10DF'   28 88                 	JR	Z,J54
  10E1'   57                    	LD	D,A
  10E2'   21 123E'              	LD	HL,ST6
  10E5'   DD 21 1246'           	LD	IX,ST7
  10E9'   4E                    J555:	LD	C,M
  10EA'   23                    	INC	HL
  10EB'   46                    	LD	B,M
  10EC'   23                    	INC	HL
  10ED'   DD 7E 00              	LD	A,(IX+00)
  10F0'   DD 23                 	INC	IX
  10F2'   02                    	LD	(BC),A
  10F3'   15                    	DEC	D
  10F4'   20 F3                 	JR	NZ,J555
  10F6'   C3 1069'              	JP	J54
                                
  10F9'   E5                    J56:	PUSH	HL	;Kommandos:  S .
  10FA'   CD 085C'              	CALL	CIN
  10FD'   CD 0BE7'              	CALL	C131
  1100'   FE 52                 	CP	'R'
  1102'   21 1588'              	LD	HL,DDAF
  1105'   3E 20                 	LD	A,' '
  1107'   CA 11A8'              	JP	Z,J60
  110A'   CD 0C38'              	CALL	C172	;Kommando:  S M
  110D'   60                    	LD	H,B
  110E'   69                    	LD	L,C
  110F'   FE 0D                 J57:	CP	00DH
  1111'   28 24                 	JR	Z,J58
  1113'   7E                    	LD	A,M
  1114'   CD 0BF0'              	CALL	C111
  1117'   0E 2D                 	LD	C,'-'
  1119'   CD 094F'              	CALL	C041
  111C'   CD 0C38'              	CALL	C172
  111F'   FE 2C                 	CP	','
  1121'   28 18                 	JR	Z,J59
  1123'   71                    	LD	M,C
  1124'   23                    	INC	HL
  1125'   FE 2E                 	CP	'.'
  1127'   28 02                 	JR	Z,J571
  1129'   18 E4                 	JR	J57
                                
  112B'   CD 0BFE'              J571:	CALL	C141
  112E'   E5                    	PUSH	HL
  112F'   C1                    	POP	BC
  1130'   CD 0C18'              	CALL	C161
  1133'   3E 01                 	LD	A,1
  1135'   18 D8                 	JR	J57
                                
  1137'   E1                    J58:	POP	HL
  1138'   C3 0F2F'              	JP	J40
                                
  113B'   23                    J59:	INC	HL
  113C'   18 D1                 	JR	J57
                                
  113E'   20 49                 TAB2:	DB	' I'
  1140'   1570'                 	DW	DDI
  1142'   01                    	DB	1
                                
  1143'   20 52                 	DB	' R'
  1145'   1571'                 	DW	DDR
  1147'   01                    	DB	1
                                
  1148'   20 41                 	DB	' A'
  114A'   1588'                 	DW	DDAF
  114C'   02                    	DB	2
                                
  114D'   20 42                 	DB	' B'
  114F'   1582'                 	DW	DDBC
  1151'   02                    	DB	2
                                
  1152'   20 43                 	DB	' C'
  1154'   1582'                 	DW	DDBC
  1156'   01                    	DB	1
                                
  1157'   20 44                 	DB	' D'
  1159'   1584'                 	DW	DDDE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-25


  115B'   02                    	DB	2
                                
  115C'   20 45                 	DB	' E'
  115E'   1584'                 	DW	DDDE
  1160'   01                    	DB	1
                                
  1161'   20 48                 	DB	' H'
  1163'   1586'                 	DW	DDHL
  1165'   02                    	DB	2
                                
  1166'   20 4C                 	DB	' L'
  1168'   1586'                 	DW	DDHL
  116A'   01                    	DB	1
                                
  116B'   20 46                 	DB	' F'
  116D'   1588'                 	DW	DDAF
  116F'   01                    	DB	1
                                
  1170'   58 49                 	DB	'XI'
  1172'   1576'                 	DW	DDIX
  1174'   00                    	DB	0
                                
  1175'   59 49                 	DB	'YI'
  1177'   1578'                 	DW	DDIY
  1179'   00                    	DB	0
                                
  117A'   50 53                 	DB	'PS'
  117C'   1574'                 	DW	DDSP
  117E'   00                    	DB	0
                                
  117F'   27                    	DB	27H
  1180'   41                    	DB	'A'
  1181'   1580'                 	DW	DDAFS
  1183'   02                    	DB	2
                                
  1184'   27                    	DB	27H
  1185'   42                    	DB	'B'
  1186'   157A'                 	DW	DDBCS
  1188'   02                    	DB	2
                                
  1189'   27                    	DB	27H
  118A'   43                    	DB	'C'
  118B'   157A'                 	DW	DDBCS
  118D'   01                    	DB	1
                                
  118E'   27                    	DB	27H
  118F'   44                    	DB	'D'
  1190'   157C'                 	DW	DDDES
  1192'   02                    	DB	2
                                
  1193'   27                    	DB	27H
  1194'   45                    	DB	'E'
  1195'   157C'                 	DW	DDDES
  1197'   01                    	DB	1
                                
  1198'   27                    	DB	27H
  1199'   48                    	DB	'H'
  119A'   157E'                 	DW	DDHLS
  119C'   02                    	DB	2
                                
  119D'   27                    	DB	27H
  119E'   4C                    	DB	'L'
  119F'   157E'                 	DW	DDHLS
  11A1'   01                    	DB	1
                                
  11A2'   27                    	DB	27H
  11A3'   46                    	DB	'F'
  11A4'   1580'                 	DW	DDAFS
  11A6'   01                    	DB	1
                                
  11A7'   00                    	DB	0
                                
  11A8'   CD 085C'              J60:	CALL	CIN	;Kommando:  S R
  11AB'   CD 0BE7'              	CALL	C131
  11AE'   57                    	LD	D,A
  11AF'   CD 085C'              	CALL	CIN
  11B2'   CD 0BE7'              	CALL	C131
  11B5'   5F                    	LD	E,A
  11B6'   0E 20                 	LD	C,' '
  11B8'   CD 094F'              	CALL	C041
  11BB'   01 113E'              	LD	BC,TAB2
  11BE'   0A                    J601:	LD	A,(BC)
  11BF'   B7                    	OR	A
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-26


  11C0'   CA 1137'              	JP	Z,J58
  11C3'   6F                    	LD	L,A
  11C4'   03                    	INC	BC
  11C5'   0A                    	LD	A,(BC)
  11C6'   67                    	LD	H,A
  11C7'   ED 52                 	SBC	HL,DE
  11C9'   28 06                 	JR	Z,J61
  11CB'   03                    	INC	BC
  11CC'   03                    	INC	BC
  11CD'   03                    	INC	BC
  11CE'   03                    	INC	BC
  11CF'   18 ED                 	JR	J601
                                
  11D1'   03                    J61:	INC	BC
  11D2'   0A                    	LD	A,(BC)
  11D3'   6F                    	LD	L,A
  11D4'   03                    	INC	BC
  11D5'   0A                    	LD	A,(BC)
  11D6'   67                    	LD	H,A
  11D7'   03                    	INC	BC
  11D8'   0A                    	LD	A,(BC)
  11D9'   B7                    	OR	A
  11DA'   20 14                 	JR	NZ,J611
  11DC'   4E                    	LD	C,M
  11DD'   23                    	INC	HL
  11DE'   46                    	LD	B,M
  11DF'   CD 0C18'              	CALL	C161
  11E2'   0E 2D                 	LD	C,'-'
  11E4'   CD 094F'              	CALL	C041
  11E7'   CD 0C38'              	CALL	C172
  11EA'   70                    	LD	M,B
  11EB'   2B                    	DEC	HL
  11EC'   71                    	LD	M,C
  11ED'   C3 1137'              	JP	J58
                                
  11F0'   3D                    J611:	DEC	A
  11F1'   4F                    	LD	C,A
  11F2'   06 00                 	LD	B,0
  11F4'   09                    	ADD	HL,BC
  11F5'   7E                    	LD	A,M
  11F6'   CD 0BF0'              	CALL	C111
  11F9'   0E 2D                 	LD	C,'-'
  11FB'   CD 094F'              	CALL	C041
  11FE'   CD 0C38'              	CALL	C172
  1201'   71                    	LD	M,C
  1202'   C3 1137'              	JP	J58
                                
  1205'   CD 085C'              J62:	CALL	CIN	;Kommandos:  T .
  1208'   CD 0BE7'              	CALL	C131
  120B'   FE 4E                 	CP	'N'
  120D'   20 17                 	JR	NZ,J621
  120F'   E5                    	PUSH	HL	;Kommando:  T N
  1210'   3E 01                 	LD	A,1
  1212'   32 1238'              	LD	(ST1),A
  1215'   32 1239'              	LD	(ST2),A
  1218'   21 0DE5'              	LD	HL,TXT1+1
  121B'   CD 0C58'              	CALL	C60
  121E'   AF                    	XOR	A
  121F'   32 1239'              	LD	(ST2),A
  1222'   E1                    	POP	HL
  1223'   C3 0F2F'              	JP	J40
                                
  1226'   AF                    J621:	XOR	A	;Kommando :  T O
  1227'   32 1238'              	LD	(ST1),A
  122A'   C3 0F2F'              	JP	J40
                                
                                	PAGE
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	1-27


                                
                                ;****************************************************************
                                ;*               Monitorvektor - Konstanten                     *
                                ;****************************************************************
  122D'   0000                  STPO:	DW	00000H	;ZPOS= 1 , SPOS= 1
  122F'   0101                  	DW	00101H	;ZMIN= 1 , SMIN= 1
  1231'   5018                  	DW	MAX	;ZMAX=24 , SMAX=80
                                
  1233'   20 20 20 20           RPOS:	DB	'     '	;BER	6
  1237'   20                    
  1238'   00                    ST1:	DB	0
  1239'   00                    ST2:	DB	0
  123A'   0000                  ST3:	DW	0
  123C'   00                    ST4:	DB	0
  123D'   00                    ST5:	DB	0
  123E'   20 20 20 20           ST6:	DB	'        '	;BER	8
  1242'   20 20 20 20           
  1246'                         ST7	EQU	$	;BER	33
                                	ORG	$+33
  1267'   0000                  ST8:	DW	0
  1269'                         ST9	EQU	$	;BER	300H
                                	ORG	$+300H
  1569'   0000                  STSP:	DW	0
                                
  5018                          MAX	EQU	05018H
                                
  0DB2                          ZPOS	EQU	00DB2H	;SM.ZPOS
                                
  156B'   00                    TK:	DB	0
  156C'   00                    ZZ:	DB	0
  156D'   00                    CST:	DB	0
                                
  156E'   00                    DDEI:	DB	0	;S2.DDEI
  156F'   00                    DDIM:	DB	0
  1570'   00                    DDI:	DB	0
  1571'   00                    DDR:	DB	0
  1572'   0000                  DDPC:	DW	0
  1574'   0000                  DDSP:	DW	0
  1576'   0000                  DDIX:	DW	0
  1578'   0000                  DDIY:	DW	0
  157A'   0000                  DDBCS:	DW	0
  157C'   0000                  DDDES:	DW	0
  157E'   0000                  DDHLS:	DW	0
  1580'   0000                  DDAFS:	DW	0
  1582'   0000                  DDBC:	DW	0
  1584'   0000                  DDDE:	DW	0
  1586'   0000                  DDHL:	DW	0
  1588'   0000                  DDAF:	DW	0
                                
                                	END
'S o f t w a r e  T R A C E   D E G 2 0 0 0'	MACRO-80 3.44	09-Dec-81	PAGE	S


Macros:

Symbols:
0000'	BWSA            083B'	BWSU1           081A'	BWSUS           
0940'	C04             094F'	C041            094B'	C042            
0958'	C05             09EE'	C06             0A2B'	C07             
0B5A'	C08             0BBF'	C09             0BC9'	C10             
0BD0'	C11             0BF0'	C111            0BD9'	C12             
0BE3'	C13             0BE7'	C131            0BF9'	C14             
0BFE'	C141            0C07'	C15             0C0F'	C16             
0C18'	C161            0C21'	C17             0C25'	C171            
0C38'	C172            0C41'	C18             0C87'	C21             
0C77'	C211            0CB4'	C22             0CC8'	C23             
0CF4'	C24             0CFC'	C25             0D08'	C30             
0D7D'	C31             0DD0'	C32             0C56'	C50             
0C57'	C51             0C58'	C60             085C'	CIN             
0868'	CIN1            08D9'	CON             08F1'	CON1            
08F6'	CON2            08FF'	CON9            156D'	CST             
08A2'	CST10           08A5'	CST11           08C0'	CSTS            
0878'	CSTS1           0895'	CSTS2           089E'	CSTS3           
08CD'	CSTS4           08D1'	CSTS5           1588'	DDAF            
1580'	DDAFS           1582'	DDBC            157A'	DDBCS           
1584'	DDDE            157C'	DDDES           156E'	DDEI            
1586'	DDHL            157E'	DDHLS           1570'	DDI             
156F'	DDIM            1576'	DDIX            1578'	DDIY            
1572'	DDPC            1571'	DDR             1574'	DDSP            
09B8'	J09             09AC'	J091            09B6'	J092            
09BA'	J093            09E8'	J10             09E9'	J11             
09EA'	J12             09EB'	J13             0A68'	J20             
0A98'	J21             0AB1'	J22             0ACB'	J23             
0ACF'	J24             0AD3'	J25             0AD7'	J26             
0AE9'	J27             0AEF'	J28             0AFB'	J29             
0AFF'	J30             0B0D'	J31             0B22'	J32             
0B33'	J33             0B46'	J34             0BA5'	J341            
0BA8'	J35             0C51'	J36             0CB2'	J38             
0C9C'	J39             0F2F'	J40             0F2F'	J401            
0F92'	J41             104A'	J411            0FC3'	J44             
0FD7'	J441            0FBD'	J45             0FDB'	J46             
0FE3'	J47             0FE6'	J471            0FFE'	J48             
1002'	J49             1005'	J50             1017'	J51             
1026'	J511            102A'	J52             1054'	J53             
1069'	J54             1070'	J55             10C8'	J551            
1089'	J552            108E'	J553            10AB'	J554            
10E9'	J555            10F9'	J56             110F'	J57             
112B'	J571            1137'	J58             113B'	J59             
11A8'	J60             11BE'	J601            11D1'	J61             
11F0'	J611            1205'	J62             1226'	J621            
0906'	LIST            0852'	LOAD            0EEC'	MAIN            
5018 	MAX             0817'	PRIO            1233'	RPOS            
0849'	SAVE            1238'	ST1             1239'	ST2             
123A'	ST3             123C'	ST4             123D'	ST5             
123E'	ST6             1246'	ST7             1267'	ST8             
1269'	ST9             122D'	STPO            1569'	STSP            
0939'	STX2            0921'	STX3            092B'	STX4            
093C'	STX9            0F14'	SUB             080E'	SYSTB           
0FB7'	SYTB            0811'	TA1             0814'	TA2             
113E'	TAB2            156B'	TK              0DE4'	TXT1            
0E50'	TXT11           0E61'	TXT12           0E83'	TXT13           
0EA5'	TXT2            0EDB'	TXT3            0B1B'	USB1            
0B2C'	USB2            0B41'	USB3            0B54'	USB4            
1086'	USB90           0A88'	USBEF           0001 	V1              
0DB2 	ZPOS            156C'	ZZ              



No Fatal error(s)


    080E'	SYSTB           
0FB7'	SYTB            0811'	TA1  