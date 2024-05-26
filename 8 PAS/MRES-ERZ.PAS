uses  Crt;

const HEX      : string ='0123456789ABCDEF';
      PATH     : string ='ES2000';
      PROG     : string ='';

type  zeile    = Array[0..15] of Byte;

var   inp,
      out      : File of zeile;
      buffer1,
      buffer2  : Array[0..7] of zeile;

      NextChar : Char;
      i,j,
      Datei,
      DateiAnz : byte;
      DAnz     : Word;
      DateiN   : Array[1..103] of string;
      DateiL   : Array[1..103] of Word;


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

procedure Schreiben_Block(s:Char; Anz:Byte);
  var i:Byte;
begin for i:=0 to 15 do buffer1[0][i]:=ord(s);
      buffer1[0][1]:=Anz;
      Write(out,buffer1[0]);
end;

procedure BM_schreiben;
begin Schreiben_Block('V',$10);
      Schreiben_Block('B',$10);
      Schreiben_Block('N',$10);
end;

begin TextBackground(Blue); TextColor(Yellow); ClrScr;
      Assign(out,PATH+'\'+PATH+'.CAS'); Rewrite(out);

      BM_schreiben;

{ Bandkopf im EBCD-Code }
      Assign(inp,PATH+'\'+PATH+'.VOL'); Reset(inp);
      for j:=1 to 3 do
          begin Schreiben_Block('V',$80);
                for i:=0 to 7 do Read (inp,buffer1[i]);
                for i:=0 to 7 do Write(out,buffer1[i]);
                Schreiben_Block('N',$80);
          end;
      Close (inp);
      BM_schreiben;

      Assign(inp,PATH+'\'+PATH+'.DIR'); Reset(inp);
{ Trennsatz }
      Schreiben_Block('V',$20);
      for i:=1 to 2 do Read (inp,buffer1[i]);
      for i:=1 to 2 do Write(out,buffer1[i]);
      Schreiben_Block('N',$20);
{ "DS"-Satz }
      Schreiben_Block('V',$20);
      for i:=1 to 2 do Read (inp,buffer1[i]);
      for i:=1 to 2 do Write(out,buffer1[i]);
      Schreiben_Block('N',$20);
{ Bibliothekssatz 1 ... 103 (max.) }
      j:=0; DateiAnz:=0;
      repeat Schreiben_Block('V',$20); Inc(j);
             for i:=1 to 2 do Read (inp,buffer1[i]);
             if  buffer1[2][7]<>j
                 then for i:=0 to 15 do begin buffer1[1][i]:=$A5;
                                              buffer1[2][i]:=$A5;
                                        end
                 else begin Inc(DateiAnz);
                            DateiL[DateiAnz]:=buffer1[2][10]*256+buffer1[2][9];
                            DateiN[DateiAnz]:='';
                            for i:=0 to 5 do DateiN[DateiAnz]:=DateiN[DateiAnz]+chr(buffer1[1][i]);
                            Write(DateiAnz:3,': ',DateiN[DateiAnz],' (',DateiL[DateiAnz]:6,')');
                      end;
             for i:=1 to 2 do Write(out,buffer1[i]);
             Schreiben_Block('N',$20);
      until  (j=103) or (Eof(inp));
      for i:=0 to 15 do begin buffer1[1][i]:=$A5; buffer1[2][i]:=$A5; end;
      while   j<103 do
      begin Schreiben_Block('V',$20); Inc(j);
            for i:=1 to 2 do Write(out,buffer1[i]);
            Schreiben_Block('N',$20);
      end;
      Close (inp);
      BM_schreiben;

{ Datei 1 ... 103 (max.) }
      for Datei:=1 to DateiAnz do
          begin
      { Blockkennzeichensatz "n" }
                for i:=0 to 15 do begin buffer1[1][i]:=0; buffer1[2][i]:=0; end;
                buffer1[1][0]:=Datei;
                Schreiben_Block('V',$20);
                for i:=1 to 2 do Write(out,buffer1[i]);
                Schreiben_Block('N',$20);
      { "k" Bl”cke der Datei "n" }
                Assign(inp,PATH+'\'+DateiN[Datei]); Reset(inp);
                for DAnz:=1 to DateiL[Datei] do
                    begin Schreiben_Block('V',$80);
                          for i:=0 to 7 do Read (inp,buffer1[i]);
                          for i:=0 to 7 do Write(out,buffer1[i]);
                          Schreiben_Block('N',$80);
                    end;
                Close(inp);
                BM_schreiben;
          end;
{ Blockkennzeichensatz "n"+1 }
      for i:=0 to 15 do begin buffer1[1][i]:=0; buffer1[2][i]:=0; end;
      buffer1[1][0]:=DateiAnz+1;
      Schreiben_Block('V',$20);
      for i:=1 to 2 do Write(out,buffer1[i]);
      Schreiben_Block('N',$20);
{ Schluálcke }
      Schreiben_Block('V',$10);
      Schreiben_Block('S',$10);
      Schreiben_Block('N',$10);

      Close(out);
end.