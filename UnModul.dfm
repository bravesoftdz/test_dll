object FmModul: TFmModul
  Left = 525
  Top = 283
  BorderStyle = bsToolWindow
  Caption = #1052#1086#1076#1091#1083#1080
  ClientHeight = 156
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 4
    Top = 4
    Width = 613
    Height = 150
    Columns = <
      item
        Caption = #1060#1072#1081#1083
        Width = 200
      end
      item
        Caption = #1048#1084#1103' '#1084#1086#1076#1091#1083#1103
        Width = 120
      end
      item
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 150
      end
      item
        Caption = #1062#1080#1082#1083' '#1079#1072#1087#1091#1089#1082#1072' ('#1089#1077#1082')'
        Width = 120
      end>
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 532
    Top = 68
    object N1: TMenuItem
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      ShortCut = 46
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = N3Click
    end
  end
end
