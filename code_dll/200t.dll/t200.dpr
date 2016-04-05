library t200;

//uses
//  windows;

{$R bmp.RES}
{$E plu} //задаем расширение файла не DLL

function PlInfo : Pchar;
begin
  PlInfo := 'тест на давление';
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
  PlName := '200 тонн';
end;

function PlExec():Boolean;
begin
  //MessageBox(0,'Запущен тест на давление!!!','Сообщение плагина',MB_OK);
  PlExec:=True;
end;

exports
  PlInfo, PlType, PlTime, PlName, PlExec;

end.


