uses Crt;

var fb      : Array[1..3] of Byte;
    fd1,fd2 : file of Byte;
    i       : Integer;

begin if ParamCount<>1 then begin ClrScr; WriteLn(' Aufruf:  COM-BIN name '); exit; end;

      Assign(fd1,ParamStr(1)+'.COM'); Reset  (fd1);
      Assign(fd2,ParamStr(1)+'.BIN'); Rewrite(fd2);
      fb[1]:=$FF; fb[2]:=0; fb[3]:=0;
      for i:=1 to 3 do Write(fd2,fb[i]);
      while not Eof(fd1) do
      begin Read(fd1,fb[1]); Write(fd2,fb[1]); end;
      Close(fd1); Close(fd2);
end.
