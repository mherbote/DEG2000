uses Crt;

const HEX : string ='0123456789ABCDEF';
      PROG: string ='SYS213';

var  inp,out : File of Char;
     buffer,
     buffer2 : Array[0..127] of Char;
     NextChar: Char;
     Anz     : byte;
     StarAdr,
     NextAdr,
     k,x,x1,y,
     buf_len,
     buf_zei,
     buf_zei2,
     FSinp   : LongInt;
     PS1,PS2,
     RA1,RA2 : Word;
     ENDE    : Boolean;

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

procedure Adr_Wechsel;
begin
      NextAdr:=StarAdr+Anz;
      GotoXY(61, 1); Write('Startadresse: $',HexAnzeige_WordByte (StarAdr  ,'B'));
      GotoXY(61, 2); Write('LÑnge       : $',HexAnzeige_Byte     (Anz          ));
      if Anz=0 then begin GotoXY(22, 4); Write('Programm-Startadresse: $',HexAnzeige_WordByte(StarAdr   ,'B'));
                    end
               else begin if StarAdr=NextAdr then ReadLn;
                          GotoXY(61, 1); Write('                   ');
                          GotoXY(61, 2); Write('                   ');
                          GotoXY( 1, 1); Write('Startadresse: $',HexAnzeige_WordByte(StarAdr   ,'B'));
                          GotoXY( 1, 2); Write('LÑnge       : $',HexAnzeige_Byte    (Anz           ));
                          GotoXY(31, 1); Write('Next-adresse: $',HexAnzeige_WordByte(NextAdr   ,'B'));
                    end;
end;

procedure Read_inp;
begin buf_len:=0;
      repeat {$I-} Read(inp,buffer[buf_len]); {$I+}
             Inc(buf_len);
      until  (buf_len=128) or (IOResult=100);
      buf_zei:=0; Inc(RA1);
end;

function  NextChar_inp:Char;
begin NextChar_inp:=buffer[buf_zei];
      Inc(buf_zei); if buf_zei=buf_len then Read_inp;
      Dec(FSinp);   if FSinp=4         then ENDE:=TRUE;
end;

procedure AnzAdr_ermitteln;
begin Anz    :=ord(NextChar_inp);
      StarAdr:=        ord(NextChar_inp)*256;
      StarAdr:=StarAdr+ord(NextChar_inp);
end;

procedure Write_out;
begin for buf_zei2:=0 to 127 do Write(out,buffer2[buf_zei2]);
      buf_zei2:=0;
end;

procedure flush_out;
begin if buf_zei2>0
         then for buf_zei:=0 to buf_zei2-1 do Write(out,buffer2[buf_zei]);
end;

procedure out_NextChar(Char:Char);
begin buffer2[buf_zei2]:=Char;
      Inc(buf_zei2); if buf_zei2=128 then Write_out;
end;

begin TextBackground(Blue); TextColor(Yellow); ClrScr; ENDE:=FALSE;
      Assign(inp,PROG       ); Reset  (inp);
      Assign(out,PROG+'.BIN'); Rewrite(out);
      FSinp:=FileSize(inp); x:=1; y:=6; x1:=58; PS1:=$FFFF; RA1:=0; buf_zei2:=0;

      Read_inp; AnzAdr_ermitteln;
      out_NextChar(chr($FF              ));
      out_NextChar(chr(StarAdr AND $00FF)); out_NextChar(chr((StarAdr AND $FF00) SHR 8));
{***  erste LÑnge und Adresse}
      GotoXY( 1, 1); Write('Startadresse: $',HexAnzeige_WordByte(StarAdr   ,'B'));
      GotoXY( 1, 2); Write('LÑnge       : $',HexAnzeige_Byte    (Anz           ));
      GotoXY(31, 1); Write('Next-adresse: $',HexAnzeige_WordByte(NextAdr   ,'B'));
      repeat NextChar:=NextChar_inp;
             out_NextChar(NextChar);
             GotoXY(x ,y); Write(HexAnzeige_Byte(ord(NextChar)));
             GotoXY(x1,y); if (ord(NextChar)>$1F) and (ord(NextChar)<$7F)
                                then Write(NextChar)
                                else Write('.');
             Dec(Anz); if (Anz=0) AND NOT ENDE
                          then begin AnzAdr_ermitteln; Adr_Wechsel; end;
             Inc(x1 ); if x1=58+16 then x1:=58;
             Inc(x,3); case x of 1+ 4*3,
                                 2+ 8*3,
                                 3+12*3: Inc(x);
                                 4+16*3: begin x:=1; Inc(y);
                                               if y>24
                                                  then begin for y:=6 to 24 do
                                                                 begin GotoXY(x,y); ClrEol; end;
                                                             y:=6;
                                                       end;
                                         end;
                       end;
      until  ENDE;
      Dec(RA1);
      PS2:=ord(NextChar_inp)*256; PS2:=PS2+ord(NextChar_inp)    ;
      RA2:=ord(NextChar_inp)    ; RA2:=RA2+ord(NextChar_inp)*256;
      GotoXY(61, 1); Write('PrÅfsumme1  : $',HexAnzeige_WordByte(PS1,'B'));
      GotoXY(61, 2); Write('Anzahl Rec.1: $',HexAnzeige_WordByte(RA1,'B'));
      GotoXY(61, 3); Write('PrÅfsumme2  : $',HexAnzeige_WordByte(PS2,'B'));
      GotoXY(61, 4); Write('Anzahl Rec.2: $',HexAnzeige_WordByte(RA2,'B'));
      ReadLn;

      Close(inp); flush_out; Close(out);
end.