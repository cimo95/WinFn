object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'WinFn 1.0'
  ClientHeight = 286
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lBanner: TLabel
    Left = 195
    Top = 258
    Width = 277
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Press CTRL+ALT+SHIFT+F12 to show / hide this program'
  end
  object lvDftKey: TListView
    Left = 8
    Top = 8
    Width = 345
    Height = 241
    Columns = <
      item
        Caption = 'Key'
      end
      item
        Caption = 'Status'
        Width = 60
      end
      item
        Caption = 'Command'
        Width = 200
      end
      item
        Caption = 'Mode'
        Width = 0
      end>
    ColumnClick = False
    Items.ItemData = {
      05E00600001600000000000000FFFFFFFFFFFFFFFF03000000FFFFFFFF000000
      00024600310008440069007300610062006C0065006400F81EB42F044E006F00
      6E006500301FB42F013000F020B42F00000000FFFFFFFFFFFFFFFF03000000FF
      FFFFFF00000000024600320008440069007300610062006C00650064008020B4
      2F044E006F006E0065002821B42F013000C81CB42F00000000FFFFFFFFFFFFFF
      FF03000000FFFFFFFF00000000024600330008440069007300610062006C0065
      0064004022B42F044E006F006E0065007822B42F013000282FB42F00000000FF
      FFFFFFFFFFFFFF03000000FFFFFFFF0000000002460034000844006900730061
      0062006C00650064004820B42F044E006F006E006500E822B42F013000982FB4
      2F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF0000000002460035000844
      0069007300610062006C00650064005823B42F044E006F006E0065009023B42F
      013000D02FB42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF0000000002
      4600360008440069007300610062006C00650064000024B42F044E006F006E00
      65003824B42F0130000830B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFF
      FF00000000024600370008440069007300610062006C0065006400A824B42F04
      4E006F006E006500E024B42F0130004030B42F00000000FFFFFFFFFFFFFFFF03
      000000FFFFFFFF00000000024600380008440069007300610062006C00650064
      005025B42F044E006F006E0065008825B42F0130007830B42F00000000FFFFFF
      FFFFFFFFFF03000000FFFFFFFF00000000024600390008440069007300610062
      006C0065006400F825B42F044E006F006E0065003026B42F013000B030B42F00
      000000FFFFFFFFFFFFFFFF03000000FFFFFFFF00000000034600310030000844
      0069007300610062006C0065006400A026B42F044E006F006E006500D826B42F
      013000E830B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF0000000003
      46003100310008440069007300610062006C00650064004827B42F044E006F00
      6E0065008027B42F0130002031B42F00000000FFFFFFFFFFFFFFFF03000000FF
      FFFFFF000000000346003100320008440069007300610062006C0065006400F0
      27B42F044E006F006E0065002828B42F0130005831B42F00000000FFFFFFFFFF
      FFFFFF03000000FFFFFFFF00000000054E0055004D0020003000084400690073
      00610062006C00650064009828B42F044E006F006E006500D028B42F01300090
      31B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF00000000054E005500
      4D002000310008440069007300610062006C00650064004029B42F044E006F00
      6E0065007829B42F013000C831B42F00000000FFFFFFFFFFFFFFFF03000000FF
      FFFFFF00000000054E0055004D002000320008440069007300610062006C0065
      006400E829B42F044E006F006E006500202AB42F0130000032B42F00000000FF
      FFFFFFFFFFFFFF03000000FFFFFFFF00000000054E0055004D00200033000844
      0069007300610062006C0065006400902AB42F044E006F006E006500C82AB42F
      0130003832B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF0000000005
      4E0055004D002000340008440069007300610062006C0065006400382BB42F04
      4E006F006E006500702BB42F0130007032B42F00000000FFFFFFFFFFFFFFFF03
      000000FFFFFFFF00000000054E0055004D002000350008440069007300610062
      006C0065006400E02BB42F044E006F006E006500182CB42F013000A832B42F00
      000000FFFFFFFFFFFFFFFF03000000FFFFFFFF00000000054E0055004D002000
      360008440069007300610062006C0065006400882CB42F044E006F006E006500
      C02CB42F013000E032B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF00
      000000054E0055004D002000370008440069007300610062006C0065006400F0
      2EB42F044E006F006E006500B82EB42F0130001833B42F00000000FFFFFFFFFF
      FFFFFF03000000FFFFFFFF00000000054E0055004D0020003800084400690073
      00610062006C0065006400102EB42F044E006F006E006500D82DB42F01300050
      33B42F00000000FFFFFFFFFFFFFFFF03000000FFFFFFFF00000000054E005500
      4D002000390008440069007300610062006C00650064000822B42F044E006F00
      6E006500001DB42F0130008833B42FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvDftKeyDblClick
  end
  object pCtrl: TPanel
    Left = 359
    Top = 8
    Width = 200
    Height = 241
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object lModeKey: TLabel
      Left = 8
      Top = 16
      Width = 58
      Height = 13
      Caption = 'Key Name : '
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 38
      Height = 13
      Caption = 'Status :'
    end
    object Label4: TLabel
      Left = 8
      Top = 62
      Width = 57
      Height = 13
      Caption = 'Command : '
    end
    object lStat: TLabel
      Left = 8
      Top = 216
      Width = 3
      Height = 13
    end
    object cmbDftKey: TComboBox
      Left = 69
      Top = 13
      Width = 57
      Height = 21
      Hint = 'Select which key you want to modify'
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'F1'
      OnChange = cmbDftKeyChange
      Items.Strings = (
        'F1'
        'F2'
        'F3'
        'F4'
        'F5'
        'F6'
        'F7'
        'F8'
        'F9'
        'F10'
        'F11'
        'F12'
        'NUM 0'
        'NUM 1'
        'NUM 2'
        'NUM 3'
        'NUM 4'
        'NUM 5'
        'NUM 6'
        'NUM 7'
        'NUM 8'
        'NUM 9')
    end
    object cmbCmd: TComboBox
      Left = 69
      Top = 59
      Width = 116
      Height = 21
      Hint = 'Select the command type'
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'System Command'
      OnChange = cmbCmdChange
      Items.Strings = (
        'System Command'
        'Application Shell')
    end
    object gbSysCmd: TGroupBox
      Left = 8
      Top = 86
      Width = 185
      Height = 123
      Caption = 'System Command'
      TabOrder = 5
      object cmbDftSysCmd: TComboBox
        Left = 8
        Top = 54
        Width = 170
        Height = 21
        Hint = 'Choose windows hidden shortcut command'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'None'
        Items.Strings = (
          'None'
          'Brightness - Increase'
          'Brightness - Decrease'
          'Volume - Increase'
          'Volume - Decrease'
          'Volume - Mute'
          'Playback - Next'
          'Playback - Previous'
          'Playback - Play/Pause'
          'Playback - Stop'
          'Playback - Select'
          'Browser - Back'
          'Browser - Forward'
          'Browser - Refresh'
          'Browser - Stop'
          'Browser - Search'
          'Browser - Bookmark'
          'Browser - Home'
          'System - Sleep'
          'System - Application'
          'System - Toggle WiFi (Admin)')
      end
    end
    object bSet: TButton
      Left = 119
      Top = 210
      Width = 75
      Height = 25
      Hint = 'Apply the changes you have made'
      Caption = 'APPLY'
      TabOrder = 6
      OnClick = bSetClick
    end
    object gbAppShl: TGroupBox
      Left = 8
      Top = 86
      Width = 185
      Height = 123
      Caption = 'Application Shell'
      TabOrder = 4
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 18
        Width = 87
        Height = 13
        Caption = 'Application Path : '
      end
      object Label3: TLabel
        Left = 9
        Top = 64
        Width = 110
        Height = 13
        Caption = 'Additional Parameter : '
      end
      object eAppPath: TEdit
        Left = 8
        Top = 35
        Width = 170
        Height = 21
        Hint = 'Click to add your favorite application path'
        ReadOnly = True
        TabOrder = 0
        OnClick = eAppPathClick
      end
      object eAppParam: TEdit
        Left = 8
        Top = 81
        Width = 170
        Height = 21
        Hint = 'Put your application parameter (if necessary)'
        TabOrder = 1
      end
    end
    object rbStatusE: TRadioButton
      Left = 52
      Top = 40
      Width = 58
      Height = 17
      Hint = 'Allow this key to perform the given command'
      Caption = 'Enabled'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbStatusD: TRadioButton
      Left = 116
      Top = 40
      Width = 61
      Height = 17
      Hint = 'Deny this key to perform the given command'
      Caption = 'Disabled'
      TabOrder = 2
    end
  end
  object bStartup: TButton
    Left = 8
    Top = 253
    Width = 97
    Height = 25
    Hint = 'Enable or Disable WinFn execution while you logged in'
    Caption = 'ENABLE STARTUP'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = bStartupClick
  end
  object bClose: TButton
    Left = 110
    Top = 253
    Width = 75
    Height = 25
    Hint = 'Terminate and close WinFn '
    Caption = 'CLOSE'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = bCloseClick
  end
  object bHowTo: TButton
    Left = 484
    Top = 253
    Width = 75
    Height = 25
    Hint = 'Show simple tutorial about how to using this program'
    Caption = 'HOWTO'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = bHowToClick
  end
  object odAppPath: TOpenDialog
    Filter = 'Application|*.exe'
    Options = [ofHideReadOnly, ofNoNetworkButton, ofDontAddToRecent, ofForceShowHidden]
    Title = 'Select Application Path'
    Left = 240
    Top = 104
  end
  object td: TTaskDialog
    Buttons = <>
    Caption = 'About'
    CommonButtons = [tcbOk]
    RadioButtons = <>
    Text = 
      'A simple program to enables dedicated hotkey for your standard k' +
      'eyboard :)'#13#10#13#10'Version : 1.0'#13#10'Programmer : Arachmadi Putra (githu' +
      'b.com/cimo95)'#13#10#13#10'This program is open source, please visit XXX t' +
      'o download the source code.'#13#10'Please make sure you have latest Em' +
      'barcadero Delphi before using the source code.'
    Title = 'WinFn'
    Left = 184
    Top = 120
  end
  object tBanner: TTimer
    Interval = 3000
    OnTimer = tBannerTimer
    Left = 320
    Top = 64
  end
end
