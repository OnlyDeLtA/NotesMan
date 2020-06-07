unit helper;


interface
uses
System.sysutils,System.Classes,System.strutils, Winapi.Windows;

type
NArray= array of TArray<string>;
GArray=array of string;

function ReadNotes(const grp: String): NArray;
function ReadGroup: GArray;
procedure WriteNotes(const grp: String; Notes: NArray);
procedure WriteGroup(Group: GArray);
function MoveFileA(f1: PWideChar; f2: PWideChar; Replace:Boolean=False): Boolean;

implementation

function SplitAtFO(const str: string; const substr: string): TArray<string>;
var
Temp: TArray<string>;
P: Integer;
begin
P:=Pos(substr,str);
SetLength(Temp,2);
Temp[0]:=Copy(str,1,P-1);
Temp[1]:=Copy(str,P+1);
Result:=Temp;
end;

function ReadNotes(const grp: String): NArray;
var
notes : NArray;
rstrm: Tstreamreader;
I: Integer;
begin
I:=0;
if FileExists('Notes\'+grp+'\Index.txt') then
begin
rstrm:=Tstreamreader.create('Notes\'+grp+'\Index.txt');
try
while not rstrm.endofstream do
begin
inc(I,1);
Setlength(notes,I);
notes[I-1]:=SplitAtFO(rstrm.ReadLine,':');
end;
finally
rstrm.Free;
end;
end;
Result:=notes;
end;

function ReadGroup : GArray;
var
group : GArray;
rstrm: Tstreamreader;
I: Integer;
begin
I:=0;
rstrm:=Tstreamreader.create('Notes\Index.txt');
try
while not rstrm.endofstream do
begin
inc(I,1);
Setlength(group,I);
group[I-1]:=rstrm.readline;
end;
finally
rstrm.Free;
end;
Result:=group;
end;

procedure WriteGroup(Group: GArray);
var
wstrm: Tstreamwriter;
I: Integer;
begin
wstrm:= TStreamWriter.Create('Notes\Index.txt');
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
wstrm:=TStreamWriter.Create('Notes\'+grp+'\Index.txt');
try
for I := Low(Notes) to High(Notes) do
  begin
  wstrm.WriteLine(Notes[I][0]+':'+Notes[I][1]);
  end;
finally
wstrm.Free;
end;
end;

function MoveFileA(f1: PWideChar; f2: PWideChar; Replace:Boolean=False): Boolean;
begin
Result:=CopyFile(f1,f2,Replace) and DeleteFile(f1);
end;

end.
