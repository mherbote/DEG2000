{$I DEFINE.INC}

uses Crt,Mon1,Varia,IOSim1;

{ This function loads the CPU and memory from the file CORE.DEG }
procedure load_core;
  var fd         : file of Byte;
      x,x1,x2,x3 : Byte;
      y1         : Integer absolute x3;
      y2         : LongInt absolute x3;
      y3         : Word    absolute x3;
      p          : Word;
  label ende;
begin Assign(fd,'CORE.DEG'); Reset(fd);
      if IOResult<>0 then begin Writeln('CAN''T OPEN FILE CORE.DEG');
                                Goto ende;
                          end;
      Read(fd,A  );
      Read(fd,x3 ); Read(fd,x2); Read(fd,x1); Read(fd,x); F  := y1;
      Read(fd,B  );
      Read(fd,C  );
      Read(fd,D  );
      Read(fd,E  );
      Read(fd,H  );
      Read(fd,L  );
      Read(fd,A_ );
      Read(fd,x3 ); Read(fd,x2); Read(fd,x1); Read(fd,x); F_ := y1;
      Read(fd,B_ );
      Read(fd,C_ );
      Read(fd,D_ );
      Read(fd,E_ );
      Read(fd,H_ );
      Read(fd,L_ );
      Read(fd,III); Read(fd,x1);
      Read(fd,IFF); Read(fd,x1);
      Read(fd,x3 ); Read(fd,x2); R := y3;
      Read(fd,x3 ); Read(fd,x2); Read(fd,x1); Read(fd,x); PC    := y2;
      Read(fd,x3 ); Read(fd,x2); Read(fd,x1); Read(fd,x); STACK := y2;
      Read(fd,x  ); IX    := x; Read(fd,x ); IX    := IX + x * 256;
      Read(fd,x  ); IY    := x; Read(fd,x ); IY    := IY + x * 256;
      for p:=0 to $FFFF do
          begin Read(fd,x  );
                Speicher_schreiben_Byte(p,x);
          end;
      Close(fd);
ende:
end;

{ This function saves the CPU and the memory into the file CORE.Z80 }
procedure save_core;
  var fd         : file of Byte;
      x,x1,x2,x3 : Byte;
      y1         : Integer absolute x3;
      y2         : LongInt absolute x3;
      y3         : Word    absolute x3;
      p          : Word;
  label ende;
begin Assign(fd,'CORE.DEG'); Rewrite(fd);
      if IOResult<>0 then begin Writeln('CAN''T OPEN FILE CORE.DEG');
                                Goto ende;
                          end;
      Write(fd,A  ); y1 :=    F ; Write(fd,x3); Write(fd,x2); Write(fd,x1); Write(fd,x);
      Write(fd,B  );              Write(fd,C );
      Write(fd,D  );              Write(fd,E );
      Write(fd,H  );              Write(fd,L );
      Write(fd,A_ ); y1 :=    F_; Write(fd,x3); Write(fd,x2); Write(fd,x1); Write(fd,x);
      Write(fd,B_ );              Write(fd,C_);
      Write(fd,D_ );              Write(fd,E_);
      Write(fd,H_ );              Write(fd,L_);
      Write(fd,III); x1 :=    0 ; Write(fd,x1);
      Write(fd,IFF); x1 :=    0 ; Write(fd,x1);
                     y3 :=    R ; Write(fd,x3); Write(fd,x2);
                     y2 :=    PC; Write(fd,x3); Write(fd,x2); Write(fd,x1); Write(fd,x);
                     y2 := STACK; Write(fd,x3); Write(fd,x2); Write(fd,x1); Write(fd,x);
               x := IX AND $00FF; Write(fd,x  );
       x := (IX AND $FF00) shr 8; Write(fd,x  );
               x := IY AND $00FF; Write(fd,x  );
       x := (IY AND $FF00) shr 8; Write(fd,x  );
      for p:=0 to $FFFF do
          begin x := Speicher_lesen_Byte(p); Write(fd,x); end;
      Close(fd);
ende:
end;

procedure main;
  var i,j: Integer;
      p  : Word;
      s  : Char;
      s1 : String;
begin if (ParamCount>0)
      then begin for i:=1 to ParamCount do
                 begin s1:=ParamStr(i);
                       if s1[1]='-'
                       then begin s:=s1[2];
                                  case s of 's': { save core and CPU on exit }
                                                 s_flag1     := 1;
                                            'l': { load core and CPU from file }
                                                 l_flag      := 1;
                                            'h': { execute HALT opcode }
                                                 break_flag  := FALSE;
                                            'm': begin { initialize Z80 memory }
                                                       for j:=3 to Length(ParamStr(i)) do xfn[j-2]:=s1[j];
                                                       j:=1; m_flag:= exatoi(xfn,j);
                                                 end;
                                            'x': begin { get filename with Z80 executable }
                                                       x_flag:=1;
                                                       for j:=3 to Length(ParamStr(i)) do xfn[j-2]:=s1[j];
                                                 end;
                                  else begin WriteLn('illegal option ',ParamStr(1));
                                             WriteLn('usage:  ',ParamStr(0),' [-s -l -h -mn -xfilename]');
                                             WriteLn('          s = save core and cpu');
                                             WriteLn('          l = load core and cpu');
                                             WriteLn('          h = execute HALT op-code');
                                             WriteLn('          m = init memory with n');
                                             WriteLn('          x = load and execute filename');
{                                             exit(1);}
                                       end;
                                  end;
                            end;
                 end;
           end;
      ClrScr;
      WriteLn('#######  #####    ###            #####    ###   #     #');
      WriteLn('     #  #     #  #   #          #     #    #    ##   ##');
      WriteLn('    #   #     # #     #         #          #    # # # #');
      WriteLn('   #     #####  #     #  #####   #####     #    #  #  #');
      WriteLn('  #     #     # #     #               #    #    #     #');
      WriteLn(' #      #     #  #   #          #     #    #    #     #');
      WriteLn('#######  #####    ###            #####    ###   #     #');
      WriteLn('Release ',RELEASE,', ',COPYR);

{$IFDEF	USR_COM}
      WriteLn(USR_COM,' Release ',USR_REL,', ',USR_CPR);
{$ENDIF}

{break_flag  := FALSE;}
      wrk_ram := 0;
      PC      := 0;
      STACK   := 0;
      sb_next := 1;
      h_next  := 1;
      for p:=0 to $FFFF do Speicher_schreiben_Byte(p,m_flag);
      for p:=1 to Length(Test) do HS[Seg_BWS]^.HS[p-1]:=ord(Test[p]);

      if (l_flag =1) then load_core;
      int_on;
      init_io;
      mon;
      if (s_flag1=1) then save_core;
      exit_io;
      int_off;
{      exit(0);}
end;



begin
{      i:= $EFFF+$FFDD;
      ClrScr; Write(HexAnzeige_WordByte(i,'B'));
end.}
      Speicher_bereitstellen;
      DEG2000_Init;
      main;
      Speicher_freigeben;
end.
