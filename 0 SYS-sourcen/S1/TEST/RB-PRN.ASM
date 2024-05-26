'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1


                                	TITLE	'RB10	RAM-Test'
                                ;	PN	RB10
                                
  3000                          BWSA	EQU	03000H
  00A0                          ATAST	EQU	0A0H
  00C0                          SPBA	EQU	0C0H
                                
  0000'   C3 05DC'              RBANF:	JP	START	;Kaltstart
  0003'   C3 0A15'              CONF:	JP	CON	;Outputroutine
  0006'   C3 0A55'              CINF:	JP	CIN	;Input routine
  0009'   C3 0A5B'              CSTSF:	JP	CSTS	;Konsolenstatus
  000C'   C3 0A76'              CADRF:	JP	CADR	;Cursoradressierung
  000F'   C3 0A6A'              CHOMF:	JP	CHOM	;Clear-Home-Routine
  0012'   18                    	DB	24	;Zeilen anzahl ABS
  0013'   50                    	DB	80	;Spaltenanzahl ABS
  0014'   0000'                 RANF:	DW	RBANF	;RAMBUG Anfang
  0016'   0E4E'                 REND:	DW	RBEND	;RAMBUG Ende
                                
  0018'   0000                  RAANF:	DW	0
  001A'   0000                  RAEND:	DW	0
  001C'   FF                    	DB	0FFH
  001D'   20 20 20 20           ZWI:	DB	'                    '
  0021'   20 20 20 20           
  0025'   20 20 20 20           
  0029'   20 20 20 20           
  002D'   20 20 20 20           
  0031'   FF                    	DB	0FFH
  0032'   0000                  TANF:	DW	0
  0034'   0000                  TEND:	DW	0
  0036'   0000                  TLAE:	DW	0
  0038'   0000                  BLAE:	DW	0
  003A'   00                    ZPOS:	DB	0
  003B'   00                    SPOS:	DB	0
  003C'   0000                  UM:	DW	0
  003E'   0000                  UM1:	DW	0
  0040'   0000                  UM2:	DW	0
  0042'   20 20 20 20           MER:	DB	'          '	;BER	10
  0046'   20 20 20 20           
  004A'   20 20                 
  004C'   20 20 20 20           			DB	'          '	;BER	100
  0050'   20 20 20 20           
  0054'   20 20                 
  0056'   20 20 20 20           			DB	'          '
  005A'   20 20 20 20           
  005E'   20 20                 
  0060'   20 20 20 20           			DB	'          '
  0064'   20 20 20 20           
  0068'   20 20                 
  006A'   20 20 20 20           			DB	'          '
  006E'   20 20 20 20           
  0072'   20 20                 
  0074'   20 20 20 20           			DB	'          '
  0078'   20 20 20 20           
  007C'   20 20                 
  007E'   20 20 20 20           			DB	'          '
  0082'   20 20 20 20           
  0086'   20 20                 
  0088'   20 20 20 20           			DB	'          '
  008C'   20 20 20 20           
  0090'   20 20                 
  0092'   20 20 20 20           			DB	'          '
  0096'   20 20 20 20           
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-1


  009A'   20 20                 
  009C'   20 20 20 20           			DB	'          '
  00A0'   20 20 20 20           
  00A4'   20 20                 
  00A6'   20 20 20 20           			DB	'          '
  00AA'   20 20 20 20           
  00AE'   20 20                 
  00B0'   00                    SV1:	DB	0
  00B1'   00                    SV2:	DB	0
  00B2'   00                    SV3:	DB	0
  00B3'   0000                  SV4:	DW	0
  00B5'   67C6                  CHK:	DW	067C6H
  00B7'   00                    	DB	0
                                
  00B8'   D5                    UP1:	PUSH	DE
  00B9'   F5                    	PUSH	AF
  00BA'   1A                    	LD	A,(DE)
  00BB'   F5                    	PUSH	AF
  00BC'   CD 0003'              M1001:	CALL	CONF
  00BF'   F1                    	POP	AF
  00C0'   13                    	INC	DE
  00C1'   CB 7F                 	BIT	7,A
  00C3'   28 F5                 	JR	Z,$-09
  00C5'   F1                    	POP	AF
  00C6'   D1                    	POP	DE
  00C7'   C9                    	RET
                                
  00C8'   E3                    SOUT:	EX	(SP),HL
  00C9'   F5                    	PUSH	AF
  00CA'   7E                    	LD	A,M
  00CB'   CB BF                 	RES	7,A
  00CD'   CD 0003'              M1002:	CALL	CONF
  00D0'   7E                    	LD	A,M
  00D1'   23                    	INC	HL
  00D2'   CB 7F                 	BIT	7,A
  00D4'   28 F4                 	JR	Z,$-10
  00D6'   F1                    	POP	AF
  00D7'   E3                    	EX	(SP),HL
  00D8'   C9                    	RET
                                
  00D9'   F5                    UP2:	PUSH	AF
  00DA'   D5                    	PUSH	DE
  00DB'   CD 0006'              M1003:	CALL	CINF
  00DE'   CB BF                 	RES	7,A
  00E0'   FE 08                 	CP	008H
  00E2'   20 10                 	JR	NZ,$+18
  00E4'   1B                    	DEC	DE
  00E5'   1A                    	LD	A,(DE)
  00E6'   FE FF                 	CP	0FFH
  00E8'   13                    	INC	DE
  00E9'   28 F0                 	JR	Z,$-14
  00EB'   1B                    	DEC	DE
  00EC'   CD 00C8'              M1004:	CALL	SOUT
  00EF'   08                    	DB	08H
  00F0'   20                    	DB	' '
  00F1'   88                    	DB	08H+80H
  00F2'   18 E7                 	JR	$-23
  00F4'   FE 7F                 	CP	07FH
  00F6'   30 E3                 	JR	NC,$-27
  00F8'   FE 20                 	CP	020H
  00FA'   30 04                 	JR	NC,$+06
  00FC'   FE 0D                 	CP	00DH
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-2


  00FE'   20 DB                 	JR	NZ,$-35
  0100'   F5                    	PUSH	AF
  0101'   CD 0003'              M1005:	CALL	CONF
  0104'   F1                    	POP	AF
  0105'   FE 0D                 	CP	00DH
  0107'   28 0D                 	JR	Z,$+15
  0109'   C5                    	PUSH	BC
  010A'   4F                    	LD	C,A
  010B'   1A                    	LD	A,(DE)
  010C'   FE FF                 	CP	0FFH
  010E'   79                    	LD	A,C
  010F'   C1                    	POP	BC
  0110'   28 C9                 	JR	Z,$-53
  0112'   12                    	LD	(DE),A
  0113'   13                    	INC	DE
  0114'   18 C5                 	JR	$-57
  0116'   1B                    	DEC	DE
  0117'   1A                    	LD	A,(DE)
  0118'   CB FF                 	SET	7,A
  011A'   12                    	LD	(DE),A
  011B'   3E 0A                 	LD	A,00AH
  011D'   CD 0003'              M1006:	CALL	CONF
  0120'   D1                    	POP	DE
  0121'   F1                    	POP	AF
  0122'   C9                    	RET
  0123'   11 001D'              M1007:	LD	DE,ZWI
  0126'   18 B1                 	JR	$-77
                                
  0128'   CD 00B8'              UP3:	CALL	UP1
  012B'   CD 00C8'              M1008:	CALL	SOUT
  012E'   20 28 4A 2F           	DB	' (J/N) ?'
  0132'   4E 29 20 3F           
  0136'   A0                    	DB	20H+80H
  0137'   CD 0006'              M1009:	CALL	CINF
  013A'   F5                    	PUSH	AF
  013B'   CD 0003'              M1010:	CALL	CONF
  013E'   CD 00C8'              M1011:	CALL	SOUT
  0141'   8D                    	DB	0DH+80H
  0142'   F1                    	POP	AF
  0143'   FE 4E                 	CP	04EH
  0145'   28 07                 	JR	Z,$+09
  0147'   FE 6E                 	CP	06EH
  0149'   28 03                 	JR	Z,$+05
  014B'   3E FF                 	LD	A,0FFH
  014D'   C9                    	RET
  014E'   AF                    	XOR	A
  014F'   C9                    	RET
                                
  0150'   21 0000               	LD	HL,0
  0153'   D5                    	PUSH	DE
  0154'   CD 00D9'              M1012:	CALL	UP2
  0157'   1A                    	LD	A,(DE)
  0158'   FE FF                 	CP	0FFH
  015A'   28 26                 	JR	Z,$+40
  015C'   CB BF                 	RES	7,A
  015E'   FE 30                 	CP	030H
  0160'   13                    	INC	DE
  0161'   38 F4                 	JR	C,$-10
  0163'   1B                    	DEC	DE
  0164'   FE 41                 	CP	041H
  0166'   30 04                 	JR	NC,$+06
  0168'   D6 30                 	SUB	030H
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-3


  016A'   18 08                 	JR	$+10
  016C'   D6 37                 	SUB	037H
  016E'   FE 10                 	CP	010H
  0170'   38 02                 	JR	C,$+04
  0172'   D6 20                 	SUB	020H
  0174'   29                    	ADD	HL,HL
  0175'   29                    	ADD	HL,HL
  0176'   29                    	ADD	HL,HL
  0177'   29                    	ADD	HL,HL
  0178'   85                    	ADD	A,L
  0179'   6F                    	LD	L,A
  017A'   1A                    	LD	A,(DE)
  017B'   CB 7F                 	BIT	7,A
  017D'   20 03                 	JR	NZ,$+05
  017F'   13                    	INC	DE
  0180'   18 D5                 	JR	$-41
  0182'   D1                    	POP	DE
  0183'   C9                    	RET
                                
  0184'   11 001D'              UP4:	LD	DE,ZWI
  0187'   18 C7                 	JR	$-55
                                
  0189'   F5                    UP5:	PUSH	AF
  018A'   1F                    	RRA
  018B'   1F                    	RRA
  018C'   1F                    	RRA
  018D'   1F                    	RRA
  018E'   CD 0192'              M1013:	CALL	UP6
  0191'   F1                    	POP	AF
                                
  0192'   F5                    UP6:	PUSH	AF
  0193'   E6 0F                 	AND	00FH
  0195'   F6 30                 	OR	030H
  0197'   FE 3A                 	CP	03AH
  0199'   38 02                 	JR	C,$+04
  019B'   C6 07                 	ADD	A,007H
  019D'   CD 0003'              M1014:	CALL	CONF
  01A0'   F1                    	POP	AF
  01A1'   C9                    	RET
                                
  01A2'   F5                    UP7:	PUSH	AF
  01A3'   7C                    	LD	A,H
  01A4'   CD 0189'              M1015:	CALL	UP5
  01A7'   7D                    	LD	A,L
  01A8'   CD 0189'              M1016:	CALL	UP5
  01AB'   F1                    	POP	AF
  01AC'   C9                    	RET
                                
  01AD'   CD 000F'              J1:	CALL	CHOMF
  01B0'   CD 00C8'              M1017:	CALL	SOUT
  01B3'   2A 20 53 59           	DB	'* SYSTEM ABSTURZ '
  01B7'   53 54 45 4D           
  01BB'   20 41 42 53           
  01BF'   54 55 52 5A           
  01C3'   20                    
  01C4'   AA                    	DB	02AH+80H
  01C5'   76                    	HALT
                                
  01C6'   0D                    T1:	DB	00DH
  01C7'   45 69 6E 67           	DB	'Eingabe richtig'
  01CB'   61 62 65 20           
  01CF'   72 69 63 68           
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-4


  01D3'   74 69 67              
  01D6'   A0                    	DB	020H+80H
  01D7'   42 75 66 66           T2:	DB	'Buffer/Chip-Tes'
  01DB'   65 72 2F 43           
  01DF'   68 69 70 2D           
  01E3'   54 65 73              
  01E6'   F4                    	DB	074H+80H
  01E7'   50 65 61 6B           T3:	DB	'Peak-Test      '
  01EB'   2D 54 65 73           
  01EF'   74 20 20 20           
  01F3'   20 20 20              
  01F6'   A0                    	DB	020H+80H
  01F7'   56 61 6C 6C           T4:	DB	'Valley-Test    '
  01FB'   65 79 2D 54           
  01FF'   65 73 74 20           
  0203'   20 20 20              
  0206'   A0                    	DB	020H+80H
  0207'   48 2D 57 6F           T7:	DB	'H-Worstcase    '
  020B'   72 73 74 63           
  020F'   61 73 65 20           
  0213'   20 20 20              
  0216'   A0                    	DB	020H+80H
  0217'   4C 2D 57 6F           T8:	DB	'L-Worstcase    '
  021B'   72 73 74 63           
  021F'   61 73 65 20           
  0223'   20 20 20              
  0226'   A0                    	DB	020H+80H
  0227'   52 65 66 72           T9:	DB	'Refresh-Test   '
  022B'   65 73 68 2D           
  022F'   54 65 73 74           
  0233'   20 20 20              
  0236'   A0                    	DB	020H+80H
  0237'   52 65 66 72           T10:	DB	'Refresh-Delay  '
  023B'   65 73 68 2D           
  023F'   44 65 6C 61           
  0243'   79 20 20              
  0246'   A0                    	DB	020H+80H
  0247'   4D 31 2D 54           T11:	DB	'M1-Test        '
  024B'   65 73 74 20           
  024F'   20 20 20 20           
  0253'   20 20 20              
  0256'   A0                    	DB	020H+80H
                                
  0257'   CD 000F'              UP8:	CALL	CHOMF
  025A'   CD 00C8'              M1018:	CALL	SOUT
  025D'   20 20 20 20           	DB	'     RAMTEST  ( DEG 2000 )'
  0261'   20 52 41 4D           
  0265'   54 45 53 54           
  0269'   20 20 28 20           
  026D'   44 45 47 20           
  0271'   32 30 30 30           
  0275'   20 29                 
  0277'   0D                    	DB	00DH
  0278'   8D                    	DB	00DH+80H
  0279'   2A 0014'              M1019:	LD	HL,(RANF)
  027C'   2B                    MV2:	DEC	HL
  027D'   7D                    	LD	A,L
  027E'   B4                    	OR	H
  027F'   28 09                 	JR	Z,M1020
  0281'   7E                    	LD	A,M
  0282'   2F                    	CPL
  0283'   77                    	LD	M,A
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-5


  0284'   2F                    	CPL
  0285'   BE                    	CP	M
  0286'   77                    	LD	M,A
  0287'   20 F3                 	JR	NZ,MV2
  0289'   23                    	INC	HL
  028A'   22 0018'              M1020:	LD	(RAANF),HL
  028D'   2A 0016'              M1021:	LD	HL,(REND)
  0290'   23                    MV4:	INC	HL
  0291'   7D                    	LD	A,L
  0292'   B4                    	OR	H
  0293'   28 08                 	JR	Z,MV3
  0295'   7E                    	LD	A,M
  0296'   2F                    	CPL
  0297'   77                    	LD	M,A
  0298'   2F                    	CPL
  0299'   BE                    	CP	M
  029A'   77                    	LD	M,A
  029B'   20 F3                 	JR	NZ,MV4
  029D'   2B                    MV3:	DEC	HL
  029E'   22 001A'              M1022:	LD	(RAEND),HL
  02A1'   E5                    	PUSH	HL
  02A2'   CD 00C8'              M1023:	CALL	SOUT
  02A5'   52 41 4D 20           	DB	'RAM - Bereich    :'
  02A9'   2D 20 42 65           
  02AD'   72 65 69 63           
  02B1'   68 20 20 20           
  02B5'   20 3A                 
  02B7'   A0                    	DB	020H+80H
  02B8'   2A 0018'              M1024:	LD	HL,(RAANF)
  02BB'   CD 01A2'              M1025:	CALL	UP7
  02BE'   CD 00C8'              M1026:	CALL	SOUT
  02C1'   AD                    	DB	02DH+80H
  02C2'   E1                    	POP	HL
  02C3'   CD 01A2'              M1027:	CALL	UP7
  02C6'   CD 00C8'              M1028:	CALL	SOUT
  02C9'   0D                    	DB	00DH
  02CA'   52 41 4D 54           	DB	'RAMTEST belegt   :'
  02CE'   45 53 54 20           
  02D2'   62 65 6C 65           
  02D6'   67 74 20 20           
  02DA'   20 3A                 
  02DC'   A0                    	DB	020H+80H
  02DD'   2A 0014'              M1029:	LD	HL,(RANF)
  02E0'   CD 01A2'              M1030:	CALL	UP7
  02E3'   CD 00C8'              M1031:	CALL	SOUT
  02E6'   AD                    	XOR	L
  02E7'   2A 0016'              M1032:	LD	HL,(REND)
  02EA'   CD 01A2'              M1033:	CALL	UP7
  02ED'   CD 00C8'              J2:	CALL	SOUT
  02F0'   0D                    	DB	00DH
  02F1'   0D                    	DB	00DH
  02F2'   54 65 73 74           	DB	'Testanfang (hex) :'
  02F6'   61 6E 66 61           
  02FA'   6E 67 20 28           
  02FE'   68 65 78 29           
  0302'   20 3A                 
  0304'   A0                    	DB	020H+80H
  0305'   CD 0184'              M1034:	CALL	UP4
  0308'   22 0032'              M1035:	LD	(TANF),HL
  030B'   E5                    	PUSH	HL
  030C'   CD 00C8'              M1036:	CALL	SOUT
  030F'   54 65 73 74           	DB	'Testende   (hex) :'
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-6


  0313'   65 6E 64 65           
  0317'   20 20 20 28           
  031B'   68 65 78 29           
  031F'   20 3A                 
  0321'   A0                    	DB	020H+80H
  0322'   CD 0184'              M1037:	CALL	UP4
  0325'   22 0034'              M1038:	LD	(TEND),HL
  0328'   D1                    	POP	DE
  0329'   AF                    	XOR	A
  032A'   ED 52                 	SBC	HL,DE
  032C'   23                    	INC	HL
  032D'   22 0036'              M1039:	LD	(TLAE),HL
  0330'   E5                    	PUSH	HL
  0331'   CD 00C8'              M1040:	CALL	SOUT
  0334'   52 41 4D 2D           	DB	'RAM-Laenge (hex) :'
  0338'   4C 61 65 6E           
  033C'   67 65 20 28           
  0340'   68 65 78 29           
  0344'   20 3A                 
  0346'   A0                    	DB	020H+80H
  0347'   CD 01A2'              M1041:	CALL	UP7
  034A'   E5                    	PUSH	HL
  034B'   2A 0016'              M1042:	LD	HL,(REND)
  034E'   ED 5B 0014'           M1043:	LD	DE,(RANF)
  0352'   ED 52                 	SBC	HL,DE
  0354'   23                    	INC	HL
  0355'   E5                    	PUSH	HL
  0356'   29                    	ADD	HL,HL
  0357'   D1                    	POP	DE
  0358'   19                    	ADD	HL,DE
  0359'   E5                    	PUSH	HL
  035A'   2A 001A'              M1044:	LD	HL,(RAEND)
  035D'   ED 5B 0018'           M1045:	LD	DE,(RAANF)
  0361'   23                    	INC	HL
  0362'   ED 52                 	SBC	HL,DE
  0364'   D1                    	POP	DE
  0365'   ED 52                 	SBC	HL,DE
  0367'   D1                    	POP	DE
  0368'   ED 52                 	SBC	HL,DE
  036A'   30 21                 	JR	NC,M1048
  036C'   CD 00C8'              M1046:	CALL	SOUT
  036F'   0D                    	DB	00DH
  0370'   0D                    	DB	00DH
  0371'   2A 20 6B 65           	DB	'* kein Arbeitsbereich *'
  0375'   69 6E 20 41           
  0379'   72 62 65 69           
  037D'   74 73 62 65           
  0381'   72 65 69 63           
  0385'   68 20 2A              
  0388'   8D                    	DB	00DH+80H
  0389'   E1                    	POP	HL
  038A'   C3 02ED'              M1047:	JP	J2
  038D'   CD 00C8'              M1048:	CALL	SOUT
  0390'   0D                    	DB	0DH
  0391'   42 6C 6F 63           	DB	'Blocklaenge (hex):'
  0395'   6B 6C 61 65           
  0399'   6E 67 65 20           
  039D'   28 68 65 78           
  03A1'   29 3A                 
  03A3'   A0                    	DB	020H+80H
  03A4'   CD 0184'              M1049:	CALL	UP4
  03A7'   22 0038'              M1050:	LD	(BLAE),HL
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-7


  03AA'   0E 00                 	LD	C,000H
  03AC'   EB                    	EX	DE,HL
  03AD'   E1                    	POP	HL
  03AE'   AF                    	XOR	A
  03AF'   0C                    	INC	C
  03B0'   28 49                 	JR	Z,M1057
  03B2'   ED 52                 	SBC	HL,DE
  03B4'   28 1D                 	JR	Z,M1060
  03B6'   30 F7                 	JR	NC,$-07
  03B8'   CD 00C8'              M1051:	CALL	SOUT
  03BB'   0D                    	DB	00DH
  03BC'   2A 20 66 61           	DB	'* falsche Eingabe *'
  03C0'   6C 73 63 68           
  03C4'   65 20 45 69           
  03C8'   6E 67 61 62           
  03CC'   65 20 2A              
  03CF'   8D                    	DB	00DH+80H
  03D0'   C3 02ED'              M1052:	JP	J2
  03D3'   79                    M1060:	LD	A,C
  03D4'   32 0042'              M1053:	LD	(MER),A
  03D7'   CD 00C8'              M1054:	CALL	SOUT
  03DA'   42 6C 6F 63           	DB	'Blockanzahl      :'
  03DE'   6B 61 6E 7A           
  03E2'   61 68 6C 20           
  03E6'   20 20 20 20           
  03EA'   20 3A                 
  03EC'   A0                    	DB	020H+80H
  03ED'   47                    	LD	B,A
  03EE'   AF                    	XOR	A
  03EF'   3C                    	INC	A
  03F0'   27                    	DAA
  03F1'   10 FC                 	DJNZ	$-02
  03F3'   CD 0189'              M1055:	CALL	UP5
  03F6'   3E 15                 M1056:	LD	A,21
  03F8'   91                    	SUB	C
  03F9'   30 1D                 	JR	NC,M1059
  03FB'   CD 00C8'              M1057:	CALL	SOUT
  03FE'   0D                    	DB	00DH
  03FF'   0D                    	DB	00DH
  0400'   2A 20 7A 75           	DB	'* zu viele Bloecke *'
  0404'   20 76 69 65           
  0408'   6C 65 20 42           
  040C'   6C 6F 65 63           
  0410'   6B 65 20 2A           
  0414'   8D                    	DB	00DH+80H
  0415'   C3 02ED'              M1058:	JP	J2
  0418'   CD 00C8'              M1059:	CALL	SOUT
  041B'   0D                    	DB	00DH
  041C'   0D                    	DB	00DH
  041D'   77 65 6C 63           	DB	'welche Tests werden gewuenscht ?'
  0421'   68 65 20 54           
  0425'   65 73 74 73           
  0429'   20 77 65 72           
  042D'   64 65 6E 20           
  0431'   67 65 77 75           
  0435'   65 6E 73 63           
  0439'   68 74 20 3F           
  043D'   8D                    	DB	00DH+80H
  043E'   11 01D7'              M1061:	LD	DE,T2
  0441'   CD 0128'              M1062:	CALL	UP3
  0444'   32 0043'              M1063:	LD	(MER+1),A
  0447'   11 01E7'              M1067:	LD	DE,T3
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-8


  044A'   CD 0128'              M1068:	CALL	UP3
  044D'   32 0044'              M1069:	LD	(MER+2),A
  0450'   11 01F7'              M1070:	LD	DE,T4
  0453'   CD 0128'              M1071:	CALL	UP3
  0456'   32 0045'              M1072:	LD	(MER+3),A
  0459'   11 0207'              M1073:	LD	DE,T7
  045C'   CD 0128'              M1074:	CALL	UP3
  045F'   32 0048'              M1075:	LD	(MER+6),A
  0462'   11 0217'              M1076:	LD	DE,T8
  0465'   CD 0128'              M1077:	CALL	UP3
  0468'   32 0049'              M1078:	LD	(MER+7),A
  046B'   11 0227'              M1082:	LD	DE,T9
  046E'   CD 0128'              M1083:	CALL	UP3
  0471'   32 004A'              M1084:	LD	(MER+8),A
  0474'   11 0247'              M1085:	LD	DE,T11
  0477'   CD 0128'              M1086:	CALL	UP3
  047A'   32 004B'              M1087:	LD	(MER+9),A
  047D'   11 01C6'              M1088:	LD	DE,T1
  0480'   CD 0128'              M1089:	CALL	UP3
  0483'   CA 0257'              M1090:	JP	Z,UP8
  0486'   C9                    	RET
                                
  0487'   4D 52 4C 48           S:	DB	'MRLHVPB'
  048B'   56 50 42              
                                
  048E'   CD 000F'              UP9:	CALL	CHOMF
  0491'   CD 00C8'              M1091:	CALL	SOUT
  0494'   41 64 64 72           	DB	'Addr.'
  0498'   2E                    
  0499'   A0                    	DB	020H+80H
  049A'   06 08                 	LD	B,008H
  049C'   CD 00C8'              M1093:	CALL	SOUT
  049F'   20                    	DB	' '
  04A0'   A0                    	DB	020H+80H
  04A1'   78                    LDAB:	LD	A,B
  04A2'   3D                    	DEC	A
  04A3'   CD 0189'              M1094:	CALL	UP5
  04A6'   0E 06                 	LD	C,006H
  04A8'   CD 00C8'              M1096:	CALL	SOUT
  04AB'   A0                    	DB	020H+80H
  04AC'   0D                    	DEC	C
  04AD'   20 F9                 	JR	NZ,$-05
  04AF'   10 F0                 	DJNZ	LDAB
  04B1'   CD 00C8'              M1097:	CALL	SOUT
  04B4'   8D                    	DB	00DH+80H
  04B5'   06 45                 	LD	B,045H
  04B7'   CD 00C8'              M1099:	CALL	SOUT
  04BA'   AD                    	DB	02DH+80H
  04BB'   10 FA                 	DJNZ	$-04
  04BD'   2A 0032'              M1100:	LD	HL,(TANF)
  04C0'   ED 5B 0038'           M1101:	LD	DE,(BLAE)
  04C4'   3A 0042'              M1102:	LD	A,(MER)
  04C7'   47                    	LD	B,A
  04C8'   CD 00C8'              M1103:	CALL	SOUT
  04CB'   8D                    	DB	00DH+80H
  04CC'   CD 01A2'              M1104:	CALL	UP7
  04CF'   CD 00C8'              M1105:	CALL	SOUT
  04D2'   20                    	DB	' '
  04D3'   A0                    	DB	020H+80H
  04D4'   C5                    	PUSH	BC
  04D5'   06 08                 	LD	B,008H
  04D7'   0E 07                 M1106:	LD	C,007H
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-9


  04D9'   CD 00C8'              M1107:	CALL	SOUT
  04DC'   AE                    	DB	02EH+80H
  04DD'   0D                    	DEC	C
  04DE'   20 F9                 	JR	NZ,$-05
  04E0'   CD 00C8'              M1108:	CALL	SOUT
  04E3'   A0                    	DB	020H+80H
  04E4'   10 F1                 	DJNZ	M1106
  04E6'   C1                    	POP	BC
  04E7'   19                    	ADD	HL,DE
  04E8'   10 DE                 	DJNZ	M1103
  04EA'   C9                    	RET
                                
  04EB'   F5                    UP10:	PUSH	AF
  04EC'   C5                    	PUSH	BC
  04ED'   D5                    	PUSH	DE
  04EE'   E5                    	PUSH	HL
  04EF'   2A 0032'              M1109:	LD	HL,(TANF)
  04F2'   2B                    	DEC	HL
  04F3'   DD 2B                 	DEC	IX
  04F5'   ED 5B 0038'           M1110:	LD	DE,(BLAE)
  04F9'   06 00                 	LD	B,000H
  04FB'   19                    	ADD	HL,DE
  04FC'   04                    	INC	B
  04FD'   EB                    	EX	DE,HL
  04FE'   E5                    	PUSH	HL
  04FF'   DD E5                 	PUSH	IX
  0501'   E1                    	POP	HL
  0502'   ED 52                 	SBC	HL,DE
  0504'   E1                    	POP	HL
  0505'   EB                    	EX	DE,HL
  0506'   30 F3                 	JR	NC,$-11
  0508'   3F                    	CCF
  0509'   ED 52                 	SBC	HL,DE
  050B'   78                    	LD	A,B
  050C'   3C                    	INC	A
  050D'   FD E5                 	PUSH	IY
  050F'   C1                    	POP	BC
  0510'   5F                    	LD	E,A
  0511'   78                    	LD	A,B
  0512'   06 08                 	LD	B,008H
  0514'   16 05                 	LD	D,005H
  0516'   07                    	RLCA
  0517'   30 22                 M1112:	JR	NC,M1119
  0519'   D5                    	PUSH	DE
  051A'   C5                    	PUSH	BC
  051B'   F5                    	PUSH	AF
  051C'   21 0487'              M1111:	LD	HL,S
  051F'   06 07                 	LD	B,007H
  0521'   79                    	LD	A,C
  0522'   BE                    	CP	M
  0523'   28 06                 	JR	Z,$+08
  0525'   23                    	INC	HL
  0526'   10 F9                 	DJNZ	$-05
  0528'   C3 01AD'              M1115:	JP	J1
  052B'   78                    	LD	A,B
  052C'   82                    	ADD	A,D
  052D'   57                    	LD	D,A
  052E'   CD 000C'              M1116:	CALL	CADRF
  0531'   79                    	LD	A,C
  0532'   CD 0003'              M1117:	CALL	CONF
  0535'   CD 000C'              M1118:	CALL	CADRF
  0538'   F1                    	POP	AF
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-10


  0539'   C1                    	POP	BC
  053A'   D1                    	POP	DE
  053B'   F5                    M1119:	PUSH	AF
  053C'   3E 08                 	LD	A,008H
  053E'   82                    	ADD	A,D
  053F'   57                    	LD	D,A
  0540'   F1                    	POP	AF
  0541'   CB 27                 	SLA	A
  0543'   10 D2                 	DJNZ	M1112
  0545'   E1                    	POP	HL
  0546'   D1                    	POP	DE
  0547'   C1                    	POP	BC
  0548'   F1                    	POP	AF
  0549'   DD 23                 	INC	IX
  054B'   C9                    	RET
                                
  054C'   62 65 6C 69           T20:	DB	'beliebige Taste oder RESET '
  0550'   65 62 69 67           
  0554'   65 20 54 61           
  0558'   73 74 65 20           
  055C'   6F 64 65 72           
  0560'   20 52 45 53           
  0564'   45 54 20              
  0567'   A1                    	DB	021H+80H
  0568'   54 65 73 74           T21A:	DB	'Test'
  056C'   A0                    	DB	020H+80H
  056D'   77 69 65 64           T22:	DB	'wiederholen  '
  0571'   65 72 68 6F           
  0575'   6C 65 6E 20           
  0579'   20                    
  057A'   A0                    	DB	020H+80H
  057B'   2A 2A 20 4D           T23:	DB	'** M1: Block zu klein **'
  057F'   31 3A 20 42           
  0583'   6C 6F 63 6B           
  0587'   20 7A 75 20           
  058B'   6B 6C 65 69           
  058F'   6E 20 2A 2A           
  0593'   8D                    	DB	00DH+80H
                                
  0594'   00                    T24:	NOP
  0595'   88                    	ADC	A,B
  0596'   01 007F               	LD	BC,0007FH
  0599'   88                    	ADC	A,B
  059A'   00                    	NOP
  059B'   04                    	INC	B
  059C'   88                    	ADC	A,B
  059D'   00                    	NOP
  059E'   08                    	EX	AF,AF'
  059F'   00                    	NOP
  05A0'   08                    	EX	AF,AF'
  05A1'   00                    	NOP
  05A2'   10 02                 	DJNZ	$+04
  05A4'   0E 08                 	LD	C,008H
  05A6'   04                    	INC	B
  05A7'   88                    	ADC	A,B
  05A8'   2D                    	DEC	L
  05A9'   88                    	ADC	A,B
  05AA'   00                    	NOP
  05AB'   08                    	EX	AF,AF'
  05AC'   80                    	ADD	A,B
  05AD'   00                    	NOP
  05AE'   00                    	NOP
'RB10	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-11


                                
  05AF'   D5                    UP11:	PUSH	DE
  05B0'   57                    	LD	D,A
  05B1'   3A 00B0'              M1120:	LD	A,(SV1)
  05B4'   5F                    	LD	E,A
  05B5'   D5                    	PUSH	DE
  05B6'   FD E1                 	POP	IY
  05B8'   E5                    	PUSH	HL
  05B9'   DD E1                 	POP	IX
  05BB'   CD 04EB'              M1121:	CALL	UP10
  05BE'   D1                    	POP	DE
  05BF'   C9                    	RET
  05C0'   F5                    UP12:	PUSH	AF
  05C1'   D5                    	PUSH	DE
  05C2'   16 00                 	LD	D,0
  05C4'   3A 0042'              M1122:	LD	A,(MER)
  05C7'   C6 02                 	ADD	A,002H
  05C9'   5F                    	LD	E,A
  05CA'   3E 18                 M1123:	LD	A,24
  05CC'   93                    	SUB	E
  05CD'   DA 01AD'              M1124:	JP	C,J1
  05D0'   CD 000C'              M1125:	CALL	CADRF
  05D3'   CD 09A3'              M1126:	CALL	UP17
  05D6'   D1                    	POP	DE
  05D7'   CD 00B8'              M1127:	CALL	UP1
  05DA'   F1                    	POP	AF
  05DB'   C9                    	RET
                                
                                	TITLE	'RB20	RAM-Test'
                                	PAGE
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-12


                                
                                ;	END
                                ;	PN	RB20
                                
  05DC'   31 00B3'              START:	LD	SP,SV4
  05DF'   CD 0AED'              ST1:	CALL	UP18
  05E2'   CD 0257'              M1128:	CALL	UP8
  05E5'   CD 08A1'              M1129:	CALL	UP16
  05E8'   31 00B0'              J3:	LD	SP,SV1
  05EB'   CD 048E'              M1130:	CALL	UP9
                                
  05EE'   3A 0043'              M1132:	LD	A,(MER+1)	;B/C - TEST
  05F1'   FE FF                 	CP	0FFH
  05F3'   20 2F                 	JR	NZ,M1144
  05F5'   3E 42                 	LD	A,042H
  05F7'   32 00B0'              M1133:	LD	(SV1),A
  05FA'   11 01D7'              M1134:	LD	DE,T2
  05FD'   CD 05C0'              M1135:	CALL	UP12
  0600'   06 08                 	LD	B,008H
  0602'   2A 0032'              M1136:	LD	HL,(TANF)
  0605'   ED 5B 0036'           M1137:	LD	DE,(TLAE)
  0609'   3E 55                 	LD	A,055H
  060B'   77                    	LD	M,A
  060C'   AE                    	XOR	M
  060D'   C4 05AF'              M1138:	CALL	NZ,UP11
  0610'   CD 0009'              M1139:	CALL	CSTSF
  0613'   20 0F                 	JR	NZ,M1144
  0615'   3E AA                 	LD	A,0AAH
  0617'   77                    	LD	M,A
  0618'   AE                    	XOR	M
  0619'   C4 05AF'              M1141:	CALL	NZ,UP11
  061C'   1B                    	DEC	DE
  061D'   23                    	INC	HL
  061E'   7A                    	LD	A,D
  061F'   B3                    	OR	E
  0620'   20 E7                 	JR	NZ,$-23
  0622'   10 DE                 	DJNZ	$-32
                                
  0624'   3A 0044'              M1144:	LD	A,(MER+2)	;P - TEST
  0627'   FE FF                 	CP	0FFH
  0629'   20 4E                 	JR	NZ,M1161
  062B'   3E 50                 	LD	A,050H
  062D'   32 00B0'              M1145:	LD	(SV1),A
  0630'   11 01E7'              M1146:	LD	DE,T3
  0633'   CD 05C0'              M1147:	CALL	UP12
  0636'   AF                    	XOR	A	;START
  0637'   2A 0032'              M1151:	LD	HL,(TANF)
  063A'   77                    	LD	M,A
  063B'   06 09                 	LD	B,009H
  063D'   2A 0032'              M1152:	LD	HL,(TANF)
  0640'   ED 5B 0036'           M1153:	LD	DE,(TLAE)
  0644'   7E                    	LD	A,M
  0645'   A7                    	AND	A
  0646'   20 01                 	JR	NZ,$+03
  0648'   37                    	SCF
  0649'   17                    	RLA
  064A'   77                    	LD	M,A
  064B'   08                    	EX	AF,AF'
  064C'   23                    	INC	HL
  064D'   1B                    	DEC	DE
  064E'   7A                    	LD	A,D
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-13


  064F'   B3                    	OR	E
  0650'   28 03                 	JR	Z,$+05
  0652'   08                    	EX	AF,AF'
  0653'   18 F4                 	JR	$-10
  0655'   2A 0032'              M1155:	LD	HL,(TANF)
  0658'   ED 5B 0036'           M1156:	LD	DE,(TLAE)
  065C'   7E                    	LD	A,M
  065D'   A7                    	AND	A
  065E'   20 01                 	JR	NZ,$+03
  0660'   37                    	SCF
  0661'   4F                    	LD	C,A
  0662'   08                    	EX	AF,AF'
  0663'   79                    	LD	A,C
  0664'   AE                    	XOR	M
  0665'   C4 05AF'              M1157:	CALL	NZ,UP11
  0668'   23                    	INC	HL
  0669'   1B                    	DEC	DE
  066A'   CD 0009'              M1158:	CALL	CSTSF
  066D'   20 0A                 	JR	NZ,M1161
  066F'   7A                    	LD	A,D
  0670'   B3                    	OR	E
  0671'   28 04                 	JR	Z,$+06
  0673'   08                    	EX	AF,AF'
  0674'   17                    	RLA
  0675'   18 EA                 	JR	$-20
  0677'   10 C4                 	DJNZ	M1152
                                
  0679'   3A 0045'              M1161:	LD	A,(MER+3)	;V - TEST
  067C'   FE FF                 	CP	0FFH
  067E'   20 4A                 	JR	NZ,M1181
  0680'   3E 56                 	LD	A,056H
  0682'   32 00B0'              M1162:	LD	(SV1),A
  0685'   11 01F7'              M1163:	LD	DE,T4
  0688'   CD 05C0'              M1164:	CALL	UP12
  068B'   2A 0032'              M1167:	LD	HL,(TANF)	;START
  068E'   36 FF                 	LD	M,0FFH
  0690'   06 09                 	LD	B,009H
  0692'   2A 0032'              M1168:	LD	HL,(TANF)
  0695'   ED 5B 0036'           M1169:	LD	DE,(TLAE)
  0699'   7E                    	LD	A,M
  069A'   FE FF                 	CP	0FFH
  069C'   17                    	RLA
  069D'   77                    	LD	M,A
  069E'   08                    	EX	AF,AF'
  069F'   23                    	INC	HL
  06A0'   1B                    	DEC	DE
  06A1'   7A                    	LD	A,D
  06A2'   B3                    	OR	E
  06A3'   28 03                 	JR	Z,$+05
  06A5'   08                    	EX	AF,AF'
  06A6'   18 F4                 	JR	$-10
  06A8'   2A 0032'              M1171:	LD	HL,(TANF)
  06AB'   ED 5B 0036'           M1172:	LD	DE,(TLAE)
  06AF'   7E                    	LD	A,M
  06B0'   FE FF                 	CP	0FFH
  06B2'   4F                    	LD	C,A
  06B3'   08                    	EX	AF,AF'
  06B4'   79                    	LD	A,C
  06B5'   AE                    	XOR	M
  06B6'   C4 05AF'              M1173:	CALL	NZ,UP11
  06B9'   23                    	INC	HL
  06BA'   1B                    	DEC	DE
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-14


  06BB'   CD 0009'              M1174:	CALL	CSTSF
  06BE'   20 0A                 	JR	NZ,M1181
  06C0'   7A                    	LD	A,D
  06C1'   B3                    	OR	E
  06C2'   28 04                 	JR	Z,$+06
  06C4'   08                    	EX	AF,AF'
  06C5'   17                    	RLA
  06C6'   18 EA                 	JR	$-20
  06C8'   10 C8                 	DJNZ	M1168
                                
  06CA'   3A 0048'              M1181:	LD	A,(MER+6)	;WC - TEST (H)
  06CD'   FE FF                 	CP	0FFH
  06CF'   20 17                 	JR	NZ,M1192
  06D1'   3E 48                 	LD	A,048H
  06D3'   32 00B0'              M1182:	LD	(SV1),A
  06D6'   11 0207'              M1183:	LD	DE,T7
  06D9'   CD 05C0'              M1184:	CALL	UP12
  06DC'   3E 55                 	LD	A,055H
  06DE'   32 00B1'              M1185:	LD	(SV2),A
  06E1'   2F                    	CPL
  06E2'   32 00B2'              M1186:	LD	(SV3),A
  06E5'   CD 0709'              M1187:	CALL	UP15
                                
  06E8'   3A 0049'              M1192:	LD	A,(MER+7)	;WC - TEST (L)
  06EB'   FE FF                 	CP	0FFH
  06ED'   C2 0769'              M1193:	JP	NZ,J5
  06F0'   3E 4C                 	LD	A,04CH
  06F2'   32 00B0'              M1194:	LD	(SV1),A
  06F5'   11 0217'              M1195:	LD	DE,T8
  06F8'   CD 05C0'              M1196:	CALL	UP12
  06FB'   3E AA                 	LD	A,0AAH
  06FD'   32 00B1'              M1205:	LD	(SV2),A
  0700'   2F                    	CPL
  0701'   32 00B2'              M1206:	LD	(SV3),A
  0704'   CD 0709'              M1207:	CALL	UP15
  0707'   18 60                 	JR	$+98
  0709'   2A 0032'              UP15:	LD	HL,(TANF)	;START
  070C'   ED 5B 0036'           M1210:	LD	DE,(TLAE)
  0710'   3A 00B2'              M1211:	LD	A,(SV3)
  0713'   77                    	LD	M,A
  0714'   06 11                 	LD	B,011H
  0716'   3A 00B1'              M1212:	LD	A,(SV2)
  0719'   4F                    	LD	C,A
  071A'   18 01                 	JR	$+03
  071C'   71                    	LD	M,C
  071D'   23                    	INC	HL
  071E'   1B                    	DEC	DE
  071F'   CD 0009'              M1213:	CALL	CSTSF
  0722'   C0                    	RET	NZ
  0723'   7A                    	LD	A,D
  0724'   B3                    	OR	E
  0725'   28 04                 	JR	Z,$+06
  0727'   10 F3                 	DJNZ	$-11
  0729'   18 E5                 	JR	$-25
  072B'   06 10                 	LD	B,010H
  072D'   C5                    	PUSH	BC
  072E'   ED 5B 0034'           M1214:	LD	DE,(TEND)
  0732'   D5                    	PUSH	DE
  0733'   E1                    	POP	HL
  0734'   2B                    	DEC	HL
  0735'   ED 4B 0036'           M1215:	LD	BC,(TLAE)
  0739'   0B                    	DEC	BC
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-15


  073A'   ED B8                 	LDDR
  073C'   2A 0032'              M1216:	LD	HL,(TANF)
  073F'   3A 00B1'              M1217:	LD	A,(SV2)
  0742'   77                    	LD	M,A
  0743'   C1                    	POP	BC
  0744'   CD 0009'              M1218:	CALL	CSTSF
  0747'   C0                    	RET	NZ
  0748'   10 E3                 	DJNZ	$-27
  074A'   ED 5B 0036'           M1219:	LD	DE,(TLAE)
  074E'   06 10                 	LD	B,010H
  0750'   3A 00B1'              M1220:	LD	A,(SV2)
  0753'   AE                    	XOR	M
  0754'   C4 05AF'              M1221:	CALL	NZ,UP11
  0757'   23                    	INC	HL
  0758'   1B                    	DEC	DE
  0759'   CD 0009'              M1222:	CALL	CSTSF
  075C'   C0                    	RET	NZ
  075D'   7A                    	LD	A,D
  075E'   B3                    	OR	E
  075F'   C8                    	RET	Z
  0760'   10 EE                 	DJNZ	$-16
  0762'   3A 00B2'              M1223:	LD	A,(SV3)
  0765'   06 11                 	LD	B,011H
  0767'   18 EA                 	JR	$-20
                                
  0769'   3A 004A'              J5:	LD	A,(MER+8)	;R - TEST
  076C'   FE FF                 	CP	0FFH
  076E'   20 68                 	JR	NZ,M1245
  0770'   3E 52                 	LD	A,052H
  0772'   32 00B0'              M1224:	LD	(SV1),A
  0775'   11 0227'              M1225:	LD	DE,T9
  0778'   CD 05C0'              M1226:	CALL	UP12
  077B'   0E 8E                 	LD	C,08EH
  077D'   2A 0032'              M1227:	LD	HL,(TANF)
  0780'   71                    	LD	M,C
  0781'   06 08                 	LD	B,008H
  0783'   2A 0032'              M1228:	LD	HL,(TANF)
  0786'   ED 5B 0036'           M1229:	LD	DE,(TLAE)
  078A'   4E                    	LD	C,M
  078B'   CB 09                 	RRC	C
  078D'   71                    	LD	M,C
  078E'   23                    	INC	HL
  078F'   1B                    	DEC	DE
  0790'   CD 0009'              M1230:	CALL	CSTSF
  0793'   20 43                 	JR	NZ,M1245
  0795'   7A                    	LD	A,D
  0796'   B3                    	OR	E
  0797'   20 F2                 	JR	NZ,$-12
  0799'   11 0237'              M1232:	LD	DE,T10
  079C'   CD 05C0'              M1233:	CALL	UP12
  079F'   21 000A               	LD	HL,0000AH
  07A2'   11 FFFF               	LD	DE,0FFFFH
  07A5'   1B                    	DEC	DE
  07A6'   7A                    	LD	A,D
  07A7'   B3                    	OR	E
  07A8'   20 FB                 	JR	NZ,$-03
  07AA'   2B                    	DEC	HL
  07AB'   CD 0009'              M1234:	CALL	CSTSF
  07AE'   20 28                 	JR	NZ,M1245
  07B0'   7C                    	LD	A,H
  07B1'   B5                    	OR	L
  07B2'   20 EE                 	JR	NZ,$-16
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-16


  07B4'   11 0227'              M1236:	LD	DE,T9
  07B7'   CD 05C0'              M1237:	CALL	UP12
  07BA'   2A 0032'              M1238:	LD	HL,(TANF)
  07BD'   ED 5B 0036'           M1239:	LD	DE,(TLAE)
  07C1'   4E                    	LD	C,M
  07C2'   79                    	LD	A,C
  07C3'   AE                    	XOR	M
  07C4'   C4 05AF'              M1240:	CALL	NZ,UP11
  07C7'   23                    	INC	HL
  07C8'   1B                    	DEC	DE
  07C9'   CD 0009'              M1241:	CALL	CSTSF
  07CC'   20 0A                 	JR	NZ,M1245
  07CE'   7A                    	LD	A,D
  07CF'   B3                    	OR	E
  07D0'   28 04                 	JR	Z,$+06
  07D2'   CB 09                 	RRC	C
  07D4'   18 EC                 	JR	$-18
  07D6'   10 AB                 	DJNZ	$-83
                                
  07D8'   3A 004B'              M1245:	LD	A,(MER+9)	;M1 - TEST
  07DB'   FE FF                 	CP	0FFH
  07DD'   C2 0883'              M1246:	JP	NZ,J6
  07E0'   3E 4D                 	LD	A,04DH
  07E2'   32 00B0'              M1247:	LD	(SV1),A
  07E5'   11 0247'              M1248:	LD	DE,T11
  07E8'   CD 05C0'              M1249:	CALL	UP12
  07EB'   ED 5B 0038'           M1250:	LD	DE,(BLAE)
  07EF'   21 0020               	LD	HL,00020H
  07F2'   ED 52                 	SBC	HL,DE
  07F4'   38 12                 	JR	C,$+20
  07F6'   11 057B'              M1251:	LD	DE,T23
  07F9'   CD 05C0'              M1252:	CALL	UP12
  07FC'   11 054C'              M1253:	LD	DE,T20
  07FF'   CD 00B8'              M1254:	CALL	UP1
  0802'   CD 0006'              M1255:	CALL	CINF
  0805'   C3 05DC'              M1256:	JP	START
  0808'   3A 0042'              M1257:	LD	A,(MER)
  080B'   47                    	LD	B,A
  080C'   2A 0032'              M1258:	LD	HL,(TANF)
  080F'   C5                    	PUSH	BC
  0810'   D5                    	PUSH	DE
  0811'   E5                    	PUSH	HL
  0812'   EB                    	EX	DE,HL
  0813'   21 0594'              M1259:	LD	HL,T24
  0816'   01 001B               	LD	BC,0001BH
  0819'   ED B0                 	LDIR
  081B'   E1                    	POP	HL
  081C'   C1                    	POP	BC
  081D'   09                    	ADD	HL,BC
  081E'   C5                    	PUSH	BC
  081F'   E5                    	PUSH	HL
  0820'   ED 52                 	SBC	HL,DE
  0822'   3E C9                 	LD	A,0C9H
  0824'   12                    	LD	(DE),A
  0825'   13                    	INC	DE
  0826'   2B                    	DEC	HL
  0827'   7C                    	LD	A,H
  0828'   B5                    	OR	L
  0829'   20 F7                 	JR	NZ,$-07
  082B'   E1                    	POP	HL
  082C'   D1                    	POP	DE
  082D'   C1                    	POP	BC
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-17


  082E'   10 DF                 	DJNZ	$-31
  0830'   D9                    	EXX
  0831'   01 0400               	LD	BC,00400H
  0834'   D9                    	EXX
  0835'   ED 5B 0032'           M1260:	LD	DE,(TANF)
  0839'   CD 0009'              M1261:	CALL	CSTSF
  083C'   20 45                 	JR	NZ,$+71
  083E'   3A 0042'              M1262:	LD	A,(MER)
  0841'   47                    	LD	B,A
  0842'   D5                    	PUSH	DE
  0843'   C5                    	PUSH	BC
  0844'   21 0853'              M1263:	LD	HL,J10
  0847'   E5                    	PUSH	HL
  0848'   D5                    	PUSH	DE
  0849'   01 0000               	LD	BC,0
  084C'   21 0080               	LD	HL,00080H
  084F'   3E FF                 	LD	A,0FFH
  0851'   08                    	EX	AF,AF'
  0852'   C9                    	RET
  0853'   30 24                 J10:	JR	NC,$+38
  0855'   A7                    	AND	A
  0856'   20 21                 	JR	NZ,$+35
  0858'   78                    	LD	A,B
  0859'   FE 01                 	CP	001H
  085B'   20 1C                 	JR	NZ,$+30
  085D'   7D                    	LD	A,L
  085E'   FE 7F                 	CP	07FH
  0860'   20 17                 	JR	NZ,$+25
  0862'   79                    	LD	A,C
  0863'   FE 08                 	CP	008H
  0865'   20 12                 	JR	NZ,$+20
  0867'   C1                    	POP	BC
  0868'   D1                    	POP	DE
  0869'   2A 0038'              M1264:	LD	HL,(BLAE)
  086C'   19                    	ADD	HL,DE
  086D'   EB                    	EX	DE,HL
  086E'   10 D2                 	DJNZ	$-44
  0870'   D9                    	EXX
  0871'   0B                    	DEC	BC
  0872'   78                    	LD	A,B
  0873'   B1                    	OR	C
  0874'   D9                    	EXX
  0875'   20 BE                 	JR	NZ,$-64
  0877'   18 0A                 	JR	$+12
  0879'   C1                    	POP	BC
  087A'   E1                    	POP	HL
  087B'   3E FF                 	LD	A,0FFH
  087D'   CD 05AF'              M1265:	CALL	UP11
  0880'   EB                    	EX	DE,HL
  0881'   18 E6                 	JR	$-24
  0883'   11 054C'              J6:	LD	DE,T20
  0886'   CD 05C0'              M1266:	CALL	UP12
  0889'   CD 0009'              M1267:	CALL	CSTSF
  088C'   CD 0006'              M1269:	CALL	CINF
  088F'   11 0568'              M1270:	LD	DE,T21A
  0892'   CD 05C0'              M1271:	CALL	UP12
  0895'   11 056D'              M1272:	LD	DE,T22
  0898'   CD 0128'              M1273:	CALL	UP3
  089B'   CA 05DC'              M1274:	JP	Z,START
  089E'   C3 05E8'              M1275:	JP	J3
                                
  08A1'   ED 5B 0016'           UP16:	LD	DE,(REND)
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-18


  08A5'   2A 0032'              M1276:	LD	HL,(TANF)
  08A8'   AF                    	XOR	A
  08A9'   ED 52                 	SBC	HL,DE
  08AB'   D0                    	RET	NC
  08AC'   ED 5B 0034'           M1277:	LD	DE,(TEND)
  08B0'   2A 0014'              M1278:	LD	HL,(RANF)
  08B3'   ED 52                 	SBC	HL,DE
  08B5'   D0                    	RET	NC
  08B6'   2A 0016'              M1279:	LD	HL,(REND)
  08B9'   E5                    	PUSH	HL
  08BA'   ED 5B 0014'           M1280:	LD	DE,(RANF)	;RAMBUGANFANG
  08BE'   AF                    	XOR	A
  08BF'   ED 52                 	SBC	HL,DE	;LAENGE RAMBUG
  08C1'   E5                    	PUSH	HL
  08C2'   C1                    	POP	BC
  08C3'   E1                    	POP	HL	;REND
  08C4'   ED 5B 0034'           M1281:	LD	DE,(TEND)
  08C8'   ED 52                 	SBC	HL,DE
  08CA'   38 04                 	JR	C,M1283
  08CC'   ED 5B 0016'           M1282:	LD	DE,(REND)	;DE=MAX(REND,TEND)
  08D0'   2A 001A'              M1283:	LD	HL,(RAEND)
  08D3'   AF                    	XOR	A
  08D4'   ED 52                 	SBC	HL,DE	;FREIER PLATZ BIS RAM-ENDE
  08D6'   38 0A                 	JR	C,M1285
  08D8'   ED 42                 	SBC	HL,BC	;FREIER PLATZ - LAENGE RAMBUG
  08DA'   38 06                 	JR	C,M1285
  08DC'   13                    	INC	DE
  08DD'   CD 096E'              M1284:	CALL	UP161
  08E0'   20 30                 	JR	NZ,VER	;J... VERSCHIEBUNG RAMBUG
  08E2'   2A 0014'              M1285:	LD	HL,(RANF)
  08E5'   ED 5B 0032'           M1286:	LD	DE,(TANF)
  08E9'   E5                    	PUSH	HL
  08EA'   AF                    	XOR	A
  08EB'   ED 52                 	SBC	HL,DE
  08ED'   E1                    	POP	HL
  08EE'   38 01                 	JR	C,MV5
  08F0'   EB                    	EX	DE,HL	;HL=MIN(TANF,RANF)
  08F1'   11 4000               MV5:	LD	DE,4000H
  08F4'   E5                    	PUSH	HL
  08F5'   2A 0018'              M1287:	LD	HL,(RAANF)
  08F8'   E5                    	PUSH	HL
  08F9'   AF                    	XOR	A
  08FA'   ED 52                 	SBC	HL,DE
  08FC'   E1                    	POP	HL
  08FD'   38 01                 	JR	C,MV6
  08FF'   EB                    	EX	DE,HL	;DE=MAX(RAANF,4000H)
  0900'   E1                    MV6:	POP	HL
  0901'   AF                    	XOR	A
  0902'   ED 52                 	SBC	HL,DE
  0904'   DA 01AD'              M1288:	JP	C,J1
  0907'   ED 42                 	SBC	HL,BC	;FREIER SPEICHER - LAENGE RAMBUG
  0909'   DA 01AD'              M1289:	JP	C,J1
  090C'   CD 096E'              M1290:	CALL	UP161
  090F'   CA 05DC'              M1291:	JP	Z,START
  0912'   E5                    VER:	PUSH	HL
  0913'   D5                    	PUSH	DE
  0914'   ED B0                 	LDIR
  0916'   AF                    	XOR	A
  0917'   D1                    	POP	DE
  0918'   E1                    	POP	HL
  0919'   ED 52                 	SBC	HL,DE
  091B'   E5                    	PUSH	HL
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-19


  091C'   C1                    	POP	BC
  091D'   DD 21 0BB0'           M1305:	LD	IX,GEN1
  0921'   DD 6E 00              	LD	L,(IX+00)
  0924'   DD 23                 	INC	IX
  0926'   DD 66 00              	LD	H,(IX+00)
  0929'   DD 23                 	INC	IX
  092B'   7C                    	LD	A,H
  092C'   B5                    	OR	L
  092D'   28 18                 	JR	Z,$+26
  092F'   2B                    	DEC	HL
  0930'   19                    	ADD	HL,DE
  0931'   D5                    	PUSH	DE
  0932'   5E                    	LD	E,M
  0933'   23                    	INC	HL
  0934'   56                    	LD	D,M
  0935'   EB                    	EX	DE,HL
  0936'   ED 42                 	SBC	HL,BC
  0938'   EB                    	EX	DE,HL
  0939'   72                    	LD	M,D
  093A'   7E                    	LD	A,M
  093B'   BA                    	CP	D
  093C'   20 0D                 	JR	NZ,$+15
  093E'   2B                    	DEC	HL
  093F'   73                    	LD	M,E
  0940'   7E                    	LD	A,M
  0941'   BB                    	CP	E
  0942'   20 07                 	JR	NZ,$+09
  0944'   D1                    	POP	DE
  0945'   18 DA                 	JR	$-36
  0947'   E1                    	POP	HL
  0948'   ED 42                 	SBC	HL,BC
  094A'   E9                    	JP	(HL)
  094B'   CD 00C8'              M1306:	CALL	SOUT
  094E'   0D                    	DB	00DH
  094F'   2A 20 53 70           	DB	'* Speicherfehler *'
  0953'   65 69 63 68           
  0957'   65 72 66 65           
  095B'   68 6C 65 72           
  095F'   20 2A                 
  0961'   8D                    	DB	00DH+80H
  0962'   11 054C'              M1307:	LD	DE,T20
  0965'   CD 00B8'              M1308:	CALL	UP1
  0968'   CD 0006'              M1309:	CALL	CINF
  096B'   C3 05DC'              M1310:	JP	START
                                
  096E'   CD 00C8'              UP161:	CALL	SOUT
  0971'   54 65 73 74           	DB	'Test verschieben von'
  0975'   20 76 65 72           
  0979'   73 63 68 69           
  097D'   65 62 65 6E           
  0981'   20 76 6F 6E           
  0985'   A0                    	DB	20H+80H
  0986'   2A 0014'              M1601:	LD	HL,(RANF)
  0989'   CD 01A2'              M1602:	CALL	UP7
  098C'   CD 00C8'              M1603:	CALL	SOUT
  098F'   20 6E 61 63           	DB	' nach'
  0993'   68                    
  0994'   A0                    	DB	20H+80H
  0995'   EB                    	EX	DE,HL
  0996'   CD 01A2'              M1604:	CALL	UP7
  0999'   EB                    	EX	DE,HL
  099A'   D5                    	PUSH	DE
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-20


  099B'   11 01C6'              M1605:	LD	DE,T1
  099E'   CD 0128'              M1606:	CALL	UP3
  09A1'   D1                    	POP	DE
  09A2'   C9                    	RET
                                
  09A3'   F5                    UP17:	PUSH	AF
  09A4'   C5                    	PUSH	BC
  09A5'   D5                    	PUSH	DE
  09A6'   E5                    	PUSH	HL
  09A7'   FD 21 0000            	LD	IY,0
  09AB'   2A 0014'              M1311:	LD	HL,(RANF)
  09AE'   01 00B8               	LD	BC,UP1-RBANF
  09B1'   09                    	ADD	HL,BC
  09B2'   E5                    	PUSH	HL
  09B3'   C1                    	POP	BC
  09B4'   2A 0014'              M1312:	LD	HL,(RANF)
  09B7'   11 0E4D               	LD	DE,RBEND-RBANF-1
  09BA'   19                    	ADD	HL,DE
  09BB'   EB                    	EX	DE,HL
  09BC'   DD 21 0BC0'           M1313:	LD	IX,GEN2
  09C0'   DD 6E 00              	LD	L,(IX+00)
  09C3'   DD 23                 	INC	IX
  09C5'   DD 66 00              	LD	H,(IX+00)
  09C8'   DD 23                 	INC	IX
  09CA'   2B                    	DEC	HL
  09CB'   D5                    	PUSH	DE
  09CC'   ED 5B 0014'           M1314:	LD	DE,(RANF)
  09D0'   19                    	ADD	HL,DE
  09D1'   D1                    	POP	DE
  09D2'   AF                    	XOR	A
  09D3'   ED 42                 	SBC	HL,BC
  09D5'   28 15                 	JR	Z,$+23
  09D7'   D5                    	PUSH	DE
  09D8'   EB                    	EX	DE,HL
  09D9'   AF                    	XOR	A
  09DA'   ED 42                 	SBC	HL,BC
  09DC'   38 12                 	JR	C,$+20
  09DE'   EB                    	EX	DE,HL
  09DF'   0A                    	LD	A,(BC)
  09E0'   5F                    	LD	E,A
  09E1'   16 00                 	LD	D,0
  09E3'   FD 19                 	ADD	IY,DE
  09E5'   D1                    	POP	DE
  09E6'   03                    	INC	BC
  09E7'   2B                    	DEC	HL
  09E8'   7C                    	LD	A,H
  09E9'   B5                    	OR	L
  09EA'   20 EB                 	JR	NZ,$-19
  09EC'   03                    	INC	BC
  09ED'   03                    	INC	BC
  09EE'   18 D0                 	JR	$-46
  09F0'   D1                    	POP	DE
  09F1'   ED 4B 00B5'           M1315:	LD	BC,(CHK)
  09F5'   FD E5                 	PUSH	IY
  09F7'   E1                    	POP	HL
  09F8'   AF                    	XOR	A
  09F9'   ED 42                 	SBC	HL,BC
  09FB'   C2 01AD'              M1316:	JP	NZ,J1
  09FE'   E1                    	POP	HL
  09FF'   D1                    	POP	DE
  0A00'   C1                    	POP	BC
  0A01'   F1                    	POP	AF
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-21


  0A02'   C9                    	RET
                                
  0A03'   0A03'                 M201:	DW	$
  0A05'   52 41 4D 54           	DB	'RAMT'
  0A09'   F3                    	DI
  0A0A'   31 00B3'              M2011:	LD	SP,SV4
  0A0D'   D3 C4                 	OUT	(0C4H),A
  0A0F'   CD 0B3D'              M202:	CALL	DEG
  0A12'   C3 0000'              M203:	JP	RBANF
                                
  0A15'   CD 0B55'              CON:	CALL	BWSZU
  0A18'   E5                    	PUSH	HL
  0A19'   C5                    	PUSH	BC
  0A1A'   D5                    	PUSH	DE
  0A1B'   F5                    	PUSH	AF
  0A1C'   CD 0A92'              M204:	CALL	CPOS
  0A1F'   CB BE                 	RES	7,(HL)
  0A21'   F1                    	POP	AF
  0A22'   CB BF                 	RES	7,A
  0A24'   FE 0A                 	CP	00AH
  0A26'   28 27                 	JR	Z,CON9
  0A28'   FE 0D                 	CP	00DH
  0A2A'   28 09                 	JR	Z,CON2
  0A2C'   77                    	LD	(HL),A
  0A2D'   23                    	INC	HL
  0A2E'   CB FE                 	SET	7,(HL)
  0A30'   CD 0AA6'              M205:	CALL	LCPOS
  0A33'   18 1A                 	JR	CON9
  0A35'   CD 0AC3'              CON2:	CALL	ZLPOS
  0A38'   11 0050               M206:	LD	DE,80
  0A3B'   19                    	ADD	HL,DE
  0A3C'   E5                    	PUSH	HL
  0A3D'   21 3780               	LD	HL,BWSA+1920
  0A40'   D1                    	POP	DE
  0A41'   B7                    	OR	A
  0A42'   ED 52                 	SBC	HL,DE
  0A44'   20 05                 	JR	NZ,CON3
  0A46'   CD 0ACF'              M207:	CALL	LOE
  0A49'   18 04                 	JR	CON9
  0A4B'   EB                    CON3:	EX	DE,HL
  0A4C'   CD 0AA6'              M208:	CALL	LCPOS
  0A4F'   D1                    CON9:	POP	DE
  0A50'   C1                    	POP	BC
  0A51'   E1                    	POP	HL
  0A52'   C3 0B67'              M209:	JP	BWSAB
                                
  0A55'   CD 0A5B'              CIN:	CALL	CSTS
  0A58'   28 FB                 	JR	Z,CIN
  0A5A'   C9                    	RET
                                
  0A5B'   DB A1                 CSTS:	IN	A,(ATAST+1)
  0A5D'   2F                    	CPL
  0A5E'   CB 5F                 	BIT	3,A
  0A60'   C8                    	RET	Z
  0A61'   DB A0                 	IN	A,(ATAST)
  0A63'   FE 9D                 	CP	09DH
  0A65'   C0                    	RET	NZ
  0A66'   3E 0D                 	LD	A,0DH
  0A68'   B7                    	OR	A
  0A69'   C9                    	RET
                                
  0A6A'   F5                    CHOM:	PUSH	AF
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-22


  0A6B'   C5                    	PUSH	BC
  0A6C'   D5                    	PUSH	DE
  0A6D'   E5                    	PUSH	HL
  0A6E'   CD 0ACF'              CHOM0:	CALL	LOE
  0A71'   E1                    	POP	HL
  0A72'   D1                    	POP	DE
  0A73'   C1                    	POP	BC
  0A74'   F1                    	POP	AF
  0A75'   C9                    	RET
                                
  0A76'   CD 0B55'              CADR:	CALL	BWSZU
  0A79'   F5                    	PUSH	AF
  0A7A'   E5                    	PUSH	HL
  0A7B'   D5                    	PUSH	DE
  0A7C'   CD 0A92'              CADR0:	CALL	CPOS
  0A7F'   CB BE                 	RES	7,(HL)
  0A81'   D1                    	POP	DE
  0A82'   D5                    	PUSH	DE
  0A83'   ED 53 003A'           M213:	LD	(ZPOS),DE
  0A87'   CD 0A92'              M214:	CALL	CPOS
  0A8A'   CB FE                 	SET	7,(HL)
  0A8C'   D1                    	POP	DE
  0A8D'   E1                    	POP	HL
  0A8E'   F1                    	POP	AF
  0A8F'   C3 0B67'              M214A:	JP	BWSAB
                                
  0A92'   2A 003B'              CPOS:	LD	HL,(SPOS)
  0A95'   11 3000               	LD	DE,BWSA
  0A98'   62                    	LD	H,D
  0A99'   3A 003A'              M215:	LD	A,(ZPOS)
  0A9C'   B7                    PNSP:	OR	A
  0A9D'   C8                    	RET	Z
  0A9E'   11 0050               M216:	LD	DE,80
  0AA1'   19                    PNSP1:	ADD	HL,DE
  0AA2'   3D                    	DEC	A
  0AA3'   20 FC                 	JR	NZ,PNSP1
  0AA5'   C9                    	RET
                                
  0AA6'   E5                    LCPOS:	PUSH	HL
  0AA7'   D5                    	PUSH	DE
  0AA8'   11 3000               	LD	DE,BWSA
  0AAB'   B7                    	OR	A
  0AAC'   ED 52                 	SBC	HL,DE
  0AAE'   11 0050               M217:	LD	DE,80
  0AB1'   AF                    	XOR	A
  0AB2'   ED 52                 LCP1:	SBC	HL,DE
  0AB4'   3C                    	INC	A
  0AB5'   30 FB                 	JR	NC,LCP1
  0AB7'   19                    	ADD	HL,DE
  0AB8'   3D                    	DEC	A
  0AB9'   32 003A'              M218:	LD	(ZPOS),A
  0ABC'   7D                    	LD	A,L
  0ABD'   32 003B'              M219:	LD	(SPOS),A
  0AC0'   D1                    	POP	DE
  0AC1'   E1                    	POP	HL
  0AC2'   C9                    	RET
                                
  0AC3'   21 3000               ZLPOS:	LD	HL,BWSA
  0AC6'   F5                    	PUSH	AF
  0AC7'   3A 003A'              M220:	LD	A,(ZPOS)
  0ACA'   CD 0A9C'              POS4:	CALL	PNSP
  0ACD'   F1                    POS1:	POP	AF
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-23


  0ACE'   C9                    	RET
                                
  0ACF'   CD 0B55'              LOE:	CALL	BWSZU
  0AD2'   21 3000               	LD	HL,BWSA
  0AD5'   11 3001               	LD	DE,BWSA+1
  0AD8'   01 0780               	LD	BC,1920
  0ADB'   36 20                 	LD	(HL),' '
  0ADD'   ED B0                 	LDIR
  0ADF'   21 0000               	LD	HL,0
  0AE2'   22 003A'              M221:	LD	(ZPOS),HL
  0AE5'   21 3000               	LD	HL,BWSA
  0AE8'   CB FE                 	SET	7,(HL)
  0AEA'   C3 0B67'              M221A:	JP	BWSAB
                                
  0AED'   D5                    UP18:	PUSH	DE
  0AEE'   E5                    	PUSH	HL
  0AEF'   F5                    	PUSH	AF
  0AF0'   CD 0A6A'              M224:	CALL	CHOM
  0AF3'   CD 00C8'              M225:	CALL	SOUT
  0AF6'   0D                    	DB	00DH
  0AF7'   52 65 63 68           	DB	'Rechnerkonfiguration (A,S) '
  0AFB'   6E 65 72 6B           
  0AFF'   6F 6E 66 69           
  0B03'   67 75 72 61           
  0B07'   74 69 6F 6E           
  0B0B'   20 28 41 2C           
  0B0F'   53 29 20              
  0B12'   BA                    	DB	03AH+80H
  0B13'   CD 0A55'              M226:	CALL	CIN
  0B16'   F5                    	PUSH	AF
  0B17'   CD 0003'              M227:	CALL	CONF
  0B1A'   11 0B3A'              M227A:	LD	DE,T27
  0B1D'   CD 0128'              M227B:	CALL	UP3
  0B20'   20 03                 	JR	NZ,MV15
  0B22'   F1                    	POP	AF
  0B23'   18 CB                 	JR	M224
  0B25'   F1                    MV15:	POP	AF
  0B26'   FE 53                 	CP	53H
  0B28'   20 05                 	JR	NZ,M229A
  0B2A'   CD 0B3D'              M229:	CALL	DEG
  0B2D'   18 07                 	JR	M2301
  0B2F'   FE 41                 M229A:	CP	41H
  0B31'   20 03                 	JR	NZ,M2301
  0B33'   CD 0B79'              M230:	CALL	ANW
  0B36'   F1                    M2301:	POP	AF
  0B37'   E1                    	POP	HL
  0B38'   D1                    	POP	DE
  0B39'   C9                    	RET
                                
  0B3A'   0D                    T27:	DB	00DH
  0B3B'   0D                    	DB	00DH
  0B3C'   8D                    	DB	00DH+80H
                                
  0B3D'   E5                    DEG:	PUSH	HL
  0B3E'   F5                    	PUSH	AF
  0B3F'   21 27A7               	LD	HL,027A7H
  0B42'   22 003C'              M231:	LD	(UM),HL
  0B45'   21 0484               	LD	HL,00484H
  0B48'   22 003E'              M232:	LD	(UM1),HL
  0B4B'   21 0000               	LD	HL,0
  0B4E'   22 0040'              M2321:	LD	(UM2),HL
  0B51'   F1                    	POP	AF
'RB20	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-24


  0B52'   E1                    	POP	HL
  0B53'   18 12                 	JR	BWSAB
                                
  0B55'   F5                    BWSZU:	PUSH	AF
  0B56'   3A 0041'              M242:	LD	A,(UM2+1)
  0B59'   D3 C2                 	OUT	(SPBA+2),A
  0B5B'   3A 003F'              M243:	LD	A,(UM1+1)
  0B5E'   D3 C1                 	OUT	(SPBA+1),A
  0B60'   3A 003D'              M2431:	LD	A,(UM+1)
  0B63'   D3 C0                 	OUT	(SPBA),A
  0B65'   F1                    	POP	AF
  0B66'   C9                    	RET
                                
  0B67'   F5                    BWSAB:	PUSH	AF
  0B68'   3A 003C'              M244:	LD	A,(UM)
  0B6B'   D3 C0                 	OUT	(SPBA),A
  0B6D'   3A 003E'              M245:	LD	A,(UM1)
  0B70'   D3 C1                 	OUT	(SPBA+1),A
  0B72'   3A 0040'              M2451:	LD	A,(UM2)
  0B75'   D3 C2                 	OUT	(SPBA+2),A
  0B77'   F1                    	POP	AF
  0B78'   C9                    	RET
                                
  0B79'   CD 00C8'              ANW:	CALL	SOUT	;ANWENDERMODUS
  0B7C'   0D                    	DB	0DH
  0B7D'   53 59 53 31           	DB	'SYS1'
  0B81'   BA                    	DB	3AH+80H
  0B82'   CD 0184'              M246:	CALL	UP4
  0B85'   22 003C'              M247:	LD	(UM),HL
  0B88'   CD 00C8'              M248:	CALL	SOUT
  0B8B'   0D                    	DB	0DH
  0B8C'   53 59 53 32           	DB	'SYS2'
  0B90'   BA                    	DB	3AH+80H
  0B91'   CD 0184'              M249:	CALL	UP4
  0B94'   22 003E'              M250:	LD	(UM1),HL
  0B97'   CD 00C8'              M251:	CALL	SOUT
  0B9A'   0D                    	DB	0DH
  0B9B'   53 59 53 33           	DB	'SYS3'
  0B9F'   BA                    	DB	3AH+80H
  0BA0'   CD 0184'              M2511:	CALL	UP4
  0BA3'   22 0040'              M2512:	LD	(UM2),HL
  0BA6'   11 0B3A'              M254:	LD	DE,T27
  0BA9'   CD 0128'              M255:	CALL	UP3
  0BAC'   28 CB                 	JR	Z,ANW
  0BAE'   18 B7                 	JR	BWSAB
                                
                                	TITLE	'RB30	RAM-Test'
                                	PAGE
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-25


                                
                                ;	END
                                ;	PN	RB30
                                
  0BB0'   0002                  GEN1:	DW	RBANF-RBANF+2
  0BB2'   0005                  	DW	CONF-RBANF+2
  0BB4'   0008                  	DW	CINF-RBANF+2
  0BB6'   000B                  	DW	CSTSF-RBANF+2
  0BB8'   000E                  	DW	CADRF-RBANF+2
  0BBA'   0011                  	DW	CHOMF-RBANF+2
  0BBC'   0015                  	DW	RANF-RBANF+1
  0BBE'   0017                  	DW	REND-RBANF+1
  0BC0'   00BE                  GEN2:	DW	M1001-RBANF+2
  0BC2'   00CF                  	DW	M1002-RBANF+2
  0BC4'   00DD                  	DW	M1003-RBANF+2
  0BC6'   00EE                  	DW	M1004-RBANF+2
  0BC8'   0103                  	DW	M1005-RBANF+2
  0BCA'   011F                  	DW	M1006-RBANF+2
  0BCC'   0125                  	DW	M1007-RBANF+2
  0BCE'   012A                  	DW	UP3-RBANF+2
  0BD0'   012D                  	DW	M1008-RBANF+2
  0BD2'   0139                  	DW	M1009-RBANF+2
  0BD4'   013D                  	DW	M1010-RBANF+2
  0BD6'   0140                  	DW	M1011-RBANF+2
  0BD8'   0156                  	DW	M1012-RBANF+2
  0BDA'   0186                  	DW	UP4-RBANF+2
  0BDC'   0190                  	DW	M1013-RBANF+2
  0BDE'   019F                  	DW	M1014-RBANF+2
  0BE0'   01A6                  	DW	M1015-RBANF+2
  0BE2'   01AA                  	DW	M1016-RBANF+2
  0BE4'   01AF                  	DW	J1-RBANF+2
  0BE6'   01B2                  	DW	M1017-RBANF+2
  0BE8'   0259                  	DW	UP8-RBANF+2
  0BEA'   025C                  	DW	M1018-RBANF+2
  0BEC'   027B                  	DW	M1019-RBANF+2
  0BEE'   028C                  	DW	M1020-RBANF+2
  0BF0'   028F                  	DW	M1021-RBANF+2
  0BF2'   02A0                  	DW	M1022-RBANF+2
  0BF4'   02A4                  	DW	M1023-RBANF+2
  0BF6'   02BA                  	DW	M1024-RBANF+2
  0BF8'   02BD                  	DW	M1025-RBANF+2
  0BFA'   02C0                  	DW	M1026-RBANF+2
  0BFC'   02C5                  	DW	M1027-RBANF+2
  0BFE'   02C8                  	DW	M1028-RBANF+2
  0C00'   02DF                  	DW	M1029-RBANF+2
  0C02'   02E2                  	DW	M1030-RBANF+2
  0C04'   02E5                  	DW	M1031-RBANF+2
  0C06'   02E9                  	DW	M1032-RBANF+2
  0C08'   02EC                  	DW	M1033-RBANF+2
  0C0A'   02EF                  	DW	J2-RBANF+2
  0C0C'   0307                  	DW	M1034-RBANF+2
  0C0E'   030A                  	DW	M1035-RBANF+2
  0C10'   030E                  	DW	M1036-RBANF+2
  0C12'   0324                  	DW	M1037-RBANF+2
  0C14'   0327                  	DW	M1038-RBANF+2
  0C16'   032F                  	DW	M1039-RBANF+2
  0C18'   0333                  	DW	M1040-RBANF+2
  0C1A'   0349                  	DW	M1041-RBANF+2
  0C1C'   034D                  	DW	M1042-RBANF+2
  0C1E'   0351                  	DW	M1043-RBANF+3
  0C20'   035C                  	DW	M1044-RBANF+2
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-26


  0C22'   0360                  	DW	M1045-RBANF+3
  0C24'   036E                  	DW	M1046-RBANF+2
  0C26'   038C                  	DW	M1047-RBANF+2
  0C28'   038F                  	DW	M1048-RBANF+2
  0C2A'   03A6                  	DW	M1049-RBANF+2
  0C2C'   03A9                  	DW	M1050-RBANF+2
  0C2E'   03BA                  	DW	M1051-RBANF+2
  0C30'   03D2                  	DW	M1052-RBANF+2
  0C32'   03D6                  	DW	M1053-RBANF+2
  0C34'   03D9                  	DW	M1054-RBANF+2
  0C36'   03F5                  	DW	M1055-RBANF+2
  0C38'   03FD                  	DW	M1057-RBANF+2
  0C3A'   0417                  	DW	M1058-RBANF+2
  0C3C'   041A                  	DW	M1059-RBANF+2
  0C3E'   0440                  	DW	M1061-RBANF+2
  0C40'   0443                  	DW	M1062-RBANF+2
  0C42'   0446                  	DW	M1063-RBANF+2
  0C44'   0449                  	DW	M1067-RBANF+2
  0C46'   044C                  	DW	M1068-RBANF+2
  0C48'   044F                  	DW	M1069-RBANF+2
  0C4A'   0452                  	DW	M1070-RBANF+2
  0C4C'   0455                  	DW	M1071-RBANF+2
  0C4E'   0458                  	DW	M1072-RBANF+2
  0C50'   045B                  	DW	M1073-RBANF+2
  0C52'   045E                  	DW	M1074-RBANF+2
  0C54'   0461                  	DW	M1075-RBANF+2
  0C56'   0464                  	DW	M1076-RBANF+2
  0C58'   0467                  	DW	M1077-RBANF+2
  0C5A'   046A                  	DW	M1078-RBANF+2
  0C5C'   046D                  	DW	M1082-RBANF+2
  0C5E'   0470                  	DW	M1083-RBANF+2
  0C60'   0473                  	DW	M1084-RBANF+2
  0C62'   0476                  	DW	M1085-RBANF+2
  0C64'   0479                  	DW	M1086-RBANF+2
  0C66'   047C                  	DW	M1087-RBANF+2
  0C68'   047F                  	DW	M1088-RBANF+2
  0C6A'   0482                  	DW	M1089-RBANF+2
  0C6C'   0485                  	DW	M1090-RBANF+2
  0C6E'   0490                  	DW	UP9-RBANF+2
  0C70'   0493                  	DW	M1091-RBANF+2
  0C72'   049E                  	DW	M1093-RBANF+2
  0C74'   04A5                  	DW	M1094-RBANF+2
  0C76'   04AA                  	DW	M1096-RBANF+2
  0C78'   04B3                  	DW	M1097-RBANF+2
  0C7A'   04B9                  	DW	M1099-RBANF+2
  0C7C'   04BF                  	DW	M1100-RBANF+2
  0C7E'   04C3                  	DW	M1101-RBANF+3
  0C80'   04C6                  	DW	M1102-RBANF+2
  0C82'   04CA                  	DW	M1103-RBANF+2
  0C84'   04CE                  	DW	M1104-RBANF+2
  0C86'   04D1                  	DW	M1105-RBANF+2
  0C88'   04DB                  	DW	M1107-RBANF+2
  0C8A'   04E2                  	DW	M1108-RBANF+2
  0C8C'   04F1                  	DW	M1109-RBANF+2
  0C8E'   04F8                  	DW	M1110-RBANF+3
  0C90'   051E                  	DW	M1111-RBANF+2
  0C92'   052A                  	DW	M1115-RBANF+2
  0C94'   0530                  	DW	M1116-RBANF+2
  0C96'   0534                  	DW	M1117-RBANF+2
  0C98'   0537                  	DW	M1118-RBANF+2
  0C9A'   05B3                  	DW	M1120-RBANF+2
  0C9C'   05BD                  	DW	M1121-RBANF+2
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-27


  0C9E'   05C6                  	DW	M1122-RBANF+2
  0CA0'   05CF                  	DW	M1124-RBANF+2
  0CA2'   05D2                  	DW	M1125-RBANF+2
  0CA4'   05D5                  	DW	M1126-RBANF+2
  0CA6'   05D9                  	DW	M1127-RBANF+2
  0CA8'   05DE                  	DW	START-RBANF+2
  0CAA'   05E1                  	DW	ST1-RBANF+2
  0CAC'   05E4                  	DW	M1128-RBANF+2
  0CAE'   05E7                  	DW	M1129-RBANF+2
  0CB0'   05EA                  	DW	J3-RBANF+2
  0CB2'   05ED                  	DW	M1130-RBANF+2
  0CB4'   05F0                  	DW	M1132-RBANF+2
  0CB6'   05F9                  	DW	M1133-RBANF+2
  0CB8'   05FC                  	DW	M1134-RBANF+2
  0CBA'   05FF                  	DW	M1135-RBANF+2
  0CBC'   0604                  	DW	M1136-RBANF+2
  0CBE'   0608                  	DW	M1137-RBANF+3
  0CC0'   060F                  	DW	M1138-RBANF+2
  0CC2'   0612                  	DW	M1139-RBANF+2
  0CC4'   061B                  	DW	M1141-RBANF+2
  0CC6'   0626                  	DW	M1144-RBANF+2
  0CC8'   062F                  	DW	M1145-RBANF+2
  0CCA'   0632                  	DW	M1146-RBANF+2
  0CCC'   0635                  	DW	M1147-RBANF+2
  0CCE'   0639                  	DW	M1151-RBANF+2
  0CD0'   063F                  	DW	M1152-RBANF+2
  0CD2'   0643                  	DW	M1153-RBANF+3
  0CD4'   0657                  	DW	M1155-RBANF+2
  0CD6'   065B                  	DW	M1156-RBANF+3
  0CD8'   0667                  	DW	M1157-RBANF+2
  0CDA'   066C                  	DW	M1158-RBANF+2
  0CDC'   067B                  	DW	M1161-RBANF+2
  0CDE'   0684                  	DW	M1162-RBANF+2
  0CE0'   0687                  	DW	M1163-RBANF+2
  0CE2'   068A                  	DW	M1164-RBANF+2
  0CE4'   068D                  	DW	M1167-RBANF+2
  0CE6'   0694                  	DW	M1168-RBANF+2
  0CE8'   0698                  	DW	M1169-RBANF+3
  0CEA'   06AA                  	DW	M1171-RBANF+2
  0CEC'   06AE                  	DW	M1172-RBANF+3
  0CEE'   06B8                  	DW	M1173-RBANF+2
  0CF0'   06BD                  	DW	M1174-RBANF+2
  0CF2'   06CC                  	DW	M1181-RBANF+2
  0CF4'   06D5                  	DW	M1182-RBANF+2
  0CF6'   06D8                  	DW	M1183-RBANF+2
  0CF8'   06DB                  	DW	M1184-RBANF+2
  0CFA'   06E0                  	DW	M1185-RBANF+2
  0CFC'   06E4                  	DW	M1186-RBANF+2
  0CFE'   06E7                  	DW	M1187-RBANF+2
  0D00'   06EA                  	DW	M1192-RBANF+2
  0D02'   06EF                  	DW	M1193-RBANF+2
  0D04'   06F4                  	DW	M1194-RBANF+2
  0D06'   06F7                  	DW	M1195-RBANF+2
  0D08'   06FA                  	DW	M1196-RBANF+2
  0D0A'   06FF                  	DW	M1205-RBANF+2
  0D0C'   0703                  	DW	M1206-RBANF+2
  0D0E'   0706                  	DW	M1207-RBANF+2
  0D10'   070B                  	DW	UP15-RBANF+2
  0D12'   070F                  	DW	M1210-RBANF+3
  0D14'   0712                  	DW	M1211-RBANF+2
  0D16'   0718                  	DW	M1212-RBANF+2
  0D18'   0721                  	DW	M1213-RBANF+2
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-28


  0D1A'   0731                  	DW	M1214-RBANF+3
  0D1C'   0738                  	DW	M1215-RBANF+3
  0D1E'   073E                  	DW	M1216-RBANF+2
  0D20'   0741                  	DW	M1217-RBANF+2
  0D22'   0746                  	DW	M1218-RBANF+2
  0D24'   074D                  	DW	M1219-RBANF+3
  0D26'   0752                  	DW	M1220-RBANF+2
  0D28'   0756                  	DW	M1221-RBANF+2
  0D2A'   075B                  	DW	M1222-RBANF+2
  0D2C'   0764                  	DW	M1223-RBANF+2
  0D2E'   076B                  	DW	J5-RBANF+2
  0D30'   0774                  	DW	M1224-RBANF+2
  0D32'   0777                  	DW	M1225-RBANF+2
  0D34'   077A                  	DW	M1226-RBANF+2
  0D36'   077F                  	DW	M1227-RBANF+2
  0D38'   0785                  	DW	M1228-RBANF+2
  0D3A'   0789                  	DW	M1229-RBANF+3
  0D3C'   0792                  	DW	M1230-RBANF+2
  0D3E'   079B                  	DW	M1232-RBANF+2
  0D40'   079E                  	DW	M1233-RBANF+2
  0D42'   07AD                  	DW	M1234-RBANF+2
  0D44'   07B6                  	DW	M1236-RBANF+2
  0D46'   07B9                  	DW	M1237-RBANF+2
  0D48'   07BC                  	DW	M1238-RBANF+2
  0D4A'   07C0                  	DW	M1239-RBANF+3
  0D4C'   07C6                  	DW	M1240-RBANF+2
  0D4E'   07CB                  	DW	M1241-RBANF+2
  0D50'   07DA                  	DW	M1245-RBANF+2
  0D52'   07DF                  	DW	M1246-RBANF+2
  0D54'   07E4                  	DW	M1247-RBANF+2
  0D56'   07E7                  	DW	M1248-RBANF+2
  0D58'   07EA                  	DW	M1249-RBANF+2
  0D5A'   07EE                  	DW	M1250-RBANF+3
  0D5C'   07F8                  	DW	M1251-RBANF+2
  0D5E'   07FB                  	DW	M1252-RBANF+2
  0D60'   07FE                  	DW	M1253-RBANF+2
  0D62'   0801                  	DW	M1254-RBANF+2
  0D64'   0804                  	DW	M1255-RBANF+2
  0D66'   0807                  	DW	M1256-RBANF+2
  0D68'   080A                  	DW	M1257-RBANF+2
  0D6A'   080E                  	DW	M1258-RBANF+2
  0D6C'   0815                  	DW	M1259-RBANF+2
  0D6E'   0838                  	DW	M1260-RBANF+3
  0D70'   083B                  	DW	M1261-RBANF+2
  0D72'   0840                  	DW	M1262-RBANF+2
  0D74'   0846                  	DW	M1263-RBANF+2
  0D76'   086B                  	DW	M1264-RBANF+2
  0D78'   087F                  	DW	M1265-RBANF+2
  0D7A'   0885                  	DW	J6-RBANF+2
  0D7C'   0888                  	DW	M1266-RBANF+2
  0D7E'   088B                  	DW	M1267-RBANF+2
  0D80'   088E                  	DW	M1269-RBANF+2
  0D82'   0891                  	DW	M1270-RBANF+2
  0D84'   0894                  	DW	M1271-RBANF+2
  0D86'   0897                  	DW	M1272-RBANF+2
  0D88'   089A                  	DW	M1273-RBANF+2
  0D8A'   089D                  	DW	M1274-RBANF+2
  0D8C'   08A0                  	DW	M1275-RBANF+2
  0D8E'   08A4                  	DW	UP16-RBANF+3
  0D90'   08A7                  	DW	M1276-RBANF+2
  0D92'   08AF                  	DW	M1277-RBANF+3
  0D94'   08B2                  	DW	M1278-RBANF+2
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-29


  0D96'   08B8                  	DW	M1279-RBANF+2
  0D98'   08BD                  	DW	M1280-RBANF+3
  0D9A'   08C7                  	DW	M1281-RBANF+3
  0D9C'   08CF                  	DW	M1282-RBANF+3
  0D9E'   08D2                  	DW	M1283-RBANF+2
  0DA0'   08DF                  	DW	M1284-RBANF+2
  0DA2'   08E4                  	DW	M1285-RBANF+2
  0DA4'   08E8                  	DW	M1286-RBANF+3
  0DA6'   08F7                  	DW	M1287-RBANF+2
  0DA8'   0906                  	DW	M1288-RBANF+2
  0DAA'   090B                  	DW	M1289-RBANF+2
  0DAC'   090E                  	DW	M1290-RBANF+2
  0DAE'   0911                  	DW	M1291-RBANF+2
  0DB0'   0920                  	DW	M1305-RBANF+3
  0DB2'   094D                  	DW	M1306-RBANF+2
  0DB4'   0964                  	DW	M1307-RBANF+2
  0DB6'   0967                  	DW	M1308-RBANF+2
  0DB8'   096A                  	DW	M1309-RBANF+2
  0DBA'   096D                  	DW	M1310-RBANF+2
  0DBC'   0970                  	DW	UP161-RBANF+2
  0DBE'   0988                  	DW	M1601-RBANF+2
  0DC0'   098B                  	DW	M1602-RBANF+2
  0DC2'   098E                  	DW	M1603-RBANF+2
  0DC4'   0998                  	DW	M1604-RBANF+2
  0DC6'   099D                  	DW	M1605-RBANF+2
  0DC8'   09A0                  	DW	M1606-RBANF+2
  0DCA'   09AD                  	DW	M1311-RBANF+2
  0DCC'   09B6                  	DW	M1312-RBANF+2
  0DCE'   09BF                  	DW	M1313-RBANF+3
  0DD0'   09CF                  	DW	M1314-RBANF+3
  0DD2'   09F4                  	DW	M1315-RBANF+3
  0DD4'   09FD                  	DW	M1316-RBANF+2
                                
  0DD6'   0A04                  	DW	M201-RBANF+1
  0DD8'   0A0C                  	DW	M2011-RBANF+2
  0DDA'   0A11                  	DW	M202-RBANF+2
  0DDC'   0A14                  	DW	M203-RBANF+2
  0DDE'   0A17                  	DW	CON-RBANF+2
  0DE0'   0A1E                  	DW	M204-RBANF+2
  0DE2'   0A32                  	DW	M205-RBANF+2
  0DE4'   0A37                  	DW	CON2-RBANF+2
  0DE6'   0A48                  	DW	M207-RBANF+2
  0DE8'   0A4E                  	DW	M208-RBANF+2
  0DEA'   0A54                  	DW	M209-RBANF+2
  0DEC'   0A57                  	DW	CIN-RBANF+2
  0DEE'   0A70                  	DW	CHOM0-RBANF+2
  0DF0'   0A78                  	DW	CADR-RBANF+2
  0DF2'   0A7E                  	DW	CADR0-RBANF+2
  0DF4'   0A86                  	DW	M213-RBANF+3
  0DF6'   0A89                  	DW	M214-RBANF+2
  0DF8'   0A91                  	DW	M214A-RBANF+2
  0DFA'   0A94                  	DW	CPOS-RBANF+2
  0DFC'   0A9B                  	DW	M215-RBANF+2
  0DFE'   0ABB                  	DW	M218-RBANF+2
  0E00'   0ABF                  	DW	M219-RBANF+2
  0E02'   0AC9                  	DW	M220-RBANF+2
  0E04'   0ACC                  	DW	POS4-RBANF+2
  0E06'   0AD1                  	DW	LOE-RBANF+2
  0E08'   0AE4                  	DW	M221-RBANF+2
  0E0A'   0AEC                  	DW	M221A-RBANF+2
  0E0C'   0AF2                  	DW	M224-RBANF+2
  0E0E'   0AF5                  	DW	M225-RBANF+2
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	1-30


  0E10'   0B15                  	DW	M226-RBANF+2
  0E12'   0B19                  	DW	M227-RBANF+2
  0E14'   0B1C                  	DW	M227A-RBANF+2
  0E16'   0B1F                  	DW	M227B-RBANF+2
  0E18'   0B2C                  	DW	M229-RBANF+2
  0E1A'   0B35                  	DW	M230-RBANF+2
  0E1C'   0B44                  	DW	M231-RBANF+2
  0E1E'   0B4A                  	DW	M232-RBANF+2
  0E20'   0B50                  	DW	M2321-RBANF+2
  0E22'   0B58                  	DW	M242-RBANF+2
  0E24'   0B5D                  	DW	M243-RBANF+2
  0E26'   0B62                  	DW	M2431-RBANF+2
  0E28'   0B6A                  	DW	M244-RBANF+2
  0E2A'   0B6F                  	DW	M245-RBANF+2
  0E2C'   0B74                  	DW	M2451-RBANF+2
  0E2E'   0B7B                  	DW	ANW-RBANF+2
  0E30'   0B84                  	DW	M246-RBANF+2
  0E32'   0B87                  	DW	M247-RBANF+2
  0E34'   0B8A                  	DW	M248-RBANF+2
  0E36'   0B93                  	DW	M249-RBANF+2
  0E38'   0B96                  	DW	M250-RBANF+2
  0E3A'   0B99                  	DW	M251-RBANF+2
  0E3C'   0BA2                  	DW	M2511-RBANF+2
  0E3E'   0BA5                  	DW	M2512-RBANF+2
  0E40'   0BA8                  	DW	M254-RBANF+2
  0E42'   0BAB                  	DW	M255-RBANF+2
  0E44'   0000                  	DW	0
  0E46'   0000                  	DW	0
  0E48'   0000                  	DW	0
  0E4A'   0000                  	DW	0
  0E4C'   0000                  	DW	0
  0E4E'                         RBEND	EQU	$
                                	END
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	S


Macros:

Symbols:
0B79'	ANW             00A0 	ATAST           0038'	BLAE            
3000 	BWSA            0B67'	BWSAB           0B55'	BWSZU           
0A76'	CADR            0A7C'	CADR0           000C'	CADRF           
00B5'	CHK             0A6A'	CHOM            0A6E'	CHOM0           
000F'	CHOMF           0A55'	CIN             0006'	CINF            
0A15'	CON             0A35'	CON2            0A4B'	CON3            
0A4F'	CON9            0003'	CONF            0A92'	CPOS            
0A5B'	CSTS            0009'	CSTSF           0B3D'	DEG             
0BB0'	GEN1            0BC0'	GEN2            01AD'	J1              
0853'	J10             02ED'	J2              05E8'	J3              
0769'	J5              0883'	J6              0AB2'	LCP1            
0AA6'	LCPOS           04A1'	LDAB            0ACF'	LOE             
00BC'	M1001           00CD'	M1002           00DB'	M1003           
00EC'	M1004           0101'	M1005           011D'	M1006           
0123'	M1007           012B'	M1008           0137'	M1009           
013B'	M1010           013E'	M1011           0154'	M1012           
018E'	M1013           019D'	M1014           01A4'	M1015           
01A8'	M1016           01B0'	M1017           025A'	M1018           
0279'	M1019           028A'	M1020           028D'	M1021           
029E'	M1022           02A2'	M1023           02B8'	M1024           
02BB'	M1025           02BE'	M1026           02C3'	M1027           
02C6'	M1028           02DD'	M1029           02E0'	M1030           
02E3'	M1031           02E7'	M1032           02EA'	M1033           
0305'	M1034           0308'	M1035           030C'	M1036           
0322'	M1037           0325'	M1038           032D'	M1039           
0331'	M1040           0347'	M1041           034B'	M1042           
034E'	M1043           035A'	M1044           035D'	M1045           
036C'	M1046           038A'	M1047           038D'	M1048           
03A4'	M1049           03A7'	M1050           03B8'	M1051           
03D0'	M1052           03D4'	M1053           03D7'	M1054           
03F3'	M1055           03F6'	M1056           03FB'	M1057           
0415'	M1058           0418'	M1059           03D3'	M1060           
043E'	M1061           0441'	M1062           0444'	M1063           
0447'	M1067           044A'	M1068           044D'	M1069           
0450'	M1070           0453'	M1071           0456'	M1072           
0459'	M1073           045C'	M1074           045F'	M1075           
0462'	M1076           0465'	M1077           0468'	M1078           
046B'	M1082           046E'	M1083           0471'	M1084           
0474'	M1085           0477'	M1086           047A'	M1087           
047D'	M1088           0480'	M1089           0483'	M1090           
0491'	M1091           049C'	M1093           04A3'	M1094           
04A8'	M1096           04B1'	M1097           04B7'	M1099           
04BD'	M1100           04C0'	M1101           04C4'	M1102           
04C8'	M1103           04CC'	M1104           04CF'	M1105           
04D7'	M1106           04D9'	M1107           04E0'	M1108           
04EF'	M1109           04F5'	M1110           051C'	M1111           
0517'	M1112           0528'	M1115           052E'	M1116           
0532'	M1117           0535'	M1118           053B'	M1119           
05B1'	M1120           05BB'	M1121           05C4'	M1122           
05CA'	M1123           05CD'	M1124           05D0'	M1125           
05D3'	M1126           05D7'	M1127           05E2'	M1128           
05E5'	M1129           05EB'	M1130           05EE'	M1132           
05F7'	M1133           05FA'	M1134           05FD'	M1135           
0602'	M1136           0605'	M1137           060D'	M1138           
0610'	M1139           0619'	M1141           0624'	M1144           
062D'	M1145           0630'	M1146           0633'	M1147           
0637'	M1151           063D'	M1152           0640'	M1153           
0655'	M1155           0658'	M1156           0665'	M1157           
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	S-1


066A'	M1158           0679'	M1161           0682'	M1162           
0685'	M1163           0688'	M1164           068B'	M1167           
0692'	M1168           0695'	M1169           06A8'	M1171           
06AB'	M1172           06B6'	M1173           06BB'	M1174           
06CA'	M1181           06D3'	M1182           06D6'	M1183           
06D9'	M1184           06DE'	M1185           06E2'	M1186           
06E5'	M1187           06E8'	M1192           06ED'	M1193           
06F2'	M1194           06F5'	M1195           06F8'	M1196           
06FD'	M1205           0701'	M1206           0704'	M1207           
070C'	M1210           0710'	M1211           0716'	M1212           
071F'	M1213           072E'	M1214           0735'	M1215           
073C'	M1216           073F'	M1217           0744'	M1218           
074A'	M1219           0750'	M1220           0754'	M1221           
0759'	M1222           0762'	M1223           0772'	M1224           
0775'	M1225           0778'	M1226           077D'	M1227           
0783'	M1228           0786'	M1229           0790'	M1230           
0799'	M1232           079C'	M1233           07AB'	M1234           
07B4'	M1236           07B7'	M1237           07BA'	M1238           
07BD'	M1239           07C4'	M1240           07C9'	M1241           
07D8'	M1245           07DD'	M1246           07E2'	M1247           
07E5'	M1248           07E8'	M1249           07EB'	M1250           
07F6'	M1251           07F9'	M1252           07FC'	M1253           
07FF'	M1254           0802'	M1255           0805'	M1256           
0808'	M1257           080C'	M1258           0813'	M1259           
0835'	M1260           0839'	M1261           083E'	M1262           
0844'	M1263           0869'	M1264           087D'	M1265           
0886'	M1266           0889'	M1267           088C'	M1269           
088F'	M1270           0892'	M1271           0895'	M1272           
0898'	M1273           089B'	M1274           089E'	M1275           
08A5'	M1276           08AC'	M1277           08B0'	M1278           
08B6'	M1279           08BA'	M1280           08C4'	M1281           
08CC'	M1282           08D0'	M1283           08DD'	M1284           
08E2'	M1285           08E5'	M1286           08F5'	M1287           
0904'	M1288           0909'	M1289           090C'	M1290           
090F'	M1291           091D'	M1305           094B'	M1306           
0962'	M1307           0965'	M1308           0968'	M1309           
096B'	M1310           09AB'	M1311           09B4'	M1312           
09BC'	M1313           09CC'	M1314           09F1'	M1315           
09FB'	M1316           0986'	M1601           0989'	M1602           
098C'	M1603           0996'	M1604           099B'	M1605           
099E'	M1606           0A03'	M201            0A0A'	M2011           
0A0F'	M202            0A12'	M203            0A1C'	M204            
0A30'	M205            0A38'	M206            0A46'	M207            
0A4C'	M208            0A52'	M209            0A83'	M213            
0A87'	M214            0A8F'	M214A           0A99'	M215            
0A9E'	M216            0AAE'	M217            0AB9'	M218            
0ABD'	M219            0AC7'	M220            0AE2'	M221            
0AEA'	M221A           0AF0'	M224            0AF3'	M225            
0B13'	M226            0B17'	M227            0B1A'	M227A           
0B1D'	M227B           0B2A'	M229            0B2F'	M229A           
0B33'	M230            0B36'	M2301           0B42'	M231            
0B48'	M232            0B4E'	M2321           0B56'	M242            
0B5B'	M243            0B60'	M2431           0B68'	M244            
0B6D'	M245            0B72'	M2451           0B82'	M246            
0B85'	M247            0B88'	M248            0B91'	M249            
0B94'	M250            0B97'	M251            0BA0'	M2511           
0BA3'	M2512           0BA6'	M254            0BA9'	M255            
0042'	MER             0B25'	MV15            027C'	MV2             
029D'	MV3             0290'	MV4             08F1'	MV5             
0900'	MV6             0A9C'	PNSP            0AA1'	PNSP1           
0ACD'	POS1            0ACA'	POS4            0018'	RAANF           
001A'	RAEND           0014'	RANF            0000'	RBANF           
'RB30	RAM-Test'	MACRO-80 3.44	09-Dec-81	PAGE	S-2


0E4E'	RBEND           0016'	REND            0487'	S               
00C8'	SOUT            00C0 	SPBA            003B'	SPOS            
05DF'	ST1             05DC'	START           00B0'	SV1             
00B1'	SV2             00B2'	SV3             00B3'	SV4             
01C6'	T1              0237'	T10             0247'	T11             
01D7'	T2              054C'	T20             0568'	T21A            
056D'	T22             057B'	T23             0594'	T24             
0B3A'	T27             01E7'	T3              01F7'	T4              
0207'	T7              0217'	T8              0227'	T9              
0032'	TANF            0034'	TEND            0036'	TLAE            
003C'	UM              003E'	UM1             0040'	UM2             
00B8'	UP1             04EB'	UP10            05AF'	UP11            
05C0'	UP12            0709'	UP15            08A1'	UP16            
096E'	UP161           09A3'	UP17            0AED'	UP18            
00D9'	UP2             0128'	UP3             0184'	UP4             
0189'	UP5             0192'	UP6             01A2'	UP7             
0257'	UP8             048E'	UP9             0912'	VER             
0AC3'	ZLPOS           003A'	ZPOS            001D'	ZWI             



No Fatal error(s)


    
00B8'	UP1             04EB'	UP10            05AF'	UP11            
05C0'	UP12  