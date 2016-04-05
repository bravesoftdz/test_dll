unit Unit2;

interface

uses
  SysUtils, Classes, activex, DB, ADODB;

type
  TDataModule2 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.dfm}

initialization
 oleinitialize(nil);

end.
