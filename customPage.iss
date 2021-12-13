#include "checkDotNet.iss";
#include "checkCrystalReport.iss";
#include "checkSqlServer.iss";
[Code]
var
  Page: TWizardPage;
  CheckListBox: TNewCheckListBox;

procedure InitializeWizard();
begin
  // create page after welcome page
  Page :=
    CreateCustomPage(wpWelcome, 'Software requirements', 'Checking requirements');

    CheckListBox := TNewCheckListBox.Create(Page);
    CheckListBox.Parent := Page.Surface;
    CheckListBox.Width := Page.SurfaceWidth;
    CheckListBox.Height := Page.SurfaceHeight;

    // styling
    CheckListBox.BorderStyle := bsNone;
    CheckListBox.Color := clBtnFace;
    CheckListBox.WantTabs := True;
    CheckListBox.MinItemHeight := ScaleY(22); 

    // AddCheckBox(ACaption, ASubItem, ALevel, AChecked, AEnabled, AHasInternalChildren, ACheckWhenParentChecked, AObject)
     CheckListBox.AddCheckBox('Microsoft .NET Framework 4 Full', '', 0, not IsDotNetInstalled(), not IsDotNetInstalled, False, False, nil); 
     CheckListBox.AddCheckBox('Crystal Report Runtime', '', 0, not IsCrystalReportInstalled(), not IsCrystalReportInstalled(), False, False, nil); 
     CheckListBox.AddCheckBox('Microsoft SQL Server 2008 R2 - Express Edition', '', 0, not IsSqlServerInstalled(), not IsSqlServerInstalled(), False, False, nil); 

end;
