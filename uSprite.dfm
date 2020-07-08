object fmSprite: TfmSprite
  Left = 340
  Top = 124
  Width = 353
  Height = 522
  Caption = 'fmSprite'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 16
    Top = 152
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H:'
  end
  object Label8: TLabel
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
  object Label7: TLabel
    Left = 16
    Top = 128
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'W:'
  end
  object Label6: TLabel
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
  object Label5: TLabel
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
  object Label4: TLabel
    Left = 16
    Top = 104
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Y:'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'X:'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label17: TLabel
    Left = 152
    Top = 256
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
    Top = 256
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Palette:'
  end
  object Label15: TLabel
    Left = 16
    Top = 232
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Z-Depth:'
  end
  object Label14: TLabel
    Left = 16
    Top = 184
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pixel Format:'
  end
  object Label13: TLabel
    Left = 152
    Top = 208
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
    Top = 208
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label11: TLabel
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
  object Label10: TLabel
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
  object Label1: TLabel
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
  object Label18: TLabel
    Left = 16
    Top = 339
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Link:'
  end
  object seY: TSpinEdit
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
  object seX: TSpinEdit
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
  object sePal: TSpinEdit
    Tag = 10
    Left = 88
    Top = 253
    Width = 57
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = ControlChange
  end
  object eVidAddr: TEdit
    Tag = 8
    Left = 88
    Top = 205
    Width = 57
    Height = 21
    TabOrder = 3
    OnChange = ControlChange
  end
  object eName: TEdit
    Tag = 1
    Left = 88
    Top = 21
    Width = 145
    Height = 21
    TabOrder = 4
    OnChange = ControlChange
  end
  object eAddress: TEdit
    Tag = 2
    Left = 88
    Top = 45
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 5
    OnChange = ControlChange
  end
  object cbZ: TComboBox
    Tag = 9
    Left = 88
    Top = 229
    Width = 105
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Disabled'
    OnChange = ControlChange
    Items.Strings = (
      'Disabled'
      'Back'
      'Between Layers'
      'Front')
  end
  object cbW: TComboBox
    Tag = 5
    Left = 88
    Top = 125
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = '8'
    OnChange = ControlChange
    Items.Strings = (
      '8'
      '16'
      '32'
      '64')
  end
  object cbVFlip: TCheckBox
    Tag = 12
    Left = 88
    Top = 304
    Width = 85
    Height = 17
    Caption = 'Vertical Flip:'
    TabOrder = 8
  end
  object cbMode: TComboBox
    Tag = 7
    Left = 88
    Top = 181
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 9
    Text = '4 bpp'
    OnChange = ControlChange
    Items.Strings = (
      '4 bpp'
      '8 bpp')
  end
  object cbHFlip: TCheckBox
    Tag = 11
    Left = 88
    Top = 288
    Width = 85
    Height = 17
    Caption = 'Horizontal Flip:'
    TabOrder = 10
  end
  object cbH: TComboBox
    Tag = 6
    Left = 88
    Top = 149
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 11
    Text = '8'
    OnChange = ControlChange
    Items.Strings = (
      '8'
      '16'
      '32'
      '64')
  end
  object cbPic: TComboBox
    Tag = 13
    Left = 88
    Top = 336
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 12
    OnChange = ControlChange
    OnDropDown = cbPicDropDown
  end
end
