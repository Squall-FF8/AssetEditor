program AssetEditor;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uCommon in 'uCommon.pas',
  uLayer in 'uLayer.pas' {fmLayer},
  uSprite in 'uSprite.pas' {fmSprite},
  uPicture in 'uPicture.pas' {fmPicture},
  uPalette in 'uPalette.pas' {fmPalette},
  uMap in 'uMap.pas' {fmMap},
  uTiles in 'uTiles.pas' {fmTiles},
  uRAW in 'uRAW.pas' {fmRAW},
  uImportOpt in 'uImportOpt.pas' {dlgImportOption},
  uText in 'uText.pas' {fmText},
  uZSM in 'uZSM.pas' {fmZSM};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmLayer, fmLayer);
  Application.CreateForm(TfmSprite, fmSprite);
  Application.CreateForm(TfmPicture, fmPicture);
  Application.CreateForm(TfmPalette, fmPalette);
  Application.CreateForm(TfmMap, fmMap);
  Application.CreateForm(TfmTiles, fmTiles);
  Application.CreateForm(TfmRAW, fmRAW);
  Application.CreateForm(TdlgImportOption, dlgImportOption);
  Application.CreateForm(TfmText, fmText);
  Application.CreateForm(TfmZSM, fmZSM);
  Application.Run;
end.
