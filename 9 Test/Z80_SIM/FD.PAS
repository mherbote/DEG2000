{$I DEFINE.INC}

unit FD;

interface

uses Varia,FDCB;

function op_fd_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xFD of a multi byte opcode.
}
function trap_fd:Integer; far;
begin
      cpu_error := OPTRAP2;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_fd:=0;
{$ENDIF}
end;

function op_popiy:Integer; far;                                     { POP IY }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      IY := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      IY := IY + (Speicher_lesen_Byte(STACK)*256);
      STACK := STACK + 1;

{$IFDEF WANT_TIM}
      op_popiy:=14;
{$ENDIF}
end;

function op_pusiy:Integer; far;                                    { PUSH IY }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,IY div 256);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,IY AND $00FF);
{$IFDEF WANT_TIM}
      op_pusiy:=15;
{$ENDIF}
end;

function op_jpiy:Integer; far;		                           { JP (IY) }
begin
      PC := IY;
{$IFDEF WANT_TIM}
      op_jpiy:=8;
{$ENDIF}
end;

function op_exspy:Integer; far;	                                { EX (SP),IY }
  var i : Integer;
begin
      i := Speicher_lesen_Byte(STACK)+Speicher_lesen_Byte(STACK+1)*256;
      Speicher_schreiben_Byte(STACK  ,IY AND $00FF);
      Speicher_schreiben_Byte(STACK+1,IY div 256);
      IY:= i;
{$IFDEF WANT_TIM}
      op_exspy:=23;
{$ENDIF}
end;

function op_ldspy:Integer; far;		                          { LD SP,IY }
begin
      STACK := IY;
{$IFDEF WANT_TIM}
      op_ldspy:=10;
{$ENDIF}
end;

function op_ldiynn:Integer; far;		                  { LD IY,nn }
begin
      IY :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      IY := IY+Speicher_lesen_Byte(PC)*256; PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldiynn:=14;
{$ENDIF}
end;

function op_ldiyinn:Integer; far;	                        { LD IY,(nn) }
  var p : Word;
begin
      p  :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      p  := p +Speicher_lesen_Byte(PC)*256; PC := PC + 1;
      IY :=    Speicher_lesen_Byte(p )    ; p  := p  + 1;
      IY := IY+Speicher_lesen_Byte(p )*256;
{$IFDEF WANT_TIM}
      op_ldiyinn:=20;
{$ENDIF}
end;

function op_ldiny:Integer; far;		                        { LD (nn),IY }
  var p : Word;
begin
      p  :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      p  := p +Speicher_lesen_Byte(PC)*256; PC := PC + 1;
      Speicher_schreiben_Byte(p,IY AND $00FF); p:=p+1;
      Speicher_schreiben_Byte(p,IY div 256  );
{$IFDEF WANT_TIM}
      op_ldiny:=20;
{$ENDIF}
end;

function op_adayd:Integer; far;                               { ADD A,(IY+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((A AND $0F) + (P AND $0F) > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (A + P > 255)                     then	F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A + P;
      A := i;
      if (i <  -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128          then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                    then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adayd:=19;
{$ENDIF}
end;

function op_acayd:Integer; far;		                      { ADC A,(IY+d) }
  var i,carry : Integer;
      P       : Byte;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      P := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((A AND $0F) + (P AND $0F) + carry > $0F) then	F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (A + P + carry > 255)                     then	F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A + P + carry;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_acayd:=19;
{$ENDIF}
end;

function op_suayd:Integer; far;		                      { SUB A,(IY+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)	             then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_suayd:=19;
{$ENDIF}
end;

function op_scayd:Integer; far;                               { SBC A,(IY+d) }
  var i,carry : Integer;
      P       : Byte;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      P := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P - carry;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_scayd:=19;
{$ENDIF}
end;

function op_andyd:Integer; far;                                 { AND (IY+d) }
begin
      A := A AND Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR	C_FLAG);
{$IFDEF WANT_TIM}
      op_andyd:=19;
{$ENDIF}
end;

function op_xoryd:Integer; far;                                 { XOR (IY+d) }
begin
 {^}  A := A XOR Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_xoryd:=19;
{$ENDIF}
end;

function op_oryd:Integer; far;                                   { OR (IY+d) }
begin
      A := A OR Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_oryd:=19;
{$ENDIF}
end;

function op_cpyd:Integer; far;                                   { CP (IY+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpyd:=19;
{$ENDIF}
end;

function op_incyd:Integer; far;                                 { INC (IY+d) }
  var p : Word;
begin
      p := IY + Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((Speicher_lesen_Byte(p) AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)+1);
      if (Speicher_lesen_Byte(p)=128)         then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p))=0           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incyd:=23;
{$ENDIF}
end;

function op_decyd:Integer; far;                                 { DEC (IY+d) }
  var p : Word;
begin
      p := IY + Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((Speicher_lesen_Byte(p)-1 AND $0F) = $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)-1);
      if (Speicher_lesen_Byte(p)=127)         then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p))=0           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_decyd:=23;
{$ENDIF}
end;

function op_addyb:Integer; far;                                  { ADD IY,BC }
  var i : LongInt;
begin
      i := IY + (B * 256) + C;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IY := i;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addyb:=15;
{$ENDIF}
end;

function op_addyd:Integer; far;                                  { ADD IY,DE }
  var i : LongInt;
begin
      i := IY + (D * 256) + E;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IY := i;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addyd:=15;
{$ENDIF}
end;

function op_addys:Integer; far;		                         { ADD IY,SP }
  var i : LongInt;
begin
      i  := IY + STACK;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IY := i;
      F  := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addys:=15;
{$ENDIF}
end;

function op_addyy:Integer; far;		                         { ADD IY,IY }
  var i : LongInt;
begin
      i  := IY * 2;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IY := i;
      F  := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addyy:=15;
{$ENDIF}
end;

function op_inciy:Integer; far;		                            { INC IY }
begin
	IY := IY + 1;
{$IFDEF WANT_TIM}
      op_inciy:=10;
{$ENDIF}
end;

function op_deciy:Integer; far;		                            { DEC IY }
begin
	IY := IY - 1;
{$IFDEF WANT_TIM}
      op_deciy:=10;
{$ENDIF}
end;

function op_ldayd:Integer; far;		                       { LD A,(IY+d) }
begin
      A := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldayd:=19;
{$ENDIF}
end;

function op_ldbyd:Integer; far;		                       { LD B,(IY+d) }
begin
      B := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldbyd:=19;
{$ENDIF}
end;

function op_ldcyd:Integer; far;		                       { LD C,(IY+d) }
begin
      C := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldcyd:=19;
{$ENDIF}
end;

function op_lddyd:Integer; far;		                       { LD D,(IY+d) }
begin
      D := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_lddyd:=19;
{$ENDIF}
end;

function op_ldeyd:Integer; far;		                       { LD E,(IY+d) }
begin
      E := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldeyd:=19;
{$ENDIF}
end;

function op_ldhyd:Integer; far;		                       { LD H,(IY+d) }
begin
      H := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldhyd:=19;
{$ENDIF}
end;

function op_ldlyd:Integer; far;		                       { LD L,(IY+d) }
begin
      L := Speicher_lesen_Byte(IY + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldlyd:=19;
{$ENDIF}
end;

function op_ldyda:Integer; far;		                       { LD (IY+d),A }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),A); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldyda:=19;
{$ENDIF}
end;

function op_ldydb:Integer; far;		                       { LD (IY+d),B }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),B); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydb:=19;
{$ENDIF}
end;

function op_ldydc:Integer; far;		                       { LD (IY+d),C }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),C); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydc:=19;
{$ENDIF}
end;

function op_ldydd:Integer; far;		                       { LD (IY+d),D }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),D); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydd:=19;
{$ENDIF}
end;

function op_ldyde:Integer; far;		                       { LD (IY+d),E }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),E); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldyde:=19;
{$ENDIF}
end;

function op_ldydh:Integer; far;		                       { LD (IY+d),H }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),H); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydh:=19;
{$ENDIF}
end;

function op_ldydl:Integer; far;		                       { LD (IY+d),L }
begin
      Speicher_schreiben_Byte(IY + Speicher_lesen_Byte(PC),L); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydl:=19;
{$ENDIF}
end;

function op_ldydn:Integer; far;		                       { LD (IY+d),n }
  var d : Integer;
begin
      d := Speicher_lesen_Byte(PC); PC := PC + 1;
      Speicher_schreiben_Byte(IY+d,Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldydn:=19;
{$ENDIF}
end;

{ Like the function "cpu()" this one emulates multi byte opcodes
  starting with 0xFD
}
function op_fd_handel:Integer;
  const op_fd : Array[0..255] of op_func =
       (trap_fd,  {0x00} trap_fd,     {0x01} trap_fd,  {0x02} trap_fd,     {0x03}
        trap_fd,  {0x04} trap_fd,     {0x05} trap_fd,  {0x06} trap_fd,     {0x07}
        trap_fd,  {0x08} op_addyb,    {0x09} trap_fd,  {0x0a} trap_fd,     {0x0b}
        trap_fd,  {0x0c} trap_fd,     {0x0d} trap_fd,  {0x0e} trap_fd,     {0x0f}
        trap_fd,  {0x10} trap_fd,     {0x11} trap_fd,  {0x12} trap_fd,     {0x13}
        trap_fd,  {0x14} trap_fd,     {0x15} trap_fd,  {0x16} trap_fd,     {0x17}
        trap_fd,  {0x18} op_addyd,    {0x19} trap_fd,  {0x1a} trap_fd,     {0x1b}
        trap_fd,  {0x1c} trap_fd,     {0x1d} trap_fd,  {0x1e} trap_fd,     {0x1f}
        trap_fd,  {0x20} op_ldiynn,   {0x21} op_ldiny, {0x22} op_inciy,    {0x23}
        trap_fd,  {0x24} trap_fd,     {0x25} trap_fd,  {0x26} trap_fd,     {0x27}
        trap_fd,  {0x28} op_addyy,    {0x29} op_ldiyinn,{0x2a}op_deciy,    {0x2b}
        trap_fd,  {0x2c} trap_fd,     {0x2d} trap_fd,  {0x2e} trap_fd,     {0x2f}
        trap_fd,  {0x30} trap_fd,     {0x31} trap_fd,  {0x32} trap_fd,     {0x33}
        op_incyd, {0x34} op_decyd,    {0x35} op_ldydn, {0x36} trap_fd,     {0x37}
        trap_fd,  {0x38} op_addys,    {0x39} trap_fd,  {0x3a} trap_fd,     {0x3b}
        trap_fd,  {0x3c} trap_fd,     {0x3d} trap_fd,  {0x3e} trap_fd,     {0x3f}
        trap_fd,  {0x40} trap_fd,     {0x41} trap_fd,  {0x42} trap_fd,     {0x43}
        trap_fd,  {0x44} trap_fd,     {0x45} op_ldbyd, {0x46} trap_fd,     {0x47}
        trap_fd,  {0x48} trap_fd,     {0x49} trap_fd,  {0x4a} trap_fd,     {0x4b}
        trap_fd,  {0x4c} trap_fd,     {0x4d} op_ldcyd, {0x4e} trap_fd,     {0x4f}
        trap_fd,  {0x50} trap_fd,     {0x51} trap_fd,  {0x52} trap_fd,     {0x53}
        trap_fd,  {0x54} trap_fd,     {0x55} op_lddyd, {0x56} trap_fd,     {0x57}
        trap_fd,  {0x58} trap_fd,     {0x59} trap_fd,  {0x5a} trap_fd,     {0x5b}
        trap_fd,  {0x5c} trap_fd,     {0x5d} op_ldeyd, {0x5e} trap_fd,     {0x5f}
        trap_fd,  {0x60} trap_fd,     {0x61} trap_fd,  {0x62} trap_fd,     {0x63}
        trap_fd,  {0x64} trap_fd,     {0x65} op_ldhyd, {0x66} trap_fd,     {0x67}
        trap_fd,  {0x68} trap_fd,     {0x69} trap_fd,  {0x6a} trap_fd,     {0x6b}
        trap_fd,  {0x6c} trap_fd,     {0x6d} op_ldlyd, {0x6e} trap_fd,     {0x6f}
        op_ldydb, {0x70} op_ldydc,    {0x71} op_ldydd, {0x72} op_ldyde,    {0x73}
        op_ldydh, {0x74} op_ldydl,    {0x75} trap_fd,  {0x76} op_ldyda,    {0x77}
        trap_fd,  {0x78} trap_fd,     {0x79} trap_fd,  {0x7a} trap_fd,     {0x7b}
        trap_fd,  {0x7c} trap_fd,     {0x7d} op_ldayd, {0x7e} trap_fd,     {0x7f}
        trap_fd,  {0x80} trap_fd,     {0x81} trap_fd,  {0x82} trap_fd,     {0x83}
        trap_fd,  {0x84} trap_fd,     {0x85} op_adayd, {0x86} trap_fd,     {0x87}
        trap_fd,  {0x88} trap_fd,     {0x89} trap_fd,  {0x8a} trap_fd,     {0x8b}
        trap_fd,  {0x8c} trap_fd,     {0x8d} op_acayd, {0x8e} trap_fd,     {0x8f}
        trap_fd,  {0x90} trap_fd,     {0x91} trap_fd,  {0x92} trap_fd,     {0x93}
        trap_fd,  {0x94} trap_fd,     {0x95} op_suayd, {0x96} trap_fd,     {0x97}
        trap_fd,  {0x98} trap_fd,     {0x99} trap_fd,  {0x9a} trap_fd,     {0x9b}
        trap_fd,  {0x9c} trap_fd,     {0x9d} op_scayd, {0x9e} trap_fd,     {0x9f}
        trap_fd,  {0xa0} trap_fd,     {0xa1} trap_fd,  {0xa2} trap_fd,     {0xa3}
        trap_fd,  {0xa4} trap_fd,     {0xa5} op_andyd, {0xa6} trap_fd,     {0xa7}
        trap_fd,  {0xa8} trap_fd,     {0xa9} trap_fd,  {0xaa} trap_fd,     {0xab}
        trap_fd,  {0xac} trap_fd,     {0xad} op_xoryd, {0xae} trap_fd,     {0xaf}
        trap_fd,  {0xb0} trap_fd,     {0xb1} trap_fd,  {0xb2} trap_fd,     {0xb3}
        trap_fd,  {0xb4} trap_fd,     {0xb5} op_oryd,  {0xb6} trap_fd,     {0xb7}
        trap_fd,  {0xb8} trap_fd,     {0xb9} trap_fd,  {0xba} trap_fd,     {0xbb}
        trap_fd,  {0xbc} trap_fd,     {0xbd} op_cpyd,  {0xbe} trap_fd,     {0xbf}
        trap_fd,  {0xc0} trap_fd,     {0xc1} trap_fd,  {0xc2} trap_fd,     {0xc3}
        trap_fd,  {0xc4} trap_fd,     {0xc5} trap_fd,  {0xc6} trap_fd,     {0xc7}
        trap_fd,  {0xc8} trap_fd,     {0xc9} trap_fd,  {0xca} op_fdcb_handel,{0xcb}
        trap_fd,  {0xcc} trap_fd,     {0xcd} trap_fd,  {0xce} trap_fd,     {0xcf}
        trap_fd,  {0xd0} trap_fd,     {0xd1} trap_fd,  {0xd2} trap_fd,     {0xd3}
        trap_fd,  {0xd4} trap_fd,     {0xd5} trap_fd,  {0xd6} trap_fd,     {0xd7}
        trap_fd,  {0xd8} trap_fd,     {0xd9} trap_fd,  {0xda} trap_fd,     {0xdb}
        trap_fd,  {0xdc} trap_fd,     {0xdd} trap_fd,  {0xde} trap_fd,     {0xdf}
        trap_fd,  {0xe0} op_popiy,    {0xe1} trap_fd,  {0xe2} op_exspy,    {0xe3}
        trap_fd,  {0xe4} op_pusiy,    {0xe5} trap_fd,  {0xe6} trap_fd,     {0xe7}
        trap_fd,  {0xe8} op_jpiy,     {0xe9} trap_fd,  {0xea} trap_fd,     {0xeb}
        trap_fd,  {0xec} trap_fd,     {0xed} trap_fd,  {0xee} trap_fd,     {0xef}
        trap_fd,  {0xf0} trap_fd,     {0xf1} trap_fd,  {0xf2} trap_fd,     {0xf3}
        trap_fd,  {0xf4} trap_fd,     {0xf5} trap_fd,  {0xf6} trap_fd,     {0xf7}
        trap_fd,  {0xf8} op_ldspy,    {0xf9} trap_fd,  {0xfa} trap_fd,     {0xfb}
        trap_fd,  {0xfc} trap_fd,     {0xfd} trap_fd,  {0xfe} trap_fd	   {0xff}
       );
  var op_f : op_func;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin
      op_f := op_fd[Speicher_lesen_Byte(PC)];
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
      op_fd_handel:=t;
{$ENDIF}
end;

begin
end.
