[Code]
const
  adCmdText = $00000001;
  adExecuteNoRecords = $00000080;
procedure ConnectToSqlServer();
var
  ADOConnection: Variant;
  ADOCommand: Variant;
  SQLQuery: AnsiString;
begin
  try
    ADOConnection := CreateOleObject('ADODB.Connection');
    ADOConnection.ConnectionString := 
      'Provider=SQLOLEDB;' +               // provider
      'Data Source=.\sse2008r2;' +         // server name
      'Initial Catalog=master;' +          // default database
      'Integrated Security=SSPI;'
    ADOConnection.Open;
    try
      // create the ADO command object
      ADOCommand := CreateOleObject('ADODB.Command');
      // assign the currently opened connection to ADO command object
      ADOCommand.ActiveConnection := ADOConnection;
      SQLQuery := 
      ExpandConstant('IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = ''{#DBName}'') ') +
      'BEGIN ' +
      ExpandConstant('CREATE DATABASE {#DBName} ') +  
      ExpandConstant('  ON (FILENAME = ''{userdocs}\DataFiles\{#DBFileName}.mdf''), ') +   
      ExpandConstant('     (FILENAME = ''{userdocs}\DataFiles\{#DBFileName}_Log.ldf'') ') +   
      ' FOR ATTACH; ' +
      'END ';
      // assign text of a command to be issued against a provider
      ADOCommand.CommandText := SQLQuery;
      // this will execute the script; the adCmdText flag here means
      // you're going to execute the CommandText text command, while
      // the adExecuteNoRecords flag ensures no data row will be get
      // from a provider, what should improve performance
      ADOCommand.Execute(NULL, NULL, adCmdText or adExecuteNoRecords);
    finally
      ADOConnection.Close;
    end;
  except
    MsgBox(GetExceptionMessage, mbError, MB_OK);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    ConnectToSqlServer();
  end;
end;