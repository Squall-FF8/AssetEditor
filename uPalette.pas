unit uPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain, pngextra, ExtCtrls;

type
  TfmPalette = class(TForm)
    seCount3: TSpinEdit;
    Label45: TLabel;
    Label44: TLabel;
    Label42: TLabel;
    Label34: TLabel;
    Label33: TLabel;
    Label32: TLabel;
    eVidAddr3: TEdit;
    eName3: TEdit;
    eAddress3: TEdit;
    bAppPal: TPNGButton;
    pAddPal: TPanel;
    lPal: TLabel;
    cbPal: TComboBox;
    bClose: TPNGButton;
    Panel1: TPanel;
    Label1: TLabel;
    seRed: TSpinEdit;
    Label2: TLabel;
    seGreen: TSpinEdit;
    Label3: TLabel;
    seBlue: TSpinEdit;
    Label4: TLabel;
    eColHex: TEdit;
    shColor: TShape;
    bDeletePal: TPNGButton;
    cbNoExport: TCheckBox;
    procedure ControlChange(Sender: TObject);
    procedure bAppPalClick(Sender: TObject);
    procedure cbPalCloseUp(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure ColorChange(Sender: TObject);
    procedure eColHexChange(Sender: TObject);
    procedure bDeletePalClick(Sender: TObject);
  private
    ColID: integer;
  public
    Pal: pPalette;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
    procedure SetColor(_ColID: integer);
    procedure DrawSelection;
    procedure ExchangePals(Src, Dst: integer);
  end;

var
  fmPalette: TfmPalette;

  function XYtoCol(X, Y: integer): integer;

implementation
{$R *.dfm}


const
  cX = 10;
  cY = 10;
  cW = 20;
  cH = 20;


function XYtoCol(X, Y: integer): integer;
begin
  Result := ((X - cX) div cW) + ((Y - cY) div cH) shl 4;
end;


procedure TfmPalette.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;

procedure TfmPalette.SetPointer(Ptr: pointer);
begin
  Pal := Ptr;
//  SetColor(0);

  eName3.Text      := Pal.Name;
  eAddress3.Text   := IntToHex(Pal.Addr, 4);
  seCount3.Value   := Pal.Count;
  eVidAddr3.Text   := IntToHex(Pal.vAddr, 5);
  cbNoExport.Checked := (Pal.Flags and 1) = 1;

  SetColor(0);
  fmMain.ShowPanel(2);
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
  //DrawImage;
end;


procedure TfmPalette.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Pal.Name := eName3.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Pal.Name;
      end;
     2: Pal.Addr  := StrToInt('$' + eAddress3.Text);
     3: if seCount3.Value <> 0 then begin
        Pal.Count := seCount3.Value;
        SetLength(Pal.Data, 2 * Pal.Count);
      end;
     4: Pal.vAddr := StrToInt('$' + eVidAddr3.Text);
    20: Pal.Flags := (Pal.Flags and $FE) + ord(cbNoExport.Checked);
  end;
end;


procedure TfmPalette.DrawImage;
  var i, X, Y, c, ind: integer;
begin
  with fmMain.Image.Canvas do begin
    X := 2*cX + 16 * cW;
    Y := 2*cY + 16 * cW;
    fmMain.Image.SetBounds(0, 0, X, Y);
    fmMain.Image.Picture.Bitmap.PixelFormat := pf24bit;
    fmMain.Image.Picture.Bitmap.Width  := X;
    fmMain.Image.Picture.Bitmap.Height := Y;

    Pen.Color   := cTransCol;
    Brush.Color := cTransCol;
    Rectangle(0, 0, X, Y);

    for i := 0 to Pal.Count-1 do begin
      ind := 2*i;
      c := (Pal.Data[ind + 1] and $0F) shl 4 +
           (Pal.Data[ind] and $F0) shl 8 +
           (Pal.Data[ind ] and $0F) shl 20;
      X := cX + (i and $F) * cW;
      Y := cY + (i shr 4)  * cH;
      Pen.Color   := clBlack;
      Brush.Color := c;
      Rectangle(X, Y, X + cW +1, Y + cH+1);
    end;
  end;

  DrawSelection;
end;

procedure TfmPalette.bAppPalClick(Sender: TObject);
  var i: integer;
      Asset: pAsset;
begin
  cbPal.Clear;
  for i := 0 to fmMain.lbList.Count - 1 do begin
    Asset := pAsset(fmMain.lbList.Items.Objects[i]);
    if (Asset.Kind = atPalette) and (pPalette(Asset) <> Pal) then
      cbPal.AddItem(Asset.Name, tObject(Asset));
  end;

  pAddPal.Visible  := true;
end;


procedure TfmPalette.cbPalCloseUp(Sender: TObject);
  var i, ind: integer;
      SrcPal: pPalette;
begin
  ind := cbPal.ItemIndex;
  if ind < 0 then exit;


  SrcPal := pPalette( cbPal.Items.Objects[ind] );
  ind := 2* Pal.Count;
  seCount3.Value := Pal.Count + SrcPal.Count;
  for i := 0 to 2*SrcPal.Count - 1 do
    Pal.Data[ind + i] := SrcPal.Data[i];

  pAddPal.Visible  := false;
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
  DrawImage;
end;

procedure TfmPalette.bCloseClick(Sender: TObject);
begin
  pAddPal.Visible := false;
end;


procedure TfmPalette.SetColor(_ColID: integer);
  var col: integer;
begin
  if _ColID >= Pal.Count then exit;
  ColID := _ColID;
  col := pWord(@Pal.Data[2 * ColID])^;
  eColHex.Text  := IntToHex(col, 3);
  seRed.Value   := col shr 8;
  seGreen.Value := (col shr 4) and $0F;
  seBlue.Value  := col and $0F;
  shColor.Brush.Color := seRed.Value shl 4 + seGreen.Value shl 12 + seBlue.Value shl 20;
  DrawImage;
end;


procedure TfmPalette.DrawSelection;
  var Xo, Yo: integer;
begin
  with fmMain.Image.Canvas do begin
    Brush.Style := bsClear;
    Xo := (ColID and $0F) * cW + cX;
    Yo := (ColID shr 4) * cH + cY;

    Pen.Color := $0;
    Rectangle(Bounds(Xo+2, Yo+2, cW-3,cH-3));
    Rectangle(Bounds(cX-2, Yo-2, cW*16+5, cH+5));
    //Rectangle(Bounds(cX+2, Yo+2, cW*16-4, cH-4));

    Pen.Color := $FFFFFF;
    Rectangle(Bounds(Xo+1, Yo+1, cW-1, cH-1));
    Rectangle(Bounds(cX-1, Yo-1, cW*16+3, cH+3));
  end;
end;


procedure TfmPalette.ColorChange(Sender: TObject);
  var col: integer;
begin
  if (seBlue.Text = '') or (seGreen.Text = '') or (seRed.Text = '') then exit;
  col := seBlue.Value + seGreen.Value shl 4 + seRed.Value shl 8;
  pWord(@Pal.Data[2 * ColID])^ := col;
  eColHex.Text := IntToHex(col, 3);
  shColor.Brush.Color := seRed.Value shl 4 + seGreen.Value shl 12 + seBlue.Value shl 20;
  DrawImage;
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
end;

procedure TfmPalette.eColHexChange(Sender: TObject);
  var col: integer;
begin
  if eColHex.Text = '' then exit;
  col := StrToIntDef('$' + eColHex.Text, 0);
  pWord(@Pal.Data[2 * ColID])^ := col;
  shColor.Brush.Color := (col shr 8) shl 4 + ((col shr 4) and $F) shl 12 + (col and $F) shl 20;
  DrawImage;
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
end;


procedure TfmPalette.ExchangePals(Src, Dst: integer);
  var i: integer;
      t: byte;
begin
  Src := Src shl 5;
  Dst := Dst shl 5;
  for i := 0 to 31 do begin
    t := Pal.Data[Src + i];
    Pal.Data[Src + i] := Pal.Data[Dst + i];
    Pal.Data[Dst + i] := t;
  end;

  //DrawImage;
  SetColor(ColID);
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
end;


procedure TfmPalette.bDeletePalClick(Sender: TObject);
  var ind: integer;
begin
  if ColID >= Pal.Count then exit;
  ind := ColID and $FFF0;

  if (ColID + 16) < Pal.Count then
    Move(Pal.Data[2*ind + 32], Pal.Data[2*ind], (Pal.Count-ind-16)*2)
  else
    Dec(ColID, 16);
  seCount3.Value := Pal.Count - 16;
  //SetLength(Pal.Data, Pal.Count - 32);

  SetColor(ColID);
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
end;

end.
