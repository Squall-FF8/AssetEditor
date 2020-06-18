unit uPicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain;

type
  TfmPicture = class(TForm)
    seY2: TSpinEdit;
    seX2: TSpinEdit;
    seW2: TSpinEdit;
    seH2: TSpinEdit;
    Label36: TLabel;
    Label31: TLabel;
    Label30: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    Label27: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    eVidAddr2: TEdit;
    eName2: TEdit;
    eAddress2: TEdit;
    cbPicFmt2: TComboBox;
    cbBpp2: TComboBox;
    procedure ControlChange(Sender: TObject);
  private

  public
    Pic: pPicture;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
  end;

var
  fmPicture: TfmPicture;

implementation
{$R *.dfm}


procedure TfmPicture.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmPicture.SetPointer(Ptr: pointer);
begin
  Pic := Ptr;

  eName2.Text         := Pic.Name;
  eAddress2.Text      := IntToHex(Pic.Addr, 4);
  seX2.Value          := Pic.X;
  seY2.Value          := Pic.Y;
  seW2.Value          := Pic.W;
  seH2.Value          := Pic.H;
  cbBpp2.ItemIndex    := Pic.BPP;
  cbPicFmt2.ItemIndex := Pic.Mode;
  eVidAddr2.Text      := IntToHex(Pic.vAddr, 5);

  fmMain.ShowPanel(1);
  HexDump(fmMain.Memo.Lines, Pic.Data, Pic.Addr);
end;


procedure TfmPicture.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Pic.Name := eName2.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Pic.Name;
      end;
     2: Pic.Addr  := StrToInt('$' + eAddress2.Text);
     3: Pic.X     := seX2.Value;
     4: Pic.Y     := seY2.Value;
     5: Pic.W     := seW2.Value;
     6: Pic.H     := seH2.Value;
     7: Pic.BPP   := cbBpp2.ItemIndex;
     8: Pic.Mode  := cbPicFmt2.ItemIndex;
     9: Pic.vAddr := StrToInt('$' + eVidAddr2.Text);
  end;
end;

end.
