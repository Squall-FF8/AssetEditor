unit uPicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain;

type
  TfmPicture = class(TForm)
    seY2: TSpinEdit;
    seX2: TSpinEdit;
    seW2: TSpinEdit;
    seH2: TSpinEdit;
    Label31: TLabel;
    Label30: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    eVidAddr2: TEdit;
    eName2: TEdit;
    eAddress2: TEdit;
    cbPixFmt: TComboBox;
    cbPal: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    sePal: TSpinEdit;
    procedure ControlChange(Sender: TObject);
    procedure cbPalDropDown(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetBit8bpp(bmp: tBitmap);
    procedure SetBit4bpp(bmp: tBitmap);
    procedure SetBit4bpTile8(const bmp: tBitmap);
    procedure SetBit4bpTile16(const bmp: tBitmap);
  public
    Pic: pPicture;
    Pal: pPalette;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmPicture: TfmPicture;

implementation
{$R *.dfm}


procedure TfmPicture.FormCreate(Sender: TObject);
  var i: integer;
begin
  for i := 0 to cTmplNum do
    cbPixFmt.Items.Add(cTemplate[i].Name);
end;


procedure TfmPicture.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmPicture.SetPointer(Ptr: pointer);
begin
  Pal := nil;
  Pic := Ptr;

  eName2.Text         := Pic.Name;
  eAddress2.Text      := IntToHex(Pic.Addr, 4);
  seX2.Value          := Pic.X;
  seY2.Value          := Pic.Y;
  seW2.Value          := Pic.W;
  seH2.Value          := Pic.H;
  //cbBpp2.ItemIndex    := Pic.BPP;
  cbPixFmt.ItemIndex  := Pic.Mode;
  eVidAddr2.Text      := IntToHex(Pic.vAddr, 5);
  sePal.Value         := Pic.Ind;
  if Pic.Link <= 0 then cbPal.Text := ''
                   else cbPal.Text := pAsset(fmMain.lbList.Items.Objects[Pic.Link - 1])^.Name;

  fmMain.ShowPanel(1);
  HexDump(fmMain.Memo.Lines, Pic.Data, Pic.Addr);
  DrawImage;
end;


procedure TfmPicture.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Pic.Name := eName2.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Pic.Name;
      end;
     2: Pic.Addr  := StrToInt('$' + eAddress2.Text);
     3: Pic.X     := seX2.Value;
     4: Pic.Y     := seY2.Value;
     5: Pic.W     := seW2.Value;
     6: Pic.H     := seH2.Value;
     //7: Pic.BPP   := cbBpp2.ItemIndex;
     8: Pic.Mode  := cbPixFmt.ItemIndex;
     9: Pic.vAddr := StrToInt('$' + eVidAddr2.Text);
    10: begin
        Pic.Link := integer(cbPal.Items.Objects[cbPal.ItemIndex]);
        Pal := pointer(fmMain.lbList.Items.Objects[Pic.Link - 1]);
        sePal.MaxValue := Pal.Count shr 4 - 1;
        DrawImage;
      end;
    11: begin
        Pic.Ind := sePal.Value;
        DrawImage;
      end;
  end;
end;


procedure TfmPicture.DrawImage;
  var i, j, n: integer;
      tmp: array[0..255] of cardinal;
      bmp: tBitmap;
begin

  bmp := tBitmap.Create;
  bmp.Width  := Pic.W;
  bmp.Height := Pic.H;
  bmp.PixelFormat := ModeToFmt(Pic.Mode);

  j := ModeToCols(Pic.Mode);
  n := Pic.Ind shl 5;
  if Pic.Link = 0 then
    if j = 256 then
      for i := 0 to 255 do
        tmp[i] := i + i shl 8 + i shl 16
    else
      for i := 0 to 15 do
        tmp[i] := (i*16+i) + (i*16+i) shl 8 + (i*16+i) shl 16
  else begin
    Pal := pointer(fmMain.lbList.Items.Objects[Pic.Link - 1]);
    for i := 0 to j - 1 do
      tmp[i] := (Pal.Data[2*i + n] and $0F) shl 4 +
                (Pal.Data[2*i + n] and $F0) shl 8 +
                (Pal.Data[2*i+1 + n] and $0F) shl 20;
    end;

  //tmp[0] := ColorToRGB(cTransCol);
  SetDIBColorTable(bmp.Canvas.Handle, 0, j, tmp[0]);

  case Pic.Mode of
    0: SetBit8bpp(bmp);
    1: SetBit4bpp(bmp);
    2: SetBit4bpTile8(bmp);
    3: SetBit4bpTile16(bmp);
  end;

  fmMain.Image.SetBounds(0, 0, 2*Pic.W, 2*Pic.H);
  fmMain.Image.Picture.Bitmap.PixelFormat := pf24bit;
  fmMain.Image.Picture.Bitmap.Width  := 2*Pic.W;
  fmMain.Image.Picture.Bitmap.Height := 2*Pic.H;
  fmMain.Image.Canvas.StretchDraw(Bounds(0, 0, 2*Pic.W, 2*Pic.H), bmp);
  bmp.Free;
end;


procedure TfmPicture.cbPalDropDown(Sender: TObject);
  var i: integer;
      Asset: pAsset;
begin
  cbPal.Clear;
  for i := 0 to fmMain.lbList.Count - 1 do begin
    Asset := pAsset(fmMain.lbList.Items.Objects[i]);
    if Asset.Kind = atPalette then
      cbPal.AddItem(Asset.Name, tObject(i + 1));
  end;
end;


procedure TfmPicture.SetBit8bpp(bmp: tBitmap);
  var i, j: integer;
      s, p: pByte;
begin
  s := @Pic.Data[0];
  for i := 0 to Pic.H - 1 do begin
    p := bmp.ScanLine[i];
    for j := 0 to Pic.W - 1 do begin
      p^ := s^;
      inc(p);
      inc(s);
    end;
  end;
end;

procedure TfmPicture.SetBit4bpp(bmp: tBitmap);
  var i, j: integer;
      s, p: pByte;
begin
  s := @Pic.Data[0];
  for i := 0 to Pic.H - 1 do begin
    p := bmp.ScanLine[i];
    for j := 0 to Pic.W shr 1 - 1 do begin
      p^ := s^;
      inc(p);
      inc(s);
    end;
  end;
end;


procedure TfmPicture.SetBit4bpTile8(const bmp: tBitmap);
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
        pBmpLine(bmp.ScanLine[Y shl 3 + ty])^[X] := Src^;
        inc(Src);
      end;
end;


procedure TfmPicture.SetBit4bpTile16(const bmp: tBitmap);
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
        pBmpLine(bmp.ScanLine[Y shl 4 + ty])^[X] := Src^;
        inc(Src);
      end;
end;


end.
