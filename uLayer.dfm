object fmLayer: TfmLayer
  Left = 432
  Top = 117
  Width = 634
  Height = 681
  Caption = 'fmLayer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label61: TLabel
    Left = 152
    Top = 272
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
  object Label60: TLabel
    Left = 152
    Top = 248
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
  object Label59: TLabel
    Left = 16
    Top = 272
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H. Scroll:'
  end
  object Label58: TLabel
    Left = 16
    Top = 248
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'H. Scroll:'
  end
  object Label57: TLabel
    Left = 152
    Top = 176
    Width = 18
    Height = 13
    Caption = 'tiles'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label56: TLabel
    Left = 152
    Top = 224
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
  object Label55: TLabel
    Left = 16
    Top = 224
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Map Base:'
  end
  object Label54: TLabel
    Left = 152
    Top = 200
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
  object Label53: TLabel
    Left = 16
    Top = 200
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Tile Base:'
  end
  object Label52: TLabel
    Left = 152
    Top = 304
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
  object Label51: TLabel
    Left = 16
    Top = 304
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Video Address:'
  end
  object Label50: TLabel
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
  object Label49: TLabel
    Left = 16
    Top = 176
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Map Width:'
  end
  object Label48: TLabel
    Left = 152
    Top = 152
    Width = 18
    Height = 13
    Caption = 'tiles'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label47: TLabel
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
  object Label46: TLabel
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
  object Label43: TLabel
    Left = 16
    Top = 152
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Map Height:'
  end
  object Label41: TLabel
    Left = 16
    Top = 128
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Tile Width:'
  end
  object Label40: TLabel
    Left = 16
    Top = 104
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Tile Height:'
  end
  object Label39: TLabel
    Left = 16
    Top = 80
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Video Mode:'
  end
  object Label38: TLabel
    Left = 16
    Top = 48
    Width = 57
    Height = 13
    AutoSize = False
    Caption = 'Address:'
  end
  object Label37: TLabel
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
  object seVScroll4: TSpinEdit
    Tag = 11
    Left = 88
    Top = 269
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = ControlChange
  end
  object seHScroll4: TSpinEdit
    Tag = 10
    Left = 88
    Top = 245
    Width = 57
    Height = 22
    MaxValue = 1023
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = ControlChange
  end
  object eVidAddr4: TEdit
    Tag = 12
    Left = 88
    Top = 301
    Width = 57
    Height = 21
    TabOrder = 2
    OnChange = ControlChange
  end
  object eTileBase4: TEdit
    Tag = 8
    Left = 88
    Top = 197
    Width = 57
    Height = 21
    TabOrder = 3
    OnChange = ControlChange
  end
  object eName4: TEdit
    Tag = 1
    Left = 88
    Top = 21
    Width = 145
    Height = 21
    TabOrder = 4
    OnChange = ControlChange
  end
  object eMapBase4: TEdit
    Tag = 9
    Left = 88
    Top = 221
    Width = 57
    Height = 21
    TabOrder = 5
    OnChange = ControlChange
  end
  object eAddress4: TEdit
    Tag = 2
    Left = 88
    Top = 45
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 6
    OnChange = ControlChange
  end
  object cbVidMode4: TComboBox
    Tag = 3
    Left = 88
    Top = 77
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 7
    Text = '1 Text (256c Fg, 1c Bg)'
    OnChange = ControlChange
    Items.Strings = (
      '0 Text (16c Fg/Bg)'
      '1 Text (256c Fg, 1c Bg)'
      '2 Tile 2bpp'
      '3 Tile 4bpp'
      '4 Tile 8bpp'
      '5 Bitmap 2bpp'
      '6 Bitmap 4bpp'
      '7 Bitmap 8bpp')
  end
  object cbTileW4: TComboBox
    Tag = 5
    Left = 88
    Top = 125
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
    Text = '8'
    OnChange = ControlChange
    Items.Strings = (
      '8'
      '16')
  end
  object cbTileH4: TComboBox
    Tag = 4
    Left = 88
    Top = 101
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 9
    Text = '8'
    OnChange = ControlChange
    Items.Strings = (
      '8'
      '16')
  end
  object cbMapW4: TComboBox
    Tag = 7
    Left = 88
    Top = 173
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 10
    Text = '32'
    OnChange = ControlChange
    Items.Strings = (
      '32'
      '64'
      '128'
      '256')
  end
  object cbMapH4: TComboBox
    Tag = 6
    Left = 88
    Top = 149
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 11
    Text = '32'
    OnChange = ControlChange
    Items.Strings = (
      '32'
      '64'
      '128'
      '256')
  end
  object cbEnabled4: TCheckBox
    Tag = 13
    Left = 88
    Top = 336
    Width = 85
    Height = 17
    Caption = 'Enabled'
    TabOrder = 12
  end
end
