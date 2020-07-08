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
    Top = 184
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pixel Format:'
  end
  object Label30: TLabel
    Left = 152
    Top = 240
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
    Top = 240
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label28: TLabel
    Left = 152
    Top = 48
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
    Top = 152
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
    Top = 152
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H:'
  end
  object Label25: TLabel
    Left = 152
    Top = 128
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
    Top = 128
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'W:'
  end
  object Label23: TLabel
    Left = 152
    Top = 104
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
    Top = 80
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
    Top = 104
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Y:'
  end
  object Label20: TLabel
    Left = 16
    Top = 80
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'X:'
  end
  object Label19: TLabel
    Left = 16
    Top = 48
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label18: TLabel
    Left = 16
    Top = 24
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
    Top = 283
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Link:'
  end
  object Label2: TLabel
    Left = 16
    Top = 312
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pal Number:'
  end
  object seY2: TSpinEdit
    Tag = 4
    Left = 88
    Top = 101
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
    Top = 77
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
    Top = 125
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
    Top = 149
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
    Top = 237
    Width = 57
    Height = 21
    TabOrder = 4
    OnChange = ControlChange
  end
  object eName2: TEdit
    Tag = 1
    Left = 88
    Top = 21
    Width = 145
    Height = 21
    TabOrder = 5
    OnChange = ControlChange
  end
  object eAddress2: TEdit
    Tag = 2
    Left = 88
    Top = 45
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 6
    OnChange = ControlChange
  end
  object cbPixFmt: TComboBox
    Tag = 8
    Left = 88
    Top = 181
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
    Top = 280
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
    Top = 309
    Width = 57
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 9
    Value = 0
    OnChange = ControlChange
  end
end
