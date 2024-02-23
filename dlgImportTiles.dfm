object dlgImportTile: TdlgImportTile
  Left = 644
  Top = 124
  Width = 359
  Height = 507
  BorderStyle = bsSizeToolWin
  Caption = 'Please select:'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 425
    Width = 343
    Height = 2
    Align = alBottom
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 24
    Top = 211
    Width = 51
    Height = 13
    Caption = 'Tile Width:'
  end
  object Label7: TLabel
    Left = 184
    Top = 211
    Width = 38
    Height = 13
    Caption = 'in pixels'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 243
    Width = 54
    Height = 13
    Caption = 'Tile Height:'
  end
  object Label3: TLabel
    Left = 184
    Top = 243
    Width = 38
    Height = 13
    Caption = 'in pixels'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 307
    Width = 73
    Height = 13
    Caption = 'Tiles to Import:'
  end
  object lNum: TLabel
    Left = 184
    Top = 307
    Width = 36
    Height = 13
    Caption = 'number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Image: TImage
    Left = 0
    Top = 0
    Width = 343
    Height = 201
    Align = alTop
    Center = True
    Proportional = True
    Stretch = True
  end
  object Label6: TLabel
    Left = 24
    Top = 275
    Width = 41
    Height = 13
    Caption = 'Tile BPP:'
  end
  object Label5: TLabel
    Left = 24
    Top = 379
    Width = 70
    Height = 13
    Caption = 'Bytes per tile: '
  end
  object lBytesPerTile: TLabel
    Left = 112
    Top = 379
    Width = 12
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 24
    Top = 395
    Width = 64
    Height = 13
    Caption = 'Total bytes : '
  end
  object lTotalBytes: TLabel
    Left = 112
    Top = 395
    Width = 12
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 427
    Width = 343
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 0
    object bOK: TPNGButton
      Left = 80
      Top = 10
      Width = 81
      Height = 23
      ButtonLayout = pbsImageLeft
      Caption = 'OK'
      ButtonStyle = pbsFlat
      OnClick = bOKClick
    end
    object bCancel: TPNGButton
      Left = 192
      Top = 10
      Width = 81
      Height = 23
      ButtonLayout = pbsImageLeft
      Caption = 'Cancel'
      ButtonStyle = pbsFlat
      OnClick = bCancelClick
    end
  end
  object seTileW: TSpinEdit
    Tag = 1
    Left = 112
    Top = 208
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxLength = 255
    MaxValue = 10000
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 16
    OnChange = ControlChange
  end
  object seTileH: TSpinEdit
    Tag = 2
    Left = 112
    Top = 240
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxLength = 255
    MaxValue = 10000
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 16
    OnChange = ControlChange
  end
  object seTileNum: TSpinEdit
    Tag = 4
    Left = 112
    Top = 304
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxLength = 255
    MaxValue = 10000
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Value = 1
    OnChange = ControlChange
  end
  object cbImpPal: TCheckBox
    Tag = 5
    Left = 24
    Top = 344
    Width = 201
    Height = 17
    Caption = 'Import the palette?'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object cbTileBPP: TComboBox
    Tag = 3
    Left = 112
    Top = 272
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnChange = ControlChange
    Items.Strings = (
      '2 BPP'
      '4 BPP'
      '8 BPP')
  end
end
