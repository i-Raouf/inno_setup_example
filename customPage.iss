#include "checkDotNet.iss";
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
     CheckListBox.AddCheckBox('Microsoft .NET Framework 4 Full', '', 0, IsDotNetInstalled(), not IsDotNetInstalled, False, False, nil); // unchecked
     CheckListBox.AddCheckBox('requirement 2', '', 0, True, True, False, False, nil); // checked
     CheckListBox.AddCheckBox('requirement 3', '', 0, False, False, False, False, nil); // disabled

end;
