object frmLocalization: TfrmLocalization
  Left = 0
  Top = 0
  Caption = 'Localization Editor'
  ClientHeight = 523
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 329
    Top = 0
    Height = 523
    ResizeStyle = rsUpdate
    ExplicitLeft = 408
    ExplicitTop = 176
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 523
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 524
    object vetStrings: TVirtualEditTree
      Left = 0
      Top = 0
      Width = 329
      Height = 523
      Align = alClient
      Colors.SelectionRectangleBlendColor = clGray
      Colors.SelectionRectangleBorderColor = clBlack
      Colors.SelectionTextColor = clBlack
      Header.AutoSizeIndex = 1
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 21
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      NodeDataSize = 8
      PopupMenu = pmuStrings
      SelectionBlendFactor = 32
      SelectionCurveRadius = 3
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
      TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
      TreeOptions.StringOptions = [toAutoAcceptEditChange]
      OnChange = vetStringsChange
      OnGetText = vetStringsGetText
      OnPaintText = vetStringsPaintText
      OnInitChildren = vetStringsInitChildren
      OnInitNode = vetStringsInitNode
      ExplicitHeight = 524
      Columns = <
        item
          Position = 0
          Width = 100
          WideText = 'String ID'
        end
        item
          Position = 1
          Width = 225
          WideText = 'Text'
        end>
    end
  end
  object Panel2: TPanel
    Left = 332
    Top = 0
    Width = 506
    Height = 523
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 524
    object memoText: TMemo
      Left = 0
      Top = 0
      Width = 506
      Height = 488
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = memoTextChange
      ExplicitHeight = 473
    end
    object pnlControls: TPanel
      Left = 0
      Top = 488
      Width = 506
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnSave: TButton
        Left = 424
        Top = 4
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 0
        OnClick = btnSaveClick
      end
    end
  end
  object pmuStrings: TPopupMenu
    OnPopup = pmuStringsPopup
    Left = 200
    Top = 136
    object mniFileExport: TMenuItem
      Caption = 'Export to file'
      OnClick = mniFileExportClick
    end
    object mniFileImport: TMenuItem
      Caption = 'Import from file'
    end
  end
  object dlgExport: TSaveTextFileDialog
    Filter = 'Text file (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 200
    Top = 200
  end
end
