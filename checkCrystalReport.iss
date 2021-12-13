[Code]
function IsCrystalReportInstalled(): Boolean;
var 
    crystalReportInstalled: Boolean;
begin
    crystalReportInstalled := DirExists(ExpandConstant('{commonpf32}\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0'));
    Result := crystalReportInstalled;
end;