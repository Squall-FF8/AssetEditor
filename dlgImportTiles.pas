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
    Label9: TLabel;
    cbPreset: TComboBox;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure ControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbPresetChange(Sender: TObject);
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

type
  tPreset = record
    Text: string [20]; //used in combpbpx
    W, H: integer; //tile Width/Height
    BPP:  integer;
  end;

const
  c2bpp      = 0;
  c4bpp      = 1;
  c8bpp      = 2;
  cPresetNum = 9;
  cPreset: array[0 .. cPresetNum-1] of tPreset = (
    (Text: 'Tile 8x8 in 8 bpp'; W: 8; H: 8; BPP: c8bpp),
    (Text: 'Tile 12x12 in 8 bpp'; W: 12; H: 12; BPP: c8bpp),
    (Text: 'Tile 16x16 in 8 bpp'; W: 16; H: 16; BPP: c8bpp),
    (Text: 'Tile 8x8 in 4 bpp'; W: 8; H: 8; BPP: c4bpp),
    (Text: 'Tile 12x12 in 4 bpp'; W: 12; H: 12; BPP: c4bpp),
    (Text: 'Tile 16x16 in 4 bpp'; W: 16; H: 16; BPP: c4bpp),
    (Text: 'Tile 8x8 in 2 bpp'; W: 8; H: 8; BPP: c2bpp),
    (Text: 'Tile 12x12 in 2 bpp'; W: 12; H: 12; BPP: c2bpp),
    (Text: 'Tile 16x16 in 2 bpp'; W: 16; H: 16; BPP: c2bpp)
  );


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
  lBytesPerTile.Caption := format('%.d  ($%.2x)', [n, n]);
  n := n * seTileNum.Value;
  lTotalBytes.Caption   := format('%.d  ($%.2x)', [n, n]);
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

procedure TdlgImportTile.FormCreate(Sender: TObject);
  var i: integer;
begin
  for i := 0 to cPresetNum -1 do
    cbPreset.Items.Add(cPreset[i].Text);
  cbPreset.ItemIndex := 2;
end;

procedure TdlgImportTile.cbPresetChange(Sender: TObject);
  var ind: integer;
begin
  ind := cbPreset.ItemIndex;
  if ind = -1 then exit;

  seTileH.Value := cPreset[ind].H;
  seTileW.Value := cPreset[ind].W;
  cbTileBPP.ItemIndex := cPreset[ind].BPP;
  Calc;
  seTileNum.Value := seTileNum.MaxValue;
end;

end.
