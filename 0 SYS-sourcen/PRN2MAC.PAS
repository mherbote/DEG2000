program PRN2MAC;
{
      (c) Marcus Herbote
      Programmstand:  26.06.2025
}


var  sym       : boolean;
     ifilename : string;
     ofilename : string;
     line      : string;
     linePRN   : string;
     inf,outf  : text;
     posStr    : integer;

function Exist(Filename: string): boolean;
   var fil : file;
begin Assign(fil, Filename);
      {$I-} Reset(fil); {$I+}
      Exist := (IOresult = 0);
end;

function Replace(inst: string): string;
  var j   : integer;
      str : string;
begin
      str := '';
      while (Length(inst)>0) do
      begin j:= Pos(#39, inst);
            if j>0 then
               begin str := str + Copy(inst,  0,             j-1) + '*';
                     inst:=       Copy(inst,j+1,Length(inst)-j  );
               end
            else
               begin str := str + Copy(inst,0,Length(inst));
                     inst:= '';
               end;
      end;
      Replace:=str;
end;

begin
     sym:=false;
     if ParamCount <> 1 then
     begin
          Writeln('Aufruf mit:  PRN2MAC filename  (ohne Erweiterung)');
          exit;
     end;

     ifilename := 'D:\QUE\DEG\BC11\'  + ParamStr(1) + '.PRN';     {zum Testen}
     ifilename := ''                  + ParamStr(1) + '.PRN';
     ofilename := 'D:\QUE\DEG\_\lst\' + ParamStr(1) + '-prn.MAC';

     WriteLn('===========');
     WriteLn('Input Datei: '+ifilename);
     WriteLn('OutputDatei: '+ofilename);

     if not Exist(ifilename) then
        begin
              WriteLn('Cannot find File: "' + ifilename + '"');
              exit;
        end
     else
        begin Assign(inf, ifilename);
              Reset(inf);
        end;

     Assign(outf, ofilename);
     Rewrite(outf);

     while not Eof(inf) do
     begin  ReadLn(inf, line);
            posStr:=Pos(#39, line);
            if line = 'Symbols:' then sym:=true;

            if (Pos(#12, line)>0) then
                  begin
                        WriteLn(outf, line);
                        Write('.');
                  end
            else
                  begin
                        if (sym) then
                              begin
                                    if (Pos('PAGE',line)>0) then
                                          begin
                                                WriteLn(outf, line);
                                                Write('.');
                                          end
                                    else
                                          begin
                                                linePRN := Replace(line);
                                                WriteLn(outf, linePRN);
                                                Write('.');
                                          end;
                              end
                        else
                              begin
                                    if (Length(line) > 0) then
                                          begin if (sym) then
                                                      begin
                                                      end
                                                else
                                                begin if posStr = 7 then
                                                            begin
                                                                  linePRN := Copy(line,0,25);
                                                                  linePRN := Replace(linePRN);
                                                                  linePRN := linePRN + Copy(line,26,Length(line)-23);
                                                                  WriteLn(outf, linePRN);
                                                                  Write('.');
                                                            end
                                                      else
                                                            begin
                                                                  WriteLn(outf, line);
                                                                  Write('.');
                                                            end;
                                                end;
                                          end
                                    else
                                          begin
                                                WriteLn(outf, line);
                                                Write('.');
                                          end
                              end
                  end

     end;
     Close(inf);
     Close(outf);
     WriteLn(' ');
     WriteLn('==========');
end.
