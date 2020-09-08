unit helper;

interface

uses
  System.sysutils, System.Classes, System.strutils, Winapi.Windows;

type
  NArray = array of TArray<string>;
  GArray = array of string;

function ReadNotes(const grp: String): NArray;
function ReadGroup: GArray;
procedure WriteNotes(const grp: String; Notes: NArray);
procedure WriteGroup(Group: GArray);
function MoveFileA(f1: PWideChar; f2: PWideChar;
  Replace: Boolean = False): Boolean;

implementation

uses
  main;

function SplitAtFO(const str: string; const substr: string): TArray<string>;
var
  Temp: TArray<string>;
  P: Integer;
begin
  P := Pos(substr, str);
  SetLength(Temp, 2);
  Temp[0] := Copy(str, 1, P - 1);
  Temp[1] := Copy(str, P + 1);
  Result := Temp;
end;

function ReadNotes(const grp: String): NArray;
var
  Notes: NArray;
  rstrm: Tstreamreader;
  I: Integer;
begin
  I := 0;
  if FileExists(DefaultDir + grp + '\Index.txt') then
  begin
    rstrm := Tstreamreader.create(DefaultDir + grp + '\Index.txt');
    try
      while not rstrm.endofstream do
      begin
        inc(I, 1);
        SetLength(Notes, I);
        Notes[I - 1] := SplitAtFO(rstrm.ReadLine, ':');
      end;
    finally
      rstrm.Free;
    end;
  end;
  Result := Notes;
end;

function ReadGroup: GArray;
var
  Group: GArray;
  rstrm: Tstreamreader;
  I: Integer;
begin
  I := 0;
  rstrm := Tstreamreader.create(DefaultDir + 'Index.txt');
  try
    while not rstrm.endofstream do
    begin
      inc(I, 1);
      SetLength(Group, I);
      Group[I - 1] := rstrm.ReadLine;
    end;
  finally
    rstrm.Free;
  end;
  Result := Group;
end;

procedure WriteGroup(Group: GArray);
var
  wstrm: Tstreamwriter;
  I: Integer;
begin
  wstrm := Tstreamwriter.create(DefaultDir + 'Index.txt');
  try
    for I := Low(Group) to High(Group) do
    begin
      wstrm.WriteLine(Group[I]);
    end;
  finally
    wstrm.Free;
  end;
end;

procedure WriteNotes(const grp: String; Notes: NArray);
var
  wstrm: Tstreamwriter;
  I: Integer;
begin
  wstrm := Tstreamwriter.create(DefaultDir + grp + '\Index.txt');
  try
    for I := Low(Notes) to High(Notes) do
    begin
      wstrm.WriteLine(Notes[I][0] + ':' + Notes[I][1]);
    end;
  finally
    wstrm.Free;
  end;
end;

function MoveFileA(f1: PWideChar; f2: PWideChar;
  Replace: Boolean = False): Boolean;
begin
  Result := CopyFile(f1, f2, Replace) and DeleteFile(f1);
end;

end.
