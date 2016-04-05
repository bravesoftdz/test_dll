object DataModule2: TDataModule2
  OldCreateOrder = False
  Left = 192
  Top = 106
  Height = 150
  Width = 215
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDAORA.1;Password=test;User ID=test;Data Source=level3' +
      ';Persist Security Info=True'
    LoginPrompt = False
    Provider = 'MSDAORA.1'
    Left = 24
    Top = 4
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\'#1056#1091#1089'\tray\data\Di' +
      'na960.mdb;Persist Security Info=False'
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM dati960 WHERE movetoremotedb = false;')
    Left = 68
    Top = 16
  end
end
