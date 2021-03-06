[Code]
function IsSqlServerInstalled(): Boolean;
var 
    sqlserverInstalled: Boolean;
    Version: String;
    PackedVersion: Int64;
begin
    RegQueryStringValue(HKLM, ExpandConstant('SOFTWARE\Microsoft\Microsoft SQL Server\{#ServerInstance}\MSSQLServer\CurrentVersion'), 'CurrentVersion', version);
    if (version < '10.5') (*or (version > '9.00') or (version = '') *) then
        sqlserverInstalled := false
    else
        sqlserverInstalled := true;
    Result := sqlserverInstalled;
end;

procedure InstallSqlServer;
var
  ResultCode: Integer;
  Params: String;
begin
  Params := '/ACTION="Install" ' +
            '/Q ' +
            '/FEATURES=SQL ' +
            ExpandConstant('/INSTANCENAME="{#ServerInstance}" ') +
            '/HIDECONSOLE ' +
            '/IACCEPTSQLSERVERLICENSETERMS ';

  if not ShellExec('', ExpandConstant('{src}\Bin\SQLEXPR_x86_ENU.exe'),
     Params, '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
  begin
    MsgBox('Microsoft SQL Server 2008 R2 - Express Edition installation failed with code: ' + IntToStr(ResultCode) + '.',
      mbError, MB_OK);
  end;
end;