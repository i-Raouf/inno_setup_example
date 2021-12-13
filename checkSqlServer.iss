[Code]
function IsSqlServerInstalled(): Boolean;
var 
    sqlserverInstalled: Boolean;
    version : String;
begin
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Microsoft SQL Server\SQLEXPRESS\MSSQLServer\CurrentVersion', 'CurrentVersion', version);

    if (version < '10.5') (*or (version > '9.00') or (version = '') *) then
        sqlserverInstalled := false
    else
        sqlserverInstalled := true;
    Result := sqlserverInstalled;
end;