unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.strutils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ComCtrls, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.ToolWin,
  Vcl.StdActns, Vcl.Menus, Vcl.ActnList, System.Actions, editorshow,System.IniFiles,
  System.Win.TaskbarCore, Vcl.Taskbar, IOUtils, helper, setting, Vcl.AppEvnts,ShellApi, System.UItypes;

type
  TNotesManMF = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    lv1: TListView;
    tlb1: TToolBar;
    mm1: TMainMenu;
    il1: TImageList;
    File1: TMenuItem;
    Options1: TMenuItem;
    Help1: TMenuItem;
    Addanewgroup1: TMenuItem;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    Taskbar1: TTaskbar;
    pm1: TPopupMenu;
    btn12: TButtonedEdit;
    Addnote1: TMenuItem;
    Deletenote1: TMenuItem;
    Removegroup1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Viewnote1: TMenuItem;
    Preferences1: TMenuItem;
    AboutNotesMan1: TMenuItem;
    btn13: TToolButton;
    btn14: TToolButton;
    trycn1: TTrayIcon;
    pm2: TPopupMenu;
    ShowWindow1: TMenuItem;
    AddNote2: TMenuItem;
    N3: TMenuItem;
    Exit2: TMenuItem;
    AddfromClipboardd1: TMenuItem;
    N4: TMenuItem;
    GithubPage1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure lv1DblClick(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn3Click(Sender: TObject);
    procedure btn12Change(Sender: TObject);
    procedure btn12RightButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure lv1Data(Sender: TObject; Item: TListItem);
    procedure Exit1Click(Sender: TObject);
    procedure Addnote1Click(Sender: TObject);
    procedure Deletenote1Click(Sender: TObject);
    procedure Addanewgroup1Click(Sender: TObject);
    procedure Removegroup1Click(Sender: TObject);
    procedure Viewnote1Click(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure ShowWindow1Click(Sender: TObject);
    procedure AddNote2Click(Sender: TObject);
    procedure AddfromClipboardd1Click(Sender: TObject);
    procedure GithubPage1Click(Sender: TObject);
    procedure AboutNotesMan1Click(Sender: TObject);
    procedure trycn1Click(Sender: TObject);
  private
    procedure HandlePopupItem(Sender: TObject);
    procedure HandleDirectory;
    procedure WMApp (var msg: TMessage); message wm_App;
  public
    procedure FillTListView;
    procedure FillGroupMenu;
    procedure CheckDefault;
    procedure AddNotes;
    procedure ViewNote;
    procedure DeleteNote;
    procedure AddGroup;
    procedure RemoveGroup;
    procedure ReadSettings;
    procedure WriteSettings;
  end;

var
  Form1: TNotesManMF;
  Grp: Integer=0;
  Notes: NArray;
  FilterNotes: NArray;
  Group: GArray;
  LItem: TListItem;
  Selected: Integer;
  Exist: Boolean=False;
//Settings
  RememberMWS: Boolean;
  RememberMWP: Boolean;
  MinimizeST: Boolean;
  RememberEWS: Boolean;
  RememberEWP: Boolean;
  EditorFontSize: Integer;
//VariableforHandlingTrayClicks
  trMax: Boolean;
  addfromclipb: Boolean=False;

implementation

{$R *.dfm}


procedure TNotesManMF.AboutNotesMan1Click(Sender: TObject);
begin
MessageDlg('Copyright © 2020 VNM Software'+ #13#10+'Build Date: 02-06-2020'+#13#10+'Graphics by: http://www.famfamfam.com/', mtInformation, [mbOK], 0);
end;

procedure TNotesManMF.Addanewgroup1Click(Sender: TObject);
begin
AddGroup;
end;

procedure TNotesManMF.AddfromClipboardd1Click(Sender: TObject);
begin
if not EditorFormexist then
begin
addfromclipb:=True;
AddNotes;
end;
end;

procedure TNotesManMF.AddGroup;
var
NGroup: string;
I,Len: Integer;
begin
Ngroup:=EmptyStr;
NGroup:=InputBox('Group+','Enter group name.','');
NGroup:=Trim(NGroup);
if not NGroup.IsEmpty then
begin
for I := Low(Group) to High(Group) do
begin
if CompareText(Ngroup,Group[I])= 0 then
begin
Application.MessageBox('Group with same name already exists.','',0);
Exit;
end;
end;
Len:=Length(Group);
SetLength(Group,Len+1);
Group[Len]:=NGroup;
Grp:=Len;
HandleDirectory;
WriteGroup(Group);
FillGroupMenu;
FillTListView;
end;

end;

procedure TNotesManMF.Addnote1Click(Sender: TObject);
begin
AddNotes;
end;

procedure TNotesManMF.AddNote2Click(Sender: TObject);
begin
if not EditorFormexist then
 AddNotes;
end;

procedure TNotesManMF.AddNotes;
begin
Form2:=TForm2.Create(nil);
try
Form2.ShowModal;
finally
Form2.Free;
end;
end;

procedure TNotesManMF.btn11Click(Sender: TObject);
begin
RemoveGroup;
end;

procedure TNotesManMF.btn12Change(Sender: TObject);
var
  I,J: Integer;
begin
//lv1.Items.Clear;
if btn12.Text='' then
begin
btn12.RightButton.ImageIndex:=7;
FilterNotes:=Notes;
end
else
begin
J:=0;
btn12.RightButton.ImageIndex:=8;
Setlength(FilterNotes,0);
for I := High(Notes) downto Low(Notes) do
begin
if ContainsText(Notes[I][1],string(btn12.Text))then
begin
Inc(J,1);
Setlength(FilterNotes,J);
Setlength(FilterNotes[J-1],2);
FilterNotes[J-1][0]:=Notes[I][0];
FilterNotes[J-1][1]:=Notes[I][1];
end;
end;
end;
lv1.Items.Count:=Length(FilterNotes);
lv1.Invalidate;
end;

procedure TNotesManMF.btn12RightButtonClick(Sender: TObject);
begin
btn12.Text:='';
btn12.RightButton.ImageIndex:=7;
end;

procedure TNotesManMF.btn14Click(Sender: TObject);
begin
WriteSettings;
Application.Terminate;
end;

procedure TNotesManMF.btn1Click(Sender: TObject);
begin
AddNotes;
end;

procedure TNotesManMF.btn3Click(Sender: TObject);
begin
DeleteNote;
end;

procedure TNotesManMF.btn7Click(Sender: TObject);
begin
ViewNote;
end;

procedure TNotesManMF.btn9Click(Sender: TObject);
begin
AddGroup;
end;

procedure TNotesManMF.CheckDefault;
var
wstrm: Tstreamwriter;
begin
if not FileExists('Notes\Index.txt') then
begin
ForceDirectories(ExtractFilePath(Application.ExeName)+'\Notes');
wstrm:=TStreamWriter.Create('Notes\Index.txt');
try
wstrm.WriteLine('Default');
Grp:=0;
finally
wstrm.Free;
end;
end;
end;

procedure TNotesManMF.DeleteNote;
var
I:Integer;
ListItem: TListItem;
begin
if lv1.SelCount<>0 then
begin
if Application.MessageBox('Do you Really want to '+#10+' delete selected note?','',(MB_YESNO))=ID_YES then
begin
for I := 0 to (lv1.Items.Count-1) do
begin
ListItem:=lv1.Items.Item[I];
if ListItem.Selected then
begin
Selected:=StrToInt(ListItem.Caption);
DeleteFile('Notes\'+Group[Grp]+'\'+Notes[Selected-1][0]);
Delete(Notes,Selected-1,1);
WriteNotes(Group[Grp],Notes);
end;
end;
FillTListView;
end;
end;
end;

procedure TNotesManMF.Deletenote1Click(Sender: TObject);
begin
DeleteNote;
end;

procedure TNotesManMF.Exit1Click(Sender: TObject);
begin
WriteSettings;
Application.Terminate;
end;

procedure TNotesManMF.Exit2Click(Sender: TObject);
begin
WriteSettings;
Application.Terminate;
end;

procedure TNotesManMF.FillGroupMenu;
var
  I: Integer;
  MItem: TMenuItem;
begin
Group:=ReadGroup;
pm1.Items.Clear;
    for I := Low(Group) to High(Group) do
    begin
    MItem := TMenuItem.Create(pm1);
    MItem.Caption := Group[I];
    MItem.OnClick := HandlePopupItem;
    pm1.Items.Add(MItem);
    if I=Grp then
    pm1.Items[I].Checked:=True;
    end;

end;

procedure TNotesManMF.FillTListView;
begin
Notes:=ReadNotes(Group[Grp]);
FilterNotes:=Notes;
lv1.items.Count:=Length(FilterNotes);
lv1.Invalidate;
//lv1.Clear;
//Notes:=ReadNotes(Group[Grp]);
//    lv1.Items.BeginUpdate;
//    for I := High(Notes) downto Low(Notes) do
//    begin
//      LItem := lv1.Items.Add;
//      LItem.Caption :=(I+1).ToString;
//      LItem.SubItems.Add(Notes[I][1]);
//    end;
//lv1.Items.EndUpdate;
end;

procedure TNotesManMF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
WriteSettings;
if MinimizeST then
begin
Action:=caNone;
  Hide;
  WindowState := wsMinimized;
  trycn1.Visible := True;
//WriteGroup(Group);
//WriteNotes(Grp,Notes);
end;
end;

procedure TNotesManMF.FormCreate(Sender: TObject);
begin
  ReadSettings;
  CheckDefault;
  FillGroupMenu;
  FillTListView;
  HandleDirectory;
end;

procedure TNotesManMF.FormResize(Sender: TObject);
begin
lv1.Columns[1].Width:=lv1.Width-lv1.Columns[0].Width-5;
if Width<700 then
Width:=700;
if WindowState=wsMaximized then
  trMax:=True
else if WindowState=wsNormal then
   trMax:=False;
if (WindowState=wsMinimized) then
begin
  Hide;
  trycn1.Visible := True;
end;
//  lv1.Columns[0].Width:=50;
end;



procedure TNotesManMF.FormShow(Sender: TObject);
begin
   lv1.SetFocus;
   lv1.Columns[1].Width:=lv1.Width-lv1.Columns[0].Width-5;
end;

procedure TNotesManMF.GithubPage1Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'https://github.com/onlydelta/notesman', nil, nil, SW_SHOWNORMAL);
end;

procedure TNotesManMF.HandleDirectory;
var
I: Integer;
begin
for I := Low(Group) to High(Group) do
begin
if not DirectoryExists('Notes\'+Group[I]) then
begin
ForceDirectories(ExtractFilePath(Application.ExeName)+'\Notes\'+Group[I]);
end;
end;
end;

procedure TNotesManMF.HandlePopupItem(Sender: TObject);
var
I: Integer;
begin
for I := 0 to pm1.Items.Count-1 do
begin
pm1.Items[I].Checked:=False;
end;
TMenuItem(Sender).Checked:=True;
Grp:=TMenuItem(Sender).MenuIndex;
FillTListView;
end;

procedure TNotesManMF.lv1Data(Sender: TObject; Item: TListItem);
begin
Item.Caption:=(Length(FilterNotes)-Item.Index).ToString;
Item.SubItems.Add(FilterNotes[Length(FilterNotes)-Item.Index-1][1]);
end;

procedure TNotesManMF.lv1DblClick(Sender: TObject);
begin
Form2:=TForm2.Create(nil);
try
if lv1.SelCount=1 then
begin
Exist:=True;
Form2.edt1.Text:=lv1.Selected.SubItems[0];
Selected:=StrToInt(lv1.Selected.Caption);
Form2.RichEdit1.Lines.LoadFromFile('Notes\'+Group[Grp]+'\'+Notes[Selected-1][0],TEncoding.UTF8);
Form2.ShowModal;
Exist:=False;
end;
finally
Form2.Free;
end;

end;

procedure TNotesManMF.Preferences1Click(Sender: TObject);
begin
Form3:=TForm3.Create(nil);
try
Form3.ShowModal;
finally
Form3.Free;
end;
end;

procedure TNotesManMF.ReadSettings;
var
   Ini: TIniFile;
begin
Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
   try
    RememberMWS:= Ini.ReadBool('General','RememberMWS',False);
    RememberMWP:= Ini.ReadBool('General','RememberMWP',False);
    MinimizeST:= Ini.ReadBool('General','MinimizeST',False);
    RememberEWS:= Ini.ReadBool('General','RememberEWS',False);
    RememberEWP:= Ini.ReadBool('General','RememberEWP',False);
    Grp:=Ini.ReadInteger( 'General', 'ActiveGroup', 0);
    EditorFontSize:=Ini.ReadInteger('Editor','EditorFontSize',11);
    if RememberMWS then
     begin
     Height:= Ini.ReadInteger('General', 'MHeight', Height);
     Width:= Ini.ReadInteger('General', 'MWidth', Width);
     if Ini.ReadBool('General', 'WindowState', false ) then
       WindowState := wsMaximized
     else
     begin
       WindowState := wsNormal;

     end;
     end;
    if RememberMWP then
     begin
     Top:= Ini.ReadInteger('General', 'MTop',0);
     Left:= Ini.ReadInteger('General', 'MLeft', 0);
     end
     else
     Position:=poDesktopCenter;
   finally
     Ini.Free;
end;
end;


procedure TNotesManMF.RemoveGroup;
var
NGroup: string;
  I: Integer;
begin
NGroup:=EmptyStr;
NGroup:=InputBox('Group-','Enter group name.','');
NGroup:=Trim(LowerCase(NGroup));
if (not NGroup.IsEmpty) and (NGroup<>'default') then
begin

for I := Low(Group) to High(Group) do
begin
 if LowerCase(Group[I])=NGroup then
begin
if Application.MessageBox('Do you really want to '+#10+' delete entered group.?','',(MB_YESNO))=ID_YES then
begin
TDirectory.Delete('Notes\'+Group[I],True);
Delete(Group,I,1);
if Grp=Length(Group) then
Dec(Grp,1);
WriteGroup(Group);
FillGroupMenu;
FillTListView;
end;
end;
end;
end;
end;

procedure TNotesManMF.Removegroup1Click(Sender: TObject);
begin
RemoveGroup;
end;

procedure TNotesManMF.ShowWindow1Click(Sender: TObject);
begin
if not EditorFormexist  then
begin
  trycn1.Visible := False;
  if trMax then
  WindowState := wsMaximized
  else
  WindowState:=wsNormal;
  Show;
  Application.BringToFront;
end;
end;

procedure TNotesManMF.trycn1Click(Sender: TObject);
begin
if not EditorFormexist then
begin
  trycn1.Visible := False;
  if trMax then
  WindowState := wsMaximized
  else
  WindowState:=wsNormal;
  Show;
  Application.BringToFront;
end;
end;

procedure TNotesManMF.ViewNote;
begin
Form2:=TForm2.Create(nil);
try
if lv1.SelCount=1 then
begin
Exist:=True;
Form2.edt1.Text:=lv1.Selected.SubItems[0];
Selected:=StrToInt(lv1.Selected.Caption);
Form2.RichEdit1.Lines.LoadFromFile('Notes\'+Group[Grp]+'\'+Notes[Selected-1][0],TEncoding.UTF8);
Form2.ShowModal;
Exist:=False;
end;
finally
Form2.Free;
end;

end;

procedure TNotesManMF.Viewnote1Click(Sender: TObject);
begin
 ViewNote;
end;

procedure TNotesManMF.WMApp(var msg: TMessage);
begin
if not EditorFormexist then
begin
  trycn1.Visible := False;
  if trMax then
  WindowState := wsMaximized
  else
  WindowState:=wsNormal;
  Show;
  Application.BringToFront;
end;
end;

procedure TNotesManMF.WriteSettings;
var
Ini: TInifile;
begin
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
   try
     Ini.WriteBool('General','RememberMWS',RememberMWS);
     Ini.WriteBool('General','RememberMWP',RememberMWP);
     Ini.WriteBool('General','MinimizeST',MinimizeST);
     Ini.WriteBool('General','RememberEWS',RememberEWS);
     Ini.WriteBool('General','RememberEWP',RememberEWP);
     Ini.WriteInteger( 'General', 'ActiveGroup', Grp);
     Ini.WriteInteger( 'General', 'MTop', Top);
     Ini.WriteInteger( 'General', 'MLeft', Left);
     Ini.WriteInteger( 'General', 'MHeight', Height);
     Ini.WriteInteger( 'General', 'MWidth', Width);
     Ini.WriteBool( 'General', 'WindowState', WindowState = wsMaximized );
     if WindowState=wsMinimized then
     begin
     if trMax then
     Ini.WriteBool( 'General', 'WindowState', True )
     else
     Ini.WriteBool( 'General', 'WindowState', False );
     end;
     Ini.WriteInteger( 'Editor', 'EditorFontSize', EditorFontSize);
   finally
     Ini.Free;
   end;
end;

end.
