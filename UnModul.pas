unit UnModul;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, Menus;

type
  TFmModul = class(TForm)
    ListView1: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmModul: TFmModul;

implementation

uses UnClose;

{$R *.dfm}

procedure TFmModul.FormCreate(Sender: TObject);
begin
 Form1.SearchDLL(true);
end;

procedure TFmModul.PopupMenu1Popup(Sender: TObject);
begin
 N1.Enabled:=ListView1.Selected<>nil;
end;

procedure TFmModul.N1Click(Sender: TObject);
begin
 if ListView1.Selected<>nil then ListView1.Items.Delete(ListView1.Selected.Index);
end;

procedure TFmModul.N3Click(Sender: TObject);
var
 i:integer;
begin
 Form1.SearchDLL(false);
 i:=0;
 while i<=ListView1.Items.Count-1 do begin
  if not FileExists(ListView1.Items[i].Caption) then ListView1.Items.Delete(i) else inc(i);
 end; //while
end;

end.
