program AssetEditor;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uCommon in 'uCommon.pas',
  uLayer in 'uLayer.pas' {fmLayer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmLayer, fmLayer);
  Application.Run;
end.
