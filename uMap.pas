unit uMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain ;

type
  TfmMap = class(TForm)
    sePal: TSpinEdit;
    Label2: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    eVidAddr: TEdit;
    eName: TEdit;
    eAddress: TEdit;
    Label18: TLabel;
    cbPic: TComboBox;
    Label24: TLabel;
    seW: TSpinEdit;
    Label25: TLabel;
    Label26: TLabel;
    seH: TSpinEdit;
    Label27: TLabel;
    cbNoExport: TCheckBox;
    procedure ControlChange(Sender: TObject);
    procedure cbPicDropDown(Sender: TObject);
  private
    procedure ChangePal;
  public
    Map: pMap;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmMap: TfmMap;

implementation
{$R *.dfm}

uses uPicture;


procedure TfmMap.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmMap.SetPointer(Ptr: pointer);
begin
  Map := Ptr;

  eName.Text    := Map.Name;
  eAddress.Text := IntToHex(Map.Addr, 4);
  seW.Value     := Map.W;
  seH.Value     := Map.H;
  eVidAddr.Text    := IntToHex(Map.vAddr, 5);
  sePal.Value      := Map.Pal;
  cbNoExport.Checked := (Map.Flags and 1) = 1;

  //cbPic.Text       := pAsset(fmMain.lbList.Items.Objects[Spr.Link - 1])^.Name;

  HexDump(fmMain.Memo.Lines, Map.Data, Map.Addr);
  fmMain.ShowPanel(atMap - 1);
  DrawImage;
end;


procedure TfmMap.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Map.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Map.Name;
      end;
     2: Map.Addr  := StrToInt('$' + eAddress.Text);
     5: Map.W     := seW.Value;
     6: Map.H     := seH.Value;
     8: Map.vAddr := StrToInt('$' + eVidAddr.Text);
    10: begin
        Map.Pal   := sePal.Value;
        ChangePal;
      end;
    13: begin
        Map.Link := integer(cbPic.Items.Objects[cbPic.ItemIndex]);
        DrawImage;
      end;
    20: Map.Flags := (Map.Flags and $FE) + ord(cbNoExport.Checked);
  end;
  //PrepareSpriteData(Spr);
  HexDump(fmMain.Memo.Lines, Map.Data, Map.Addr);
end;


procedure TfmMap.cbPicDropDown(Sender: TObject);
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


procedure TfmMap.DrawImage;
begin
  //if Map.Link = 0 then exit;
  //fmPicture.Pic := pointer(fmMain.lbList.Items.Objects[Spr.Link - 1]);
  //fmPicture.DrawImage;
end;


procedure TfmMap.ChangePal;
  var i: integer;
begin
  for i := 0 to Map.W * Map.H - 1 do
    Map.Data[2*i + 1] := Map.Data[2*i + 1] and $0F + Map.Pal shl 4;
end;

end.
