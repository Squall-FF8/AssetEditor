unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, pngextra, Spin, ExtDlgs;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    bAddSprite: TPNGButton;
    XPManifest1: TXPManifest;
    panSprite: TPanel;
    Label1: TLabel;
    eName: TEdit;
    Label2: TLabel;
    eAddress: TEdit;
    Label3: TLabel;
    seX: TSpinEdit;
    Label4: TLabel;
    seY: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbW: TComboBox;
    Label9: TLabel;
    cbH: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    eVidAddr: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    cbMode: TComboBox;
    Label15: TLabel;
    cbZ: TComboBox;
    Label16: TLabel;
    sePal: TSpinEdit;
    Label17: TLabel;
    cbHFlip: TCheckBox;
    cbVFlip: TCheckBox;
    Memo: TMemo;
    panPicture: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    eName2: TEdit;
    eAddress2: TEdit;
    seX2: TSpinEdit;
    seY2: TSpinEdit;
    cbBpp2: TComboBox;
    seW2: TSpinEdit;
    seH2: TSpinEdit;
    bAddPic: TPNGButton;
    Label29: TLabel;
    eVidAddr2: TEdit;
    Label30: TLabel;
    panPalette: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    eName3: TEdit;
    eAddress3: TEdit;
    seCount3: TSpinEdit;
    eVidAddr3: TEdit;
    bAddPalette: TPNGButton;
    bImpSprite: TPNGButton;
    dOpenPicture: TOpenPictureDialog;
    dSave: TSaveDialog;
    bSaveFile: TPNGButton;
    eAddr: TEdit;
    Label35: TLabel;
    bAddr: TPNGButton;
    bSaveAssets: TPNGButton;
    bGenerateSource: TPNGButton;
    bLoadDoc: TPNGButton;
    bSaveDoc: TPNGButton;
    dOpen: TOpenDialog;
    bNewDoc: TPNGButton;
    bImpPic: TPNGButton;
    bDelAsset: TPNGButton;
    Panel2: TPanel;
    lbList: TListBox;
    Label36: TLabel;
    cbPicFmt2: TComboBox;
    bImpPicTile: TPNGButton;
    bAddLayer: TPNGButton;
    panEdits: TPanel;
    Panel3: TPanel;
    bMoveDown: TPNGButton;
    bMoveUp: TPNGButton;
    bDeleteAsset: TPNGButton;
    bCopyAsset: TPNGButton;
    procedure bAddSpriteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbListClick(Sender: TObject);
    procedure SpriteChange(Sender: TObject);
    procedure bGenerateSourceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bAddPicClick(Sender: TObject);
    procedure PictureChange(Sender: TObject);
    procedure PaletteChange(Sender: TObject);
    procedure bAddPaletteClick(Sender: TObject);
    procedure bImpSpriteClick(Sender: TObject);
    procedure bSaveFileClick(Sender: TObject);
    procedure bAddrClick(Sender: TObject);
    procedure bSaveAssetsClick(Sender: TObject);
    procedure bSaveDocClick(Sender: TObject);
    procedure bLoadDocClick(Sender: TObject);
    procedure bNewDocClick(Sender: TObject);
    procedure bImpPicClick(Sender: TObject);
    procedure bDelAssetClick(Sender: TObject);
    procedure bMoveUpClick(Sender: TObject);
    procedure bMoveDownClick(Sender: TObject);
    procedure bImpPicTileClick(Sender: TObject);
    procedure bAddLayerClick(Sender: TObject);
    procedure LayerChange(Sender: TObject);
    procedure bCopyAssetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure EmptyDoc;
    procedure ShowPanel(Ind: integer);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation
{$R *.dfm}

uses uCommon, uLayer;


procedure TfmMain.FormCreate(Sender: TObject);
begin
//
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  EmptyDoc;
end;


procedure TfmMain.EmptyDoc;
  var i: integer;
      Asset: pAsset;
begin
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    SetLength(Asset.Data, 0);
    Dispose( Asset );
  end;
end;


procedure TfmMain.bAddSpriteClick(Sender: TObject);
  var Spr: pSprite;
begin
  New(Spr);
  FillChar(Spr^, Sizeof(Spr^), 0);
  Spr.Name := 'NewSprite';
  Spr.Kind := atSprite;
  Spr.vAddr := $F5000;
  SetLength(Spr.Data, 8);

  lbList.AddItem(Spr.Name, tObject(Spr));
end;


procedure TfmMain.bAddPicClick(Sender: TObject);
  var Pic: pPicture;
begin
  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := 'NewPicture';
  Pic.Kind := atPicture;
  //SetLength(Pic.Data, 8);

  lbList.AddItem(Pic.Name, tObject(Pic));
end;


procedure TfmMain.bAddPaletteClick(Sender: TObject);
  var Pal: pPalette;
begin
  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := 'NewPalette';
  Pal.Kind  := atPalette;
  Pal.vAddr := $F1000;
  //SetLength(Pic.Data, 8);

  lbList.AddItem(Pal.Name, tObject(Pal));
end;


procedure TfmMain.bAddLayerClick(Sender: TObject);
  var Layer: pLayer;
begin
  New(Layer);
  FillChar(Layer^, Sizeof(Layer^), 0);
  Layer.Name := 'NewLayer';
  Layer.Kind := atLayer;
  Layer.vAddr := $F2000;
  SetLength(Layer.Data, 10);

  lbList.AddItem(Layer.Name, tObject(Layer));
end;


procedure TfmMain.lbListClick(Sender: TObject);
  var ind: integer;
      Spr: pSprite;
      Pic: pPicture;
      Pal: pPalette;
begin
  ind := lbList.ItemIndex;
  if ind < 0 then exit;

  case pAsset(lbList.Items.Objects[ind]).Kind of
  1: begin
    Spr := pSprite(lbList.Items.Objects[ind]);
    eName.Text    := Spr.Name;
    eAddress.Text := IntToHex(Spr.Addr, 4);
    seX.Value     := Spr.X;
    seY.Value     := Spr.Y;
    cbW.ItemIndex := Spr.W;
    cbH.ItemIndex := Spr.H;
    cbMode.ItemIndex := Spr.BPP;
    cbZ.ItemIndex    := Spr.Z;
    eVidAddr.Text    := IntToHex(Spr.vAddr, 5);
    sePal.Value      := Spr.Pal;
    cbHFlip.Checked  := Spr.hFlip = 1;
    cbVFlip.Checked  := Spr.vFlip = 1;

    ShowPanel(1);
    HexDump(Memo.Lines, Spr.Data, Spr.Addr);
   end;

  2: begin
    Pic := pPicture(lbList.Items.Objects[ind]);
    eName2.Text         := Pic.Name;
    eAddress2.Text      := IntToHex(Pic.Addr, 4);
    seX2.Value          := Pic.X;
    seY2.Value          := Pic.Y;
    seW2.Value          := Pic.W;
    seH2.Value          := Pic.H;
    cbBpp2.ItemIndex    := Pic.BPP;
    cbPicFmt2.ItemIndex := Pic.Mode;
    eVidAddr2.Text      := IntToHex(Pic.vAddr, 5);

    ShowPanel(2);
    HexDump(Memo.Lines, Pic.Data, Pic.Addr);
   end;

  3: begin
    Pal := pPalette(lbList.Items.Objects[ind]);
    eName3.Text      := Pal.Name;
    eAddress3.Text   := IntToHex(Pal.Addr, 4);
    seCount3.Value   := Pal.Count;
    eVidAddr3.Text   := IntToHex(Pal.vAddr, 5);

    ShowPanel(3);
    HexDump(Memo.Lines, Pal.Data, Pal.Addr);
   end;

  4: begin
    fmLayer.SetPointer(lbList.Items.Objects[ind]);
    ShowPanel(0);
    {Lay := pLayer(lbList.Items.Objects[ind]);

    panPalette.Visible := false;
    panPicture.Visible := false;
    panSprite.Visible  := false;
    PanLayer.Visible   := true;
    HexDump(Memo.Lines, Lay.Data, Lay.Addr);  }
   end;

  end;
end;


procedure TfmMain.SpriteChange(Sender: TObject);
  var Spr: pSprite;
begin
  Spr := pSprite(lbList.Items.Objects[lbList.ItemIndex]);
  case TComponent(Sender).Tag of
     1: begin
        Spr.Name := eName.Text;
        lbList.Items[lbList.ItemIndex] := Spr.Name;
      end;
     2: Spr.Addr := StrToInt('$' + eAddress.Text);
     3: Spr.X := seX.Value;
     4: Spr.Y := seY.Value;
     5: Spr.W := cbW.ItemIndex;
     6: Spr.H := cbH.ItemIndex;
     7: Spr.BPP := cbMode.ItemIndex;
     8: Spr.vAddr := StrToInt('$' + eVidAddr.Text);
     9: Spr.Z := cbZ.ItemIndex;
    10: Spr.Pal := sePal.Value;
    11: Spr.hFlip := ord(cbHFlip.Checked);
    12: Spr.vFlip := ord(cbVFlip.Checked);
  end;
  PrepareSpriteData(Spr);
  HexDump(Memo.Lines, Spr.Data, Spr.Addr);
end;


procedure TfmMain.PictureChange(Sender: TObject);
  var Pic: pPicture;
begin
  Pic := pPicture(lbList.Items.Objects[lbList.ItemIndex]);
  case TComponent(Sender).Tag of
     1: begin
        Pic.Name := eName2.Text;
        lbList.Items[lbList.ItemIndex] := Pic.Name;
      end;
     2: Pic.Addr  := StrToInt('$' + eAddress2.Text);
     3: Pic.X     := seX2.Value;
     4: Pic.Y     := seY2.Value;
     5: Pic.W     := seW2.Value;
     6: Pic.H     := seH2.Value;
     7: Pic.BPP   := cbBpp2.ItemIndex;
     8: Pic.Mode  := cbPicFmt2.ItemIndex;
     9: Pic.vAddr := StrToInt('$' + eVidAddr2.Text);
  end;
end;


procedure TfmMain.LayerChange(Sender: TObject);
  var Lay: pLayer;
begin
  {Lay := pLayer(lbList.Items.Objects[lbList.ItemIndex]);
  HexDump(Memo.Lines, Lay.Data, Lay.Addr); }
end;


procedure TfmMain.PaletteChange(Sender: TObject);
  var Pal: pPalette;
begin
  Pal := pPalette(lbList.Items.Objects[lbList.ItemIndex]);
  case TComponent(Sender).Tag of
     1: begin
        Pal.Name := eName3.Text;
        lbList.Items[lbList.ItemIndex] := Pal.Name;
      end;
     2: Pal.Addr  := StrToInt('$' + eAddress3.Text);
     3: Pal.Count := seCount3.Value;
     4: Pal.vAddr := StrToInt('$' + eVidAddr3.Text);
  end;
end;


procedure TfmMain.bGenerateSourceClick(Sender: TObject);
  const
    cHeader: string =
      'const'#13#10 +
      '  cAssetAddress = $%s;'#13#10#13#10 +
      'var'#13#10 +
      '  AssetFile: array[] of char = ''Assets.bin'';'#13#10;
    cBody: string =
      #13#10 +
      '  LoadFile(@AssetFile, AssetFile.Length, cAssetAddress);';
    cCopyToVera: string =
      #13#10 +
      '  vSetAddressR($%.2x, $%.2x, $%.2x);'#13#10 +
      '  CopyToVera($%.4x, %d);';

  var i: integer;
      Asset: pAsset;
begin
  Memo.Lines.Add(format(cHeader, [eAddr.Text]));
  for i :=0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Memo.Lines.Add( format('  %s: array[%d] of byte absolute $%.4x;',
      [Asset.Name, Length(Asset.Data), Asset.Addr]) );
  end;

  Memo.Lines.Add(cBody);
  for i :=0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Memo.Lines.Add( format(cCopyToVera,
      [Asset.vAddr shr 16, (Asset.vAddr shr 8) and $FF, Asset.vAddr and $FF, Asset.Addr, Length(Asset.Data)]) );
  end;
end;


procedure TfmMain.bImpSpriteClick(Sender: TObject);
  var i, n: integer;
      fn: string;
      bmp: tBitmap;
      Spr: pSprite;
      Pic: pPicture;
      Pal: pPalette;
begin
  if not dOpenPicture.Execute then exit;

  bmp := tBitmap.Create;
  bmp.LoadFromFile(dOpenPicture.FileName);
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  New(Spr);
  FillChar(Spr^, Sizeof(Spr^), 0);
  Spr.Name := fn + '_Spr';
  Spr.Kind := atSprite;
  Spr.vAddr := $F5000;
  Spr.W    := GetSprMetric(bmp.Width);
  Spr.H    := GetSprMetric(bmp.Height);
  Spr.BPP  := ord( bmp.PixelFormat = pf8bit );
  Spr.Z    := 3;
  SetLength(Spr.Data, 8);
  lbList.AddItem(Spr.Name, tObject(Spr));

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.W    := bmp.Width;
  Pic.H    := bmp.Height;
  Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  Pic.Mode := pmLinear;
  SetLength(Pic.Data, (Pic.W * Pic.H * IndToBpp(Pic.BPP)) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));
  n := (Pic.W * IndToBpp(Pic.BPP)) shr 3;
  for i := 0 to Pic.H - 1 do
    Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $F1000;
  Pal.Count := 1 shl (1 shl Pic.BPP);
  SetLength(Pal.Data, 2 * Pal.Count);
  ExtarctPal(bmp, Pal.Data);
  lbList.AddItem(Pal.Name, tObject(Pal));

  bmp.Free;
end;


procedure TfmMain.bImpPicClick(Sender: TObject);
  var i, n: integer;
      fn: string;
      bmp: tBitmap;
      Pic: pPicture;
begin
  if not dOpenPicture.Execute then exit;

  bmp := tBitmap.Create;
  bmp.LoadFromFile(dOpenPicture.FileName);
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.W    := bmp.Width;
  Pic.H    := bmp.Height;
  Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  Pic.Mode := pmLinear;
  SetLength(Pic.Data, (Pic.W * Pic.H * IndToBpp(Pic.BPP)) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));
  n := (Pic.W * IndToBpp(Pic.BPP)) shr 3;
  for i := 0 to Pic.H - 1 do
    Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);
end;


procedure TfmMain.bSaveFileClick(Sender: TObject);
  var f, n: cardinal;
      w: word;
      Asset: pAsset;
begin
  dSave.Filter := 'Binary File (.bin)|*.bin|All Files (*.*)|*.*';
  if not dSave.Execute then exit;

  Asset := pAsset(lbList.Items.Objects[lbList.ItemIndex]);
  w := 0;
  f := CreateFile(pchar(dSave.FileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  WriteFile(f, w, 2, n, nil);
  WriteFile(f, Asset.Data[0], Length(Asset.Data), n, nil);
  CloseHandle(f);
end;


procedure TfmMain.bAddrClick(Sender: TObject);
  var i, p: integer;
      Asset: pAsset;
begin
  p := StrToInt('$' + eAddr.Text);
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Asset.Addr := p;
    inc(p, Length(Asset.Data));
  end;
end;


procedure TfmMain.bSaveAssetsClick(Sender: TObject);
  var f, i, n: cardinal;
      w: word;
      Asset: pAsset;
begin
  dSave.Filter := 'Binary File (.bin)|*.bin|All Files (*.*)|*.*';
  if not dSave.Execute then exit;

  w := 0;
  f := CreateFile(pchar(dSave.FileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  WriteFile(f, w, 2, n, nil);
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    WriteFile(f, Asset.Data[0], Length(Asset.Data), n, nil);
  end;
  CloseHandle(f);
end;


procedure TfmMain.bSaveDocClick(Sender: TObject);
  var f, i, n: cardinal;
      Asset: pAsset;
begin
  dSave.Filter := 'Asset Editor File (.aef)|*.aef|All Files (*.*)|*.*';
  if not dSave.Execute then exit;

  f := CreateFile(pchar(dSave.FileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  i := lbList.Count;
  WriteFile(f, i, 4, n, nil);
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Asset._Len := Length(Asset.Data);
    WriteFile(f, Asset.Kind, cKindLen[Asset.Kind], n, nil);
    WriteFile(f, Asset.Data[0], Length(Asset.Data), n, nil);
  end;
  CloseHandle(f);
end;


procedure TfmMain.bLoadDocClick(Sender: TObject);
  var f, i, n, m: cardinal;
      t: byte;
      Spr: pSprite;
      Pic: pPicture;
      Pal: pPalette;
      Lay: pLayer;
begin
  if not dOpen.Execute then exit;

  EmptyDoc;
  lbList.Items.Clear;
  f := CreateFile(pchar(dOpen.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  ReadFile(f, m, 4, n, nil);
  for i := 0 to m - 1 do begin
    ReadFile(f, t, 1, n, nil);
    SetFilePointer(f, -1, nil, FILE_CURRENT);
    case t of
      atSprite: begin
        New(Spr);
        ReadFile(f, Spr^, SizeOf(tSprite), n, nil);
        pCardinal(@Spr.Data)^ := 0;
        SetLength(Spr.Data, Spr._Len);
        ReadFile(f, Spr.Data[0], Spr._Len, n, nil);
        lbList.AddItem(Spr.Name, tObject(Spr));
       end;
      atPicture: begin
        New(Pic);
        ReadFile(f, Pic^, SizeOf(tPicture), n, nil);
        pCardinal(@Pic.Data)^ := 0;
        SetLength(Pic.Data, Pic._Len);
        ReadFile(f, Pic.Data[0], Pic._Len, n, nil);
        lbList.AddItem(Pic.Name, tObject(Pic));
       end;
      atPalette: begin
        New(Pal);
        ReadFile(f, Pal^, SizeOf(tPalette), n, nil);
        pCardinal(@Pal.Data)^ := 0;
        SetLength(Pal.Data, Pal._Len);
        ReadFile(f, Pal.Data[0], Pal._Len, n, nil);
        lbList.AddItem(Pal.Name, tObject(Pal));
       end;
      atLayer: begin
        New(Lay);
        ReadFile(f, Lay^, SizeOf(tLayer), n, nil);
        pCardinal(@Lay.Data)^ := 0;
        SetLength(Lay.Data, Lay._Len);
        ReadFile(f, Lay.Data[0], Lay._Len, n, nil);
        lbList.AddItem(Lay.Name, tObject(Lay));
       end;
    end;
  end;
  CloseHandle(f);
end;


procedure TfmMain.bNewDocClick(Sender: TObject);
begin
  EmptyDoc;
  lbList.Items.Clear;
end;


procedure TfmMain.bDelAssetClick(Sender: TObject);
  var ind: integer;
      Asset: pAsset;
begin
  ind := lbList.ItemIndex;
  if ind < 0 then exit;

  Asset := pAsset(lbList.Items.Objects[ind]);
  SetLength(Asset.Data, 0);
  Dispose( Asset );
end;

procedure TfmMain.bMoveUpClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbList.ItemIndex;
  if ind < 1 then exit;
  lbList.Items.Exchange(ind, ind-1);
end;

procedure TfmMain.bMoveDownClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbList.ItemIndex;
  if (ind < 0) or (ind = (lbList.Count - 1)) then exit;
  lbList.Items.Exchange(ind, ind+1);
end;


procedure TfmMain.bImpPicTileClick(Sender: TObject);
  var //i, n: integer;
      fn: string;
      bmp: tBitmap;
      Pic: pPicture;
begin
  if not dOpenPicture.Execute then exit;

  bmp := tBitmap.Create;
  bmp.LoadFromFile(dOpenPicture.FileName);
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.W    := bmp.Width;
  Pic.H    := bmp.Height;
  Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  Pic.Mode := pmTiles;

  SetLength(Pic.Data, (Pic.W * Pic.H * IndToBpp(Pic.BPP)) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));

  Import4bpTile(bmp, Pic);
  //n := (Pic.W * IndToBpp(Pic.BPP)) shr 3;
  //for i := 0 to Pic.H - 1 do
  //  Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);
end;


procedure TfmMain.bCopyAssetClick(Sender: TObject);
begin
  HexDumpInClipBoard(pAsset(lbList.Items.Objects[lbList.ItemIndex]).Data);
end;

procedure TfmMain.ShowPanel(Ind: integer);
  var i: integer;
begin
  for i := 0 to panEdits.ControlCount - 1 do
    panEdits.Controls[i].Visible := i = Ind;
end;


procedure TfmMain.FormShow(Sender: TObject);
begin
  fmLayer.Setup;
end;

end.
