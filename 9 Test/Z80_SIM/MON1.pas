{$I DEFINE.INC}

{ This modul is an ICE type user interface to debug Z80 programs
  on a host system.
}

unit MON1;

interface

uses WinCrt,Varia,CPU1,DISAS1;

procedure mon;

implementation

var cmd   : Array[0..80] of Char;   {80 = LENCMD}

procedure print_head;                  { Output header for the CPU registers }
begin
      WriteLn;
      WriteLn('PC   A  SZHPNC I  IFF BC   DE   HL   A''F'' B''C'' D''E'' H''L'' IX   IY   SP');
end;

procedure print_reg;                              { Output all CPU registers }
begin
      Write(HexAnzeige_WordByte(PC,'B'),' ',HexAnzeige_Byte(A),' ');
      if (F AND S_FLAG)=S_FLAG then Write('1') else Write('0');
      if (F AND Z_FLAG)=Z_FLAG then Write('1') else Write('0');
      if (F AND H_FLAG)=H_FLAG then Write('1') else Write('0');
      if (F AND P_FLAG)=P_FLAG then Write('1') else Write('0');
      if (F AND N_FLAG)=N_FLAG then Write('1') else Write('0');
      if (F AND C_FLAG)=C_FLAG then Write('1') else Write('0');
      Write(' ',HexAnzeige_Byte(III),' ');
      if (IFF AND 1)=1 then Write('1') else Write('0');
      if (IFF AND 2)=2 then Write('1') else Write('0');
      Write('  ',HexAnzeige_Byte(B ),HexAnzeige_Byte(C ),
             ' ',HexAnzeige_Byte(D ),HexAnzeige_Byte(E ),
             ' ',HexAnzeige_Byte(H ),HexAnzeige_Byte(L ),
             ' ',HexAnzeige_Byte(A_),HexAnzeige_Byte(F_),
             ' ',HexAnzeige_Byte(B_),HexAnzeige_Byte(C_),
             ' ',HexAnzeige_Byte(D_),HexAnzeige_Byte(E_),
             ' ',HexAnzeige_Byte(H_),HexAnzeige_Byte(L_),
             ' ',HexAnzeige_WordByte(IX   ,'B'),
             ' ',HexAnzeige_WordByte(IY   ,'B'),
             ' ',HexAnzeige_WordByte(STACK,'B'));
      WriteLn;
end;

procedure cpu_err_msg;                  { Error handler after CPU is stopped }
begin
      case cpu_error of 0: ;
                        1: WriteLn('HALT Op-Code reached at ',HexAnzeige_WordByte(PC-1,'B'));
                        2: WriteLn('I/O Trap at ',HexAnzeige_WordByte(PC,'B'));
                        3: WriteLn('Op-code trap at ',HexAnzeige_WordByte(PC-1,'B'),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-1)));
                        4: WriteLn('Op-code trap at ',HexAnzeige_WordByte(PC-2,'B'),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-2)),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-1)));
                        5: WriteLn('Op-code trap at ',HexAnzeige_WordByte(PC-4,'B'),' ',Speicher_lesen_Byte(PC-4),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-3)),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-2)),
                                                  ' ',HexAnzeige_Byte(Speicher_lesen_Byte(PC-1)));
                        6: WriteLn('User Interrupt');
      else                 WriteLn('Unknown error ',cpu_error);
      end;
end;

{ Handling of software breakpoints (HALT opcode):
  Behandlung von Software	Breakpoints (HALT Op-Code)
  Output:    0 breakpoint or other HALT opcode reached (stop)
             1 breakpoint reached, passcounter not reached (continue)
}
{$IFDEF SBSIZE}
function handel_break:Integer;
  var i             : Integer;
      break_address : Integer;
  label was_softbreak,ret;
begin
      for i := 1 to SBSIZE do	                     { search for breakpoint }
          if (soft[i].sb_adr = PC - 1) then goto was_softbreak;
      handel_break:=0;
      goto ret;
was_softbreak:
{$IFDEF HISIZE}
      h_next := h_next - 1;                                { correct history }
      if (h_next < 1) then h_next := 1;
{$ENDIF}
      break_address := PC - 1;                     { store adr of breakpoint }
      cpu_error := NONE;                             { HALT was a breakpoint }
      PC := PC - 1;                              { substitute HALT opcode by }
      Speicher_schreiben_Byte(PC,soft[i].sb_oldopc);       { original opcode }
      cpu_state := SINGLE_STEP;                             { and execute it }
      cpu;
      Speicher_schreiben_Byte(soft[i].sb_adr,$76);{ restore HALT opcode again }
      Inc(soft[i].sb_passcount);                     { increment passcounter }
      if (soft[i].sb_passcount <> soft[i].sb_pass)
         then begin handel_break:=1; goto ret end;{ pass not reached, continue }
      WriteLn('Software breakpoint ',i,' reached at ',HexAnzeige_WordByte(break_address,'B'));
      soft[i].sb_passcount := 0;                         { reset passcounter }
      handel_break:=0;                                  { pass reached, stop }
{$ENDIF}
ret:
end;

procedure do_step;                                   { Execute a single step }
  var p : Word;
begin
      cpu_state := SINGLE_STEP;
      cpu_error := NONE;
      cpu;
      if (cpu_error = OPHALT) then handel_break;
      cpu_err_msg;
      print_head;
      print_reg;
      p := PC;
      disass(p);
end;

procedure do_trace;                { Execute several steps with trace output }
  var count, i : Integer;
      s        : Integer;
begin
      s := 1;
      repeat s := s + 1; until cmd[s]<>' ';
{      if (cmd[s] = '\0') then count := 20 else count := atoi(s);}
      cpu_state := SINGLE_STEP;
      cpu_error := NONE;
      print_head;
      print_reg;
      for i := 0 to count do
          begin
                cpu;
		print_reg;
                if (cpu_error>0)
                   then begin if (cpu_error = OPHALT)
                                 then if (handel_break=0) then break;
                        end
                   else
			break;
	  end;
      cpu_err_msg;
end;

procedure do_go;                             { Run the CPU emulation endless }
  var i : Integer;
  label cont;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      if cmd[i] in ['a'..'f','A'..'F','0'..'9'] then PC := exatoi(cmd,i);
cont:
      cpu_state := CONTIN_RUN;
      cpu_error := NONE;
      cpu;
      if (cpu_error = OPHALT)
         then if (handel_break=1)
                 then if (cpu_error=0) then goto cont;
      cpu_err_msg;
      print_head;
      print_reg;
end;

procedure do_dump;                                             { Memory dump }
  var i : Integer;
      j : LongInt;
      c : Char;
  label ende;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      if cmd[i] in ['a'..'f','A'..'F','0'..'9']
         then begin j:=exatoi(cmd,i);
                    if (j < 0) then begin Write(adr_err); goto ende; end;
                    wrk_ram := j;
              end;
      Write('Adr    ');
      for i := 1 to 16 do Write(HexAnzeige_Byte(i),' ');
      WriteLn('   ASCII');
      for i := 1 to 16 do
          begin
                Write(HexAnzeige_WordByte(wrk_ram,'B'),' - ');
                for j := 1 to 16 do
                    begin
                          Write(HexAnzeige_Byte(Speicher_lesen_Byte(wrk_ram)),' ');
                          Inc(wrk_ram);
                          if (wrk_ram > 65535) then wrk_ram := 0;
                    end;
                Write('   ');
                for j := -16 to -1 do
                    begin c := chr(Speicher_lesen_Byte(wrk_ram+j));
                          if (c >= ' ') AND (c <= chr($7F)) then Write(c  )
                                                            else Write('.');
                    end;
                WriteLn;
          end;
ende:
end;

procedure do_list;                                             { Disassemble }
  var i : Integer;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      if cmd[i] in ['a'..'f','A'..'F','0'..'9'] then wrk_ram := exatoi(cmd,i);
      for i := 1 to 10 do
          begin
                Write(HexAnzeige_WordByte(wrk_ram,'B'),' - ');
		disass(wrk_ram);
                if (wrk_ram > 65535) then wrk_ram := 0;
          end;
end;

procedure do_modify;                                         { Memory modify }
  var i  : Integer;
      j  : LongInt;
      nv : Array[0..80] of Char;   {80 = LENCMD}
  label end1,end2;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      if cmd[i] in ['a'..'f','A'..'F','0'..'9']
         then begin j:=exatoi(cmd,i);
                    if (j < 0) then begin Write(adr_err); goto end2; end;
                    wrk_ram := j;
              end;
      j:=0;
      while j=0 do
      begin Write(HexAnzeige_WordByte(                    wrk_ram ,'B'),' = ',
                  HexAnzeige_Byte    (Speicher_lesen_Byte(wrk_ram)    ),' : ');
            ClrEol;
            fgets(nv); i:=1;
            if (nv[1] = chr($0D))
               then begin wrk_ram := wrk_ram + 1;
                          if (wrk_ram > 65535) then wrk_ram := 0;
                          goto end1;
                    end;
            if NOT (nv[1] in ['a'..'f','A'..'F','0'..'9']) then goto end2;
            Speicher_schreiben_Byte(wrk_ram,exatoi(nv,i)); wrk_ram := wrk_ram + 1;
            if (wrk_ram > 65535) then wrk_ram := 0;
end1:
      end;
end2:
end;

procedure do_fill;                                             { Memory fill }
  var i   : Integer;
      j   : LongInt;
      p   : Word;
      val : Byte;
  label ende;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      j:=exatoi(cmd,i);
      if (j < 0) then begin Write(adr_err); goto ende; end;
      p := j;
      while (cmd[i]<>',') AND (cmd[i]<>' ') AND (cmd[i]<>chr($0D)) do Inc(i); Inc(i);
      if (cmd[i]<>chr($0D)) then j   := exatoi(cmd,i);
      while (cmd[i]<>',') AND (cmd[i]<>' ') AND (cmd[i]<>chr($0D)) do Inc(i); Inc(i);
      if (cmd[i]<>chr($0D)) then val := exatoi(cmd,i);
      while (j>0) do begin
                           Speicher_schreiben_Byte(p,val); p := p + 1;
                           if (p > 65535) then p := 0;
                           j := j - 1;
	             end;
ende:
end;

procedure do_move;                                             { Memory move }
  var i     : Integer;
      j     : LongInt;
      p1,p2 : Word;
  label ende;
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      j:=exatoi(cmd,i);
      if (j < 0) then begin Write(adr_err); goto ende; end;
      p1 := j;
      while (cmd[i]<>',') AND (cmd[i]<>' ') AND (cmd[i]<>chr($0D)) do Inc(i); Inc(i);
      if (cmd[i]<>chr($0D)) then p2 := exatoi(cmd,i);
      while (cmd[i]<>',') AND (cmd[i]<>' ') AND (cmd[i]<>chr($0D)) do Inc(i); Inc(i);
      if (cmd[i]<>chr($0D)) then j  := exatoi(cmd,i);
      while (j>0) do begin
                           Speicher_schreiben_Byte(p2,Speicher_lesen_Byte(p1));
                           p1 := p1 + 1; p2 := p2 + 1;
                           if (p1 > 65535) then p1 := 0;
                           if (p2 > 65535) then p2 := 0;
                           j := j - 1;
	             end;
ende:
end;

procedure do_reg;                                          { Register modify }
  var i,i1 : Integer;
      j    : LongInt;
      nv   : Array[0..80] of Char;   {80 = LENCMD}
      cm   : String;
  label ende;
begin
      for i:=1 to 80 do if cmd[i]<>'''' then cmd[i]:=UpCase(cmd[i]);
      i:=2; while cmd[i]=' ' do Inc(i);
      if cmd[i] = chr($0D) then goto ende;
      cm := '';
      while cmd[i]<>chr($0D) do begin cm := cm + cmd[i]; Inc(i); end;
      if (cm = 'BC''')
         then begin Write('BC'' = ',HexAnzeige_Byte(B_),HexAnzeige_Byte(C_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    B_ := (j AND $FF00) div 256;
                    C_ := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'DE''')
         then begin Write('DE'' = ',HexAnzeige_Byte(D_),HexAnzeige_Byte(E_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    D_ := (j AND $FF00) div 256;
                    E_ := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'HL''')
         then begin Write('HL'' = ',HexAnzeige_Byte(H_),HexAnzeige_Byte(L_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    H_ := (j AND $FF00) div 256;
                    L_ := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'BC')
         then begin Write('BC = ',HexAnzeige_Byte(B),HexAnzeige_Byte(C),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    B  := (j AND $FF00) div 256;
                    C  := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'DE')
         then begin Write('DE = ',HexAnzeige_Byte(D),HexAnzeige_Byte(E),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    D  := (j AND $FF00) div 256;
                    E  := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'HL')
         then begin Write('HL = ',HexAnzeige_Byte(H),HexAnzeige_Byte(L),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    H  := (j AND $FF00) div 256;
                    L  := (j AND $00FF);
                    goto ende;
              end;
      if (cm = 'PC')
         then begin Write('PC = ',HexAnzeige_WordByte(PC,'B'),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    PC := j AND $FFFF;
                    goto ende;
              end;
      if (cm = 'IX')
         then begin Write('IX = ',HexAnzeige_WordByte(IX,'B'),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    IX := j AND $FFFF;
                    goto ende;
              end;
      if (cm = 'IY')
         then begin Write('IY = ',HexAnzeige_WordByte(IY,'B'),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    IY := j AND $FFFF;
                    goto ende;
              end;
      if (cm = 'A''')
         then begin Write('A'' = ',HexAnzeige_Byte(A_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    A_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'F''')
         then begin Write('F'' = ',HexAnzeige_Byte(F_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    F_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'B''')
         then begin Write('B'' = ',HexAnzeige_Byte(B_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    B_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'C''')
         then begin Write('C'' = ',HexAnzeige_Byte(C_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    C_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'D''')
         then begin Write('D'' = ',HexAnzeige_Byte(D_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    D_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'E''')
         then begin Write('E'' = ',HexAnzeige_Byte(E_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    E_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'H''')
         then begin Write('H'' = ',HexAnzeige_Byte(H_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    H_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'L''')
         then begin Write('L'' = ',HexAnzeige_Byte(L_),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    L_ := j AND $FF;
                    goto ende;
              end;
      if (cm = 'A')
         then begin Write('A = ',HexAnzeige_Byte(A),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    A := j AND $FF;
                    goto ende;
              end;
      if (cm = 'F')
         then begin Write('F = ',HexAnzeige_Byte(F),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    F := j AND $FF;
                    goto ende;
              end;
      if (cm = 'B')
         then begin Write('B = ',HexAnzeige_Byte(B),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    B := j AND $FF;
                    goto ende;
              end;
      if (cm = 'C')
         then begin Write('C = ',HexAnzeige_Byte(C),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    C := j AND $FF;
                    goto ende;
              end;
      if (cm = 'D')
         then begin Write('D = ',HexAnzeige_Byte(D),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    D := j AND $FF;
                    goto ende;
              end;
      if (cm = 'E')
         then begin Write('E = ',HexAnzeige_Byte(E),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    E := j AND $FF;
                    goto ende;
              end;
      if (cm = 'H')
         then begin Write('H = ',HexAnzeige_Byte(H),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    H := j AND $FF;
                    goto ende;
              end;
      if (cm = 'L')
         then begin Write('L = ',HexAnzeige_Byte(L),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    L := j AND $FF;
                    goto ende;
              end;
      if (cm = 'I')
         then begin Write('I = ',HexAnzeige_Byte(III),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    III := j AND $FF;
                    goto ende;
              end;
      if (cm = 'SP')
         then begin Write('SP = ',HexAnzeige_WordByte(STACK,'B'),' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    STACK := j AND $FFFF;
                    goto ende;
              end;
      if (cm = 'FS')
         then begin Write('S-FLAG = ');
                    if (F AND S_FLAG)=S_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR S_FLAG else F := F AND NOT S_FLAG;
                    goto ende;
              end;
      if (cm = 'FZ')
         then begin Write('Z-FLAG = ');
                    if (F AND Z_FLAG)=Z_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR Z_FLAG else F := F AND NOT Z_FLAG;
                    goto ende;
              end;
      if (cm = 'FH')
         then begin Write('H-FLAG = ');
                    if (F AND H_FLAG)=H_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
                    goto ende;
              end;
      if (cm = 'FP')
         then begin Write('P-FLAG = ');
                    if (F AND P_FLAG)=P_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR P_FLAG else F := F AND NOT P_FLAG;
                    goto ende;
              end;
      if (cm = 'FN')
         then begin Write('N-FLAG = ');
                    if (F AND N_FLAG)=N_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR N_FLAG else F := F AND NOT N_FLAG;
                    goto ende;
              end;
      if (cm = 'FC')
         then begin Write('C-FLAG = ');
                    if (F AND C_FLAG)=C_FLAG then Write('1') else Write('0');
                    Write(' : ');
                    fgets(nv); i1 := 1; j := exatoi(nv,i1);
                    if (j=1) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
                    goto ende;
              end;
      WriteLn('can''t change register ',cm);
ende:
      print_head;
      print_reg;
end;

procedure do_port;                                             { Port modify }
  var i    : Integer;
      port : Byte;
      nv   : Array[0..80] of Char;   {80 = LENCMD}
{	extern BYTE io_out(), io_in(); }
begin
      i:=2; while cmd[i]=' ' do Inc(i);
      port := exatoi(cmd,i);
      Write(HexAnzeige_Byte(port),' = ',{HexAnzeige_Byte(io_in(port),}'1 : ');
      fgets(nv);
      if cmd[i] in ['a'..'f','A'..'F','0'..'9']
         then begin i := 1; {io_out(port, exatoi(nv,i));} end;
end;

procedure do_break;                                   { Software breakpoints }
  var i   : Integer;
      j,k : Word;
  label ende;
begin
{$IFNDEF SBSIZE}
      WriteLn('Sorry, no breakpoints available');
      WriteLn('Please recompile with SBSIZE defined in DEFINE.INC');
{$ELSE}
      if (NOT break_flag) then begin Write('Can''t use softbreaks with -h option.');
                                 goto ende;
                           end;
      i := 2;
      if (cmd[i]=chr($0D))
         then begin WriteLn('No Addr Pass  Counter');
                    for i := 1 to SBSIZE do
                        if soft[i].sb_pass>0
                           then WriteLn(HexAnzeige_Byte    (     i            ),' ',
                                        HexAnzeige_WordByte(soft[i].sb_adr,'B'),' ',
                                        soft[i].sb_pass,' ',soft[i].sb_passcount);
                    goto ende;
              end;
      if cmd[i] in ['0'..'9']
         then begin
                    j := atoi(cmd,i);
                    if (j >= SBSIZE)
                       then begin Write  ('breakpoint ');
                                  WriteLn(j,' not available');
                                  goto ende;
                            end;
              end
         else begin
                    j := sb_next; sb_next := sb_next + 1;
                    if (sb_next > SBSIZE) then sb_next := 1;
              end;
      while cmd[i]=' ' do Inc(i);
      if cmd[i] = 'c'
         then begin
                    Speicher_schreiben_Byte(soft[j].sb_adr,soft[j].sb_oldopc);
                    for i:=1 to SBSIZE do
                        begin soft[i].sb_adr       := 0;
                              soft[i].sb_oldopc    := 0;
                              soft[i].sb_passcount := 0;
                              soft[i].sb_pass      := 0;
                        end;
                    goto ende;
              end;
      k := exatoi(cmd,i);
      if (k < 0) then begin Write(adr_err); goto ende end;
      if (soft[j].sb_pass>0) then Speicher_schreiben_Byte(soft[j].sb_adr,soft[j].sb_oldopc);
      soft[j].sb_adr    := k;
      soft[j].sb_oldopc := Speicher_lesen_Byte(soft[j].sb_adr);
      Speicher_schreiben_Byte(soft[j].sb_adr,$076);
{      while (!iscntrl( *s) AND (!ispunct( *s)) then i := i + 1;}
      if (cmd[i] <> ',') then soft[j].sb_pass := 1
                         else soft[j].sb_pass := exatoi(cmd,i);
      soft[j].sb_passcount := 0;
ende:
{$ENDIF}
end;

procedure do_hist;                                                 { History }
  var i,l,b,e,sa : Integer;
      c          : Char;
  label ende;
begin
{$IFNDEF HISIZE}
      WriteLn('Sorry, no history available');
      WriteLn('Please recompile with HISIZE defined in DEFINE.INC');
{$ELSE}
      i:=2; while cmd[i]=' ' do Inc(i);
      case cmd[i] of 'c': begin for i:=1 to 100 do
                                    begin his[i].h_adr := 0;
                                          his[i].h_af  := 0;
                                          his[i].h_bc  := 0;
                                          his[i].h_de  := 0;
                                          his[i].h_hl  := 0;
                                          his[i].h_ix  := 0;
                                          his[i].h_iy  := 0;
                                          his[i].h_sp  := 0;
                                    end;
                                h_next  := 1;
                                h_flag1 := 0;
                                goto ende;
                          end;
      else begin
                 if ((h_next = 1) AND (h_flag1 = 0))
                    then begin
                               WriteLn('History memory is empty');
                               goto ende;
                         end;
                 e := h_next-1;
                 if (h_flag1=1) then b := h_next else b := 1;
                 l := 0;
                 while cmd[i]=' ' do Inc(i);
                 if cmd[i]<>chr($0D) then sa := exatoi(cmd,i)
                                     else sa := -1;
                 for i := b to e do
                     begin
{                           if (i = HISIZE) then i := 0;    }
                           if sa <> -1 then
                                            if (his[i].h_adr < sa) then goto ende
                                                                   else sa := -1;
                           WriteLn(HexAnzeige_WordByte(his[i].h_adr,'B'),' AF=',
                                   HexAnzeige_WordByte(his[i].h_af ,'B'),' BC=',
                                   HexAnzeige_WordByte(his[i].h_bc ,'B'),' DE=',
                                   HexAnzeige_WordByte(his[i].h_de ,'B'),' HL=',
                                   HexAnzeige_WordByte(his[i].h_hl ,'B'),' IX=',
                                   HexAnzeige_WordByte(his[i].h_ix ,'B'),' IY=',
                                   HexAnzeige_WordByte(his[i].h_iy ,'B'),' SP=',
                                   HexAnzeige_WordByte(his[i].h_sp ,'B'));
                           l := l + 1;
                           if (l = 20)
                              then begin l := 0;
                                         Write('q = quit, else continue: ');
                                         c := ReadKey;
                                         WriteLn;
                                         if UpCase(c) = 'Q' then goto ende;
                                   end;
		     end;
		 goto ende;
           end;
      end;
ende:
{$ENDIF}
end;

{ Runtime measurement by counting the executed T states }
procedure do_count;
  var i : Integer;
begin
{$IFNDEF WANT_TIM}
      WriteLn('Sorry, no t-state count available');
      WriteLn('Please recompile with WANT_TIM defined in DEFINE.INC');
{$ELSE}
      i:=2; while cmd[i]=' ' do Inc(i);
      if (cmd[i]=chr($0D)) then begin
                                      WriteLn('start  stop  status  T-states');
                                      Write(HexAnzeige_WordByte(t_start,'B'),'   ',
                                            HexAnzeige_WordByte(t_end  ,'B'),'    ');
                                      if t_flag=1 then Write('on ')
                                                  else Write('off');
                                      WriteLn(t_states);
                                end
                           else begin
                                      t_start := exatoi(cmd,i);
                                      while (cmd[i] <> ',') AND (cmd[i] <> chr($0D)) do Inc(i);
                                      if (cmd[i]<>chr($0D))
                                         then begin
                                                    t_end    := exatoi(cmd,i);
                                                    t_states := 0;
                                                    t_flag   := 0;
                                              end;
                                end;
{$ENDIF}
end;

{ Calculate the clock frequency of the emulated CPU:
  into memory locations 0000H to 0002H the following
  code will be stored:
  LOOP: JP LOOP
  It uses 10 T states for each execution. A 3 secound
  timer is started and then the CPU. For every opcode
  fetch the R register is incremented by one and after
  the timer is down and stopps the emulation, the clock
  speed of the CPU is calculated with:
  f = R / 300000
}
procedure do_clock;
  var save : Array[0..3] of Byte;
{	int timeout();
	unsigned alarm();}
begin
      save[0] := Speicher_lesen_Byte($0000);         { save memory locations }
      save[1] := Speicher_lesen_Byte($0001);                 { 0000H - 0002H }
      save[2] := Speicher_lesen_Byte($0002);
      Speicher_schreiben_Byte($0000,$C3);{ store opcode JP 0000H at address }
      Speicher_schreiben_Byte($0001,$00);		             { 0000H }
      Speicher_schreiben_Byte($0002,$00);
      PC := $0000;                                     { set PC to this code }
      R  := 0;                                      { clear refresh register }
      cpu_state := CONTIN_RUN;                              { initialize CPU }
      cpu_error := NONE;
{      signal(SIGALRM,	timeout);}	{ initialize timer interrupt handler }
{      alarm(3);      }                                { start 3 secound timer }
      cpu;                                                       { start CPU }
      Speicher_schreiben_Byte($0000,save[0]);     { restore memory locations }
      Speicher_schreiben_Byte($0001,save[1]);                { 0000H - 0002H }
      Speicher_schreiben_Byte($0002,save[2]);
      if (cpu_error = NONE) then WriteLn('clock frequency = ',R / 300000.0,'f Mhz')
                            else WriteLn('Interrupted by user');
end;

{ Loader for binary images with Mostek header.
  Format of the first 3 bytes:

  0xff ll	lh

  ll = load address low
  lh = load address high
}
function load_mos(pfn:string):Integer;
  var fb           : Array[0..3] of Byte;
      fd           : file of Byte;
      count,readed : Integer;
      rc,w         : Integer;
begin
      rc := 0;
      Assign(fd,pfn); Reset(fd);
      Read(fd,fb[1]);
      Read(fd,fb[2]);                                    { read load address }
      Read(fd,fb[3]);
      if wrk_ram = 0 then                             { and set if not given }
                          wrk_ram := (fb[3] * 256 + fb[2]);
      count := $FFFF - wrk_ram; readed := 0; w := wrk_ram;
      repeat Read(fd,fb[1]);
             Speicher_schreiben_Byte(wrk_ram,fb[1]);
             Inc(wrk_ram); Dec(count); Inc(readed);
             if wrk_ram=0
                then begin WriteLn('Too much to load, stopped at FFFF');
                           rc := 1;
                     end;
      until Eof(fd) OR (wrk_ram=0);
      Close(fd); wrk_ram := w;
      WriteLn;
      WriteLn('Loader statistics for file ',pfn,':');
      WriteLn('START : ',HexAnzeige_WordByte(wrk_ram            ,'B'));
      WriteLn('END   : ',HexAnzeige_WordByte(wrk_ram+ readed - 1,'B'));
      WriteLn('LOADED: ',HexAnzeige_WordByte(         readed    ,'B'));
      PC := w;
      load_mos := rc;
end;

{ Read a file into the memory of the emulated CPU.
  The following file formats are supported:
      binary images with Mostek header
}
function do_getfile:Integer;
  var pfn  : String;
{  Array[0..80] of char;  80 = LENCMD}
      fb   : Array[1.. 5] of Byte;
      i,ii : Integer;
      fd   : file of Byte;
  label ende;
begin
      i:=2; while cmd[i]=' ' do Inc(i); {ii := 0;} pfn:='';
      while (cmd[i]<>',') AND (cmd[i]<>chr($0D)) do
            begin pfn := pfn + cmd[i];           {[ii]}
                  Inc(ii); Inc(i);
            end;
      pfn:=pfn+'.bin';
{      pfn[ii]:=chr($0D); for ii:=ii to 80 do pfn[ii]:=' ';}
      if pfn=''        {[1]=chr($0D)}
         then begin WriteLn('no input file given');
                    do_getfile:=1;
                    goto ende;
              end;
      Assign(fd,pfn); Reset(fd);
      if IOResult<>0 then begin WriteLn('can''t open file ',pfn);
                                do_getfile:=2;
                                goto ende;
                          end;
      if (cmd[i]=',') then wrk_ram := exatoi(cmd,i)
                      else wrk_ram := 0;
      for i:=1 to 5 do Read(fd,fb[i]);          { read first 5 bytes of file }
      Close(fd);
      if fb[1]=$FF                                         { Mostek header ? }
         then       do_getfile:=load_mos(pfn)
         else begin
                    WriteLn('unkown format, can''t load file ',pfn);
                    do_getfile:=3;
                    goto ende;
              end;
ende:
end;

procedure do_unix;                     { Call system function from simulator }
begin
{      int_off();
      system(s);
      int_on();}
end;

procedure do_show;             { Output informations about compiling options }
  var i : Integer;
begin
      WriteLn('Release: ',RELEASE);

{$IFDEF HISIZE}
      i := HISIZE;
{$ELSE}
      i := 0;
{$ENDIF}
      WriteLn('No. of entrys in history memory: ',i);

{$IFDEF SBSIZE}
      i := SBSIZE;
{$ELSE}
      i := 0;
{$ENDIF}
      WriteLn('No. of software breakpoints: ',i);

{$IFDEF WANT_SPC}
      i := 1;
{$ELSE}
      i := 0;
{$ENDIF}
      Write('Stackpointer turn around ');
      if i=1 then Write('') else Write('not ');
      WriteLn('checked');

{$IFDEF WANT_PCC}
      i := 1;
{$ELSE}
      i := 0;
{$ENDIF}
      Write('Programcounter turn around ');
      if i=1 then Write('') else Write('not ');
      WriteLn('checked');

{$IFDEF WANT_TIM}
      i := 1;
{$ELSE}
      i := 0;
{$ENDIF}
      Write('T-State counting ');
      if i=1 then Write('') else Write('im');
      WriteLn('possible');

{$IFDEF CNTL_C}
      i := 1;
{$ELSE}
      i := 0;
{$ENDIF}
      Write('CPU simulation ');
      if i=1 then Write('') else Write('not ');
      WriteLn('stopped on cntl-c');

{$IFDEF CNTL_BS}
      i := 1;
{$ELSE}
      i := 0;
{$ENDIF}
      Write('CPU simulation ');
      if i=1 then Write('') else Write('not ');
      WriteLn('stopped on cntl-\');
end;

procedure do_help;                                        { Output help text }
begin
      WriteLn('r filename[,address]      read object into memory');
      WriteLn('d [address]               dump memory');
      WriteLn('l [address]               list memory');
      WriteLn('m [address]               modify memory');
      WriteLn('f address,count,value     fill memory');
      WriteLn('v from,to,count           move memory');
      WriteLn('p address                 show/modify port');
      WriteLn('g [address]               run program');
      WriteLn('t [count]                 trace program');
      WriteLn('return                    single step program');
      WriteLn('x [register]              show/modify register');
      WriteLn('x f<flag>                 modify flag');
      WriteLn('b[no] address[,pass]      set soft breakpoint');
      WriteLn('b                         show soft breakpoints');
      WriteLn('b[no] c                   clear soft breakpoint');
      WriteLn('h [address]               show history');
      WriteLn('h c                       clear history');
      WriteLn('z start,stop              set trigger adr for t-state count');
      WriteLn('z                         show t-state count');
      WriteLn('c                         measure clock frequency');
      WriteLn('s                         show settings');
      WriteLn('! command                 execute UNIX command');
      WriteLn('q                         quit');
end;

{ The function "mon()" is the dialog user interface, called
  from the simulation just after program start.
}
procedure mon;
  var i,eoj : Integer;
      c1    : Char;
  label next;
begin
      eoj := 1;
      if (x_flag=1)
         then begin i:=1; cmd[1]:='r';
                    while xfn[i]<>chr(0) do begin cmd[i+1]:=xfn[i]; inc(i); end;
                    cmd[i+1]:=chr($0D);
                    if (do_getfile = 0) then do_go;
              end;
      repeat
             WriteLn; Write('==> ');
             fgets(cmd);
             case cmd[1] of chr($0D): begin do_step;           goto next; end;
                                 't': begin do_trace;          goto next; end;
                                 'g': begin do_go;             goto next; end;
                                 'd': begin do_dump;           goto next; end;
                                 'l': begin do_list;           goto next; end;
                                 'm': begin do_modify;         goto next; end;
                                 'f': begin do_fill;           goto next; end;
                                 'v': begin do_move;           goto next; end;
                                 'x': begin do_reg;            goto next; end;
                                 'p': begin do_port;           goto next; end;
                                 'b': begin do_break;          goto next; end;
                                 'h': begin do_hist;           goto next; end;
                                 'z': begin do_count;          goto next; end;
                                 'c': begin do_clock;          goto next; end;
                                 's': begin do_show;           goto next; end;
                                 '?': begin do_help;           goto next; end;
                                 'r': begin do_getfile;        goto next; end;
                                 '!': begin do_unix;           goto next; end;
                                 'q': begin eoj := 0;          goto next; end;
             else                     begin WriteLn('what??'); goto next; end
             end;
next:
      until eoj=0;
end;

begin
end.

{ This function is the signal handler for the timer interrupt.
  The CPU emulation is stopped here.
}
procedure timeout;
begin
      cpu_state := STOPPED;
end;
{ $ENDIF}

