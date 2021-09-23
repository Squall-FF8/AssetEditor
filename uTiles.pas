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
    cbPic: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    eNum: TEdit;
    cbNoExport: TCheckBox;
    procedure ControlChange(Sender: TObject);
    procedure cbPicDropDown(Sender: TObject);
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
begin
  Tiles := Ptr;

  eName.Text    := Tiles.Name;
  eAddress.Text := IntToHex(Tiles.Addr, 4);
  eVidAddr.Text := IntToHex(Tiles.vAddr, 5);
  eNum.Text     := IntToStr(Tiles.Num);
  cbNoExport.Checked := (Tiles.Flags and 1) = 1;

  HexDump(fmMain.Memo.Lines, Tiles.Data, Tiles.Addr);
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
    13: begin
        Tiles.Link := integer(cbPic.Items.Objects[cbPic.ItemIndex]);
        DrawImage;
      end;
    20: Tiles.Flags := (Tiles.Flags and $FE) + ord(cbNoExport.Checked);
  end;
  HexDump(fmMain.Memo.Lines, Tiles.Data, Tiles.Addr);
end;


procedure TfmTiles.cbPicDropDown(Sender: TObject);
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


procedure TfmTiles.DrawImage;
begin
  //if Map.Link = 0 then exit;
  //fmPicture.Pic := pointer(fmMain.lbList.Items.Objects[Spr.Link - 1]);
  //fmPicture.DrawImage;
end;


end.
