{$I DEFINE.INC}

unit Varia;

interface

const
      COPYR          : string ='Copyright (C) 1987-92 by Udo Munk';
      RELEASE        : string ='1.7';
      USR_COM        : string ='DEG2000-System Simulation';
      USR_REL        : string ='1.0';
      USR_CPR        : string ='Copyright (C) 1996 by Marcus Herbote';

      adr_err        : string = 'address out of range';

      const_Seg_BWS  : Byte   =3;                   { Adresse BWS im DEG2000 }
      Test           : string ='D E G 2 0 0 0';

      HISIZE         : Byte   = 100;           { number of entrys in history }
      SBSIZE         : Byte   =   4;        { number of software breakpoints }
      LENCMD         : Byte   =  80;         { length of command buffers etc }

      S_FLAG	     : Byte   = 128;          { bit definitions of CPU flags }
      Z_FLAG	     : Byte   =  64;
      N2_FLAG        : Byte   =  32;
      H_FLAG	     : Byte   =  16;
      N1_FLAG        : Byte   =   8;
      P_FLAG	     : Byte   =   4;
      N_FLAG	     : Byte   =   2;
      C_FLAG         : Byte   =   1;
                                                { operation of simulated CPU }
      SINGLE_STEP    : Byte   =   0;                           { single step }
      CONTIN_RUN     : Byte   =   1;	                     { continual run }
      STOPPED        : Byte   =   0;             { stop CPU because of error }
                                                           { causes of error }
      NONE           : Byte   =   0;                              { no error }
      OPHALT         : Byte   =   1;             { HALT      op-code    trap }
      IOTRAP         : Byte   =   2;             { IN/OUT               trap }
      OPTRAP1        : Byte   =   3;           { illegal 1 byte op-code trap }
      OPTRAP2        : Byte   =   4;           { illegal 2 byte op-code trap }
      OPTRAP4        : Byte   =   5;           { illegal 4 byte op-code trap }
      USERINT        : Byte   =   6;                   { user      interrupt }
                                                     { type of CPU interrupt }
      INT_NMI        : Byte   =   1;                { non maskable interrupt }
      INT_INT        : Byte   =   2;                    { maskable interrupt }

      break_flag     : Boolean=TRUE;        {TRUE=break at HALT, FALSE=execute HALT}

          { Table to get parritys as fast as possible }
      parrity        : Array[0..255] of Integer =
                     (0 { 00000000 }, 1 { 00000001 }, 1 { 00000010 }, 0 { 00000011 },
                      1 { 00000100 }, 0 { 00000101 }, 0 { 00000110 }, 1 { 00000111 },
                      1 { 00001000 }, 0 { 00001001 }, 0 { 00001010 }, 1 { 00001011 },
                      0 { 00001100 }, 1 { 00001101 }, 1 { 00001110 }, 0 { 00001111 },
                      1 { 00010000 }, 0 { 00010001 }, 0 { 00010010 }, 1 { 00010011 },
                      0 { 00010100 }, 1 { 00010101 }, 1 { 00010110 }, 0 { 00010111 },
                      0 { 00011000 }, 1 { 00011001 }, 1 { 00011010 }, 0 { 00011011 },
                      1 { 00011100 }, 0 { 00011101 }, 0 { 00011110 }, 1 { 00011111 },
                      1 { 00100000 }, 0 { 00100001 }, 0 { 00100010 }, 1 { 00100011 },
                      0 { 00100100 }, 1 { 00100101 }, 1 { 00100110 }, 0 { 00100111 },
                      0 { 00101000 }, 1 { 00101001 }, 1 { 00101010 }, 0 { 00101011 },
                      1 { 00101100 }, 0 { 00101101 }, 0 { 00101110 }, 1 { 00101111 },
                      0 { 00110000 }, 1 { 00110001 }, 1 { 00110010 }, 0 { 00110011 },
                      1 { 00110100 }, 0 { 00110101 }, 0 { 00110110 }, 1 { 00110111 },
                      1 { 00111000 }, 0 { 00111001 }, 0 { 00111010 }, 1 { 00111011 },
                      0 { 00111100 }, 1 { 00111101 }, 1 { 00111110 }, 0 { 00111111 },
                      1 { 01000000 }, 0 { 01000001 }, 0 { 01000010 }, 1 { 01000011 },
                      0 { 01000100 }, 1 { 01000101 }, 1 { 01000110 }, 0 { 01000111 },
                      0 { 01001000 }, 1 { 01001001 }, 1 { 01001010 }, 0 { 01001011 },
                      1 { 01001100 }, 0 { 01001101 }, 0 { 01001110 }, 1 { 01001111 },
                      0 { 01010000 }, 1 { 01010001 }, 1 { 01010010 }, 0 { 01010011 },
                      1 { 01010100 }, 0 { 01010101 }, 0 { 01010110 }, 1 { 01010111 },
                      1 { 01011000 }, 0 { 01011001 }, 0 { 01011010 }, 1 { 01011011 },
                      0 { 01011100 }, 1 { 01011101 }, 1 { 01011110 }, 0 { 01011111 },
                      0 { 01100000 }, 1 { 01100001 }, 1 { 01100010 }, 0 { 01100011 },
                      1 { 01100100 }, 0 { 01100101 }, 0 { 01100110 }, 1 { 01100111 },
                      1 { 01101000 }, 0 { 01101001 }, 0 { 01101010 }, 1 { 01101011 },
                      0 { 01101100 }, 1 { 01101101 }, 1 { 01101110 }, 0 { 01101111 },
                      1 { 01110000 }, 0 { 01110001 }, 0 { 01110010 }, 1 { 01110011 },
                      0 { 01110100 }, 1 { 01110101 }, 1 { 01110110 }, 0 { 01110111 },
                      0 { 01111000 }, 1 { 01111001 }, 1 { 01111010 }, 0 { 01111011 },
                      1 { 01111100 }, 0 { 01111101 }, 0 { 01111110 }, 1 { 01111111 },
                      1 { 10000000 }, 0 { 10000001 }, 0 { 10000010 }, 1 { 10000011 },
                      0 { 10000100 }, 1 { 10000101 }, 1 { 10000110 }, 0 { 10000111 },
                      0 { 10001000 }, 1 { 10001001 }, 1 { 10001010 }, 0 { 10001011 },
                      1 { 10001100 }, 0 { 10001101 }, 0 { 10001110 }, 1 { 10001111 },
                      0 { 10010000 }, 1 { 10010001 }, 1 { 10010010 }, 0 { 10010011 },
                      1 { 10010100 }, 0 { 10010101 }, 0 { 10010110 }, 1 { 10010111 },
                      1 { 10011000 }, 0 { 10011001 }, 0 { 10011010 }, 1 { 10011011 },
                      0 { 10011100 }, 1 { 10011101 }, 1 { 10011110 }, 0 { 10011111 },
                      0 { 10100000 }, 1 { 10100001 }, 1 { 10100010 }, 0 { 10100011 },
                      1 { 10100100 }, 0 { 10100101 }, 0 { 10100110 }, 1 { 10100111 },
                      1 { 10101000 }, 0 { 10101001 }, 0 { 10101010 }, 1 { 10101011 },
                      0 { 10101100 }, 1 { 10101101 }, 1 { 10101110 }, 0 { 10101111 },
                      1 { 10110000 }, 0 { 10110001 }, 0 { 10110010 }, 1 { 10110011 },
                      0 { 10110100 }, 1 { 10110101 }, 1 { 10110110 }, 0 { 10110111 },
                      0 { 10111000 }, 1 { 10111001 }, 1 { 10111010 }, 0 { 10111011 },
                      1 { 10111100 }, 0 { 10111101 }, 0 { 10111110 }, 1 { 10111111 },
                      0 { 11000000 }, 1 { 11000001 }, 1 { 11000010 }, 0 { 11000011 },
                      1 { 11000100 }, 0 { 11000101 }, 0 { 11000110 }, 1 { 11000111 },
                      1 { 11001000 }, 0 { 11001001 }, 0 { 11001010 }, 1 { 11001011 },
                      0 { 11001100 }, 1 { 11001101 }, 1 { 11001110 }, 0 { 11001111 },
                      1 { 11010000 }, 0 { 11010001 }, 0 { 11010010 }, 1 { 11010011 },
                      0 { 11010100 }, 1 { 11010101 }, 1 { 11010110 }, 0 { 11010111 },
                      0 { 11011000 }, 1 { 11011001 }, 1 { 11011010 }, 0 { 11011011 },
                      1 { 11011100 }, 0 { 11011101 }, 0 { 11011110 }, 1 { 11011111 },
                      1 { 11100000 }, 0 { 11100001 }, 0 { 11100010 }, 1 { 11100011 },
                      0 { 11100100 }, 1 { 11100101 }, 1 { 11100110 }, 0 { 11100111 },
                      0 { 11101000 }, 1 { 11101001 }, 1 { 11101010 }, 0 { 11101011 },
                      1 { 11101100 }, 0 { 11101101 }, 0 { 11101110 }, 1 { 11101111 },
                      0 { 11110000 }, 1 { 11110001 }, 1 { 11110010 }, 0 { 11110011 },
                      1 { 11110100 }, 0 { 11110101 }, 0 { 11110110 }, 1 { 11110111 },
                      1 { 11111000 }, 0 { 11111001 }, 0 { 11111010 }, 1 { 11111011 },
                      0 { 11111100 }, 1 { 11111101 }, 1 { 11111110 }, 0 { 11111111 });

type PHauptSpeicher  = ^HauptSpeicher;
     HauptSpeicher   = record HS : Array[0..1024*4-1] of Byte;
                       end;

     PBildSpeicher   = ^BildSpeicher;
     BildSpeicher    = record BWS: Array[0..1024*4-1] of Byte;
                       end;

     op_func         = function                  :Integer;
     op_funcp        = function(data:Integer)    :Integer;
     op_func2        = function(s:string; p:Word):Integer;

{$IFDEF HISIZE}        { structure of a history entry }
type history         = record h_adr  : Word; { address of execution }
                              h_af   : Word; { register AF }
                              h_bc   : Word; { register BC }
                              h_de   : Word; { register DE }
                              h_hl   : Word; { register HL }
                              h_ix   : Word; { register IX }
                              h_iy   : Word; { register IY }
                              h_sp   : Word; { register SP }
                       end;
{$ENDIF}

{$IFDEF SBSIZE}        { structure of a breakpoint }
type softbreak       = record sb_adr      : Word;    { address of breakpoint }
                              sb_oldopc   : Byte;    { op-code at address of breakpoint }
                              sb_passcount: Integer; { pass counter of breakpoint }
                              sb_pass     : Integer; { no. of pass to break }
                       end;
{$ENDIF}

var
     HS                   : Array[0..15] of PHauptSpeicher;
     BWS                  : PBildSpeicher;
     Seg_BWS              : Byte;
     xfn      {80=LENCMD} : Array[0..80] of Char; {buffer for filename (option -x) }
     A ,B ,C ,D ,E ,H ,L  : Byte;    { Z80 primary registers }
     A_,B_,C_,D_,E_,H_,L_ : Byte;    { Z80 secoundary registers }
     PC                   : Word;    { Z80 programm counter *PC }
     STACK                : Word;    { Z80 stackpointer     *STACK }
     III                  : Byte;    { Z80 interrupt register }
     IFF                  : Byte;    { Z80 interrupt flags }
     IX,IY                : Word;
     F ,F_                : Integer;
     R                    : LongInt; { Z80 refresh register }
     wrk_ram              : Word;    { workpointer into memory for dump etc. *wrk_ram }

     s_flag1              : Integer; {flag for -s option}
     l_flag               : Integer; {flag for -l option}
     m_flag               : Integer; {flag for -m option}
     x_flag               : Integer; {flag for -x option}
     cpu_state            : Integer; {      status of CPU emulation}
     cpu_error            : Byte;    {error status of CPU emulation}
     int_type             : Integer; {type	of interrupt}
     int_mode             : Integer; {CPU interrupt mode (IM 0, IM 1, IM 2)}
     cntl_c               : Integer; {flag	for cntl-c entered}
     cntl_bs              : Integer; {flag	for cntl-\ entered}

{$IFDEF HISIZE}
     his     {100=HISIZE} : Array[1..100] of history;  {memory to hold trace informations}
     h_next               : Integer; {index into trace memory}
     h_flag1              : Integer; {flag for trace memory overrun}
{$ENDIF}

{$IFDEF SBSIZE}
     soft      {10=SBSIZE} : Array[1..4] of softbreak; {memory to hold breakpoint informations}
     sb_next              : Integer;            {index into breakpoint memory}
{$ENDIF}

{$IFDEF WANT_TIM}
     t_states   {number of counted T states}: LongInt;
     t_flag     {flag, 1 = on, 0 = off}     : Integer;
     t_start                                : Word;
     t_end                                  : Word;
{    #if !defined(COHERENT) || defined(_I386)
        BYTE *t_start =	ram + 65535;	 start address for measurement
        BYTE *t_end = ram + 65535;	 end address for measurement
     #else
        BYTE *t_start =	ram + 32767;
        BYTE *t_end = ram + 32767;
     #endif}
{$ENDIF}

procedure Speicher_bereitstellen;
procedure Speicher_freigeben;
function  Seg_Adresse(Adresse:Word):Byte;
function  Speicher_lesen_Byte(Adresse:Word):Byte;
function  Speicher_lesen_Word(Adresse:Word):Word;
procedure Speicher_schreiben_Byte(Adresse:Word; B:Byte);
procedure Speicher_schreiben_Word(Adresse:Word; W:Word);
procedure DEG2000_Init;
procedure BWS_anzeigen;
function  HexAnzeige_Byte(Wert:Byte):string;
function  HexAnzeige_WordByte(Wert:Word; Steuerung:char):string;
procedure fgets(var cmd:Array of Char);
function  atoi  (cmd:Array of Char; var i:Integer):LongInt;
function  exatoi(cmd:Array of Char; var i:Integer):LongInt;
procedure int_on;
procedure int_off;
procedure user_int;
procedure quit_int;

implementation

uses WinCrt;

const HEX : string ='0123456789ABCDEF';

procedure Speicher_bereitstellen;
  var i1,i2 : Integer;
begin for i1:=0 to 15 do
{          if MaxAvail < SizeOf(HauptSpeicher)
             then begin Writeln('Not enough memory for ''HauptSpeicher'' ',i1); halt; end
             else} begin New(HS[i1]);
                        for i2:=0 to 1024*4-1 do HS[i1]^.HS[i2]:=0;
                  end;
{      if MaxAvail < SizeOf(BildSpeicher)
         then begin Writeln('Not enough memory for ''BildSpeicher'''); halt; end
         else} begin New(BWS);
                    for i2:=0 to 1024*4-1 do BWS^.BWS[i2]:=0;
              end;
      A :=0; F :=0; B :=0; C :=0; D :=0; E :=0; H :=0; L :=0;
      A_:=0; F_:=0; B_:=0; C_:=0; D_:=0; E_:=0; H_:=0; L_:=0;
      IX:=0; IY:=0; PC:=0; STACK:=0; III:=0; IFF:=0; R:=0;
end;

procedure Speicher_freigeben;
  var i : Integer;
begin for i:=0 to 15 do Dispose(HS[i]);
      Dispose(BWS);
end;

function Seg_Adresse(Adresse:Word):Byte;
begin Seg_Adresse:=(Adresse DIV 256) DIV 16; end;

function Speicher_lesen_Byte(Adresse:Word):Byte;
begin Speicher_lesen_Byte:=HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)  ];
end;

function Speicher_lesen_Word(Adresse:Word):Word;
begin Speicher_lesen_Word:=HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)+1]*256+
                           HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)  ];
end;

procedure Speicher_schreiben_Byte(Adresse:Word; B:Byte);
begin HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)  ]:=B;
end;

procedure Speicher_schreiben_Word(Adresse:Word; W:Word);
begin HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)+1]:=(W DIV 256);
      HS[Seg_Adresse(Adresse)]^.HS[(Adresse AND $FFF)  ]:=(W AND 255);
end;

procedure DEG2000_Init;
  var i : Integer;
begin Seg_BWS:=const_Seg_BWS;
{      for i1:=0 to 1024*4-1 do i1:=1024*4-1;
          Speicher_schreiben_Byte(Seg_BWS*1024*4+i1,ord(' '));}
end;

procedure BWS_anzeigen;
  var Z,S,z1,s1 : Integer;
      B         : Byte;
begin ClrScr;
      for Z:=0 to 23 do
          for S:=0 to 79 do
              begin
                    B := (HS[Seg_BWS]^.HS[Z*80+S]);
                    Write(chr(B AND $7F));
                    if (B AND $80)=$80 then begin z1:=Z; s1:=S; end;
              end;
      GotoXY(s1+1,z1+1);
end;

procedure BWS_load;
begin ClrScr;
end;

procedure BWS_wait;
  var c : Char;
begin repeat while NOT (ReadKey=chr(0)) do ;
             c:=ReadKey;
      until c=chr(48);
end;

function HexAnzeige_Byte(Wert:Byte):string;
begin HexAnzeige_Byte:=HEX[((Wert AND 255) DIV 16)+1]+HEX[((Wert AND 255) AND 15)+1];
end;

function HexAnzeige_WordByte(Wert:Word; Steuerung:char):string;
begin case Steuerung of 'H': HexAnzeige_WordByte:=HEX[((Wert DIV 256) DIV 16)+1]+HEX[((Wert DIV 256) AND 15)+1];
                        'L': HexAnzeige_WordByte:=HEX[((Wert AND 255) DIV 16)+1]+HEX[((Wert AND 255) AND 15)+1];
                        'B': HexAnzeige_WordByte:=HEX[((Wert DIV 256) DIV 16)+1]+HEX[((Wert DIV 256) AND 15)+1]+
                                                  HEX[((Wert AND 255) DIV 16)+1]+HEX[((Wert AND 255) AND 15)+1];
                        'S': HexAnzeige_WordByte:=HEX[((Wert DIV 256) DIV 16)+1];
      end;
end;

procedure fgets(var cmd:Array of Char);
  var i     : Integer;
      c1,c2 : Char;
begin
      for i:=1 to 80 do cmd[i]:=' '; i:=0;
      repeat c1:=ReadKey;
             case c1 of 'a'..'z'
                       ,'A'..'Z',
                        '0'..'9',
        '.',',','?','!',' ','''',
                        chr($0D): begin Inc(i); cmd[i]:=c1; Write(cmd[i]); end;
                        chr($08): if i>0 then begin cmd[i]:=' '; Dec(i);
                                                    Write(chr($08),' ',chr($08));
                                              end;
                        chr($00): begin c2:=ReadKey;
                                        case c2 of chr(48): begin      {ALT B}
                                                                  BWS_anzeigen;
                                                                  BWS_wait;
                                                                  BWS_load;
                                                            end;
                                        end;
                                  end;
             else
             end;
      until  (c1=chr($0D)) OR (i=80);
end;

function atoi(cmd:Array of Char; var i:Integer):LongInt;
  var num : LongInt;
begin
      num := 0;
      while (cmd[i] in ['0'..'9']) do
            begin
                  num := num * 10;
                  num := num + ord(cmd[i] )-ord('0');
                  Inc(i);
            end;
      atoi:=num;
end;

function exatoi(cmd:Array of Char; var i:Integer):LongInt;
  var num : LongInt;
begin
      num := 0;
      while (cmd[i] in ['a'..'f','A'..'F','0'..'9']) do
            begin
                  num := num * 16;
                  if (cmd[i] <= '9') then num := num + ord(       cmd[i] )-ord('0')
                                     else num := num + ord(UpCase(cmd[i]))-ord('7');
                  Inc(i);
            end;
      exatoi:=num;
end;

{	nmi_int()	: handler for non maskable interrupt (Z80)
 	int_int()	: handler for     maskable interrupt (Z80)
}
procedure int_on;                            { initialize interrupt handlers }
begin
{      signal(SIGINT,  user_int);
      signal(SIGQUIT, quit_int);}
end;

procedure int_off;                             { reset interrupts to default }
begin
{      signal(SIGINT,  SIG_DFL);
      signal(SIGQUIT, SIG_DFL); }
end;

procedure user_int;                    { handler for user interrupt (CNTL-C) }
begin
{      signal(SIGINT, user_int);}
{$IFDEF CNTL_C}
      cpu_error := USERINT;
      cpu_state := STOPPED;
{$ELSE}
      cntl_c := cntl_c + 1;
{$ENDIF}
end;

procedure quit_int;                              { handler for signal "quit" }
begin
{      signal(SIGQUIT, quit_int);}
{$IFDEF CNTL_BS}
      cpu_error := USERINT;
      cpu_state := STOPPED;
{$ELSE}
      cntl_bs := cntl_bs + 1;
{$ENDIF}
end;

end.
