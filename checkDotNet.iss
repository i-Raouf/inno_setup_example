[Code]
function IsDotNetInstalled(): Boolean;
var 
    v: Cardinal;
    dotnetInstalled: Boolean;
begin
    dotnetInstalled := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Servicing', v);
    Result := dotnetInstalled;
end;

procedure InstallDotNet;
var
  ResultCode: Integer;
begin
  if not Exec('Bin\\dotNetFx40_Full_x86_x64.exe', '/q /norestart', '', SW_SHOW,
     ewWaitUntilTerminated, ResultCode) then
  begin
    MsgBox('.NET installation failed with code: ' + IntToStr(ResultCode) + '.',
      mbError, MB_OK);
  end;
end;