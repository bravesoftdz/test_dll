unit UnClose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, CoolTrayIcon, Menus, ImgList, ShellAPI, AppEvnts, ComCtrls,
  Registry, ExtCtrls, StrUtils, StdCtrls{, WinSvc};

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    TrayIcon1: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    ShowWindow1: TMenuItem;
    HideWindow1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    MM: TMainMenu;
    sjkdsjkdf1: TMenuItem;
    Im_Text: TImage;
    Timer1: TTimer;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ShowWindow1Click(Sender: TObject);
    procedure TrayIcon1MouseExit(Sender: TObject);
    procedure TrayIcon1MouseEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Loaded; override;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LogException (Sender: TObject; E: Exception);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PlugClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    HTooltip: HWND;
    CustomFont: TFont;
    BackColor, TextColor: COLORREF;
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
  public
    { Public declarations }
    procedure SavesLog(Str:String);
    procedure AddItemToLV(var LV:TListView; Cap:String;
        SubCap:array of String; Im:Integer; ItemData:Pointer);
    procedure SearchDLL(one:boolean);
    procedure LoadPlug(fileName: string; find:boolean);
    procedure _ShowText(Str:String);
  end;

var
  Form1: TForm1;
  bm : TBitMap;
  min:integer;
  
implementation

uses UnModul;

{$R *.dfm}

const
 TTM_SETMAXTIPWIDTH = (WM_USER + 24);
 TTM_SETTIPBKCOLOR = (WM_USER + 19);
 TTM_SETTIPTEXTCOLOR = (WM_USER + 20);
 TTM_SETTITLEA = (WM_USER + 32);

{function CreateNTService(ExecutablePath, ServiceName: string): boolean;
var
  hNewService, hSCMgr: SC_HANDLE;
  FuncRetVal: Boolean;
begin
  FuncRetVal := False;
  hSCMgr := OpenSCManager(nil, nil, SC_MANAGER_CREATE_SERVICE);
  if (hSCMgr <> 0) then begin
    hNewService := CreateService(hSCMgr, PChar(ServiceName), PChar(ServiceName),
      STANDARD_RIGHTS_REQUIRED, SERVICE_WIN32_OWN_PROCESS,
      SERVICE_AUTO_START, SERVICE_ERROR_NORMAL,
      PChar(ExecutablePath), nil, nil, nil, nil, nil);
    CloseServiceHandle(hSCMgr);
    if (hNewService <> 0) then  FuncRetVal := true
     else FuncRetVal := false;
  end;
  CreateNTService := FuncRetVal;
end;

function DeleteNTService(ServiceName: string): boolean;
var
  hServiceToDelete, hSCMgr: SC_HANDLE;
  RetVal: LongBool;
  FunctRetVal: Boolean;
begin
  FunctRetVal := false;
  hSCMgr := OpenSCManager(nil, nil, SC_MANAGER_CREATE_SERVICE);
  if (hSCMgr <> 0) then
  begin
    hServiceToDelete := OpenService(hSCMgr, PChar(ServiceName), SERVICE_ALL_ACCESS);
    RetVal := DeleteService(hServiceToDelete);
    CloseServiceHandle(hSCMgr);
    FunctRetVal := RetVal;
  end;
  DeleteNTService := FunctRetVal;
end;}

procedure TForm1.LogException(Sender: TObject; E: Exception);
var
 LogFile: textfile;
begin
 AssignFile(LogFile,'error_log.log');
 if FileExists('error_log.log') then Append(LogFile) else Rewrite(LogFile);
 Writeln(LogFile,'['+DateTimeToStr(Now)+']: '+E.Message);
 CloseFile(LogFile);
end;

procedure TForm1.SavesLog(Str:String);
var
  myFile : TextFile;
  PT : String;
begin
 try
  try
   PT := ExtractFilePath(ParamStr(0))+'1.txt';
   AssignFile(myFile, PT);
   if FileExists(PT) then Append(myFile) else ReWrite(myFile);
   WriteLn(myFile, '['+DateTimeToStr(Now)+']: '+Str);
  except end; //try
 finally
  CloseFile(myFile);
 end; //try
end;

procedure TForm1.WMHotkey( var msg: TWMHotkey );
begin
 if msg.hotkey = 1 then
  ShellExecute(Application.Handle, 'Open', '', nil, PChar(ExtractFilePath(ParamStr(0))), SW_SHOWNA);
end;

procedure TForm1.FormCreate(Sender: TObject);
 procedure DoAppToRun(RunName, AppName: string);
 var
  Reg: TRegistry;
 begin
  try
   Reg := TRegistry.Create;
   with Reg do begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
    WriteString(RunName, AppName);
    CloseKey;
    Free;
   end;
  except end; //try
 end; //procedure
begin
 try
  RegisterHotkey(Handle, 1, MOD_ALT or MOD_SHIFT or MOD_CONTROL, VK_F9);
  DoAppToRun('TestsService',ParamStr(0));
 except end; //try
 min:=0;
 Left := (Screen.Width-Width)-10;
 Top := (Screen.Height-Height)-60;
 CustomFont := TFont.Create;
 CustomFont.Size := 14;
 CustomFont.Name := 'Verdana';
 BackColor := RGB(0, 0, 255);
 TextColor := RGB(255, 255, 0);
 Application.ProcessMessages;
 bm := TBitMap.Create;
 bm.Width := Im_Text.ClientWidth;
 bm.Height := Im_Text.ClientHeight;
 with bm.Canvas do begin
  Font.name := 'Arial';
  Font.Size := 18;
  Font.Color := clBlue;
 end; //with
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Application.Minimize;
 TrayIcon1.HideMainForm;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.ShowWindow1Click(Sender: TObject);
begin
 TrayIcon1.ShowMainForm;
 SetWindowPos(Application.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TForm1.TrayIcon1MouseExit(Sender: TObject);
begin
 if HTooltip = 0 then Exit;
 SetWindowPos(HTooltip, 0, -500, -500, 0, 0, SWP_NOZORDER or SWP_NOACTIVATE or SWP_NOSIZE);
 SendMessage(HTooltip, TTM_SETMAXTIPWIDTH, 0, -1);
 SendMessage(HTooltip, WM_SETFONT, 0, 0);
 SendMessage(HTooltip, TTM_SETTIPBKCOLOR, GetSysColor(COLOR_INFOBK), 0);
 SendMessage(HTooltip, TTM_SETTIPTEXTCOLOR, GetSysColor(COLOR_INFOTEXT), 0);
end;

procedure TForm1.TrayIcon1MouseEnter(Sender: TObject);
begin
 if HTooltip = 0 then Exit;
 SendMessage(HTooltip, WM_SETFONT, CustomFont.Handle, 0);
 SendMessage(HTooltip, TTM_SETTIPBKCOLOR, BackColor, 0);
 SendMessage(HTooltip, TTM_SETTIPTEXTCOLOR, TextColor, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 CustomFont.Free;
end;

procedure TForm1.Loaded;
begin
 inherited;
 HTooltip := TrayIcon1.GetTooltipHandle;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
 ShowWindow1.Enabled := Not IsWindowVisible(Application.Handle);
 HideWindow1.Enabled := IsWindowVisible(Application.Handle);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
  UnRegisterHotkey( Handle, 1 );
 except end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 FmModul.Show;
end;

procedure TForm1.AddItemToLV(var LV:TListView; Cap:String;
  SubCap:array of String; Im:Integer; ItemData:Pointer);
var
 I:Integer;
begin
 Application.ProcessMessages;
 if Cap='' then Exit;
 try
  with LV.Items.Add do begin
   Caption:=Cap;
   for I:=Low(SubCap) to High(SubCap) do SubItems.Add(SubCap[I]);
   ImageIndex:=Im;
   if ItemData<>nil then Data:=ItemData;
  end; //with LV..
 except end; //try
end;

function ExecPlg(Path:String):boolean;
var
 i:integer;
 stat:boolean;
begin
 stat:=false;
 for i:=0 to FmModul.ListView1.Items.Count-1 do
  if FmModul.ListView1.Items[i].Caption = Path then begin
   stat:=true;
   break;
  end;
 Result:=stat;
end;

procedure TForm1.SearchDLL(one:boolean);
var
 SR:TSearchRec;
 FindResult:integer;
 dir:string;
begin
 dir:=ExtractFilePath(ParamStr(0))+'dll';
 FindResult:=FindFirst(dir+'\*.dll',faAnyFile,SR);
 if one then FmModul.ListView1.Clear;
 try
  while FindResult=0 do begin
   with SR do begin
    if (Name<>'.') and (Name<>'..') and (not ExecPlg(dir+'\'+Name)) then LoadPlug(dir+'\'+Name,true);
   end; //with
   FindResult:=FindNext(SR);
  end; //while
 finally
  FindClose(SR);
 end; //try
end;

procedure TForm1.LoadPlug(fileName: string; find:boolean);
var
 PlugName : function : PChar;
 PlugInfo : function : PChar;
 PlugTime : function : PChar;
 item : TMenuItem;
 handle : THandle;
 res :TResourceStream;
begin
 try
  handle := LoadLibrary(Pchar(FileName));
 except
  exit;
 end;
 if handle <> 0 then begin
  @PlugName := GetProcAddress(handle,'PlName');
  @PlugInfo := GetProcAddress(handle,'PlInfo');
  @PlugTime := GetProcAddress(handle,'PlTime');
  if @PlugName = nil then Exit;
  if find then begin
   res:= TResourceStream.Create(handle,'bitmap',rt_rcdata);
   res.Position:=0;
   item := TMenuItem.create(MM);
   item.Bitmap.LoadFromStream(res);
   item.caption := PlugName;
   item.Enabled:=false;
   item.Tag:=FmModul.ListView1.Items.Count-1;
   item.onClick:=PlugClick;
   MM.items[0].add(item);
  end; //if find
  AddItemToLV(FmModul.ListView1,FileName,[PlugName,PlugInfo,PlugTime],-1,nil);
  FreeLibrary(handle);
 end;
end;

procedure TForm1.PlugClick(Sender: TObject);
var
 PlugExec : function(AObject : TObject): boolean;
 PlugType : function: PChar;
 FileName : string;
 handle : Thandle;
begin
 with (Sender as TMenuItem) do filename:= FmModul.ListView1.Items[Tag].Caption;
 handle := LoadLibrary(Pchar(FileName));
 if handle <> 0 then  begin
  @plugExec := GetProcAddress(handle,'PlExec');
  @plugType := GetProcAddress(handle,'PlType');
  if PlugType = 'TEST' then PlugExec(nil)
   else if PlugType = 'NIL' then PlugExec(nil);
 end;
 FreeLibrary(handle);
end;

procedure TForm1._ShowText(Str:String);
begin
 with bm.Canvas do begin
  Brush.Style := bsSolid;
  Brush.Color := clWhite;
  FillRect(ClipRect);
  TextOut((bm.Width-TextWidth(Str)) div 2, (bm.Height-TextHeight(Str)) div 2, Str);
  Im_Text.Canvas.Draw(0, 0, bm);
 end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
 procedure proc(f:string);
 var
  PlugExec : function(AObject : TObject): boolean;
  PlugType : function: PChar;
  handle : Thandle;
 begin
  handle := LoadLibrary(Pchar(f));
  if handle <> 0 then  begin
   @plugExec := GetProcAddress(handle,'PlExec');
   @plugType := GetProcAddress(handle,'PlType');
   if PlugType = 'TEST' then if not PlugExec(nil) then SavesLog('�����������: ������ ������� � �����!');
   // else if PlugType = 'NIL' then PlugExec(nil);
  end; //if
  FreeLibrary(handle);
 end; //procedure
 function summ(s:string):string;
 begin
  result := IntToStr(StrToInt(s)-1);
 end; //function
var
 i:integer;
 s:string;
begin
 inc(min);
 if min=20 then begin
  min:=0;
  FmModul.N3.Click;
 end;
 _ShowText(TimeToStr(Now));
 with FmModul.ListView1 do begin
  for i:=0 to Items.Count-1 do begin
   Items[i].SubItems[2] := summ(Items[i].SubItems[2]);
   if Items[i].SubItems[2] = '0' then begin
    s:=Items[i].Caption;
    Items[i].Delete;
    Label3.Caption:=TimeToStr(Now);
    proc(s); LoadPlug(s,false);
   end;//if
  end;
 end; //with
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
 //CreateNTService(Application.ExeName, 'TEST_SERVICE');
 //DeleteNTService('TEST_SERVICE');
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
 //if MessageBox(Handle,PChar('�� �������?'),PChar('���������'),MB_ICONWARNING+MB_YESNO)=ID_YES then ;
end;

end.
