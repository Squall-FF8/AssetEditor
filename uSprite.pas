unit uSprite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain ;

type
  TfmSprite = class(TForm)
    seY: TSpinEdit;
    seX: TSpinEdit;
    sePal: TSpinEdit;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    eVidAddr: TEdit;
    eName: TEdit;
    eAddress: TEdit;
    cbZ: TComboBox;
    cbW: TComboBox;
    cbVFlip: TCheckBox;
    cbMode: TComboBox;
    cbHFlip: TCheckBox;
    cbH: TComboBox;
    procedure ControlChange(Sender: TObject);
  private

  public
    Spr: pSprite;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
  end;

var
  fmSprite: TfmSprite;

implementation
{$R *.dfm}


procedure TfmSprite.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmSprite.SetPointer(Ptr: pointer);
begin
  Spr := Ptr;

  eName.Text    := Spr.Name;
  eAddress.Text := IntToHex(Spr.Addr, 4);
  seX.Value     := Spr.X;
  seY.Value     := Spr.Y;
  cbW.ItemIndex := Spr.W;
  cbH.ItemIndex := Spr.H;
  cbMode.ItemIndex := Spr.BPP;
  cbZ.ItemIndex    := Spr.Z;
  eVidAddr.Text    := IntToHex(Spr.vAddr, 5);
  sePal.Value      := Spr.Pal;
  cbHFlip.Checked  := Spr.hFlip = 1;
  cbVFlip.Checked  := Spr.vFlip = 1;

  HexDump(fmMain.Memo.Lines, Spr.Data, Spr.Addr);
  fmMain.ShowPanel(0);
end;


procedure TfmSprite.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Spr.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Spr.Name;
      end;
     2: Spr.Addr := StrToInt('$' + eAddress.Text);
     3: Spr.X := seX.Value;
     4: Spr.Y := seY.Value;
     5: Spr.W := cbW.ItemIndex;
     6: Spr.H := cbH.ItemIndex;
     7: Spr.BPP := cbMode.ItemIndex;
     8: Spr.vAddr := StrToInt('$' + eVidAddr.Text);
     9: Spr.Z := cbZ.ItemIndex;
    10: Spr.Pal := sePal.Value;
    11: Spr.hFlip := ord(cbHFlip.Checked);
    12: Spr.vFlip := ord(cbVFlip.Checked);
  end;
  PrepareSpriteData(Spr);
  HexDump(fmMain.Memo.Lines, Spr.Data, Spr.Addr);
end;

end.
