{$I DEFINE.INC}

unit ED;

interface

uses Varia,IOsim1;

function op_ed_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xED of a multi byte opcode.
}
function trap_ed:Integer; far;
begin
      cpu_error := OPTRAP2;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_ed:=0;
{$ENDIF}
end;

function op_im0:Integer; far;                                         { IM 0 }
begin
      int_mode := 0;
{$IFDEF WANT_TIM}
      op_im0:=8;
{$ENDIF}
end;

function op_im1:Integer; far;                                         { IM 1 }
begin
      int_mode := 1;
{$IFDEF WANT_TIM}
      op_im1:=8;
{$ENDIF}
end;

function op_im2:Integer; far;                                         { IM 2 }
begin
      int_mode := 2;
{$IFDEF WANT_TIM}
      op_im2:=8;
{$ENDIF}
end;

function op_reti:Integer; far;                                        { RETI }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      PC := i;
{$IFDEF WANT_TIM}
      op_reti:=14;
{$ENDIF}
end;

function op_retn:Integer; far;                                        { RETN }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      PC := i;
      if (IFF AND 2)=2 then IFF := IFF OR 1 else IFF := IFF AND NOT 1;
{$IFDEF WANT_TIM}
      op_retn:=14;
{$ENDIF}
end;

function op_neg:Integer; far;                                          { NEG }
begin
      if (A=0)                 then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (A = $80)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (0 - (A AND $0F) < 0) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      A := 0 - A;
      F := F OR N_FLAG;
      if (A=0)                 then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80       then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_neg:=8;
{$ENDIF}
end;

function op_inaic:Integer; far;                                   { IN A,(C) }
begin
      A := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_inaic:=12;
{$ENDIF}
end;

function op_inbic:Integer; far;                                   { IN B,(C) }
begin
      B := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_inbic:=12;
{$ENDIF}
end;

function op_incic:Integer; far;                                   { IN C,(C) }
begin
      C := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_incic:=12;
{$ENDIF}
end;

function op_indic:Integer; far;                                   { IN D,(C) }
begin
      D := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_indic:=12;
{$ENDIF}
end;

function op_ineic:Integer; far;                                   { IN E,(C) }
begin
      E := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_ineic:=12;
{$ENDIF}
end;

function op_inhic:Integer; far;                                   { IN H,(C) }
begin
      H := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_inhic:=12;
{$ENDIF}
end;

function op_inlic:Integer; far;                                   { IN L,(C) }
begin
      L := io_in(C);
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_inlic:=12;
{$ENDIF}
end;

function op_outca:Integer; far;                                  { OUT (C),A }
begin
      io_out(C, A);
{$IFDEF WANT_TIM}
      op_outca:=12;
{$ENDIF}
end;

function op_outcb:Integer; far;                                  { OUT (C),B }
begin
      io_out(C, B);
{$IFDEF WANT_TIM}
      op_outcb:=12;
{$ENDIF}
end;

function op_outcc:Integer; far;                                  { OUT (C),C }
begin
      io_out(C, C);
{$IFDEF WANT_TIM}
      op_outcc:=12;
{$ENDIF}
end;

function op_outcd:Integer; far;                                  { OUT (C),D }
begin
      io_out(C, D);
{$IFDEF WANT_TIM}
      op_outcd:=12;
{$ENDIF}
end;

function op_outce:Integer; far;                                  { OUT (C),E }
begin
      io_out(C, E);
{$IFDEF WANT_TIM}
      op_outce:=12;
{$ENDIF}
end;

function op_outch:Integer; far;                                  { OUT (C),H }
begin
      io_out(C, H);
{$IFDEF WANT_TIM}
      op_outch:=12;
{$ENDIF}
end;

function op_outcl:Integer; far;                                  { OUT (C),L }
begin
      io_out(C, L);
{$IFDEF WANT_TIM}
      op_outcl:=12;
{$ENDIF}
end;

function op_ini:Integer; far;                                          { INI }
begin
      Speicher_schreiben_Byte((H shl 8) + L,io_in(C));
      L := L + 1;
      if NOT L=0 then H := H + 1;
      B := B - 1;
      F := F OR N_FLAG;
      if (B=0) then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_ini:=16;
{$ENDIF}
end;

function op_inir:Integer; far;                                        { INIR }
  var d : Word;
{$IFDEF WANT_TIM}
      t	: LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      d := (H shl 8) + L;
      while (B>0) do
            begin
                  Speicher_schreiben_Byte(d, io_in(C)); d := d + 1;
                  B := B - 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
            end;
      H := d shr 8;
      L := d AND $00FF;
      F := F OR N_FLAG OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_inir:=t + 16;
{$ENDIF}
end;

function op_ind:Integer; far;                                          { IND }
begin
      Speicher_schreiben_Byte((H shl 8) + L, io_in(C));
      L := L - 1;
      if (L = $FF) then H := H - 1;
      B := B - 1;
      F := F OR N_FLAG;
      if (B=0) then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_ind:=16;
{$ENDIF}
end;

function op_indr:Integer; far;                                        { INDR }
  var d : Word;
{$IFDEF WANT_TIM}
      t	: LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      d := (H shl 8) + L;
      while (B>0) do
            begin
                  Speicher_schreiben_Byte(d, io_in(C)); d := d - 1;
                  B := B - 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
            end;
      H := d shr 8;
      L := d AND $00FF;
      F := F OR N_FLAG OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_indr:=t + 16;
{$ENDIF}
end;

function op_outi:Integer; far;                                        { OUTI }
begin
      io_out(C, Speicher_lesen_Byte((H shl 8) + L));
      L := L + 1;
      if (L=0) then H := H + 1;
      B := B - 1;
      F := F OR N_FLAG;
      if (B=0) then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_outi:=16;
{$ENDIF}
end;

function op_otir:Integer; far;                                        { OTIR }
  var d : Word;
{$IFDEF WANT_TIM}
      t	: LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      d := (H shl 8) + L;
      while (B>0) do
            begin
                  io_out(C, Speicher_lesen_Byte(d)); d := d + 1;
                  B := B - 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
            end;
      H := d shr 8;
      L := d AND $00FF;
      F := F OR N_FLAG OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_otir:=t + 16;
{$ENDIF}
end;

function op_outd:Integer; far;                                        { OUTD }
begin
      io_out(C, Speicher_lesen_Byte((H shl 8) + L));
      L := L - 1;
      if (L = $FF) then H := H - 1;
      B := B - 1;
      F := F OR N_FLAG;
      if (B=0) then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_outd:=16;
{$ENDIF}
end;

function op_otdr:Integer; far;                                        { OTDR }
  var d : Word;
{$IFDEF WANT_TIM}
      t	: LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      d := (H shl 8) + L;
      while (B>0) do
            begin
                  io_out(C, Speicher_lesen_Byte(d)); d := d - 1;
                  B := B - 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
            end;
      H := d shr 8;
      L := d AND $00FF;
      F := F OR N_FLAG OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_otdr:=t + 16;
{$ENDIF}
end;

function op_ldai:Integer; far;                                      { LD A,I }
begin
      A := III;
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (IFF AND 2)=2   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_ldai:=9;
{$ENDIF}
end;

function op_ldar:Integer; far;                                      { LD A,R }
begin
      A := R;
      F := F AND NOT (N_FLAG OR H_FLAG);
      if (IFF AND 2)=2   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_ldar:=9;
{$ENDIF}
end;

function op_ldia:Integer; far;                                      { LD I,A }
begin
      III := A;
{$IFDEF WANT_TIM}
      op_ldia:=9;
{$ENDIF}
end;

function op_ldra:Integer; far;                                      { LD R,A }
begin
      R := A;
{$IFDEF WANT_TIM}
      op_ldra:=9;
{$ENDIF}
end;

function op_ldbcinn:Integer; far;                               { LD BC,(nn) }
  var p : Word;
begin
      p :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      p := p + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      C := Speicher_lesen_Byte(p); p := p + 1;
      B := Speicher_lesen_Byte(p);
{$IFDEF WANT_TIM}
      op_ldbcinn:=20;
{$ENDIF}
end;

function op_lddeinn:Integer; far;                               { LD DE,(nn) }
  var p : Word;
begin
      p :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      p := p + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      E := Speicher_lesen_Byte(p); p := p + 1;
      D := Speicher_lesen_Byte(p);
{$IFDEF WANT_TIM}
      op_lddeinn:=20;
{$ENDIF}
end;

function op_ldspinn:Integer; far;                               { LD SP,(nn) }
  var p : Word;
begin
      p     :=         Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      p     := p     + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      STACK :=         Speicher_lesen_Byte(p)      ; p := p + 1;
      STACK := STACK + Speicher_lesen_Byte(p) shl 8;
{$IFDEF WANT_TIM}
      op_ldspinn:=20;
{$ENDIF}
end;

function op_ldinbc:Integer; far;                                { LD (nn),BC }
  var p : Word;
begin
      p :=     Speicher_lesen_Byte(PC); PC := PC + 1;
      p := p + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      Speicher_schreiben_Byte(p,C); p := p + 1;
      Speicher_schreiben_Byte(p,B);
{$IFDEF WANT_TIM}
      op_ldinbc:=20;
{$ENDIF}
end;

function op_ldinde:Integer; far;                                { LD (nn),DE }
  var p : Word;
begin
      p :=     Speicher_lesen_Byte(PC); PC := PC + 1;
      p := p + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      Speicher_schreiben_Byte(p,E); p := p + 1;
      Speicher_schreiben_Byte(p,D);
{$IFDEF WANT_TIM}
      op_ldinde:=20;
{$ENDIF}
end;


function op_ldinsp:Integer; far;                                { LD (nn),SP }
  var p : Word;
      i : Integer;
begin
      p :=     Speicher_lesen_Byte(PC); PC := PC + 1;
      p := p + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
      i := STACK;
      Speicher_schreiben_Byte(p,i AND $00FF); p := p + 1;
      Speicher_schreiben_Byte(p,i shr     8);
{$IFDEF WANT_TIM}
      op_ldinsp:=20;
{$ENDIF}
end;

function op_adchb:Integer; far;                                  { ADC HL,BC }
  var carry : Integer;
      hl,bc : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      bc := (B shl 8) +	C;
      i  := hl + bc + carry;
      if ((hl < $8000) AND (i > $7FFF)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i > $FFFF)                    then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i=0)                          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F AND NOT N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_adchb:=15;
{$ENDIF}
end;

function op_adchd:Integer; far;                                  { ADC HL,DE }
  var carry : Integer;
      hl,de : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      de := (D shl 8) +	E;
      i  := hl + de + carry;
      if ((hl < $8000) AND (i > $7FFF)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i > $FFFF)                    then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i=0)                          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F AND NOT N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_adchd:=15;
{$ENDIF}
end;

function op_adchh:Integer; far;                                  { ADC HL,HL }
  var carry : Integer;
      hl    : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      i  := (hl shl 1) + carry;
      if ((hl < $8000) AND (i > $7FFF)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i > $FFFF)                    then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i=0)                          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F AND NOT N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_adchh:=15;
{$ENDIF}
end;

function op_adchs:Integer; far;                                  { ADC HL,SP }
  var carry : Integer;
      hl,sp : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      sp := STACK;
      i  := hl + sp + carry;
      if ((hl < $8000) AND (i > $7FFF)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i > $FFFF)                    then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i=0)                          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F AND NOT N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_adchs:=15;
{$ENDIF}
end;

function op_sbchb:Integer; far;                                  { SBC HL,BC }
  var carry : Integer;
      hl,bc : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      bc := (B shl 8) +	C;
      i  := hl - bc - carry;
      if ((hl > $7FFF) AND (i < $8000)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i < 0)                        then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i<>0)                         then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F OR N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_sbchb:=15;
{$ENDIF}
end;

function op_sbchd:Integer; far;                                  { SBC HL,DE }
  var carry : Integer;
      hl,de : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      de := (D shl 8) +	E;
      i  := hl - de - carry;
      if ((hl > $7FFF) AND (i < $8000)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i < 0)                        then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i<>0)                         then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F OR N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_sbchd:=15;
{$ENDIF}
end;

function op_sbchh:Integer; far;                                  { SBC HL,HL }
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    F := F OR       S_FLAG OR P_FLAG OR N_FLAG OR C_FLAG;
                    F := F AND NOT  Z_FLAG;
                    H := $FF;
                    L := $FF;
              end
         else begin
                    F := F OR       Z_FLAG OR N_FLAG;
                    F := F AND NOT (S_FLAG OR P_FLAG OR C_FLAG);
                    H := 0;
                    L := 0;
              end;
{$IFDEF WANT_TIM}
      op_sbchh:=15;
{$ENDIF}
end;

function op_sbchs:Integer; far;                                  { SBC HL,SP }
  var carry : Integer;
      hl,sp : Word;
      i     : LongInt;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      hl := (H shl 8) +	L;
      sp := STACK;
      i  := hl - sp - carry;
      if ((hl > $7FFF) AND (i < $8000)) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i < 0)                        then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      if (i=0)                          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      H  := i shr 8;
      L  := i AND $00FF;
      F  := F OR N_FLAG;
      if (H AND $80)=$80 then F := F OR S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_sbchs:=15;
{$ENDIF}
end;

function op_ldi:Integer; far;                                          { LDI }
begin
      Speicher_schreiben_Byte((D shl 8) + E,Speicher_lesen_Byte((H shl 8) + L));
      E := E + 1;
      if (E=0) then D := D + 1;
      L := L + 1;
      if (L=0) then H := H + 1;
      C := C - 1;
      if (C = $FF)      then B := B - 1;
      if (B=0) OR (C=0) then F := F OR P_FLAG else F := F AND NOT P_FLAG;
      F := F AND NOT (N_FLAG OR H_FLAG);
{$IFDEF WANT_TIM}
      op_ldi:=16;
{$ENDIF}
end;

function op_ldir:Integer; far;                                        { LDIR }
  var i   : Word;
      s,p : Word;
{$IFDEF WANT_TIM}
      t   : LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      i := (B shl 8) + C;
      p := (D shl 8) + E;
      s := (H shl 8) + L;
      while (i>0) do
            begin
                  Speicher_schreiben_Byte(p, Speicher_lesen_Byte(s));
                  p := p + 1; s := s + 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
                  i := i - 1;
            end;
      B := 0;
      C := 0;
      D := p shr 8;
      E := p AND $00FF;
      H := s shr 8;
      L := s AND $00FF;
      F := F AND NOT (N_FLAG OR P_FLAG OR H_FLAG);
{$IFDEF WANT_TIM}
      op_ldir:=t + 16;
{$ENDIF}
end;

function op_ldd:Integer; far;                                          { LDD }
begin
      Speicher_schreiben_Byte((D shl 8) + E, Speicher_lesen_Byte((H shl 8) + L));
      E := E - 1;
      if (E = $FF) then D := D - 1;
      L := L - 1;
      if (L = $FF) then H := H - 1;
      C := C - 1;
      if (C = $FF) then B := B - 1;
      if (B=0) OR (C=0)	then F := F OR P_FLAG else F := F AND NOT P_FLAG;
      F := F AND NOT (N_FLAG OR H_FLAG);
{$IFDEF WANT_TIM}
      op_ldd:=16;
{$ENDIF}
end;

function op_lddr:Integer; far;                                        { LDDR }
  var i   : Word;
      s,p : Word;
{$IFDEF WANT_TIM}
      t   : LongInt;
{$ENDIF}
begin
{$IFDEF WANT_TIM}
      t	:= -21;
{$ENDIF}
      i := (B shl 8) + C;
      p := (D shl 8) + E;
      s := (H shl 8) + L;
      while (i>0) do
            begin
                  Speicher_schreiben_Byte(d, Speicher_lesen_Byte(s));
                  p := p - 1; s := s - 1;
{$IFDEF WANT_TIM}
                  t := t + 21;
{$ENDIF}
                  i := i - 1;
            end;
      B := 0;
      C := 0;
      D := p shr 8;
      E := p AND $00FF;
      H := s shr 8;
      L := s AND $00FF;
      F := F AND NOT (N_FLAG OR P_FLAG OR H_FLAG);
{$IFDEF WANT_TIM}
      op_lddr:=t + 16;
{$ENDIF}
end;

function op_cpi:Integer; far;                                          { CPI }
  var i : Byte;
begin                                              { H flag isn't set here ! }
      i := A - Speicher_lesen_Byte((H shl 8) + L);
      L := L + 1;
      if (L =   0) then H := H + 1;
      C := C - 1;
      if (C = $FF) then B := B - 1;
      F := F OR N_FLAG;
      if (B=0) OR (C=0)	 then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (i AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_cpi:=16;
{$ENDIF}
end;

function op_cpir:Integer; far;                                        { CPIR }
  var i : Word;
      s : Word;
      p : Byte;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin                                              { H flag isn't set here ! }
{$IFDEF WANT_TIM}
      t := -21;
{$ENDIF}
      i := (B shl 8) + C;
      s := (H shl 8) + L;
      repeat
             p := A - Speicher_lesen_Byte(s); s := s + 1;
{$IFDEF WANT_TIM}
             t := t + 21;
{$ENDIF}
             i := i - 1;
      until (i>0) AND (p<>0);
      F := F OR N_FLAG;
      B := i shr 8;
      C := i AND $00FF;
      H := s shr 8;
      L := s AND $00FF;

      if (i=0)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_cpir:=t + 16;
{$ENDIF}
end;

function op_cpdop:Integer; far;                                        { CPD }
  var i : Byte;
begin                                              { H flag isn't set here ! }
      i := A - Speicher_lesen_Byte((H shl 8) + L);
      L := L - 1;
      if (L = $FF) then H := H - 1;
      C := C - 1;
      if (C = $FF) then B := B - 1;
      F := F OR N_FLAG;
      if (B=0) OR (C=0)	 then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (i AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_cpdop:=16;
{$ENDIF}
end;

function op_cpdr:Integer; far;                                        { CPDR }
  var i : Word;
      s : Word;
      p : Byte;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin                                              { H flag isn't set here ! }
{$IFDEF WANT_TIM}
      t := -21;
{$ENDIF}
      i := (B shl 8) + C;
      s := (H shl 8) + L;
      repeat
             p := A - Speicher_lesen_Byte(s); s := s - 1;
{$IFDEF WANT_TIM}
             t := t + 21;
{$ENDIF}
             i := i - 1;
      until (i>0) AND (p<>0);
      F := F OR N_FLAG;
      B := i shr 8;
      C := i AND $00FF;
      H := s shr 8;
      L := s AND $00FF;

      if (i=0)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
{$IFDEF WANT_TIM}
      op_cpdr:=t + 16;
{$ENDIF}
end;

function op_oprld:Integer; far;                                   { RLD (HL) }
  var i,j : Integer;
begin
      i := Speicher_lesen_Byte((H shl 8) + L);
      j := A AND $0F;
      A := (A AND $F0) OR (i shr 4);
      i := (i shl 4) OR j;
      Speicher_schreiben_Byte((H shl 8) + L,i);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_oprld:=18;
{$ENDIF}
end;

function op_oprrd:Integer; far;                                   { RRD (HL) }
  var i,j : Integer;
begin
      i := Speicher_lesen_Byte((H shl 8) + L);
      j := A AND $0F;
      A := (A AND $F0) OR (i AND $0F);
      i := (i shr 4) OR (j shl 4);
      Speicher_schreiben_Byte((H shl 8) + L,i);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_oprrd:=18;
{$ENDIF}
end;


{ Like the function "cpu()" this one emulates multi byte opcodes
  starting with 0xED
}
function op_ed_handel:Integer;
  const op_ed : Array[0..255] of op_func =
       (trap_ed,  {0x00} trap_ed,     {0x01} trap_ed,  {0x02} trap_ed,     {0x03}
        trap_ed,  {0x04} trap_ed,     {0x05} trap_ed,  {0x06} trap_ed,     {0x07}
        trap_ed,  {0x08} trap_ed,     {0x09} trap_ed,  {0x0a} trap_ed,     {0x0b}
        trap_ed,  {0x0c} trap_ed,     {0x0d} trap_ed,  {0x0e} trap_ed,     {0x0f}
        trap_ed,  {0x10} trap_ed,     {0x11} trap_ed,  {0x12} trap_ed,     {0x13}
        trap_ed,  {0x14} trap_ed,     {0x15} trap_ed,  {0x16} trap_ed,     {0x17}
        trap_ed,  {0x18} trap_ed,     {0x19} trap_ed,  {0x1a} trap_ed,     {0x1b}
        trap_ed,  {0x1c} trap_ed,     {0x1d} trap_ed,  {0x1e} trap_ed,     {0x1f}
        trap_ed,  {0x20} trap_ed,     {0x21} trap_ed,  {0x22} trap_ed,     {0x23}
        trap_ed,  {0x24} trap_ed,     {0x25} trap_ed,  {0x26} trap_ed,     {0x27}
        trap_ed,  {0x28} trap_ed,     {0x29} trap_ed,  {0x2a} trap_ed,     {0x2b}
        trap_ed,  {0x2c} trap_ed,     {0x2d} trap_ed,  {0x2e} trap_ed,     {0x2f}
        trap_ed,  {0x30} trap_ed,     {0x31} trap_ed,  {0x32} trap_ed,     {0x33}
        trap_ed,  {0x34} trap_ed,     {0x35} trap_ed,  {0x36} trap_ed,     {0x37}
        trap_ed,  {0x38} trap_ed,     {0x39} trap_ed,  {0x3a} trap_ed,     {0x3b}
        trap_ed,  {0x3c} trap_ed,     {0x3d} trap_ed,  {0x3e} trap_ed,     {0x3f}
        op_inbic, {0x40} op_outcb,    {0x41} op_sbchb, {0x42} op_ldinbc,   {0x43}
        op_neg,   {0x44} op_retn,     {0x45} op_im0,   {0x46} op_ldia,     {0x47}
        op_incic, {0x48} op_outcc,    {0x49} op_adchb, {0x4a} op_ldbcinn,  {0x4b}
        trap_ed,  {0x4c} op_reti,     {0x4d} trap_ed,  {0x4e} op_ldra,     {0x4f}
        op_indic, {0x50} op_outcd,    {0x51} op_sbchd, {0x52} op_ldinde,   {0x53}
        trap_ed,  {0x54} trap_ed,     {0x55} op_im1,   {0x56} op_ldai,     {0x57}
        op_ineic, {0x58} op_outce,    {0x59} op_adchd, {0x5a} op_lddeinn,  {0x5b}
        trap_ed,  {0x5c} trap_ed,     {0x5d} op_im2,   {0x5e} op_ldar,     {0x5f}
        op_inhic, {0x60} op_outch,    {0x61} op_sbchh, {0x62} trap_ed,     {0x63}
        trap_ed,  {0x64} trap_ed,     {0x65} trap_ed,  {0x66} op_oprrd,    {0x67}
        op_inlic, {0x68} op_outcl,    {0x69} op_adchh, {0x6a} trap_ed,     {0x6b}
        trap_ed,  {0x6c} trap_ed,     {0x6d} trap_ed,  {0x6e} op_oprld,    {0x6f}
        trap_ed,  {0x70} trap_ed,     {0x71} op_sbchs, {0x72} op_ldinsp,   {0x73}
        trap_ed,  {0x74} trap_ed,     {0x75} trap_ed,  {0x76} trap_ed,     {0x77}
        op_inaic, {0x78} op_outca,    {0x79} op_adchs, {0x7a} op_ldspinn,  {0x7b}
        trap_ed,  {0x7c} trap_ed,     {0x7d} trap_ed,  {0x7e} trap_ed,     {0x7f}
        trap_ed,  {0x80} trap_ed,     {0x81} trap_ed,  {0x82} trap_ed,     {0x83}
        trap_ed,  {0x84} trap_ed,     {0x85} trap_ed,  {0x86} trap_ed,     {0x87}
        trap_ed,  {0x88} trap_ed,     {0x89} trap_ed,  {0x8a} trap_ed,     {0x8b}
        trap_ed,  {0x8c} trap_ed,     {0x8d} trap_ed,  {0x8e} trap_ed,     {0x8f}
        trap_ed,  {0x90} trap_ed,     {0x91} trap_ed,  {0x92} trap_ed,     {0x93}
        trap_ed,  {0x94} trap_ed,     {0x95} trap_ed,  {0x96} trap_ed,     {0x97}
        trap_ed,  {0x98} trap_ed,     {0x99} trap_ed,  {0x9a} trap_ed,     {0x9b}
        trap_ed,  {0x9c} trap_ed,     {0x9d} trap_ed,  {0x9e} trap_ed,     {0x9f}
        op_ldi,   {0xa0} op_cpi,      {0xa1} op_ini,   {0xa2} op_outi,     {0xa3}
        trap_ed,  {0xa4} trap_ed,     {0xa5} trap_ed,  {0xa6} trap_ed,     {0xa7}
        op_ldd,   {0xa8} op_cpdop,    {0xa9} op_ind,   {0xaa} op_outd,     {0xab}
        trap_ed,  {0xac} trap_ed,     {0xad} trap_ed,  {0xae} trap_ed,     {0xaf}
        op_ldir,  {0xb0} op_cpir,     {0xb1} op_inir,  {0xb2} op_otir,     {0xb3}
        trap_ed,  {0xb4} trap_ed,     {0xb5} trap_ed,  {0xb6} trap_ed,     {0xb7}
        op_lddr,  {0xb8} op_cpdr,     {0xb9} op_indr,  {0xba} op_otdr,     {0xbb}
        trap_ed,  {0xbc} trap_ed,     {0xbd} trap_ed,  {0xbe} trap_ed,     {0xbf}
        trap_ed,  {0xc0} trap_ed,     {0xc1} trap_ed,  {0xc2} trap_ed,     {0xc3}
        trap_ed,  {0xc4} trap_ed,     {0xc5} trap_ed,  {0xc6} trap_ed,     {0xc7}
        trap_ed,  {0xc8} trap_ed,     {0xc9} trap_ed,  {0xca} trap_ed,     {0xcb}
        trap_ed,  {0xcc} trap_ed,     {0xcd} trap_ed,  {0xce} trap_ed,     {0xcf}
        trap_ed,  {0xd0} trap_ed,     {0xd1} trap_ed,  {0xd2} trap_ed,     {0xd3}
        trap_ed,  {0xd4} trap_ed,     {0xd5} trap_ed,  {0xd6} trap_ed,     {0xd7}
        trap_ed,  {0xd8} trap_ed,     {0xd9} trap_ed,  {0xda} trap_ed,     {0xdb}
        trap_ed,  {0xdc} trap_ed,     {0xdd} trap_ed,  {0xde} trap_ed,     {0xdf}
        trap_ed,  {0xe0} trap_ed,     {0xe1} trap_ed,  {0xe2} trap_ed,     {0xe3}
        trap_ed,  {0xe4} trap_ed,     {0xe5} trap_ed,  {0xe6} trap_ed,     {0xe7}
        trap_ed,  {0xe8} trap_ed,     {0xe9} trap_ed,  {0xea} trap_ed,     {0xeb}
        trap_ed,  {0xec} trap_ed,     {0xed} trap_ed,  {0xee} trap_ed,     {0xef}
        trap_ed,  {0xf0} trap_ed,     {0xf1} trap_ed,  {0xf2} trap_ed,     {0xf3}
        trap_ed,  {0xf4} trap_ed,     {0xf5} trap_ed,  {0xf6} trap_ed,     {0xf7}
        trap_ed,  {0xf8} trap_ed,     {0xf9} trap_ed,  {0xfa} trap_ed,     {0xfb}
        trap_ed,  {0xfc} trap_ed,     {0xfd} trap_ed,  {0xfe} trap_ed      {0xff}
	);
  var op_f : op_func;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin
      op_f := op_ed[Speicher_lesen_Byte(PC)];
      PC := PC + 1;
{$IFDEF WANT_TIM}                                      { execute next opcode }
      t := op_f;
{$ELSE}
      op_f;
{$ENDIF}

{$IFDEF WANT_PCC}                                       { correct PC overrun }
      if (PC > 65535) then PC := 0;
{$ENDIF}

{$IFDEF WANT_TIM}
      op_ed_handel:=t;
{$ENDIF}
end;

begin
end.
