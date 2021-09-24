unit uRAW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain, pngextra ;

type
  TfmRAW = class(TForm)
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
    cbNoExport: TCheckBox;
    bLoadData: TPNGButton;
    procedure ControlChange(Sender: TObject);
    procedure cbPicDropDown(Sender: TObject);
    procedure bLoadDataClick(Sender: TObject);
  private

  public
    RAW: pAsset;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure DrawImage;
  end;

var
  fmRAW: TfmRAW;

implementation
{$R *.dfm}

uses uPicture;


procedure TfmRAW.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmRAW.SetPointer(Ptr: pointer);
begin
  RAW := Ptr;

  eName.Text    := RAW.Name;
  eAddress.Text := IntToHex(RAW.Addr, 4);
  eVidAddr.Text := IntToHex(RAW.vAddr, 5);
  cbNoExport.Checked := (RAW.Flags and 1) = 1;

  fmMain.HexDump(RAW);
  fmMain.ShowPanel(atRaw - 1);
  DrawImage;
end;


procedure TfmRAW.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        RAW.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := RAW.Name;
      end;
     2: RAW.Addr  := StrToInt('$' + eAddress.Text);
     8: RAW.vAddr := StrToInt('$' + eVidAddr.Text);
    13: begin
        RAW.Link := integer(cbPic.Items.Objects[cbPic.ItemIndex]);
        DrawImage;
      end;
    20: RAW.Flags := (RAW.Flags and $FE) + ord(cbNoExport.Checked);
  end;
  fmMain.HexDump(RAW);
end;


procedure TfmRAW.cbPicDropDown(Sender: TObject);
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


procedure TfmRAW.DrawImage;
begin
  //if Map.Link = 0 then exit;
  //fmPicture.Pic := pointer(fmMain.lbList.Items.Objects[Spr.Link - 1]);
  //fmPicture.DrawImage;
end;


procedure TfmRAW.bLoadDataClick(Sender: TObject);
  var f, n: cardinal;
begin
  if not fmMain.dOpen.Execute then exit;

  SetLength( RAW.Data, 0 );
  f := CreateFile(pchar(fmMain.dOpen.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  n := GetFileSize(f, nil);
  SetLength( Raw.Data, n);
  ReadFile(f, RAW.Data[0], n, n, nil);
  CloseHandle(f);

  fmMain.HexDump(RAW);
end;

end.
