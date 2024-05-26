{$F+}

{ Sample I/O-handler

  Port 0 input:     reads the next byte from stdin
  Port 0 output:    writes the byte to stdout

  All the other ports are connected to a I/O-trap handler,
  I/O to this ports stops the simulation with an I/O error.
}

unit IOSIM1;

interface

procedure init_io;
procedure exit_io;
function  io_in(adr:Byte):Byte;
function  io_out(adr,data:Byte):Byte;

implementation

uses WinCrt,Varia;


{ This two dimensional array contains function pointers
  for every I/O port (0 - 255), to do the needed I/O.
  The first entry is for input, the second for output.
}
type op_funcb = function (adr:Byte): Byte;

var  port     : Array [0..255,1..2] of op_funcb;
     op_f     : op_funcb;
     data_n   : Byte;
     Tast_s1  : Byte;

{ I/O trap funtion
  This function should be added into all unused
  entrys of the port array. It stops the emulation
  with an I/O error.
}
function io_trap(data:Byte):Byte;
begin
{      cpu_error := IOTRAP;
      cpu_state := STOPPED;
      io_trap   := 0;}
end;

function in_Tast_d(data:Byte):Byte;
begin
      BWS_anzeigen;
{      in_Tast_d := ord(ReadKey);}
end;

function out_Tast_s1(data:Byte):Byte;
begin
      BWS_anzeigen;
      out_Tast_s1 := Tast_s1;
end;


{ This function is to initiate the I/O devices.
  It will be called from the CPU simulation before
  any operation with the Z80 is possible.

  In this sample I/O simulation we initialize all
  unused port with an error trap handler, so that
  simulation stops at I/O on the unused ports.

  See the I/O simulation of CP/M for a more complex
  example.
}
procedure init_io;
  var i : Integer;
begin
      for i := 0 to $FF do
          begin port[i,1] := io_trap;
                port[i,2] := io_trap;
          end;
      port[$A0,1] := in_Tast_d ;
      port[$A1,2] := out_Tast_s1 ;
      Tast_s1     := 4;
end;

{ This function is to stop the I/O devices. It is
  called from the CPU simulation on exit.

  Here is just nothing to do, see the I/O simulation
  of CP/M for a more complex example.
}
procedure exit_io;
begin
end;

{ This is the main handler for all IN op-codes,
  called by the simulator. It calls the input
  function for port adr.
}
function io_in(adr:Byte):Byte;
begin
      op_f  := port[adr,1];
      io_in := op_f(data_n);
end;

{ This is the main handler for all OUT op-codes,
  called by the simulator. It calls the output
  function for port adr.
}
function io_out(adr,data:Byte):Byte;
begin
      op_f  := port[adr,2];
      io_out:= op_f(data);
end;

begin init_io;
end.
