library spectr;

uses
  Classes,
  System,
  windows,
  sysutils,
  StrUtils,
  Unit2 in 'Unit2.pas' {DataModule2: TDataModule};

{$R bmp.RES}

var
 M:TStringList;

function pole(i:integer;str:string):string;
 function data(coords:string):string;
 var
  p:integer;
  s1,s2:string;
 begin
  p:=pos(':',coords);
  s1:=copy(coords,1,p-1);
  s2:=copy(coords,p+1,length(coords)+p+1);
  result:=trim(copy(str,StrToInt(s1),StrToInt(s2)-StrToInt(s1)));
 end;
var
 s:string;
 p:integer;
begin
 result:='';
 with M do begin
  s:=trim(M[i]);
  p:= pos('-',s);
  if p>0 then s:=copy(s,p+1,length(s)-p+1);
  result := data(s);
 end;
end;

{function shapka(i:integer):string;
var
 p:integer;
 s:string;
begin
 with M do begin
  s:=trim(M[i]);
  p:= pos('-',s);
  if p>0 then s:=copy(s,1,p-1);
  result:=s
 end; //with
end;}

function nullsclear(cl,str:string):string;
var
 p,i,j:integer;
 s1,s2:string;
begin
 if AnsiIndexStr(cl,['C','Si','Mn','P','S','Cr','Ni','Mo','Al','Cu','Co',
 'Ti','Nb','V','W','Pb','B','Sn','Zn','As','Bi','Ca','Ce','Zr','La','Fe'])>-1 then begin
  p:=pos('.',str);
  s1:=copy(str,1,p-1);
  s2:=copy(str,p+1,length(str)-p+1);
  if s1[length(s1)]='0' then begin
   I := 0;
    while I <= Length(s1) do begin
     Inc(I);
     if (s1[I] = '0') then begin
      repeat
       J := I;
       Inc(j);
       if s1[j] = '0' then Delete(s1, j, 1);
      until s1[j] <> '0';
      I := J;
     end; //if s1[....
    end; //while
  end else begin
   I := 1;
   while I <= Length(s1) do if (s1[I] = '0') then Delete(s1, i, 1) else Inc(I);
  end; //if s1[......
  result:=s1+'.'+s2;
 end; //if AnsiInd.......
end;

function PlInfo : Pchar;
begin
  PlInfo := 'тест на химический состав';
end;

function PlType : Pchar;
begin
  PlType := 'TEST';
end;

function PlTime : Pchar;
begin
  PlTime := '600';
end;

function PlName:Pchar;
begin
  PlName := 'Спектрометр';
end;

function DaysTimes(str:string):String;
var
 ss:array[1..6] of integer;
 i,j,a1,a2:integer;
begin
 if trim(str)='' then begin
  Result:='0';
  Exit;
 end;
 i:=1; j:=1;
 while i<=Length(str) do begin
  ss[j]:=StrToInt(Copy(str,i,2));
  Inc(i,2);
  Inc(j);
 end;
 a1:=(((ss[3]*12)+ss[2])*30)+ss[1];
 a2:=(ss[4]*60*60)+(ss[5]*60)+ss[6];
 Result:=IntToStr(a1)+'.'+IntToStr(a2);
end;

function PlExec():Boolean;
 {type
  strt = ^matrix;
  matrix = packed record
   s:array[0..40] of string[50];
  end;}
var
 i: Integer;
 f: TextFile;
 t: string;
 st:array[0..49] of string[50];
 ddtt:Double;
 fd,fm:string;
begin
 //if trim(Edit3.Text)='' then Edit3.Text:='1';
 //if trim(Edit2.Text)='' then Edit2.Text:='25';
 //fd:=ExtractFilePath(ParamStr(0))+'data\ANALYSEN.DAT';
 fd:='\\pcspectrometer\host\ANALYSEN.DAT';
 fm:=ExtractFilePath(ParamStr(0))+'data\1.txt';
 if (not FileExists(fd)) or (not FileExists(fm)) then begin
  PlExec:=False;
  exit;
 end;
 DataModule2 := TDataModule2.Create(nil);
 //Form1.ADOConnection1.Open;
 M := TStringList.Create;

 AssignFile(f,fd);
 M.LoadFromFile(fm);
 M.Text:=trim(M.Text);
 //StringGrid1.ColCount:=Memo1.Lines.Count;
 //StringGrid1.RowCount:=2;
 //ListBox1.Items.Clear;
 //for i:=1 to StringGrid1.ColCount-1 do StringGrid1.Cells[i,0]:=shapka(i-1);
 Reset(f);
 //z := 0;
 try
  DataModule2.ADOConnection1.Open;

  DataModule2.ADOQuery1.Open;
  ddtt:=StrToFloat(DaysTimes(DataModule2.ADOQuery1.FieldByName('DATATIME').AsString));
  DataModule2.ADOQuery1.Close;
  //j:=270110101516;
  //SELECT * FROM (SELECT DATATIME FROM SPECTROMETR ORDER BY ID DESC) WHERE ROWNUM = 1
 repeat
  //Inc(z);
  readln(f, t);
   for i:=0 to M.Count-1 do begin
    //New(st);
    // st^.s[i] := Trim(pole(i,t));
    st[i] := Trim(pole(i,t));
   end; //for
    try
     if StrToFloat(DaysTimes(st[0]))>ddtt then
     DataModule2.ADOConnection1.Execute('INSERT INTO SPECTROMETR (DATATIME,MILLORDER,QUALITY,HEAT,LOT,SAMPLE,SPECIMEN,METHOD,C,SI,MN,P,S,CR,NI,MO,AL,CU,CO,TI,NB,V,W,PB,B,SN,ZN,AS_,BI,CA,CE,ZR,LA,FE) VALUES ('''
      +st[0]+''','''+st[1]+''','''
      +st[2]+''','''+st[3]+''','''+st[4]+''','''
      +st[5]+''','''+st[6]+''','''+st[8]+''','''
      +st[9]+''','''+st[10]+''','''+st[11]+''','''
      +st[12]+''','''+st[13]+''','''+st[14]+''','''
      +st[15]+''','''+st[16]+''','''+st[17]+''','''
      +st[18]+''','''+st[19]+''','''+st[20]+''','''
      +st[21]+''','''+st[22]+''','''+st[23]+''','''
      +st[24]+''','''+st[25]+''','''+st[26]+''','''
      +st[27]+''','''+st[28]+''','''+st[29]+''','''
      +st[30]+''','''+st[31]+''','''+st[32]+''','''
      +st[33]+''','''+st[34]+''')');
    except end;
  //if z>=StrToInt(Edit3.Text) then begin
   //StringGrid1.RowCount:=StringGrid1.RowCount+1;
   //StringGrid1.Cells[0,StringGrid1.RowCount-2]:=IntToStr(z);
   //for i:=1 to StringGrid1.ColCount-1 do StringGrid1.Cells[i,StringGrid1.RowCount-2]:=Trim(pole(i-1,t));
   //for i:=10 to 36 do StringGrid1.Cells[i,StringGrid1.RowCount-2]:=nullsclear(StringGrid1.Cells[i,0],StringGrid1.Cells[i,StringGrid1.RowCount-2]);
   //if StringGrid1.Cells[1,0] = 'DataTime' then
   // ListBox1.Items.Add(StringGrid1.Cells[1,StringGrid1.RowCount-2]);
   // StringGrid1.Cells[1,StringGrid1.RowCount-2]:=datas(StringGrid1.Cells[1,StringGrid1.RowCount-2]);
  //end; //if z>=......
 until EOF(f) {or (z>=(StrToInt(Edit3.Text)+StrToInt(Edit2.Text))-1)};
 finally
  DataModule2.ADOConnection1.Close;
 end; //try

 //MessageBox(0,PChar('Прочитано '+IntToStr(z)+' строк.'),'Сообщение плагина',MB_OK);
 //Label5.Caption:=IntToStr(z);
 //StringGrid1.RowCount:=StringGrid1.RowCount-1;
 CloseFile(f);
 //resizesg;
 M.Free;
 //Form1.ADOConnection1.Close;
 DataModule2.Free;
 PlExec:=True;
end;

exports
  PlInfo, PlType, PlTime, PlName, PlExec;

{initialization
 CoInitialize;}

end.


