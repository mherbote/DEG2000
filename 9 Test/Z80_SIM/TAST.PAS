unit Tast;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button44: TButton;
    Button45: TButton;
    Button46: TButton;
    Button47: TButton;
    Button48: TButton;
    Button49: TButton;
    Button50: TButton;
    Button51: TButton;
    Button52: TButton;
    Button53: TButton;
    Button54: TButton;
    Button55: TButton;
    Button56: TButton;
    Button57: TButton;
    Button58: TButton;
    Button59: TButton;
    Button60: TButton;
    Button61: TButton;
    Button62: TButton;
    Button65: TButton;
    Button66: TButton;
    Button67: TButton;
    Button68: TButton;
    Button69: TButton;
    Button70: TButton;
    Button71: TButton;
    Panel1: TPanel;
    Button72: TButton;
    Button73: TButton;
    Button74: TButton;
    Button75: TButton;
    Button76: TButton;
    Button77: TButton;
    Button78: TButton;
    Button79: TButton;
    Button80: TButton;
    Button81: TButton;
    Button82: TButton;
    Button83: TButton;
    Button84: TButton;
    Button85: TButton;
    Button86: TButton;
    Button87: TButton;
    Button88: TButton;
    Button89: TButton;
    Button90: TButton;
    Button91: TButton;
    Button92: TButton;
    Button93: TButton;
    Button94: TButton;
    Button95: TButton;
    Button96: TButton;
    Button97: TButton;
    Button98: TButton;
    Button99: TButton;
    Button100: TButton;
    Button101: TButton;
    Button102: TButton;
    Button103: TButton;
    Button107: TButton;
    Button108: TButton;
    Button110: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    procedure Button31Click(Sender: TObject);
    procedure Button66Click(Sender: TObject);
    procedure Button91Click(Sender: TObject);
    procedure Button95Click(Sender: TObject);
    procedure Button99Click(Sender: TObject);
    procedure Button103Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Tast_Akt(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button31Click(Sender: TObject);
begin
     case Panel11.Color of clBtnFace: begin Panel11.Color  :=clRed;
                                            Button1.Caption:='!';
                                            Button2.Caption:='"';
                                            Button3.Caption:='#';
                                            Button4.Caption:='$';
                                            Button5.Caption:='%';
                                            Button6.Caption:='&&';
                                            Button7.Caption:='''';
                                            Button8.Caption:='(';
                                            Button9.Caption:=')';
                                            Button10.Caption:='_';
                                            Button11.Caption:='=';
                                            Button12.Caption:='_';
                                            Button16.Caption:='Q';
                                            Button17.Caption:='W';
                                            Button18.Caption:='E';
                                            Button19.Caption:='R';
                                            Button20.Caption:='T';
                                            Button21.Caption:='Z';
                                            Button22.Caption:='U';
                                            Button23.Caption:='I';
                                            Button24.Caption:='O';
                                            Button25.Caption:='P';
                                            Button26.Caption:='`';
                                            Button27.Caption:='{';
                                            Button32.Caption:='A';
                                            Button33.Caption:='S';
                                            Button34.Caption:='D';
                                            Button35.Caption:='F';
                                            Button36.Caption:='G';
                                            Button37.Caption:='H';
                                            Button38.Caption:='J';
                                            Button39.Caption:='K';
                                            Button40.Caption:='L';
                                            Button41.Caption:='+';
                                            Button42.Caption:='*';
                                            Button43.Caption:='}';
                                            Button47.Caption:='\';
                                            Button48.Caption:='Y';
                                            Button49.Caption:='X';
                                            Button50.Caption:='C';
                                            Button51.Caption:='V';
                                            Button52.Caption:='B';
                                            Button53.Caption:='N';
                                            Button54.Caption:='M';
                                            Button55.Caption:='<';
                                            Button56.Caption:='>';
                                            Button57.Caption:='?';
                                      end;
                               clRed: begin Panel11.Color:=clBtnFace;
                                            Button1.Caption:='1';
                                            Button2.Caption:='2';
                                            Button3.Caption:='3';
                                            Button4.Caption:='4';
                                            Button5.Caption:='5';
                                            Button6.Caption:='6';
                                            Button7.Caption:='7';
                                            Button8.Caption:='8';
                                            Button9.Caption:='9';
                                            Button10.Caption:='0';
                                            Button11.Caption:='-';
                                            Button12.Caption:='^';
                                            Button16.Caption:='q';
                                            Button17.Caption:='w';
                                            Button18.Caption:='e';
                                            Button19.Caption:='r';
                                            Button20.Caption:='t';
                                            Button21.Caption:='z';
                                            Button22.Caption:='u';
                                            Button23.Caption:='i';
                                            Button24.Caption:='o';
                                            Button25.Caption:='p';
                                            Button26.Caption:='@';
                                            Button27.Caption:='[';
                                            Button32.Caption:='a';
                                            Button33.Caption:='s';
                                            Button34.Caption:='d';
                                            Button35.Caption:='f';
                                            Button36.Caption:='g';
                                            Button37.Caption:='h';
                                            Button38.Caption:='j';
                                            Button39.Caption:='k';
                                            Button40.Caption:='l';
                                            Button41.Caption:=';';
                                            Button42.Caption:=':';
                                            Button43.Caption:=']';
                                            Button47.Caption:='|';
                                            Button48.Caption:='y';
                                            Button49.Caption:='x';
                                            Button50.Caption:='c';
                                            Button51.Caption:='v';
                                            Button52.Caption:='b';
                                            Button53.Caption:='n';
                                            Button54.Caption:='m';
                                            Button55.Caption:=',';
                                            Button56.Caption:='.';
                                            Button57.Caption:='/';
                                      end;
     end;
end;

procedure TForm1.Button66Click(Sender: TObject);
begin
     case Panel2.color of clBtnFace: begin Panel2.color:=clRed;
                                           Panel5.color:=clRed;
                                           Panel6.color:=clRed;
                                     end;
                              clRed: begin Panel2.color:=clBtnFace;
                                           Panel5.color:=clBtnFace;
                                           Panel6.color:=clBtnFace;
                                     end;
     end;
end;

procedure TForm1.Button91Click(Sender: TObject);
begin
      Panel12.Color:=clRed;
      Panel13.Color:=clBtnFace;
      Panel14.Color:=clBtnFace;
      Panel15.Color:=clBtnFace;
      Button88.Caption :=' 1'; Button89.Caption :=' 2'; Button90.Caption :=' 3';
      Button92.Caption :=' 4'; Button93.Caption :=' 5'; Button94.Caption :=' 6';
      Button96.Caption :=' 7'; Button97.Caption :=' 8'; Button98.Caption :=' 9';
      Button100.Caption:='10'; Button101.Caption:='11'; Button102.Caption:='12';
end;

procedure TForm1.Button95Click(Sender: TObject);
begin
      Panel12.Color:=clBtnFace;
      Panel13.Color:=clRed;
      Panel14.Color:=clBtnFace;
      Panel15.Color:=clBtnFace;
      Button88.Caption :='13'; Button89.Caption :='14'; Button90.Caption :='15';
      Button92.Caption :='16'; Button93.Caption :='17'; Button94.Caption :='18';
      Button96.Caption :='19'; Button97.Caption :='20'; Button98.Caption :='21';
      Button100.Caption:='22'; Button101.Caption:='23'; Button102.Caption:='24';
end;

procedure TForm1.Button99Click(Sender: TObject);
begin
      Panel12.Color:=clBtnFace;
      Panel13.Color:=clBtnFace;
      Panel14.Color:=clRed;
      Panel15.Color:=clBtnFace;
      Button88.Caption :='25'; Button89.Caption :='26'; Button90.Caption :='27';
      Button92.Caption :='28'; Button93.Caption :='29'; Button94.Caption :='30';
      Button96.Caption :='31'; Button97.Caption :='32'; Button98.Caption :='33';
      Button100.Caption:='34'; Button101.Caption:='35'; Button102.Caption:='36';
end;

procedure TForm1.Button103Click(Sender: TObject);
begin
      Panel12.Color:=clBtnFace;
      Panel13.Color:=clBtnFace;
      Panel14.Color:=clBtnFace;
      Panel15.Color:=clRed;
      Button88.Caption :='37'; Button89.Caption :='38'; Button90.Caption :='39';
      Button92.Caption :='40'; Button93.Caption :='41'; Button94.Caption :='42';
      Button96.Caption :='43'; Button97.Caption :='44'; Button98.Caption :='45';
      Button100.Caption:='46'; Button101.Caption:='47'; Button102.Caption:='48';
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
     case Panel10.Color of clBtnFace: begin Panel10.Color:=clRed;
                                      end;
                               clRed: begin Panel10.Color:=clBtnFace;
                                      end;
     end;
end;

procedure TForm1.Tast_Akt(Sender: TObject);
begin
      Form1.ClientHeight:=Panel1.Height;
      Form1.ClientWidth :=Panel1.Width ;
      Panel12.Color:=clRed;
      Panel13.Color:=clBtnFace;
      Panel14.Color:=clBtnFace;
      Panel15.Color:=clBtnFace;
      Button88.Caption :=' 1'; Button89.Caption :=' 2'; Button90.Caption :=' 3';
      Button92.Caption :=' 4'; Button93.Caption :=' 5'; Button94.Caption :=' 6';
      Button96.Caption :=' 7'; Button97.Caption :=' 8'; Button98.Caption :=' 9';
      Button100.Caption:='10'; Button101.Caption:='11'; Button102.Caption:='12';
end;

end.

