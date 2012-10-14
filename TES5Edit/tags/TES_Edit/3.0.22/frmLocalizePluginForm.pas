unit frmLocalizePluginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TfrmLocalizePlugin = class(TForm)
    gbTranslation: TGroupBox;
    cbTranslation: TCheckBox;
    Label1: TLabel;
    clbFrom: TCheckListBox;
    Label2: TLabel;
    Label3: TLabel;
    clbTo: TCheckListBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure cbTranslationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalizePlugin: TfrmLocalizePlugin;

implementation

{$R *.dfm}

procedure TfrmLocalizePlugin.cbTranslationClick(Sender: TObject);
begin
  gbTranslation.Enabled := cbTranslation.Checked;
end;

procedure TfrmLocalizePlugin.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i, j: integer;
begin
  if cbTranslation.Checked then begin
    j := 0;
    for i := 0 to Pred(clbFrom.Count) do begin
      if clbFrom.Checked[i] and clbTo.Checked[i] then begin
        MessageBox(0, PChar('Translation files should not match'), 'Error', 0);
        Action := caNone;
        Exit;
      end;
      if clbFrom.Checked[i] then Inc(j);
      if clbTo.Checked[i] then Dec(j);
    end;
    if j <> 0 then begin
      MessageBox(0, PChar('Translation files should come in pairs'), 'Error', 0);
      Action := caNone;
    end;
  end;
end;

end.
