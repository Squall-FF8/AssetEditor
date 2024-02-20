unit uImportOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, pngextra, ExtCtrls;

type
  TdlgImportOption = class(TForm)
    Label1: TLabel;
    seStartIndex: TSpinEdit;
    Label2: TLabel;
    seColorCount: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    seInsertIndex: TSpinEdit;
    Bevel1: TBevel;
    bOK: TPNGButton;
    bCancel: TPNGButton;
    cbPal: TComboBox;
    cbTransparency: TCheckBox;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function Go: boolean;
  end;

var
  dlgImportOption: TdlgImportOption;


implementation
{$R *.dfm}

uses uCommon;


class function TdlgImportOption.Go: boolean;
  var i: integer;
      Asset: pAsset;
begin
  with dlgImportOption do begin
    cbPal.Clear;
    for i := 0 to List.Count - 1 do begin
      Asset := pAsset(List.Items.Objects[i]);
      if Asset.Kind = atPalette then
        cbPal.AddItem(Asset.Name, tObject(i + 1));
    end;
    if cbPal.Items.Count > 0 then cbPal.ItemIndex := 0;

    Result := ShowModal = mrOK;

    Link := integer(cbPal.Items.Objects[cbPal.ItemIndex]);
    //Pal := pointer(lbList.Items.Objects[Link - 1]);
    indStart  := seStartIndex.Value;
    indInsert := seInsertIndex.Value;
    ColCount  := seColorCount.Value;
    Transparency := cbTransparency.Checked;
  end;
end;


procedure TdlgImportOption.bOKClick(Sender: TObject);
begin
  if cbPal.ItemIndex < 0 then exit;
  ModalResult := mrOk;
end;

procedure TdlgImportOption.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
