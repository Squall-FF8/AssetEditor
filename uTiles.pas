unit uTiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain ;

type
  TfmTiles = class(TForm)
    Label2: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    eVidAddr: TEdit;
    eName: TEdit;
    eAddress: TEdit;
    Label18: TLabel;
    cbPal: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    eNum: TEdit;
    cbNoExport: TCheckBox;
    Label5: TLabel;
    eFixedLen: TEdit;
    Label6: TLabel;
    Label31: TLabel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    seW: TSpinEdit;
    seH: TSpinEdit;
    cbPixFmt: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    seNumCols: TSpinEdit;
    Label9: TLabel;
    sePal: TSpinEdit;
    procedure ControlChange(Sender: TObject);
    procedure cbPalDropDown(Sender: TObject);
  private

  public
    Tiles: pTile;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmTiles: TfmTiles;

implementation
{$R *.dfm}

uses uPicture;


procedure TfmTiles.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmTiles.SetPointer(Ptr: pointer);
  function BPPtoIndex(BPP: byte): integer;
  begin
    Result := -1;
    case BPP of
      2: Result := 0;
      4: Result := 1;
      8: Result := 2;
    end;
  end;
begin
  Tiles := Ptr;

  eName.Text         := Tiles.Name;
  eAddress.Text      := BRAMToStr(Tiles.Addr);
  eVidAddr.Text      := IntToHex(Tiles.vAddr, 5);
  cbNoExport.Checked := (Tiles.Flags and 1) = 1;
  eFixedLen.Text     := IntToHex(Tiles.FixLen, 4);
  seW.Value          := Tiles.W;
  seH.Value          := Tiles.H;
  cbPixFmt.ItemIndex := BPPtoIndex(Tiles.BPP);
  eNum.Text          := IntToStr(Tiles.Num);
  seNumCols.MaxValue := Tiles.Num;
  seNumCols.Value    := Tiles.NumCols;

  if Tiles.Link <= 0 then cbPal.Text := ''
                     else cbPal.Text := pAsset(fmMain.lbList.Items.Objects[Tiles.Link - 1])^.Name;

  fmMain.HexDump(Tiles);
  fmMain.ShowPanel(atTile - 1);
  DrawImage;
end;


procedure TfmTiles.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Tiles.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Tiles.Name;
      end;
     2: Tiles.Addr  := StrToInt('$' + eAddress.Text);
     8: Tiles.vAddr := StrToInt('$' + eVidAddr.Text);
    10: begin
        Tiles.NumCols := seNumCols.Value;
        DrawImage;
      end;  
    13: begin
        Tiles.Link := integer(cbPal.Items.Objects[cbPal.ItemIndex]);
        DrawImage;
      end;
    14: begin
        Tiles.Ind := sePal.Value;
        DrawImage;
      end;
    20: Tiles.Flags := (Tiles.Flags and $FE) + ord(cbNoExport.Checked);
    21: Tiles.FixLen := StrToInt('$' + eFixedLen.Text);
  end;
  fmMain.HexDump(Tiles);
end;


procedure TfmTiles.cbPalDropDown(Sender: TObject);
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


procedure TfmTiles.DrawImage;
  var addr, i, j, n, Xo, Yo: integer;
      b, Mask, b1, bp, c: byte;
      Shift, Shift1: shortint;
      p: pByte;
      bmp: tBitmap;

  function BPPtoPixelFormat(BPP: byte): TPixelFormat;
  begin
    if BPP <= 4 then Result := pf4bit
                else Result := pf8bit;
    if BPP <= 4 then bp := 4
                else bp := 8;
  end;

begin
  //exit;

  bmp := tBitmap.Create;
  bmp.Width  := Tiles.W * Tiles.NumCols;
  bmp.Height := Tiles.H * ((Tiles.Num + Tiles.NumCols - 1) div Tiles.NumCols);
  bmp.PixelFormat := BPPtoPixelFormat(Tiles.BPP);

  n := 1 shl Tiles.BPP;

  if Tiles.Link = 0 then
    if Tiles.BPP = 8 then MakePal_Gray256
                     else MakePal_Gray16
  else
    MakePal_Link(pPalette(fmMain.lbList.Items.Objects[Tiles.Link - 1]).Data, Tiles.Ind, n);
  SetDIBColorTable(bmp.Canvas.Handle, 0, n, WinPal[0]);

  addr := 0;
  b := 0;
  Shift := -1;
  Mask := n - 1;
  b1 := 0;
  Shift1 := 8-bp;
  Xo := 0;
  Yo := 0;
  n  := 0;

  repeat
    for i := 0 to Tiles.H - 1 do begin
      p := bmp.ScanLine[Yo + i];
      inc(p, Xo * bp div 8);
      for j := 0 to Tiles.W - 1 do begin
        if Shift < 0 then begin
          b := Tiles.Data[addr];
          inc(addr);
          Shift := 8 - Tiles.BPP;
        end;
        c := (b shr Shift) and Mask;;
        inc(b1, c shl Shift1);
        dec(Shift1, bp);
        if Shift1 < 0 then begin
          p^ := b1;
          inc(p);
          b1 := 0;
          Shift1 := 8 - bp;
        end;
        dec(Shift, Tiles.BPP);
      end;
    end;
    inc(Xo, Tiles.W);
    if (Xo + Tiles.W) > bmp.Width then begin
      inc(Yo, Tiles.H);
      Xo := 0;
    end;
    inc(n)
  until n = Tiles.Num;


  n := 4;
  fmMain.Image.SetBounds(0, 0, n*bmp.Width, n*bmp.Height);
  fmMain.Image.Picture.Bitmap.PixelFormat := pf24bit;
  fmMain.Image.Picture.Bitmap.Width  := n*bmp.Width;
  fmMain.Image.Picture.Bitmap.Height := n*bmp.Height;
  fmMain.Image.Canvas.StretchDraw(Bounds(0, 0, n*bmp.Width, n*bmp.Height), bmp);
  bmp.Free;
end;


end.
