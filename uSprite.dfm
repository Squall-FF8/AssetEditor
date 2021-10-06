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
    Top = 192
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H:'
  end
  object Label8: TLabel
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
  object Label7: TLabel
    Left = 16
    Top = 168
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'W:'
  end
  object Label6: TLabel
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
  object Label5: TLabel
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
  object Label4: TLabel
    Left = 16
    Top = 144
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Y:'
  end
  object Label3: TLabel
    Left = 16
    Top = 120
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'X:'
  end
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
    Top = 296
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
    Top = 296
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Palette:'
  end
  object Label15: TLabel
    Left = 16
    Top = 272
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Z-Depth:'
  end
  object Label14: TLabel
    Left = 16
    Top = 224
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Pixel Format:'
  end
  object Label13: TLabel
    Left = 152
    Top = 248
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
    Top = 248
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
  object Label10: TLabel
    Left = 152
    Top = 192
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
  object Label19: TLabel
    Left = 16
    Top = 88
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Fixed Len:'
  end
  object Label20: TLabel
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
  object seY: TSpinEdit
    Tag = 4
    Left = 88
    Top = 141
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
    Top = 117
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
    Top = 293
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
    Top = 245
    Width = 57
    Height = 21
    TabOrder = 3
    OnChange = ControlChange
  end
  object eName: TEdit
    Tag = 1
    Left = 88
    Top = 37
    Width = 145
    Height = 21
    TabOrder = 4
    OnChange = ControlChange
  end
  object eAddress: TEdit
    Tag = 2
    Left = 88
    Top = 61
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 5
    OnChange = ControlChange
  end
  object cbZ: TComboBox
    Tag = 9
    Left = 88
    Top = 269
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
    Top = 165
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
    Top = 344
    Width = 85
    Height = 17
    Caption = 'Vertical Flip:'
    TabOrder = 8
  end
  object cbMode: TComboBox
    Tag = 7
    Left = 88
    Top = 221
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
    Top = 328
    Width = 85
    Height = 17
    Caption = 'Horizontal Flip:'
    TabOrder = 10
  end
  object cbH: TComboBox
    Tag = 6
    Left = 88
    Top = 189
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
    Top = 376
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 12
    OnChange = ControlChange
    OnDropDown = cbPicDropDown
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
    TabOrder = 13
    OnClick = ControlChange
  end
  object eFixedLen: TEdit
    Tag = 21
    Left = 88
    Top = 85
    Width = 57
    Height = 21
    TabOrder = 14
    OnChange = ControlChange
  end
end
