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
    bImpBackground: TPNGButton;
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
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bImpBackgroundClick(Sender: TObject);
  private
    ColSrc: integer;
    procedure EmptyDoc;
    procedure ExchangeLinks(n1, n2: integer);
  public
    procedure ShowPanel(Ind: integer);
  end;

var
  fmMain: TfmMain;

implementation
{$R *.dfm}

uses uCommon, uSprite, uPicture, uPalette, uLayer, uMap, uTiles;


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
  id := -1;
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
  Pal.vAddr := $1FA00;
  //Pal.Count := 16;
  //SetLength(Pal.Data, 32);

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
begin
  id := lbList.ItemIndex;
  if id < 0 then exit;

  case pAsset(lbList.Items.Objects[id]).Kind of
    1: fmSprite.SetPointer(lbList.Items.Objects[id]);
    2: fmPicture.SetPointer(lbList.Items.Objects[id]);
    3: fmPalette.SetPointer(lbList.Items.Objects[id]);
    4: fmLayer.SetPointer(lbList.Items.Objects[id]);
    5: fmMap.SetPointer(lbList.Items.Objects[id]);
    6: fmTiles.SetPointer(lbList.Items.Objects[id]);
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
  var i, n, m: integer;
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
  Pic.W    := 1 shl (Spr.W + 3);
  Pic.H    := 1 shl (Spr.H + 3);
  //Pic.BPP  := GetPicBpp(bmp.PixelFormat);
  if bmp.PixelFormat = pf8bit then Pic.Mode := 0;
  if bmp.PixelFormat = pf4bit then Pic.Mode := 1;
  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
  lbList.AddItem(Pic.Name, tObject(Pic));
  n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;
  m := (bmp.Width * cTemplate[Pic.Mode].BPP) shr 3;
  for i := 0 to bmp.Height - 1 do
    Move(bmp.ScanLine[i]^, Pic.Data[n * i], m);

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $1FA00;
  Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
  SetLength(Pal.Data, 2 * Pal.Count);
  ExtarctPal(bmp, Pal.Data);
  lbList.AddItem(Pal.Name, tObject(Pal));

  bmp.Free;
  Spr.Link := lbList.Count - 1;
  Pic.Link := lbList.Count;
end;


procedure TfmMain.bImpPicClick(Sender: TObject);
  var i, n: integer;
      fn: string;
      bmp: tBitmap;
      Pic: pPicture;
      Pal: pPalette;
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

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $1FA00;
  Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
  SetLength(Pal.Data, 2 * Pal.Count);
  ExtarctPal(bmp, Pal.Data);
  lbList.AddItem(Pal.Name, tObject(Pal));

  bmp.Free;
  Pic.Link := lbList.Count;
end;


procedure TfmMain.bSaveFileClick(Sender: TObject);
  var f, n: cardinal;
      w: word;
      Asset: pAsset;
begin
  dSave.Filter := 'Binary File (.bin)|*.bin|All Files (*.*)|*.*';
  if not dSave.Execute then exit;

  Asset := pAsset(lbList.Items.Objects[id]);
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
      Map: pMap;
      Tiles: pTile;
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
      atMap: begin
        New(Map);
        ReadFile(f, Map^, SizeOf(tMap), n, nil);
        pCardinal(@Map.Data)^ := 0;
        SetLength(Map.Data, Map._Len);
        ReadFile(f, Map.Data[0], Map._Len, n, nil);
        lbList.AddItem(Map.Name, tObject(Map));
       end;
      atTile: begin
        New(Tiles);
        ReadFile(f, Tiles^, SizeOf(tTile), n, nil);
        pCardinal(@Tiles.Data)^ := 0;
        SetLength(Tiles.Data, Tiles._Len);
        ReadFile(f, Tiles.Data[0], Tiles._Len, n, nil);
        lbList.AddItem(Tiles.Name, tObject(Tiles));
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
  var i, n: integer;
      Asset: pAsset;
begin
  if id < 0 then exit;

  Asset := pAsset(lbList.Items.Objects[id]);
  SetLength(Asset.Data, 0);
  Dispose( Asset );
  lbList.Items.Delete(id);

  n := id + 1;
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    if Asset.Link = n then
      Asset.Link := 0;
    if Asset.Link > n then
      dec(Asset.Link);
  end;
end;


procedure TfmMain.ExchangeLinks(n1, n2: integer);
  var i: integer;
      Asset: pAsset;
begin
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    if Asset.Link = n1 then
      Asset.Link := n2
    else if Asset.Link = n2 then
      Asset.Link := n1;
  end;
end;

procedure TfmMain.bMoveUpClick(Sender: TObject);
begin
  if id < 1 then exit;
  lbList.Items.Exchange(id, id-1);
  ExchangeLinks(id, id + 1);
  dec(id);
end;

procedure TfmMain.bMoveDownClick(Sender: TObject);
begin
  if (id < 0) or (id = (lbList.Count - 1)) then exit;
  lbList.Items.Exchange(id, id+1);
  inc(id);
  ExchangeLinks(id, id + 1);
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
  HexDumpInClipBoard(pAsset(lbList.Items.Objects[id]).Data);
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
  fmMap.Setup;
  fmTiles.Setup;
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


procedure TfmMain.ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var col: integer;
begin
  ColSrc := -1;
  col := XYtoCol(X, Y);
  if (id < 0) or (pAsset(lbList.Items.Objects[id]).Kind <> atPalette) or
     (col >= fmPalette.Pal.Count) then exit;

  ColSrc := XYtoCol(X, Y);
  fmPalette.SetColor(ColSrc);
end;


procedure TfmMain.ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var col: integer;
begin
  col := XYtoCol(X, Y);
  if (id < 0) or (pAsset(lbList.Items.Objects[id]).Kind <> atPalette) or
     (ColSrc = -1) or (col >= fmPalette.Pal.Count) or
     ((col shr 4) = (ColSrc shr 4))then exit;

  fmPalette.ExchangePals(ColSrc shr 4, col shr 4);
end;


procedure TfmMain.bImpBackgroundClick(Sender: TObject);
  type
    tMyTile = array [0 .. 7] of integer;
    pMyTile = ^ tMyTile;

  var i, j, n: integer;
      fn: string;
      t1, t2: pMyTile;
      bmp: tBitmap;
      Pic: pPicture;
      Map: pMap;
      Tile: pTile;
      Pal: pPalette;
      tmp: array[0 .. 255] of cardinal;

      X, Y, tY: integer;
      t: word;
      Src: ^integer;
begin
  if not dOpenPicture.Execute then exit;

  bmp := tBitmap.Create;
  bmp.LoadFromFile(dOpenPicture.FileName);
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.W    := bmp.Width;
  Pic.H    := bmp.Height;
  SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
  Import4bpTile(bmp, Pic);

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $1FA00;
  Pal.Count := 16;
  SetLength(Pal.Data, 2 * Pal.Count);
  ExtarctPal(bmp, Pal.Data);
  lbList.AddItem(Pal.Name, tObject(Pal));

  GetDIBColorTable(bmp.Canvas.Handle, 0, 16, tmp[0]);
  bmp.Free;

  New(Tile);
  FillChar(Tile^, Sizeof(Tile^), 0);
  Tile.Name := fn + '_Tiles';
  Tile.Kind := atTile;
  SetLength(Tile.Data, (Pic.W * Pic.H) shr 1);
  lbList.AddItem(Tile.Name, tObject(Tile));

  New(Map);
  FillChar(Map^, Sizeof(Map^), 0);
  Map.Name := fn + '_Map';
  Map.Kind := atMap;
  Map.W := Pic.W shr 3;
  Map.H := Pic.H shr 3;
  SetLength(Map.Data, Map.W * Map.H * 2);
  lbList.AddItem(Map.Name, tObject(Map));

  n := 0;
  FillChar(Tile.Data[0], 32, 0); // The first tiles is always empty one
  for i := 0 to Map.W * Map.H - 1 do begin
    j := 0;
    t1 := @Pic.Data[i*32];
    t2 := @Tile.Data[0];
    repeat
      if (t1[0] = t2[0]) and (t1[1] = t2[1]) and (t1[2] = t2[2]) and (t1[3] = t2[3]) and
         (t1[4] = t2[4]) and (t1[5] = t2[5]) and (t1[6] = t2[6]) and (t1[7] = t2[7]) then begin
        pWord(@Map.Data[2*i])^ := j;
        break;
      end;
      inc(j);
      inc(t2);
    until j > n;
    if j > n then begin
      Move(t1[0], t2[0], 32); // copy a tile
      inc(n);
      pWord(@Map.Data[2*i])^ := n;
    end;
  end;
  Tile.Num := n + 1;
  SetLength(Tile.Data, Tile.Num * 32);

  bmp := tBitmap.Create;
  bmp.Width  := Pic.W;
  bmp.Height := Pic.H;
  bmp.PixelFormat := pf4bit;
  SetDIBColorTable(bmp.Canvas.Handle, 0, 16, tmp[0]);

  for Y := 0 to Map.H - 1 do
    for X := 0 to Map.W - 1 do begin
      t := Map.Data[2* (Y*Map.W + X)] and $3FF;
      Src := @Tile.Data[ t*32];
      for tY := 0 to 7 do begin
        pMyTile(bmp.ScanLine[Y shl 3 + ty])^[X] := Src^;
        inc(Src);
      end;
    end;

  Image.SetBounds(0, 0, 2*Pic.W, 2*Pic.H);
  Image.Picture.Bitmap.PixelFormat := pf24bit;
  Image.Picture.Bitmap.Width  := 2*Pic.W;
  Image.Picture.Bitmap.Height := 2*Pic.H;
  Image.Canvas.StretchDraw(Bounds(0, 0, 2*Pic.W, 2*Pic.H), bmp);
  bmp.Free;

  Dispose(Pic);
end;

end.
