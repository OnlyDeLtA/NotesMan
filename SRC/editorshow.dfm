object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Edit - NotesMan'
  ClientHeight = 561
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    DesignSize = (
      884
      40)
    object lbl1: TLabel
      Left = 12
      Top = 9
      Width = 32
      Height = 21
      Caption = 'Title:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object btn2: TSpeedButton
      Left = 846
      Top = 8
      Width = 26
      Height = 26
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        10000300000000020000120B0000120B00000000000000000000007C0000E003
        00001F000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FE818C718C614A5108510840C9C73C6182104210400000000
        0000FF7FFF7FFF7F091DF039D856CF35CF35C714BD772925323EB752CF35CF35
        0000FF7FFF7FFF7F2921F035195FAF31CF35C614FF7FA514323ED856AF31CF35
        2104FF7FFF7FFF7F2A25F035195FCF31AE314B29FF7F2921F039D856AF31CF35
        2204FF7FFF7FFF7FF0395342195FD7565446F03DFF7FCE35123ED856D7567446
        2925FF7FFF7FFF7F6C29E81C4B25E718C614E7185A6B6C2D630C8410630C4208
        4208FF7FFF7FFF7F5342964ACF35CF35AE318D2DA6144A25D035CF35AE31AE2D
        0000DE7BFF7FFF7FB652B752D035D035553E974A964A5542333EB02D8E2D323E
        8410FF7FFF7FFF7F7B6B33425342F0394A252A21D0358D2DB02D543E123A4A25
        3146FF7FFF7FFF7FFF7FAE315446323E5342E818FF7F2921CF35F039E818103E
        DE7BFF7FFF7FFF7FFF7FFF7FFF7F5342D8566C29FF7FCF357446744AFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7F744AB7525342FF7F754A5342CF35FF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7F}
      ParentFont = False
      OnClick = btn2Click
    end
    object edt1: TEdit
      Left = 51
      Top = 9
      Width = 787
      Height = 24
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSelect = False
      AutoSize = False
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnChange = edt1Change
      OnKeyPress = edt1KeyPress
    end
  end
  object pnl3: TPanel
    Left = 0
    Top = 40
    Width = 884
    Height = 481
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'pnl3'
    TabOrder = 1
    object RichEdit1: TRichEdit
      Left = 0
      Top = 0
      Width = 884
      Height = 481
      Align = alClient
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      PlainText = True
      PopupMenu = pm1
      ScrollBars = ssVertical
      TabOrder = 0
      WantTabs = True
      Zoom = 100
      OnChange = RichEdit1Change
      OnKeyDown = RichEdit1KeyDown
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 521
    Width = 884
    Height = 40
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 2
    object btn1: TSpeedButton
      Left = 12
      Top = 7
      Width = 74
      Height = 27
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        10000300000000020000120B0000120B00000000000000000000007C0000E003
        00001F000000FF7FFF7FFF7FFF7FFF7FFF7F3932182E3A363B3A3B363B363A36
        3936B5219419FB563932D7219719B71DB71D182A3D5FFB7FB063D46BD46BB163
        FB7F9B42B521F825BE77BE6F9E6F9E6F9E6FF829DD4EDC73EA420D4B0E4FEA42
        DC737B3EB51DD821BE6FFF36FF32FF32FF32182ADC4ADE73BD73BD73BD73BD73
        DE777A3ED521F821BE731F375F4F5F4F5F4B3832DC4A9B429B429B3E9B3E7B3E
        7A3A7A3AF72D1826BE73DE2ADE2ADE2ADE2A3932DC4E9B3E9B429B3E7A3E7A3E
        7A3E7A3E172E1822BE779F6B9F6B9F6B9F6B382EFD52FF7BFF7FFF7FFF7FFF7B
        FF7F9B42F7293826DE779F6B9F6B9F6B9F6B182EFD4EFF7F5936FF7FFF7FFF7B
        DF77BC463832382ADE779F6B9F6B9F6B9F6B39323E57FF7F1C5BFF7FFF7FFF7F
        FF7FFC523832382ADE779F6B9F6B9F6B9F6B5A367A3E593A9A4239365936793A
        793A38327D67382ADE779F6B9F6B9F679F677E637E635E5F5E5B5D5BDE771826
        FF7FFF7FFF7F382ADE779F679F679F677E677E635E5F9E6FBE77DF7BBE731826
        FF7FFF7FFF7F382ADE779F679F677F677E637E635E5FFF7B9F679E63DB429A42
        FF7FFF7FFF7F592EDE777E637F637F637E637E5F5E5BFF7B5E5BBB3E5B36FF7B
        FF7FFF7FFF7F9A3ADE77DE77DE77DE77DE77BE77BE779D6BDB3E5B36FF7BFF7F
        FF7FFF7FFF7F3C5BBA3E592E382A592A592A592A382A7936DB4AFF7BFF7FFF7F
        FF7FFF7FFF7F}
      ParentFont = False
      OnClick = btn1Click
    end
  end
  object dlgFind1: TFindDialog
    OnFind = dlgFind1Find
    Left = 504
    Top = 525
  end
  object pm1: TPopupMenu
    OnPopup = pm1Popup
    Left = 464
    Top = 525
    object Undo1: TMenuItem
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = Undo1Click
    end
    object Redo1: TMenuItem
      Caption = 'Redo'
      ShortCut = 24666
      OnClick = Redo1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 16472
      OnClick = Cut1Click
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = Copy1Click
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = Paste1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = Delete1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Repeat1: TMenuItem
      Caption = 'SelectAll   '
      ShortCut = 16449
      OnClick = Repeat1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object Find1: TMenuItem
      Caption = 'Find...'
      ShortCut = 16454
      OnClick = Find1Click
    end
  end
end
