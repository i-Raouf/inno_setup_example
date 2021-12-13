[Code]
function IsDotNetInstalled(): Boolean;
var 
    v: Cardinal;
    dotnetInstalled: Boolean;
begin
    dotnetInstalled := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Servicing', v);
    Result := dotnetInstalled;
end;