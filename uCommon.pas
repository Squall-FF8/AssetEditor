unit uCommon;

interface
uses Windows, Classes, Graphics, StdCtrls, pngimage;

const
  cTransCol = clBtnFace;

  atSprite  = 1;
  atPicture = 2;
  atPalette = 3;
  atLayer   = 4;
  atMap     = 5;
  atTile    = 6;
  atRaw     = 7;
  atText    = 8;

  // Picture Modes
  //pmLinear = 0;
  //pmTiles  = 1;


type
     // Palette related
  tWinPalEntry = record
    case byte of
      0: (R, G, B, A: byte);
      1: (Color: TColor);
  end;
  tWinPalette = array[0..255] of tWinPalEntry;

  tScanLine = array[0..1] of byte;
  pScanLine = ^tScanLine;


  tAssetName = string[50];
  tData = array of byte;

  tAsset = record
    Kind:   byte;
    Flags:  byte;
    _Len:   integer;
    Name:   tAssetName;
    Addr:   integer;
    vAddr:  integer;
    Data:   tData;
    Link:   integer;
    FixLen: integer;
  end;
  pAsset = ^tAsset;


  tSprite = record
    Kind:  byte;
    Flags: byte;
    _Len:  integer;
    Name:  tAssetName;
    Addr:  integer;
    vAddr: integer;
    Data:  tData;
    Link:  integer;  // to a Pic
    FixLen: integer;

    X, Y:  integer;
    W, H:  byte;
    BPP:   byte;
    Z:     byte;
    vFlip,
    hFlip: byte;
    Pal:   byte;
  end;
  pSprite = ^tSprite;


  tPicture = record
    Kind:  byte;
    Flags: byte;
    _Len:  integer;
    Name:  tAssetName;
    Addr:  integer;
    vAddr: integer;
    Data:  tData;
    Link:  integer;  // to a Pal
    FixLen: integer;

    X, Y:  integer;
    W, H:  integer;
    //BPP:   byte;  // 1, 2, 4, 8
    Mode:  byte;  // Linear = 0; Tile = 1;

    Ind:   integer;  // Pal Index
  end;
  pPicture = ^tPicture;


  tPalette = record
    Kind:  byte;
    Flags: byte;
    _Len:  integer;
    Name:  tAssetName;
    Addr:  integer;
    vAddr: integer;
    Data:  tData;
    Link:  integer;  // not used
    FixLen: integer;

    Count: integer;
  end;
  pPalette = ^tPalette;

  tLayer = record
    Kind:  byte;
    Flags: byte;
    _Len:  integer;
    Name:  tAssetName;
    Addr:  integer;
    vAddr: integer;
    Data:  tData;
    Link:  integer;  // not used
    FixLen: integer;

    Mode:     byte;
    Enable:   byte;  // 1 - yes; 0 - no
    TileH,
    TileW:    byte;
    MapH,
    MapW:     byte;
    MapBase:  integer;  //Map Base
    TileBase: integer;  //Tile Base
    ScrollH:  byte;
    ScrollV:  byte;
  end;
  pLayer = ^tLayer;

  tTile = record
    Kind: byte;
    Flags: byte;
    _Len: integer;
    Name: tAssetName;
    Addr: integer;
    vAddr: integer;
    Data: tData;
    Link: integer;
    FixLen: integer;

    Num:  integer;
  end;
  pTile = ^tTile;

  tMap = record
    Kind: byte;
    Flags: byte;
    _Len: integer;
    Name: tAssetName;
    Addr: integer;
    vAddr: integer;
    Data: tData;
    Link: integer;
    FixLen: integer;

    W, H:  integer;  // in tiles not in pixels
    Pal:   integer;  // Pal Index
  end;
  pMap = ^tMap;

  tText = tAsset;
  pText = ^tText;


const
  cKindLen: array[1 .. 8] of integer = (
    SizeOf(tSprite), SizeOf(TPicture), SizeOf(tPalette), SizeOf(tLayer),
    SizeOf(tMap), SizeOf(tTile), SizeOf(tAsset), SizeOf(tText) );


type
  tTemplate = record
    Name: string[20];
    BPP,
    tW,
    tH: byte;
  end;
  pTemplate = ^tTemplate;

const
  // Tile Format constants
  cTmplNum = 3;
  cTemplate: array[0 .. cTmplNum] of tTemplate = (
    (Name: '8bpp Linear';        BPP: 8;  tW:1;  tH:1),
    (Name: '4bpp Linear';        BPP: 4;  tW:1;  tH:1),
    (Name: '4bpp Tiled (8x8)';   BPP: 4;  tW:8;  tH:8),
    (Name: '4bpp Tiled (16x16)'; BPP: 4;  tW:16; tH:16)
  );


type
  tLayerMode = record
    Text: string;
    Value: integer;
  end;

const
  cLayMode: array[0 .. 8] of tLayerMode = (
    (Text: 'Text (16c Fg/Bg)';      Value: 0),
    (Text: 'Text (256c Fg, 1c Bg)'; Value: 8),
    (Text: 'Tile 2bpp';             Value: 1),
    (Text: 'Tile 4bpp';             Value: 2),
    (Text: 'Tile 8bpp';             Value: 3),
    (Text: 'Bitmap 1bpp';           Value: 4),
    (Text: 'Bitmap 2bpp';           Value: 5),
    (Text: 'Bitmap 4bpp';           Value: 6),
    (Text: 'Bitmap 8bpp';           Value: 7)
  );



var
  id: integer = -1;

  // globl var to simplify the imports
  fn: string;
  W, H, BPP: integer;
  Start, Delta: integer;
  List: tListBox;
  WinPal: tWinPalette;
  png: tPNGObject;
  bmp: tBitmap;

  Spr: pSprite;
  Pic: pPicture;
  Pal: pPalette;

  // for ImportOption:
  indStart,
  indInsert,
  ColCount,
  Link: integer;
  Transparency: boolean;



//procedure HexDump(Lines: tStrings; const Data: tData; Address: integer = 0; Bank: integer = 0);
procedure HexDumpInClipBoard(const Data: tData);

procedure PrepareSpriteData(Spr: pSprite);
procedure PrepareLayerData(Layer: pLayer);
procedure PasDump(Lines: tStrings; Asset: pAsset);
procedure ExtarctPal(bmp: tBitmap; var Data: tData);

//Helpers
function GetSprMetric(Metric: integer): byte;
function GetPicBpp(pf: tPixelFormat): byte;
function IndToBpp(Ind: byte): byte;
function ModeToFmt(Mode: byte): TPixelFormat;
function ModeToCols(Mode: byte): integer;

// Imports
procedure Import4bpTile(const bmp: tBitmap; Pic: pPicture);
procedure Import4bpTile16(const bmp: tBitmap; Pic: pPicture);

procedure LoadPNG(const FileName: string);
procedure LoadBMP(const FileName: string);
function  BadBPP: boolean;
function  BadSize: boolean;
procedure GetPalette(var Data: tData);
procedure NewSprite;

procedure ImportSprite;
procedure ImportSprite2;


implementation
uses SysUtils, Dialogs, ClipBrd;


procedure HexDumpInClipBoard(const Data: tData);
  var p, n: integer;
      s: string;
begin
  n := Length(Data);
  p := 0;
  s := '';

  while p <> n do begin
    //if (p and $0F) <> 0 then s := s + ', $';
    s := s + '$' + IntToHex(Data[p], 2) + ', ';
    if (p and $0F) = $F then s := s + #13#10;
    inc(p);
  end;
  Clipboard.AsText := s;
end;


procedure PrepareSpriteData(Spr: pSprite);
begin
  Spr.Data[0] := (Spr.vAddr shr 5) and $FF;
  Spr.Data[1] := (Spr.vAddr shr 13) and $0F + (Spr.BPP shl 7);
  pWord(@Spr.Data[2])^ := Spr.X;
  pWord(@Spr.Data[4])^ := Spr.Y;
  Spr.Data[6] := Spr.hFlip + Spr.vFlip shl 1 + Spr.Z shl 2; // Collision Mask??
  Spr.Data[7] := Spr.Pal + Spr.W shl 4 + Spr.H shl 6;
end;


procedure PrepareLayerData(Layer: pLayer);
begin
  Layer.Data[0] := Layer.MapH shl 6 + Layer.MapW shl 4 + cLayMode[Layer.Mode].Value;
  Layer.Data[1] := Layer.MapBase shr 9;
  Layer.Data[2] := (Layer.TileBase shr 11) shl 2 + Layer.TileH shl 1 + Layer.TileW;
  pWord(@Layer.Data[3])^ := Layer.ScrollH and $FFF;
  pWord(@Layer.Data[5])^ := Layer.ScrollV and $FFF;
end;

procedure PasDump(Lines: tStrings; Asset: pAsset);
begin
  Lines.Add( format('  %s: array[%d] of byte absolute $%.4x;',
    [Asset.Name, Length(Asset.Data), Asset.Addr]) )
end;


// Helpers
function GetSprMetric( Metric: integer): byte;
begin
  case Metric of
    0..8: Result := 0;
    9..16: Result := 1;
    17..32: Result := 2;
    33..64: Result := 3;
    else
      ShowMessage(format('%d is not suitable for sprite Width/Height', [Metric]));
  end;
end;

function GetPicBpp(pf: tPixelFormat): byte;
begin
  case pf of
    pf1bit: Result := 0;
    pf4bit: Result := 2;
    pf8bit: Result := 3;
  end;
end;

function IndToBpp(Ind: byte): byte;
begin
  Result := 1 shl Ind;
end;

function ModeToFmt(Mode: byte): TPixelFormat;
begin
  case Mode of
       0: Result := pf8bit;
    1..3: Result := pf4bit;
    else
      ShowMessage('Unsupported mode for Pixel Format: ' + IntToStr(Mode));
  end;
end;


function ModeToCols(Mode: byte): integer;
begin
  case Mode of
       0: Result := 256;
    1..3: Result := 16;
    else
      ShowMessage('Unsupported mode for Number of Colors: ' + IntToStr(Mode));
  end;
end;


procedure ExtarctPal(bmp: tBitmap; var Data: tData);
  var i, n: integer;
      tmp: array[0 .. 255] of cardinal;
      r, g, b: cardinal;
begin
  n := Length(Data) shr 1;
  GetDIBColorTable(bmp.Canvas.Handle, 0, n, tmp[0]);
  for i := 0 to n - 1 do begin
    r := (tmp[i] shr 20) and $0F;
    g := (tmp[i] shr 12) and $0F;
    b := (tmp[i] shr 4)  and $0F;
    pWord(@Data[2*i])^ := r shl 8 + g shl 4 + b;
  end;
end;


// Imports
procedure Import4bpTile(const bmp: tBitmap; Pic: pPicture);
  type
    tBmpLine = array [0 .. 1] of integer;
    pBmpLine = ^ tBmpLine;

  var X, Y, tY, w, h: integer;
      Src: ^integer;
begin
  w := Pic.W shr 3;
  h := Pic.H shr 3;
  Src := @Pic.Data[0];

  for Y := 0 to H - 1 do
    for X := 0 to W - 1 do
      for tY := 0 to 7 do begin
        Src^ := pBmpLine(bmp.ScanLine[Y shl 3 + ty])^[X];
        inc(Src);
      end;
end;


procedure Import4bpTile16(const bmp: tBitmap; Pic: pPicture);
  type
    tBmpLine = array [0 .. 1] of int64;
    pBmpLine = ^ tBmpLine;

  var X, Y, tY, w, h: integer;
      Src: ^int64;
begin
  w := Pic.W shr 4;
  h := Pic.H shr 4;
  Src := @Pic.Data[0];

  for Y := 0 to H - 1 do
    for X := 0 to W - 1 do
      for tY := 0 to 15 do begin
        Src^ := pBmpLine(bmp.ScanLine[Y shl 4 + ty])^[X];
        inc(Src);
      end;
end;



procedure LoadPNG(const FileName: string);
begin
  png.LoadFromFile(FileName);
  W := png.Width;
  H := png.Height;
  BPP := png.Header.BitDepth;
  Start := integer(png.ScanLine[0]);
  Delta := integer(png.ScanLine[1]) - integer(png.ScanLine[0]);

  fn := ExtractFileName(FileName);
  Delete(fn, Length(fn) - 3, 4);

  FillChar(WinPal[0], SizeOf(WinPal), 0);
  GetPaletteEntries(png.Palette, 0, 1 shl BPP, WinPal);
end;

procedure LoadBMP(const FileName: string);
begin
  bmp.LoadFromFile(FileName);
  W := bmp.Width;
  H := bmp.Height;
  BPP := 0;
  if bmp.PixelFormat = pf8bit then BPP := 8;
  if bmp.PixelFormat = pf4bit then BPP := 4;
  Start := integer(bmp.ScanLine[0]);
  Delta := integer(bmp.ScanLine[1]) - integer(bmp.ScanLine[0]);

  fn := ExtractFileName(FileName);
  Delete(fn, Length(fn) - 3, 4);

  FillChar(WinPal[0], SizeOf(WinPal), 0);
  GetPaletteEntries(bmp.Palette, 0, 1 shl BPP, WinPal);
end;


function BadBPP: boolean;
begin
  Result := not (BPP in [4, 8]);
  if Result then
    ShowMessage('Unsupported pixel format. Please use only 4bpp or 8 bpp');
end;

function BadSize: boolean;
begin
  Result := (W > 64) or (H > 64);
  if Result then
    ShowMessage('Height and Width can be max 64 pixels');
end;

procedure GetPalette(var Data: tData);
  var i, n: integer;
      r, g, b: cardinal;
begin
  n := Length(Data) shr 1;
  for i := 0 to n - 1 do begin
    r := WinPal[i].R shr 4;
    g := WinPal[i].G shr 4;
    b := WinPal[i].B shr 4;
    pWord(@Data[2*i])^ := r shl 8 + g shl 4 + b;
  end;
end;

procedure NewSprite;
begin
  New(Spr);
  FillChar(Spr^, Sizeof(Spr^), 0);
  Spr.Name := fn + '_Spr';
  Spr.Kind := atSprite;
  Spr.vAddr := $F5000;
  Spr.W    := GetSprMetric(W);
  Spr.H    := GetSprMetric(H);
  Spr.BPP  := ord( BPP = 8 );
  Spr.Z    := 3;
  SetLength(Spr.Data, 8);
  List.AddItem(Spr.Name, tObject(Spr));
end;



procedure ImportSprite;
  var i, n, m: integer;
      Spr: pSprite;
      Pic: pPicture;
      Pal: pPalette;
begin
  New(Spr);
  FillChar(Spr^, Sizeof(Spr^), 0);
  Spr.Name := fn + '_Spr';
  Spr.Kind := atSprite;
  Spr.vAddr := $F5000;
  Spr.W    := GetSprMetric(W);
  Spr.H    := GetSprMetric(H);
  Spr.BPP  := ord( BPP = 8 );
  Spr.Z    := 3;
  SetLength(Spr.Data, 8);
  List.AddItem(Spr.Name, tObject(Spr));

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.W    := 1 shl (Spr.W + 3);
  Pic.H    := 1 shl (Spr.H + 3);
  Pic.Mode := ord(BPP = 4);
  n := (Pic.W * BPP) shr 3;
  m := (W * BPP) shr 3;
  SetLength(Pic.Data, Pic.H * n);
  for i := 0 to H - 1 do
    //Move(bmp.ScanLine[i]^, Pic.Data[n * i], m);
    Move( pointer(Start + i* Delta)^, Pic.Data[n * i], m);
  List.AddItem(Pic.Name, tObject(Pic));

  New(Pal);
  FillChar(Pal^, Sizeof(Pal^), 0);
  Pal.Name  := fn + '_Pal';
  Pal.Kind  := atPalette;
  Pal.vAddr := $1FA00;
  Pal.Count := 1 shl BPP;
  SetLength(Pal.Data, 2 * Pal.Count);
  GetPalette(Pal.Data);
  List.AddItem(Pal.Name, tObject(Pal));

  Spr.Link := List.Count - 1;
  Pic.Link := List.Count;
end;


procedure ImportSprite2;
  var i, j, n: integer;
      r, g, b: cardinal;
      c: byte;
begin
  NewSprite;

  New(Pic);
  FillChar(Pic^, Sizeof(Pic^), 0);
  Pic.Name := fn + '_Pic';
  Pic.Kind := atPicture;
  Pic.Link := Link;
  Pic.W    := 1 shl (Spr.W + 3);
  Pic.H    := 1 shl (Spr.H + 3);
  Pic.Mode := ord(BPP = 4);

  n := (Pic.W * BPP) shr 3;
  SetLength(Pic.Data, Pic.H * n);
  for j := 0 to H - 1 do
    for i := 0 to W - 1 do begin
      c := pByte(Start + j*Delta + i)^ ;
      if Transparency and (c=0) then Pic.Data[j*n + i] := 0
                                else Pic.Data[j*n + i] := c + indInsert;
    end;
  List.AddItem(Pic.Name, tObject(Pic));

  Pal := pointer(List.Items.Objects[Link - 1]);
  for i := indStart to ColCount - 1 do begin
    r := WinPal[i].R shr 4;
    g := WinPal[i].G shr 4;
    b := WinPal[i].B shr 4;
    pWord(@Pal.Data[2*(i + indInsert)])^ := r shl 8 + g shl 4 + b;
  end;

  Spr.Link := List.Count;
end;


end.
