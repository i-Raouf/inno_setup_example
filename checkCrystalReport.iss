[Code]
function IsCrystalReportInstalled(): Boolean;
var 
    crystalReportInstalled: Boolean;
begin
    crystalReportInstalled := DirExists(ExpandConstant('{commonpf32}\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0'));
    Result := crystalReportInstalled;
end;

procedure InstallcrystalReport;
var
  ResultCode: Integer;
begin
  if not ShellExec('', 'msiexec.exe',
     ExpandConstant('/i "{src}\Bin\CRRuntime_32bit_13_0_20.msi" /qn'), '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
  begin
    MsgBox('Crystal Report Runtime installation failed with code: ' + IntToStr(ResultCode) + '.',
      mbError, MB_OK);
  end;
end;