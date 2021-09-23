object fmPicture: TfmPicture
  Left = 340
  Top = 124
  Width = 311
  Height = 465
  Caption = 'fmPicture'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label31: TLabel
    Left = 16
    Top = 200
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pixel Format:'
  end
  object Label30: TLabel
    Left = 152
    Top = 256
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
  object Label29: TLabel
    Left = 16
    Top = 256
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label28: TLabel
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
  object Label27: TLabel
    Left = 152
    Top = 168
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
    Top = 168
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H:'
  end
  object Label25: TLabel
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
  object Label24: TLabel
    Left = 16
    Top = 144
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'W:'
  end
  object Label23: TLabel
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
  object Label22: TLabel
    Left = 152
    Top = 96
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
  object Label21: TLabel
    Left = 16
    Top = 120
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Y:'
  end
  object Label20: TLabel
    Left = 16
    Top = 96
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'X:'
  end
  object Label19: TLabel
    Left = 16
    Top = 64
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label18: TLabel
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
  object Label1: TLabel
    Left = 16
    Top = 299
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Link:'
  end
  object Label2: TLabel
    Left = 16
    Top = 328
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pal Number:'
  end
  object seY2: TSpinEdit
    Tag = 4
    Left = 88
    Top = 117
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = ControlChange
  end
  object seX2: TSpinEdit
    Tag = 3
    Left = 88
    Top = 93
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = ControlChange
  end
  object seW2: TSpinEdit
    Tag = 5
    Left = 88
    Top = 141
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = ControlChange
  end
  object seH2: TSpinEdit
    Tag = 6
    Left = 88
    Top = 165
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = ControlChange
  end
  object eVidAddr2: TEdit
    Tag = 9
    Left = 88
    Top = 253
    Width = 57
    Height = 21
    TabOrder = 4
    OnChange = ControlChange
  end
  object eName2: TEdit
    Tag = 1
    Left = 88
    Top = 37
    Width = 145
    Height = 21
    TabOrder = 5
    OnChange = ControlChange
  end
  object eAddress2: TEdit
    Tag = 2
    Left = 88
    Top = 61
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 6
    OnChange = ControlChange
  end
  object cbPixFmt: TComboBox
    Tag = 8
    Left = 88
    Top = 197
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
    OnChange = ControlChange
  end
  object cbPal: TComboBox
    Tag = 10
    Left = 88
    Top = 296
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 8
    OnChange = ControlChange
    OnDropDown = cbPalDropDown
  end
  object sePal: TSpinEdit
    Tag = 11
    Left = 88
    Top = 325
    Width = 57
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 9
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
    TabOrder = 10
    OnClick = ControlChange
  end
end
