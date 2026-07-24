unit uMainForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, DB,
  Graphics, Controls, Forms, Dialogs, ComCtrls, Buttons, ExtCtrls, Menus,
  DBCtrls, StdCtrls, Calendar, DBExtCtrls,
  RTTICtrls, cyPageControl,  usplash, ZConnection, ZDataset,
  RxDBGrid, rxpickdate, uWVLoader, uWVCoreWebView2Args, uinput;

const
  WV_INITIALIZED = WM_APP + $100;

  HOMEPAGE_URL        = 'https://www.google.com/';
  DEFAULT_TAB_CAPTION = '....';

type

  { TMainForm }

  TMainForm = class(TForm)
    BrowserPageCtrl: TPageControl;
    DBDateEdit1: TDBDateEdit;
    DBMemo1: TDBMemo;
    dspages: TDataSource;
    dshistori: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    edtCariBookmark: TEdit;
    edtCariHistori: TEdit;
    grdhistori: TRxDBGrid;
    grdpages: TRxDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ImageList1: TImageList;
    koneksi: TZConnection;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    mnTabAdd: TMenuItem;
    MenuItem3: TMenuItem;
    mnEditBookmark: TMenuItem;
    mnHapusBookmark: TMenuItem;
    mnCloseTab: TMenuItem;
    mnHapusHistori: TMenuItem;
    pageLeft: TcyPageControl;
    pnpageleft: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel9: TPanel;
    pmHistori: TPopupMenu;
    pmBookmark: TPopupMenu;
    PopupMenu1: TPopupMenu;
    qhistori50: TZQuery;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    tbsBookmark: TTabSheet;
    tbsCalculator: TTabSheet;
    tbsHistori: TTabSheet;
    tbsSchedule: TTabSheet;
    tvhistori: TZTable;
    tpages: TZTable;
    thistori: TZTable;
    ZQuery1: TZQuery;

    procedure edtCariBookmarkChange(Sender: TObject);
    procedure edtCariHistoriChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddTabBtnClick(Sender: TObject);
    procedure grdhistoriDblClick(Sender: TObject);
    procedure grdpagesDblClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure mnAudioClick(Sender: TObject);
    procedure mnBookmarkClick(Sender: TObject);
    procedure mnDownloadClick(Sender: TObject);
    procedure mnEditBookmarkClick(Sender: TObject);
    procedure mnHapusBookmarkClick(Sender: TObject);
    procedure mnHapusHistoriClick(Sender: TObject);
    procedure mnHistoriClick(Sender: TObject);
    procedure mnNotesClick(Sender: TObject);
    procedure mnPosBottomClick(Sender: TObject);
    procedure mnPosUpClick(Sender: TObject);
    procedure mnTanyaAiClick(Sender: TObject);
    procedure RemoveTabBtnClick(Sender: TObject);
    procedure spCoretaxFiskusClick(Sender: TObject);
    procedure spEditURLClick(Sender: TObject);
    procedure spHapusURLClick(Sender: TObject);
    procedure spShowPanelClick(Sender: TObject);
    procedure spShowSideBarClick(Sender: TObject);
    procedure spTambahURLClick(Sender: TObject);
    procedure tbsHistoriShow(Sender: TObject);


  protected
    FLastTabID       : cardinal;

    function  GetNextTabID : cardinal;
    procedure EnableButtonPnl;

    property  NextTabID       : cardinal   read GetNextTabID;
  private
    FormInput : TfrmInput;
    FormSplash : TfrmSplash;
    procedure TambahPage(Url:string);
    procedure TambahPageLeft(Url:string);

  public
    procedure WVInitializedMsg(var aMessage : TMessage); message WV_INITIALIZED;
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;

    procedure CreateNewTab(const aArgs : TCoreWebView2NewWindowRequestedEventArgs);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

// This demo shows how to create multiple browsers at runtime using tabs.

uses
  uBrowserTab;

procedure TMainForm.FormShow(Sender: TObject);
var
  neet : boolean;

begin
  if GlobalWebView2Loader.InitializationError then
    showmessage(GlobalWebView2Loader.ErrorMessage)
   else
    if GlobalWebView2Loader.Initialized then
      EnableButtonPnl;



  With koneksi do
  begin
    Protocol:='sqlite';
    Database:=ExtractFilePath(Application.ExeName) + 'support/pages.sq';
    LibraryLocation:=ExtractFilePath(Application.ExeName) + 'support/sqlite3.dll';
    Connect;
    tpages.open;
    thistori.open;

  end;
  tpages.Locate('home','1',[loPartialKey]);
  Application.ProcessMessages;
 TambahPage(tpages.FieldByName('URL').AsString );
   //  TambahPage('https://google.com' );

  FormSplash.ShowModal;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

  FormInput := TfrmInput.create(self);
  FormSplash := TfrmSplash.create(self);


end;

procedure TMainForm.edtCariHistoriChange(Sender: TObject);
begin
  if edtCariHistori.Text<>'' then
    begin
      thistori.Filtered:=false;
      thistori.Filter:='URL LIKE' + QuotedStr('*'+ edtCariHistori.text + '*') +
                            ' OR NAMA LIKE ' +QuotedStr('*'+ edtCariHistori.text + '*');
      thistori.Filtered:=true;
    end
  else
     thistori.Filtered:=false;
end;

procedure TMainForm.edtCariBookmarkChange(Sender: TObject);
begin
  if edtCariBookmark.Text<>'' then
    begin
      tpages.Filtered:=false;
      tpages.Filter:='URL LIKE' + QuotedStr('*'+ edtCariBookmark.text + '*') +
                            ' OR NAMA LIKE ' +QuotedStr('*'+ edtCariBookmark.text + '*');
      tpages.Filtered:=true;
    end
  else
     tpages.Filtered:=false;
end;

procedure TMainForm.WVInitializedMsg(var aMessage : TMessage);
begin
  EnableButtonPnl;
end;

function TMainForm.GetNextTabID : cardinal;
begin
  inc(FLastTabID);
  Result := FLastTabID;
end;

procedure TMainForm.RemoveTabBtnClick(Sender: TObject);
var
  TempTab : TBrowserTab;
begin
  TempTab := TBrowserTab(BrowserPageCtrl.Pages[BrowserPageCtrl.ActivePageIndex]);
  TempTab.Free;
end;

procedure TMainForm.spCoretaxFiskusClick(Sender: TObject);
begin

end;

procedure TMainForm.spEditURLClick(Sender: TObject);
begin
  tpages.Edit;
  FormInput.ShowModal;
end;

procedure TMainForm.spHapusURLClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Menghapus URL ini?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
     tpages.Delete;
   end;
end;

procedure TMainForm.spShowPanelClick(Sender: TObject);
begin

end;

procedure TMainForm.spShowSideBarClick(Sender: TObject);
begin
   if pnpageLeft.Showing then
   pageLeft.hide
   else
   pnpageLeft.show;
end;

procedure TMainForm.spTambahURLClick(Sender: TObject);
begin
  tpages.Append;
  FormInput.ShowModal;
end;

procedure TMainForm.tbsHistoriShow(Sender: TObject);
begin
  thistori.Refresh;
end;

procedure TMainForm.TambahPage(Url:string);
var
  TempNewTab : TBrowserTab;
begin

  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := BrowserPageCtrl;

  BrowserPageCtrl.ActivePageIndex := pred(BrowserPageCtrl.PageCount);
  TempNewTab.ImageIndex:=0;
  TempNewTab.CreateBrowser(url);
end;
procedure TMainForm.TambahPageLeft(Url:string);
var
  TempNewTab : TBrowserTab;
begin

  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := pageLeft;

  pageLeft.ActivePageIndex := pred(BrowserPageCtrl.PageCount);
  TempNewTab.CreateBrowser(url);
end;

procedure TMainForm.AddTabBtnClick(Sender: TObject);
var
  TempNewTab : TBrowserTab;
begin
  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := BrowserPageCtrl;

  BrowserPageCtrl.ActivePageIndex := pred(BrowserPageCtrl.PageCount);

  TempNewTab.CreateBrowser(HOMEPAGE_URL);

end;

procedure TMainForm.grdhistoriDblClick(Sender: TObject);
var
  url : string;
begin
  url := thistori.FieldByName('URL').AsString;
  TambahPage(url);

end;

procedure TMainForm.grdpagesDblClick(Sender: TObject);
var
  url : string;
begin
  url := tpages.FieldByName('URL').AsString;
  TambahPage(url);
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
  koneksi.ExecuteDirect('update web set home=0');
  koneksi.ExecuteDirect('update web set home=1 where id=' + tpages.FieldByName('ID').AsString);
  ShowMessage(tpages.FieldByName('NAMA').AsString + ' Menjadi Halaman Default');
end;

procedure TMainForm.MenuItem6Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.mnAudioClick(Sender: TObject);
begin
    pnpageLeft.show;

end;

procedure TMainForm.mnBookmarkClick(Sender: TObject);
begin
  pnpageLeft.show;
  tbsBookmark.show;
end;

procedure TMainForm.mnDownloadClick(Sender: TObject);
begin
    pnpageLeft.show;

end;

procedure TMainForm.mnEditBookmarkClick(Sender: TObject);
begin
    tpages.Edit;
  FormInput.ShowModal;
end;

procedure TMainForm.mnHapusBookmarkClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Menghapus URL ini?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
     tpages.Delete;
   end;
end;

procedure TMainForm.mnHapusHistoriClick(Sender: TObject);
begin
   if Dialogs.MessageDlg('Menghapus URL ini?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
     thistori.Delete;
   end;
end;

procedure TMainForm.mnHistoriClick(Sender: TObject);
begin
    pnpageLeft.show;
  tbsHistori.show;
end;

procedure TMainForm.mnNotesClick(Sender: TObject);
begin
    pnpageLeft.show;

end;

procedure TMainForm.mnPosBottomClick(Sender: TObject);
begin
  BrowserPageCtrl.TabPosition:=tpBottom;
end;

procedure TMainForm.mnPosUpClick(Sender: TObject);
begin
  BrowserPageCtrl.TabPosition:=tpTop;
end;

procedure TMainForm.mnTanyaAiClick(Sender: TObject);
begin
    pnpageLeft.show;

end;

procedure TMainForm.CreateNewTab(const aArgs : TCoreWebView2NewWindowRequestedEventArgs);
var
  TempNewTab : TBrowserTab;
begin
  TempNewTab             := TBrowserTab.Create(self, NextTabID, DEFAULT_TAB_CAPTION);
  TempNewTab.PageControl := BrowserPageCtrl;

  BrowserPageCtrl.ActivePageIndex := pred(BrowserPageCtrl.PageCount);

  TempNewTab.CreateBrowser(aArgs);
end;

procedure TMainForm.EnableButtonPnl;
begin

      Caption           := 'CleoSurfer 2026 [ Build On Lazarus FreePascal ]' ;
      cursor            := crDefault;


end;

procedure TMainForm.WMMove(var aMessage : TWMMove);
var
  i : integer;
begin
  inherited;

  i := 0;
  while (i < BrowserPageCtrl.PageCount) do
    begin
      TBrowserTab(BrowserPageCtrl.Pages[i]).NotifyParentWindowPositionChanged;
      inc(i);
    end;
end;



procedure TMainForm.WMMoving(var aMessage : TMessage);
var
  i : integer;
begin
  inherited;

  i := 0;
  while (i < BrowserPageCtrl.PageCount) do
    begin
      TBrowserTab(BrowserPageCtrl.Pages[i]).NotifyParentWindowPositionChanged;
      inc(i);
    end;
end;

procedure GlobalWebView2Loader_OnEnvironmentCreated(Sender: TObject);
begin
  if (MainForm <> nil) and MainForm.HandleAllocated then
    PostMessage(MainForm.Handle, WV_INITIALIZED, 0, 0);
end;

initialization
  GlobalWebView2Loader                      := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder       := ExtractFileDir(Application.ExeName) + '\CustomCache';
  GlobalWebView2Loader.OnEnvironmentCreated := GlobalWebView2Loader_OnEnvironmentCreated;
  GlobalWebView2Loader.StartWebView2;


end.
