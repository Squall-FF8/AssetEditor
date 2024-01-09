unit uText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain, pngextra ;

type
  TfmText = class(TForm)
    Label2: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    eName: TEdit;
    eAddress: TEdit;
    cbNoExport: TCheckBox;
    Label5: TLabel;
    eFixedLen: TEdit;
    Label6: TLabel;
    lbText: TListBox;
    eText: TEdit;
    bMoveDown: TPNGButton;
    bMoveUp: TPNGButton;
    bDelete: TPNGButton;
    procedure ControlChange(Sender: TObject);
    procedure eTextKeyPress(Sender: TObject; var Key: Char);
    procedure lbTextClick(Sender: TObject);
    procedure bDeleteClick(Sender: TObject);
    procedure bMoveDownClick(Sender: TObject);
    procedure bMoveUpClick(Sender: TObject);
  private
    procedure Refresh;
  public
    Text: pText;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
  end;

var
  fmText: TfmText;

implementation
{$R *.dfm}


procedure TfmText.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmText.SetPointer(Ptr: pointer);
  const Delimeter: char = #01;
  var i, n, l: integer;
      s: string;
begin
  Text := Ptr;

  eName.Text    := Text.Name;
  eAddress.Text := IntToHex(Text.Addr, 4);
  cbNoExport.Checked := (Text.Flags and 1) = 1;
  eFixedLen.Text     := IntToHex(Text.FixLen, 4);

  lbText.Clear;
  i := 2 * Text.Num;
  while i < length(Text.Data) do begin
    n := i;
    while Text.Data[n] <> 0 do inc(n);
    l := n - i;
    SetLength(s, l);
    Move(Text.Data[i], s[1], l);
    lbText.Items.Add(s);
    inc(i, l + 1);
  end;

  fmMain.HexDump(Text);
  fmMain.ShowPanel(atText - 1);
end;


procedure TfmText.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        Text.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := Text.Name;
      end;
     2: Text.Addr  := StrToInt('$' + eAddress.Text);
    20: Text.Flags := (Text.Flags and $FE) + ord(cbNoExport.Checked);
    21: Text.FixLen := StrToInt('$' + eFixedLen.Text);
  end;
  fmMain.HexDump(Text);
end;


procedure TfmText.eTextKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    if lbText.ItemIndex < 0 then begin
      lbText.Items.Add(eText.Text);
    end else begin
      lbText.Items[ lbText.ItemIndex ] := eText.Text;
      lbText.ItemIndex := -1;
    end;
    eText.Text := '';
    Key := #0;
    Refresh;
  end;
end;


procedure TfmText.lbTextClick(Sender: TObject);
begin
  if lbText.ItemIndex < 0 then exit;
  eText.Text := lbText.Items[ lbText.ItemIndex ];
  eText.SetFocus;
  eText.SelStart := length( eText.Text ); // to put the Carret at the end
end;


procedure TfmText.bDeleteClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbText.ItemIndex;
  if ind < 0 then exit;

  lbText.Items.Delete(ind);
  if ind < lbText.Count then
    lbText.ItemIndex := ind;
  Refresh;
end;


procedure TfmText.bMoveDownClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbText.ItemIndex;
  if (ind < 0) or (ind = (lbText.Count - 1)) then exit;
  lbText.Items.Exchange(ind, ind + 1);
  Refresh;
end;

procedure TfmText.bMoveUpClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbText.ItemIndex;
  if ind <= 0 then exit;
  lbText.Items.Exchange(ind, ind - 1);
  Refresh;
end;


procedure TfmText.Refresh;
  var i, n, l, len, addr: integer;
begin
  Text.Num := lbText.Count;
  len := Text.Num * 2;
  SetLength(Text.Data, len);

  addr := Text.Addr + len;
  for i := 0 to Text.Num - 1 do begin
    Text.Data[i] := addr and $FF;
    Text.Data[Text.Num + i] := addr shr 8;
    l := length(lbText.Items[i]) + 1;
    inc(len, l);
    inc(addr, l);
  end;
  SetLength(Text.Data, len);

  n := 2 * Text.Num;
  for i := 0 to lbText.Count - 1 do begin
    l := length(lbText.Items[i]) + 1;  // it seems Delphi adds #0 at the end of strings
    Move(lbText.Items[i][1], Text.Data[n], l);
    inc(n, l);
    //Text.Data[n] := 0;
    //inc(n);
  end;

  fmMain.HexDump(Text);
end;


end.
