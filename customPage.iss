#include "checkDotNet.iss";
#include "checkCrystalReport.iss";
#include "checkSqlServer.iss";
[Code]
var
  Page: TWizardPage;
  CheckListBox: TNewCheckListBox;
  OutputProgressWizardPage: TOutputProgressWizardPage;
  OutputProgressWizardPageAfterID: Integer;


function CreateRequirementsPage(PreviousPageId: Integer): Integer;
var
    Page: TWizardPage;
    CheckListBox: TNewCheckListBox;
begin
    Page := CreateCustomPage(PreviousPageId, 'Software requirements', 'Checking requirements');

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

    Result := Page.ID;
end;


procedure InitializeWizard();
begin
  // create page after welcome page
  OutputProgressWizardPageAfterID := CreateRequirementsPage(wpWelcome)

  OutputProgressWizardPage := CreateOutputProgressPage('Installing dependencies', 'Installing softwares needed to run this program');
end;


function NextButtonClick(CurPageID: Integer): Boolean;
var
  Position, Max: Integer;
begin
  if CurPageID = OutputProgressWizardPageAfterID then begin
    try
        OutputProgressWizardPage.Show
        OutputProgressWizardPage.SetProgress(0, 3);
        OutputProgressWizardPage.SetText('Installing...','Microsoft .NET Framework 4 Full');
        if not IsDotNetInstalled() then
          InstallDotNet();
        OutputProgressWizardPage.SetProgress(1, 3);
        OutputProgressWizardPage.SetText('Installing...','Crystal Report Runtime');
        if not IsCrystalReportInstalled() then
          InstallcrystalReport();
        OutputProgressWizardPage.SetProgress(2, 3);
        OutputProgressWizardPage.SetText('Installing...','Microsoft SQL Server 2008 R2 - Express Edition');
        if not IsSqlServerInstalled() then
          InstallSqlServer();
        OutputProgressWizardPage.SetProgress(3, 3);
    finally
      OutputProgressWizardPage.Hide;
    end;
  end;
  Result := True;
end;
