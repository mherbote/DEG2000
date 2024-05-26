{$F+}
unit DISAS1;

interface

uses WinCrt,Varia;

procedure disass(var adr:Word);

implementation

function opout (s:string; p:Word):Integer; forward;
function nout  (s:string; p:Word):Integer; forward;
function iout1 (s:string; p:Word):Integer; forward;
function iout2 (s:string; p:Word):Integer; forward;
function rout  (s:string; p:Word):Integer; forward;
function nnout (s:string; p:Word):Integer; forward;
function inout1(s:string; p:Word):Integer; forward;
function inout2(s:string; p:Word):Integer; forward;
function inout3(s:string; p:Word):Integer; forward;
function cbop  (s:string; p:Word):Integer; forward;
function edop  (s:string; p:Word):Integer; forward;
function ddfd  (s:string; p:Word):Integer; forward;

{ Op-code tables }
type  opt = record fun : op_func2;
                   txt : {Array[1..15] of Char}string;
            end;

const optab  : Array[0..255] of opt = ((fun: opout; txt: 'NOP  '        ), {0x00}
                                       (fun: nnout; txt: 'LD   BC,'     ), {0x01}
                                       (fun: opout; txt: 'LD   (BC),A'  ), {0x02}
                                       (fun: opout; txt: 'INC  BC'      ), {0x03}
                                       (fun: opout; txt: 'INC  B'       ), {0x04}
                                       (fun: opout; txt: 'DEC  B'       ), {0x05}
                                       (fun: nout;  txt: 'LD   B,'      ), {0x06}
                                       (fun: opout; txt: 'RLCA'         ), {0x07}
                                       (fun: opout; txt: 'EX   AF,AF''' ), {0x08}
                                       (fun: opout; txt: 'ADD  HL,BC'   ), {0x09}
                                       (fun: opout; txt: 'LD   A,(BC)'  ), {0x0a}
                                       (fun: opout; txt: 'DEC  BC'      ), {0x0b}
                                       (fun: opout; txt: 'INC  C'       ), {0x0c}
                                       (fun: opout; txt: 'DEC  C'       ), {0x0d}
                                       (fun: nout;  txt: 'LD   C,'      ), {0x0e}
                                       (fun: opout; txt: 'RRCA '        ), {0x0f}
                                       (fun: rout;  txt: 'DJNZ '        ), {0x10}
                                       (fun: nnout; txt: 'LD   DE,'     ), {0x11}
                                       (fun: opout; txt: 'LD   (DE),A'  ), {0x12}
                                       (fun: opout; txt: 'INC  DE'      ), {0x13}
                                       (fun: opout; txt: 'INC  D'       ), {0x14}
                                       (fun: opout; txt: 'DEC  D'       ), {0x15}
                                       (fun: nout;  txt: 'LD   D,'      ), {0x16}
                                       (fun: opout; txt: 'RLA  '        ), {0x17}
                                       (fun: rout;  txt: 'JR   '	), {0x18}
                                       (fun: opout; txt: 'ADD  HL,DE'   ), {0x19}
                                       (fun: opout; txt: 'LD   A,(DE)'  ), {0x1a}
                                       (fun: opout; txt: 'DEC  DE'      ), {0x1b}
                                       (fun: opout; txt: 'INC  E'       ), {0x1c}
                                       (fun: opout; txt: 'DEC  E'       ), {0x1d}
                                       (fun: nout;  txt: 'LD   E,'      ), {0x1e}
                                       (fun: opout; txt: 'RRA  '        ), {0x1f}
                                       (fun: rout;  txt: 'JR   NZ,'     ), {0x20}
                                       (fun: nnout; txt: 'LD   HL,'     ), {0x21}
                                       (fun: inout1;txt: 'LD   ('       ), {0x22}
                                       (fun: opout; txt: 'INC  HL'      ), {0x23}
                                       (fun: opout; txt: 'INC  H'       ), {0x24}
                                       (fun: opout; txt: 'DEC  H'       ), {0x25}
                                       (fun: nout;  txt: 'LD   H,'      ), {0x26}
                                       (fun: opout; txt: 'DAA  '        ), {0x27}
                                       (fun: rout;  txt: 'JR   Z,'      ), {0x28}
                                       (fun: opout; txt: 'ADD  HL,HL'   ), {0x29}
                                       (fun: inout2;txt: 'LD   HL,('    ), {0x2a}
                                       (fun: opout; txt: 'DEC  HL'      ), {0x2b}
                                       (fun: opout; txt: 'INC  L'       ), {0x2c}
                                       (fun: opout; txt: 'DEC  L'       ), {0x2d}
                                       (fun: nout;  txt: 'LD   L,'      ), {0x2e}
                                       (fun: opout; txt: 'CPL  '        ), {0x2f}
                                       (fun: rout;  txt: 'JR   NC,'     ), {0x30}
                                       (fun: nnout; txt: 'LD   SP,'     ), {0x31}
                                       (fun: inout3;txt: 'LD   ('       ), {0x32}
                                       (fun: opout; txt: 'INC  SP'      ), {0x33}
                                       (fun: opout; txt: 'INC  (HL)'    ), {0x34}
                                       (fun: opout; txt: 'DEC  (HL)'    ), {0x35}
                                       (fun: nout;  txt: 'LD   (HL),'   ), {0x36}
                                       (fun: opout; txt: 'SCF  '        ), {0x37}
                                       (fun: rout;  txt: 'JR   C,'      ), {0x38}
                                       (fun: opout; txt: 'ADD  HL,SP'   ), {0x39}
                                       (fun: inout2;txt: 'LD   A,('     ), {0x3a}
                                       (fun: opout; txt: 'DEC  SP'      ), {0x3b}
                                       (fun: opout; txt: 'INC  A'       ), {0x3c}
                                       (fun: opout; txt: 'DEC  A'       ), {0x3d}
                                       (fun: nout;  txt: 'LD   A,'      ), {0x3e}
                                       (fun: opout; txt: 'CCF  '        ), {0x3f}
                                       (fun: opout; txt: 'LD   B,B'     ), {0x40}
                                       (fun: opout; txt: 'LD   B,C'     ), {0x41}
                                       (fun: opout; txt: 'LD   B,D'     ), {0x42}
                                       (fun: opout; txt: 'LD   B,E'     ), {0x43}
                                       (fun: opout; txt: 'LD   B,H'     ), {0x44}
                                       (fun: opout; txt: 'LD   B,L'     ), {0x45}
                                       (fun: opout; txt: 'LD   B,(HL)'  ), {0x46}
                                       (fun: opout; txt: 'LD   B,A'	), {0x47}
                                       (fun: opout; txt: 'LD   C,B'     ), {0x48}
                                       (fun: opout; txt: 'LD   C,C'     ), {0x49}
                                       (fun: opout; txt: 'LD   C,D'     ), {0x4a}
                                       (fun: opout; txt: 'LD   C,E'     ), {0x4b}
                                       (fun: opout; txt: 'LD   C,H'     ), {0x4c}
                                       (fun: opout; txt: 'LD   C,L'     ), {0x4d}
                                       (fun: opout; txt: 'LD   C,(HL)'  ), {0x4e}
                                       (fun: opout; txt: 'LD   C,A'     ), {0x4f}
                                       (fun: opout; txt: 'LD   D,B'     ), {0x50}
                                       (fun: opout; txt: 'LD   D,C'     ), {0x51}
                                       (fun: opout; txt: 'LD   D,D'     ), {0x52}
                                       (fun: opout; txt: 'LD   D,E'     ), {0x53}
                                       (fun: opout; txt: 'LD   D,H'     ), {0x54}
                                       (fun: opout; txt: 'LD   D,L'     ), {0x55}
                                       (fun: opout; txt: 'LD   D,(HL)'  ), {0x56}
                                       (fun: opout; txt: 'LD   D,A'     ), {0x57}
                                       (fun: opout; txt: 'LD   E,B'     ), {0x58}
                                       (fun: opout; txt: 'LD   E,C'     ), {0x59}
                                       (fun: opout; txt: 'LD   E,D'     ), {0x5a}
                                       (fun: opout; txt: 'LD   E,E'     ), {0x5b}
                                       (fun: opout; txt: 'LD   E,H'     ), {0x5c}
                                       (fun: opout; txt: 'LD   E,L'     ), {0x5d}
                                       (fun: opout; txt: 'LD   E,(HL)'  ), {0x5e}
                                       (fun: opout; txt: 'LD   E,A'     ), {0x5f}
                                       (fun: opout; txt: 'LD   H,B'     ), {0x60}
                                       (fun: opout; txt: 'LD   H,C'     ), {0x61}
                                       (fun: opout; txt: 'LD   H,D'     ), {0x62}
                                       (fun: opout; txt: 'LD   H,E'     ), {0x63}
                                       (fun: opout; txt: 'LD   H,H'     ), {0x64}
                                       (fun: opout; txt: 'LD   H,L'     ), {0x65}
                                       (fun: opout; txt: 'LD   H,(HL)'  ), {0x66}
                                       (fun: opout; txt: 'LD   H,A'     ), {0x67}
                                       (fun: opout; txt: 'LD   L,B'     ), {0x68}
                                       (fun: opout; txt: 'LD   L,C'     ), {0x69}
                                       (fun: opout; txt: 'LD   L,D'     ), {0x6a}
                                       (fun: opout; txt: 'LD   L,E'     ), {0x6b}
                                       (fun: opout; txt: 'LD   L,H'     ), {0x6c}
                                       (fun: opout; txt: 'LD   L,L'     ), {0x6d}
                                       (fun: opout; txt: 'LD   L,(HL)'  ), {0x6e}
                                       (fun: opout; txt: 'LD   L,A'     ), {0x6f}
                                       (fun: opout; txt: 'LD   (HL),B'  ), {0x70}
                                       (fun: opout; txt: 'LD   (HL),C'  ), {0x71}
                                       (fun: opout; txt: 'LD   (HL),D'  ), {0x72}
                                       (fun: opout; txt: 'LD   (HL),E'  ), {0x73}
                                       (fun: opout; txt: 'LD   (HL),H'  ), {0x74}
                                       (fun: opout; txt: 'LD   (HL),L'  ), {0x75}
                                       (fun: opout; txt: 'HALT '        ), {0x76}
                                       (fun: opout; txt: 'LD   (HL),A'  ), {0x77}
                                       (fun: opout; txt: 'LD   A,B'     ), {0x78}
                                       (fun: opout; txt: 'LD   A,C'     ), {0x79}
                                       (fun: opout; txt: 'LD   A,D'     ), {0x7a}
                                       (fun: opout; txt: 'LD   A,E'     ), {0x7b}
                                       (fun: opout; txt: 'LD   A,H'     ), {0x7c}
                                       (fun: opout; txt: 'LD   A,L'     ), {0x7d}
                                       (fun: opout; txt: 'LD   A,(HL)'  ), {0x7e}
                                       (fun: opout; txt: 'LD   A,A'     ), {0x7f}
                                       (fun: opout; txt: 'ADD  A,B'     ), {0x80}
                                       (fun: opout; txt: 'ADD  A,C'     ), {0x81}
                                       (fun: opout; txt: 'ADD  A,D'     ), {0x82}
                                       (fun: opout; txt: 'ADD  A,E'     ), {0x83}
                                       (fun: opout; txt: 'ADD  A,H'     ), {0x84}
                                       (fun: opout; txt: 'ADD  A,L'     ), {0x85}
                                       (fun: opout; txt: 'ADD  A,(HL)'  ), {0x86}
                                       (fun: opout; txt: 'ADD  A,A'     ), {0x87}
                                       (fun: opout; txt: 'ADC  A,B'     ), {0x88}
                                       (fun: opout; txt: 'ADC  A,C'     ), {0x89}
                                       (fun: opout; txt: 'ADC  A,D'     ), {0x8a}
                                       (fun: opout; txt: 'ADC  A,E'     ), {0x8b}
                                       (fun: opout; txt: 'ADC  A,H'     ), {0x8c}
                                       (fun: opout; txt: 'ADC  A,L'	), {0x8d}
                                       (fun: opout; txt: 'ADC  A,(HL)'	), {0x8e}
                                       (fun: opout; txt: 'ADC  A,A'	), {0x8f}
                                       (fun: opout; txt: 'SUB  B'	), {0x90}
                                       (fun: opout; txt: 'SUB  C'	), {0x91}
                                       (fun: opout; txt: 'SUB  D'	), {0x92}
                                       (fun: opout; txt: 'SUB  E'	), {0x93}
                                       (fun: opout; txt: 'SUB  H'	), {0x94}
                                       (fun: opout; txt: 'SUB  L'	), {0x95}
                                       (fun: opout; txt: 'SUB  (HL)'	), {0x96}
                                       (fun: opout; txt: 'SUB  A'	), {0x97}
                                       (fun: opout; txt: 'SBC  A,B'	), {0x98}
                                       (fun: opout; txt: 'SBC  A,C'	), {0x99}
                                       (fun: opout; txt: 'SBC  A,D'	), {0x9a}
                                       (fun: opout; txt: 'SBC  A,E'	), {0x9b}
                                       (fun: opout; txt: 'SBC  A,H'	), {0x9c}
                                       (fun: opout; txt: 'SBC  A,L'	), {0x9d}
                                       (fun: opout; txt: 'SBC  A,(HL)'	), {0x9e}
                                       (fun: opout; txt: 'SBC  A,A'	), {0x9f}
                                       (fun: opout; txt: 'AND  B'	), {0xa0}
                                       (fun: opout; txt: 'AND  C'	), {0xa1}
                                       (fun: opout; txt: 'AND  D'	), {0xa2}
                                       (fun: opout; txt: 'AND  E'	), {0xa3}
                                       (fun: opout; txt: 'AND  H'	), {0xa4}
                                       (fun: opout; txt: 'AND  L'	), {0xa5}
                                       (fun: opout; txt: 'AND  (HL)'	), {0xa6}
                                       (fun: opout; txt: 'AND  A'	), {0xa7}
                                       (fun: opout; txt: 'XOR  B'	), {0xa8}
                                       (fun: opout; txt: 'XOR  C'	), {0xa9}
                                       (fun: opout; txt: 'XOR  D'	), {0xaa}
                                       (fun: opout; txt: 'XOR  E'	), {0xab}
                                       (fun: opout; txt: 'XOR  H'	), {0xac}
                                       (fun: opout; txt: 'XOR  L'	), {0xad}
                                       (fun: opout; txt: 'XOR  (HL)'	), {0xae}
                                       (fun: opout; txt: 'XOR  A'	), {0xaf}
                                       (fun: opout; txt: 'OR   B'	), {0xb0}
                                       (fun: opout; txt: 'OR   C'	), {0xb1}
                                       (fun: opout; txt: 'OR   D'	), {0xb2}
                                       (fun: opout; txt: 'OR   E'	), {0xb3}
                                       (fun: opout; txt: 'OR   H'	), {0xb4}
                                       (fun: opout; txt: 'OR   L'       ), {0xb5}
                                       (fun: opout; txt: 'OR   (HL)'	), {0xb6}
                                       (fun: opout; txt: 'OR   A'	), {0xb7}
                                       (fun: opout; txt: 'CP   B'	), {0xb8}
                                       (fun: opout; txt: 'CP   C'	), {0xb9}
                                       (fun: opout; txt: 'CP   D'	), {0xba}
                                       (fun: opout; txt: 'CP   E'	), {0xbb}
                                       (fun: opout; txt: 'CP   H'	), {0xbc}
                                       (fun: opout; txt: 'CP   L'	), {0xbd}
                                       (fun: opout; txt: 'CP   (HL)'	), {0xbe}
                                       (fun: opout; txt: 'CP   A'	), {0xbf}
                                       (fun: opout; txt: 'RET  NZ'	), {0xc0}
                                       (fun: opout; txt: 'POP  BC'	), {0xc1}
                                       (fun: nnout; txt: 'JP   NZ,'	), {0xc2}
                                       (fun: nnout; txt: 'JP   '        ), {0xc3}
                                       (fun: nnout; txt: 'CALL NZ,'	), {0xc4}
                                       (fun: opout; txt: 'PUSH BC'	), {0xc5}
                                       (fun: nout;  txt: 'ADD  A,'	), {0xc6}
                                       (fun: opout; txt: 'RST  0'	), {0xc7}
                                       (fun: opout; txt: 'RET  Z'	), {0xc8}
                                       (fun: opout; txt: 'RET  '	), {0xc9}
                                       (fun: nnout; txt: 'JP   Z,'	), {0xca}
                                       (fun: cbop;  txt: ''		), {0xcb}
                                       (fun: nnout; txt: 'CALL Z,'	), {0xcc}
                                       (fun: nnout; txt: 'CALL '	), {0xcd}
                                       (fun: nout;  txt: 'ADC  A,'	), {0xce}
                                       (fun: opout; txt: 'RST  8'	), {0xcf}
                                       (fun: opout; txt: 'RET  NC'	), {0xd0}
                                       (fun: opout; txt: 'POP  DE'	), {0xd1}
                                       (fun: nnout; txt: 'JP   NC,'	), {0xd2}
                                       (fun: iout1; txt: 'OUT  ('       ), {0xd3}
                                       (fun: nnout; txt: 'CALL NC,'     ), {0xd4}
                                       (fun: opout; txt: 'PUSH DE'	), {0xd5}
                                       (fun: nout;  txt: 'SUB  '	), {0xd6}
                                       (fun: opout; txt: 'RST  10'	), {0xd7}
                                       (fun: opout; txt: 'RET  C'	), {0xd8}
                                       (fun: opout; txt: 'EXX  '	), {0xd9}
                                       (fun: nnout; txt: 'JP   C,'	), {0xda}
                                       (fun: iout2; txt: 'IN   A,('     ), {0xdb}
                                       (fun: nnout; txt: 'CALL C,'	), {0xdc}
                                       (fun: ddfd;  txt: ''		), {0xdd}
                                       (fun: nout;  txt: 'SBC  A,'      ), {0xde}
                                       (fun: opout; txt: 'RST  18'	), {0xdf}
                                       (fun: opout; txt: 'RET  PO'	), {0xe0}
                                       (fun: opout; txt: 'POP  HL'	), {0xe1}
                                       (fun: nnout; txt: 'JP   PO,'	), {0xe2}
                                       (fun: opout; txt: 'EX   (SP),HL'	), {0xe3}
                                       (fun: nnout; txt: 'CALL PO,'	), {0xe4}
                                       (fun: opout; txt: 'PUSH HL'	), {0xe5}
                                       (fun: nout;  txt: 'AND  '	), {0xe6}
                                       (fun: opout; txt: 'RST  20'	), {0xe7}
                                       (fun: opout; txt: 'RET  PE'	), {0xe8}
                                       (fun: opout; txt: 'JP   (HL)'	), {0xe9}
                                       (fun: nnout; txt: 'JP   PE,'	), {0xea}
                                       (fun: opout; txt: 'EX   DE,HL'	), {0xeb}
                                       (fun: nnout; txt: 'CALL PE,'	), {0xec}
                                       (fun: edop;  txt: ''		), {0xed}
                                       (fun: nout;  txt: 'XOR  '	), {0xee}
                                       (fun: opout; txt: 'RST  28'	), {0xef}
                                       (fun: opout; txt: 'RET  P'	), {0xf0}
                                       (fun: opout; txt: 'POP  AF'	), {0xf1}
                                       (fun: nnout; txt: 'JP   P,'	), {0xf2}
                                       (fun: opout; txt: 'DI'		), {0xf3}
                                       (fun: nnout; txt: 'CALL P,'	), {0xf4}
                                       (fun: opout; txt: 'PUSH AF'      ), {0xf5}
                                       (fun: nout;  txt: 'OR   '        ), {0xf6}
                                       (fun: opout; txt: 'RST  30'	), {0xf7}
                                       (fun: opout; txt: 'RET  M'	), {0xf8}
                                       (fun: opout; txt: 'LD   SP,HL'	), {0xf9}
                                       (fun: nnout; txt: 'JP   M,'	), {0xfa}
                                       (fun: opout; txt: 'EI   '	), {0xfb}
                                       (fun: nnout; txt: 'CALL M,'	), {0xfc}
                                       (fun: ddfd;  txt: ''		), {0xfd}
                                       (fun: nout;  txt: 'CP   '	), {0xfe}
                                       (fun: opout; txt: 'RST  38'	)  {0xff}
                                      );

const unknown :                string = '???';
      reg     : Array[0..7] of string = ('B','C','D','E','H','L','(HL)','A');
      regix   :                string = 'IX';
      regiy   :                string = 'IY';

var   addr    : Integer;
      op_f    : op_func2;

{ The function disass() is the only global function of this module.
  The first argument is a pointer to a unsigned char pointer, which points
  to the op-code to disassemble. The output of the disassembly goes
  to stdout, terminated by a newline. After the disassembly the pointer to
  the op-code will be increased by the size of the op-code, so that
  disass() can be called again.
  The secound argument is the (Z80) address of the op-code to disassemble.
  It is used to calculate the destination address of relative jumps.
 }
procedure disass(var adr:Word);
  var len : Integer;
      s   : String;
begin
      addr := adr;
      op_f :=      optab[Speicher_lesen_Byte(adr)].fun;
      s    := ''; len := 1;
      while optab[Speicher_lesen_Byte(adr)].txt[len]<>chr(0) do
            begin s := s + optab[Speicher_lesen_Byte(adr)].txt[len];
                  Inc(len);
            end;
      len  := op_f(s, adr);
      adr  := adr + len;
end;

{ disassemble 1 byte op-codes }
function opout(s:string; p:Word):Integer;
begin
      WriteLn(s);
      opout:=1;
end;

{ disassemble 2 byte op-codes of type "Op n" }
function nout(s:string; p:Word):Integer;
begin
      WriteLn(s, HexAnzeige_Byte(Speicher_lesen_Byte(p + 1)));
      nout:=2;
end;

{ disassemble 2 byte op-codes with indirect addressing }
function iout1(s:string; p:Word):Integer;
begin
      WriteLn(s,HexAnzeige_Byte(Speicher_lesen_Byte(p + 1)),'),A');
      iout1:=2;
end;
function iout2(s:string; p:Word):Integer;
begin
      WriteLn(s,HexAnzeige_Byte(Speicher_lesen_Byte(p + 1)),')');
      iout2:=2;
end;

{ disassemble 2 byte op-codes with relative addressing }
function rout(s:string;p:Word):Integer;
  var i : ShortInt;
begin
      i := Speicher_lesen_Byte(p + 1);
      WriteLn(s, HexAnzeige_WordByte(addr + i + 2,'B'));
      rout:=2;
end;


function nnout(s:string;p:Word):Integer;    { disassemble 3 byte op-codes of type "Op nn" }
  var i:Integer;
begin
      i := Speicher_lesen_Byte(p + 1) + (Speicher_lesen_Byte(p + 2) shl 8);
      WriteLn(s,HexAnzeige_WordByte(i,'B'));
      nnout:=3;
end;

function inout1(s:string;p:Word):Integer; { disassemble 3 byte op-codes with indirect addressing }
  var i:Integer;
begin
      i := Speicher_lesen_Byte(p + 1) + (Speicher_lesen_Byte(p + 2) shl 8);
      WriteLn(s,HexAnzeige_WordByte(i,'B'),'),HL');
      inout1:=3;
end;
function inout2(s:string;p:Word):Integer; { disassemble 3 byte op-codes with indirect addressing }
  var i:Integer;
begin
      i := Speicher_lesen_Byte(p + 1) + (Speicher_lesen_Byte(p + 2) shl 8);
      WriteLn(s,HexAnzeige_WordByte(i,'B'),')');
      inout2:=3;
end;
function inout3(s:string;p:Word):Integer; { disassemble 3 byte op-codes with indirect addressing }
  var i:Integer;
begin
      i := Speicher_lesen_Byte(p + 1) + (Speicher_lesen_Byte(p + 2) shl 8);
      WriteLn(s,HexAnzeige_WordByte(i,'B'),'),A');
      inout3:=3;
end;

function cbop(s:string;p:Word):Integer; { disassemble multi byte op-codes with prefix $CB }
  var b2 : Integer;
  label ende;
begin
      b2 := Speicher_lesen_Byte(p + 1);
      if (b2 >= $00) AND (b2 <= $07)
         then begin
                    WriteLn('RLC  ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $08) AND (b2 <= $0F)
         then begin
                    WriteLn('RRC  ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $10) AND (b2 <= $17)
         then begin
                    WriteLn('RL   ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $18) AND (b2 <= $1F)
         then begin
                    WriteLn('RR   ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $20) AND (b2 <= $27)
         then begin
                    WriteLn('SLA  ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $28) AND (b2 <= $2F)
         then begin
                    WriteLn('SRA  ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $38) AND (b2 <= $3F)
         then begin
                    WriteLn('SRL  ',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $40) AND (b2 <= $7F)
         then begin
                    WriteLn('BIT  ',chr(((b2 shr 3) AND 7) + ord('0')),',',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $80) AND (b2 <= $BF)
         then begin
                    WriteLn('RES  ',chr(((b2 shr 3) AND 7) + ord('0')),',',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      if (b2 >= $C0)
         then begin
                    WriteLn('SET  ',chr(((b2 shr 3) AND 7) + ord('0')),',',reg[b2 AND 7]);
                    cbop:=2;
                    goto ende;
              end;
      WriteLn(unknown);
      cbop:=2;
ende:
end;

{ disassemble multi byte op-codes with prefix 0xED }
function edop(s:String;p:Word):Integer;
  var b2,i : Integer;
      len  : Integer;
begin
      len := 2;
      b2  := Speicher_lesen_Byte(p + 1);
      case b2 of $40: WriteLn('IN   B,(C)');
                 $41: WriteLn('OUT  (C),B');
                 $42: WriteLn('SBC  HL,BC');
                 $43: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   (',HexAnzeige_WordByte(i,'B'),'),BC');
                            len := 4;
                      end;
                 $44: WriteLn('NEG  ');
                 $45: WriteLn('RETN ');
                 $46: WriteLn('IM   0');
                 $47: WriteLn('LD   I,A');
                 $48: WriteLn('IN   C,(C)');
                 $49: WriteLn('OUT  (C),C');
                 $4A: WriteLn('ADC  HL,BC');
                 $4B: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   BC,(',HexAnzeige_WordByte(i,'B'),')');
                            len := 4;
                      end;
                 $4D: WriteLn('RETI');
                 $4F: WriteLn('LD   R,A');
                 $50: WriteLn('IN   D,(C)');
                 $51: WriteLn('OUT  (C),D');
                 $52: WriteLn('SBC  HL,DE');
                 $53: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   (',HexAnzeige_WordByte(i,'B'),'),DE');
                            len := 4;
                      end;
                 $56: WriteLn('IM   1');
                 $57: WriteLn('LD   A,I');
                 $58: WriteLn('IN   E,(C)');
                 $59: WriteLn('OUT  (C),E');
                 $5A: WriteLn('ADC  HL,DE');
                 $5B: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   DE,(',HexAnzeige_WordByte(i,'B'),')');
                            len := 4;
                      end;
                 $5E: WriteLn('IM   2');
                 $5F: WriteLn('LD   A,R');
                 $60: WriteLn('IN   H,(C)');
                 $61: WriteLn('OUT  (C),H');
                 $62: WriteLn('SBC  HL,HL');
                 $67: WriteLn('RRD');
                 $68: WriteLn('IN   L,(C)');
                 $69: WriteLn('OUT  (C),L');
                 $6A: WriteLn('ADC  HL,HL');
                 $6F: WriteLn('RLD');
                 $72: WriteLn('SBC  HL,SP');
                 $73: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   (',HexAnzeige_WordByte(i,'B'),'),SP');
                            len := 4;
                      end;
                 $78: WriteLn('IN   A,(C)');
                 $79: WriteLn('OUT  (C),A');
                 $7A: WriteLn('ADC  HL,SP');
                 $7B: begin i := Speicher_lesen_Byte(p + 2)+(Speicher_lesen_Byte(p + 3) shl 8);
                            WriteLn('LD   SP,(',HexAnzeige_WordByte(i,'B'),')');
                            len := 4;
                      end;
                 $A0: WriteLn('LDI');
                 $A1: WriteLn('CPI');
                 $A2: WriteLn('INI');
                 $A3: WriteLn('OUTI');
                 $A8: WriteLn('LDD');
                 $A9: WriteLn('CPD');
                 $AA: WriteLn('IND');
                 $AB: WriteLn('OUTD');
                 $B0: WriteLn('LDIR');
                 $B1: WriteLn('CPIR');
                 $B2: WriteLn('INIR');
                 $B3: WriteLn('OTIR');
                 $B8: WriteLn('LDDR');
                 $B9: WriteLn('CPDR');
                 $BA: WriteLn('INDR');
                 $BB: WriteLn('OTDR');
      else            WriteLn(unknown);
      end;
      edop := len;
end;

{ disassemble multi byte op-codes with prefix $DD and $FD }
function ddfd(s:String;p:Word):Integer;
  var b2   : Integer;
      len  : Integer;
      ireg : String;
  label ende;
begin
      len := 3;

      if (Speicher_lesen_Byte(p)=$DD) then ireg := regix
                                      else ireg := regiy;
      b2 := Speicher_lesen_Byte(p + 1);
      if (b2 >= $70) AND (b2 <= $77)
         then begin WriteLn('LD   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),'),',reg[b2 AND 7]);
                    ddfd:=3;
                    goto ende;
              end;
      case b2 of $09: begin WriteLn('ADD  ',ireg,',BC');
                            len := 2;
                      end;
                 $19: begin WriteLn('ADD  ',ireg,',DE');
                            len := 2;
                      end;
                 $21: begin WriteLn('LD   ',ireg,',',HexAnzeige_WordByte(Speicher_lesen_Byte(p + 2)+
                                                                        (Speicher_lesen_Byte(p + 3) shl 8),'B'));
                            len := 4;
                      end;
                 $22: begin WriteLn('LD   (',HexAnzeige_WordByte(Speicher_lesen_Byte(p + 2)+
                                                                (Speicher_lesen_Byte(p + 3) shl 8),'B'),
                                             '),',ireg);
                            len := 4;
                      end;
                 $23: begin WriteLn('INC  ',ireg);
                            len := 2;
                      end;
                 $29: begin if (Speicher_lesen_Byte(p)=$DD) then WriteLn('ADD  IX,IX')
                                                            else WriteLn('ADD  IY,IY');
                            len := 2;
                      end;
                 $2A: begin WriteLn('LD   ',ireg,',(',HexAnzeige_WordByte(Speicher_lesen_Byte(p + 2)+
                                                                         (Speicher_lesen_Byte(p + 3) shl 8),'B'),
                                                     ')');
                            len := 4;
                      end;
                 $2B: begin WriteLn('DEC  ',ireg);
                            len := 2;
                      end;
                 $34:       WriteLn('INC  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $35:       WriteLn('DEC  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $36: begin WriteLn('LD   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),'),',
                                                      HexAnzeige_Byte(Speicher_lesen_Byte(p + 3)));
                            len := 4;
                      end;
                 $39: begin WriteLn('ADD  ',ireg,',SP');
                            len := 2;
                      end;
                 $46: WriteLn('LD   B,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $4E: WriteLn('LD   C,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $56: WriteLn('LD   D,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $5E: WriteLn('LD   E,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $66: WriteLn('LD   H,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $6E: WriteLn('LD   L,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $7E: WriteLn('LD   A,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $86: WriteLn('ADD  A,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $8E: WriteLn('ADC  A,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $96: WriteLn('SUB  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p +	2)),')');
                 $9E: WriteLn('SBC  A,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $A6: WriteLn('AND  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $AE: WriteLn('XOR  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $B6: WriteLn('OR   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $BE: WriteLn('CP   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                 $CB: begin case Speicher_lesen_Byte(p + 3) of
                                 $06: WriteLn('RLC  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $0E: WriteLn('RRC  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $16: WriteLn('RL   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $1E: WriteLn('RR   (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $26: WriteLn('SLA  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $2E: WriteLn('SRA  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $3E: WriteLn('SRL  (',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $46: WriteLn('BIT  0,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $4E: WriteLn('BIT  1,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $56: WriteLn('BIT  2,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $5E: WriteLn('BIT  3,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $66: WriteLn('BIT  4,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $6E: WriteLn('BIT  5,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $76: WriteLn('BIT  6,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $7E: WriteLn('BIT  7,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $86: WriteLn('RES  0,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $8E: WriteLn('RES  1,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $96: WriteLn('RES  2,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $9E: WriteLn('RES  3,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $A6: WriteLn('RES  4,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $AE: WriteLn('RES  5,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $B6: WriteLn('RES  6,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $BE: WriteLn('RES  7,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $C6: WriteLn('SET  0,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $CE: WriteLn('SET  1,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $D6: WriteLn('SET  2,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $DE: WriteLn('SET  3,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $E6: WriteLn('SET  4,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $EE: WriteLn('SET  5,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $F6: WriteLn('SET  6,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                                 $FE: WriteLn('SET  7,(',ireg,'+',HexAnzeige_Byte(Speicher_lesen_Byte(p + 2)),')');
                            else
                                 WriteLn(unknown);
                            end;
                            len := 4;
                      end;
                 $E1: begin WriteLn('POP  ',ireg);
                            len := 2;
                      end;
                 $E3: begin WriteLn('EX   (SP),',ireg);
                            len := 2;
                      end;
                 $E5: begin WriteLn('PUSH ',ireg);
                            len := 2;
                      end;
                 $E9: begin WriteLn('JP   (',ireg,')');
                            len := 2;
                      end;
                 $F9: begin WriteLn('LD   SP,',ireg);
                            len := 2;
                      end;
      else
                      WriteLn(unknown);
      end;
      ddfd:=len;
ende:
end;

begin
end.
