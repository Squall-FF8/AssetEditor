unit dlgImportTiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngextra, ExtCtrls, StdCtrls, Spin, uCommon;

type
  TdlgImportTile = class(TForm)
    Panel1: TPanel;
    bOK: TPNGButton;
    bCancel: TPNGButton;
    Bevel1: TBevel;
    Label1: TLabel;
    seTileW: TSpinEdit;
    Label7: TLabel;
    Label2: TLabel;
    seTileH: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    seTileNum: TSpinEdit;
    lNum: TLabel;
    cbImpPal: TCheckBox;
    Image: TImage;
    Label6: TLabel;
    cbTileBPP: TComboBox;
    Label5: TLabel;
    lBytesPerTile: TLabel;
    Label8: TLabel;
    lTotalBytes: TLabel;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure ControlChange(Sender: TObject);
  private
    procedure Calc;
  public
    class function Go: boolean;
  end;

var
  dlgImportTile: TdlgImportTile;

implementation

uses StdConvs;
{$R *.dfm}


procedure TdlgImportTile.bOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TdlgImportTile.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TdlgImportTile.Calc;
  var n: integer;
begin
  seTileNum.MaxValue := (W div seTileW.Value) * (H div seTileH.Value);
  lNum.Caption := 'max ' + IntToStr(seTileNum.MaxValue);

  n := seTileW.Value * seTileH.Value * (2 shl cbTileBPP.ItemIndex) div 8;
  lBytesPerTile.Caption := format('%.d (%.2x)', [n, n]);
  n := n * seTileNum.Value;
  lTotalBytes.Caption   := format('%.d (%.2x)', [n, n]);
end;


class function TdlgImportTile.Go: boolean;
begin
  with dlgImportTile do begin
    Image.Picture.Assign(png);
    seTileW.MaxValue    := W;
    seTileH.MaxValue    := H;
    cbTileBPP.ItemIndex := BPP shr 2;
    Calc;
    seTileNum.Value     := seTileNum.MaxValue;

    Result := ShowModal = mrOK;
    if Result then begin
      tW     := seTileW.Value;
      tH     := seTileH.Value;
      tBPP   := 2 shl cbTileBPP.ItemIndex;
      ImpPal := cbImpPal.Checked;
      tNum   := seTileNum.Value
    end;
  end;
end;


procedure TdlgImportTile.ControlChange(Sender: TObject);
begin
  Calc;
end;

end.
