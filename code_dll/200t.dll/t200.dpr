library t200;

//uses
//  windows;

{$R bmp.RES}
{$E plu} //������ ���������� ����� �� DLL

function PlInfo : Pchar;
begin
  PlInfo := '���� �� ��������';
end;

function PlType : Pchar;
begin
  PlType := 'TEST';
end;

function PlTime : Pchar;
begin
  PlTime := '43200';
end;

function PlName:Pchar;
begin
  PlName := '200 ����';
end;

function PlExec():Boolean;
begin
  //MessageBox(0,'������� ���� �� ��������!!!','��������� �������',MB_OK);
  PlExec:=True;
end;

exports
  PlInfo, PlType, PlTime, PlName, PlExec;

end.


