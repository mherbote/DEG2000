uses  Crt;

const HEX      : string ='0123456789ABCDEF';
      PATH     : string ='ES2000';
      PROG     : string ='';
      EBDC     : Array[0..255] of Byte = ($00,$01,$02,$03,$04,$09,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
                                          $10,$11,$12,$13,$14,$15,$08,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
                                          $20,$21,$22,$23,$24,$0A,$17,$1B,$28,$29,$2A,$2B,$2C,$05,$06,$07,
                                          $30,$31,$36,$33,$34,$35,$36,$34,$38,$39,$3A,$3B,$14,$15,$3E,$1A,
                                          $20,$41,$42,$43,$44,$45,$46,$47,$48,$49,$5B,$2E,$3C,$28,$2B,$21,
                                          $26,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5D,$24,$2A,$29,$3B,$5E,
                                          $2D,$2F,$62,$63,$64,$65,$66,$67,$68,$69,$7C,$2C,$25,$5F,$3E,$3F,
                                          $70,$71,$72,$73,$74,$75,$76,$77,$78,$60,$3A,$23,$40,$27,$3D,$22,
                                          $80,$61,$62,$63,$64,$65,$66,$67,$68,$69,$8A,$8B,$8C,$8D,$8E,$8F,
                                          $90,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$9A,$9B,$9C,$9D,$9E,$9F,
                                          $A0,$7E,$73,$74,$75,$76,$77,$78,$79,$7A,$AA,$AB,$AC,$AD,$AE,$AF,
                                          $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,
                                          $7B,$41,$42,$43,$44,$45,$46,$47,$48,$49,$CA,$CB,$CC,$CD,$CE,$CF,
                                          $7D,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$DA,$DB,$DC,$DD,$DE,$DF,
                                          $5C,$E1,$53,$54,$55,$56,$57,$58,$59,$5A,$EA,$EB,$EC,$ED,$EE,$EF,
                                          $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$FA,$FB,$FC,$FD,$FE,$7F);

type  zeile    = Array[0.. 15] of Byte;

var   inp,
      out      : File of zeile;
      buffer   : Array[0..8] of zeile;

      SChar    : Char;
      FPos     : LongInt;
      i,j,
      Anz      : byte;
      DAnz     : Word;
      DateiN   : Array[1..103] of string;
      DateiL   : Array[1..103] of Word;
      Ende     : Boolean;
      cmd      : Char;
      D,E      : Byte;
      D1,E1    : Byte;

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

function Lesen_Record:Byte;
  var i,Anz:Byte;
begin if FilePos(inp)<FileSize(inp)-2
         then begin Read(inp,buffer[0]);
                    if chr(buffer[0][0])<>'V' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                                         halt;
                                                   end;
                    Anz:=buffer[0][1] SHR 4;
                    for i:=1 to Anz do Read(inp,buffer[i]);
                    Read(inp,buffer[0]);
                    if chr(buffer[0][0])<>'N' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                                         halt;
                                                   end;
                    Lesen_Record:=Anz;
              end;
end;

procedure Next_Record;
  var i,Anz:Byte;
begin Read(inp,buffer[0]);
      if chr(buffer[0][0])<>'V' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                           halt;
                                     end;
      Anz:=buffer[0][1] SHR 4;
      Seek(inp,FilePos(inp)+Anz); Read(inp,buffer[0]);
      if chr(buffer[0][0])<>'N' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                           halt;
                                     end;
end;

function Back_Record:Byte;
  var i,Anz:Byte;
begin if FilePos(inp)>0
         then begin Seek(inp,FilePos(inp)-1); Read(inp,buffer[0]);
                    if chr(buffer[0][0])<>'N' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                                         halt;
                                                   end;
                    Anz:=buffer[0][1] SHR 4;
                    for i:=Anz downto 1 do begin Seek(inp,FilePos(inp)-2); Read(inp,buffer[i]); end;
                    Seek(inp,FilePos(inp)-2); Read(inp,buffer[0]);
                    if chr(buffer[0][0])<>'V' then begin GotoXY(1,15); Write('Fehler: ',chr(buffer[0][0]));
                                                         halt;
                                                   end;
                    Seek(inp,FilePos(inp)-1);
                    Back_Record:=Anz;
              end;
end;

function Next_BM:Byte;
  var i,Anz:Byte;
begin repeat Anz:=Lesen_Record;
      until  ((Anz=1) AND (chr(buffer[1][0])='B')) OR (FilePos(inp)=FileSize(inp));
      Next_BM:=Anz;
end;

function Previous_BM:Byte;
  var i,Anz:Byte;
begin repeat Anz:=Back_Record;
      until  (Anz=1) AND (chr(buffer[1][0])='B');
      Anz:=Lesen_Record;
      Previous_BM:=Anz;
end;

function BM_nr(nr:Byte):Byte;
  var i,Anz:Byte;
begin for i:=1 to nr do
          begin repeat Anz:=Lesen_Record;
                until  ((Anz=1) AND (chr(buffer[1][0])='B')) OR (FilePos(inp)=FileSize(inp));
          end;
      BM_nr:=Anz;
end;

procedure Rewind;
begin Seek(inp,0); end;

procedure AnfAnzeige;
  var i:Byte;
begin
      GotoXY(1, 1); ClrEol; Write('FilePos: ',FilePos(inp));
      GotoXY(1,15); ClrEol;
      GotoXY(1, 4); Write('   0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      0123456789ABCDEF');
      for i:=1 to 8 do
          begin GotoXY(1,5+i); Write(i:1,': '); ClrEol; end;
end;

procedure CRC(Buf:zeile);
  var B1,B2,A,C : Byte;
      CY,CY1,CY2: Byte;
begin for B1:=0 to 15 do
          begin C:=Buf[B1];
                for B2:=1 to 8 do
                    begin A:=C;
                          A:=A XOR D;
                          if (A AND $01)=$01 then CY :=1 else CY :=0;
                          A:=A SHR 1; if CY =1 then A:=A OR $80;

                          if (E AND $01)=$01 then CY1:=1 else CY1:=0;
                          E:=E SHR 1; if CY =1 then E:=E OR $80;

                          if (D AND $01)=$01 then CY2:=1 else CY2:=0;
                          D:=D SHR 1; if CY1=1 then D:=D OR $80;
                          if CY=1 then begin D:=D XOR $01;
                                             E:=E XOR $20;
                                       end;
                          if (C AND $01)=$01 then CY :=1 else CY :=0;
                          C:=C SHR 1; if CY =1 then C:=C OR $80;
                    end;
          end;
end;

begin TextBackground(Blue); TextColor(Yellow); ClrScr; Ende:=FALSE;
      Assign(inp,PATH+'.CAS'); Reset(inp);

      repeat Anz:=Lesen_Record;
             if Anz>0 then AnfAnzeige;
             case Anz of 1: begin case buffer[1][0] of ord('B'): begin GotoXY(1,15); Write('B a n d M a r k e');
                                                                 end;
                                                       ord('S'): begin GotoXY(1,15); Write('S c h l u á L  c k e');
                                                                       Ende:=TRUE;
                                                                 end;
                                  else                           begin GotoXY(4,6);
                                                                       for i:=0 to 15 do
                                                                           Write(HexAnzeige_Byte(buffer[1][i]),' ');
                                                                       Write('    ');
                                                                       for i:=0 to 15 do
                                                                           if (buffer[1][i]>$1F) AND (buffer[1][i]<$7F)
                                                                              then Write(chr(buffer[1][i]))
                                                                              else Write('.');
                                                                 end;
                                  end;
                            end;
                         2: begin D:=0; E:=0;
                                  for j:=1 to 2 do
                                      begin GotoXY(4,5+j);
                                            for i:=0 to 15 do
                                                Write(HexAnzeige_Byte(buffer[j][i]),' ');
                                            Write('    ');
                                            for i:=0 to 15 do
                                                if (buffer[j][i]>$1F) AND (buffer[j][i]<$7F)
                                                   then Write(chr(buffer[j][i]))
                                                   else Write('.');
                                            CRC(buffer[j]);
                                      end;
                                  GotoXY(36, 1); Write('CRC-Satz : ',HexAnzeige_Byte(buffer[0][14]),
                                                                     HexAnzeige_Byte(buffer[0][15]));
                                  buffer[0][14]:=D; buffer[0][15]:=E;
                                  Seek(inp,FilePos(inp)-1); Write(inp,buffer[0]);
                                  GotoXY(56, 1); Write('CRC-Satz : ',HexAnzeige_Byte(D),HexAnzeige_Byte(E));
                                  D1:=0; E1:=0;
                                  GotoXY(56, 2); Write('CRC-Datei: ',HexAnzeige_Byte(D1),HexAnzeige_Byte(E1));
                            end;
                         8: begin D:=0; E:=0;
                                  for j:=1 to 8 do
                                      begin GotoXY(4,5+j);
                                            for i:=0 to 15 do
                                                if (FilePos(inp)>5) AND (FilePos(inp)<75)
                                                   then Write(HexAnzeige_Byte(EBDC[buffer[j][i]]),' ')
                                                   else Write(HexAnzeige_Byte(     buffer[j][i]) ,' ');
                                            Write('    ');
                                            for i:=0 to 15 do
                                                if (FilePos(inp)>5) AND (FilePos(inp)<75)
                                                   then begin if (EBDC[buffer[j][i]]>$1F) AND (EBDC[buffer[j][i]]<$7F)
                                                                 then Write(chr(EBDC[buffer[j][i]]))
                                                                 else Write('.');
                                                        end
                                                   else begin if (buffer[j][i]>$1F) AND (buffer[j][i]<$7F)
                                                                 then Write(chr(buffer[j][i]))
                                                                 else Write('.');
                                                        end;
                                            CRC(buffer[j]);
                                      end;
                                  GotoXY(36, 1); Write('CRC-Satz : ',HexAnzeige_Byte(buffer[0][14]),
                                                                     HexAnzeige_Byte(buffer[0][15]));
                                  buffer[0][14]:=D; buffer[0][15]:=E;
                                  Seek(inp,FilePos(inp)-1); Write(inp,buffer[0]);
                                  GotoXY(56, 1); Write('CRC-Satz : ',HexAnzeige_Byte(D),HexAnzeige_Byte(E));
                                  D:=D1; E:=E1;
                                  for j:=1 to 8 do CRC(buffer[j]);
                                  D1:=D; E1:=E;
                                  GotoXY(56, 2); Write('CRC-Datei: ',HexAnzeige_Byte(D1),HexAnzeige_Byte(E1));
                            end;
             else
             end;
      until  Ende;

      Close(inp);
end.