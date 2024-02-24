unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, pngExtra, pngImage, Spin, ExtDlgs,
  uCommon;

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
    bAddr: TPNGButton;
    bSaveAssets: TPNGButton;
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
    ImageBox: TScrollBox;
    Image: TImage;
    bImpPicTile16: TPNGButton;
    bImpBackground: TPNGButton;
    bAddRaw: TPNGButton;
    bImpPic2: TPNGButton;
    bImpSprite2: TPNGButton;
    bAddText: TPNGButton;
    bGenerateASM: TPNGButton;
    bAddZSM: TPNGButton;
    TextBox: TMemo;
    bImpTiles: TPNGButton;
    procedure bAddSpriteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbListClick(Sender: TObject);
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
    procedure bAddRawClick(Sender: TObject);
    procedure bImpPic2Click(Sender: TObject);
    procedure bImpSprite2Click(Sender: TObject);
    procedure bAddTextClick(Sender: TObject);
    procedure bGenerateASMClick(Sender: TObject);
    procedure bAddZSMClick(Sender: TObject);
    procedure bImpTilesClick(Sender: TObject);
  private
    ColSrc: integer;
    procedure EmptyDoc;
    procedure ExchangeLinks(n1, n2: integer);
  public
    procedure ShowPanel(Ind: integer);
    procedure HexDump(const Ptr);
  end;

var
  fmMain: TfmMain;

implementation
{$R *.dfm}

uses
  uSprite, uPicture, uPalette, uLayer, uMap, uTile0, uRAW, uText, uZSM, uTiles,
  uImportOpt, dlgRefactor, dlgImportTiles;


procedure TfmMain.FormCreate(Sender: TObject);
begin
  List := lbList;
  png := TPNGObject.Create;
  bmp := tBitmap.Create;
  TextBox.Align := alClient;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  EmptyDoc;
  png.Free;
  bmp.Free;
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
  SetLength(Layer.Data, 7);

  lbList.AddItem(Layer.Name, tObject(Layer));
end;


procedure TfmMain.bAddRawClick(Sender: TObject);
  var Raw: pAsset;
begin
  New(Raw);
  FillChar(Raw^, Sizeof(Raw^), 0);
  Raw.Name := 'NewRAW';
  Raw.Kind := atRaw;
  Raw.vAddr := $0;
  SetLength(Raw.Data, 0);

  lbList.AddItem(Raw.Name, tObject(Raw));
end;


procedure TfmMain.bAddTextClick(Sender: TObject);
  var Text: pText;
begin
  New(Text);
  FillChar(Text^, Sizeof(Text^), 0);
  Text.Name := 'NewTexts';
  Text.Kind := atText;
  Text.vAddr := $0;
  SetLength(Text.Data, 0);

  lbList.AddItem(Text.Name, tObject(Text));
end;


procedure TfmMain.lbListClick(Sender: TObject);
  var Asset: pAsset;
begin
  id := lbList.ItemIndex;
  if id < 0 then exit;

  Asset := pAsset(lbList.Items.Objects[id]);
  ImageBox.Visible := (Asset.Flags and Flag_TextBox) = 0;
  TextBox.Visible  := (Asset.Flags and Flag_TextBox) > 0;

  case Asset.Kind of
    atSprite:  fmSprite.SetPointer(Asset);
    atPicture: fmPicture.SetPointer(Asset);
    atPalette: fmPalette.SetPointer(Asset);
    atLayer:   fmLayer.SetPointer(Asset);
    atMap:     fmMap.SetPointer(Asset);
    atTile0:   fmTile0.SetPointer(Asset);
    atRaw:     fmRAW.SetPointer(Asset);
    atText:    fmText.SetPointer(Asset);
    atZSM:     fmZSM.SetPointer(Asset);
    atTile:    fmTiles.SetPointer(Asset);
  end;
end;


procedure TfmMain.bImpSpriteClick(Sender: TObject);
  var i, n, m: integer;
      bmp: tBitmap;
      Spr: pSprite;
      Pic: pPicture;
      Pal: pPalette;
begin
  if not dOpenPicture.Execute then exit;

  if ExtractFileExt(dOpenPicture.FileName) = '.png' then begin
    LoadPNG(dOpenPicture.FileName);
    if BadBPP or BadSize then exit;
    ImportSprite;
    exit;
  end;




  bmp := tBitmap.Create;
  bmp.LoadFromFile(dOpenPicture.FileName);
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
      png: TPNGObject;
      Pic: pPicture;
      Pal: pPalette;

      WinPal: tWinPalette;
      r, g, b: cardinal;
begin
  if not dOpenPicture.Execute then exit;
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $1FA00;

  if ExtractFileExt(dOpenPicture.FileName) = '.bmp' then begin
    bmp := tBitmap.Create;
    bmp.LoadFromFile(dOpenPicture.FileName);

    Pic.W    := bmp.Width;
    Pic.H    := bmp.Height;
    if bmp.PixelFormat = pf8bit then Pic.Mode := 0;
    if bmp.PixelFormat = pf4bit then Pic.Mode := 1;
    SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
    n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;
    for i := 0 to Pic.H - 1 do
      Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);

    Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
    SetLength(Pal.Data, 2 * Pal.Count);
    ExtarctPal(bmp, Pal.Data);

    bmp.Free;
  end else begin  // PNG
    png := TPNGObject.Create;
    png.LoadFromFile(dOpenPicture.FileName);

    Pic.W    := png.Width;
    Pic.H    := png.Height;
    if png.Header.BitDepth = 8 then Pic.Mode := 0;
    if png.Header.BitDepth = 4 then Pic.Mode := 1;
    n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;  //bytes per row
    SetLength(Pic.Data, Pic.H * n);
    //CopyMemory(@Pic.Data[0], png.Scanline[0], n);
    //Move(@(png.Scanline[0]), Pic.Data[0], n);
    for i := 0 to Pic.H - 1 do
      Move(png.ScanLine[i]^, Pic.Data[n * i], n);

    Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
    SetLength(Pal.Data, 2 * Pal.Count);
    FillChar(WinPal[0], SizeOf(WinPal), 0);
    GetPaletteEntries(png.Palette, 0, Pal.Count, WinPal);
    //GetDIBColorTable(png.Canvas.Handle, 0, Pal.Count, WinPal);
    for i := 0 to Pal.Count - 1 do begin
      r := WinPal[i].R shr 4;
      g := WinPal[i].G shr 4;
      b := WinPal[i].B shr 4;
      pWord(@Pal.Data[2*i])^ := r shl 8 + g shl 4 + b;
    end;

    png.Free;
  end;

  lbList.AddItem(Pic.Name, tObject(Pic));
  lbList.AddItem(Pal.Name, tObject(Pal));
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
  var i, p, a: integer;
      Asset: pAsset;
begin
  if not dlgRefactorOptions.Go then exit;
  a := Header.RAM.Bank;
  p := Header.RAM.Addr;
  if a >= 0 then inc(p, a * $2000);

  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    if (Asset.Flags and 1) = 0 then begin
      a := Asset.FixLen;
      if a <> 0 then
        a := a - p mod a;
      Asset.Addr := p + a;
      inc(p, Length(Asset.Data) + a);
    end;
  end;
end;


procedure TfmMain.bSaveAssetsClick(Sender: TObject);
  var f, i, n, a: cardinal;
      //a: integer;
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
    if (Asset.Flags and 1) = 0 then begin
      a := Asset.FixLen;
      if a <> 0 then begin
        a := a - (GetFileSize(f, nil) - 2) mod a;
        SetFilePointer(f, a, nil, FILE_CURRENT);
      end;

      WriteFile(f, Asset.Data[0], Length(Asset.Data), n, nil);
    end;
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
  Header.Count := lbList.Count;
  WriteFile(f, Header, cHeaderSize, n, nil);
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Asset._Len := Length(Asset.Data);
    WriteFile(f, Asset.Kind, cKindLen[Asset.Kind], n, nil);
    WriteFile(f, Asset.Data[0], Length(Asset.Data), n, nil);
  end;
  CloseHandle(f);
  Caption := 'Asset Editor - ' + dSave.FileName;
end;


procedure TfmMain.bLoadDocClick(Sender: TObject);
  var f, i, n, m: cardinal;
      t: byte;
      Spr:   pSprite;
      Pic:   pPicture;
      Pal:   pPalette;
      Lay:   pLayer;
      Map:   pMap;
      Tile0: pTile0;
      RAW:   pAsset;
      Text:  pText;
      ZSM:   pZSM;
      Tile:  pTile;
      Asset: pAsset;
      h: tHeader;
begin
  if not dOpen.Execute then exit;

  EmptyDoc;
  lbList.Items.Clear;
  f := CreateFile(pchar(dOpen.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  ReadFile(f, h, cHeaderSize, n, nil);
  if h.Mark = 'AEF' then begin
    m := h.Count;
    Header := h;
  end else begin  // revert to Version 1 (no header)
    m := pInteger(@h.Mark)^;
    SetFilePointer(f, 4, nil, FILE_BEGIN);
  end;

  for i := 0 to m - 1 do begin
    ReadFile(f, t, 1, n, nil);
    SetFilePointer(f, -1, nil, FILE_CURRENT);
    case t of
      atSprite: begin
        New(Spr);
        Asset := pointer(Spr);
       end;
      atPicture: begin
        New(Pic);
        Asset := pointer(Pic);
       end;
      atPalette: begin
        New(Pal);
        Asset := pointer(Pal);
       end;
      atLayer: begin
        New(Lay);
        Asset := pointer(Lay);
       end;
      atMap: begin
        New(Map);
        Asset := pointer(Map);
       end;
      atTile0: begin
        New(Tile0);
        Asset := pointer(Tile0);
       end;
      atRaw: begin
        New(RAW);
        Asset := pointer(RAW);
       end;
      atText: begin
        New(Text);
        Asset := pointer(Text);
       end;
      atZSM: begin
        New(ZSM);
        Asset := pointer(ZSM);
       end;
      atTile: begin
        New(Tile);
        Asset := pointer(Tile);
       end;
    end;
    ReadFile(f, Asset^, cKindLen[t], n, nil);
    pCardinal(@Asset.Data)^ := 0;
    SetLength(Asset.Data, Asset._Len);
    ReadFile(f, Asset.Data[0], Asset._Len, n, nil);
    lbList.AddItem(Asset.Name, tObject(Asset));
  end;
  CloseHandle(f);
  Caption := 'Asset Editor - ' + dOpen.FileName;
end;


procedure TfmMain.bNewDocClick(Sender: TObject);
begin
  EmptyDoc;
  lbList.Items.Clear;
  Caption := 'Asset Editor';
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
  fmTile0.Setup;
  fmRAW.Setup;
  fmText.Setup;
  fmZSM.Setup;
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

  var i, j, n, n1, n2: integer;
      fn: string;
      t1, t2: pMyTile;
      bmp: tBitmap;
      Pic: pPicture;
      Map: pMap;
      Tile: pTile0;
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
  Tile.Kind := atTile0;
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

  n  := 0;
  n1 := 0;
  n2 := 0;
  FillChar(Tile.Data[0], 32, 0); // The first tiles is always empty one
  for i := 0 to Map.W * Map.H - 1 do begin
    j := 0;
    t1 := @Pic.Data[i*32];
    t2 := @Tile.Data[0];
    repeat
      if (t1[0] = t2[0]) and (t1[1] = t2[1]) and (t1[2] = t2[2]) and (t1[3] = t2[3]) and
         (t1[4] = t2[4]) and (t1[5] = t2[5]) and (t1[6] = t2[6]) and (t1[7] = t2[7]) then begin
        pWord(@Map.Data[2*i])^ := j;
        inc(n1);
        break;
      end;
      if (t1[0] = t2[7]) and (t1[1] = t2[6]) and (t1[2] = t2[5]) and (t1[3] = t2[4]) and
         (t1[4] = t2[3]) and (t1[5] = t2[2]) and (t1[6] = t2[1]) and (t1[7] = t2[0]) then begin
        pWord(@Map.Data[2*i])^ := j + $400;
        inc(n2);
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
  Memo.Clear;
  Memo.Lines.Add(format('Total:   %4d', [Map.W * Map.H] ));
  Memo.Lines.Add(format('Similar: %4d', [n1] ));
  Memo.Lines.Add(format('H-Flip:  %4d', [n2] ));
  Memo.Lines.Add(format('Unique:  %4d', [Tile.Num] ));

  bmp := tBitmap.Create;
  bmp.Width  := Pic.W;
  bmp.Height := Pic.H;
  bmp.PixelFormat := pf4bit;
  SetDIBColorTable(bmp.Canvas.Handle, 0, 16, tmp[0]);

  for Y := 0 to Map.H - 1 do
    for X := 0 to Map.W - 1 do begin
      t := pWord(@Map.Data[2* (Y*Map.W + X)])^ and $3FF;
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


procedure TfmMain.HexDump(const Ptr);
  var p, n, addr: integer;
      Asset: pAsset;
      s: string;
begin
  Memo.Clear;
  Asset := pAsset(ptr);
  n := Length(Asset.Data);
  p := 0;
  s := '';

  while p <> n do begin
    if (p and $0F) = 0 then begin
      addr := Asset.Addr + p;
      if addr < $A000 then s := s + IntToHex(addr, 4) + ': '
      else begin
        dec(addr, $A000);
        s := s + format('%.2x %.4x: ', [addr div $2000, addr mod $2000 + $A000] )
      end;
    end;
    s := s + ' ' + IntToHex(Asset.Data[p], 2);
    if (p and $0F) = $F then s := s + #13#10;
    inc(p);
  end;
  Memo.Lines.Text := s;
end;



procedure TfmMain.bImpPic2Click(Sender: TObject);
  var i, j, n: integer;
      indStart, indInsert, ColCount, Link: integer;
      fn: string;
      bmp: tBitmap;
      png: tPNGObject;

      Asset: pAsset;
      Pic: pPicture;
      Pal: pPalette;

      WinPal: tWinPalette;
      r, g, b: cardinal;
      Src, Dst: ^byte;
begin
  if not dOpenPicture.Execute then exit;
  fn := ExtractFileName(dOpenPicture.FileName);
  Delete(fn, Length(fn) - 3, 4);

  with dlgImportOption do begin
    cbPal.Clear;
    for i := 0 to lbList.Count - 1 do begin
      Asset := pAsset(lbList.Items.Objects[i]);
      if Asset.Kind = atPalette then
        cbPal.AddItem(Asset.Name, tObject(i + 1));
    end;

    if ShowModal <> mrOK then exit;
    Link := integer(cbPal.Items.Objects[cbPal.ItemIndex]);
    Pal := pointer(lbList.Items.Objects[Link - 1]);
    indStart  := seStartIndex.Value;
    indInsert := seInsertIndex.Value;
    ColCount  := seColorCount.Value;
  end;

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.Link := Link;

  if ExtractFileExt(dOpenPicture.FileName) = '.bmp' then begin
    bmp := tBitmap.Create;
    bmp.LoadFromFile(dOpenPicture.FileName);

    Pic.W    := bmp.Width;
    Pic.H    := bmp.Height;
    if bmp.PixelFormat = pf8bit then Pic.Mode := 0;
    if bmp.PixelFormat = pf4bit then Pic.Mode := 1;
    SetLength(Pic.Data, (Pic.W * Pic.H * cTemplate[Pic.Mode].BPP) shr 3);
    n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;
    for i := 0 to Pic.H - 1 do
      Move(bmp.ScanLine[i]^, Pic.Data[n * i], n);

    Pal.Count := 1 shl cTemplate[Pic.Mode].BPP;
    SetLength(Pal.Data, 2 * Pal.Count);
    ExtarctPal(bmp, Pal.Data);

    bmp.Free;
  end else begin  // PNG
    png := TPNGObject.Create;
    png.LoadFromFile(dOpenPicture.FileName);

    Pic.W    := png.Width;
    Pic.H    := png.Height;
    Pic.Mode := ord(png.Header.BitDepth = 4);
    n := (Pic.W * cTemplate[Pic.Mode].BPP) shr 3;  //bytes per row
    SetLength(Pic.Data, Pic.H * n);

    Dst := @Pic.Data[0];
    for j := 0 to Pic.H - 1 do begin
      Src := png.ScanLine[j];
      for i := 0 to Pic.W - 1 do begin
        Dst^ := Src^ + indInsert;
        inc(Src);
        inc(Dst);
      end;
    end;

    FillChar(WinPal[0], SizeOf(WinPal), 0);
    GetPaletteEntries(png.Palette, 0, 1 shl png.Header.BitDepth, WinPal);
    for i := indStart to ColCount - 1 do begin
      r := WinPal[i].R shr 4;
      g := WinPal[i].G shr 4;
      b := WinPal[i].B shr 4;
      pWord(@Pal.Data[2*(i + indInsert)])^ := r shl 8 + g shl 4 + b;
    end;

    png.Free;
  end;

  lbList.AddItem(Pic.Name, tObject(Pic));
end;


procedure TfmMain.bImpSprite2Click(Sender: TObject);
begin
  if not dOpenPicture.Execute then exit;

  if ExtractFileExt(dOpenPicture.FileName) = '.png'
    then LoadPNG(dOpenPicture.FileName)
    else LoadBMP(dOpenPicture.FileName);
  if BadBPP or BadSize then exit;
  if not dlgImportOption.Go then exit;
  ImportSprite2;
end;

procedure TfmMain.bGenerateASMClick(Sender: TObject);
  var i: integer;
      Asset: pAsset;

  function FormatAddress(Addr: integer): string;
    var n: integer;
  begin
    if Addr < $A000 then Result := IntToHex(Addr, 4)
    else begin
      n := Addr - $A000;
      Result := format('$%d%.4x', [n div 8192, $A000 + n mod 8192]);
    end;
  end;

begin
  Memo.Clear;
  for i := 0 to lbList.Count - 1 do begin
    Asset := pAsset(lbList.Items.Objects[i]);
    Memo.Lines.Add( format('%s = %s',
      [Asset.Name, FormatAddress(Asset.Addr)]) );
  end;
end;

procedure TfmMain.bAddZSMClick(Sender: TObject);
  var ZSM: pZSM;
begin
  New(ZSM);
  FillChar(ZSM^, Sizeof(ZSM^), 0);
  ZSM.Name := 'New ZSM';
  ZSM.Kind := atZSM;
  ZSM.vAddr := $0;
  ZSM.Flags := Flag_TextBox;
  SetLength(ZSM.Data, 0);

  lbList.AddItem(ZSM.Name, tObject(ZSM));
end;

procedure TfmMain.bImpTilesClick(Sender: TObject);
begin
  if not dOpenPicture.Execute then exit;
  if ExtractFileExt(dOpenPicture.FileName) <> '.png' then exit; // for now PNG only!

  LoadPNG(dOpenPicture.FileName);
  if BadBPP then exit;
  if not dlgImportTile.Go then exit;

  ImportTiles;
end;

end.
