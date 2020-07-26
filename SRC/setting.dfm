object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Preferences - NotesMan'
  ClientHeight = 290
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 256
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    object grp1: TGroupBox
      Left = 7
      Top = 8
      Width = 354
      Height = 113
      Caption = 'General'
      TabOrder = 0
      object chk1: TCheckBox
        Left = 19
        Top = 24
        Width = 158
        Height = 17
        Caption = 'Rememer window position'
        TabOrder = 0
      end
      object chk2: TCheckBox
        Left = 19
        Top = 47
        Width = 145
        Height = 17
        Caption = 'Remember window size'
        TabOrder = 1
      end
      object chk3: TCheckBox
        Left = 19
        Top = 70
        Width = 182
        Height = 17
        Caption = 'OnExit minimize to system tray'
        TabOrder = 2
      end
    end
    object grp2: TGroupBox
      Left = 7
      Top = 134
      Width = 354
      Height = 112
      Caption = 'Editor'
      TabOrder = 1
      object lbl1: TLabel
        Left = 195
        Top = 25
        Width = 53
        Height = 13
        Caption = 'Font Size: '
      end
      object chk4: TCheckBox
        Left = 19
        Top = 24
        Width = 166
        Height = 17
        Caption = 'Remember window position'
        TabOrder = 0
      end
      object chk5: TCheckBox
        Left = 19
        Top = 47
        Width = 145
        Height = 17
        Caption = 'Remember window size'
        TabOrder = 1
      end
      object cbb1: TComboBox
        Left = 252
        Top = 22
        Width = 88
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          '10'
          '11'
          '12'
          '13'
          '14'
          '15')
      end
      object chk6: TCheckBox
        Left = 19
        Top = 70
        Width = 182
        Height = 17
        Caption = 'Auto Save notes OnExit'
        TabOrder = 3
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 256
    Width = 369
    Height = 34
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    object btn2: TButton
      Left = 88
      Top = 3
      Width = 70
      Height = 23
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btn2Click
    end
    object btn3: TButton
      Left = 7
      Top = 3
      Width = 70
      Height = 23
      Caption = 'OK'
      TabOrder = 1
      OnClick = btn3Click
    end
  end
end
