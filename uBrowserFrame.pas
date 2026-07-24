unit uBrowserFrame;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, openssl, opensslsockets,FileUtil, SysUtils,
  Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Menus, ComboEx, cyBaseCombobox,
  uWVBrowserBase, uWVBrowser, uWVWinControl, uWVWindowParent,
  uWVTypeLibrary, uWVTypes, uChildForm, uWVCoreWebView2Args,
  uWVCoreWebView2Deferral, uWVEvents,  DateUtils, fphttpclient,
  fpjson, StrUtils, Math,  Types,Clipbrd;

type
  TBrowserTitleEvent = procedure(Sender: TObject; const aTitle : string) of object;

  { TBrowserFrame }

  TBrowserFrame = class(TFrame)
    cbEngine: TComboBox;
    GoBtn: TSpeedButton;
    GoBtn1: TSpeedButton;
    GoBtn2: TSpeedButton;
    GoBtn3: TSpeedButton;
    GoBtn4: TSpeedButton;
    MenuItem1: TMenuItem;
    mnSaveTxt: TMenuItem;
    mnInspecElement: TMenuItem;
    mnLihatSource: TMenuItem;
    MnHapusDir: TMenuItem;
    mnTentangCleo: TMenuItem;
    mnDarkMode: TMenuItem;
    MenuItem11: TMenuItem;
    mnSideBar: TMenuItem;
    mnOut: TMenuItem;
    MenuItem6: TMenuItem;
    mnOpenFile: TMenuItem;
    mnBack: TMenuItem;
    mnGoFoward: TMenuItem;
    mnGoBookmark: TMenuItem;
    mnStop: TMenuItem;
    mnRefresh: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    ODHTML: TOpenDialog;
    Panel3: TPanel;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Panel2: TPanel;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    Separator5: TMenuItem;
    spAddTab: TSpeedButton;
    spCloseTab: TSpeedButton;
    spReload: TSpeedButton;
    URLCbx: TComboBox;
    WVBrowser1: TWVBrowser;
    WVWindowParent1: TWVWindowParent;

    procedure BookMarkBtnClick(Sender: TObject);
    procedure cbEngineChange(Sender: TObject);
    procedure ckDarkChange(Sender: TObject);
    procedure edtCariKeyPress(Sender: TObject; var Key: char);
    procedure GoBtn1Click(Sender: TObject);
    procedure GoBtn3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure mnCalculatorClick(Sender: TObject);
    procedure mnDarkModeClick(Sender: TObject);
    procedure MnHapusDirClick(Sender: TObject);
    procedure mnInspecElementClick(Sender: TObject);
    procedure mnLihatSourceClick(Sender: TObject);
    procedure mnSalinkLinkClick(Sender: TObject);
    procedure mnBackClick(Sender: TObject);
    procedure mnGoBookmarkClick(Sender: TObject);
    procedure mnGoFowardClick(Sender: TObject);
    procedure mnHistoriClick(Sender: TObject);
    procedure mnOutClick(Sender: TObject);
    procedure mnRefreshClick(Sender: TObject);
    procedure mnResumeAIClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure mnBookmarkClick(Sender: TObject);
    procedure mnSaveTxtClick(Sender: TObject);
    procedure mnScheduleClick(Sender: TObject);
    procedure mnSideBarClick(Sender: TObject);
    procedure mnStopClick(Sender: TObject);
    procedure mnTentangCleoClick(Sender: TObject);
    procedure OpenFileBtnClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure PrintPDFClick(Sender: TObject);
    procedure SideBarShowClick(Sender: TObject);
    procedure spAddTabClick(Sender: TObject);
    procedure spCleoClick(Sender: TObject);
    procedure spCloseTabClick(Sender: TObject);
    procedure spReloadClick(Sender: TObject);
    procedure TranslateBtnClick(Sender: TObject);
    procedure URLCbxChange(Sender: TObject);
    procedure URLCbxKeyPress(Sender: TObject; var Key: char);
    procedure WVBrowser1ContextMenuRequested(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1DownloadStarting(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2DownloadStartingEventArgs);
    procedure WVBrowser1NavigationStarting(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationStartingEventArgs);
    procedure WVBrowser1NavigationCompleted(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1RetrieveTextCompleted(Sender: TObject;
      aResult: boolean; const aText: wvstring);
    procedure WVBrowser1SourceChanged(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2SourceChangedEventArgs);
    procedure WVBrowser1InitializationError(Sender: TObject; aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1NewWindowRequested(Sender: TObject; const aWebView: ICoreWebView2; const aArgs: ICoreWebView2NewWindowRequestedEventArgs);

    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);

  protected
    FHomepage             : wvstring;
    FOnBrowserTitleChange : TBrowserTitleEvent;
    FArgs                 : TCoreWebView2NewWindowRequestedEventArgs;
    FDeferral             : TCoreWebView2Deferral;
    ModeDark              : Boolean;
    function  GetInitialized : boolean;

    procedure SetArgs(const aValue : TCoreWebView2NewWindowRequestedEventArgs);

    procedure UpdateNavButtons(aIsNavigating : boolean);
    procedure AddHistori;
    function GetInformationFromGemini(s:string):string;
  public
    FLastClickedLink : PWideChar;
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure   NotifyParentWindowPositionChanged;
    procedure   CreateBrowser;
    procedure   CreateAllHandles;

    property  Initialized          : boolean                                   read GetInitialized;
    property  Homepage             : wvstring                                  read FHomepage              write FHomepage;
    property  OnBrowserTitleChange : TBrowserTitleEvent                        read FOnBrowserTitleChange  write FOnBrowserTitleChange;
    property  Args                 : TCoreWebView2NewWindowRequestedEventArgs  read FArgs                  write SetArgs;
    function GetAutoTranslateScript(TargetLang: String): String;
  end;



implementation

{$R *.lfm}

uses
  uWVCoreWebView2WindowFeatures, uMainForm;

constructor TBrowserFrame.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FHomepage              := '';
  FOnBrowserTitleChange  := nil;

end;

destructor TBrowserFrame.Destroy;
begin
  if assigned(FDeferral) then
    FreeAndNil(FDeferral);

  if assigned(FArgs) then
    FreeAndNil(FArgs);

  inherited Destroy;
end;

procedure TBrowserFrame.NotifyParentWindowPositionChanged;
begin
  WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TBrowserFrame.AddHistori;
begin

  With MainForm do
  begin
       tvhistori.Open;
       tvhistori.First;
       while not tvhistori.eof do
        begin
             URLCbx.Items.Add(tvhistori.FieldByName('url').AsString);
             tvhistori.next;
        end;
  end;

end;

procedure TBrowserFrame.CreateBrowser;
begin
  WVBrowser1.DefaultURL := FHomepage;
  WVBrowser1.CreateBrowser(WVWindowParent1.Handle);

end;

procedure TBrowserFrame.CreateAllHandles;
begin
  CreateHandle;
  WVWindowParent1.CreateHandle;
end;

function TBrowserFrame.GetInitialized : boolean;
begin

  Result := WVBrowser1.Initialized;
  ModeDark := False;
end;

procedure TBrowserFrame.SetArgs(const aValue : TCoreWebView2NewWindowRequestedEventArgs);
begin
  FArgs     := aValue;
  FDeferral := TCoreWebView2Deferral.Create(FArgs.Deferral);
end;

procedure TBrowserFrame.WVBrowser1NavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
var
 nama,url:string;
begin
  nama := WVBrowser1.DocumentTitle;
  url := WVBrowser1.Source;
  UpdateNavButtons(False);
  MainForm.koneksi.ExecuteDirect('delete from histori where url=' + QuotedStr(url));
  MainForm.koneksi.ExecuteDirect('INSERT INTO HISTORI (NAMA,URL,TANGGAL) values ('+
                                 QuotedStr(nama)+','+ QuotedStr(url) +',' +
                                 QuotedStr(DateToStr(now))+')');
  mnDarkModeClick(Sender);

end;

procedure TBrowserFrame.WVBrowser1NavigationStarting(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationStartingEventArgs);
begin
  UpdateNavButtons(True);
end;

procedure TBrowserFrame.WVBrowser1NewWindowRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
var
  TempChildForm : TChildForm;
  TempArgs : TCoreWebView2NewWindowRequestedEventArgs;
  TempWindowFeatures : TCoreWebView2WindowFeatures;
begin
  if assigned(aArgs) then
    begin
      TempArgs           := TCoreWebView2NewWindowRequestedEventArgs.Create(aArgs);
      TempWindowFeatures := TCoreWebView2WindowFeatures.Create(TempArgs.WindowFeatures);

      if TempWindowFeatures.HasSize or TempWindowFeatures.HasPosition then
        begin
          TempChildForm := TChildForm.Create(self, TempArgs);
          TempChildForm.Show;
        end
       else
        TMainForm(Application.MainForm).CreateNewTab(TempArgs);

      FreeAndNil(TempWindowFeatures);
    end;
end;

procedure TBrowserFrame.WVBrowser1SourceChanged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
var
nama,url:string;
begin
  URLCbx.Text := WVBrowser1.Source;

begin
  nama := WVBrowser1.DocumentTitle;
  url := WVBrowser1.Source;
  UpdateNavButtons(False);
  MainForm.koneksi.ExecuteDirect('delete from histori where nama=' + QuotedStr(''));
  MainForm.koneksi.ExecuteDirect('delete from histori where url=' + QuotedStr(url));
  MainForm.koneksi.ExecuteDirect('INSERT INTO HISTORI (NAMA,URL,TANGGAL) values ('+
                                 QuotedStr(nama)+','+ QuotedStr(url) +',' +
                                 QuotedStr(DateToStr(now))+')');
  if mnDarkMode.Checked then
      ckDarkChange(sender);
end;

end;

procedure TBrowserFrame.ReloadBtnClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TBrowserFrame.StopBtnClick(Sender: TObject);
begin
  WVBrowser1.Stop;
end;

procedure TBrowserFrame.UpdateNavButtons(aIsNavigating : boolean);
begin

end;

procedure TBrowserFrame.BackBtnClick(Sender: TObject);
begin
  WVBrowser1.GoBack;
end;

procedure TBrowserFrame.ForwardBtnClick(Sender: TObject);
begin
  WVBrowser1.GoForward;
end;

procedure TBrowserFrame.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(URLCbx.Text);
end;

procedure TBrowserFrame.WVBrowser1AfterCreated(Sender: TObject);
begin

  if assigned(FArgs) and assigned(FDeferral) then
    try
      FArgs.NewWindow := WVBrowser1.CoreWebView2.BaseIntf;
      FArgs.Handled   := True;


      FDeferral.Complete;
    finally
      FreeAndNil(FDeferral);
      FreeAndNil(FArgs);
    end;

  WVWindowParent1.UpdateSize;
  //NavControlPnl.Enabled := True;
  WVBrowser1.CoreWebView2.Settings.Set_IsScriptEnabled(1);
  WVBrowser1.CoreWebView2.Settings.Set_IsWebMessageEnabled(1);
  WVBrowser1.CoreWebView2.Settings.Set_IsZoomControlEnabled(1);
  WVBrowser1.CoreWebView2Settings.IsGeneralAutofillEnabled:=true;
  WVBrowser1.CoreWebView2Settings.IsPasswordAutosaveEnabled:=true;
  WVBrowser1.CoreWebView2.Settings.Set_IsBuiltInErrorPageEnabled(1);
  AddHistori
end;

procedure TBrowserFrame.WVBrowser1RetrieveTextCompleted(Sender: TObject;
  aResult: boolean; const aText: wvstring);
begin
  Clipboard.AsText:= aText;
end;

procedure TBrowserFrame.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  if assigned(FOnBrowserTitleChange) then
    FOnBrowserTitleChange(self, WVBrowser1.DocumentTitle);
end;

procedure TBrowserFrame.PrintButtonClick(Sender: TObject);
begin
  if WVBrowser1.CoreWebView2 <> nil then
    begin
      // Memanggil dialog print bawaan browser
      WVBrowser1.CoreWebView2.ShowPrintUI(COREWEBVIEW2_PRINT_DIALOG_KIND_BROWSER);
    end;
end;

procedure TBrowserFrame.PrintPDFClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  WVBrowser1.PrintToPdf(SaveDialog1.FileName) ;

end;

procedure TBrowserFrame.SideBarShowClick(Sender: TObject);
begin
  if MainForm.pageLeft.Showing then
     MainForm.pageLeft.hide
  else
    MainForm.pageLeft.Show
end;

procedure TBrowserFrame.spAddTabClick(Sender: TObject);
begin
  MainForm.AddTabBtnClick(sender);
end;

procedure TBrowserFrame.spCleoClick(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

procedure TBrowserFrame.spCloseTabClick(Sender: TObject);
begin
  MainForm.RemoveTabBtnClick(sender);
end;

procedure TBrowserFrame.spReloadClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TBrowserFrame.TranslateBtnClick(Sender: TObject);
var
  JS:string;
begin
  JS := GetAutoTranslateScript('id');

    // Eksekusi Script
    WVBrowser1.ExecuteScript(JS);
end;

procedure TBrowserFrame.URLCbxChange(Sender: TObject);
begin

end;

procedure TBrowserFrame.URLCbxKeyPress(Sender: TObject; var Key: char);
var
  a,e,url:string;
begin
  if key=#13 then
    begin
      if AnsiMidStr(URLCbx.Text,1,4)='http' then
        begin
          WVBrowser1.Navigate(URLCbx.text);
        end
      else
      begin
      a := trim(URLCbx.text);
      e := cbEngine.text;
      if trim(URLCbx.text) <>'' then
         begin
           if e = 'Google' then
             url := 'https://www.google.com/search?q=' + a
           else if e = 'Bing' then
             url := 'https://www.bing.com/search?q=' + a
           else if e = 'Yahoo' then
             url := 'https://search.yahoo.com/search?p=' + a
           else if e = 'Yandex' then
             url := 'https://yandex.com/search/?text=' + a
           else if e = 'Brave' then
             url := 'https://search.brave.com/search?q=' + a + '&source=web'
           else if e = 'Ecosia' then
             url := 'https://www.ecosia.org/search?method=index&q=' + a;

         end;
      WVBrowser1.Navigate(url);

      end;
    end;

end;

procedure TBrowserFrame.WVBrowser1ContextMenuRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2ContextMenuRequestedEventArgs);
var
  ScreenPt: TPoint;
  url : Boolean;
  LArgs: TCoreWebView2ContextMenuRequestedEventArgs;
begin
  if aArgs <> nil then
    aArgs.Set_Handled(1);
    // Catatan: Pada beberapa versi WV4D lama kodenya mungkin: aArgs.Handled := True;

  // 2. Dapatkan koordinat mouse saat ini di layar (Screen Coordinates)
  // TPopupMenu membutuhkan koordinat layar keseluruhan, bukan koordinat form
  ScreenPt := Mouse.CursorPos;



  PopupMenu1.Popup(ScreenPt.X, ScreenPt.Y);

end;

procedure TBrowserFrame.BookMarkBtnClick(Sender: TObject);
var
 nama,url:string;
begin
 nama := WVBrowser1.DocumentTitle;
 url := WVBrowser1.Source;
 MainForm.koneksi.ExecuteDirect('delete from web where nama=''''');
 MainForm.koneksi.ExecuteDirect('delete from web where url='+ QuotedStr(url) );
 MainForm.koneksi.ExecuteDirect('INSERT INTO WEB (NAMA,URL) values ('+
                                QuotedStr(nama)+','+ QuotedStr(url) +')');
 MainForm.tpages.Refresh;
end;

procedure TBrowserFrame.cbEngineChange(Sender: TObject);
begin

end;

procedure TBrowserFrame.ckDarkChange(Sender: TObject);
begin


 end;

procedure TBrowserFrame.edtCariKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TBrowserFrame.GoBtn1Click(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

procedure TBrowserFrame.GoBtn3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TBrowserFrame.mnCalculatorClick(Sender: TObject);
begin
  MainForm.tbsCalculator.show ;
end;

procedure TBrowserFrame.mnDarkModeClick(Sender: TObject);
var
  LStyle : String;
begin

    ModeDark := mnDarkMode.Checked;

    if ModeDark=True then
     begin
       // Script untuk memberikan filter invert pada seluruh halaman
       // sambil tetap menjaga gambar dan video tetap normal (tidak terbalik warnanya)
       LStyle := 'if (!document.getElementById("dark-mode-filter")) {' +
                   '  var style = document.createElement("style");' +
                   '  style.id = "dark-mode-filter";' + // <--- Kuncinya di sini
                   '  style.innerHTML = "html { filter: invert(0.9) hue-rotate(180deg) !important; } ' +
                   '  img, video, iframe { filter: invert(1) hue-rotate(-180deg) !important; }";' +
                   '  document.head.appendChild(style);' +
                   '}';

       WVBrowser1.ExecuteScript(LStyle, 0);
    end
 else
   begin
    LStyle := 'var style = document.getElementById("dark-mode-filter");' +
             'if (style) { style.remove(); }';
    WVBrowser1.ExecuteScript(LStyle, 0);

   end;
end;

procedure TBrowserFrame.MnHapusDirClick(Sender: TObject);
begin

 if Dialogs.MessageDlg('Menghapus Seluruh Cache Browser  ?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
     WVBrowser1.ClearBrowsingDataAll;
     WVBrowser1.ClearCache;
     MainForm.koneksi.ExecuteDirect('delete from histori');
   end;

end;

procedure TBrowserFrame.mnInspecElementClick(Sender: TObject);
begin
  if (WVBrowser1 <> nil) and WVBrowser1.Initialized then
  begin
    // Membuka jendela Developer Tools (Inspect Element)
    WVBrowser1.OpenDevToolsWindow;
  end;
end;

procedure TBrowserFrame.mnLihatSourceClick(Sender: TObject);
var
  CurrentURL:string;
begin

  if (WVBrowser1 <> nil) and (WVBrowser1.CoreWebView2 <> nil) then
  begin
    // Ambil URL yang sedang aktif saat ini
    CurrentURL := WVBrowser1.CoreWebView2.Source;

    if CurrentURL <> '' then
    begin
        if mnLihatSource.Caption='Lihat Source' then
        begin
          WVBrowser1.Navigate('view-source:' + CurrentURL);
          mnLihatSource.Caption:='Lihat Halaman';
        end
        else if mnLihatSource.Caption='Lihat Halaman' then
        begin
          WVBrowser1.Navigate(URLCbx.text);
          mnLihatSource.Caption:='Lihat Source';

    end;
    end;
end;

end;

procedure TBrowserFrame.mnSalinkLinkClick(Sender: TObject);
begin
  Clipboard.AsText:= FLastClickedLink;
end;

procedure TBrowserFrame.mnBackClick(Sender: TObject);
begin
  if WVBrowser1.CanGoBack then
     WVBrowser1.GoBack;
end;

procedure TBrowserFrame.mnGoBookmarkClick(Sender: TObject);
begin

end;

procedure TBrowserFrame.mnGoFowardClick(Sender: TObject);
begin
     if WVBrowser1.CanGoForward then
     WVBrowser1.CanGoForward;
end;

procedure TBrowserFrame.mnHistoriClick(Sender: TObject);
begin
    MainForm.mnHistoriClick(sender);
    mnSideBar.Caption:='Sembunyikan Sidebar';
end;

procedure TBrowserFrame.mnOutClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TBrowserFrame.mnRefreshClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TBrowserFrame.mnResumeAIClick(Sender: TObject);
var
  u ,p,h : string;
begin

  u := WVBrowser1.Source;
  p := 'Role: Analis Konten Website , Silahkan analisis Link berikut ini "' +
        u + '". Tampilkan hasilnya dalam format HTML yang rapi dengan font Google sans';
  Application.ProcessMessages;
  h := GetInformationFromGemini(p);
  //MainForm.HtmlViewer1.LoadFromString(h);
  //MainForm.tbsAI.show;


end;

procedure TBrowserFrame.MenuItem2Click(Sender: TObject);
begin

end;

procedure TBrowserFrame.mnBookmarkClick(Sender: TObject);
begin
  MainForm.mnBookmarkClick(sender);
  mnSideBar.Caption:='Sembunyikan Sidebar';
end;

procedure TBrowserFrame.mnSaveTxtClick(Sender: TObject);
begin
  WVBrowser1.RetrieveText ;
end;

procedure TBrowserFrame.mnScheduleClick(Sender: TObject);
begin
   MainForm.tbsSchedule.show ;
end;

procedure TBrowserFrame.mnSideBarClick(Sender: TObject);
begin
    if MainForm.pnpageLeft.Showing then
    begin
     mnSideBar.Caption:='Sembunyikan Sidebar';
     MainForm.pnpageLeft.hide
    end
  else
  begin
    mnSideBar.Caption:='Tampilkan Sidebar';
    MainForm.pnpageLeft.Show
  end;
end;

procedure TBrowserFrame.mnStopClick(Sender: TObject);
begin
  WVBrowser1.stop;
end;

procedure TBrowserFrame.mnTentangCleoClick(Sender: TObject);
begin
  ShowMessage('CLeo Browser 2026' + #13#10 +
              'Basis : Edge 144 ' + #13#13 +
              'Pustaka : WebViewDriver4Delphi ' + #13#10 +
              'Kompiler : FreePascal 3.2' +#13#10 +    #13#10 +
              'By KangOzi') ;
end;

procedure TBrowserFrame.OpenFileBtnClick(Sender: TObject);
begin
  if ODHTML.Execute then
   begin
     WVBrowser1.Navigate(ODHTML.FileName);
   end;
end;

function TBrowserFrame.GetAutoTranslateScript(TargetLang: String): String;
begin
  // TargetLang contohnya: 'id' untuk Indonesia, 'en' untuk Inggris
  Result :=
    // 1. Cek apakah widget sudah ada agar tidak double
    'if (!document.getElementById("google_translate_element")) {' +

    // 2. (PENTING) Set Cookie untuk AUTO TRANSLATE tanpa klik
    // Format cookie googtrans: /auto/target_bahasa
    '  document.cookie = "googtrans=/auto/' + TargetLang + '; domain=." + document.domain + "; path=/";' +
    '  document.cookie = "googtrans=/auto/' + TargetLang + '; path=/";' +

    // 3. Buat DIV wadah (hidden atau visible, terserah Anda)
    '  var div = document.createElement("div");' +
    '  div.id = "google_translate_element";' +
    '  div.style.display = "none";' + // Kita hide saja karena sudah auto-translate via cookie
    '  document.body.insertBefore(div, document.body.firstChild);' +

    // 4. Fungsi inisialisasi Google Translate
    '  window.googleTranslateElementInit = function() {' +
    '    new google.translate.TranslateElement({' +
    '      pageLanguage: "auto",' +
    '      includedLanguages: "' + TargetLang + '",' + // Batasi bahasa
    '      layout: google.translate.TranslateElement.InlineLayout.SIMPLE,' +
    '      autoDisplay: false' +
    '    }, "google_translate_element");' +
    '  };' +

    // 5. Load Script Google
    '  var script = document.createElement("script");' +
    '  script.type = "text/javascript";' +
    '  script.src = "//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit";' +
    '  document.body.appendChild(script);' +
    '}';
end;

procedure TBrowserFrame.WVBrowser1DownloadStarting(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2DownloadStartingEventArgs);
var
  DownloadOp:ICoreWebView2DownloadOperation;
begin



end;

procedure TBrowserFrame.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(aErrorMessage);
end;
function TBrowserFrame.GetInformationFromGemini(s:string):string;
var

    json: TJSONData;
    content: string;
    Client: TFPHTTPClient;
    RequestBody: TMemoryStream;
    Response: TStringStream;
    QueryJSON: string;
    gemini_ac : string;
    t : TStringList;
    j : integer;
    apkey : string;
    ind : integer;
    AK :TStringList;
begin




    randomize;
    ind := RandomRange(0,3);
    try
      AK := TStringList.Create;

    AK.LoadFromFile(ExtractFilePath(Application.ExeName) + 'support/key.inf');
    apkey := AK.Strings[ind];


     // Persiapkan klien HTTP
    Client := TFPHTTPClient.Create(nil);
    Response := TStringStream.Create('');
    RequestBody := TMemoryStream.Create;


    gemini_ac:= 'https://generativelanguage.googleapis.com/v1beta/models/'+
                'gemini-3-flash-preview:generateContent?key='+trim(apkey) ;



    s  := AnsiReplaceStr(s,':','\:');
    s  := AnsiReplaceStr(s,'''','\''');
    s  := AnsiReplaceStr(s,'"','\"');
    s  := AnsiReplaceStr(s,'{','\{');
    s  := AnsiReplaceStr(s,'}','\}');
    s  := AnsiReplaceStr(s,'[','\[');
    s  := AnsiReplaceStr(s,']','\]');
    s  := AnsiReplaceStr(s,'-','\-');
    s  := AnsiReplaceStr(s,',','\,');
    s  := AnsiReplaceStr(s,';','\;');


    try
      // Persiapkan kueri dalam format JSON
      QueryJSON :=
        '{ '+
        '"contents": [{ '+
        '"parts": [{'+
        '"text": "'+ s + '" '+
        '}]'+
        '}] '+
        '}';
      RequestBody.Write(QueryJSON[1], Length(QueryJSON));
      RequestBody.Position := 0;

      Client.AddHeader('Content-Type', 'application/json');

      Client.RequestBody := RequestBody;
      Client.Post(gemini_ac, Response);

      // Tampilkan hasil respons
      json := GetJSON(Response.DataString) ;
      content := json.FindPath('candidates[0].content.parts[0].text').AsString;
      content := Trim(content);
      Result  := content;
    except
      on E: Exception do
      begin

        ShowMessage( 'Terdapat Error dalam Request , Coba Ulangi');
        Result := '';
      end;
    end;

    Client.Free;
    Response.Free;
    RequestBody.Free;

    finally
    AK.Free;
    end;


end;

end.
