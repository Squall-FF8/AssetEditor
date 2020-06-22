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
    bAddPic: TPNGButton;
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
    bImpPicTile: TPNGButton;
    bAddLayer: TPNGButton;
    Panel3: TPanel;
    bMoveDown: TPNGButton;
    bMoveUp: TPNGButton;
    bDeleteAsset: TPNGButton;
    bCopyAsset: TPNGButton;
    Panel4: TPanel;
    panEdits: TPanel;
    Panel5: TPanel;
    Memo: TMemo;
    Splitter1: TSplitter;
    ScrollBox1: TScrollBox;
    Image: TImage;
    bImpPicTile16: TPNGButton;
    procedure bAddSpriteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbListClick(Sender: TObject);
    procedure bGenerateSourceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bAddPicClick(Sender: TObject);
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
    procedure bCopyAssetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bImpPicTile16Click(Sender: TObject);
  private
    procedure EmptyDoc;
  public
    procedure ShowPanel(Ind: integer);
  end;

var
  fmMain: TfmMain;

implementation
{$R *.dfm}

uses uCommon, uSprite, uPicture, uPalette, uLayer;


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
begin
  ind := lbList.ItemIndex;
  if ind < 0 then exit;

  case pAsset(lbList.Items.Objects[ind]).Kind of
    1: fmSprite.SetPointer(lbList.Items.Objects[ind]);
    2: fmPicture.SetPointer(lbList.Items.Objects[ind]);
    3: fmPalette.SetPointer(lbList.Items.Objects[ind]);
    4: fmLayer.SetPointer(lbList.Items.Objects[ind]);
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
  if (bmp.PixelFormat <> pf8bit) and (bmp.PixelFormat <> pf4bit) then begin
    ShowMessage('Unsupported pixel format. Please use only 4bpp or 8 bpp');
    exit;
  end;

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
  //Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  if bmp.PixelFormat = pf8bit then Pic.Mode := 0;
  if bmp.PixelFormat = pf4bit then Pic.Mode := 1;
  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));
  n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;
  for i := 0 to Pic.H - 1 do
    Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $F1000;
  Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
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
  //Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  if bmp.PixelFormat = pf8bit then Pic.Mode := 0;
  if bmp.PixelFormat = pf4bit then Pic.Mode := 1;
  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));
  n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;
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
  //Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  Pic.Mode := 2;

  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
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
  // Order is important!
  fmSprite.Setup;
  fmPicture.Setup;
  fmPalette.Setup;
  fmLayer.Setup;
end;


procedure TfmMain.bImpPicTile16Click(Sender: TObject);
  var fn: string;
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
  Pic.Mode := 3;

  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));

  Import4bpTile16(bmp, Pic);
end;

end.
