unit dlgRefactor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, pngextra, ExtCtrls;

type
  TdlgRefactorOptions = class(TForm)
    Label1: TLabel;
    seRAM_Bank: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    bOK: TPNGButton;
    bCancel: TPNGButton;
    eRAM_Addr: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    eVRAM: TEdit;
    Label6: TLabel;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function Go: boolean;
  end;

var
  dlgRefactorOptions: TdlgRefactorOptions;


implementation
{$R *.dfm}

uses uCommon;


class function TdlgRefactorOptions.Go: boolean;
  var v: integer;
begin
  with dlgRefactorOptions do begin
    seRAM_Bank.Value := Header.RAM.Bank;
    eRAM_Addr.Text   := IntToHex(Header.RAM.Addr, 4);
    eVRAM.Text := IntToStr(Header.VRAM.Bank) + IntToHex(Header.VRAM.Addr, 4);

    Result := ShowModal = mrOK;
    if Result then begin
      Header.RAM.Bank := seRAM_Bank.Value;
      Header.RAM.Addr := StrToInt('$' + eRAM_Addr.Text);
      v := StrToInt('$' + eVRAM.Text);
      Header.VRAM.Bank := v shr 16;
      Header.VRAM.Addr := v and $FFFF;
    end;
  end;
end;


procedure TdlgRefactorOptions.bOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TdlgRefactorOptions.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
