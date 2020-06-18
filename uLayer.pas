unit uLayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain;

type
  TfmLayer = class(TForm)
    seVScroll4: TSpinEdit;
    seHScroll4: TSpinEdit;
    Label61: TLabel;
    Label60: TLabel;
    Label59: TLabel;
    Label58: TLabel;
    Label57: TLabel;
    Label56: TLabel;
    Label55: TLabel;
    Label54: TLabel;
    Label53: TLabel;
    Label52: TLabel;
    Label51: TLabel;
    Label50: TLabel;
    Label49: TLabel;
    Label48: TLabel;
    Label47: TLabel;
    Label46: TLabel;
    Label43: TLabel;
    Label41: TLabel;
    Label40: TLabel;
    Label39: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    eVidAddr4: TEdit;
    eTileBase4: TEdit;
    eName4: TEdit;
    eMapBase4: TEdit;
    eAddress4: TEdit;
    cbVidMode4: TComboBox;
    cbTileW4: TComboBox;
    cbTileH4: TComboBox;
    cbMapW4: TComboBox;
    cbMapH4: TComboBox;
    cbEnabled4: TCheckBox;
    procedure ControlChange(Sender: TObject);
  private
    { Private declarations }
  public
    Lay: pLayer;
    procedure SetPointer(Ptr: pointer);
    procedure Setup;
  end;

var
  fmLayer: TfmLayer;

implementation
{$R *.dfm}


procedure TfmLayer.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Top := 0;
  Left := 0;
  Align := alClient;
end;


procedure TfmLayer.SetPointer(Ptr: pointer);
begin
  Lay := Ptr;

  eName4.Text          := Lay.Name;
  eAddress4.Text       := IntToHex(Lay.Addr, 4);
  cbVidMode4.ItemIndex := Lay.Mode;
  cbTileH4.ItemIndex   := Lay.TileH;
  cbTileW4.ItemIndex   := Lay.TileW;
  cbMapH4.ItemIndex    := Lay.MapH;
  cbMapW4.ItemIndex    := Lay.MapW;
  eTileBase4.Text      := IntToHex(Lay.TileBase, 5);
  eMapBase4.Text       := IntToHex(Lay.MapBase, 5);
  seHScroll4.Value     := Lay.ScrollH;
  seVScroll4.Value     := Lay.ScrollV;
  eVidAddr4.Text       := IntToHex(Lay.vAddr, 5);
  cbEnabled4.Checked   := Lay.Enable = 1;
end;


procedure TfmLayer.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Lay.Name := eName4.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Lay.Name;
      end;
     2: Lay.Addr := StrToInt('$' + eAddress4.Text);
     3: Lay.Mode := cbVidMode4.ItemIndex;
     4: Lay.TileH := cbTileH4.ItemIndex;
     5: Lay.TileW := cbTileW4.ItemIndex;
     6: Lay.MapH := cbMapH4.ItemIndex;
     7: Lay.MapW := cbMapW4.ItemIndex;
     8: Lay.TileBase := StrToInt('$' + eTileBase4.Text);
     9: Lay.MapBase  := StrToInt('$' + eMapBase4.Text);
    10: Lay.ScrollH  := seHScroll4.Value;
    11: Lay.ScrollV  := seVScroll4.Value;
    12: Lay.vAddr    := StrToInt('$' + eVidAddr4.Text);
    13: Lay.Enable   := ord(cbEnabled4.Checked);
  end;

  PrepareLayerData(Lay);
end;

end.
