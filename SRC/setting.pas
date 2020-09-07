unit setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btn2: TButton;
    btn3: TButton;
    grp1: TGroupBox;
    grp2: TGroupBox;
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk4: TCheckBox;
    chk5: TCheckBox;
    lbl1: TLabel;
    cbb1: TComboBox;
    chk6: TCheckBox;
    chk7: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
main;

procedure TForm3.btn2Click(Sender: TObject);
begin
Form3.Close;
end;

procedure TForm3.btn3Click(Sender: TObject);
begin
RememberMWP:=chk1.Checked;
RememberMWS:=chk2.Checked;
MinimizeST:=chk3.Checked;
RememberEWP:=chk4.Checked;
RememberEWS:=chk5.Checked;
Autosave:=chk6.Checked;
WordWrap:=chk7.Checked;
if (StrToInt(cbb1.Items[cbb1.ItemIndex])>=10) and (StrToInt(cbb1.Items[cbb1.ItemIndex])<=15)then
EditorFontSize:=StrToInt(cbb1.Items[cbb1.ItemIndex]);
Form3.Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
I: Integer;
begin
chk1.Checked:=RememberMWP;
chk2.Checked:=RememberMWS;
chk3.Checked:=MinimizeST;
chk4.Checked:=RememberEWP;
chk5.Checked:=RememberEWS;
chk6.Checked:=AutoSave;
chk7.Checked:=WordWrap;
for I := 0 to cbb1.Items.Count-1 do
begin
if cbb1.Items[I]=EditorFontSize.ToString then
begin
cbb1.ItemIndex:=I;
Break;
end;
end;

end;

end.
