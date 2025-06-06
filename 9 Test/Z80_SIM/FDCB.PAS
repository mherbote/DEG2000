{$I DEFINE.INC}

unit FDCB;

interface

uses Varia;

function op_fdcb_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xFD 0xCB of a 4 byte opcode.
}
function trap_fdcb(data:Integer):Integer; far;
begin
      cpu_error := OPTRAP4;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_fdcb:=0;
{$ENDIF}
end;

function op_tb0iyd(data:Integer):Integer; far;                { BIT 0,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 1)=1)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0iyd:=20;
{$ENDIF}
end;

function op_tb1iyd(data:Integer):Integer; far;                { BIT 1,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 2)=2)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1iyd:=20;
{$ENDIF}
end;

function op_tb2iyd(data:Integer):Integer; far;	              { BIT 2,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 4)=4)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2iyd:=20;
{$ENDIF}
end;

function op_tb3iyd(data:Integer):Integer; far;	              { BIT 3,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 8)=8)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3iyd:=20;
{$ENDIF}
end;

function op_tb4iyd(data:Integer):Integer; far;	              { BIT 4,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 16)=16)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4iyd:=20;
{$ENDIF}
end;

function op_tb5iyd(data:Integer):Integer; far;	              { BIT 5,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 32)=32)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5iyd:=20;
{$ENDIF}
end;

function op_tb6iyd(data:Integer):Integer; far;	              { BIT 6,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 64)=64)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6iyd:=20;
{$ENDIF}
end;

function op_tb7iyd(data:Integer):Integer; far;	              { BIT 7,(IY+d) }
begin
      F := F AND N_FLAG;
      F := F OR  H_FLAG;
      if ((Speicher_lesen_Byte(IY+data) AND 128)=128)
         then F := F AND Z_FLAG
         else F := F OR  Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7iyd:=20;
{$ENDIF}
end;

function op_rb0iyd(data:Integer):Integer; far;                { RES 0,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $FE));
{$IFDEF WANT_TIM}
      op_rb0iyd:=23;
{$ENDIF}
end;

function op_rb1iyd(data:Integer):Integer; far;                { RES 1,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $FD));
{$IFDEF WANT_TIM}
      op_rb1iyd:=23;
{$ENDIF}
end;

function op_rb2iyd(data:Integer):Integer; far;                { RES 2,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $FB));
{$IFDEF WANT_TIM}
      op_rb2iyd:=23;
{$ENDIF}
end;

function op_rb3iyd(data:Integer):Integer; far;                { RES 3,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $F7));
{$IFDEF WANT_TIM}
      op_rb3iyd:=23;
{$ENDIF}
end;

function op_rb4iyd(data:Integer):Integer; far;                { RES 4,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $EF));
{$IFDEF WANT_TIM}
      op_rb4iyd:=23;
{$ENDIF}
end;

function op_rb5iyd(data:Integer):Integer; far;                { RES 5,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $DF));
{$IFDEF WANT_TIM}
      op_rb5iyd:=23;
{$ENDIF}
end;

function op_rb6iyd(data:Integer):Integer; far;                { RES 6,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $BF));
{$IFDEF WANT_TIM}
      op_rb6iyd:=23;
{$ENDIF}
end;

function op_rb7iyd(data:Integer):Integer; far;                { RES 7,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) AND $7F));
{$IFDEF WANT_TIM}
      op_rb7iyd:=23;
{$ENDIF}
end;

function op_sb0iyd(data:Integer):Integer; far;                { SET 0,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $01));
{$IFDEF WANT_TIM}
      op_sb0iyd:=23;
{$ENDIF}
end;

function op_sb1iyd(data:Integer):Integer; far;                { SET 1,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $02));
{$IFDEF WANT_TIM}
      op_sb1iyd:=23;
{$ENDIF}
end;

function op_sb2iyd(data:Integer):Integer; far;                { SET 2,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $04));
{$IFDEF WANT_TIM}
      op_sb2iyd:=23;
{$ENDIF}
end;

function op_sb3iyd(data:Integer):Integer; far;                { SET 3,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $08));
{$IFDEF WANT_TIM}
      op_sb3iyd:=23;
{$ENDIF}
end;

function op_sb4iyd(data:Integer):Integer; far;                { SET 4,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $10));
{$IFDEF WANT_TIM}
      op_sb4iyd:=23;
{$ENDIF}
end;

function op_sb5iyd(data:Integer):Integer; far;                { SET 5,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $20));
{$IFDEF WANT_TIM}
      op_sb5iyd:=23;
{$ENDIF}
end;

function op_sb6iyd(data:Integer):Integer; far;                { SET 6,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $40));
{$IFDEF WANT_TIM}
      op_sb6iyd:=23;
{$ENDIF}
end;

function op_sb7iyd(data:Integer):Integer; far;                { SET 7,(IY+d) }
begin
      Speicher_schreiben_Byte(IY+data,(Speicher_lesen_Byte(IY+data) OR $80));
{$IFDEF WANT_TIM}
      op_sb7iyd:=23;
{$ENDIF}
end;

function op_rlciyd(data:Integer):Integer; far;                  { RLC (IY+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      i := p AND $80;
      if (i=$80) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      if (i=$80) then p := p AND $01;
      Speicher_schreiben_Byte(IY+data,p);
      if (p=0)           then F := F OR      Z_FLAG else F := F AND NOT Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlciyd:=23;
{$ENDIF}
end;

function op_rrciyd(data:Integer):Integer; far;                  { RRC (IY+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      i := p AND $01;
      if (i=$01) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      if (i=$01) then p := p AND $80;
      Speicher_schreiben_Byte(IY+data,p);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrciyd:=23;
{$ENDIF}
end;

function op_rliyd(data:Integer):Integer; far;                    { RL (IY+d) }
  var old_c_flag : Integer;
      p          : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      old_c_flag := F AND C_FLAG;
      if (p AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      if (old_c_flag=1) then p := p OR 1;
      Speicher_schreiben_Byte(IY+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rliyd:=23;
{$ENDIF}
end;

function op_rriyd(data:Integer):Integer; far;                    { RR (IY+d) }
  var old_c_flag : Integer;
      p          : Byte;
begin
      old_c_flag := F AND C_FLAG;
      p := Speicher_lesen_Byte(IY+data);
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      if (old_c_flag=1) then p := p OR $80;
      Speicher_schreiben_Byte(IY+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR 	   S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rriyd:=23;
{$ENDIF}
end;

function op_slaiyd(data:Integer):Integer; far;	                { SLA (IY+d) }
  var p : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      if (p AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      Speicher_schreiben_Byte(IY+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slaiyd:=23;
{$ENDIF}
end;

function op_sraiyd(data:Integer):Integer; far;	                { SRA (IY+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      i := p AND $80;
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      p := p OR  i;
      Speicher_schreiben_Byte(IY+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_sraiyd:=23;
{$ENDIF}
end;

function op_srliyd(data:Integer):Integer; far;	                { SRL (IY+d) }
  var p : Byte;
begin
      p := Speicher_lesen_Byte(IY+data);
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      Speicher_schreiben_Byte(IY+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srliyd:=23;
{$ENDIF}
end;

{ Like the function "cpu()" this one emulates 4 byte opcodes
  starting with 0xFD 0xCB
}
function op_fdcb_handel:Integer;
  const op_fdcb : Array[0..255] of op_funcp =
       (trap_fdcb,{0x00} trap_fdcb,   {0x01} trap_fdcb,{0x02} trap_fdcb,   {0x03}
        trap_fdcb,{0x04} trap_fdcb,   {0x05} op_rlciyd,{0x06} trap_fdcb,   {0x07}
        trap_fdcb,{0x08} trap_fdcb,   {0x09} trap_fdcb,{0x0a} trap_fdcb,   {0x0b}
        trap_fdcb,{0x0c} trap_fdcb,   {0x0d} op_rrciyd,{0x0e} trap_fdcb,   {0x0f}
        trap_fdcb,{0x10} trap_fdcb,   {0x11} trap_fdcb,{0x12} trap_fdcb,   {0x13}
        trap_fdcb,{0x14} trap_fdcb,   {0x15} op_rliyd, {0x16} trap_fdcb,   {0x17}
        trap_fdcb,{0x18} trap_fdcb,   {0x19} trap_fdcb,{0x1a} trap_fdcb,   {0x1b}
        trap_fdcb,{0x1c} trap_fdcb,   {0x1d} op_rriyd, {0x1e} trap_fdcb,   {0x1f}
        trap_fdcb,{0x20} trap_fdcb,   {0x21} trap_fdcb,{0x22} trap_fdcb,   {0x23}
        trap_fdcb,{0x24} trap_fdcb,   {0x25} op_slaiyd,{0x26} trap_fdcb,   {0x27}
        trap_fdcb,{0x28} trap_fdcb,   {0x29} trap_fdcb,{0x2a} trap_fdcb,   {0x2b}
        trap_fdcb,{0x2c} trap_fdcb,   {0x2d} op_sraiyd,{0x2e} trap_fdcb,   {0x2f}
        trap_fdcb,{0x30} trap_fdcb,   {0x31} trap_fdcb,{0x32} trap_fdcb,   {0x33}
        trap_fdcb,{0x34} trap_fdcb,   {0x35} trap_fdcb,{0x36} trap_fdcb,   {0x37}
        trap_fdcb,{0x38} trap_fdcb,   {0x39} trap_fdcb,{0x3a} trap_fdcb,   {0x3b}
        trap_fdcb,{0x3c} trap_fdcb,   {0x3d} op_srliyd,{0x3e} trap_fdcb,   {0x3f}
        trap_fdcb,{0x40} trap_fdcb,   {0x41} trap_fdcb,{0x42} trap_fdcb,   {0x43}
        trap_fdcb,{0x44} trap_fdcb,   {0x45} op_tb0iyd,{0x46} trap_fdcb,   {0x47}
        trap_fdcb,{0x48} trap_fdcb,   {0x49} trap_fdcb,{0x4a} trap_fdcb,   {0x4b}
        trap_fdcb,{0x4c} trap_fdcb,   {0x4d} op_tb1iyd,{0x4e} trap_fdcb,   {0x4f}
        trap_fdcb,{0x50} trap_fdcb,   {0x51} trap_fdcb,{0x52} trap_fdcb,   {0x53}
        trap_fdcb,{0x54} trap_fdcb,   {0x55} op_tb2iyd,{0x56} trap_fdcb,   {0x57}
        trap_fdcb,{0x58} trap_fdcb,   {0x59} trap_fdcb,{0x5a} trap_fdcb,   {0x5b}
        trap_fdcb,{0x5c} trap_fdcb,   {0x5d} op_tb3iyd,{0x5e} trap_fdcb,   {0x5f}
        trap_fdcb,{0x60} trap_fdcb,   {0x61} trap_fdcb,{0x62} trap_fdcb,   {0x63}
        trap_fdcb,{0x64} trap_fdcb,   {0x65} op_tb4iyd,{0x66} trap_fdcb,   {0x67}
        trap_fdcb,{0x68} trap_fdcb,   {0x69} trap_fdcb,{0x6a} trap_fdcb,   {0x6b}
        trap_fdcb,{0x6c} trap_fdcb,   {0x6d} op_tb5iyd,{0x6e} trap_fdcb,   {0x6f}
        trap_fdcb,{0x70} trap_fdcb,   {0x71} trap_fdcb,{0x72} trap_fdcb,   {0x73}
        trap_fdcb,{0x74} trap_fdcb,   {0x75} op_tb6iyd,{0x76} trap_fdcb,   {0x77}
        trap_fdcb,{0x78} trap_fdcb,   {0x79} trap_fdcb,{0x7a} trap_fdcb,   {0x7b}
        trap_fdcb,{0x7c} trap_fdcb,   {0x7d} op_tb7iyd,{0x7e} trap_fdcb,   {0x7f}
        trap_fdcb,{0x80} trap_fdcb,   {0x81} trap_fdcb,{0x82} trap_fdcb,   {0x83}
        trap_fdcb,{0x84} trap_fdcb,   {0x85} op_rb0iyd,{0x86} trap_fdcb,   {0x87}
        trap_fdcb,{0x88} trap_fdcb,   {0x89} trap_fdcb,{0x8a} trap_fdcb,   {0x8b}
        trap_fdcb,{0x8c} trap_fdcb,   {0x8d} op_rb1iyd,{0x8e} trap_fdcb,   {0x8f}
        trap_fdcb,{0x90} trap_fdcb,   {0x91} trap_fdcb,{0x92} trap_fdcb,   {0x93}
        trap_fdcb,{0x94} trap_fdcb,   {0x95} op_rb2iyd,{0x96} trap_fdcb,   {0x97}
        trap_fdcb,{0x98} trap_fdcb,   {0x99} trap_fdcb,{0x9a} trap_fdcb,   {0x9b}
        trap_fdcb,{0x9c} trap_fdcb,   {0x9d} op_rb3iyd,{0x9e} trap_fdcb,   {0x9f}
        trap_fdcb,{0xa0} trap_fdcb,   {0xa1} trap_fdcb,{0xa2} trap_fdcb,   {0xa3}
        trap_fdcb,{0xa4} trap_fdcb,   {0xa5} op_rb4iyd,{0xa6} trap_fdcb,   {0xa7}
        trap_fdcb,{0xa8} trap_fdcb,   {0xa9} trap_fdcb,{0xaa} trap_fdcb,   {0xab}
        trap_fdcb,{0xac} trap_fdcb,   {0xad} op_rb5iyd,{0xae} trap_fdcb,   {0xaf}
        trap_fdcb,{0xb0} trap_fdcb,   {0xb1} trap_fdcb,{0xb2} trap_fdcb,   {0xb3}
        trap_fdcb,{0xb4} trap_fdcb,   {0xb5} op_rb6iyd,{0xb6} trap_fdcb,   {0xb7}
        trap_fdcb,{0xb8} trap_fdcb,   {0xb9} trap_fdcb,{0xba} trap_fdcb,   {0xbb}
        trap_fdcb,{0xbc} trap_fdcb,   {0xbd} op_rb7iyd,{0xbe} trap_fdcb,   {0xbf}
        trap_fdcb,{0xc0} trap_fdcb,   {0xc1} trap_fdcb,{0xc2} trap_fdcb,   {0xc3}
        trap_fdcb,{0xc4} trap_fdcb,   {0xc5} op_sb0iyd,{0xc6} trap_fdcb,   {0xc7}
        trap_fdcb,{0xc8} trap_fdcb,   {0xc9} trap_fdcb,{0xca} trap_fdcb,   {0xcb}
        trap_fdcb,{0xcc} trap_fdcb,   {0xcd} op_sb1iyd,{0xce} trap_fdcb,   {0xcf}
        trap_fdcb,{0xd0} trap_fdcb,   {0xd1} trap_fdcb,{0xd2} trap_fdcb,   {0xd3}
        trap_fdcb,{0xd4} trap_fdcb,   {0xd5} op_sb2iyd,{0xd6} trap_fdcb,   {0xd7}
        trap_fdcb,{0xd8} trap_fdcb,   {0xd9} trap_fdcb,{0xda} trap_fdcb,   {0xdb}
        trap_fdcb,{0xdc} trap_fdcb,   {0xdd} op_sb3iyd,{0xde} trap_fdcb,   {0xdf}
        trap_fdcb,{0xe0} trap_fdcb,   {0xe1} trap_fdcb,{0xe2} trap_fdcb,   {0xe3}
        trap_fdcb,{0xe4} trap_fdcb,   {0xe5} op_sb4iyd,{0xe6} trap_fdcb,   {0xe7}
        trap_fdcb,{0xe8} trap_fdcb,   {0xe9} trap_fdcb,{0xea} trap_fdcb,   {0xeb}
        trap_fdcb,{0xec} trap_fdcb,   {0xed} op_sb5iyd,{0xee} trap_fdcb,   {0xef}
        trap_fdcb,{0xf0} trap_fdcb,   {0xf1} trap_fdcb,{0xf2} trap_fdcb,   {0xf3}
        trap_fdcb,{0xf4} trap_fdcb,   {0xf5} op_sb6iyd,{0xf6} trap_fdcb,   {0xf7}
        trap_fdcb,{0xf8} trap_fdcb,   {0xf9} trap_fdcb,{0xfa} trap_fdcb,   {0xfb}
        trap_fdcb,{0xfc} trap_fdcb,   {0xfd} op_sb7iyd,{0xfe} trap_fdcb    {0xff}
       );
  var d    : Integer;
      op_f : op_funcp;
{$IFDEF WANT_TIM}
      t : LongInt;
{$ENDIF}
begin
      d := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_PCC}                                       { correct PC overrun }
      if (PC > 65535) then PC := 0;
{$ENDIF}

      op_f := op_fdcb[Speicher_lesen_Byte(PC)];
      PC := PC + 1;
{$IFDEF WANT_PCC}                                 { again correct PC overrun }
      if (PC > 65535) then PC := 0;
{$ENDIF}

{$IFDEF WANT_TIM}                                      { execute next opcode }
      t := op_f(d);
{$ELSE}
      op_f(d);
{$ENDIF}

{$IFDEF WANT_TIM}
      op_fdcb_handel:=t;
{$ENDIF}
end;

begin
end.