unit uZSM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  uCommon, uMain, pngextra ;

type
  TfmZSM = class(TForm)
    Label2: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    eName: TEdit;
    eAddress: TEdit;
    cbNoExport: TCheckBox;
    bLoadData: TPNGButton;
    Label5: TLabel;
    eFixedLen: TEdit;
    Label6: TLabel;
    procedure ControlChange(Sender: TObject);
    procedure bLoadDataClick(Sender: TObject);
  private

  public
    ZSM: pZSM;
    procedure Setup;
    procedure SetPointer(Ptr: pointer);
    procedure ParseZSM;
  end;

var
  fmZSM: TfmZSM;

implementation
{$R *.dfm}


procedure TfmZSM.Setup;
begin
  BorderStyle := bsNone;
  Parent := fmMain.panEdits;
  Align := alClient;
end;


procedure TfmZSM.SetPointer(Ptr: pointer);
begin
  ZSM := Ptr;

  eName.Text    := ZSM.Name;
  eAddress.Text := IntToHex(ZSM.Addr, 4);
  cbNoExport.Checked := (ZSM.Flags and 1) = 1;
  eFixedLen.Text     := IntToHex(ZSM.FixLen, 4);

  fmMain.HexDump(ZSM);
  fmMain.ShowPanel(atzSM - 1);
  //DrawImage;
end;


procedure TfmZSM.ControlChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
     1: begin
        ZSM.Name := eName.Text;
        fmMain.lbList.Items[fmMain.lbList.ItemIndex] := ZSM.Name;
      end;
     2: ZSM.Addr  := StrToInt('$' + eAddress.Text);
    20: ZSM.Flags := (ZSM.Flags and $FE) + ord(cbNoExport.Checked);
    21: ZSM.FixLen := StrToInt('$' + eFixedLen.Text);
  end;
  fmMain.HexDump(ZSM);
end;


procedure TfmZSM.ParseZSM;
  var p, n, i: integer;
      cmd, arg: byte;
      s: string;
begin
  with fmMain.TextBox do begin
    Clear;
    p := 0;
    s := '';
    repeat
      cmd := ZSM.Data[p];
      case cmd of
        $00..$3F: begin
          inc(p);
          arg := ZSM.Data[p];
          s := s + format('PSG %.2x: %.2x'#13#10, [cmd, arg]);
          inc(p);
         end;
        $40: begin
          inc(p);
          arg := ZSM.Data[p];
          s := s + format('EXTCMD %.2x: ', [arg shr 6]);
          n := arg and $3F;
          for i := 1 to n do
            s := s + format('%.2x ', [ ZSM.Data[p+i] ]);
          s := s + #13#10;
          inc(p, n + 1);
         end;
        $41..$7F: begin
          inc(p);
          s := s + 'Yamaha: ';
          n := cmd and $3F;  // last 6 bits are the len
          for i := 0 to n - 1 do
            s := s + format('%.2x:%.2x ',[ ZSM.Data[p + 2*i], ZSM.Data[p + 2*i +1] ]);
          inc(p, 2*n);
          s := s + #13#10
         end;
        $80: s := s + 'End of ZSM';
        $81..$FF: begin
          s := s + format('Delay:  %d ticks'#13#10, [cmd and $7F]);
          inc(p);
         end;
      else
        inc(p);
      end;
    until cmd = $80;
    Lines.Text := s;
  end;
end;


procedure TfmZSM.bLoadDataClick(Sender: TObject);
  var f, n: cardinal;
begin
  if not fmMain.dOpen.Execute then exit;

  f := CreateFile(pchar(fmMain.dOpen.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  n := GetFileSize(f, nil);
  SetLength( ZSM.Data, 16 );
  ReadFile(f, ZSM.Data[0], 16, n, nil);
  ZSM.Loop := ZSM.Data[3] + 8*ZSM.Data[4] + 16*ZSM.Data[5];

  n := GetFileSize(f, nil) - 16;
  SetLength( ZSM.Data, n);
  ReadFile(f, ZSM.Data[0], n, n, nil);
  CloseHandle(f);

  fmMain.HexDump(ZSM);
  ParseZSM;
end;

end.
