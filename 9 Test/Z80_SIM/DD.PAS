{$I DEFINE.INC}

unit DD;

interface

uses Varia,DDCB;

function op_dd_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xDD of a multi byte opcode.
}
function trap_dd:Integer; far;
begin
      cpu_error := OPTRAP2;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_dd:=0;
{$ENDIF}
end;

function op_popix:Integer; far;                                     { POP IX }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      IX := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      IX := IX + (Speicher_lesen_Byte(STACK)*256);
      STACK := STACK + 1;

{$IFDEF WANT_TIM}
      op_popix:=14;
{$ENDIF}
end;

function op_pusix:Integer; far;                                    { PUSH IX }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,IX div 256);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,IX AND $00FF);
{$IFDEF WANT_TIM}
      op_pusix:=15;
{$ENDIF}
end;

function op_jpix:Integer; far;		                           { JP (IX) }
begin
      PC := IX;
{$IFDEF WANT_TIM}
      op_jpix:=8;
{$ENDIF}
end;

function op_exspx:Integer; far;	                                { EX (SP),IX }
  var i : Integer;
begin
      i := Speicher_lesen_Byte(STACK)+Speicher_lesen_Byte(STACK+1)*256;
      Speicher_schreiben_Byte(STACK  ,IX AND $00FF);
      Speicher_schreiben_Byte(STACK+1,IX div 256);
      IX:= i;
{$IFDEF WANT_TIM}
      op_exspx:=23;
{$ENDIF}
end;

function op_ldspx:Integer; far;		                          { LD SP,IX }
begin
      STACK := IX;
{$IFDEF WANT_TIM}
      op_ldspx:=10;
{$ENDIF}
end;

function op_ldixnn:Integer; far;		                  { LD IX,nn }
begin
      IX :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      IX := IX+Speicher_lesen_Byte(PC)*256; PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldixnn:=14;
{$ENDIF}
end;

function op_ldixinn:Integer; far;	                        { LD IX,(nn) }
  var p : Word;
begin
      p  :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      p  := p +Speicher_lesen_Byte(PC)*256; PC := PC + 1;
      IX :=    Speicher_lesen_Byte(p )    ; p  := p  + 1;
      IX := IX+Speicher_lesen_Byte(p )*256;
{$IFDEF WANT_TIM}
      op_ldixinn:=20;
{$ENDIF}
end;

function op_ldinx:Integer; far;		                        { LD (nn),IX }
  var p : Word;
begin
      p  :=    Speicher_lesen_Byte(PC)    ; PC := PC + 1;
      p  := p +Speicher_lesen_Byte(PC)*256; PC := PC + 1;
      Speicher_schreiben_Byte(p,IX AND $00FF); p:=p+1;
      Speicher_schreiben_Byte(p,IX div 256  );
{$IFDEF WANT_TIM}
      op_ldinx:=20;
{$ENDIF}
end;

function op_adaxd:Integer; far;                               { ADD A,(IX+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((A AND $0F) + (P AND $0F) > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (A + P > 255)                     then	F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A + P;
      A := i;
      if (i <  -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128          then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                    then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adaxd:=19;
{$ENDIF}
end;

function op_acaxd:Integer; far;		                      { ADC A,(IX+d) }
  var i,carry : Integer;
      P       : Byte;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      P := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((A AND $0F) + (P AND $0F) + carry > $0F) then	F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (A + P + carry > 255)                     then	F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A + P + carry;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_acaxd:=19;
{$ENDIF}
end;

function op_suaxd:Integer; far;		                      { SUB A,(IX+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)	             then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_suaxd:=19;
{$ENDIF}
end;

function op_scaxd:Integer; far;                               { SBC A,(IX+d) }
  var i,carry : Integer;
      P       : Byte;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      P := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P - carry;
      A := i;
      if (i < -128) OR (i > 127) then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128         then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                   then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_scaxd:=19;
{$ENDIF}
end;

function op_andxd:Integer; far;                                 { AND (IX+d) }
begin
      A := A AND Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR	C_FLAG);
{$IFDEF WANT_TIM}
      op_andxd:=19;
{$ENDIF}
end;

function op_xorxd:Integer; far;                                 { XOR (IX+d) }
begin
 {^}  A := A XOR Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_xorxd:=19;
{$ENDIF}
end;

function op_orxd:Integer; far;                                   { OR (IX+d) }
begin
      A := A OR Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if (A AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (parrity[A]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_orxd:=19;
{$ENDIF}
end;

function op_cpxd:Integer; far;                                   { CP (IX+d) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND 128)=128             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpxd:=19;
{$ENDIF}
end;

function op_incxd:Integer; far;                                 { INC (IX+d) }
  var p : Word;
begin
      p := IX + Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((Speicher_lesen_Byte(p) AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)+1);
      if (Speicher_lesen_Byte(p)=128)         then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p))=0           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incxd:=23;
{$ENDIF}
end;

function op_decxd:Integer; far;                                 { DEC (IX+d) }
  var p : Word;
begin
      p := IX + Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((Speicher_lesen_Byte(p)-1 AND $0F) = $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)-1);
      if (Speicher_lesen_Byte(p)=127)         then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND 128)=128 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p))=0           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_decxd:=23;
{$ENDIF}
end;

function op_addxb:Integer; far;                                  { ADD IX,BC }
  var i : LongInt;
begin
      i := IX + (B * 256) + C;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IX := i;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addxb:=15;
{$ENDIF}
end;

function op_addxd:Integer; far;                                  { ADD IX,DE }
  var i : LongInt;
begin
      i := IX + (D * 256) + E;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IX := i;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addxd:=15;
{$ENDIF}
end;

function op_addxs:Integer; far;		                         { ADD IX,SP }
  var i : LongInt;
begin
      i  := IX + STACK;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IX := i;
      F  := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addxs:=15;
{$ENDIF}
end;

function op_addxx:Integer; far;		                         { ADD IX,IX }
  var i : LongInt;
begin
      i  := IX * 2;
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      IX := i;
      F  := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addxx:=15;
{$ENDIF}
end;

function op_incix:Integer; far;		                            { INC IX }
begin
	IX := IX + 1;
{$IFDEF WANT_TIM}
      op_incix:=10;
{$ENDIF}
end;

function op_decix:Integer; far;		                            { DEC IX }
begin
	IX := IX - 1;
{$IFDEF WANT_TIM}
      op_decix:=10;
{$ENDIF}
end;

function op_ldaxd:Integer; far;		                       { LD A,(IX+d) }
begin
      A := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldaxd:=19;
{$ENDIF}
end;

function op_ldbxd:Integer; far;		                       { LD B,(IX+d) }
begin
      B := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldbxd:=19;
{$ENDIF}
end;

function op_ldcxd:Integer; far;		                       { LD C,(IX+d) }
begin
      C := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldcxd:=19;
{$ENDIF}
end;

function op_lddxd:Integer; far;		                       { LD D,(IX+d) }
begin
      D := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_lddxd:=19;
{$ENDIF}
end;

function op_ldexd:Integer; far;		                       { LD E,(IX+d) }
begin
      E := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldexd:=19;
{$ENDIF}
end;

function op_ldhxd:Integer; far;		                       { LD H,(IX+d) }
begin
      H := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldhxd:=19;
{$ENDIF}
end;

function op_ldlxd:Integer; far;		                       { LD L,(IX+d) }
begin
      L := Speicher_lesen_Byte(IX + Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldlxd:=19;
{$ENDIF}
end;

function op_ldxda:Integer; far;		                       { LD (IX+d),A }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),A); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxda:=19;
{$ENDIF}
end;

function op_ldxdb:Integer; far;		                       { LD (IX+d),B }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),B); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdb:=19;
{$ENDIF}
end;

function op_ldxdc:Integer; far;		                       { LD (IX+d),C }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),C); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdc:=19;
{$ENDIF}
end;

function op_ldxdd:Integer; far;		                       { LD (IX+d),D }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),D); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdd:=19;
{$ENDIF}
end;

function op_ldxde:Integer; far;		                       { LD (IX+d),E }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),E); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxde:=19;
{$ENDIF}
end;

function op_ldxdh:Integer; far;		                       { LD (IX+d),H }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),H); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdh:=19;
{$ENDIF}
end;

function op_ldxdl:Integer; far;		                       { LD (IX+d),L }
begin
      Speicher_schreiben_Byte(IX + Speicher_lesen_Byte(PC),L); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdl:=19;
{$ENDIF}
end;

function op_ldxdn:Integer; far;		                       { LD (IX+d),n }
  var d : Integer;
begin
      d := Speicher_lesen_Byte(PC); PC := PC + 1;
      Speicher_schreiben_Byte(IX+d,Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldxdn:=19;
{$ENDIF}
end;

{ Like the function "cpu()" this one emulates multi byte opcodes
  starting with 0xDD
}
function op_dd_handel:Integer;
  const op_dd : Array[0..255] of op_func =
       (trap_dd,  {0x00} trap_dd,     {0x01} trap_dd,  {0x02} trap_dd,     {0x03}
        trap_dd,  {0x04} trap_dd,     {0x05} trap_dd,  {0x06} trap_dd,     {0x07}
        trap_dd,  {0x08} op_addxb,    {0x09} trap_dd,  {0x0a} trap_dd,     {0x0b}
        trap_dd,  {0x0c} trap_dd,     {0x0d} trap_dd,  {0x0e} trap_dd,     {0x0f}
        trap_dd,  {0x10} trap_dd,     {0x11} trap_dd,  {0x12} trap_dd,     {0x13}
        trap_dd,  {0x14} trap_dd,     {0x15} trap_dd,  {0x16} trap_dd,     {0x17}
        trap_dd,  {0x18} op_addxd,    {0x19} trap_dd,  {0x1a} trap_dd,     {0x1b}
        trap_dd,  {0x1c} trap_dd,     {0x1d} trap_dd,  {0x1e} trap_dd,     {0x1f}
        trap_dd,  {0x20} op_ldixnn,   {0x21} op_ldinx, {0x22} op_incix,    {0x23}
        trap_dd,  {0x24} trap_dd,     {0x25} trap_dd,  {0x26} trap_dd,     {0x27}
        trap_dd,  {0x28} op_addxx,    {0x29} op_ldixinn,{0x2a}op_decix,    {0x2b}
        trap_dd,  {0x2c} trap_dd,     {0x2d} trap_dd,  {0x2e} trap_dd,     {0x2f}
        trap_dd,  {0x30} trap_dd,     {0x31} trap_dd,  {0x32} trap_dd,     {0x33}
        op_incxd, {0x34} op_decxd,    {0x35} op_ldxdn, {0x36} trap_dd,     {0x37}
        trap_dd,  {0x38} op_addxs,    {0x39} trap_dd,  {0x3a} trap_dd,     {0x3b}
        trap_dd,  {0x3c} trap_dd,     {0x3d} trap_dd,  {0x3e} trap_dd,     {0x3f}
        trap_dd,  {0x40} trap_dd,     {0x41} trap_dd,  {0x42} trap_dd,     {0x43}
        trap_dd,  {0x44} trap_dd,     {0x45} op_ldbxd, {0x46} trap_dd,     {0x47}
        trap_dd,  {0x48} trap_dd,     {0x49} trap_dd,  {0x4a} trap_dd,     {0x4b}
        trap_dd,  {0x4c} trap_dd,     {0x4d} op_ldcxd, {0x4e} trap_dd,     {0x4f}
        trap_dd,  {0x50} trap_dd,     {0x51} trap_dd,  {0x52} trap_dd,     {0x53}
        trap_dd,  {0x54} trap_dd,     {0x55} op_lddxd, {0x56} trap_dd,     {0x57}
        trap_dd,  {0x58} trap_dd,     {0x59} trap_dd,  {0x5a} trap_dd,     {0x5b}
        trap_dd,  {0x5c} trap_dd,     {0x5d} op_ldexd, {0x5e} trap_dd,     {0x5f}
        trap_dd,  {0x60} trap_dd,     {0x61} trap_dd,  {0x62} trap_dd,     {0x63}
        trap_dd,  {0x64} trap_dd,     {0x65} op_ldhxd, {0x66} trap_dd,     {0x67}
        trap_dd,  {0x68} trap_dd,     {0x69} trap_dd,  {0x6a} trap_dd,     {0x6b}
        trap_dd,  {0x6c} trap_dd,     {0x6d} op_ldlxd, {0x6e} trap_dd,     {0x6f}
        op_ldxdb, {0x70} op_ldxdc,    {0x71} op_ldxdd, {0x72} op_ldxde,    {0x73}
        op_ldxdh, {0x74} op_ldxdl,    {0x75} trap_dd,  {0x76} op_ldxda,    {0x77}
        trap_dd,  {0x78} trap_dd,     {0x79} trap_dd,  {0x7a} trap_dd,     {0x7b}
        trap_dd,  {0x7c} trap_dd,     {0x7d} op_ldaxd, {0x7e} trap_dd,     {0x7f}
        trap_dd,  {0x80} trap_dd,     {0x81} trap_dd,  {0x82} trap_dd,     {0x83}
        trap_dd,  {0x84} trap_dd,     {0x85} op_adaxd, {0x86} trap_dd,     {0x87}
        trap_dd,  {0x88} trap_dd,     {0x89} trap_dd,  {0x8a} trap_dd,     {0x8b}
        trap_dd,  {0x8c} trap_dd,     {0x8d} op_acaxd, {0x8e} trap_dd,     {0x8f}
        trap_dd,  {0x90} trap_dd,     {0x91} trap_dd,  {0x92} trap_dd,     {0x93}
        trap_dd,  {0x94} trap_dd,     {0x95} op_suaxd, {0x96} trap_dd,     {0x97}
        trap_dd,  {0x98} trap_dd,     {0x99} trap_dd,  {0x9a} trap_dd,     {0x9b}
        trap_dd,  {0x9c} trap_dd,     {0x9d} op_scaxd, {0x9e} trap_dd,     {0x9f}
        trap_dd,  {0xa0} trap_dd,     {0xa1} trap_dd,  {0xa2} trap_dd,     {0xa3}
        trap_dd,  {0xa4} trap_dd,     {0xa5} op_andxd, {0xa6} trap_dd,     {0xa7}
        trap_dd,  {0xa8} trap_dd,     {0xa9} trap_dd,  {0xaa} trap_dd,     {0xab}
        trap_dd,  {0xac} trap_dd,     {0xad} op_xorxd, {0xae} trap_dd,     {0xaf}
        trap_dd,  {0xb0} trap_dd,     {0xb1} trap_dd,  {0xb2} trap_dd,     {0xb3}
        trap_dd,  {0xb4} trap_dd,     {0xb5} op_orxd,  {0xb6} trap_dd,     {0xb7}
        trap_dd,  {0xb8} trap_dd,     {0xb9} trap_dd,  {0xba} trap_dd,     {0xbb}
        trap_dd,  {0xbc} trap_dd,     {0xbd} op_cpxd,  {0xbe} trap_dd,     {0xbf}
        trap_dd,  {0xc0} trap_dd,     {0xc1} trap_dd,  {0xc2} trap_dd,     {0xc3}
        trap_dd,  {0xc4} trap_dd,     {0xc5} trap_dd,  {0xc6} trap_dd,     {0xc7}
        trap_dd,  {0xc8} trap_dd,     {0xc9} trap_dd,  {0xca} op_ddcb_handel,{0xcb}
        trap_dd,  {0xcc} trap_dd,     {0xcd} trap_dd,  {0xce} trap_dd,     {0xcf}
        trap_dd,  {0xd0} trap_dd,     {0xd1} trap_dd,  {0xd2} trap_dd,     {0xd3}
        trap_dd,  {0xd4} trap_dd,     {0xd5} trap_dd,  {0xd6} trap_dd,     {0xd7}
        trap_dd,  {0xd8} trap_dd,     {0xd9} trap_dd,  {0xda} trap_dd,     {0xdb}
        trap_dd,  {0xdc} trap_dd,     {0xdd} trap_dd,  {0xde} trap_dd,     {0xdf}
        trap_dd,  {0xe0} op_popix,    {0xe1} trap_dd,  {0xe2} op_exspx,    {0xe3}
        trap_dd,  {0xe4} op_pusix,    {0xe5} trap_dd,  {0xe6} trap_dd,     {0xe7}
        trap_dd,  {0xe8} op_jpix,     {0xe9} trap_dd,  {0xea} trap_dd,     {0xeb}
        trap_dd,  {0xec} trap_dd,     {0xed} trap_dd,  {0xee} trap_dd,     {0xef}
        trap_dd,  {0xf0} trap_dd,     {0xf1} trap_dd,  {0xf2} trap_dd,     {0xf3}
        trap_dd,  {0xf4} trap_dd,     {0xf5} trap_dd,  {0xf6} trap_dd,     {0xf7}
        trap_dd,  {0xf8} op_ldspx,    {0xf9} trap_dd,  {0xfa} trap_dd,     {0xfb}
        trap_dd,  {0xfc} trap_dd,     {0xfd} trap_dd,  {0xfe} trap_dd	   {0xff}
       );
  var op_f : op_func;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin
      op_f := op_dd[Speicher_lesen_Byte(PC)];
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
      op_dd_handel:=t;
{$ENDIF}
end;

begin
end.
