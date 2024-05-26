; speicherumschaltungen fuer DEG2000-BIOS     12.08.85
; ----------------------------------------------------
 if tap
ures12::
	push	af
	out	(0c4h),a	; RESET-Sperre aus
	ld	a,10100111b
	out	(0c0h),a
	ld	a,10000100b
	out	(0c1h),a
	out	(0c3h),a	; RESET-Sperre ein
	pop	af
	ret
uset12::
	push	af
	out	(0c4h),a	; RESET-Sperre aus
	xor	a
	out	(0c1h),a
	out	(0c0h),a
	out	(0c3h),a	; RESET-Sperre ein
	pop	af
	ret
 else
  if tap1
  else
ures12::
	push	af
	push	bc
	push	de
	ld	bc,28h
	ld	e,4
	call	up23
ures13:
	pop	de
	pop	bc
	pop	af
	ret
uset12::
	push	af
	push	bc
	push	de
	ld	bc,28h
	ld	e,4
	call	up33
	jr	ures13

up23:	xor	a
	call	up39
	jr	nz,up23
	ret
up33:	ld	a,00ch
	call	up39
	jr	nz,up33
	ret

up39:	out	(c),a
	ld	a,b
	add	a,10h
	ld	b,a
	dec	e
	ret
  endif
 endif
;
; umschaltmacros
; --------------
;
set12	macro
	ld	(stkret),sp
	ld	sp,stk12
	call	uset12
	endm
;
res12	macro
	call	ures12
	ld	sp,(stkret)
	endm
;
;
;
 if tap
setkmb	macro
	set12
	push	af
	xor	a
	ld	i,a
	pop	af
	endm
;
reskmb	macro
	push	af
	ld	a,high biosan
	ld	i,a
	pop	af
	res12
	endm
 else
setkmb	macro
	set12
	endm
;
reskmb	macro
	res12
	endm
 endif
;
;
;
gosys	macro
	set12
	jp	0
	endm
 if tap
gosys1	macro
	gosys
	endm
 else
  if tap1
gosys1	macro
	endm
  else
gosys1	macro
	out	(0c4h),a
	xor	a
	out	(0c1h),a
	out	(0c0h),a
	out	(0c3h),a
	jp	0
	endm
  endif
 endif
;
;
;
ccpcop	macro
	ld	hl,biosan+biosle
	ld	de,biosan-1600h
	ld	bc,800h
	ldir
	ld	hl,serial
	ld	bc,6
	ldir
	jr	ccpcp1
serial::defb	0,16h,0,0,0,0a5h
ccpcp1::
	endm
;
