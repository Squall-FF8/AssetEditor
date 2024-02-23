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
  uTile0 in 'uTile0.pas' {fmTile0},
  uRAW in 'uRAW.pas' {fmRAW},
  uImportOpt in 'uImportOpt.pas' {dlgImportOption},
  uText in 'uText.pas' {fmText},
  uZSM in 'uZSM.pas' {fmZSM},
  dlgRefactor in 'dlgRefactor.pas' {dlgRefactorOptions},
  uTiles in 'uTiles.pas' {fmTiles},
  dlgImportTiles in 'dlgImportTiles.pas' {dlgImportTile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmLayer, fmLayer);
  Application.CreateForm(TfmSprite, fmSprite);
  Application.CreateForm(TfmPicture, fmPicture);
  Application.CreateForm(TfmPalette, fmPalette);
  Application.CreateForm(TfmMap, fmMap);
  Application.CreateForm(TfmTile0, fmTile0);
  Application.CreateForm(TfmRAW, fmRAW);
  Application.CreateForm(TdlgImportOption, dlgImportOption);
  Application.CreateForm(TfmText, fmText);
  Application.CreateForm(TfmZSM, fmZSM);
  Application.CreateForm(TdlgRefactorOptions, dlgRefactorOptions);
  Application.CreateForm(TfmTiles, fmTiles);
  Application.CreateForm(TdlgImportTile, dlgImportTile);
  Application.Run;
end.
