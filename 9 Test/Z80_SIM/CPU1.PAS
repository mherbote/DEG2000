{$I DEFINE.INC}

unit CPU1;

interface

uses Varia,CB,DD,ED,FD,IOsim1;

procedure cpu;

implementation

{$I FLAG.PAS}

{ Trap not implemented opcodes. This function may be usefull
  later to trap some wanted opcodes.
}
function op_notimpl:Integer; far;
begin cpu_error := OPTRAP1;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      op_notimpl:=0;
{$ENDIF}
end;

function op_nop:Integer; far;                                          { NOP }
begin
{$IFDEF WANT_TIM}
        op_nop:=4;
{$ENDIF}
end;

function op_halt:Integer; far;                                        { HALT }
begin if (break_flag) then begin cpu_error:=OPHALT;
                                 cpu_state:=STOPPED;
                           end
	              else while (int_type=0) do R:=R+1;
{$IFDEF WANT_TIM}
      op_halt:=0;
{$ENDIF}
end;

function op_scf:Integer; far;                                          { SCF }
begin
      F := F OR       C_FLAG;
      F := F AND NOT (N_FLAG OR H_FLAG);
{$IFDEF WANT_TIM}
      op_scf:=4;
{$ENDIF}
end;

function op_ccf:Integer; far;                                          { CCF }
begin
      if (F AND C_FLAG)=C_FLAG then begin F := F OR      H_FLAG; F := F AND NOT C_FLAG end
                               else begin F := F AND NOT H_FLAG; F := F OR      C_FLAG end;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_ccf:=4;
{$ENDIF}
end;

function op_cpl:Integer; far;                                          { CPL }
begin A := NOT A;
      F := F OR H_FLAG OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpl:=4;
{$ENDIF}
end;

function op_daa:Integer; far;                                          { DAA }
  var old_a : Byte;
begin
      old_a := A;
      if (F AND N_FLAG)=N_FLAG
         then begin                                           { subtractions }
                    if (((A AND $0F) > 9 ) OR ((F AND H_FLAG)=H_FLAG))
                       then begin if (((old_a AND $0F) - 6) < 0)
                                     then F := F OR H_FLAG else F := F AND NOT H_FLAG;
                                  old_a := old_a - 6;
                                  A     := old_a;
                            end;
                    if (((A AND  $F0) > $90) OR ((F AND C_FLAG)=C_FLAG))
                       then begin A := A - $60;
                                  if (old_a - $60 < 0) then F := F OR C_FLAG;
                            end;
              end
         else begin                                              { additions }
                    if (((A AND $0F) > 9) OR ((F AND H_FLAG)=H_FLAG))
                       then begin if (((old_a AND $0F) + 6) > $0F)
                                     then F := F OR H_FLAG else F := F AND NOT H_FLAG;
                                  old_a := old_a + 6;
                                  A     := old_a;
                            end;
                    if (((A AND $F0) > $90) OR ((F AND C_FLAG)=C_FLAG))
                       then begin A := A + $60;
                                  if (old_a + $60 > 255) then F := F OR C_FLAG;
                            end;
              end;
      flag2;
{$IFDEF WANT_TIM}
      op_daa:=4;
{$ENDIF}
end;

function op_ei:Integer; far;                                            { EI }
begin
      IFF := 2;
{$IFDEF WANT_TIM}
      op_ei:=4;
{$ENDIF}
end;

function op_di:Integer; far;                                            { DI }
begin
      IFF := 0;
{$IFDEF WANT_TIM}
      op_di:=4;
{$ENDIF}
end;

function op_in:Integer; far;                                      { IN A,(n) }
begin
{      BYTE io_in();}

      A := io_in( Speicher_lesen_Byte(PC) ); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_in:=11;
{$ENDIF}
end;

function op_out:Integer; far;                                    { OUT (n),A }
begin
{      BYTE io_out();}

      io_out( Speicher_lesen_Byte(PC), A ); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_out:=11;
{$ENDIF}
end;

function op_ldan:Integer; far;                                      { LD A,n }
begin
      A := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldan:=7;
{$ENDIF}
end;

function op_ldbn:Integer; far;                                      { LD B,n }
begin
      B := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldbn:=7;
{$ENDIF}
end;

function op_ldcn:Integer; far;                                      { LD C,n }
begin
      C := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldcn:=7;
{$ENDIF}
end;

function op_lddn:Integer; far;                                      { LD D,n }
begin
      D := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_lddn:=7;
{$ENDIF}
end;

function op_lden:Integer; far;                                      { LD E,n }
begin
      E := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_lden:=7;
{$ENDIF}
end;

function op_ldhn:Integer; far;                                      { LD H,n }
begin
      H := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldhn:=7;
{$ENDIF}
end;

function op_ldln:Integer; far;                                      { LD L,n }
begin
      L := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldln:=7;
{$ENDIF}
end;

function op_ldabc:Integer; far;                                  { LD A,(BC) }
begin
      A := Speicher_lesen_Byte(B * 256 + C);
{$IFDEF WANT_TIM}
      op_ldabc:=7;
{$ENDIF}
end;

function op_ldade:Integer; far;                                  { LD A,(DE) }
begin
      A := Speicher_lesen_Byte(D * 256 + E);
{$IFDEF WANT_TIM}
      op_ldade:=7;
{$ENDIF}
end;

function op_ldann:Integer; far;                                  { LD A,(nn) }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i := i + Speicher_lesen_Byte(PC) * 256; PC := PC + 1;
      A := Speicher_lesen_Byte(i);
{$IFDEF WANT_TIM}
      op_ldann:=13;
{$ENDIF}
end;

function op_ldbca:Integer; far;                                  { LD (BC),A }
begin
      Speicher_schreiben_Byte((B * 256) + C,A);
{$IFDEF WANT_TIM}
      op_ldbca:=7;
{$ENDIF}
end;

function op_lddea:Integer; far;                                  { LD (DE),A }
begin
      Speicher_schreiben_Byte((D * 256) + E,A);
{$IFDEF WANT_TIM}
      op_lddea:=7;
{$ENDIF}
end;

function op_ldnna:Integer; far;                                  { LD (nn),A }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i := i + Speicher_lesen_Byte(PC) * 256; PC := PC + 1;
      Speicher_schreiben_Byte(i,A);
{$IFDEF WANT_TIM}
      op_ldnna:=13;
{$ENDIF}
end;

function op_ldhla:Integer; far;                                  { LD (HL),A }
begin
      Speicher_schreiben_Byte((H * 256) + L,A);
{$IFDEF WANT_TIM}
      op_ldhla:=7;
{$ENDIF}
end;

function op_ldhlb:Integer; far;                                  { LD (HL),B }
begin
      Speicher_schreiben_Byte((H * 256) + L,B);
{$IFDEF WANT_TIM}
      op_ldhlb:=7;
{$ENDIF}
end;

function op_ldhlc:Integer; far;                                  { LD (HL),C }
begin
      Speicher_schreiben_Byte((H * 256) + L,C);
{$IFDEF WANT_TIM}
      op_ldhlc:=7;
{$ENDIF}
end;

function op_ldhld:Integer; far;                                  { LD (HL),D }
begin
      Speicher_schreiben_Byte((H * 256) + L,D);
{$IFDEF WANT_TIM}
      op_ldhld:=7;
{$ENDIF}
end;

function op_ldhle:Integer; far;                                  { LD (HL),E }
begin
      Speicher_schreiben_Byte((H * 256) + L,E);
{$IFDEF WANT_TIM}
      op_ldhle:=7;
{$ENDIF}
end;

function op_ldhlh:Integer; far;                                  { LD (HL),H }
begin
      Speicher_schreiben_Byte((H * 256) + L,H);
{$IFDEF WANT_TIM}
      op_ldhlh:=7;
{$ENDIF}
end;

function op_ldhll:Integer; far;                                  { LD (HL),L }
begin
      Speicher_schreiben_Byte((H * 256) + L,L);
{$IFDEF WANT_TIM}
      op_ldhll:=7;
{$ENDIF}
end;

function op_ldhl1:Integer; far;                                  { LD (HL),n }
begin
      Speicher_schreiben_Byte((H * 256) + L,Speicher_lesen_Byte(PC)); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldhl1:=10;
{$ENDIF}
end;

function op_ldaa:Integer; far;                                      { LD A,A }
begin
{$IFDEF WANT_TIM}
      op_ldaa:=4;
{$ENDIF}
end;

function op_ldab:Integer; far;                                      { LD A,B }
begin
      A := B;
{$IFDEF WANT_TIM}
      op_ldab:=4;
{$ENDIF}
end;

function op_ldac:Integer; far;                                      { LD A,C }
begin
      A := C;
{$IFDEF WANT_TIM}
      op_ldac:=4;
{$ENDIF}
end;

function op_ldad:Integer; far;                                      { LD A,D }
begin
      A := D;
{$IFDEF WANT_TIM}
      op_ldad:=4;
{$ENDIF}
end;

function op_ldae:Integer; far;                                      { LD A,E }
begin
      A := E;
{$IFDEF WANT_TIM}
      op_ldae:=4;
{$ENDIF}
end;

function op_ldah:Integer; far;                                      { LD A,H }
begin
      A := H;
{$IFDEF WANT_TIM}
      op_ldah:=4;
{$ENDIF}
end;

function op_ldal:Integer; far;                                      { LD A,L }
begin
      A := L;
{$IFDEF WANT_TIM}
      op_ldal:=4;
{$ENDIF}
end;

function op_ldahl:Integer; far;                                  { LD A,(HL) }
begin
      A := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldahl:=7;
{$ENDIF}
end;

function op_ldba:Integer; far;                                      { LD B,A }
begin
      B := A;
{$IFDEF WANT_TIM}
      op_ldba:=4;
{$ENDIF}
end;

function op_ldbb:Integer; far;                                      { LD B,B }
begin
{$IFDEF WANT_TIM}
      op_ldbb:=4;
{$ENDIF}
end;

function op_ldbc:Integer; far;                                      { LD B,C }
begin
      B := C;
{$IFDEF WANT_TIM}
      op_ldbc:=4;
{$ENDIF}
end;

function op_ldbd:Integer; far;                                      { LD B,D }
begin
      B := D;
{$IFDEF WANT_TIM}
      op_ldbd:=4;
{$ENDIF}
end;

function op_ldbe:Integer; far;                                      { LD B,E }
begin
      B := E;
{$IFDEF WANT_TIM}
      op_ldbe:=4;
{$ENDIF}
end;

function op_ldbh:Integer; far;                                      { LD B,H }
begin
      B := H;
{$IFDEF WANT_TIM}
      op_ldbh:=4;
{$ENDIF}
end;

function op_ldbl:Integer; far;                                      { LD B,L }
begin
      B := L;
{$IFDEF WANT_TIM}
      op_ldbl:=4;
{$ENDIF}
end;


function op_ldbhl:Integer; far;                                  { LD B,(HL) }
begin
      B := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldbhl:=7;
{$ENDIF}
end;

function op_ldca:Integer; far;                                      { LD C,A }
begin
      C := A;
{$IFDEF WANT_TIM}
      op_ldca:=4;
{$ENDIF}
end;

function op_ldcb:Integer; far;                                      { LD C,B }
begin
      C := B;
{$IFDEF WANT_TIM}
      op_ldcb:=4;
{$ENDIF}
end;

function op_ldcc:Integer; far;                                      { LD C,C }
begin
{$IFDEF WANT_TIM}
      op_ldcc:=4;
{$ENDIF}
end;

function op_ldcd:Integer; far;                                      { LD C,D }
begin
      C := D;
{$IFDEF WANT_TIM}
      op_ldcd:=4;
{$ENDIF}
end;

function op_ldce:Integer; far;                                      { LD C,E }
begin
      C := E;
{$IFDEF WANT_TIM}
      op_ldce:=4;
{$ENDIF}
end;

function op_ldch:Integer; far;                                      { LD C,H }
begin
      C := H;
{$IFDEF WANT_TIM}
      op_ldch:=4;
{$ENDIF}
end;

function op_ldcl:Integer; far;                                      { LD C,L }
begin
      C := L;
{$IFDEF WANT_TIM}
      op_ldcl:=4;
{$ENDIF}
end;

function op_ldchl:Integer; far;                                  { LD C,(HL) }
begin
      C := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldchl:=7;
{$ENDIF}
end;

function op_ldda:Integer; far;                                      { LD D,A }
begin
      D := A;
{$IFDEF WANT_TIM}
      op_ldda:=4;
{$ENDIF}
end;

function op_lddb:Integer; far;                                      { LD D,B }
begin
      D := B;
{$IFDEF WANT_TIM}
      op_lddb:=4;
{$ENDIF}
end;

function op_lddc:Integer; far;                                      { LD D,C }
begin
      D := C;
{$IFDEF WANT_TIM}
      op_lddc:=4;
{$ENDIF}
end;

function op_lddd:Integer; far;                                      { LD D,D }
begin
{$IFDEF WANT_TIM}
      op_lddd:=4;
{$ENDIF}
end;

function op_ldde:Integer; far;                                      { LD D,E }
begin
      D := E;
{$IFDEF WANT_TIM}
      op_ldde:=4;
{$ENDIF}
end;

function op_lddh:Integer; far;                                      { LD D,H }
begin
      D := H;
{$IFDEF WANT_TIM}
      op_lddh:=4;
{$ENDIF}
end;

function op_lddl:Integer; far;                                      { LD D,L }
begin
      D := L;
{$IFDEF WANT_TIM}
      op_lddl:=4;
{$ENDIF}
end;

function op_lddhl:Integer; far;                                  { LD D,(HL) }
begin
      D := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_lddhl:=7;
{$ENDIF}
end;

function op_ldea:Integer; far;                                      { LD E,A }
begin
      E := A;
{$IFDEF WANT_TIM}
      op_ldea:=4;
{$ENDIF}
end;

function op_ldeb:Integer; far;                                      { LD E,B }
begin
      E := B;
{$IFDEF WANT_TIM}
      op_ldeb:=4;
{$ENDIF}
end;

function op_ldec:Integer; far;                                      { LD E,C }
begin
      E := C;
{$IFDEF WANT_TIM}
      op_ldec:=4;
{$ENDIF}
end;

function op_lded:Integer; far;                                      { LD E,D }
begin
      E := D;
{$IFDEF WANT_TIM}
      op_lded:=4;
{$ENDIF}
end;

function op_ldee:Integer; far;                                      { LD E,E }
begin
{$IFDEF WANT_TIM}
      op_ldee:=4;
{$ENDIF}
end;

function op_ldeh:Integer; far;                                      { LD E,H }
begin
      E := H;
{$IFDEF WANT_TIM}
      op_ldeh:=4;
{$ENDIF}
end;

function op_ldel:Integer; far;                                      { LD E,L }
begin
      E := L;
{$IFDEF WANT_TIM}
      op_ldel:=4;
{$ENDIF}
end;

function op_ldehl:Integer; far;                                  { LD E,(HL) }
begin
      E := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldehl:=7;
{$ENDIF}
end;

function op_ldha:Integer; far;                                      { LD H,A }
begin
      H := A;
{$IFDEF WANT_TIM}
      op_ldha:=4;
{$ENDIF}
end;

function op_ldhb:Integer; far;                                      { LD H,B }
begin
      H := B;
{$IFDEF WANT_TIM}
      op_ldhb:=4;
{$ENDIF}
end;

function op_ldhc:Integer; far;                                      { LD H,C }
begin
      H := C;
{$IFDEF WANT_TIM}
      op_ldhc:=4;
{$ENDIF}
end;

function op_ldhd:Integer; far;                                      { LD H,D }
begin
      H := D;
{$IFDEF WANT_TIM}
      op_ldhd:=4;
{$ENDIF}
end;

function op_ldhe:Integer; far;                                      { LD H,E }
begin
      H := E;
{$IFDEF WANT_TIM}
      op_ldhe:=4;
{$ENDIF}
end;

function op_ldhh:Integer; far;                                      { LD H,H }
begin
{$IFDEF WANT_TIM}
      op_ldhh:=4;
{$ENDIF}
end;

function op_ldhl:Integer; far;                                      { LD H,L }
begin
      H := L;
{$IFDEF WANT_TIM}
      op_ldhl:=4;
{$ENDIF}
end;

function op_ldhhl:Integer; far;                                  { LD H,(HL) }
begin
      H := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldhhl:=7;
{$ENDIF}
end;

function op_ldla:Integer; far;                                      { LD L,A }
begin
      L := A;
{$IFDEF WANT_TIM}
      op_ldla:=4;
{$ENDIF}
end;

function op_ldlb:Integer; far;                                      { LD L,B }
begin
      L := B;
{$IFDEF WANT_TIM}
      op_ldlb:=4;
{$ENDIF}
end;

function op_ldlc:Integer; far;                                      { LD L,C }
begin
      L := C;
{$IFDEF WANT_TIM}
      op_ldlc:=4;
{$ENDIF}
end;

function op_ldld:Integer; far;                                      { LD L,D }
begin
      L := D;
{$IFDEF WANT_TIM}
      op_ldld:=4;
{$ENDIF}
end;

function op_ldle:Integer; far;                                      { LD L,E }
begin
      L := E;
{$IFDEF WANT_TIM}
      op_ldle:=4;
{$ENDIF}
end;

function op_ldlh:Integer; far;                                      { LD L,H }
begin
      L := H;
{$IFDEF WANT_TIM}
      op_ldlh:=4;
{$ENDIF}
end;

function op_ldll:Integer; far;                                      { LD L,L }
begin
{$IFDEF WANT_TIM}
      op_ldll:=4;
{$ENDIF}
end;

function op_ldlhl:Integer; far;                                  { LD L,(HL) }
begin
      L := Speicher_lesen_Byte((H * 256) + L);
{$IFDEF WANT_TIM}
      op_ldlhl:=7;
{$ENDIF}
end;

function op_ldbcnn:Integer; far;                                  { LD BC,nn }
begin
      C := Speicher_lesen_Byte(PC); PC := PC + 1;
      B := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldbcnn:=10;
{$ENDIF}
end;

function op_lddenn:Integer; far;                                  { LD DE,nn }
begin
      E := Speicher_lesen_Byte(PC); PC := PC + 1;
      D := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_lddenn:=10;
{$ENDIF}
end;

function op_ldhlnn:Integer; far;                                  { LD HL,nn }
begin
      L := Speicher_lesen_Byte(PC); PC := PC + 1;
      H := Speicher_lesen_Byte(PC); PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldhlnn:=10;
{$ENDIF}
end;

function op_ldspnn:Integer; far;                                  { LD SP,nn }
begin
      STACK :=         Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      STACK := STACK + Speicher_lesen_Byte(PC) * 256; PC := PC + 1;
{$IFDEF WANT_TIM}
      op_ldspnn:=10;
{$ENDIF}
end;

function op_ldsphl:Integer; far;                                  { LD SP,HL }
begin
      STACK := (H *256) + L;
{$IFDEF WANT_TIM}
      op_ldsphl:=6;
{$ENDIF}
end;

function op_ldhlin:Integer; far;                                { LD HL,(nn) }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i := i + Speicher_lesen_Byte(PC) * 256; PC := PC + 1;
      L := Speicher_lesen_Byte(i);
      H := Speicher_lesen_Byte(i + 1);
{$IFDEF WANT_TIM}
      op_ldhlin:=16;
{$ENDIF}
end;

function op_ldinhl:Integer; far;                                { LD (nn),HL }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i := i + Speicher_lesen_Byte(PC) * 256; PC := PC + 1;
      Speicher_schreiben_Byte(i    ,L);
      Speicher_schreiben_Byte(i + 1,H);
{$IFDEF WANT_TIM}
      op_ldinhl:=16;
{$ENDIF}
end;


function op_incbc:Integer; far;                                     { INC BC }
begin
      C := C + 1;
      if (NOT C)=0 then B := B + 1;
{$IFDEF WANT_TIM}
      op_incbc:=6;
{$ENDIF}
end;

function op_incde:Integer; far;                                     { INC DE }
begin
      E := E + 1;
      if (NOT E)=0 then D := D + 1;
{$IFDEF WANT_TIM}
      op_incde:=6;
{$ENDIF}
end;

function op_inchl:Integer; far;                                     { INC HL }
begin
      L := L + 1;
      if (NOT L)=0 then H := H + 1;
{$IFDEF WANT_TIM}
      op_inchl:=6;
{$ENDIF}
end;

function op_incsp:Integer; far;                                     { INC SP }
begin
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK > 65535) then STACK := 0;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_incsp:=6;
{$ENDIF}
end;

function op_decbc:Integer; far;                                     { DEC BC }
begin
      C := C - 1;
      if (C = $FF) then B := B - 1;
{$IFDEF WANT_TIM}
      op_decbc:=6;
{$ENDIF}
end;

function op_decde:Integer; far;                                     { DEC DE }
begin
      E := E - 1;
      if (E = $FF) then D := D - 1;
{$IFDEF WANT_TIM}
      op_decde:=6;
{$ENDIF}
end;

function op_dechl:Integer; far;                                     { DEC HL }
begin
      L := L - 1;
      if (L = $FF) then H := H - 1;
{$IFDEF WANT_TIM}
      op_dechl:=6;
{$ENDIF}
end;

function op_decsp:Integer; far;                                     { DEC SP }
begin
      STACK := STACK - 1;
{$IFDEF WANT_SPC}
      if (STACK < 0) then STACK := 65535;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_decsp:=6;
{$ENDIF}
end;

function op_adhlbc:Integer; far;                                 { ADD HL,BC }
  var i : LongInt;
begin
      i := ((H * 256) + L + (B * 256) + C) AND $FFFF;
      H := i div 256;
      L := i AND $0F;
      flag1(i);
{$IFDEF WANT_TIM}
      op_adhlbc:=11;
{$ENDIF}
end;

function op_adhlde:Integer; far;                                 { ADD HL,DE }
  var i : LongInt;
begin
      i := ((H * 256) + L + (D * 256) + E) AND $FFFF;
      H := i div 256;
      L := i AND $0F;
      flag1(i);
{$IFDEF WANT_TIM}
      op_adhlde:=11;
{$ENDIF}
end;

function op_adhlhl:Integer; far;                                 { ADD HL,HL }
  var i : LongInt;
begin
      i := (((H * 256) + L) * 2) AND $FFFF;
      H := i div 256;
      L := i AND $0F;
      flag1(i);
{$IFDEF WANT_TIM}
      op_adhlhl:=11;
{$ENDIF}
end;

function op_adhlsp:Integer; far;                                 { ADD HL,SP }
  var i : LongInt;
begin
      i := ((H * 256) + L + STACK) AND $FFFF;
      H := i div 256;
      L := i AND $0F;
      flag1(i);
{$IFDEF WANT_TIM}
      op_adhlsp:=11;
{$ENDIF}
end;

function op_anda:Integer; far;                                       { AND A }
begin
      flag2;
      F := F OR H_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_anda:=4;
{$ENDIF}
end;

function op_andb:Integer; far;                                       { AND B }
begin
      A := A AND B;
      flag2;
      F := F OR H_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andb:=4;
{$ENDIF}
end;

function op_andc:Integer; far;                                       { AND C }
begin
      A := A AND C;
      flag2;
      F := F OR H_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andc:=4;
{$ENDIF}
end;

function op_andd:Integer; far;                                       { AND D }
begin
      A := A AND D;
      flag2;
      F := F OR H_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andd:=4;
{$ENDIF}
end;

function op_ande:Integer; far;                                       { AND E }
begin
      A := A AND E;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_ande:=4;
{$ENDIF}
end;

function op_andh:Integer; far;                                       { AND H }
begin
      A := A AND H;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andh:=4;
{$ENDIF}
end;

function op_andl:Integer; far;                                       { AND L }
begin
      A := A AND L;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andl:=4;
{$ENDIF}
end;

function op_andhl:Integer; far;                                   { AND (HL) }
begin
      A := A AND Speicher_lesen_Byte(H * 256 + L);
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andhl:=7;
{$ENDIF}
end;

function op_andn:Integer; far;                                       { AND n }
begin
      A := A AND Speicher_lesen_Byte(PC); PC := PC + 1;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR H_FLAG;
      if (parrity[A]=0)  then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
      F := F AND NOT (N_FLAG OR C_FLAG);
{$IFDEF WANT_TIM}
      op_andn:=7;
{$ENDIF}
end;

function op_ora:Integer; far;                                         { OR A }
begin
      flag3;
{$IFDEF WANT_TIM}
      op_ora:=4;
{$ENDIF}
end;

function op_orb:Integer; far;                                         { OR B }
begin
      A := A OR B;
      flag3;
{$IFDEF WANT_TIM}
      op_orb:=4;
{$ENDIF}
end;

function op_orc:Integer; far;                                         { OR C }
begin
      A := A OR C;
      flag3;
{$IFDEF WANT_TIM}
      op_orc:=4;
{$ENDIF}
end;

function op_ord:Integer; far;                                         { OR D }
begin
      A := A OR D;
      flag3;
{$IFDEF WANT_TIM}
      op_ord:=4;
{$ENDIF}
end;

function op_ore:Integer; far;                                         { OR E }
begin
      A := A OR E;
      flag3;
{$IFDEF WANT_TIM}
      op_ore:=4;
{$ENDIF}
end;

function op_orh:Integer; far;                                         { OR H }
begin
      A := A OR H;
      flag3;
{$IFDEF WANT_TIM}
      op_orh:=4;
{$ENDIF}
end;

function op_orl:Integer; far;                                         { OR L }
begin
      A := A OR L;
      flag3;
{$IFDEF WANT_TIM}
      op_orl:=4;
{$ENDIF}
end;

function op_orhl:Integer; far;                                     { OR (HL) }
begin
      A := A OR Speicher_lesen_Byte(H * 256 + L);
      flag3;
{$IFDEF WANT_TIM}
      op_orhl:=7;
{$ENDIF}
end;

function op_orn:Integer; far;                                         { OR n }
begin
      A := A OR Speicher_lesen_Byte(PC); PC := PC + 1;
      flag3;
{$IFDEF WANT_TIM}
      op_orn:=7;
{$ENDIF}
end;

function op_xora:Integer; far;                                       { XOR A }
begin
      A := 0;
      F := F AND NOT (S_FLAG OR H_FLAG OR N_FLAG OR C_FLAG);
      F := F OR       Z_FLAG OR P_FLAG;
{$IFDEF WANT_TIM}
      op_xora:=4;
{$ENDIF}
end;

function op_xorb:Integer; far;                                       { XOR B }
begin
      A := A XOR B;
      flag3;
{$IFDEF WANT_TIM}
      op_xorb:=4;
{$ENDIF}
end;

function op_xorc:Integer; far;                                       { XOR C }
begin
      A := A XOR C;
      flag3;
{$IFDEF WANT_TIM}
      op_xorc:=4;
{$ENDIF}
end;

function op_xord:Integer; far;                                       { XOR D }
begin
      A := A XOR D;
      flag3;
{$IFDEF WANT_TIM}
      op_xord:=4;
{$ENDIF}
end;

function op_xore:Integer; far;                                       { XOR E }
begin
      A := A XOR E;
      flag3;
{$IFDEF WANT_TIM}
      op_xore:=4;
{$ENDIF}
end;

function op_xorh:Integer; far;                                       { XOR H }
begin
      A := A XOR H;
      flag3;
{$IFDEF WANT_TIM}
      op_xorh:=4;
{$ENDIF}
end;

function op_xorl:Integer; far;                                       { XOR L }
begin
      A := A XOR L;
      flag3;
{$IFDEF WANT_TIM}
      op_xorl:=4;
{$ENDIF}
end;

function op_xorhl:Integer; far;                                   { XOR (HL) }
begin
      A := A XOR Speicher_lesen_Byte(H * 256 + L);
      flag3;
{$IFDEF WANT_TIM}
      op_xorhl:=7;
{$ENDIF}
end;

function op_xorn:Integer; far;                                       { XOR n }
begin
      A := A XOR Speicher_lesen_Byte(PC); PC := PC + 1;
      flag3;
{$IFDEF WANT_TIM}
      op_xorn:=7;
{$ENDIF}
end;

function op_adda:Integer; far;                                     { ADD A,A }
  var i : Integer;
begin
      if ((A AND $0F) + (A AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A * 2) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A * 2;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adda:=4;
{$ENDIF}
end;

function op_addb:Integer; far;                                     { ADD A,B }
  var i : Integer;
begin
      if ((A AND $0F) + (B AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + B) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + B;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addb:=4;
{$ENDIF}
end;

function op_addc:Integer; far;                                     { ADD A,C }
  var i : Integer;
begin
      if ((A AND $0F) + (C AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + C) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + C;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addc:=4;
{$ENDIF}
end;

function op_addd:Integer; far;                                     { ADD A,D }
  var i : Integer;
begin
      if ((A AND $0F) + (D AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + D) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + D;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addd:=4;
{$ENDIF}
end;

function op_adde:Integer; far;                                     { ADD A,E }
  var i : Integer;
begin
      if ((A AND $0F) + (E AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + E) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + E;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adde:=4;
{$ENDIF}
end;

function op_addh:Integer; far;                                     { ADD A,H }
  var i : Integer;
begin
      if ((A AND $0F) + (H AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + H) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + H;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addh:=4;
{$ENDIF}
end;

function op_addl:Integer; far;                                     { ADD A,L }
  var i : Integer;
begin
      if ((A AND $0F) + (L AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + L) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + L;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addl:=4;
{$ENDIF}
end;

function op_addhl:Integer; far;                                 { ADD A,(HL) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(H *256 + L);
      if ((A AND $0F) + (P AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + P) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + P;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addhl:=7;
{$ENDIF}
end;

function op_addn:Integer; far;                                     { ADD A,n }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((A AND $0F) + (P AND $0F) > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + P) > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := A + P;
      A := i;
      if (i < -128) OR (i > 127)           then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                   then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                             then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_addn:=7;
{$ENDIF}
end;


function op_adca:Integer; far;                                     { ADC A,A }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (A AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A * 2) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A * 2)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adca:=4;
{$ENDIF}
end;

function op_adcb:Integer; far;                                     { ADC A,B }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (B AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + B) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + B)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adcb:=4;
{$ENDIF}
end;

function op_adcc:Integer; far;                                     { ADC A,C }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (C AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + C) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + C)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adcc:=4;
{$ENDIF}
end;

function op_adcd:Integer; far;                                     { ADC A,D }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (D AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + D) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + D)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adcd:=4;
{$ENDIF}
end;

function op_adce:Integer; far;                                     { ADC A,E }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (E AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + E) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + E)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adce:=4;
{$ENDIF}
end;

function op_adch:Integer; far;                                     { ADC A,H }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (H AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + H) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + H)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adch:=4;
{$ENDIF}
end;

function op_adcl:Integer; far;                                     { ADC A,L }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (L AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + L) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + L)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adcl:=4;
{$ENDIF}
end;

function op_adchl:Integer; far;                                 { ADC A,(HL) }
  var i,carry : Integer;
      P       : Byte;
begin
      P := Speicher_lesen_Byte((H shl 8) + L);
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (P AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + P) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + P)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adchl:=7;
{$ENDIF}
end;

function op_adcn:Integer; far;                                     { ADC A,n }
  var i,carry : Integer;
      P       : Byte;
begin
      P := Speicher_lesen_Byte(PC); PC := PC + 1;
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((A AND $0F) + (P AND $0F) + carry > $0F) then F := F OR      H_FLAG else F := F AND NOT H_FLAG;
      if ((A + P) + carry > 255)                   then F := F OR      C_FLAG else F := F AND NOT C_FLAG;
      i := (A + P)+ carry;
      A := i;
      if (i < -128) OR (i > 127)                   then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                           then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                                     then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_adcn:=7;
{$ENDIF}
end;

function op_suba:Integer; far;                                     { SUB A,A }
begin
      A := 0;
      F := F AND NOT (S_FLAG OR H_FLAG OR P_FLAG OR C_FLAG);
      F := F OR       Z_FLAG OR N_FLAG;
{$IFDEF WANT_TIM}
      op_suba:=4;
{$ENDIF}
end;

function op_subb:Integer; far;                                     { SUB A,B }
  var i : Integer;
begin
      if ((B AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (B > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - B;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subb:=4;
{$ENDIF}
end;

function op_subc:Integer; far;                                     { SUB A,C }
  var i : Integer;
begin
      if ((C AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (C > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - C;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subc:=4;
{$ENDIF}
end;

function op_subd:Integer; far;                                     { SUB A,D }
  var i : Integer;
begin
      if ((D AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (D > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - D;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subd:=4;
{$ENDIF}
end;

function op_sube:Integer; far;                                     { SUB A,E }
  var i : Integer;
begin
      if ((E AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (E > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - E;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sube:=4;
{$ENDIF}
end;

function op_subh:Integer; far;                                     { SUB A,H }
  var i : Integer;
begin
      if ((H AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (H > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - H;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subh:=4;
{$ENDIF}
end;

function op_subl:Integer; far;                                     { SUB A,L }
  var i : Integer;
begin
      if ((L AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (L > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - L;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subl:=4;
{$ENDIF}
end;

function op_subhl:Integer; far;                                 { SUB A,(HL) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte((H shl 8) + L);
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subhl:=7;
{$ENDIF}
end;

function op_subn:Integer; far;                                     { SUB A,n }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      A := i;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_subn:=7;
{$ENDIF}
end;

function op_sbca:Integer; far;                                     { SBC A,A }
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    F := F OR       S_FLAG OR H_FLAG OR N_FLAG OR C_FLAG;
                    F := F AND NOT (Z_FLAG OR P_FLAG);
                    A := 255;
              end
         else begin
                    F := F OR       Z_FLAG OR N_FLAG;
                    F := F AND NOT (S_FLAG OR H_FLAG OR P_FLAG OR C_FLAG);
                    A := 0;
              end;
{$IFDEF WANT_TIM}
      op_sbca:=4;
{$ENDIF}
end;

function op_sbcb:Integer; far;                                     { SBC A,B }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((B AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (B + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - B - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbcb:=4;
{$ENDIF}
end;

function op_sbcc:Integer; far;                                     { SBC A,C }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((C AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (C + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - C - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbcc:=4;
{$ENDIF}
end;

function op_sbcd:Integer; far;                                     { SBC A,D }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((D AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (D + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - D - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbcd:=4;
{$ENDIF}
end;

function op_sbce:Integer; far;                                     { SBC A,E }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((E AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (E + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - E - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbce:=4;
{$ENDIF}
end;

function op_sbch:Integer; far;                                     { SBC A,H }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((H AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (H + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - H - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbch:=4;
{$ENDIF}
end;

function op_sbcl:Integer; far;                                     { SBC A,L }
  var i,carry : Integer;
begin
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((L AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (L + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - L - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbcl:=4;
{$ENDIF}
end;

function op_sbchl:Integer; far;                                 { SBC A,(HL) }
  var i,carry : Integer;
      P       : Byte;
begin
      P := Speicher_lesen_Byte((H shr 8) + L);
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((P AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbchl:=7;
{$ENDIF}
end;

function op_sbcn:Integer; far;                                     { SBC A,n }
  var i,carry : Integer;
      P       : Byte;
begin
      P := Speicher_lesen_Byte(PC); PC := PC + 1;
      if (F AND C_FLAG)=C_FLAG then carry := 1 else carry := 0;
      if ((P AND $0F) + carry > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P + carry > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P - carry;
      A := i;
      if (i < -128) OR (i > 127)             then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80                     then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)                               then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_sbcn:=7;
{$ENDIF}
end;


function op_cpa:Integer; far;                                         { CP A }
begin
      F := F AND NOT (S_FLAG OR H_FLAG OR P_FLAG OR C_FLAG);
      F := F OR       Z_FLAG OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpa:=4;
{$ENDIF}
end;

function op_cpb:Integer; far;                                         { CP B }
  var i : Integer;
begin
      if ((B AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (B > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - B;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpb:=4;
{$ENDIF}
end;

function op_cpc:Integer; far;                                         { CP C }
  var i : Integer;
begin
      if ((C AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (C > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - C;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpc:=4;
{$ENDIF}
end;

function op_cpd:Integer; far;                                         { CP D }
  var i : Integer;
begin
      if ((D AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (D > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - D;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpd:=4;
{$ENDIF}
end;

function op_cpe:Integer; far;                                         { CP E }
  var i : Integer;
begin
      if ((E AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (E > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - E;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpe:=4;
{$ENDIF}
end;

function op_cph:Integer; far;                                         { CP H }
  var i : Integer;
begin
      if ((H AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (H > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - H;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cph:=4;
{$ENDIF}
end;

function op_cplr:Integer; far;                                         { CP L }
  var i : Integer;
begin
      if ((L AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (L > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - L;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i=0)                       then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cplr:=4;
{$ENDIF}
end;

function op_cphl:Integer; far;                                     { CP (HL) }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte((H shl 8) + L);
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i<>0)                      then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cphl:=7;
{$ENDIF}
end;

function op_cpn:Integer; far;                                         { CP n }
  var i : Integer;
      P : Byte;
begin
      P := Speicher_lesen_Byte(PC); PC := PC + 1;
      if ((P AND $0F) > (A AND $0F)) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      if (P > A)                     then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      i := A - P;
      if (i < -128) OR (i > 127)     then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (i AND $80)=$80             then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (i<>0)                      then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F OR N_FLAG;
{$IFDEF WANT_TIM}
      op_cpn:=7;
{$ENDIF}
end;

function op_inca:Integer; far;                                       { INC A }
begin
      if ((A AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      A := A + 1;
      if (A = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_inca:=4;
{$ENDIF}
end;

function op_incb:Integer; far;                                       { INC B }
begin
      if ((B AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      B := B + 1;
      if (B = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incb:=4;
{$ENDIF}
end;

function op_incc:Integer; far;                                       { INC C }
begin
      if ((C AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      C := C + 1;
      if (C = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incc:=4;
{$ENDIF}
end;

function op_incd:Integer; far;                                       { INC D }
begin
      if ((D AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      D := D + 1;
      if (D = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incd:=4;
{$ENDIF}
end;

function op_ince:Integer; far;                                       { INC E }
begin
      if ((E AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      E := E + 1;
      if (E = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_ince:=4;
{$ENDIF}
end;

function op_inch:Integer; far;                                       { INC H }
begin
      if ((H AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      H := H + 1;
      if (H = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_inch:=4;
{$ENDIF}
end;

function op_incl:Integer; far;                                       { INC L }
begin
      if ((L AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      L := L + 1;
      if (L = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incl:=4;
{$ENDIF}
end;

function op_incihl:Integer; far;                                  { INC (HL) }
  var p : Word;
begin
      p := (H shl 8) + L;
      if ((Speicher_lesen_Byte(p) AND $0F) + 1 > $0F) then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)+1);
      if (Speicher_lesen_Byte(p) = $80)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_incihl:=11;
{$ENDIF}
end;

function op_deca:Integer; far;                                       { DEC A }
begin
      if ((A-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      A := A - 1;
      if (A = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_deca:=4;
{$ENDIF}
end;

function op_decb:Integer; far;                                       { DEC B }
begin
      if ((B-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      B := B - 1;
      if (B = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (B AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (B=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_decb:=4;
{$ENDIF}
end;

function op_decc:Integer; far;                                       { DEC C }
begin
      if ((C-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      C := C - 1;
      if (C = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (C AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (C=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_decc:=4;
{$ENDIF}
end;

function op_decd:Integer; far;                                       { DEC D }
begin
      if ((D-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      D := D - 1;
      if (D = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (D AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (D=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_decd:=4;
{$ENDIF}
end;

function op_dece:Integer; far;                                       { DEC E }
begin
      if ((E-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      E := E - 1;
      if (E = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (E AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (E=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_dece:=4;
{$ENDIF}
end;

function op_dech:Integer; far;                                       { DEC H }
begin
      if ((H-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      H := H - 1;
      if (H = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (H AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (H=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_dech:=4;
{$ENDIF}
end;

function op_decl:Integer; far;                                       { DEC L }
begin
      if ((L-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      L := L - 1;
      if (L = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (L AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (L=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_decl:=4;
{$ENDIF}
end;

function op_decihl:Integer; far;                                  { DEC (HL) }
  var p : Word;
begin
      p := (H shl 8) + L;
      if ((Speicher_lesen_Byte(p)-1) AND $0F) = $0F then F := F OR H_FLAG else F := F AND NOT H_FLAG;
      Speicher_schreiben_Byte(p,Speicher_lesen_Byte(p)-1);
      if (Speicher_lesen_Byte(p) = $7F)       then F := F OR      P_FLAG else F := F AND NOT P_FLAG;
      if (Speicher_lesen_Byte(p) AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (Speicher_lesen_Byte(p)=0)           then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      F := F AND NOT N_FLAG;
{$IFDEF WANT_TIM}
      op_decihl:=11;
{$ENDIF}
end;


function op_rlca:Integer; far;                                        { RLCA }
  var i : Integer;
begin
      if (A AND $80)=$80 then i := 1 else i := 0;
      if (i=0)           then F := F OR  C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      A := A shl 1;
      A := A OR  i;
{$IFDEF WANT_TIM}
      op_rlca:=4;
{$ENDIF}
end;

function op_rrca:Integer; far;                                        { RRCA }
  var i : Integer;
begin
      i := A AND 1;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      A := A shr 1;
      if (i=0) then A := A OR $80;
{$IFDEF WANT_TIM}
      op_rrca:=4;
{$ENDIF}
end;

function op_rla:Integer; far;                                          { RLA }
  var old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      if (A AND $80)=$80 then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      A := A shl 1;
      if (old_c_flag)=C_FLAG then A := A OR 1;
{$IFDEF WANT_TIM}
      op_rla:=4;
{$ENDIF}
end;

function op_rra:Integer; far;                                          { RRA }
  var i,old_c_flag : Integer;
begin
      old_c_flag := F AND C_FLAG;
      i := A AND 1;
      if (i=0) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT (H_FLAG OR N_FLAG);
      A := A shr 1;
      if (old_c_flag)=C_FLAG then A := A OR $80;
{$IFDEF WANT_TIM}
      op_rra:=4;
{$ENDIF}
end;

function op_exdehl:Integer; far;                                  { EX DE,HL }
  var i : Integer;
begin
      i := D;
      D := H;
      H := i;
      i := E;
      E := L;
      L := i;
{$IFDEF WANT_TIM}
      op_exdehl:=4;
{$ENDIF}
end;

function op_exafaf:Integer; far;                                 { EX AF,AF' }
  var i : Integer;
begin
      i  := A;
      A  := A_;
      A_ := i;
      i  := F;
      F  := F_;
      F_ := i;
{$IFDEF WANT_TIM}
      op_exafaf:=4;
{$ENDIF}
end;

function op_exx:Integer; far;                                          { EXX }
  var i : Integer;
begin
      i  := B;
      B  := B_;
      B_ := i;
      i  := C;
      C  := C_;
      C_ := i;
      i  := D;
      D  := D_;
      D_ := i;
      i  := E;
      E  := E_;
      E_ := i;
      i  := H;
      H  := H_;
      H_ := i;
      i  := L;
      L  := L_;
      L_ := i;
{$IFDEF WANT_TIM}
      op_exx:=4;
{$ENDIF}
end;

function op_exsphl:Integer; far;                                { EX (SP),HL }
  var i : Integer;
begin
      i := Speicher_lesen_Byte(STACK);
      Speicher_schreiben_Byte(STACK,L);
      L := i;
      i := Speicher_lesen_Byte(STACK + 1);
      Speicher_schreiben_Byte(STACK + 1,H);
      H := i;
{$IFDEF WANT_TIM}
      op_exsphl:=19;
{$ENDIF}
end;

function op_pushaf:Integer; far;                                   { PUSH AF }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,A);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,F);
{$IFDEF WANT_TIM}
      op_pushaf:=11;
{$ENDIF}
end;

function op_pushbc:Integer; far;                                   { PUSH BC }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,B);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,C);
{$IFDEF WANT_TIM}
      op_pushbc:=11;
{$ENDIF}
end;

function op_pushde:Integer; far;                                   { PUSH DE }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,D);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,E);
{$IFDEF WANT_TIM}
      op_pushde:=11;
{$ENDIF}
end;

function op_pushhl:Integer; far;                                   { PUSH HL }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,H);

{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,L);
{$IFDEF WANT_TIM}
      op_pushhl:=11;
{$ENDIF}
end;

function op_popaf:Integer; far;                                     { POP AF }
begin
      F := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}

      A := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_popaf:=10;
{$ENDIF}
end;

function op_popbc:Integer; far;                                     { POP BC }
begin
      C := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}

      B := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_popbc:=10;
{$ENDIF}
end;

function op_popde:Integer; far;                                     { POP DE }
begin
      E := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}

      D := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_popde:=10;
{$ENDIF}
end;

function op_pophl:Integer; far;                                     { POP HL }
begin
      L := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}

      H := Speicher_lesen_Byte(STACK);
      STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK := 0;
{$ENDIF}
{$IFDEF WANT_TIM}
      op_pophl:=10;
{$ENDIF}
end;

function op_jp:Integer; far;                                            { JP }
  var i : Integer;
begin
      i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i  := i + Speicher_lesen_Byte(PC) shl 8;
      PC := i;
{$IFDEF WANT_TIM}
      op_jp:=10;
{$ENDIF}
end;

function op_jphl:Integer; far;                                     { JP (HL) }
begin
      PC := (H shl 8) + L;
{$IFDEF WANT_TIM}
      op_jphl:=4;
{$ENDIF}
end;

function op_jr:Integer; far;                                            { JR }
  var i : ShortInt;
begin
      i := Speicher_lesen_Byte(PC);
      PC := PC + i + 1;
{$IFDEF WANT_TIM}
      op_jr:=12;
{$ENDIF}
end;

function op_djnz:Integer; far;                                        { DJNZ }
  var i : ShortInt;
begin
      B := B - 1; i := Speicher_lesen_Byte(PC);
      if (B <> 0) then begin PC := PC + i + 1;
{$IFDEF WANT_TIM}
                             op_djnz:=13;
{$ENDIF}
                       end
                  else begin PC := PC + 1;
{$IFDEF WANT_TIM}
                             op_djnz:=8;
{$ENDIF}
                       end;
end;

function op_call:Integer; far;                                        { CALL }
  var i : Integer;
begin
      i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
      i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK -1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK -1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := i;
{$IFDEF WANT_TIM}
      op_call:=17;
{$ENDIF}
end;

function op_ret:Integer; far;                                          { RET }
  var i : Integer;
begin
      i := Speicher_lesen_Byte(STACK); STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
      if (STACK >= 65536) then STACK :=	0;
{$ENDIF}
      PC := i;
{$IFDEF WANT_TIM}
      op_ret:=10;
{$ENDIF}
end;

function op_jpz:Integer; far;                                      { JP Z,nn }
  var i : Integer;
begin
      if (F AND Z_FLAG)=Z_FLAG
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
		    PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpz:=10;
{$ENDIF}
end;

function op_jpnz:Integer; far;                                    { JP NZ,nn }
  var i : Integer;
begin
      if NOT ((F AND Z_FLAG)=Z_FLAG)
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
	            PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpnz:=10;
{$ENDIF}
end;

function op_jpc:Integer; far;                                      { JP C,nn }
  var i : Integer;
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
                    PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpc:=10;
{$ENDIF}
end;

function op_jpnc:Integer; far;                                    { JP NC,nn }
  var i : Integer;
begin
      if NOT ((F AND C_FLAG)=C_FLAG)
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
	            PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpnc:=10;
{$ENDIF}
end;

function op_jppe:Integer; far;                                    { JP PE,nn }
  var i : Integer;
begin
      if (F AND P_FLAG)=P_FLAG
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
                    PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jppe:=10;
{$ENDIF}
end;

function op_jppo:Integer; far;                                    { JP PO,nn }
  var i : Integer;
begin
      if NOT ((F AND P_FLAG)=P_FLAG)
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
	            PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jppo:=10;
{$ENDIF}
end;

function op_jpm:Integer; far;                                      { JP M,nn }
  var i : Integer;
begin
      if (F AND S_FLAG)=S_FLAG
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
                    PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpm:=10;
{$ENDIF}
end;

function op_jpp:Integer; far;                                      { JP P,nn }
  var i : Integer;
begin
      if NOT ((F AND S_FLAG)=S_FLAG)
         then begin
                    i  :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i  := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
                    PC := i;
              end
         else
	            PC := PC + 2;
{$IFDEF WANT_TIM}
      op_jpp:=10;
{$ENDIF}
end;

function op_calz:Integer; far;                                   { CALL Z,nn }
  var i : Integer;
begin
      if (F AND Z_FLAG)=Z_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calz:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calz:=10;
{$ENDIF}
              end;
end;

function op_calnz:Integer; far;                                 { CALL NZ,nn }
  var i : Integer;
begin
      if NOT ((F AND Z_FLAG)=Z_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calnz:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calnz:=10;
{$ENDIF}
              end;
end;

function op_calc:Integer; far;                                   { CALL C,nn }
  var i : Integer;
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calc:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calc:=10;
{$ENDIF}
              end;
end;

function op_calnc:Integer; far;                                 { CALL NC,nn }
  var i : Integer;
begin
      if NOT ((F AND C_FLAG)=C_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calnc:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calnc:=10;
{$ENDIF}
              end;
end;

function op_calpe:Integer; far;                                 { CALL PE,nn }
  var i : Integer;
begin
      if (F AND P_FLAG)=P_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calpe:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calpe:=10;
{$ENDIF}
              end;
end;

function op_calpo:Integer; far;                                 { CALL PO,nn }
  var i : Integer;
begin
      if NOT ((F AND P_FLAG)=P_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calpo:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calpo:=10;
{$ENDIF}
              end;
end;

function op_calm:Integer; far;                                   { CALL M,nn }
  var i : Integer;
begin
      if (F AND S_FLAG)=S_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calm:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calm:=10;
{$ENDIF}
              end;
end;

function op_calp:Integer; far;                                   { CALL P,nn }
  var i : Integer;
begin
      if NOT ((F AND S_FLAG)=S_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(PC)      ; PC := PC + 1;
                    i := i + Speicher_lesen_Byte(PC) shl 8; PC := PC + 1;
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC shr 8);
{$IFDEF WANT_SPC}
                    if (STACK <= 0) then STACK := 65536;
{$ENDIF}
                    STACK := STACK - 1;
                    Speicher_schreiben_Byte(STACK, PC AND $00FF);
                    PC := i;
{$IFDEF WANT_TIM}
                    op_calp:=17;
{$ENDIF}
              end
         else begin
                    PC := PC + 2;
{$IFDEF WANT_TIM}
                    op_calp:=10;
{$ENDIF}
              end;
end;

function op_retz:Integer; far;                                       { RET Z }
  var i : Integer;
begin
      if (F AND Z_FLAG)=Z_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retz:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retz:=5;
{$ENDIF}
end;

function op_retnz:Integer; far;                                     { RET NZ }
  var i : Integer;
begin
      if NOT ((F AND Z_FLAG)=Z_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retnz:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retnz:=5;
{$ENDIF}
end;

function op_retc:Integer; far;                                       { RET C }
  var i : Integer;
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retc:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retc:=5;
{$ENDIF}
end;

function op_retnc:Integer; far;                                     { RET NC }
  var i : Integer;
begin
      if NOT ((F AND C_FLAG)=C_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retnc:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retnc:=5;
{$ENDIF}
end;

function op_retpe:Integer; far;                                     { RET PE }
  var i : Integer;
begin
      if (F AND P_FLAG)=P_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retpe:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retpe:=5;
{$ENDIF}
end;

function op_retpo:Integer; far;                                     { RET PO }
  var i : Integer;
begin
      if NOT ((F AND P_FLAG)=P_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retpo:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retpo:=5;
{$ENDIF}
end;

function op_retm:Integer; far;                                       { RET M }
  var i : Integer;
begin
      if (F AND S_FLAG)=S_FLAG
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retm:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retm:=5;
{$ENDIF}
end;

function op_retp:Integer; far;                                       { RET P }
  var i : Integer;
begin
      if NOT ((F AND S_FLAG)=S_FLAG)
         then begin
                    i :=     Speicher_lesen_Byte(STACK)      ; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    i := i + Speicher_lesen_Byte(STACK) shl 8; STACK := STACK + 1;
{$IFDEF WANT_SPC}
                    if (STACK >= 65536) then STACK := 0;
{$ENDIF}
                    PC := i;
{$IFDEF WANT_TIM}
                    op_retp:=11;
{$ENDIF}
              end
         else
{$IFDEF WANT_TIM}
                    op_retp:=5;
{$ENDIF}
end;

function op_jrz:Integer; far;                                       { JR Z,n }
  var i : ShortInt;
begin
      if (F AND Z_FLAG)=Z_FLAG
         then begin
                    i  := Speicher_lesen_Byte(PC);
                    PC := PC + i + 1;
{$IFDEF WANT_TIM}
                    op_jrz:=12;
{$ENDIF}
              end
         else begin
                    PC := PC + 1;
{$IFDEF WANT_TIM}
                    op_jrz:=7;
{$ENDIF}
              end;
end;

function op_jrnz:Integer; far;                                     { JR NZ,n }
  var i : ShortInt;
begin
      if NOT ((F AND Z_FLAG)=Z_FLAG)
         then begin
                    i  := Speicher_lesen_Byte(PC);
                    PC := PC + i + 1;
{$IFDEF WANT_TIM}
                    op_jrnz:=12;
{$ENDIF}
              end
         else begin
                    PC := PC + 1;
{$IFDEF WANT_TIM}
                    op_jrnz:=7;
{$ENDIF}
              end;
end;

function op_jrc:Integer; far;                                       { JR C,n }
  var i : ShortInt;
begin
      if (F AND C_FLAG)=C_FLAG
         then begin
                    i  := Speicher_lesen_Byte(PC);
                    PC := PC + i + 1;
{$IFDEF WANT_TIM}
                    op_jrc:=12;
{$ENDIF}
              end
         else begin
                    PC := PC + 1;
{$IFDEF WANT_TIM}
                    op_jrc:=7;
{$ENDIF}
              end;
end;

function op_jrnc:Integer; far;                                     { JR NC,n }
  var i : ShortInt;
begin
      if NOT ((F AND C_FLAG)=C_FLAG)
         then begin
                    i  := Speicher_lesen_Byte(PC);
                    PC := PC + i + 1;
{$IFDEF WANT_TIM}
                    op_jrnc:=12;
{$ENDIF}
              end
         else begin
                    PC := PC + 1;
{$IFDEF WANT_TIM}
                    op_jrnc:=7;
{$ENDIF}
              end;
end;

function op_rst00:Integer; far;                                     { RST 00 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := 0;
{$IFDEF WANT_TIM}
      op_rst00:=11;
{$ENDIF}
end;

function op_rst08:Integer; far;                                     { RST 08 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $08;
{$IFDEF WANT_TIM}
      op_rst08:=11;
{$ENDIF}
end;

function op_rst10:Integer; far;                                     { RST 10 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $10;
{$IFDEF WANT_TIM}
      op_rst10:=11;
{$ENDIF}
end;

function op_rst18:Integer; far;                                     { RST 18 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $18;
{$IFDEF WANT_TIM}
      op_rst18:=11;
{$ENDIF}
end;

function op_rst20:Integer; far;                                     { RST 20 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $20;
{$IFDEF WANT_TIM}
      op_rst20:=11;
{$ENDIF}
end;

function op_rst28:Integer; far;                                     { RST 28 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $28;
{$IFDEF WANT_TIM}
      op_rst28:=11;
{$ENDIF}
end;

function op_rst30:Integer; far;                                     { RST 30 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $30;
{$IFDEF WANT_TIM}
      op_rst30:=11;
{$ENDIF}
end;

function op_rst38:Integer; far;                                     { RST 38 }
begin
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC shr 8);
{$IFDEF WANT_SPC}
      if (STACK <= 0) then STACK := 65536;
{$ENDIF}
      STACK := STACK - 1;
      Speicher_schreiben_Byte(STACK,PC AND $00FF);
      PC := $38;
{$IFDEF WANT_TIM}
      op_rst38:=11;
{$ENDIF}
end;

procedure cpu;
  const op_sim : Array[0..255] of op_func =
       (op_nop,   {0x00} op_ldbcnn,   {0x01} op_ldbca, {0x02} op_incbc,    {0x03}
        op_incb,  {0x04} op_decb,     {0x05} op_ldbn,  {0x06} op_rlca,     {0x07}
        op_exafaf,{0x08} op_adhlbc,   {0x09} op_ldabc, {0x0a} op_decbc,    {0x0b}
        op_incc,  {0x0c} op_decc,     {0x0d} op_ldcn,  {0x0e} op_rrca,     {0x0f}
        op_djnz,  {0x10} op_lddenn,   {0x11} op_lddea, {0x12} op_incde,    {0x13}
        op_incd,  {0x14} op_decd,     {0x15} op_lddn,  {0x16} op_rla,      {0x17}
        op_jr,    {0x18} op_adhlde,   {0x19} op_ldade, {0x1a} op_decde,    {0x1b}
        op_ince,  {0x1c} op_dece,     {0x1d} op_lden,  {0x1e} op_rra,      {0x1f}
        op_jrnz,  {0x20} op_ldhlnn,   {0x21} op_ldinhl,{0x22} op_inchl,    {0x23}
        op_inch,  {0x24} op_dech,     {0x25} op_ldhn,  {0x26} op_daa,      {0x27}
        op_jrz,   {0x28} op_adhlhl,   {0x29} op_ldhlin,{0x2a} op_dechl,    {0x2b}
        op_incl,  {0x2c} op_decl,     {0x2d} op_ldln,  {0x2e} op_cpl,      {0x2f}
        op_jrnc,  {0x30} op_ldspnn,   {0x31} op_ldnna, {0x32} op_incsp,    {0x33}
        op_incihl,{0x34} op_decihl,   {0x35} op_ldhl1, {0x36} op_scf,      {0x37}
        op_jrc,   {0x38} op_adhlsp,   {0x39} op_ldann, {0x3a} op_decsp,    {0x3b}
        op_inca,  {0x3c} op_deca,     {0x3d} op_ldan,  {0x3e} op_ccf,      {0x3f}
        op_ldbb,  {0x40} op_ldbc,     {0x41} op_ldbd,  {0x42} op_ldbe,     {0x43}
        op_ldbh,  {0x44} op_ldbl,     {0x45} op_ldbhl, {0x46} op_ldba,     {0x47}
        op_ldcb,  {0x48} op_ldcc,     {0x49} op_ldcd,  {0x4a} op_ldce,     {0x4b}
        op_ldch,  {0x4c} op_ldcl,     {0x4d} op_ldchl, {0x4e} op_ldca,     {0x4f}
        op_lddb,  {0x50} op_lddc,     {0x51} op_lddd,  {0x52} op_ldde,     {0x53}
        op_lddh,  {0x54} op_lddl,     {0x55} op_lddhl, {0x56} op_ldda,     {0x57}
        op_ldeb,  {0x58} op_ldec,     {0x59} op_lded,  {0x5a} op_ldee,     {0x5b}
        op_ldeh,  {0x5c} op_ldel,     {0x5d} op_ldehl, {0x5e} op_ldea,     {0x5f}
        op_ldhb,  {0x60} op_ldhc,     {0x61} op_ldhd,  {0x62} op_ldhe,     {0x63}
        op_ldhh,  {0x64} op_ldhl,     {0x65} op_ldhhl, {0x66} op_ldha,     {0x67}
        op_ldlb,  {0x68} op_ldlc,     {0x69} op_ldld,  {0x6a} op_ldle,     {0x6b}
        op_ldlh,  {0x6c} op_ldll,     {0x6d} op_ldlhl, {0x6e} op_ldla,     {0x6f}
        op_ldhlb, {0x70} op_ldhlc,    {0x71} op_ldhld, {0x72} op_ldhle,    {0x73}
        op_ldhlh, {0x74} op_ldhll,    {0x75} op_halt,  {0x76} op_ldhla,    {0x77}
        op_ldab,  {0x78} op_ldac,     {0x79} op_ldad,  {0x7a} op_ldae,     {0x7b}
        op_ldah,  {0x7c} op_ldal,     {0x7d} op_ldahl, {0x7e} op_ldaa,     {0x7f}
        op_addb,  {0x80} op_addc,     {0x81} op_addd,  {0x82} op_adde,     {0x83}
        op_addh,  {0x84} op_addl,     {0x85} op_addhl, {0x86} op_adda,     {0x87}
        op_adcb,  {0x88} op_adcc,     {0x89} op_adcd,  {0x8a} op_adce,     {0x8b}
        op_adch,  {0x8c} op_adcl,     {0x8d} op_adchl, {0x8e} op_adca,     {0x8f}
        op_subb,  {0x90} op_subc,     {0x91} op_subd,  {0x92} op_sube,     {0x93}
        op_subh,  {0x94} op_subl,     {0x95} op_subhl, {0x96} op_suba,     {0x97}
        op_sbcb,  {0x98} op_sbcc,     {0x99} op_sbcd,  {0x9a} op_sbce,     {0x9b}
        op_sbch,  {0x9c} op_sbcl,     {0x9d} op_sbchl, {0x9e} op_sbca,     {0x9f}
        op_andb,  {0xa0} op_andc,     {0xa1} op_andd,  {0xa2} op_ande,     {0xa3}
        op_andh,  {0xa4} op_andl,     {0xa5} op_andhl, {0xa6} op_anda,     {0xa7}
        op_xorb,  {0xa8} op_xorc,     {0xa9} op_xord,  {0xaa} op_xore,     {0xab}
        op_xorh,  {0xac} op_xorl,     {0xad} op_xorhl, {0xae} op_xora,     {0xaf}
        op_orb,   {0xb0} op_orc,      {0xb1} op_ord,   {0xb2} op_ore,      {0xb3}
        op_orh,   {0xb4} op_orl,      {0xb5} op_orhl,  {0xb6} op_ora,      {0xb7}
        op_cpb,   {0xb8} op_cpc,      {0xb9} op_cpd,   {0xba} op_cpe,      {0xbb}
        op_cph,   {0xbc} op_cplr,     {0xbd} op_cphl,  {0xbe} op_cpa,      {0xbf}
        op_retnz, {0xc0} op_popbc,    {0xc1} op_jpnz,  {0xc2} op_jp,       {0xc3}
        op_calnz, {0xc4} op_pushbc,   {0xc5} op_addn,  {0xc6} op_rst00,    {0xc7}
        op_retz,  {0xc8} op_ret,      {0xc9} op_jpz,   {0xca} op_cb_handel,{0xcb}
        op_calz,  {0xcc} op_call,     {0xcd} op_adcn,  {0xce} op_rst08,    {0xcf}
        op_retnc, {0xd0} op_popde,    {0xd1} op_jpnc,  {0xd2} op_out,      {0xd3}
        op_calnc, {0xd4} op_pushde,   {0xd5} op_subn,  {0xd6} op_rst10,    {0xd7}
        op_retc,  {0xd8} op_exx,      {0xd9} op_jpc,   {0xda} op_in,       {0xdb}
        op_calc,  {0xdc} op_dd_handel,{0xdd} op_sbcn,  {0xde} op_rst18,    {0xdf}
        op_retpo, {0xe0} op_pophl,    {0xe1} op_jppo,  {0xe2} op_exsphl,   {0xe3}
        op_calpo, {0xe4} op_pushhl,   {0xe5} op_andn,  {0xe6} op_rst20,    {0xe7}
        op_retpe, {0xe8} op_jphl,     {0xe9} op_jppe,  {0xea} op_exdehl,   {0xeb}
        op_calpe, {0xec} op_ed_handel,{0xed} op_xorn,  {0xee} op_rst28,    {0xef}
        op_retp,  {0xf0} op_popaf,    {0xf1} op_jpp,   {0xf2} op_di,       {0xf3}
        op_calp,  {0xf4} op_pushaf,   {0xf5} op_orn,   {0xf6} op_rst30,    {0xf7}
        op_retm,  {0xf8} op_ldsphl,   {0xf9} op_jpm,   {0xfa} op_ei,       {0xfb}
        op_calm,  {0xfc} op_fd_handel,{0xfd} op_cpn,   {0xfe} op_rst38     {0xff}
       );
  var op_f : op_func;
{$IFDEF WANT_TIM}
      t    : LongInt;
{$ENDIF}
begin repeat
{$IFDEF HISIZE}		{ write history }
             his[h_next].h_adr:= PC;
             his[h_next].h_af := (A * 256) + F;
             his[h_next].h_bc := (B * 256) + C;
             his[h_next].h_de := (D * 256) + E;
             his[h_next].h_hl := (H * 256) + L;
             his[h_next].h_ix := IX;
             his[h_next].h_iy := IY;
             his[h_next].h_sp := STACK;
                 h_next       := h_next + 1;
             if (h_next = HISIZE) then begin h_flag:=1; h_next:=1; end;
{$ENDIF}

{$IFDEF WANT_TIM}           { check for start address of runtime measurement }
             if (PC = t_start AND not t_flag)
                then begin t_flag   := 1;            { switch measurement on }
		           t_states := 0;      { initialize counted T-states }
                     end;
{$ENDIF}

{$IFDEF WANT_INT}		                    { CPU interrupt handling }
             if (int_type)
                then case int_type of INT_NMI:      { non maskable interrupt }
	                                       break;
                                      INT_INT:          { maskable interrupt }
                                               break;
                    end;
{$ENDIF}
             op_f := op_sim[Speicher_lesen_Byte(PC)];
             PC := PC + 1;
{$IFDEF WANT_TIM}                                      { execute next opcode }
             t := op_f;
{$ELSE}
             op_f;
{$ENDIF}

{$IFDEF WANT_PCC}                                     { check for PC overrun }
             if (PC > 65535) then PC := 0;
{$ENDIF}

             R := R + 1;                        { increment refresh register }

{$IFDEF WANT_TIM}                                   { do runtime measurement }
             if (t_flag=0)
                then begin t_states := t_states+t;{ add T-states for this opcode }
                           if (PC = t_end)            { check for end address }
                              then t_flag := 0; { if reached, switch measurement off }
                     end;
{$ENDIF}

      until (cpu_state=0);
end;

begin
end.
