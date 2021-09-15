program CSWinFn;

uses
  Vcl.Forms,
  MainU in 'MainU.pas' {FormMain},
  Winapi.Windows;

{$R *.res}

(*
* Written from scratch by :
* Arachmadi Putra (github.com/cimo95)
* https://cimosoft.com
*)

function Singleton(const sInstance: string): Boolean;
var
  hMutex: THandle;
begin
  hMutex := CreateMutex(nil, False, PChar(sInstance));
  if (hMutex <> 0) then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      Result := False;
      CloseHandle(hMutex);
    end
    else
      Result := True;
  end
  else
    Result := False;
end;

var
  i: integer;

begin
  Application.Initialize;
  {Making sure only one instance can run, if there's another instance that already run
  simulate press CTRL+ALT+SHIFT+F12 to bring up the existed instance and terminate current
  new instance. Simulating the key also hide the existed instance if its already shown.}
  if Singleton('CobaWinFn') then
  begin
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFormMain, FormMain);
    Application.HintPause := 0;
    Application.HintHidePause := 30000;
    Application.Run;
  end
  else
  begin
    for i in [VK_CONTROL, VK_MENU, VK_SHIFT, VK_F12] do
      keybd_event(i, 0, 0, 0);
    for i in [VK_CONTROL, VK_MENU, VK_SHIFT, VK_F12] do
      keybd_event(i, 0, 2, 0);
    application.Terminate;
  end;
end.

