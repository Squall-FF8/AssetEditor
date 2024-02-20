object fmMap: TfmMap
  Left = 340
  Top = 124
  Width = 353
  Height = 522
  Caption = 'fmMap'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label17: TLabel
    Left = 152
    Top = 200
    Width = 25
    Height = 13
    Caption = 'index'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 16
    Top = 200
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Palette:'
  end
  object Label13: TLabel
    Left = 152
    Top = 176
    Width = 28
    Height = 13
    Caption = 'in hex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 16
    Top = 176
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label11: TLabel
    Left = 152
    Top = 64
    Width = 28
    Height = 13
    Caption = 'in hex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label18: TLabel
    Left = 16
    Top = 379
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Link:'
  end
  object Label24: TLabel
    Left = 16
    Top = 120
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'W:'
  end
  object Label25: TLabel
    Left = 152
    Top = 120
    Width = 11
    Height = 13
    Caption = 'px'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label26: TLabel
    Left = 16
    Top = 144
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H:'
  end
  object Label27: TLabel
    Left = 152
    Top = 144
    Width = 11
    Height = 13
    Caption = 'px'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Fixed Len:'
  end
  object Label4: TLabel
    Left = 152
    Top = 88
    Width = 28
    Height = 13
    Caption = 'in hex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object sePal: TSpinEdit
    Tag = 10
    Left = 88
    Top = 197
    Width = 57
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = ControlChange
  end
  object eVidAddr: TEdit
    Tag = 8
    Left = 88
    Top = 173
    Width = 57
    Height = 21
    TabOrder = 1
    OnChange = ControlChange
  end
  object eName: TEdit
    Tag = 1
    Left = 88
    Top = 37
    Width = 145
    Height = 21
    TabOrder = 2
    OnChange = ControlChange
  end
  object eAddress: TEdit
    Tag = 2
    Left = 88
    Top = 61
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 3
    OnChange = ControlChange
  end
  object cbPic: TComboBox
    Tag = 13
    Left = 88
    Top = 376
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    OnChange = ControlChange
    OnDropDown = cbPicDropDown
  end
  object seW: TSpinEdit
    Tag = 5
    Left = 88
    Top = 117
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 5
    Value = 0
    OnChange = ControlChange
  end
  object seH: TSpinEdit
    Tag = 6
    Left = 88
    Top = 141
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 6
    Value = 0
    OnChange = ControlChange
  end
  object cbNoExport: TCheckBox
    Tag = 20
    Left = 88
    Top = 8
    Width = 85
    Height = 17
    Hint = 'Don'#39't add this Asset in Export'
    Caption = 'Don'#39't Export:'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = ControlChange
  end
  object eFixedLen: TEdit
    Tag = 21
    Left = 88
    Top = 85
    Width = 57
    Height = 21
    TabOrder = 8
    OnChange = ControlChange
  end
end
