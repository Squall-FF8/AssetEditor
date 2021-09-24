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
    Label18: TLabel;
    cbPic: TComboBox;
    cbNoExport: TCheckBox;
    procedure ControlChange(Sender: TObject);
    procedure cbPicDropDown(Sender: TObject);
  private

  public
    Spr: pSprite;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmSprite: TfmSprite;

implementation
{$R *.dfm}

uses uPicture;


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
  cbNoExport.Checked := (Spr.Flags and 1) = 1;
  if Spr.Link > 0 then
    cbPic.Text     := pAsset(fmMain.lbList.Items.Objects[Spr.Link - 1])^.Name;

  fmMain.HexDump(Spr);
  fmMain.ShowPanel(0);
  DrawImage;
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
    13: begin
        Spr.Link := integer(cbPic.Items.Objects[cbPic.ItemIndex]);
        DrawImage;
      end;
    20: Spr.Flags := (Spr.Flags and $FE) + ord(cbNoExport.Checked);
  end;
  PrepareSpriteData(Spr);
  fmMain.HexDump(Spr);
end;


procedure TfmSprite.cbPicDropDown(Sender: TObject);
  var i: integer;
      Asset: pAsset;
begin
  cbPic.Clear;
  for i := 0 to fmMain.lbList.Count - 1 do begin
    Asset := pAsset(fmMain.lbList.Items.Objects[i]);
    if Asset.Kind = atPicture then
      cbPic.AddItem(Asset.Name, tObject(i + 1));
  end;
end;


procedure TfmSprite.DrawImage;
begin
  if Spr.Link = 0 then exit;
  fmPicture.Pic := pointer(fmMain.lbList.Items.Objects[Spr.Link - 1]);
  fmPicture.DrawImage;
end;

end.
