program AssetEditor;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uCommon in 'uCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
