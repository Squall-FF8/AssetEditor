object dlgImportOption: TdlgImportOption
  Left = 330
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Please, select options:'
  ClientHeight = 253
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    328
    253)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 43
    Width = 59
    Height = 13
    Caption = 'Start Index:'
  end
  object Label2: TLabel
    Left = 40
    Top = 67
    Width = 61
    Height = 13
    Caption = 'Color Count:'
  end
  object Label3: TLabel
    Left = 24
    Top = 24
    Width = 84
    Height = 13
    Caption = 'Image Palette:'
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
    Width = 102
    Height = 13
    Caption = 'Replacing Palette:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 40
    Top = 147
    Width = 78
    Height = 13
    Caption = 'Existing Palette:'
  end
  object Label6: TLabel
    Left = 40
    Top = 123
    Width = 59
    Height = 13
    Caption = 'Start Index:'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 216
    Width = 328
    Height = 37
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object bOK: TPNGButton
    Left = 56
    Top = 224
    Width = 81
    Height = 23
    ButtonLayout = pbsImageLeft
    Caption = 'OK'
    ButtonStyle = pbsFlat
    OnClick = bOKClick
  end
  object bCancel: TPNGButton
    Left = 168
    Top = 224
    Width = 81
    Height = 23
    ButtonLayout = pbsImageLeft
    Caption = 'Cancel'
    ButtonStyle = pbsFlat
    OnClick = bCancelClick
  end
  object seStartIndex: TSpinEdit
    Left = 136
    Top = 40
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxValue = 256
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 0
  end
  object seColorCount: TSpinEdit
    Left = 136
    Top = 64
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxValue = 256
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 16
  end
  object seInsertIndex: TSpinEdit
    Left = 136
    Top = 120
    Width = 57
    Height = 22
    Hint = 'This value has meaning only before loading data!'
    MaxValue = 256
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 0
  end
  object cbPal: TComboBox
    Tag = 10
    Left = 136
    Top = 144
    Width = 169
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
  object cbTransparency: TCheckBox
    Left = 48
    Top = 176
    Width = 257
    Height = 17
    Caption = 'Keep transparency? Color 0 will stay 0'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 4
  end
end
