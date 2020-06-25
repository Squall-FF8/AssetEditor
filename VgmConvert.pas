unit VgmConvert;

interface

uses SysUtils;

procedure convertIntroVgm(vgm_fn: string; var binFile: File);
procedure convertLoopVgm(vgm_fn: string; var binFile: File);
procedure convertIntroLoopVgms(intro_fn: string; loop_fn: string; var binFile: File);

implementation

const VGM_LOOP_OFFSET = LongInt($1C);
const VGM_DATA_OFFSET = LongInt($34);
const DELAY_REG = Byte($02);
const DONE_REG  = Byte($04);

procedure convertVgm(vgm_fn: string; var binFile: File);
  var idata: array[1..4] of Byte;
      odata: array[1..2] of Byte;
      num32, loop_offset: LongInt;
      str: AnsiString;
      vgmFile: File;
      done: Boolean;

begin
  AssignFile(vgmFile,vgm_fn);
  Reset(vgmFile,1);
  BlockRead(vgmFile,idata,3);
  SetLength(str,3);
  str[1] := AnsiChar(idata[1]);
  str[2] := AnsiChar(idata[2]);
  str[3] := AnsiChar(idata[3]);
  if (str <> 'Vgm') then raise Exception.Create(vgm_fn + ' is not a VGM file');

  Seek(vgmFile,VGM_LOOP_OFFSET);
  BlockRead(vgmFile,idata,4);
  loop_offset := LongInt(idata[1]) or (LongInt(idata[2]) shl 8) or (LongInt(idata[3]) shl 16) or (LongInt(idata[4]) shl 24);
  loop_offset := VGM_LOOP_OFFSET + loop_offset;

  Seek(vgmFile,VGM_DATA_OFFSET);
  BlockRead(vgmFile,idata,4);
  num32 := LongInt(idata[1]) or (LongInt(idata[2]) shl 8) or (LongInt(idata[3]) shl 16) or (LongInt(idata[4]) shl 24);
  num32 := VGM_DATA_OFFSET + num32;
  Seek(vgmFile,num32);

  done := False;
  while not Eof(vgmFile) and not done do
  begin
    if FilePos(vgmFile) = loop_offset then
    begin
      odata[1] := DONE_REG;
      odata[2] := 0;
      BlockWrite(binFile,odata,2);
    end;

    BlockRead(vgmFile,idata,1);
    case idata[1] of
      $54: begin
        BlockRead(vgmFile,idata,2);
        BlockWrite(binFile,idata,2);
      end;
      $61: begin
        BlockRead(vgmFile,idata,2);
        odata[1] := DELAY_REG;
        odata[2] := Byte((LongInt(idata[1]) or (LongInt(idata[2]) shl 8)) Div 735);
        BlockWrite(binFile,odata,2);
      end;
      $62: begin
        odata[1] := DELAY_REG;
        odata[2] := 1;
        BlockWrite(binFile,odata,2);
      end;
      $66: begin
        odata[1] := DONE_REG;
        odata[2] := 0;
        BlockWrite(binFile,odata,2);
        done := True;
      end;
      $67: begin
        // skip over data block
        BlockRead(vgmFile,idata,2); // ignore fake end byte, data type
        BlockRead(vgmFile,idata,4); // read block length
        num32 := LongInt(idata[1]) or (LongInt(idata[2]) shl 8) or (LongInt(idata[3]) shl 16) or (LongInt(idata[4]) shl 24);
        num32 := FilePos(vgmFile) + num32;
        Seek(vgmFile,num32);
      end;
      $C0: begin
        // ignore Sega PCM data
        BlockRead(vgmFile,idata,3);
      end;
    end;
  end;

  CloseFile(vgmFile);
end;

procedure convertIntroVgm(vgm_fn: string; var binFile: File);
  var odata: array[1..2] of Byte;

begin
  convertVgm(vgm_fn,binFile);
  odata[1] := DONE_REG;
  odata[2] := 0;
  BlockWrite(binFile,odata,2);
end;

procedure convertLoopVgm(vgm_fn: string; var binFile: File);
  var odata: array[1..2] of Byte;

begin
  odata[1] := DONE_REG;
  odata[2] := 0;
  BlockWrite(binFile,odata,2);
  convertVgm(vgm_fn, binFile);
end;

procedure convertIntroLoopVgms(intro_fn: string; loop_fn: string; var binFile: File);
begin
  convertVgm(intro_fn, binFile);
  convertVgm(loop_fn,binFile);
end;

end.
