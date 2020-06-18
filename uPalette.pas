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

end.
