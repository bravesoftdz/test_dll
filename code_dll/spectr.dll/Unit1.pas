unit Unit1;

interface

uses
  Forms, Classes, activex, DB, ADODB;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

initialization
 oleinitialize(nil);

end.
