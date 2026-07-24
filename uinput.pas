unit uInput;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons;

type

  { TfrmInput }

  TfrmInput = class(TForm)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    spSubmit: TSpeedButton;
    procedure spSubmitClick(Sender: TObject);
  private

  public

  end;

var
  frmInput: TfrmInput;

implementation

{$R *.lfm}
uses uMainForm;

{ TfrmInput }

procedure TfrmInput.spSubmitClick(Sender: TObject);
begin
  MainForm.tpages.edit;
  MainForm.tpages.Post;
  ShowMessage('Data Tersimpan');
  self.close;
end;

end.

