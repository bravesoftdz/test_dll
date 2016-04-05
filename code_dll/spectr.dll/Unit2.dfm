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
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM (SELECT DATATIME FROM SPECTROMETR ORDER BY ID DESC' +
        ') WHERE ROWNUM = 1')
    Left = 64
    Top = 16
  end
end
