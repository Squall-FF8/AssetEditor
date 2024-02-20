object dlgRefactorOptions: TdlgRefactorOptions
  Left = 330
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Please, select options:'
  ClientHeight = 213
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    328
    213)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 43
    Width = 27
    Height = 13
    Caption = 'Bank:'
  end
  object Label2: TLabel
    Left = 40
    Top = 67
    Width = 43
    Height = 13
    Caption = 'Address:'
  end
  object Label3: TLabel
    Left = 24
    Top = 24
    Width = 139
    Height = 13
    Caption = 'Starting address in RAM:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 104
    Width = 143
    Height = 13
    Caption = 'Starting address in VRAM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 0
    Top = 176
    Width = 328
    Height = 37
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object bOK: TPNGButton
    Left = 56
    Top = 184
    Width = 81
    Height = 23
    ButtonLayout = pbsImageLeft
    Caption = 'OK'
    ButtonStyle = pbsFlat
    OnClick = bOKClick
  end
  object bCancel: TPNGButton
    Left = 168
    Top = 184
    Width = 81
    Height = 23
    ButtonLayout = pbsImageLeft
    Caption = 'Cancel'
    ButtonStyle = pbsFlat
    OnClick = bCancelClick
  end
  object Label7: TLabel
    Left = 192
    Top = 43
    Width = 73
    Height = 13
    Caption = '-1 for no banks'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 192
    Top = 67
    Width = 29
    Height = 13
    Caption = 'in hex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 40
    Top = 123
    Width = 43
    Height = 13
    Caption = 'Address:'
  end
  object Label6: TLabel
    Left = 192
    Top = 123
    Width = 29
    Height = 13
    Caption = 'in hex'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object seRAM_Bank: TSpinEdit
    Left = 120
    Top = 40
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxLength = 255
    MaxValue = 256
    MinValue = -1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 0
  end
  object eRAM_Addr: TEdit
    Left = 120
    Top = 64
    Width = 57
    Height = 21
    MaxLength = 4
    TabOrder = 1
  end
  object eVRAM: TEdit
    Left = 120
    Top = 120
    Width = 57
    Height = 21
    MaxLength = 5
    TabOrder = 2
  end
end
