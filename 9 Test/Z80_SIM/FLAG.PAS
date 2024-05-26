procedure flag1(i:Integer);
begin
      if (i > $FFFF) then F := F OR C_FLAG else F := F AND NOT C_FLAG;
      F := F AND NOT N_FLAG;
end;

procedure flag2;
begin
      if (A AND $80)=$80 then F := F OR      S_FLAG else F := F AND NOT S_FLAG;
      if (A<>0)          then F := F AND NOT Z_FLAG else F := F OR      Z_FLAG;
      if (parrity[A]<>0) then F := F AND NOT P_FLAG else F := F OR      P_FLAG;
end;

procedure flag3;
begin
      flag2;
      F := F AND NOT (H_FLAG OR N_FLAG OR C_FLAG);
end;
