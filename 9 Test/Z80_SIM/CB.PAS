{$I DEFINE.INC}

unit CB;

interface

uses Varia;

function op_cb_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xCB of a multi byte opcode.
}
function trap_cb:Integer; far;
begin
      cpu_error := OPTRAP2;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_cb:=0;
{$ENDIF}
end;

function op_srla:Integer; far;                                       { SRL A }
begin
      if (A AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      A := A div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srla:=8;
{$ENDIF}
end;

function op_srlb:Integer; far;                                       { SRL B }
begin
      if (B AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      B := B div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srlb:=8;
{$ENDIF}
end;

function op_srlc:Integer; far;                                       { SRL C }
begin
      if (C AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      C := C div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srlc:=8;
{$ENDIF}
end;

function op_srld:Integer; far;                                       { SRL D }
begin
      if (D AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      D := D div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srld:=8;
{$ENDIF}
end;

function op_srle:Integer; far;                                       { SRL E }
begin
      if (E AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      E := E div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srle:=8;
{$ENDIF}
end;

function op_srlh:Integer; far;                                       { SRL H }
begin
      if (H AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      H := H div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srlh:=8;
{$ENDIF}
end;

function op_srll:Integer; far;                                       { SRL L }
begin
      if (L AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      L := L div 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srll:=8;
{$ENDIF}
end;

function op_srlhl:Integer; far;                                   { SRL (HL) }
  var p : Word;
begin
      p := H * 256 + L;
      if (Speicher_lesen_Byte(p) AND 1)=1 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) div 2);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srlhl:=15;
{$ENDIF}
end;

function op_slaa:Integer; far;                                       { SLA A }
begin
      if (A AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      A := A * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slaa:=8;
{$ENDIF}
end;

function op_slab:Integer; far;                                       { SLA B }
begin
      if (B AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      B := B * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slab:=8;
{$ENDIF}
end;

function op_slac:Integer; far;                                       { SLA C }
begin
      if (C AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      C := C * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slac:=8;
{$ENDIF}
end;

function op_slad:Integer; far;                                       { SLA D }
begin
      if (D AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      D := D * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slad:=8;
{$ENDIF}
end;

function op_slae:Integer; far;                                       { SLA E }
begin
      if (E AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      E := E * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slae:=8;
{$ENDIF}
end;

function op_slah:Integer; far;                                       { SLA H }
begin
      if (H AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      H := H * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slah:=8;
{$ENDIF}
end;

function op_slal:Integer; far;                                       { SLA L }
begin
      if (L AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      L := L * 2;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slal:=8;
{$ENDIF}
end;

function op_slahl:Integer; far;                                    { SLA (HL) }
  var p : Word;
begin
      p := H * 256 + L;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) * 2);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slahl:=15;
{$ENDIF}
end;

function op_rlra:Integer; far;                                        { RL A }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (A AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      A := A * 2;
      if (old_c_flag=1) then A := A OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlra:=8;
{$ENDIF}
end;

function op_rlb:Integer; far;                                         { RL B }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (B AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      B := B * 2;
      if (old_c_flag=1) then B := B OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlb:=8;
{$ENDIF}
end;

function op_rlc:Integer; far;                                         { RL C }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (C AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      C := C * 2;
      if (old_c_flag=1) then C := C OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlc:=8;
{$ENDIF}
end;

function op_rld:Integer; far;                                         { RL D }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (D AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      D := D * 2;
      if (old_c_flag=1) then D := D OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rld:=8;
{$ENDIF}
end;

function op_rle:Integer; far;                                         { RL E }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (E AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      E := E * 2;
      if (old_c_flag=1) then E := E OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rle:=8;
{$ENDIF}
end;

function op_rlh:Integer; far;                                         { RL H }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (H AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      H := H * 2;
      if (old_c_flag=1) then H := H OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlh:=8;
{$ENDIF}
end;

function op_rll:Integer; far;                                         { RL L }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (L AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      L := L * 2;
      if (old_c_flag=1) then L := L OR 1;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rll:=8;
{$ENDIF}
end;


function op_rlhl:Integer; far;                                     { RL (HL) }
  var old_c_flag : Integer;
      p          : Word;
begin
      p := H * 256 + L;
      old_c_flag := F AND C_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) * 2);
      if (old_c_flag=1) then Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) OR 1);
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlhl:=15;
{$ENDIF}
end;

function op_rrra:Integer; far;                                        { RR A }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (A AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      A := A div 2;
      if (old_c_flag=1) then A := A OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrra:=8;
{$ENDIF}
end;

function op_rrb:Integer; far;                                         { RR B }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (B AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      B := B div 2;
      if (old_c_flag=1) then B := B OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrb:=8;
{$ENDIF}
end;

function op_rrc:Integer; far;                                         { RR C }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (C AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      C := C div 2;
      if (old_c_flag=1) then C := C OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrc:=8;
{$ENDIF}
end;

function op_rrd:Integer; far;                                         { RR D }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (D AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      D := D div 2;
      if (old_c_flag=1) then D := D OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrd:=8;
{$ENDIF}
end;

function op_rre:Integer; far;                                         { RR E }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (E AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      E := E div 2;
      if (old_c_flag=1) then E := E OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rre:=8;
{$ENDIF}
end;

function op_rrh:Integer; far;                                         { RR H }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (H AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      H := H div 2;
      if (old_c_flag=1) then H := H OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrh:=8;
{$ENDIF}
end;

function op_rrl:Integer; far;                                         { RR L }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (L AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      L := L div 2;
      if (old_c_flag=1) then L := L OR $80;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrl:=8;
{$ENDIF}
end;

function op_rrhl:Integer; far;                                     { RR (HL) }
  var old_c_flag : Integer;
      p          : Word;
begin
      p := H * 256 + L;
      old_c_flag := F AND C_FLAG;
      if (Speicher_lesen_Byte(p) AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) div 2);
      if (old_c_flag=1) then Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) OR $80);
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrhl:=15;
{$ENDIF}
end;


function op_rrcra:Integer; far;                                      { RRC A }
  var i : Integer;
begin
      i := A AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      A := A div 2;
      if (i=$01) then A := A OR $80;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcra:=8;
{$ENDIF}
end;

function op_rrcb:Integer; far;                                       { RRC B }
  var i : Integer;
begin
      i := B AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      B := B div 2;
      if (i=$01) then B := B OR $80;
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcb:=8;
{$ENDIF}
end;

function op_rrcc:Integer; far;                                       { RRC C }
  var i : Integer;
begin
      i := C AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      C := C div 2;
      if (i=$01) then C := C OR $80;
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcc:=8;
{$ENDIF}
end;

function op_rrcd:Integer; far;                                       { RRC D }
  var i : Integer;
begin
      i := D AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      D := D div 2;
      if (i=$01) then D := D OR $80;
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcd:=8;
{$ENDIF}
end;

function op_rrce:Integer; far;                                       { RRC E }
  var i : Integer;
begin
      i := E AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      E := E div 2;
      if (i=$01) then E := E OR $80;
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrce:=8;
{$ENDIF}
end;

function op_rrch:Integer; far;                                       { RRC H }
  var i : Integer;
begin
      i := H AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      H := H div 2;
      if (i=$01) then H := H OR $80;
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrch:=8;
{$ENDIF}
end;

function op_rrcl:Integer; far;                                       { RRC L }
  var i : Integer;
begin
      i := L AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      L := L div 2;
      if (i=$01) then L := L OR $80;
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcl:=8;
{$ENDIF}
end;

function op_rrchl:Integer; far;                                   { RRC (HL) }
  var i : Integer;
      p : Word;
begin
      p := H * 256 + L;
      i := Speicher_lesen_Byte(p) AND $01;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) div 2);
      if (i=$01) then Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) OR $80);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrchl:=15;
{$ENDIF}
end;


function op_rlcra:Integer; far;                                      { RLC A }
  var i : Integer;
begin
      i := A AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      A := A * 2;
      if (i=$80) then A := A OR $01;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcra:=8;
{$ENDIF}
end;

function op_rlcb:Integer; far;                                       { RLC B }
  var i : Integer;
begin
      i := B AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      B := B * 2;
      if (i=$80) then B := B OR $01;
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcb:=8;
{$ENDIF}
end;

function op_rlcc:Integer; far;                                       { RLC C }
  var i : Integer;
begin
      i := C AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      C := C * 2;
      if (i=$80) then C := C OR $01;
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcc:=8;
{$ENDIF}
end;

function op_rlcd:Integer; far;                                       { RLC D }
  var i : Integer;
begin
      i := D AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      D := D * 2;
      if (i=$80) then D := D OR $01;
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcd:=8;
{$ENDIF}
end;

function op_rlce:Integer; far;                                       { RLC E }
  var i : Integer;
begin
      i := E AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      E := E * 2;
      if (i=$80) then E := E OR $01;
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlce:=8;
{$ENDIF}
end;

function op_rlch:Integer; far;                                       { RLC H }
  var i : Integer;
begin
      i := H AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      H := H * 2;
      if (i=$80) then H := H OR $01;
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlch:=8;
{$ENDIF}
end;

function op_rlcl:Integer; far;                                       { RLC L }
  var i : Integer;
begin
      i := L AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      L := L * 2;
      if (i=$80) then L := L OR $01;
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcl:=8;
{$ENDIF}
end;


function op_rlchl:Integer; far;                                   { RLC (HL) }
  var i : Integer;
      p : Word;
begin
      p := H * 256 + L;
      i := Speicher_lesen_Byte(p) AND $80;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR	N_FLAG);
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) * 2);
      if (i=$80) then Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) OR $01);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlchl:=15;
{$ENDIF}
end;

function op_sraa:Integer; far;                                       { SRA A }
  var i : Integer;
begin
      i := A AND $80;
      if (A AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      A := A div 2;
      A := A OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_sraa:=8;
{$ENDIF}
end;

function op_srab:Integer; far;                                       { SRA B }
  var i : Integer;
begin
      i := B AND $80;
      if (B AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      B := B div 2;
      B := B OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[B]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srab:=8;
{$ENDIF}
end;

function op_srac:Integer; far;                                       { SRA C }
  var i : Integer;
begin
      i := C AND $80;
      if (C AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      C := C div 2;
      C := C OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[C]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srac:=8;
{$ENDIF}
end;

function op_srad:Integer; far;                                       { SRA D }
  var i : Integer;
begin
      i := D AND $80;
      if (D AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      D := D div 2;
      D := D OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[D]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srad:=8;
{$ENDIF}
end;

function op_srae:Integer; far;                                       { SRA E }
  var i : Integer;
begin
      i := E AND $80;
      if (E AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      E := E div 2;
      E := E OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[E]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srae:=8;
{$ENDIF}
end;

function op_srah:Integer; far;                                       { SRA H }
  var i : Integer;
begin
      i := H AND $80;
      if (H AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      H := H div 2;
      H := H OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[H]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srah:=8;
{$ENDIF}
end;

function op_sral:Integer; far;                                       { SRA L }
  var i : Integer;
begin
      i := L AND $80;
      if (L AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      L := L div 2;
      L := L OR  i;
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[L]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_sral:=8;
{$ENDIF}
end;


function op_srahl:Integer; far;                                   { SRA (HL) }
  var i : Integer;
      p : Word;
begin
      p := H * 256 + L;
      i := Speicher_lesen_Byte(p) AND $80;
      if (Speicher_lesen_Byte(p) AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) div 2);
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p) OR  i);
      F := F AND NOT (H_FLAG OR	N_FLAG);
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[Speicher_lesen_Byte(p)]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srahl:=15;
{$ENDIF}
end;

function op_sb0a:Integer; far;                                     { SET 0,A }
begin
      A := A OR $01;
{$IFDEF WANT_TIM}
      op_sb0a:=8;
{$ENDIF}
end;

function op_sb1a:Integer; far;                                     { SET 1,A }
begin
      A := A OR $02;
{$IFDEF WANT_TIM}
      op_sb1a:=8;
{$ENDIF}
end;

function op_sb2a:Integer; far;                                     { SET 2,A }
begin
      A := A OR $04;
{$IFDEF WANT_TIM}
      op_sb2a:=8;
{$ENDIF}
end;

function op_sb3a:Integer; far;                                     { SET 3,A }
begin
      A := A OR $08;
{$IFDEF WANT_TIM}
      op_sb3a:=8;
{$ENDIF}
end;

function op_sb4a:Integer; far;                                     { SET 4,A }
begin
      A := A OR $10;
{$IFDEF WANT_TIM}
      op_sb4a:=8;
{$ENDIF}
end;

function op_sb5a:Integer; far;                                     { SET 5,A }
begin
      A := A OR $20;
{$IFDEF WANT_TIM}
      op_sb5a:=8;
{$ENDIF}
end;

function op_sb6a:Integer; far;                                     { SET 6,A }
begin
      A := A OR $40;
{$IFDEF WANT_TIM}
      op_sb6a:=8;
{$ENDIF}
end;

function op_sb7a:Integer; far;                                     { SET 7,A }
begin
      A := A OR $80;
{$IFDEF WANT_TIM}
      op_sb7a:=8;
{$ENDIF}
end;

function op_sb0b:Integer; far;                                     { SET 0,B }
begin
      B := B OR $01;
{$IFDEF WANT_TIM}
      op_sb0b:=8;
{$ENDIF}
end;

function op_sb1b:Integer; far;                                     { SET 1,B }
begin
      B := B OR $02;
{$IFDEF WANT_TIM}
      op_sb1b:=8;
{$ENDIF}
end;

function op_sb2b:Integer; far;                                     { SET 2,B }
begin
      B := B OR $04;
{$IFDEF WANT_TIM}
      op_sb2b:=8;
{$ENDIF}
end;

function op_sb3b:Integer; far;                                     { SET 3,B }
begin
      B := B OR $08;
{$IFDEF WANT_TIM}
      op_sb3b:=8;
{$ENDIF}
end;

function op_sb4b:Integer; far;                                     { SET 4,B }
begin
      B := B OR $10;
{$IFDEF WANT_TIM}
      op_sb4b:=8;
{$ENDIF}
end;

function op_sb5b:Integer; far;                                     { SET 5,B }
begin
      B := B OR $20;
{$IFDEF WANT_TIM}
      op_sb5b:=8;
{$ENDIF}
end;

function op_sb6b:Integer; far;                                     { SET 6,B }
begin
      B := B OR $40;
{$IFDEF WANT_TIM}
      op_sb6b:=8;
{$ENDIF}
end;

function op_sb7b:Integer; far;                                     { SET 7,B }
begin
      B := B OR $80;
{$IFDEF WANT_TIM}
      op_sb7b:=8;
{$ENDIF}
end;

function op_sb0c:Integer; far;                                     { SET 0,C }
begin
      C := C OR $01;
{$IFDEF WANT_TIM}
      op_sb0c:=8;
{$ENDIF}
end;

function op_sb1c:Integer; far;                                     { SET 1,C }
begin
      C := C OR $02;
{$IFDEF WANT_TIM}
      op_sb1c:=8;
{$ENDIF}
end;

function op_sb2c:Integer; far;                                     { SET 2,C }
begin
      C := C OR $04;
{$IFDEF WANT_TIM}
      op_sb2c:=8;
{$ENDIF}
end;

function op_sb3c:Integer; far;                                     { SET 3,C }
begin
      C := C OR $08;
{$IFDEF WANT_TIM}
      op_sb3c:=8;
{$ENDIF}
end;

function op_sb4c:Integer; far;                                     { SET 4,C }
begin
      C := C OR $10;
{$IFDEF WANT_TIM}
      op_sb4c:=8;
{$ENDIF}
end;

function op_sb5c:Integer; far;                                     { SET 5,C }
begin
      C := C OR $20;
{$IFDEF WANT_TIM}
      op_sb5c:=8;
{$ENDIF}
end;

function op_sb6c:Integer; far;                                     { SET 6,C }
begin
      C := C OR $40;
{$IFDEF WANT_TIM}
      op_sb6c:=8;
{$ENDIF}
end;

function op_sb7c:Integer; far;                                     { SET 7,C }
begin
      C := C OR $80;
{$IFDEF WANT_TIM}
      op_sb7c:=8;
{$ENDIF}
end;

function op_sb0d:Integer; far;                                     { SET 0,D }
begin
      D := D OR $01;
{$IFDEF WANT_TIM}
      op_sb0d:=8;
{$ENDIF}
end;

function op_sb1d:Integer; far;                                     { SET 1,D }
begin
      D := D OR $02;
{$IFDEF WANT_TIM}
      op_sb1d:=8;
{$ENDIF}
end;

function op_sb2d:Integer; far;                                     { SET 2,D }
begin
      D := D OR $04;
{$IFDEF WANT_TIM}
      op_sb2d:=8;
{$ENDIF}
end;

function op_sb3d:Integer; far;                                     { SET 3,D }
begin
      D := D OR $08;
{$IFDEF WANT_TIM}
      op_sb3d:=8;
{$ENDIF}
end;

function op_sb4d:Integer; far;                                     { SET 4,D }
begin
      D := D OR $10;
{$IFDEF WANT_TIM}
      op_sb4d:=8;
{$ENDIF}
end;

function op_sb5d:Integer; far;                                     { SET 5,D }
begin
      D := D OR $20;
{$IFDEF WANT_TIM}
      op_sb5d:=8;
{$ENDIF}
end;

function op_sb6d:Integer; far;                                     { SET 6,D }
begin
      D := D OR $40;
{$IFDEF WANT_TIM}
      op_sb6d:=8;
{$ENDIF}
end;

function op_sb7d:Integer; far;                                     { SET 7,D }
begin
      D := D OR $80;
{$IFDEF WANT_TIM}
      op_sb7d:=8;
{$ENDIF}
end;

function op_sb0e:Integer; far;                                     { SET 0,E }
begin
      E := E OR $01;
{$IFDEF WANT_TIM}
      op_sb0e:=8;
{$ENDIF}
end;

function op_sb1e:Integer; far;                                     { SET 1,E }
begin
      E := E OR $02;
{$IFDEF WANT_TIM}
      op_sb1e:=8;
{$ENDIF}
end;

function op_sb2e:Integer; far;                                     { SET 2,E }
begin
      E := E OR $04;
{$IFDEF WANT_TIM}
      op_sb2e:=8;
{$ENDIF}
end;

function op_sb3e:Integer; far;                                     { SET 3,E }
begin
      E := E OR $08;
{$IFDEF WANT_TIM}
      op_sb3e:=8;
{$ENDIF}
end;

function op_sb4e:Integer; far;                                     { SET 4,E }
begin
      E := E OR $10;
{$IFDEF WANT_TIM}
      op_sb4e:=8;
{$ENDIF}
end;

function op_sb5e:Integer; far;                                     { SET 5,E }
begin
      E := E OR $20;
{$IFDEF WANT_TIM}
      op_sb5e:=8;
{$ENDIF}
end;

function op_sb6e:Integer; far;                                     { SET 6,E }
begin
      E := E OR $40;
{$IFDEF WANT_TIM}
      op_sb6e:=8;
{$ENDIF}
end;

function op_sb7e:Integer; far;                                     { SET 7,E }
begin
      E := E OR $80;
{$IFDEF WANT_TIM}
      op_sb7e:=8;
{$ENDIF}
end;

function op_sb0h:Integer; far;                                     { SET 0,H }
begin
      H := H OR $01;
{$IFDEF WANT_TIM}
      op_sb0h:=8;
{$ENDIF}
end;

function op_sb1h:Integer; far;                                     { SET 1,H }
begin
      H := H OR $02;
{$IFDEF WANT_TIM}
      op_sb1h:=8;
{$ENDIF}
end;

function op_sb2h:Integer; far;                                     { SET 2,H }
begin
      H := H OR $04;
{$IFDEF WANT_TIM}
      op_sb2h:=8;
{$ENDIF}
end;

function op_sb3h:Integer; far;                                     { SET 3,H }
begin
      H := H OR $08;
{$IFDEF WANT_TIM}
      op_sb3h:=8;
{$ENDIF}
end;

function op_sb4h:Integer; far;                                     { SET 4,H }
begin
      H := H OR $10;
{$IFDEF WANT_TIM}
      op_sb4h:=8;
{$ENDIF}
end;

function op_sb5h:Integer; far;                                     { SET 5,H }
begin
      H := H OR $20;
{$IFDEF WANT_TIM}
      op_sb5h:=8;
{$ENDIF}
end;

function op_sb6h:Integer; far;                                     { SET 6,H }
begin
      H := H OR $40;
{$IFDEF WANT_TIM}
      op_sb6h:=8;
{$ENDIF}
end;

function op_sb7h:Integer; far;                                     { SET 7,H }
begin
      H := H OR $80;
{$IFDEF WANT_TIM}
      op_sb7h:=8;
{$ENDIF}
end;

function op_sb0l:Integer; far;                                     { SET 0,L }
begin
      L := L OR $01;
{$IFDEF WANT_TIM}
      op_sb0l:=8;
{$ENDIF}
end;

function op_sb1l:Integer; far;                                     { SET 1,L }
begin
      L := L OR $02;
{$IFDEF WANT_TIM}
      op_sb1l:=8;
{$ENDIF}
end;

function op_sb2l:Integer; far;                                     { SET 2,L }
begin
      L := L OR $04;
{$IFDEF WANT_TIM}
      op_sb2l:=8;
{$ENDIF}
end;

function op_sb3l:Integer; far;                                     { SET 3,L }
begin
      L := L OR $08;
{$IFDEF WANT_TIM}
      op_sb3l:=8;
{$ENDIF}
end;

function op_sb4l:Integer; far;                                     { SET 4,L }
begin
      L := L OR $10;
{$IFDEF WANT_TIM}
      op_sb4l:=8;
{$ENDIF}
end;

function op_sb5l:Integer; far;                                     { SET 5,L }
begin
      L := L OR $20;
{$IFDEF WANT_TIM}
      op_sb5l:=8;
{$ENDIF}
end;

function op_sb6l:Integer; far;                                     { SET 6,L }
begin
      L := L OR $40;
{$IFDEF WANT_TIM}
      op_sb6l:=8;
{$ENDIF}
end;

function op_sb7l:Integer; far;                                     { SET 7,L }
begin
      L := L OR $80;
{$IFDEF WANT_TIM}
      op_sb7l:=8;
{$ENDIF}
end;

function op_sb0hl:Integer; far;                                 { SET 0,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $01);
{$IFDEF WANT_TIM}
      op_sb0hl:=15;
{$ENDIF}
end;

function op_sb1hl:Integer; far;                                 { SET 1,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $02);
{$IFDEF WANT_TIM}
      op_sb1hl:=15;
{$ENDIF}
end;

function op_sb2hl:Integer; far;                                 { SET 2,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $04);
{$IFDEF WANT_TIM}
      op_sb2hl:=15;
{$ENDIF}
end;

function op_sb3hl:Integer; far;                                 { SET 3,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $08);
{$IFDEF WANT_TIM}
      op_sb3hl:=15;
{$ENDIF}
end;

function op_sb4hl:Integer; far;                                 { SET 4,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $10);
{$IFDEF WANT_TIM}
      op_sb4hl:=15;
{$ENDIF}
end;

function op_sb5hl:Integer; far;                                 { SET 5,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $20);
{$IFDEF WANT_TIM}
      op_sb5hl:=15;
{$ENDIF}
end;

function op_sb6hl:Integer; far;                                 { SET 6,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $40);
{$IFDEF WANT_TIM}
      op_sb6hl:=15;
{$ENDIF}
end;

function op_sb7hl:Integer; far;                                 { SET 7,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) OR $80);
{$IFDEF WANT_TIM}
      op_sb7hl:=15;
{$ENDIF}
end;

function op_rb0a:Integer; far;                                     { RES 0,A }
begin
      A := A AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0a:=8;
{$ENDIF}
end;

function op_rb1a:Integer; far;                                     { RES 1,A }
begin
      A := A AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1a:=8;
{$ENDIF}
end;

function op_rb2a:Integer; far;                                     { RES 2,A }
begin
      A := A AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2a:=8;
{$ENDIF}
end;

function op_rb3a:Integer; far;                                     { RES 3,A }
begin
      A := A AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3a:=8;
{$ENDIF}
end;

function op_rb4a:Integer; far;                                     { RES 4,A }
begin
      A := A AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4a:=8;
{$ENDIF}
end;

function op_rb5a:Integer; far;                                     { RES 5,A }
begin
      A := A AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5a:=8;
{$ENDIF}
end;

function op_rb6a:Integer; far;                                     { RES 6,A }
begin
      A := A AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6a:=8;
{$ENDIF}
end;

function op_rb7a:Integer; far;                                     { RES 7,A }
begin
      A := A AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7a:=8;
{$ENDIF}
end;

function op_rb0b:Integer; far;                                     { RES 0,B }
begin
      B := B AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0b:=8;
{$ENDIF}
end;

function op_rb1b:Integer; far;                                     { RES 1,B }
begin
      B := B AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1b:=8;
{$ENDIF}
end;

function op_rb2b:Integer; far;                                     { RES 2,B }
begin
      B := B AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2b:=8;
{$ENDIF}
end;

function op_rb3b:Integer; far;                                     { RES 3,B }
begin
      B := B AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3b:=8;
{$ENDIF}
end;

function op_rb4b:Integer; far;                                     { RES 4,B }
begin
      B := B AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4b:=8;
{$ENDIF}
end;

function op_rb5b:Integer; far;                                     { RES 5,B }
begin
      B := B AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5b:=8;
{$ENDIF}
end;

function op_rb6b:Integer; far;                                     { RES 6,B }
begin
      B := B AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6b:=8;
{$ENDIF}
end;

function op_rb7b:Integer; far;                                     { RES 7,B }
begin
      B := B AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7b:=8;
{$ENDIF}
end;

function op_rb0c:Integer; far;                                     { RES 0,C }
begin
      C := C AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0c:=8;
{$ENDIF}
end;

function op_rb1c:Integer; far;                                     { RES 1,C }
begin
      C := C AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1c:=8;
{$ENDIF}
end;

function op_rb2c:Integer; far;                                     { RES 2,C }
begin
      C := C AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2c:=8;
{$ENDIF}
end;

function op_rb3c:Integer; far;                                     { RES 3,C }
begin
      C := C AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3c:=8;
{$ENDIF}
end;

function op_rb4c:Integer; far;                                     { RES 4,C }
begin
      C := C AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4c:=8;
{$ENDIF}
end;

function op_rb5c:Integer; far;                                     { RES 5,C }
begin
      C := C AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5c:=8;
{$ENDIF}
end;

function op_rb6c:Integer; far;                                     { RES 6,C }
begin
      C := C AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6c:=8;
{$ENDIF}
end;

function op_rb7c:Integer; far;                                     { RES 7,C }
begin
      C := C AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7c:=8;
{$ENDIF}
end;

function op_rb0d:Integer; far;                                     { RES 0,D }
begin
      D := D AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0d:=8;
{$ENDIF}
end;

function op_rb1d:Integer; far;                                     { RES 1,D }
begin
      D := D AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1d:=8;
{$ENDIF}
end;

function op_rb2d:Integer; far;                                     { RES 2,D }
begin
      D := D AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2d:=8;
{$ENDIF}
end;

function op_rb3d:Integer; far;                                     { RES 3,D }
begin
      D := D AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3d:=8;
{$ENDIF}
end;

function op_rb4d:Integer; far;                                     { RES 4,D }
begin
      D := D AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4d:=8;
{$ENDIF}
end;

function op_rb5d:Integer; far;                                     { RES 5,D }
begin
      D := D AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5d:=8;
{$ENDIF}
end;

function op_rb6d:Integer; far;                                     { RES 6,D }
begin
      D := D AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6d:=8;
{$ENDIF}
end;

function op_rb7d:Integer; far;                                     { RES 7,D }
begin
      D := D AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7d:=8;
{$ENDIF}
end;

function op_rb0e:Integer; far;                                     { RES 0,E }
begin
      E := E AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0e:=8;
{$ENDIF}
end;

function op_rb1e:Integer; far;                                     { RES 1,E }
begin
      E := E AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1e:=8;
{$ENDIF}
end;

function op_rb2e:Integer; far;                                     { RES 2,E }
begin
      E := E AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2e:=8;
{$ENDIF}
end;

function op_rb3e:Integer; far;                                     { RES 3,E }
begin
      E := E AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3e:=8;
{$ENDIF}
end;

function op_rb4e:Integer; far;                                     { RES 4,E }
begin
      E := E AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4e:=8;
{$ENDIF}
end;

function op_rb5e:Integer; far;                                     { RES 5,E }
begin
      E := E AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5e:=8;
{$ENDIF}
end;

function op_rb6e:Integer; far;                                     { RES 6,E }
begin
      E := E AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6e:=8;
{$ENDIF}
end;

function op_rb7e:Integer; far;                                     { RES 7,E }
begin
      E := E AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7e:=8;
{$ENDIF}
end;

function op_rb0h:Integer; far;                                     { RES 0,H }
begin
      H := H AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0h:=8;
{$ENDIF}
end;

function op_rb1h:Integer; far;                                     { RES 1,H }
begin
      H := H AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1h:=8;
{$ENDIF}
end;

function op_rb2h:Integer; far;                                     { RES 2,H }
begin
      H := H AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2h:=8;
{$ENDIF}
end;

function op_rb3h:Integer; far;                                     { RES 3,H }
begin
      H := H AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3h:=8;
{$ENDIF}
end;

function op_rb4h:Integer; far;                                     { RES 4,H }
begin
      H := H AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4h:=8;
{$ENDIF}
end;

function op_rb5h:Integer; far;                                     { RES 5,H }
begin
      H := H AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5h:=8;
{$ENDIF}
end;

function op_rb6h:Integer; far;                                     { RES 6,H }
begin
      H := H AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6h:=8;
{$ENDIF}
end;

function op_rb7h:Integer; far;                                     { RES 7,H }
begin
      H := H AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7h:=8;
{$ENDIF}
end;

function op_rb0l:Integer; far;                                     { RES 0,L }
begin
      L := L AND NOT $01;
{$IFDEF WANT_TIM}
      op_rb0l:=8;
{$ENDIF}
end;

function op_rb1l:Integer; far;                                     { RES 1,L }
begin
      L := L AND NOT $02;
{$IFDEF WANT_TIM}
      op_rb1l:=8;
{$ENDIF}
end;

function op_rb2l:Integer; far;                                     { RES 2,L }
begin
      L := L AND NOT $04;
{$IFDEF WANT_TIM}
      op_rb2l:=8;
{$ENDIF}
end;

function op_rb3l:Integer; far;                                     { RES 3,L }
begin
      L := L AND NOT $08;
{$IFDEF WANT_TIM}
      op_rb3l:=8;
{$ENDIF}
end;

function op_rb4l:Integer; far;                                     { RES 4,L }
begin
      L := L AND NOT $10;
{$IFDEF WANT_TIM}
      op_rb4l:=8;
{$ENDIF}
end;

function op_rb5l:Integer; far;                                     { RES 5,L }
begin
      L := L AND NOT $20;
{$IFDEF WANT_TIM}
      op_rb5l:=8;
{$ENDIF}
end;

function op_rb6l:Integer; far;                                     { RES 6,L }
begin
      L := L AND NOT $40;
{$IFDEF WANT_TIM}
      op_rb6l:=8;
{$ENDIF}
end;

function op_rb7l:Integer; far;                                     { RES 7,L }
begin
      L := L AND NOT $80;
{$IFDEF WANT_TIM}
      op_rb7l:=8;
{$ENDIF}
end;

function op_rb0hl:Integer; far;                                 { RES 0,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $01);
{$IFDEF WANT_TIM}
      op_rb0hl:=15;
{$ENDIF}
end;

function op_rb1hl:Integer; far;                                 { RES 1,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $02);
{$IFDEF WANT_TIM}
      op_rb1hl:=15;
{$ENDIF}
end;

function op_rb2hl:Integer; far;                                 { RES 2,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $04);
{$IFDEF WANT_TIM}
      op_rb2hl:=15;
{$ENDIF}
end;

function op_rb3hl:Integer; far;                                 { RES 3,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $08);
{$IFDEF WANT_TIM}
      op_rb3hl:=15;
{$ENDIF}
end;

function op_rb4hl:Integer; far;                                 { RES 4,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $10);
{$IFDEF WANT_TIM}
      op_rb4hl:=15;
{$ENDIF}
end;

function op_rb5hl:Integer; far;                                 { RES 5,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $20);
{$IFDEF WANT_TIM}
      op_rb5hl:=15;
{$ENDIF}
end;

function op_rb6hl:Integer; far;                                 { RES 6,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $40);
{$IFDEF WANT_TIM}
      op_rb6hl:=15;
{$ENDIF}
end;

function op_rb7hl:Integer; far;                                 { RES 7,(HL) }
begin
      Speicher_schreiben_Byte(H*256+L,Speicher_lesen_Byte(H*256+L) AND NOT $80);
{$IFDEF WANT_TIM}
      op_rb7hl:=15;
{$ENDIF}
end;

function op_tb0a:Integer; far;	                                   { BIT 0,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0a:=8;
{$ENDIF}
end;

function op_tb1a:Integer; far;	                                   { BIT 1,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1a:=8;
{$ENDIF}
end;

function op_tb2a:Integer; far;	                                   { BIT 2,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2a:=8;
{$ENDIF}
end;

function op_tb3a:Integer; far;	                                   { BIT 3,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3a:=8;
{$ENDIF}
end;

function op_tb4a:Integer; far;	                                   { BIT 4,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4a:=8;
{$ENDIF}
end;

function op_tb5a:Integer; far;	                                   { BIT 5,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5a:=8;
{$ENDIF}
end;

function op_tb6a:Integer; far;	                                   { BIT 6,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6a:=8;
{$ENDIF}
end;

function op_tb7a:Integer; far;	                                   { BIT 7,A }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (A AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7a:=8;
{$ENDIF}
end;

function op_tb0b:Integer; far;	                                   { BIT 0,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0b:=8;
{$ENDIF}
end;

function op_tb1b:Integer; far;	                                   { BIT 1,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1b:=8;
{$ENDIF}
end;

function op_tb2b:Integer; far;	                                   { BIT 2,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2b:=8;
{$ENDIF}
end;

function op_tb3b:Integer; far;	                                   { BIT 3,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3b:=8;
{$ENDIF}
end;

function op_tb4b:Integer; far;	                                   { BIT 4,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4b:=8;
{$ENDIF}
end;

function op_tb5b:Integer; far;	                                   { BIT 5,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5b:=8;
{$ENDIF}
end;

function op_tb6b:Integer; far;	                                   { BIT 6,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6b:=8;
{$ENDIF}
end;

function op_tb7b:Integer; far;	                                   { BIT 7,B }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (B AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7b:=8;
{$ENDIF}
end;

function op_tb0c:Integer; far;	                                   { BIT 0,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0c:=8;
{$ENDIF}
end;

function op_tb1c:Integer; far;	                                   { BIT 1,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1c:=8;
{$ENDIF}
end;

function op_tb2c:Integer; far;	                                   { BIT 2,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2c:=8;
{$ENDIF}
end;

function op_tb3c:Integer; far;	                                   { BIT 3,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3c:=8;
{$ENDIF}
end;

function op_tb4c:Integer; far;	                                   { BIT 4,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4c:=8;
{$ENDIF}
end;

function op_tb5c:Integer; far;	                                   { BIT 5,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5c:=8;
{$ENDIF}
end;

function op_tb6c:Integer; far;	                                   { BIT 6,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6c:=8;
{$ENDIF}
end;

function op_tb7c:Integer; far;	                                   { BIT 7,C }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (C AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7c:=8;
{$ENDIF}
end;

function op_tb0d:Integer; far;	                                   { BIT 0,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0d:=8;
{$ENDIF}
end;

function op_tb1d:Integer; far;	                                   { BIT 1,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1d:=8;
{$ENDIF}
end;

function op_tb2d:Integer; far;	                                   { BIT 2,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2d:=8;
{$ENDIF}
end;

function op_tb3d:Integer; far;	                                   { BIT 3,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3d:=8;
{$ENDIF}
end;

function op_tb4d:Integer; far;	                                   { BIT 4,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4d:=8;
{$ENDIF}
end;

function op_tb5d:Integer; far;	                                   { BIT 5,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5d:=8;
{$ENDIF}
end;

function op_tb6d:Integer; far;	                                   { BIT 6,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6d:=8;
{$ENDIF}
end;

function op_tb7d:Integer; far;	                                   { BIT 7,D }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (D AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7d:=8;
{$ENDIF}
end;

function op_tb0e:Integer; far;	                                   { BIT 0,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0e:=8;
{$ENDIF}
end;

function op_tb1e:Integer; far;	                                   { BIT 1,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1e:=8;
{$ENDIF}
end;

function op_tb2e:Integer; far;	                                   { BIT 2,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2e:=8;
{$ENDIF}
end;

function op_tb3e:Integer; far;	                                   { BIT 3,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3e:=8;
{$ENDIF}
end;

function op_tb4e:Integer; far;	                                   { BIT 4,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4e:=8;
{$ENDIF}
end;

function op_tb5e:Integer; far;	                                   { BIT 5,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5e:=8;
{$ENDIF}
end;

function op_tb6e:Integer; far;	                                   { BIT 6,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6e:=8;
{$ENDIF}
end;

function op_tb7e:Integer; far;	                                   { BIT 7,E }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (E AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7e:=8;
{$ENDIF}
end;

function op_tb0h:Integer; far;	                                   { BIT 0,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0h:=8;
{$ENDIF}
end;

function op_tb1h:Integer; far;	                                   { BIT 1,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1h:=8;
{$ENDIF}
end;

function op_tb2h:Integer; far;	                                   { BIT 2,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2h:=8;
{$ENDIF}
end;

function op_tb3h:Integer; far;	                                   { BIT 3,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3h:=8;
{$ENDIF}
end;

function op_tb4h:Integer; far;	                                   { BIT 4,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4h:=8;
{$ENDIF}
end;

function op_tb5h:Integer; far;	                                   { BIT 5,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5h:=8;
{$ENDIF}
end;

function op_tb6h:Integer; far;	                                   { BIT 6,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6h:=8;
{$ENDIF}
end;

function op_tb7h:Integer; far;	                                   { BIT 7,H }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (H AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7h:=8;
{$ENDIF}
end;

function op_tb0l:Integer; far;	                                   { BIT 0,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0l:=8;
{$ENDIF}
end;

function op_tb1l:Integer; far;	                                   { BIT 1,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1l:=8;
{$ENDIF}
end;

function op_tb2l:Integer; far;	                                   { BIT 2,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2l:=8;
{$ENDIF}
end;

function op_tb3l:Integer; far;	                                   { BIT 3,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3l:=8;
{$ENDIF}
end;

function op_tb4l:Integer; far;	                                   { BIT 4,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4l:=8;
{$ENDIF}
end;

function op_tb5l:Integer; far;	                                   { BIT 5,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5l:=8;
{$ENDIF}
end;

function op_tb6l:Integer; far;	                                   { BIT 6,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6l:=8;
{$ENDIF}
end;

function op_tb7l:Integer; far;	                                   { BIT 7,L }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (L AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7l:=8;
{$ENDIF}
end;

function op_tb0hl:Integer; far;                                 { BIT 0,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $01)=$01 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0hl:=12;
{$ENDIF}
end;

function op_tb1hl:Integer; far;                                 { BIT 1,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $02)=$02 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1hl:=12;
{$ENDIF}
end;

function op_tb2hl:Integer; far;                                 { BIT 2,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $04)=$04 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2hl:=12;
{$ENDIF}
end;

function op_tb3hl:Integer; far;                                 { BIT 3,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $08)=$08 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3hl:=12;
{$ENDIF}
end;

function op_tb4hl:Integer; far;                                 { BIT 4,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $10)=$10 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4hl:=12;
{$ENDIF}
end;

function op_tb5hl:Integer; far;                                 { BIT 5,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $20)=$20 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5hl:=12;
{$ENDIF}
end;

function op_tb6hl:Integer; far;                                 { BIT 6,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $40)=$40 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6hl:=12;
{$ENDIF}
end;

function op_tb7hl:Integer; far;                                 { BIT 7,(HL) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if (Speicher_lesen_Byte(H*256+L) AND $80)=$80 then F := F AND NOT Z_FLAG else F := F OR Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7hl:=12;
{$ENDIF}
end;

{ Like the function "cpu()" this one emulates multi byte opcodes
  starting with 0xCB
}
function op_cb_handel:Integer;
  const op_cb : Array[0..255] of op_func =
       (op_rlcb,  {0x00} op_rlcc,     {0x01} op_rlcd,  {0x02} op_rlce,     {0x03}
        op_rlch,  {0x04} op_rlcl,     {0x05} op_rlchl, {0x06} op_rlcra,    {0x07}
        op_rrcb,  {0x08} op_rrcc,     {0x09} op_rrcd,  {0x0a} op_rrce,     {0x0b}
        op_rrch,  {0x0c} op_rrcl,     {0x0d} op_rrchl, {0x0e} op_rrcra,    {0x0f}
        op_rlb,   {0x10} op_rlc,      {0x11} op_rld,   {0x12} op_rle,      {0x13}
        op_rlh,   {0x14} op_rll,      {0x15} op_rlhl,  {0x16} op_rlra,     {0x17}
        op_rrb,   {0x18} op_rrc,      {0x19} op_rrd,   {0x1a} op_rre,      {0x1b}
        op_rrh,   {0x1c} op_rrl,      {0x1d} op_rrhl,  {0x1e} op_rrra,     {0x1f}
        op_slab,  {0x20} op_slac,     {0x21} op_slad,  {0x22} op_slae,     {0x23}
        op_slah,  {0x24} op_slal,     {0x25} op_slahl, {0x26} op_slaa,     {0x27}
        op_srab,  {0x28} op_srac,     {0x29} op_srad,  {0x2a} op_srae,     {0x2b}
        op_srah,  {0x2c} op_sral,     {0x2d} op_srahl, {0x2e} op_sraa,     {0x2f}
        trap_cb,  {0x30} trap_cb,     {0x31} trap_cb,  {0x32} trap_cb,     {0x33}
        trap_cb,  {0x34} trap_cb,     {0x35} trap_cb,  {0x36} trap_cb,     {0x37}
        op_srlb,  {0x38} op_srlc,     {0x39} op_srld,  {0x3a} op_srle,     {0x3b}
        op_srlh,  {0x3c} op_srll,     {0x3d} op_srlhl, {0x3e} op_srla,     {0x3f}
        op_tb0b,  {0x40} op_tb0c,     {0x41} op_tb0d,  {0x42} op_tb0e,     {0x43}
        op_tb0h,  {0x44} op_tb0l,     {0x45} op_tb0hl, {0x46} op_tb0a,     {0x47}
        op_tb1b,  {0x48} op_tb1c,     {0x49} op_tb1d,  {0x4a} op_tb1e,     {0x4b}
        op_tb1h,  {0x4c} op_tb1l,     {0x4d} op_tb1hl, {0x4e} op_tb1a,     {0x4f}
        op_tb2b,  {0x50} op_tb2c,     {0x51} op_tb2d,  {0x52} op_tb2e,     {0x53}
        op_tb2h,  {0x54} op_tb2l,     {0x55} op_tb2hl, {0x56} op_tb2a,     {0x57}
        op_tb3b,  {0x58} op_tb3c,     {0x59} op_tb3d,  {0x5a} op_tb3e,     {0x5b}
        op_tb3h,  {0x5c} op_tb3l,     {0x5d} op_tb3hl, {0x5e} op_tb3a,     {0x5f}
        op_tb4b,  {0x60} op_tb4c,     {0x61} op_tb4d,  {0x62} op_tb4e,     {0x63}
        op_tb4h,  {0x64} op_tb4l,     {0x65} op_tb4hl, {0x66} op_tb4a,     {0x67}
        op_tb5b,  {0x68} op_tb5c,     {0x69} op_tb5d,  {0x6a} op_tb5e,     {0x6b}
        op_tb5h,  {0x6c} op_tb5l,     {0x6d} op_tb5hl, {0x6e} op_tb5a,     {0x6f}
        op_tb6b,  {0x70} op_tb6c,     {0x71} op_tb6d,  {0x72} op_tb6e,     {0x73}
        op_tb6h,  {0x74} op_tb6l,     {0x75} op_tb6hl, {0x76} op_tb6a,     {0x77}
        op_tb7b,  {0x78} op_tb7c,     {0x79} op_tb7d,  {0x7a} op_tb7e,     {0x7b}
        op_tb7h,  {0x7c} op_tb7l,     {0x7d} op_tb7hl, {0x7e} op_tb7a,     {0x7f}
        op_rb0b,  {0x80} op_rb0c,     {0x81} op_rb0d,  {0x82} op_rb0e,     {0x83}
        op_rb0h,  {0x84} op_rb0l,     {0x85} op_rb0hl, {0x86} op_rb0a,     {0x87}
        op_rb1b,  {0x88} op_rb1c,     {0x89} op_rb1d,  {0x8a} op_rb1e,     {0x8b}
        op_rb1h,  {0x8c} op_rb1l,     {0x8d} op_rb1hl, {0x8e} op_rb1a,     {0x8f}
        op_rb2b,  {0x90} op_rb2c,     {0x91} op_rb2d,  {0x92} op_rb2e,     {0x93}
        op_rb2h,  {0x94} op_rb2l,     {0x95} op_rb2hl, {0x96} op_rb2a,     {0x97}
        op_rb3b,  {0x98} op_rb3c,     {0x99} op_rb3d,  {0x9a} op_rb3e,     {0x9b}
        op_rb3h,  {0x9c} op_rb3l,     {0x9d} op_rb3hl, {0x9e} op_rb3a,     {0x9f}
        op_rb4b,  {0xa0} op_rb4c,     {0xa1} op_rb4d,  {0xa2} op_rb4e,     {0xa3}
        op_rb4h,  {0xa4} op_rb4l,     {0xa5} op_rb4hl, {0xa6} op_rb4a,     {0xa7}
        op_rb5b,  {0xa8} op_rb5c,     {0xa9} op_rb5d,  {0xaa} op_rb5e,     {0xab}
        op_rb5h,  {0xac} op_rb5l,     {0xad} op_rb5hl, {0xae} op_rb5a,     {0xaf}
        op_rb6b,  {0xb0} op_rb6c,     {0xb1} op_rb6d,  {0xb2} op_rb6e,     {0xb3}
        op_rb6h,  {0xb4} op_rb6l,     {0xb5} op_rb6hl, {0xb6} op_rb6a,     {0xb7}
        op_rb7b,  {0xb8} op_rb7c,     {0xb9} op_rb7d,  {0xba} op_rb7e,     {0xbb}
        op_rb7h,  {0xbc} op_rb7l,     {0xbd} op_rb7hl, {0xbe} op_rb7a,     {0xbf}
        op_sb0b,  {0xc0} op_sb0c,     {0xc1} op_sb0d,  {0xc2} op_sb0e,     {0xc3}
        op_sb0h,  {0xc4} op_sb0l,     {0xc5} op_sb0hl, {0xc6} op_sb0a,     {0xc7}
        op_sb1b,  {0xc8} op_sb1c,     {0xc9} op_sb1d,  {0xca} op_sb1e,     {0xcb}
        op_sb1h,  {0xcc} op_sb1l,     {0xcd} op_sb1hl, {0xce} op_sb1a,     {0xcf}
        op_sb2b,  {0xd0} op_sb2c,     {0xd1} op_sb2d,  {0xd2} op_sb2e,     {0xd3}
        op_sb2h,  {0xd4} op_sb2l,     {0xd5} op_sb2hl, {0xd6} op_sb2a,     {0xd7}
        op_sb3b,  {0xd8} op_sb3c,     {0xd9} op_sb3d,  {0xda} op_sb3e,     {0xdb}
        op_sb3h,  {0xdc} op_sb3l,     {0xdd} op_sb3hl, {0xde} op_sb3a,     {0xdf}
        op_sb4b,  {0xe0} op_sb4c,     {0xe1} op_sb4d,  {0xe2} op_sb4e,     {0xe3}
        op_sb4h,  {0xe4} op_sb4l,     {0xe5} op_sb4hl, {0xe6} op_sb4a,     {0xe7}
        op_sb5b,  {0xe8} op_sb5c,     {0xe9} op_sb5d,  {0xea} op_sb5e,     {0xeb}
        op_sb5h,  {0xec} op_sb5l,     {0xed} op_sb5hl, {0xee} op_sb5a,     {0xef}
        op_sb6b,  {0xf0} op_sb6c,     {0xf1} op_sb6d,  {0xf2} op_sb6e,     {0xf3}
        op_sb6h,  {0xf4} op_sb6l,     {0xf5} op_sb6hl, {0xf6} op_sb6a,     {0xf7}
        op_sb7b,  {0xf8} op_sb7c,     {0xf9} op_sb7d,  {0xfa} op_sb7e,     {0xfb}
        op_sb7h,  {0xfc} op_sb7l,     {0xfd} op_sb7hl, {0xfe} op_sb7a	   {0xff}
       );
  var op_f : op_func;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin
      op_f := op_cb[Speicher_lesen_Byte(PC)];
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
      op_cb_handel:=t;
{$ENDIF}
end;

begin
end.
