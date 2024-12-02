program UIDSupportConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Base36 in 'Source\Base36.pas',
  UIDInterface in 'Source\UIDInterface.pas';

begin
  try
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
