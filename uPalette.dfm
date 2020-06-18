object fmPalette: TfmPalette
  Left = 340
  Top = 124
  Width = 276
  Height = 336
  Caption = 'fmPalette'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label45: TLabel
    Left = 152
    Top = 104
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
  object Label44: TLabel
    Left = 16
    Top = 104
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label42: TLabel
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
  object Label34: TLabel
    Left = 16
    Top = 80
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Color Count:'
  end
  object Label33: TLabel
    Left = 16
    Top = 48
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label32: TLabel
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
  object seCount3: TSpinEdit
    Tag = 3
    Left = 88
    Top = 77
    Width = 57
    Height = 22
    MaxValue = 256
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = ControlChange
  end
  object eVidAddr3: TEdit
    Tag = 4
    Left = 88
    Top = 101
    Width = 57
    Height = 21
    TabOrder = 1
    OnChange = ControlChange
  end
  object eName3: TEdit
    Tag = 1
    Left = 88
    Top = 21
    Width = 145
    Height = 21
    TabOrder = 2
    OnChange = ControlChange
  end
  object eAddress3: TEdit
    Tag = 2
    Left = 88
    Top = 45
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 3
    OnChange = ControlChange
  end
end
