{$I DEFINE.INC}

unit DDCB;

interface

uses Varia;

function op_ddcb_handel:Integer; far;

implementation

{ This function traps all illegal opcodes following the
  initial 0xdd 0xcb of a 4 byte opcode.
}
function trap_ddcb(data:Integer):Integer; far;
begin
      cpu_error := OPTRAP4;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      trap_ddcb:=0;
{$ENDIF}
end;

function op_tb0ixd(data:Integer):Integer; far;                { BIT 0,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 1)=1)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb0ixd:=20;
{$ENDIF}
end;

function op_tb1ixd(data:Integer):Integer; far;                { BIT 1,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 2)=2)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb1ixd:=20;
{$ENDIF}
end;

function op_tb2ixd(data:Integer):Integer; far;	              { BIT 2,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 4)=4)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb2ixd:=20;
{$ENDIF}
end;

function op_tb3ixd(data:Integer):Integer; far;	              { BIT 3,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 8)=8)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb3ixd:=20;
{$ENDIF}
end;

function op_tb4ixd(data:Integer):Integer; far;	              { BIT 4,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 16)=16)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb4ixd:=20;
{$ENDIF}
end;

function op_tb5ixd(data:Integer):Integer; far;	              { BIT 5,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 32)=32)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb5ixd:=20;
{$ENDIF}
end;

function op_tb6ixd(data:Integer):Integer; far;	              { BIT 6,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 64)=64)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb6ixd:=20;
{$ENDIF}
end;

function op_tb7ixd(data:Integer):Integer; far;	              { BIT 7,(IX+d) }
begin
      F := F AND NOT N_FLAG;
      F := F OR      H_FLAG;
      if ((Speicher_lesen_Byte(IX+data) AND 128)=128)
         then F := F AND NOT Z_FLAG
         else F := F OR      Z_FLAG;
{$IFDEF WANT_TIM}
      op_tb7ixd:=20;
{$ENDIF}
end;

function op_rb0ixd(data:Integer):Integer; far;                { RES 0,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $FE));
{$IFDEF WANT_TIM}
      op_rb0ixd:=23;
{$ENDIF}
end;

function op_rb1ixd(data:Integer):Integer; far;                { RES 1,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $FD));
{$IFDEF WANT_TIM}
      op_rb1ixd:=23;
{$ENDIF}
end;

function op_rb2ixd(data:Integer):Integer; far;                { RES 2,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $FB));
{$IFDEF WANT_TIM}
      op_rb2ixd:=23;
{$ENDIF}
end;

function op_rb3ixd(data:Integer):Integer; far;                { RES 3,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $F7));
{$IFDEF WANT_TIM}
      op_rb3ixd:=23;
{$ENDIF}
end;

function op_rb4ixd(data:Integer):Integer; far;                { RES 4,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $EF));
{$IFDEF WANT_TIM}
      op_rb4ixd:=23;
{$ENDIF}
end;

function op_rb5ixd(data:Integer):Integer; far;                { RES 5,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $DF));
{$IFDEF WANT_TIM}
      op_rb5ixd:=23;
{$ENDIF}
end;

function op_rb6ixd(data:Integer):Integer; far;                { RES 6,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $BF));
{$IFDEF WANT_TIM}
      op_rb6ixd:=23;
{$ENDIF}
end;

function op_rb7ixd(data:Integer):Integer; far;                { RES 7,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) AND $7F));
{$IFDEF WANT_TIM}
      op_rb7ixd:=23;
{$ENDIF}
end;

function op_sb0ixd(data:Integer):Integer; far;                { SET 0,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $01));
{$IFDEF WANT_TIM}
      op_sb0ixd:=23;
{$ENDIF}
end;

function op_sb1ixd(data:Integer):Integer; far;                { SET 1,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $02));
{$IFDEF WANT_TIM}
      op_sb1ixd:=23;
{$ENDIF}
end;

function op_sb2ixd(data:Integer):Integer; far;                { SET 2,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $04));
{$IFDEF WANT_TIM}
      op_sb2ixd:=23;
{$ENDIF}
end;

function op_sb3ixd(data:Integer):Integer; far;                { SET 3,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $08));
{$IFDEF WANT_TIM}
      op_sb3ixd:=23;
{$ENDIF}
end;

function op_sb4ixd(data:Integer):Integer; far;                { SET 4,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $10));
{$IFDEF WANT_TIM}
      op_sb4ixd:=23;
{$ENDIF}
end;

function op_sb5ixd(data:Integer):Integer; far;                { SET 5,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $20));
{$IFDEF WANT_TIM}
      op_sb5ixd:=23;
{$ENDIF}
end;

function op_sb6ixd(data:Integer):Integer; far;                { SET 6,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $40));
{$IFDEF WANT_TIM}
      op_sb6ixd:=23;
{$ENDIF}
end;

function op_sb7ixd(data:Integer):Integer; far;                { SET 7,(IX+d) }
begin
      Speicher_schreiben_Byte(IX+data,(Speicher_lesen_Byte(IX+data) OR $80));
{$IFDEF WANT_TIM}
      op_sb7ixd:=23;
{$ENDIF}
end;

function op_rlcixd(data:Integer):Integer; far;                  { RLC (IX+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      i := p AND $80;
      if (i=$80) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      if (i=$80) then p := p AND $01;
      Speicher_schreiben_Byte(IX+data,p);
      if (p=0)           then F := F OR      Z_FLAG else F := F AND NOT Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlcixd:=23;
{$ENDIF}
end;

function op_rrcixd(data:Integer):Integer; far;                  { RRC (IX+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      i := p AND $01;
      if (i=$01) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      if (i=$01) then p := p AND $80;
      Speicher_schreiben_Byte(IX+data,p);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrcixd:=23;
{$ENDIF}
end;

function op_rlixd(data:Integer):Integer; far;                    { RL (IX+d) }
  var old_c_flag : Integer;
      p          : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      old_c_flag := F AND C_FLAG;
      if (p AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      if (old_c_flag=1) then p := p OR 1;
      Speicher_schreiben_Byte(IX+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rlixd:=23;
{$ENDIF}
end;

function op_rrixd(data:Integer):Integer; far;                    { RR (IX+d) }
  var old_c_flag : Integer;
      p          : Byte;
begin
      old_c_flag := F AND C_FLAG;
      p := Speicher_lesen_Byte(IX+data);
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      if (old_c_flag=1) then p := p OR $80;
      Speicher_schreiben_Byte(IX+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR 	   S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_rrixd:=23;
{$ENDIF}
end;

function op_slaixd(data:Integer):Integer; far;	                { SLA (IX+d) }
  var p : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      if (p AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $7F; p := p*2;                                    {*p <<= 1;}
      Speicher_schreiben_Byte(IX+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_slaixd:=23;
{$ENDIF}
end;

function op_sraixd(data:Integer):Integer; far;	                { SRA (IX+d) }
  var i : Integer;
      p : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      i := p AND $80;
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      p := p OR  i;
      Speicher_schreiben_Byte(IX+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_sraixd:=23;
{$ENDIF}
end;

function op_srlixd(data:Integer):Integer; far;	                { SRL (IX+d) }
  var p : Byte;
begin
      p := Speicher_lesen_Byte(IX+data);
      if (p AND $01)=$01 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      p := p AND $FE; p := p div 2;                                {*p >>= 1;}
      Speicher_schreiben_Byte(IX+data,p);
      F := F AND NOT (H_FLAG OR N_FLAG);
      if (p=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (p AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (parrity[p]=1)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
{$IFDEF WANT_TIM}
      op_srlixd:=23;
{$ENDIF}
end;

{ Like the function "cpu()" this one emulates 4 byte opcodes
  starting with 0xDD 0xCB
}
function op_ddcb_handel:Integer;
  const op_ddcb : Array[0..255] of op_funcp =
       (trap_ddcb,{0x00} trap_ddcb,   {0x01} trap_ddcb,{0x02} trap_ddcb,   {0x03}
        trap_ddcb,{0x04} trap_ddcb,   {0x05} op_rlcixd,{0x06} trap_ddcb,   {0x07}
        trap_ddcb,{0x08} trap_ddcb,   {0x09} trap_ddcb,{0x0a} trap_ddcb,   {0x0b}
        trap_ddcb,{0x0c} trap_ddcb,   {0x0d} op_rrcixd,{0x0e} trap_ddcb,   {0x0f}
        trap_ddcb,{0x10} trap_ddcb,   {0x11} trap_ddcb,{0x12} trap_ddcb,   {0x13}
        trap_ddcb,{0x14} trap_ddcb,   {0x15} op_rlixd, {0x16} trap_ddcb,   {0x17}
        trap_ddcb,{0x18} trap_ddcb,   {0x19} trap_ddcb,{0x1a} trap_ddcb,   {0x1b}
        trap_ddcb,{0x1c} trap_ddcb,   {0x1d} op_rrixd, {0x1e} trap_ddcb,   {0x1f}
        trap_ddcb,{0x20} trap_ddcb,   {0x21} trap_ddcb,{0x22} trap_ddcb,   {0x23}
        trap_ddcb,{0x24} trap_ddcb,   {0x25} op_slaixd,{0x26} trap_ddcb,   {0x27}
        trap_ddcb,{0x28} trap_ddcb,   {0x29} trap_ddcb,{0x2a} trap_ddcb,   {0x2b}
        trap_ddcb,{0x2c} trap_ddcb,   {0x2d} op_sraixd,{0x2e} trap_ddcb,   {0x2f}
        trap_ddcb,{0x30} trap_ddcb,   {0x31} trap_ddcb,{0x32} trap_ddcb,   {0x33}
        trap_ddcb,{0x34} trap_ddcb,   {0x35} trap_ddcb,{0x36} trap_ddcb,   {0x37}
        trap_ddcb,{0x38} trap_ddcb,   {0x39} trap_ddcb,{0x3a} trap_ddcb,   {0x3b}
        trap_ddcb,{0x3c} trap_ddcb,   {0x3d} op_srlixd,{0x3e} trap_ddcb,   {0x3f}
        trap_ddcb,{0x40} trap_ddcb,   {0x41} trap_ddcb,{0x42} trap_ddcb,   {0x43}
        trap_ddcb,{0x44} trap_ddcb,   {0x45} op_tb0ixd,{0x46} trap_ddcb,   {0x47}
        trap_ddcb,{0x48} trap_ddcb,   {0x49} trap_ddcb,{0x4a} trap_ddcb,   {0x4b}
        trap_ddcb,{0x4c} trap_ddcb,   {0x4d} op_tb1ixd,{0x4e} trap_ddcb,   {0x4f}
        trap_ddcb,{0x50} trap_ddcb,   {0x51} trap_ddcb,{0x52} trap_ddcb,   {0x53}
        trap_ddcb,{0x54} trap_ddcb,   {0x55} op_tb2ixd,{0x56} trap_ddcb,   {0x57}
        trap_ddcb,{0x58} trap_ddcb,   {0x59} trap_ddcb,{0x5a} trap_ddcb,   {0x5b}
        trap_ddcb,{0x5c} trap_ddcb,   {0x5d} op_tb3ixd,{0x5e} trap_ddcb,   {0x5f}
        trap_ddcb,{0x60} trap_ddcb,   {0x61} trap_ddcb,{0x62} trap_ddcb,   {0x63}
        trap_ddcb,{0x64} trap_ddcb,   {0x65} op_tb4ixd,{0x66} trap_ddcb,   {0x67}
        trap_ddcb,{0x68} trap_ddcb,   {0x69} trap_ddcb,{0x6a} trap_ddcb,   {0x6b}
        trap_ddcb,{0x6c} trap_ddcb,   {0x6d} op_tb5ixd,{0x6e} trap_ddcb,   {0x6f}
        trap_ddcb,{0x70} trap_ddcb,   {0x71} trap_ddcb,{0x72} trap_ddcb,   {0x73}
        trap_ddcb,{0x74} trap_ddcb,   {0x75} op_tb6ixd,{0x76} trap_ddcb,   {0x77}
        trap_ddcb,{0x78} trap_ddcb,   {0x79} trap_ddcb,{0x7a} trap_ddcb,   {0x7b}
        trap_ddcb,{0x7c} trap_ddcb,   {0x7d} op_tb7ixd,{0x7e} trap_ddcb,   {0x7f}
        trap_ddcb,{0x80} trap_ddcb,   {0x81} trap_ddcb,{0x82} trap_ddcb,   {0x83}
        trap_ddcb,{0x84} trap_ddcb,   {0x85} op_rb0ixd,{0x86} trap_ddcb,   {0x87}
        trap_ddcb,{0x88} trap_ddcb,   {0x89} trap_ddcb,{0x8a} trap_ddcb,   {0x8b}
        trap_ddcb,{0x8c} trap_ddcb,   {0x8d} op_rb1ixd,{0x8e} trap_ddcb,   {0x8f}
        trap_ddcb,{0x90} trap_ddcb,   {0x91} trap_ddcb,{0x92} trap_ddcb,   {0x93}
        trap_ddcb,{0x94} trap_ddcb,   {0x95} op_rb2ixd,{0x96} trap_ddcb,   {0x97}
        trap_ddcb,{0x98} trap_ddcb,   {0x99} trap_ddcb,{0x9a} trap_ddcb,   {0x9b}
        trap_ddcb,{0x9c} trap_ddcb,   {0x9d} op_rb3ixd,{0x9e} trap_ddcb,   {0x9f}
        trap_ddcb,{0xa0} trap_ddcb,   {0xa1} trap_ddcb,{0xa2} trap_ddcb,   {0xa3}
        trap_ddcb,{0xa4} trap_ddcb,   {0xa5} op_rb4ixd,{0xa6} trap_ddcb,   {0xa7}
        trap_ddcb,{0xa8} trap_ddcb,   {0xa9} trap_ddcb,{0xaa} trap_ddcb,   {0xab}
        trap_ddcb,{0xac} trap_ddcb,   {0xad} op_rb5ixd,{0xae} trap_ddcb,   {0xaf}
        trap_ddcb,{0xb0} trap_ddcb,   {0xb1} trap_ddcb,{0xb2} trap_ddcb,   {0xb3}
        trap_ddcb,{0xb4} trap_ddcb,   {0xb5} op_rb6ixd,{0xb6} trap_ddcb,   {0xb7}
        trap_ddcb,{0xb8} trap_ddcb,   {0xb9} trap_ddcb,{0xba} trap_ddcb,   {0xbb}
        trap_ddcb,{0xbc} trap_ddcb,   {0xbd} op_rb7ixd,{0xbe} trap_ddcb,   {0xbf}
        trap_ddcb,{0xc0} trap_ddcb,   {0xc1} trap_ddcb,{0xc2} trap_ddcb,   {0xc3}
        trap_ddcb,{0xc4} trap_ddcb,   {0xc5} op_sb0ixd,{0xc6} trap_ddcb,   {0xc7}
        trap_ddcb,{0xc8} trap_ddcb,   {0xc9} trap_ddcb,{0xca} trap_ddcb,   {0xcb}
        trap_ddcb,{0xcc} trap_ddcb,   {0xcd} op_sb1ixd,{0xce} trap_ddcb,   {0xcf}
        trap_ddcb,{0xd0} trap_ddcb,   {0xd1} trap_ddcb,{0xd2} trap_ddcb,   {0xd3}
        trap_ddcb,{0xd4} trap_ddcb,   {0xd5} op_sb2ixd,{0xd6} trap_ddcb,   {0xd7}
        trap_ddcb,{0xd8} trap_ddcb,   {0xd9} trap_ddcb,{0xda} trap_ddcb,   {0xdb}
        trap_ddcb,{0xdc} trap_ddcb,   {0xdd} op_sb3ixd,{0xde} trap_ddcb,   {0xdf}
        trap_ddcb,{0xe0} trap_ddcb,   {0xe1} trap_ddcb,{0xe2} trap_ddcb,   {0xe3}
        trap_ddcb,{0xe4} trap_ddcb,   {0xe5} op_sb4ixd,{0xe6} trap_ddcb,   {0xe7}
        trap_ddcb,{0xe8} trap_ddcb,   {0xe9} trap_ddcb,{0xea} trap_ddcb,   {0xeb}
        trap_ddcb,{0xec} trap_ddcb,   {0xed} op_sb5ixd,{0xee} trap_ddcb,   {0xef}
        trap_ddcb,{0xf0} trap_ddcb,   {0xf1} trap_ddcb,{0xf2} trap_ddcb,   {0xf3}
        trap_ddcb,{0xf4} trap_ddcb,   {0xf5} op_sb6ixd,{0xf6} trap_ddcb,   {0xf7}
        trap_ddcb,{0xf8} trap_ddcb,   {0xf9} trap_ddcb,{0xfa} trap_ddcb,   {0xfb}
        trap_ddcb,{0xfc} trap_ddcb,   {0xfd} op_sb7ixd,{0xfe} trap_ddcb    {0xff}
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

      op_f := op_ddcb[Speicher_lesen_Byte(PC)];
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
      op_ddcb_handel:=t;
{$ENDIF}
end;

begin
end.
