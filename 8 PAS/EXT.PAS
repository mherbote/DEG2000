function op_cb_handel:LongInt; far;
begin cpu_error := OPTRAP1;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      op_cb_handel:=0;
{$ENDIF}
end;

function op_dd_handel:LongInt; far;
begin cpu_error := OPTRAP1;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      op_dd_handel:=0;
{$ENDIF}
end;

function op_ed_handel:LongInt; far;
begin cpu_error := OPTRAP1;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      op_ed_handel:=0;
{$ENDIF}
end;

function op_fd_handel:LongInt; far;
begin cpu_error := OPTRAP1;
      cpu_state := STOPPED;
{$IFDEF WANT_TIM}
      op_fd_handel:=0;
{$ENDIF}
end;
