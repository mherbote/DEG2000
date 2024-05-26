{$I DEFINE.INC}

uses Crt,Varia,CPU1,CB,DD,ED,FD,DDCB,FDCB;

const
{      const_Reg      : string ='BCDEHL A';}
                              { D7 D6 D5 D4 D3 D2 D1 D0

                                S  Z     H     PV N  C  }
{      const_Reg_     : string ='bcdehl a';
      const_Flag     : string ='CNP H Z S';
      const_Flag_    : string ='cnp h z s';}



var
     Befehl               : Array[0.. 3] of Byte;
     i1,i2                : Integer;

procedure BWS_laden;
  var I:Integer;
begin for I:=0 to 1024*4-1 do BWS^.BWS[I]:=HS[Seg_BWS]^.HS[I];
end;

procedure Register_anzeigen;
begin
{$IFDEF DEBUG1}
      BWS_anzeigen; ReadKey;
{$ENDIF}
      GotoXY( 1, 1); Write('Register AF : ',HexAnzeige_Byte(A ),HexAnzeige_Byte(F ));
      GotoXY(21, 1); Write(       ' AF'': ',HexAnzeige_Byte(A_),HexAnzeige_Byte(F_));
      GotoXY( 1, 3); Write('Register BC : ',HexAnzeige_Byte(B ),HexAnzeige_Byte(C ));
      GotoXY(21, 3); Write(       ' BC'': ',HexAnzeige_Byte(B_),HexAnzeige_Byte(C_));
      GotoXY( 1, 4); Write('Register DE : ',HexAnzeige_Byte(D ),HexAnzeige_Byte(E ));
      GotoXY(21, 4); Write(       ' DE'': ',HexAnzeige_Byte(D_),HexAnzeige_Byte(E_));
      GotoXY( 1, 5); Write('Register HL : ',HexAnzeige_Byte(H ),HexAnzeige_Byte(L ));
      GotoXY(21, 5); Write(       ' HL'': ',HexAnzeige_Byte(H_),HexAnzeige_Byte(L_));
      GotoXY( 1, 7); Write('IndexRegister IX : ' ,HexAnzeige_WordByte(IX   ,'B'));
      GotoXY( 1, 8); Write('IndexRegister IY : ' ,HexAnzeige_WordByte(IY   ,'B'));
      GotoXY( 1,10); Write('StackPointer  SP : ' ,HexAnzeige_WordByte(STACK,'B'));
      GotoXY( 1,11); Write('Befehlsz„hler PC : ' ,HexAnzeige_WordByte(PC   ,'B'));

{      GotoXY(41, 1); Write( 'Flags : S =' ,F_Int(Flag_lesen('S')),
                                   ' Z =' ,F_Int(Flag_lesen('Z')),' H =' ,F_Int(Flag_lesen('H')),
                                   ' P =' ,F_Int(Flag_lesen('P')),' N =' ,F_Int(Flag_lesen('N')),
                                   ' C =' ,F_Int(Flag_lesen('C')));
      GotoXY(41, 2); Write('Flags'': S''=',F_Int(Flag_lesen('s')),
                                   ' Z''=',F_Int(Flag_lesen('z')),' H''=',F_Int(Flag_lesen('h')),
                                   ' P''=',F_Int(Flag_lesen('p')),' N''=',F_Int(Flag_lesen('n')),
                                   ' C''=',F_Int(Flag_lesen('c')));}
      GotoXY( 1,14);
{$IFDEF DEBUG1}
      ReadKey;
{$ENDIF}
end;


{****************}
{*** Haupteil ***}
{****************}
begin ClrScr;
      DEG2000_Init;
      Speicher_bereitstellen;

{$IFDEF DEBUG}
      for i1:=1 to Length(Test) do HS[Seg_BWS]^.HS[i1-1]:=ord(Test[i1]);
      Register_anzeigen;
{$ENDIF}

{$IFDEF TEST1}
      for i1:=0 to 3 do Write(HexAnzeige_Byte(Befehl[i1]),' ');
      Writeln;

      Word_belegen(BC,'H',12,10);
      Word_belegen(BC,'L', 1,15);
      Writeln(HexAnzeige_WordByte(BC,'H'),' - ',HexAnzeige_WordByte(BC,'L'));
      Writeln(HexAnzeige_WordByte(BC,'B'));
      Writeln(Seg_Adresse(BC));
{$ENDIF}

{$IFDEF TEST2}
{      for i1:=0 to 5 do  ByteReg_schreiben(const_Reg [i1+1],i1+ 1);
      for i1:=0 to 5 do  ByteReg_schreiben(const_Reg_[i1+1],i1+17);
      ByteReg_schreiben(const_Reg [8],7+17);
      ByteReg_schreiben(const_Reg_[8],7+17);
      Register_anzeigen;}
{$ENDIF}

{$IFDEF TEST3}
      for i1:=0 to  7 do Speicher_schreiben_Byte(i1,$78+i1);
      for i1:=0 to  7 do Write(HexAnzeige_Byte(Speicher_lesen_Byte(i1)),' ');
      Writeln;
{      for i1:=0 to  7 do
          begin Befehl_laden;
                Befehl_auswerten;
                Register_anzeigen;
          end;}
{$ENDIF}

      Speicher_freigeben;
end.
