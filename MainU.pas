unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Threading, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.JSON,
  Winapi.ShellAPI, System.Win.Registry, System.Generics.Collections;

type
  TFormMain = class(TForm)
    lvDftKey: TListView;
    pCtrl: TPanel;
    lModeKey: TLabel;
    cmbDftKey: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    cmbCmd: TComboBox;
    gbSysCmd: TGroupBox;
    cmbDftSysCmd: TComboBox;
    bSet: TButton;
    gbAppShl: TGroupBox;
    Label1: TLabel;
    eAppPath: TEdit;
    eAppParam: TEdit;
    Label3: TLabel;
    rbStatusE: TRadioButton;
    rbStatusD: TRadioButton;
    lStat: TLabel;
    odAppPath: TOpenDialog;
    bStartup: TButton;
    bClose: TButton;
    bHowTo: TButton;
    td: TTaskDialog;
    lBanner: TLabel;
    tBanner: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbCmdChange(Sender: TObject);
    procedure lvDftKeyDblClick(Sender: TObject);
    procedure bSetClick(Sender: TObject);
    procedure cmbDftKeyChange(Sender: TObject);
    procedure eAppPathClick(Sender: TObject);
    procedure bHowToClick(Sender: TObject);
    procedure tBannerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bStartupClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey(var _a: TWMHotKey); message WM_HOTKEY;
    procedure WMNclbuttondown(var _a: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNclbuttonup(var _a: TWMNCLButtonUp); message WM_NCLBUTTONUP;
    procedure RunCmd(_a: Integer);
  public
    hotkeyMain: Integer;
    bStartupExists: Boolean;
  end;

var
  FormMain: TFormMain;
  hotkey: array[0..20] of Integer = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0);
  sStatus: array[Boolean] of string = ('Enabled', 'Disabled');
  sBanner: array[0..2] of string = ('Press CTRL+ALT+SHIFT+F12 to show / hide WinFn',
    'Press WIN+[key] to perform the command',
    'Command failed if similar key used by other program');

const
  vkBaseKey: array[0..21] of Integer = (VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6,
    VK_F7, VK_F8, VK_F9, VK_F10, VK_F11, VK_F12, VK_NUMPAD0, VK_NUMPAD1,
    VK_NUMPAD2, VK_NUMPAD3, VK_NUMPAD4, VK_NUMPAD5, VK_NUMPAD6, VK_NUMPAD7,
    VK_NUMPAD8, VK_NUMPAD9);
  vkSysCmd: array[0..16] of Integer = (VK_VOLUME_UP, VK_VOLUME_DOWN,
    VK_VOLUME_MUTE, VK_MEDIA_NEXT_TRACK, VK_MEDIA_PREV_TRACK,
    VK_MEDIA_PLAY_PAUSE, VK_MEDIA_STOP, VK_LAUNCH_MEDIA_SELECT, VK_BROWSER_BACK,
    VK_BROWSER_FORWARD, VK_BROWSER_REFRESH, VK_BROWSER_STOP, VK_BROWSER_SEARCH,
    VK_BROWSER_FAVORITES, VK_BROWSER_HOME, VK_SLEEP, VK_APPS);

implementation

{$R *.dfm}
procedure saveLVtoJSON(_a: TListView; _b: string; _c: Boolean = False);
var
  a, b: Integer;
  c: TJSONArray;
  d: TJSONObject;
  e: TStringList;
begin
  try
    c := TJSONArray.Create;
    for a := 0 to _a.Items.Count - 1 do
    begin
      d := TJSONObject.Create;
      c.AddElement(d);
      if not _c then
      begin
        d.AddPair('0', _a.Items.Item[a].Caption);
        for b := 1 to _a.Columns.Count - 1 do
          d.AddPair(b.ToString, _a.Items.Item[a].SubItems.Strings[b - 1]);
      end
      else
      begin
        d.AddPair(_a.Columns.Items[0].Caption, _a.Items.Item[a].Caption);
        for b := 1 to _a.Columns.Count - 1 do
          d.AddPair(_a.Columns.Items[b].Caption, _a.Items.Item[a].SubItems.Strings
            [b - 1]);
      end;

      e := TStringList.Create;
      e.Text := c.Format(0);
      e.SaveToFile(_b);
      e.Free;
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Unable to generate data from ListView'#13'Error : '
        + e.Message);
    end;
  end;
end;

procedure loadLVfromJSON(_a: TListView; _b: string; _c: Boolean = False);
var
  a, b: Integer;
  c: TJSONArray;
  d: TJSONObject;
  e: TStringList;
  f: TListItem;
begin
  e := TStringList.Create;
  e.LoadFromFile(_b);
  c := TJSONObject.ParseJSONValue(e.Text) as TJSONArray;
  d := c.Items[0] as TJSONObject;
  if d.Count <> _a.Columns.Count then
    raise Exception.Create('Column count mismatch ! ');
  try
    _a.items.clear;
    for a := 0 to c.Count - 1 do
    begin
      f := _a.Items.Add;
      d := c.Items[a] as TJSONObject;
      if not _c then
      begin
        f.Caption := d.GetValue('0').Value;
        for b := 1 to _a.Columns.Count - 1 do
          f.SubItems.Add(d.GetValue(b.ToString).Value);
      end
      else
      begin
        f.Caption := d.GetValue(_a.Columns.Items[0].Caption).Value;
        for b := 1 to _a.Columns.Count - 1 do
          f.SubItems.Add(d.GetValue(_a.Columns.Items[b].Caption).Value);
      end;
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Unable to generate data to ListView'#13'Error : '
        + e.Message);
    end;
  end;
end;

function GetMonitorBrightness(hMonitor: THandle; var pdwMinimumBrightness: DWORD;
  var pdwCurrentBrightness: DWORD; var pdwMaximumBrightness: DWORD): Boolean;
  stdcall; external 'Dxva2.dll' name 'GetMonitorBrightness';

function SetMonitorBrightness(hMonitor: THandle; dwNewBrightness: DWORD):
  Boolean; stdcall; external 'Dxva2.dll' name 'SetMonitorBrightness';

type
  LPPHYSICAL_MONITOR = record
    hPhysicalMonitor: THandle;
    szPhysicalMonitorDescription: array[0..127] of WideChar;
  end;

  PLPPHYSICAL_MONITOR = ^LPPHYSICAL_MONITOR;

function GetPhysicalMonitorsFromHMONITOR(HMONITOR: HMONITOR;
  dwPhysicalMonitorArraySize: DWORD; pPhysicalMonitorArray: PLPPHYSICAL_MONITOR):
  Boolean; stdcall; external 'Dxva2.dll' name 'GetPhysicalMonitorsFromHMONITOR';

procedure Brightness(_a: Boolean);
var
  a, b, c: DWORD;
  d: HMONITOR;
  e: LPPHYSICAL_MONITOR;
  f: Integer;
begin
  for f := 0 to Screen.MonitorCount - 1 do
  begin
    d := Screen.Monitors[f].Handle;
    if GetPhysicalMonitorsFromHMONITOR(d, 1, @e) then
    begin
      GetMonitorBrightness(e.hPhysicalMonitor, a, b, c);
      if _a then
      begin
        if b <= c then
          SetMonitorBrightness(e.hPhysicalMonitor, b + 10);
      end
      else
      begin
        if b >= 10 then
          SetMonitorBrightness(e.hPhysicalMonitor, b - 10);
      end;
    end;
  end;
  GetMonitorBrightness(e.hPhysicalMonitor, a, b, c);
end;

procedure RunSysCmd(_a: Integer);
begin
  try
    case _a of
      0:
        Exit;
      1:
        Brightness(True);
      2:
        Brightness(False);
    else
      if _a in [3..19] then
      begin
        keybd_event(vkSysCmd[_a - 3], 0, 0, 0);
        keybd_event(vkSysCmd[_a - 3], 0, 2, 0);
      end;
    end;
  except
    on e: Exception do
    begin
      ShowMessage('An error occured :'#13'RunSysCmd(' + _a.toString + ') : ' + e.message);
    end;
  end;
end;

procedure TFormMain.RunCmd(_a: Integer);
var
  a: TStringList;
  b: Integer;
begin
  try
    a := TStringList.create;
    for b := 0 to lvDftKey.items.count - 1 do
      if _a = hotkey[b] then
        Break;
    a.text := lvDftKey.items.item[b].subitems.strings[2];
    if a[0] = '-1' then
    begin
      if a[1] = '0' then
        RunSysCmd(a[2].toInteger)
      else
        ShellExecute(0, 'open', PWideChar(a[2]), PWideChar(a[3]), nil, SW_NORMAL);
    end;
    a.free;
  except
    on e: Exception do
    begin
      ShowMessage('An error occured :'#13'RunCmd(' + _a.toString + ') : ' + e.message);
    end;
  end;
end;

procedure TFormMain.WMHotkey(var _a: TWMHotKey);
begin
  if _a.HotKey = hotkeyMain then
  begin
    if not FormMain.Visible then
    begin
      FormMain.Show;
      FormMain.FormStyle := fsStayOnTop;
      FormMain.SetFocus;
      FormMain.FormStyle := fsNormal;
    end
    else
      FormMain.Hide;
  end
  else
    RunCmd(_a.hotkey);
end;

procedure TFormMain.WMNclbuttondown(var _a: TWMNCLButtonDown);
begin
  if _a.HitTest = HTHELP then
    _a.Result := 0
  else
    inherited;
end;

procedure TFormMain.WMNclbuttonup(var _a: TWMNCLButtonUp);
begin
  if _a.HitTest = HTHELP then
  begin
    _a.Result := 0;
    td.Caption := 'About';
    td.Text :=
      'A simple program to enables custom hotkey for your standard keyboard :)'#13#10#13#10 +
      'Version : 1.0'#13#10 +
      'Programmer : Arachmadi Putra (github.com/cimo95)'#13#10#13#10 +
      'This program is open source,'#13'please visit https://github.com/cimo95/WinFn'#13'to download the source code.'#13#10;
    td.title := 'WinFn';
    td.Execute;
  end
  else
    inherited;
end;

procedure TFormMain.bSetClick(Sender: TObject);
var
  tslKeyItemValue: TStringList;
begin
  {if System Command is None or Application Path is blank, Status will be set to Disabled}
  if ((cmbCmd.itemindex = 0) and (cmbDftSysCmd.itemindex = 0)) or ((cmbCmd.itemindex
    = 1) and (eAppPath.text = '')) then
    rbStatusD.checked := True;

  {if F1 enabled, show warning.}
  if (cmbDftKey.itemindex = 0) and (rbStatusE.checked) then
    if MessageBox(Handle,
      'Beware, assigned command to F1 key (WIN+F1) may be ignored due to conflict with Windows help hotkey.',
      'F1 Key', 48 + 4) = mrNo then
      Exit;

  {Show applying status (this is mostly not visible on fast computer lol)}
  lStat.caption := 'Appliying...';
  Application.processmessages;

  {Create string bowl to put the item setting, to ease us while reading it back later}
  tslKeyItemValue := TStringList.create;

  try
    {lock lvDftKey for item updates}
    lvDftKey.items.beginupdate;

    {replacing current item key status (Enabled / Disabled)}
    lvDftKey.Items.Item[cmbDftKey.itemindex].subitems.strings[0] := sStatus[not
      rbStatusE.checked];
    {write key status mode to bowl}
    tslKeyItemValue.Add(BoolToStr(rbStatusE.checked));
    {write command type index number to bowl}
    tslKeyItemValue.Add(cmbCmd.itemindex.ToString);

    {if command type is System Command then...}
    if cmbCmd.itemindex = 0 then
    begin
      {replace current item key command to selected System Command item name}
      lvDftKey.Items.Item[cmbDftKey.itemindex].subitems.strings[1] :=
        cmbDftSysCmd.items.Strings[cmbDftSysCmd.itemindex];
      {write selected System Command index number to bowl}
      tslKeyItemValue.Add(cmbDftSysCmd.itemindex.tostring);
    end
    else
    {if command type is Application Shell then...}
    begin
      {replace current item key command to Application Path # Application Parameter}
      lvDftKey.Items.Item[cmbDftKey.itemindex].subitems.strings[1] := eAppPath.text
        + ' # ' + eAppParam.text;
      {write application path to bowl}
      tslKeyItemValue.add(eAppPath.text);
      {write application parameter to bowl}
      tslKeyItemValue.Add(eAppParam.text);
    end;

    {put all bowl contents into hidden Mode column}
    lvDftKey.Items.Item[cmbDftKey.itemindex].subitems.strings[2] := tslKeyItemValue.text;
    lvDftKey.Items.EndUpdate;

    lStat.caption := 'Saving...';
    Application.processmessages;

    {save the listview to file}
    saveLVtoJSON(lvDftKey, ChangeFileExt(Application.exename, '.json'));
  finally
    {dispose the bowl}
    tslKeyItemValue.free;
  end;

  lStat.caption := '';
  Application.processmessages;
end;

procedure TFormMain.bStartupClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  {Create registry object}
  Reg := TRegistry.Create;
  try
    {Setting up registry Root}
    Reg.RootKey := HKEY_CURRENT_USER;
    {If startup value for WinFn exists then...}
    if bStartupExists then
    begin
      {Ask user if they want to delete it or not}
      if MessageBox(Handle,
        'If the startup is disabled, WinFn will not run automatically while you logged on.'#13 +
        'Are you sure you want to disable startup? ', 'Disable Startup', 48 + 4)
        = mrYes then
      begin
        {Delete the startup value}
        if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
        begin
          Reg.DeleteValue('Cimosoft WinFn');
          Reg.CloseKey;
          bStartup.Caption := 'ENABLE STARTUP';
          bStartupExists := False;
        end;
      end;
    end    {If startup value for WinFn NOT exists then...}
    else
    {Ask user if they want to create it or not}
      if MessageBox(Handle,
      'If the startup is enabled, WinFn will run immediately after you logged on.'#13 +
      'Are you sure you want to enable startup? ', 'Disable Startup', 64 + 4) = mrYes then
    begin
      {Create the startup value}
      if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
      begin
        Reg.WriteString('Cimosoft WinFn', Application.exename + ' /anteng');
        Reg.CloseKey;
        bStartup.Caption := 'DISABLE STARTUP';
        bStartupExists := True;
      end;
    end
  finally
    Reg.Free
  end;

end;

procedure TFormMain.bCloseClick(Sender: TObject);
begin
  {Ask user if they want to terminate WinFn}
  if MessageBox(Handle,
    'This will terminate WinFn. If you just want to close this window, and keep WinFn running, please click the X button at the top right of this window instead.'#13#13 +
    'Are you sure you want to terminate WinFn?', 'Close', 48 + 4) = mrYes then
  begin
    Application.terminate;
  end;
end;

procedure TFormMain.bHowToClick(Sender: TObject);
begin
  td.Caption := 'How To';
  td.Text := '1. Choose which key you want to assign on "Key Name".'#13#10 +
    '2. Change the "Status" to "Enabled".'#13#10 +
    '3. Choose which kind of command you want to perform while pressing WIN + Selected Key'#13#10 +
    '4a. If "System Command" selected, you can choose one from 16 Windows hidden shortcuts(*).'#13#10 +
    '4b. If "Application Shell" selected, you can add your favorite app following with its parameter (optional).'#13#10 +
    '5. Click "Apply", the changes should be appeared on the list.'#13#10#13#10 +
    '(*) : These shortcuts are usually used on laptop''s special function key, or keyboard with dedicated hotkey.';
  td.title := 'Usage of WinFn';
  td.Execute;
end;

procedure TFormMain.cmbCmdChange(Sender: TObject);
begin
  {Show System Command group box if System Command command type selected}
  gbSysCmd.visible := cmbCmd.itemindex = 0;
  {Show Application SHell group box if Application Shell command type selected}
  gbAppShl.Visible := cmbCmd.ItemIndex = 1;
end;

procedure TFormMain.cmbDftKeyChange(Sender: TObject);
begin
  {Set the key list item selection index to equal with Key Name index}
  lvDftKey.itemindex := cmbDftKey.itemindex;
  {Simulate key list item doubleclick}
  lvDftKeyDblClick(FormMain);
end;

procedure TFormMain.eAppPathClick(Sender: TObject);
begin
  {Show open dialog to let user choose which app they want to add}
  if not odAppPath.execute then
    Exit
  else
    eAppPath.text := odAppPath.filename;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormMain.hide;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  FormMain.hide;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  i: Integer;
  Reg: TRegistry;
begin
  lStat.caption := 'Initializing...';
  Application.processmessages;

  {Checking if startup value for WinFn already exists, and store the result to bStartupExists}
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
      bStartupExists := Reg.valueexists('Cimosoft WinFn');
  finally
    Reg.Free;
  end;

  {Change the bStartup caption according to bStartupExists value}
  if bStartupExists then
    bStartup.Caption := 'DISABLE STARTUP'
  else
    bStartup.Caption := 'ENABLE STARTUP';

  {Since we can't put #13 character directly, we initialize all Mode contents with it by this way}
  lvDftKey.items.BeginUpdate;
  for i := 0 to lvDftKey.items.count - 1 do
    lvDftKey.items.item[i].subitems.strings[2] := '0'#13'0'#13'0';
  lvDftKey.items.EndUpdate;

  {if key list data exists, load it}
  if FileExists(ChangeFileExt(Application.exename, '.json')) then
    loadLVfromJSON(lvDftKey, ChangeFileExt(Application.exename, '.json'));

  {Simulate doubleclick of one item on key list, so it can fill up the editor}
  lvDftKey.itemindex := 1;
  lvDftKeyDblClick(FormMain);

  {Register all listed keys to system}
  for i := 0 to Length(hotkey) - 1 do
  begin
    hotkey[i] := GlobalAddAtom(PWideChar('WinFnHot-' + i.toString));
    RegisterHotKey(Handle, hotkey[i], MOD_WIN, vkBaseKey[i]);
  end;

  {Register main key to show / hide the window to system}
  hotkeyMain := GlobalAddAtom('WinFnMain');
  RegisterHotKey(Handle, hotkeyMain, MOD_CONTROL + MOD_ALT + MOD_SHIFT, VK_F12);
  lStat.caption := '';
  Application.processmessages;

  if AnsiLowerCase(ParamStr(1)) = '/anteng' then
    FormMain.hide;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  {Unregister all listed keys from system}
  for i := 0 to Length(hotkey) - 1 do
    UnregisterHotKey(Handle, hotkey[i]);
  {Unregister main key from system}
  UnregisterHotKey(Handle, hotkeyMain);
end;

procedure TFormMain.lvDftKeyDblClick(Sender: TObject);
var
  tslKeyItemValue: TStringList;
begin
  eapppath.clear;
  eAppParam.Clear;

  {setting Key Name item index to equal with selected key list item index}
  cmbDftKey.itemindex := lvDftKey.itemindex;

  {Create string bowl to read the item setting}
  tslKeyItemValue := TStringList.create;
  {Read setting from Mode column of current selected key list item to bowl}
  tslKeyItemValue.Text := lvDftKey.items.item[lvDftKey.itemindex].subitems.strings[2];

  {Checking Status value from bowl}
  rbStatusE.Checked := tslKeyItemValue[0] = '-1';
  rbStatusD.checked := not rbStatusE.checked;

  {Checking Command type from bowl}
  cmbCmd.itemindex := tslKeyItemValue[1].toInteger;
  cmbCmdChange(FormMain);

  {if Command type is System Command then set value to...}
  if tslKeyItemValue[1] = '0' then
    {System Command item index}
    cmbDftSysCmd.itemindex := tslKeyItemValue[2].toInteger
  else
  {if Command type is Application Shell then set value to...}
  begin
    {Application Shell Application Path}
    eAppPath.text := tslKeyItemValue[2];
    {Application Shell Application Parameter}
    eAppParam.Text := tslKeyItemValue[3];
  end;
  {Dispose the bowl}
  tslKeyItemValue.free;
end;

procedure TFormMain.tBannerTimer(Sender: TObject);
begin
  {Cycle of displaying banner text between CLOSE and HOWTO button}
  tBanner.tag := tBanner.Tag + 1;
  if tBanner.Tag > Length(sBanner) - 1 then
    tBanner.Tag := 0;
  lBanner.caption := sBanner[tBanner.tag];
end;

end.

