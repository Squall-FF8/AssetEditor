program AssetEditor;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uCommon in 'uCommon.pas',
  uLayer in 'uLayer.pas' {fmLayer},
  uSprite in 'uSprite.pas' {fmSprite},
  uPicture in 'uPicture.pas' {fmPicture},
  uPalette in 'uPalette.pas' {fmPalette};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmLayer, fmLayer);
  Application.CreateForm(TfmSprite, fmSprite);
  Application.CreateForm(TfmPicture, fmPicture);
  Application.CreateForm(TfmPalette, fmPalette);
  Application.Run;
end.
