library t60;

uses
  windows,
  Unit2 in 'Unit2.pas' {DataModule2: TDataModule};

{$R bmp.RES}

function PlInfo : Pchar;
begin
  PlInfo := '���� �� ������';
end;

function PlType : Pchar;
begin
  PlType := 'TEST';
end;

function PlTime : Pchar;
begin
  PlTime := '30';
end;

function PlName:Pchar;
begin
  PlName := '60 ����';
end;

function PlExec():Boolean;
var
 stat:boolean;
 i:integer;
begin
 stat := false;
 with DataModule2 do begin
  try
   ADOConnection1.Open;
   ADOQuery1.SQL.Text:='SELECT * FROM dati960 WHERE movetoremotedb = false;';
   ADOQuery1.Open;
   for i:=0 to ADOQuery1.RecordCount-1 do
    ADOConnection1.Execute('INSERT INTO DINA_960 (IDPROVA,TIPOPROVA,RM,A,REL) VALUES ();');
   ADOQuery1.Close;
   ADOConnection1.Close;
  except end;
 end; //with
 PlExec:=stat;
end;

exports
  PlInfo, PlType, PlTime, PlName, PlExec;

end.


