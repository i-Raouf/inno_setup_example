[Code]
var
  Page: TWizardPage;

procedure InitializeWizard();
begin
  // create page after welcome page
  Page :=
    CreateCustomPage(wpWelcome, 'Software requirements', 'Checking requirements');

end;
