object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ѡ��'
  ClientHeight = 313
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    466
    313)
  PixelsPerInch = 96
  TextHeight = 13
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 466
    Height = 265
    ActivePage = tsGeneral
    Align = alTop
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = '����'
      ImageIndex = 1
      object Label2: TLabel
        Left = 24
        Top = 107
        Width = 417
        Height = 30
        AutoSize = False
        Caption = 
          'Skyrim ע�⣺����� BSA �н�ѹ�� STRINGS �ļ�������Թرմ˹��ܣ���˴��������ȡ�ٶȣ�û�н�ѹ�벻Ҫȡ����ѡ��������ᵽ����������δ���ػ�����'
        WordWrap = True
      end
      object Label5: TLabel
        Left = 16
        Top = 208
        Width = 64
        Height = 13
        Caption = '�п�'
      end
      object cbIKnow: TCheckBox
        Left = 304
        Top = 15
        Width = 137
        Height = 17
        Caption = '��֪��ÿ������������'
        TabOrder = 0
        Visible = False
      end
      object cbHideUnused: TCheckBox
        Left = 16
        Top = 15
        Width = 90
        Height = 17
        Caption = '���ز�ʹ�õ�'
        TabOrder = 1
      end
      object cbHideIgnored: TCheckBox
        Left = 16
        Top = 38
        Width = 81
        Height = 17
        Caption = '���غ��Ե�'
        TabOrder = 2
      end
      object cbHideNeverShow: TCheckBox
        Left = 16
        Top = 61
        Width = 121
        Height = 17
        Caption = '���ء���Զ����ʾ����'
        TabOrder = 3
      end
      object cbLoadBSAs: TCheckBox
        Left = 16
        Top = 84
        Width = 81
        Height = 17
        Caption = '��ȡ BSA'
        TabOrder = 4
      end
      object cbSortFLST: TCheckBox
        Left = 16
        Top = 149
        Width = 121
        Height = 17
        Caption = '[FO3/FNV] FLST ����'
        TabOrder = 5
      end
      object cbSimpleRecords: TCheckBox
        Left = 16
        Top = 172
        Width = 281
        Height = 17
        Caption = '������ (LAND, NAVI, NAVM)����������Ч��'
        TabOrder = 6
      end
      object edColumnWidth: TEdit
        Left = 50
        Top = 204
        Width = 51
        Height = 21
        TabOrder = 7
      end
    end
    object tsCleaning: TTabSheet
      Caption = '����'
      object Label1: TLabel
        Left = 16
        Top = 9
        Width = 154
        Height = 13
        Caption = 'UDR ����'
      end
      object cbUDRSetXESP: TCheckBox
        Left = 32
        Top = 32
        Width = 410
        Height = 17
        Caption = 
          '��������״̬����Ҷ������ؼ����ã��رպ�����ĺ�������ге�����'
        TabOrder = 0
        WordWrap = True
      end
      object cbUDRSetScale: TCheckBox
        Left = 32
        Top = 55
        Width = 97
        Height = 17
        Caption = '���÷�ΧΪ'
        TabOrder = 1
      end
      object cbUDRSetZ: TCheckBox
        Left = 32
        Top = 78
        Width = 97
        Height = 17
        Caption = '����Zλ��Ϊ'
        TabOrder = 2
      end
      object edUDRSetScaleValue: TEdit
        Left = 133
        Top = 53
        Width = 84
        Height = 21
        TabOrder = 3
      end
      object edUDRSetZValue: TEdit
        Left = 133
        Top = 76
        Width = 84
        Height = 21
        TabOrder = 4
      end
      object cbUDRSetMSTT: TCheckBox
        Left = 32
        Top = 101
        Width = 201
        Height = 17
        Caption = '[FO3/FNV] �滻 MSTT FormID Ϊ'
        TabOrder = 5
      end
      object edUDRSetMSTTValue: TEdit
        Left = 239
        Top = 99
        Width = 82
        Height = 21
        TabOrder = 6
      end
    end
    object tsColors: TTabSheet
      Caption = '��ɫ'
      ImageIndex = 2
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 89
        Height = 13
        Caption = '��ͻ������ɫ'
      end
      object Label4: TLabel
        Left = 16
        Top = 80
        Width = 123
        Height = 13
        Caption = '��ͻ������ɫ'
      end
      object clbConflictThis: TColorBox
        Left = 223
        Top = 35
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 0
        OnChange = clbConflictThisChange
      end
      object cbConflictThis: TComboBox
        Left = 16
        Top = 35
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = cbConflictThisChange
      end
      object cbConflictAll: TComboBox
        Left = 16
        Top = 99
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = cbConflictAllChange
      end
      object clbConflictAll: TColorBox
        Left = 223
        Top = 99
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 3
        OnChange = clbConflictAllChange
      end
    end
  end
  object btnOK: TButton
    Left = 302
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'ȷ��'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 383
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'ȡ��'
    ModalResult = 2
    TabOrder = 2
  end
end
