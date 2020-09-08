unit editorshow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, helper,
  Vcl.Buttons, Vcl.Menus, System.inifiles, Clipbrd, Winapi.RichEdit;

type
  TForm2 = class(TForm)
    pnl1: TPanel;
    pnl3: TPanel;
    lbl1: TLabel;
    edt1: TEdit;
    RichEdit1: TRichEdit;
    pnl2: TPanel;
    dlgFind1: TFindDialog;
    btn2: TSpeedButton;
    btn1: TSpeedButton;
    pm1: TPopupMenu;
    Undo1: TMenuItem;
    Repeat1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Find1: TMenuItem;
    N4: TMenuItem;
    Clear1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Redo1: TMenuItem;
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn2Click(Sender: TObject);
    procedure dlgFind1Find(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Repeat1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pm1Popup(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private

  public
    procedure Save;
  end;

var
  Form2: TForm2;
  fn: string;
  btnSave: Boolean = False;
  EditorFormexist: Boolean = False;
  UnSaved: Boolean = False;

implementation

{$R *.dfm}

uses
  main;

procedure TForm2.btn1Click(Sender: TObject);
begin
  Save;
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  dlgFind1.FindText := RichEdit1.SelText;
  dlgFind1.Execute;
end;

procedure TForm2.Clear1Click(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TForm2.Copy1Click(Sender: TObject);
begin
  RichEdit1.CopyToClipboard;
end;

procedure TForm2.Cut1Click(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TForm2.Delete1Click(Sender: TObject);
begin
  RichEdit1.ClearSelection;
end;

procedure TForm2.dlgFind1Find(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, SearchLength: Integer;
  mySearchTypes: TSearchTypes;
  myFindOptions: TFindOptions;
begin
  mySearchTypes := [];
  myFindOptions := dlgFind1.Options;
  with RichEdit1 do
  begin
    if frMatchCase in myFindOptions then
      mySearchTypes := mySearchTypes + [stMatchCase];
    if frWholeWord in myFindOptions then
      mySearchTypes := mySearchTypes + [stWholeWord];
    if frDown in myFindOptions then
    begin
      if SelLength <> 0 then
        StartPos := SelStart + SelLength
      else
        StartPos := 0;
      SearchLength := Length(Text) - StartPos;
      FoundAt := FindText(dlgFind1.FindText, StartPos, SearchLength,
        mySearchTypes);
      if FoundAt <> -1 then
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(dlgFind1.FindText);
      end
      else
        Beep;
    end
    else
    begin
      StartPos := SelStart;
      SearchLength := 0;
      FoundAt := -1;
      while (StartPos > -1) and (FoundAt = -1) do
      begin
        FoundAt := FindText(dlgFind1.FindText, StartPos, SearchLength,
          mySearchTypes);
        Dec(StartPos, 1);
        Inc(SearchLength, 1);
      end;
      if FoundAt <> -1 then
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(dlgFind1.FindText);
      end
      else
        Beep;
    end;
  end;
end;

procedure TForm2.edt1Change(Sender: TObject);
begin
  if EditorFormexist then
  begin
    if not Autosave then
    begin
      btn1.Caption := '*Save';
      UnSaved := True;
    end;
  end;

end;

procedure TForm2.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key = ^s) or (Key = ^s)) then
  begin
    Key := #0;
    Save;
  end;
  if Ord(Key) = VK_ESCAPE then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TForm2.Find1Click(Sender: TObject);
begin
  dlgFind1.FindText := RichEdit1.SelText;
  dlgFind1.Execute;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TInifile;
begin
  if (Autosave) and ((edt1.Text <> '') or (RichEdit1.Lines.Text <> '')) then
    Save;
  btnSave := False;
  UnSaved := False;
  Ini := TInifile.Create(ExtractFilePath(Application.ExeName) + 'NotesMan.ini');
  try
    if RememberEWP then
    begin
      Ini.WriteInteger('Editor', 'ETop', Top);
      Ini.WriteInteger('Editor', 'ELeft', Left);
    end;
    if RememberEWS then
    begin
      Ini.WriteInteger('Editor', 'EHeight', Height);
      Ini.WriteInteger('Editor', 'EWidth', Width);
      Ini.WriteBool('Editor', 'WindowState', WindowState = wsMaximized);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  R: Integer;
begin
  if (not Autosave) and (UnSaved) then
  begin
    R := Application.MessageBox('Save note before exit?', 'Confirm',
      (MB_YESNOCANCEL or MB_DEFBUTTON1 or MB_ICONQUESTION));
    if R = ID_CANCEL then
      CanClose := False
    else if R = ID_YES then
      Save
    else if R = ID_NO then
      CanClose := True;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Ini: TInifile;
begin
  Ini := TInifile.Create(ExtractFilePath(Application.ExeName) + 'NotesMan.ini');
  try
    if RememberEWP then
    begin
      Top := Ini.ReadInteger('Editor', 'ETop', Top);
      Left := Ini.ReadInteger('Editor', 'ELeft', Left);
    end
    else
      Position := poDesktopCenter;
    if RememberEWS then
    begin
      Height := Ini.ReadInteger('Editor', 'EHeight', Height);
      Width := Ini.ReadInteger('Editor', 'EWidth', Width);
      if Ini.ReadBool('Editor', 'WindowState', False) then
        WindowState := wsMaximized
      else
        WindowState := wsNormal;
    end;
    RichEdit1.Font.Size := EditorFontSize;
    if WordWrap then
    begin
      RichEdit1.WordWrap := WordWrap;
      RichEdit1.ScrollBars := ssVertical;
    end
    else
    begin
      RichEdit1.WordWrap := WordWrap;
      RichEdit1.ScrollBars := ssBoth;
    end;
  finally
    Ini.Free;
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  EditorFormexist := False;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  EditorFormexist := True;
  if addfromclipb then
  begin
    // RichEdit1.PasteFromClipboard;
    RichEdit1.Perform(EM_REPLACESEL, 1, PWideChar(Clipboard.AsText));
    addfromclipb := False;
  end;
  RichEdit1.SetFocus;
end;

procedure TForm2.Paste1Click(Sender: TObject);
begin
  // RichEdit1.PasteFromClipboard;
  // RichEdit1.SelText := Clipboard.AsText;
  RichEdit1.Perform(EM_REPLACESEL, 1, PWideChar(Clipboard.AsText));
end;

procedure TForm2.pm1Popup(Sender: TObject);
begin
  if RichEdit1.SelLength = 0 then
  begin
    pm1.Items[3].Enabled := False;
    pm1.Items[4].Enabled := False;
    pm1.Items[6].Enabled := False;
  end
  else
  begin
    pm1.Items[3].Enabled := True;
    pm1.Items[4].Enabled := True;
    pm1.Items[6].Enabled := True;
  end;
end;

procedure TForm2.Redo1Click(Sender: TObject);
begin
  RichEdit1.Perform(EM_REDO, 0, 0);
end;

procedure TForm2.Repeat1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
end;

procedure TForm2.RichEdit1Change(Sender: TObject);
begin
  if EditorFormexist then
  begin
    if not Autosave then
    begin
      btn1.Caption := '*Save';
      UnSaved := True;
    end;
  end;
end;

procedure TForm2.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
  if (ssCtrl in Shift) and ((Key = Ord('s')) or (Key = Ord('S'))) then
  begin
    Key := 0;
    Save;
  end;
end;

procedure TForm2.Save;
var
  len: Integer;
begin
  if Exist then
  begin
    if SearchActive then
    begin
      Notes[StrToInt(FilterNotes[Selected - 1][2])][1] := edt1.Text;
      FilterNotes[Selected - 1][1] := edt1.Text;
      RichEdit1.Lines.SaveToFile(DefaultDir + Group[Grp] + '\' +
        Notes[StrToInt(FilterNotes[Selected - 1][2])][0], TEncoding.UTF8);
    end
    else
    begin
      Notes[Selected - 1][1] := edt1.Text;
      RichEdit1.Lines.SaveToFile(DefaultDir + Group[Grp] + '\' +
        Notes[Selected - 1][0], TEncoding.UTF8);
    end;
    WriteNotes(Group[Grp], Notes);
    Form1.FillTListView;
  end
  else
  begin
    len := Length(Notes);
    if btnSave then
    begin
      Notes[len - 1][1] := edt1.Text;
      RichEdit1.Lines.SaveToFile(DefaultDir + Group[Grp] + '\' + Notes[len - 1]
        [0], TEncoding.UTF8);
      WriteNotes(Group[Grp], Notes);
      Form1.FillTListView(True);
    end
    else
    begin
      SetLength(Notes, len + 1);
      SetLength(Notes[len], 2);
      if len = 0 then
        Notes[len][0] := '1'
      else
        Notes[len][0] := IntToStr(StrToInt(Notes[len - 1][0]) + 1);

      Notes[len][1] := edt1.Text;
      RichEdit1.Lines.SaveToFile(DefaultDir + Group[Grp] + '\' + Notes[len][0],
        TEncoding.UTF8);
      WriteNotes(Group[Grp], Notes);
      Form1.FillTListView(True);
      btnSave := True;
    end;
  end;
  btn1.Caption := 'Save';
  UnSaved := False;
end;

procedure TForm2.Undo1Click(Sender: TObject);
begin
  RichEdit1.Undo;
end;

end.
