object fDlgSearchIcon: TfDlgSearchIcon
  Left = 112
  Top = 306
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 'Pesquisar '#237'cones'
  ClientHeight = 223
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    362
    223)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 32
    Height = 32
  end
  object Label1: TLabel
    Left = 48
    Top = 8
    Width = 131
    Height = 13
    Caption = 'Extraindo '#237'cone do arquivo:'
  end
  object lblFileName: TLabel
    Left = 48
    Top = 24
    Width = 305
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 48
    Top = 72
    Width = 109
    Height = 13
    Caption = 'Progresso da extra'#231#227'o:'
  end
  object lblIconName: TLabel
    Left = 160
    Top = 72
    Width = 193
    Height = 13
    AutoSize = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 48
    Top = 112
    Width = 96
    Height = 13
    Caption = 'Verificando diret'#243'rio:'
  end
  object lblDirectory: TLabel
    Left = 48
    Top = 128
    Width = 305
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 187
    Width = 345
    Height = 2
    Style = bsRaised
  end
  object Label4: TLabel
    Left = 28
    Top = 205
    Width = 43
    Height = 13
    Caption = 'Minimizar'
  end
  object lblDeletado: TLabel
    Left = 208
    Top = 8
    Width = 53
    Height = 13
    Caption = 'lblDeletado'
  end
  object ProgressBar1: TProgressBar
    Left = 48
    Top = 88
    Width = 305
    Height = 16
    Smooth = True
    TabOrder = 0
  end
  object Button2: TButton
    Left = 143
    Top = 194
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cancelar'
    Default = True
    TabOrder = 1
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 280
    Top = 194
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    Visible = False
    Kind = bkClose
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 17
    Height = 17
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object imgList: TImageList
    Height = 32
    Width = 32
    Left = 232
    Top = 150
  end
end
