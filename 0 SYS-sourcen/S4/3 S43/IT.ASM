; interrupt fuer DEG2000-BIOS
; ---------------------------
;
	defs	0b8h
;io:	defw	0,0		; interruptvektoren system ctc
;	defw	kmbrob-260h+0b11h
;iocia:	defw	icich		; zeicheninterrupt von tastatur
;	defw	kmbrob-260h+06cfh
;	defw	kmbrob-260h+0773h
;	defw	kmbrob-260h+07c2h
;	defw	kmbrob-260h+08b8h
;	defw	kmbrob-260h+08d3h
;	defw	kmbrob-260h+08eeh
;
;ioria:	defw	irich		; zeicheninterrupt vom leser
;iorib:	defw	irist		; statusinterrupt  vom leser
;iopua:	defw	ipuch		; zeicheninterrupt vom stanzer
;iopub:	defw	ipust		; statusinterrupt  vom stanzer
;ioloa:	defw	0		; zeicheninterrupt vom drucker
;iolob:	defw	0		; statusinterrupt  vom drucker
;
