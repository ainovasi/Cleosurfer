unit usplash;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  klabels;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    tmSplash: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lbTerminateClick(Sender: TObject);
    procedure tmSplashTimer(Sender: TObject);
  private

  public

  end;

var
  frmSplash: TfrmSplash;
  i : integer;

implementation

uses uMainForm;


{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.lbTerminateClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TfrmSplash.tmSplashTimer(Sender: TObject);
begin
   inc(i);
  if i>1 then
      begin

        tmSplash.Enabled:=false;
        close;
      end;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
    i := 0 ;
  tmSplash.Enabled:=true;
end;

procedure TfrmSplash.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

end.

