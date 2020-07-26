program NotesMan;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  editorshow in 'editorshow.pas' {Form2},
  helper in 'helper.pas',
  setting in 'setting.pas' {Form3},
  Windows, Messages;

{$R *.res}
var
  Wnd: HWND;
begin
  Wnd := FindWindow('TNotesManMF', nil);
  if (Wnd <> 0) then
  begin
   PostMessage (Wnd, wm_App, 0, 0);
   Halt;
  end
  else
  begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TNotesManMF, Form1);
//  Application.CreateForm(TForm3, Form3);
  //  Application.CreateForm(TForm2, Form2);
  Application.Run;
  end;
end.
