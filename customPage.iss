#include "checkDotNet.iss";
#include "checkCrystalReport.iss";
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

    CheckListBox.BorderStyle := bsNone; 

    // AddCheckBox(ACaption, ASubItem, ALevel, AChecked, AEnabled, AHasInternalChildren, ACheckWhenParentChecked, AObject)
     CheckListBox.AddCheckBox('Microsoft .NET Framework 4 Full', '', 0, not IsDotNetInstalled(), not IsDotNetInstalled, False, False, nil); // unchecked
     CheckListBox.AddCheckBox('Crystal Report Runtime', '', 0, not IsCrystalReportInstalled(), not IsCrystalReportInstalled(), False, False, nil); // checked
     CheckListBox.AddCheckBox('requirement 3', '', 0, False, False, False, False, nil); // disabled

end;
