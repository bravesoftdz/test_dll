program TestServis;

uses
  Forms,
  PrevInst,
  UnClose in 'UnClose.pas' {Form1},
  UnModul in 'UnModul.pas' {FmModul};

{$R *.res}

begin
  if mt('TestServis') then halt;

  Application.Initialize;
  Application.Title := 'Test Service';
  Application.HelpFile := 'help.chm';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFmModul, FmModul);
  Application.ShowMainForm:=false;
  Application.Minimize;
  Application.Run;
end.
