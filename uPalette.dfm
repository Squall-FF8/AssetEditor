object fmPalette: TfmPalette
  Left = 340
  Top = 124
  Width = 276
  Height = 513
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
  object bAppPal: TPNGButton
    Left = 8
    Top = 246
    Width = 27
    Height = 27
    Hint = 'Append from a Palette'
    ButtonLayout = pbsImageAbove
    ImageNormal.Data = {
      89504E470D0A1A0A0000000D49484452000000180000001808040000004A7EF5
      730000000467414D410000B18F0BFC610500000002624B47440000AA8D233200
      0000097048597300000EC400000EC401952B0E1B0000000774494D4507E30C1B
      122A051E4FB1AA000000E44944415478DA6364C0047A0C2D0C0E407A3F4335C3
      157449460CE5660CFB18B8A1ECAF408D67086938CD6082C43BC960815F8338C3
      0B34113186D7F8342832DCC31079804F0333C353A02D08F09C4186E11F7E3F64
      304C47E2A533CC22E4690686128646062E7018D532F4130E5610E063300787D0
      274C29EC1AF8199880E43F868FC46AB8C3A00C24EF32A88C6AA08E06158665C0
      38D0616007B27F02B3CF3F8628A076BC364C61C846E1E512721237C325062528
      FB11D0AECF84FDE0CCB01B2AEEC9B083384F2F6088079389C486123FC3556056
      D2667847AC06068660205E8B4D0200032A37194F2E64EE000000257445587464
      6174653A63726561746500323031392D31322D32375431383A34323A30352B30
      303A3030CD1CF6090000002574455874646174653A6D6F646966790032303139
      2D31322D32375431383A34323A30352B30303A3030BC414EB500000019744558
      74536F667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000
      000049454E44AE426082}
    ButtonStyle = pbsFlat
    ParentShowHint = False
    ShowHint = True
    OnClick = bAppPalClick
  end
  object bDeletePal: TPNGButton
    Left = 56
    Top = 246
    Width = 27
    Height = 27
    Hint = 'Delete Palette'
    ButtonLayout = pbsImageAbove
    ImageNormal.Data = {
      89504E470D0A1A0A0000000D49484452000000180000001808040000004A7EF5
      730000000467414D410000B18F0BFC610500000002624B47440000AA8D233200
      0000097048597300000EC400000EC401952B0E1B0000000774494D4507E30C1B
      12233B0EEC17480000015A4944415478DAA5D34D28445114C0F1FF205918CA82
      66256596D29495C56C2CD4289F356B1F6B13866462396C0CC6AC0D5B9141A494
      85642B65C7946CF4B2908F5948BE8E8CD773BCB916EEE2BE7BCFBDBF5BF7BE73
      3CFC6E8F94E74739BC7AD193FFCED268C75AECE83B0776F4943127B8A702737B
      A0F25FA097D23FC0332B4E00D5F655DD5A8E9B9F9786347D0690664083241103
      4832A4419C9801C499D4608269E96F59A7955A7664A58D2BF6E9A14AE2316634
      186451FA4DBA48302204D93E47940C9D328E90D2A09F25E93374CB5F8FE64182
      5136E488CFD5650DC2AC1A4098350D42EC1A40883D0D821C1A4090230D029C18
      4040B255013FE706E027AB818F6B03F06169E095042E0CBC927E0A14F122B36D
      3A9897BCA993C8250B0CB345BB545E096F1A7CD5F213C73449A99CC9BC813B79
      8866CA9CB5ED0416350552CF923BB8800BEA0B80ACBC920B88334EB1CBF657C9
      D4A9EFC90784387019CB20357D0000002574455874646174653A637265617465
      00323031392D31322D32375431383A33353A35392B30303A303089BB9CE30000
      002574455874646174653A6D6F6469667900323031392D31322D32375431383A
      33353A35392B30303A3030F8E6245F0000001974455874536F66747761726500
      7777772E696E6B73636170652E6F72679BEE3C1A0000000049454E44AE426082}
    ButtonStyle = pbsFlat
    ParentShowHint = False
    ShowHint = True
    OnClick = bDeletePalClick
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
  object pAddPal: TPanel
    Left = 8
    Top = 280
    Width = 233
    Height = 65
    BevelInner = bvSpace
    BevelOuter = bvLowered
    BorderWidth = 1
    TabOrder = 4
    Visible = False
    object lPal: TLabel
      Left = 16
      Top = 31
      Width = 73
      Height = 13
      AutoSize = False
      Caption = 'Palette:'
    end
    object bClose: TPNGButton
      Left = 214
      Top = 0
      Width = 16
      Height = 16
      Hint = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ButtonLayout = pbsImageAbove
      Caption = 'X'
      ButtonStyle = pbsNoFrame
      ParentShowHint = False
      ShowHint = True
      OnClick = bCloseClick
    end
    object cbPal: TComboBox
      Tag = 10
      Left = 80
      Top = 28
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnCloseUp = cbPalCloseUp
    end
  end
  object Panel1: TPanel
    Left = 16
    Top = 136
    Width = 225
    Height = 89
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 5
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 57
      Height = 13
      AutoSize = False
      Caption = 'Red:'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 57
      Height = 13
      AutoSize = False
      Caption = 'Green:'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 57
      Height = 13
      AutoSize = False
      Caption = 'Blue:'
    end
    object Label4: TLabel
      Left = 152
      Top = 44
      Width = 65
      Height = 13
      AutoSize = False
      Caption = 'Hex Value:'
    end
    object shColor: TShape
      Left = 152
      Top = 11
      Width = 49
      Height = 28
    end
    object seRed: TSpinEdit
      Tag = 1
      Left = 72
      Top = 11
      Width = 57
      Height = 22
      MaxValue = 15
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = ColorChange
    end
    object seGreen: TSpinEdit
      Tag = 2
      Left = 72
      Top = 35
      Width = 57
      Height = 22
      MaxValue = 15
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = ColorChange
    end
    object seBlue: TSpinEdit
      Tag = 3
      Left = 72
      Top = 59
      Width = 57
      Height = 22
      MaxValue = 15
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = ColorChange
    end
    object eColHex: TEdit
      Tag = 4
      Left = 152
      Top = 60
      Width = 50
      Height = 21
      TabOrder = 3
      OnChange = eColHexChange
    end
  end
end
