	title	12.August 85     DEG2000-BIOS    Version 4.3
;
false	equ	0
true	equ	not false
;
tap	equ	true		; true   ...     T A P 2 / T A P 3
				; false  ...     mini T A P
;
 if not tap
tap1	equ	false		; false  ...     miniTAP mit TRAM
 endif				; true   ...     miniTAP mit OPS64
;
talt	equ	false		; false  ...	Tastatur 763x
				; true   ...	Tastatur 760x
dr54	equ	false		; system ohne drucker 1154
;
;
biosan	equ	0c600h
biosle	equ	02200h		; 8,5 k
gosys0	equ	08000h
;
bsanf	equ	03000h		; bildschirmadresse
maxz	equ	24		; zeilenanzahl
maxs	equ	80		; spaltenanzahl
;
; tastaturroutine
;
ptast	equ	0a0h		; basisadresse der ansteuerung
 if tap
ttinit	equ	06ef0h		; basisadresse der grundroutinen
 else
ttinit	equ	0db00h
 endif
;
; druckerroutine
;
 if tap
dinit	equ	07c06h		; initialisierungsroutine
dout	equ	07c09h		; zeichenausgaberoutine
eadr	equ	00f70h		; e/a-tabelle
 else
dinit	equ	0dc06h
dout	equ	0dc74h
eadr	equ	00d00h
 endif
;
; lochbandleser
;
 if tap
lbl	equ	07000h		; zeicheneingaberoutine
ealbl	equ	00fa0h		; e/a-tabelle
 endif
;
; lochbandstanzer
;
 if tap
lbs	equ	07003h		; zeichenausgaberoutine
ealbs	equ	00f80h		; e/a-tabelle
 endif
;
; robotron kassettenroutine
;
kmbvers	equ	12		; kmb bamos version 1.2
anzakb	equ	1		; ein doppellaufwerk k 5221
pkmb	equ	30h		; basisadresse akb
 if anzakb gt 1
pkmb2	equ	38h
 endif
 if anzakb gt 2
pkmb3	equ	38h
 endif
 if tap
kmbrob	equ	04000h
 else
kmbrob	equ	0dd39h		; eintrittsadresse in bamos kmb
 endif
kmbruc	equ	kmbrob+6adh	; eintrittsadresse bereitroutine
kmbini	equ	kmbrob+965h	; eintrittsadresse initialisierung
;
; puffer fuer kassettenpufferung
;
dir1	equ	biosan+biosle+800h  ; puffer fuer directory
dir2	equ	dir1+800h
 if tap
kasbu1	equ	02800h		; puffer fuer hostblock
 else
kasbu1	equ	00e00h
 endif
kasbu2	equ	kasbu1+100h
 if anzakb gt 1
kasbu3	equ	kasbu2+100h
kasbu4	equ	kasbu3+100h
 endif
 if anzakb gt 2
kasbu5	equ	kasbu4+100h
kasbu6	equ	kasbu5+100h
 endif
;
; speicherverteilung
;
;  f800  ;  biosan+3200   dir2              2,0 k
;  f000  ;  biosan+2a00   dir1              2,0 k
;  e800  ;  biosan+2200   ccp kopie         2,0 k
;  c600  ;  biosan        bios              8,5 k
;  b800  ;  biosan-0e00   bdos              3,5 k  =  18k
;  b000  ;  biosan-1600   ccp               2,0 k
;        ;                tpa_disk
;   100  ;                tpa
;
mbootm	macro
	defb	1ah,'51k   S Y S 4 . 3   release 2'
 if tap
	defb	'   T A P 2 / T A P 3'
 else
  if tap1
	defb	'   miniTAP/OPS64'
  else
	defb	'   miniTAP/TRAM'
  endif
 endif
	defb	cr,lf,'      D E G  2000   vom 12.August 85 ',lf,lf
	endm
;
;
pipeq	equ	true		; generierung der datei "A:PIP.SUB"
;
 if pipeq
dirg	macro
	defb	'$1:pip p:=$1:xsub.com',cr,lf
	defb	'go p:s.com=$1:submit.com',cr,lf
	defb	'go p:=$1:kini.com',cr,lf
	defb	'go p:=$1:power.com',cr,lf
	defb	'go o:=$1:m80.com',cr,lf
	defb	'go o:=$1:l80.com',cr,lf
	defb	'era pip.sub',cr,lf
	defb	01ah
	endm
 endif
;
;
mindk	equ	false
stadk	equ	false
zst	equ	true
 if tap
tramdk	equ	true
opsdk	equ	true
 else
tramdk	equ	false
opsdk	equ	false
 endif
;
eq.sys	equ	0cdh		; ruecksprung in DEG2000 Version 1.2
eq.bsd	equ	0ceh		; hardcopy
eq.cap	equ	0ffh		; PTAS / STAS
eq.hex	equ	0feh		; hexadezimale eingabe eines zeichens
eq.lr0	equ	0fdh		; druckerreset
eq.lw	equ	0fch		; A := neue laufwerksnummer
eq.gra	equ	080h		; groesse des geraetes A festlegen
eq.le1	equ	081h		; laden/entladen kassettenlw 1
eq.le2	equ	082h		; laden/entladen kassettenlw 2
 if anzakb gt 1
eq.le3	equ	083h		; laden/entladen kassettenlw 3
eq.le4	equ	084h		; laden/entladen kassettenlw 4
 endif
 if anzakb gt 2
eq.le5	equ	085h		; laden/entladen kassettenlw 5
eq.lr6	equ	086h		; laden/entladen kassettenlw 6
 endif
 if tap
eq.sio	equ	088h		; initialisieren ATS-SIO-Kanal A bzw. B
 else
eq.sio	equ	0
 endif
eq.ini	equ	089h		; initialisieren laufwerk O , P
eq.bcu	equ	08ah		; monitor BCU
eq.deg	equ	08bh		; monitor DEG-SYS4
