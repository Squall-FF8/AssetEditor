unit uPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain;

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
    procedure ControlChange(Sender: TObject);
  private

  public
    Pal: pPalette;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmPalette: TfmPalette;

implementation
{$R *.dfm}


procedure TfmPalette.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;

procedure TfmPalette.SetPointer(Ptr: pointer);
begin
  Pal := Ptr;

  eName3.Text      := Pal.Name;
  eAddress3.Text   := IntToHex(Pal.Addr, 4);
  seCount3.Value   := Pal.Count;
  eVidAddr3.Text   := IntToHex(Pal.vAddr, 5);

  fmMain.ShowPanel(2);
  HexDump(fmMain.Memo.Lines, Pal.Data, Pal.Addr);
  DrawImage;
end;


procedure TfmPalette.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Pal.Name := eName3.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Pal.Name;
      end;
     2: Pal.Addr  := StrToInt('$' + eAddress3.Text);
     3: Pal.Count := seCount3.Value;
     4: Pal.vAddr := StrToInt('$' + eVidAddr3.Text);
  end;
end;


procedure TfmPalette.DrawImage;
  const
    cX = 10;
    cY = 10;
    cW = 20;
    cH = 20;
  var i, X, Y, c, ind: integer;
begin
  with fmMain.Image.Canvas do begin
    X := cX + 16 * cW;
    Y := cX + 16 * cW;
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
      Y := cY + (i shr 4) * cH;
      Pen.Color   := clBlack;
      Brush.Color := c;
      Rectangle(X, Y, X + cW, Y + cH);
    end;
  end;
end;

end.
