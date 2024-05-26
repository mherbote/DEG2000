program Z80_sim;
{$APPTYPE GUI}

uses
  Forms,
  Main    in 'MAIN.PAS'    {Form4},
  Tast    in 'TAST.PAS'    {Form1},
  Monitor in 'MONITOR.PAS' {Form2};

{$R *.RES}

begin
{      i:= $EFFF+$FFDD;
      ClrScr; Write(HexAnzeige_WordByte(i,'B'));
end.}
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

