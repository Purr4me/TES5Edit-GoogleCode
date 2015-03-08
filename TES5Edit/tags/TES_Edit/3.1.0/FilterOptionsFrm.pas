{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit FilterOptionsFrm;

{$I wbDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus, IniFiles, ExtCtrls;

const
  sFilterSection = 'Filter';

type
  TfrmFilterOptions = class(TForm)
    clbConflictAll: TCheckListBox;
    clbConflictThis: TCheckListBox;
    cbInherit: TCheckBox;
    cbConflictAll: TCheckBox;
    cbConflictThis: TCheckBox;
    cbByInjectionStatus: TCheckBox;
    cbInjected: TCheckBox;
    cbByNotReachableStatus: TCheckBox;
    cbNotReachable: TCheckBox;
    cbByReferencesInjectedStatus: TCheckBox;
    cbReferencesInjected: TCheckBox;
    cbByEditorID: TCheckBox;
    cbByName: TCheckBox;
    edEditorID: TEdit;
    edName: TEdit;
    clbRecordSignatures: TCheckListBox;
    cbRecordSignature: TCheckBox;
    pmuSelection: TPopupMenu;
    mniSelectAll: TMenuItem;
    mniSelectNone: TMenuItem;
    mniInvertSelection: TMenuItem;
    cbByPersistent: TCheckBox;
    cbPersistent: TCheckBox;
    cbUnnecessaryPersistent: TCheckBox;
    cbMasterIsTemporary: TCheckBox;
    cbByVWD: TCheckBox;
    cbVWD: TCheckBox;
    cbIsMaster: TCheckBox;
    cbPersistentPosChanged: TCheckBox;
    cbBaseRecordSignature: TCheckBox;
    clbBaseRecordSignatures: TCheckListBox;
    cbByBaseEditorID: TCheckBox;
    edBaseEditorID: TEdit;
    cbByBaseName: TCheckBox;
    edBaseName: TEdit;
    cbByHasVWDMesh: TCheckBox;
    cbHasVWDMesh: TCheckBox;
    cbFlattenBlocks: TCheckBox;
    cbFlattenCellChilds: TCheckBox;
    cbAssignPersWrldChild: TCheckBox;
    cbScaledActors: TCheckBox;
    cbDeleted: TCheckBox;
    pnlOptions: TPanel;
    pnlBottom: TPanel;
    btnFilter: TButton;
    btnCancel: TButton;
    pnlBevel: TPanel;
    cmbPreset: TComboBox;
    Label1: TLabel;
    btnFilterAdd: TButton;
    btnFilterDel: TButton;
    btnFilterSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure mniSelectionClick(Sender: TObject);
    procedure cmbPresetSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFilterAddClick(Sender: TObject);
    procedure btnFilterDelClick(Sender: TObject);
    procedure btnFilterSaveClick(Sender: TObject);
  private
    Settings: TMemIniFile;
    function GetRecordSignatures: string;
    procedure SetRecordSignatures(const Value: string);
    function GetBaseRecordSignatures: string;
    procedure SetBaseRecordSignatures(const Value: string);
    { Private declarations }
  public
    procedure SetSettings(aIni: TMemIniFile);
    procedure FilterListPresets(aStrings: TStrings);
    procedure FilterLoadPreset(aPresetName: string = '');
    procedure FilterSavePreset(aPresetName: string = '');
    property RecordSignatures: string
      read GetRecordSignatures
      write SetRecordSignatures;
    property BaseRecordSignatures: string
      read GetBaseRecordSignatures
      write SetBaseRecordSignatures;
  end;

implementation

{$R *.dfm}

uses
  TypInfo,
  wbInterface;

procedure TfrmFilterOptions.FormCreate(Sender: TObject);
var
  i : Integer;
  s : string;
begin
  //Font := Screen.IconFont;
  if Font.Size > 8 then
    Font.Size := 8;

  clbConflictAll.Items.Add('Single Record');
  clbConflictAll.Items.Add('Multiple but no conflict');
  clbConflictAll.Items.Add('Benign Conflict');
  clbConflictAll.Items.Add('Override without conflict');
  clbConflictAll.Items.Add('Conflict');
  clbConflictAll.Items.Add('Critical Conflict');

  clbConflictThis.Items.Add('Not Defined');
  clbConflictThis.Items.Add('Identical to Master');
  clbConflictThis.Items.Add('Single Record');
  clbConflictThis.Items.Add('Hidden by Mod Group');
  clbConflictThis.Items.Add('Master');
  clbConflictThis.Items.Add('Benign conflict');
  clbConflictThis.Items.Add('Override without conflict');
  clbConflictThis.Items.Add('Identical to Master but conflict winner');
  clbConflictThis.Items.Add('Conflict winner');
  clbConflictThis.Items.Add('Conflict loser');

  for i := Low(wbRecordDefs) to High(wbRecordDefs) do
    with wbRecordDefs[i].rdeDef do begin
      s := DefaultSignature + ' - ' + GetName;
      clbRecordSignatures.Items.Add(s);
      clbBaseRecordSignatures.Items.Add(s);
    end;
  clbRecordSignatures.Sorted := True;
  clbBaseRecordSignatures.Sorted := True;
end;

procedure TfrmFilterOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfrmFilterOptions.FormShow(Sender: TObject);
var
  i: integer;
begin
  FilterListPresets(cmbPreset.Items);
  i := cmbPreset.Items.IndexOf(Settings.ReadString('View', 'LastUsedFilter', ''));
  if i <> -1 then
    cmbPreset.ItemIndex := i
  else
    cmbPreset.ItemIndex := 0;
  cmbPresetSelect(nil);
end;

procedure TfrmFilterOptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then begin
    Settings.WriteString('View', 'LastUsedFilter', cmbPreset.Text);
    FilterSavePreset(cmbPreset.Text);
  end;
end;

function TfrmFilterOptions.GetBaseRecordSignatures: string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(clbBaseRecordSignatures.Items.Count) do
    if clbBaseRecordSignatures.Checked[i] then begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + Copy(clbBaseRecordSignatures.Items[i], 1, 4);
    end;
end;

function TfrmFilterOptions.GetRecordSignatures: string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(clbRecordSignatures.Items.Count) do
    if clbRecordSignatures.Checked[i] then begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + Copy(clbRecordSignatures.Items[i], 1, 4);
    end;
end;

procedure TfrmFilterOptions.mniSelectionClick(Sender: TObject);
var
  clb : TCheckListBox;
  i   : Integer;
begin
  clb := pmuSelection.PopupComponent as TCheckListBox;
  clb.Items.BeginUpdate;
  try
    for i := 0 to Pred(clb.Items.Count) do
      if Sender = mniSelectAll then
        clb.Checked[i] := True
      else if Sender = mniSelectNone then
        clb.Checked[i] := False
      else if Sender = mniInvertSelection then
        clb.Checked[i] := not clb.Checked[i];
  finally
    clb.Items.EndUpdate;
  end;
end;

procedure TfrmFilterOptions.SetBaseRecordSignatures(const Value: string);
var
  i, Dummy: Integer;
begin
  with TStringList.Create do try
    CommaText := Value;
    Sorted := True;
    for i := 0 to Pred(clbBaseRecordSignatures.Items.Count) do
      clbBaseRecordSignatures.Checked[i] := Find(Copy(clbBaseRecordSignatures.Items[i], 1, 4), Dummy);
  finally
    Free;
  end;
end;

procedure TfrmFilterOptions.SetRecordSignatures(const Value: string);
var
  i, Dummy: Integer;
begin
  with TStringList.Create do try
    CommaText := Value;
    Sorted := True;
    for i := 0 to Pred(clbRecordSignatures.Items.Count) do
      clbRecordSignatures.Checked[i] := Find(Copy(clbRecordSignatures.Items[i], 1, 4), Dummy);
  finally
    Free;
  end;
end;

procedure TfrmFilterOptions.SetSettings(aIni: TMemIniFile);
begin
  Settings := aIni;
end;

procedure TfrmFilterOptions.FilterListPresets(aStrings: TStrings);
var
  sl: TStringList;
  i: integer;
  s: string;
begin
  sl := TStringList.Create;
  try
    Settings.ReadSections(sl);
    sl.Sort;
    for i := 0 to Pred(sl.Count) do
      if SameText(Copy(sl[i], 1, Length(sFilterSection)), sFilterSection) then begin
        s := Trim(Copy(sl[i], Length(sFilterSection) + 1, Length(sl[i])));
        if s <> '' then
          aStrings.Add(s);
      end;
    aStrings.Insert(0, '');
  finally
    sl.Free;
  end;
end;

procedure TfrmFilterOptions.btnFilterAddClick(Sender: TObject);
var
  s: string;
begin
  if InputQuery('Filter', 'Preset name', s) and (Trim(s) <> '') then
    if cmbPreset.Items.IndexOf(s) = -1 then begin
      cmbPreset.Items.Add(s);
      cmbPreset.ItemIndex := Pred(cmbPreset.Items.Count);
    end;
end;

procedure TfrmFilterOptions.btnFilterDelClick(Sender: TObject);
var
  i: integer;
begin
  if cmbPreset.ItemIndex = 0 then begin
    FilterLoadPreset('fictionalsectiontosetdefaultvalues');
    Exit;
  end;
  i := cmbPreset.ItemIndex;
  Settings.EraseSection(Trim(sFilterSection + ' ' + cmbPreset.Text));
  Settings.UpdateFile;
  cmbPreset.Items.Delete(i);
  if i > cmbPreset.Items.Count - 1 then Dec(i);
  cmbPreset.ItemIndex := i;
  cmbPresetSelect(nil);
end;

procedure TfrmFilterOptions.btnFilterSaveClick(Sender: TObject);
begin
  FilterSavePreset(cmbPreset.Text);
end;

procedure TfrmFilterOptions.cmbPresetSelect(Sender: TObject);
begin
  FilterLoadPreset(cmbPreset.Text);
end;

procedure TfrmFilterOptions.FilterLoadPreset(aPresetName: string = '');
var
  i                    : integer;
  Section              : string;
  ConflictAll          : TConflictAll;
  ConflictThis         : TConflictThis;
  FilterConflictAllSet : TConflictAllSet;
  FilterConflictThisSet: TConflictThisSet;
begin
  Section := Trim(sFilterSection + ' ' + aPresetName);

  cbConflictAll.Checked := Settings.ReadBool(Section, 'ConflictAll', True);
  cbConflictThis.Checked := Settings.ReadBool(Section, 'ConflictThis', True);

  cbByInjectionStatus.Checked := Settings.ReadBool(Section, 'byInjectStatus', False);
  cbInjected.Checked := Settings.ReadBool(Section, 'InjectStatus', True);

  cbByNotReachableStatus.Enabled := Settings.ReadBool(Section, 'byNotReachableStatus', False);
  cbNotReachable.Checked := Settings.ReadBool(Section, 'NotReachableStatus', True);

  cbByReferencesInjectedStatus.Checked := Settings.ReadBool(Section, 'byReferencesInjectedStatus', False);
  cbReferencesInjected.Checked := Settings.ReadBool(Section, 'ReferencesInjectedStatus', True);

  cbByEditorID.Checked := Settings.ReadBool(Section, 'ByEditorID', False);
  edEditorID.Text := Settings.ReadString(Section, 'EditorID', '');

  cbByName.Checked := Settings.ReadBool(Section, 'ByName', False);
  edName.Text := Settings.ReadString(Section, 'Name', '');

  cbByBaseEditorID.Checked := Settings.ReadBool(Section, 'ByBaseEditorID', False);
  edBaseEditorID.Text := Settings.ReadString(Section, 'BaseEditorID', '');

  cbByBaseName.Checked := Settings.ReadBool(Section, 'ByBaseName', False);
  edBaseName.Text := Settings.ReadString(Section, 'BaseName', '');

  cbScaledActors.Checked := Settings.ReadBool(Section, 'ScaledActors', False);

  cbRecordSignature.Checked := Settings.ReadBool(Section, 'BySignature', False);
  RecordSignatures := Settings.ReadString(Section, 'Signatures', '');

  cbBaseRecordSignature.Checked := Settings.ReadBool(Section, 'ByBaseSignature', False);
  BaseRecordSignatures := Settings.ReadString(Section, 'BaseSignatures', '');

  cbByPersistent.Checked := Settings.ReadBool(Section, 'ByPersistent', False);
  cbPersistent.Checked := Settings.ReadBool(Section, 'Persistent', True);
  cbUnnecessaryPersistent.Checked := Settings.ReadBool(Section, 'UnnecessaryPersistent', False);
  cbMasterIsTemporary.Checked := Settings.ReadBool(Section, 'MasterIsTemporary', False);
  cbIsMaster.Checked := Settings.ReadBool(Section, 'IsMaster', False);
  cbPersistentPosChanged.Checked := Settings.ReadBool(Section, 'PersistentPosChanged', False);

  cbDeleted.Checked := Settings.ReadBool(Section, 'Deleted', False);

  cbByVWD.Checked := Settings.ReadBool(Section, 'ByVWD', False);
  cbVWD.Checked := Settings.ReadBool(Section, 'VWD', True);

  cbByHasVWDMesh.Checked := Settings.ReadBool(Section, 'ByHasVWDMesh', False);
  cbHasVWDMesh.Checked := Settings.ReadBool(Section, 'HasVWDMesh', True);

  cbFlattenBlocks.Checked := Settings.ReadBool(Section, 'FlattenBlocks', False);
  cbFlattenCellChilds.Checked := Settings.ReadBool(Section, 'FlattenCellChilds', False);
  cbAssignPersWrldChild.Checked := Settings.ReadBool(Section, 'AssignPersWrldChild', False);
  cbInherit.Checked := Settings.ReadBool(Section, 'InheritConflictByParent', True);

  FilterConflictAllSet := [];
  for ConflictAll := Low(ConflictAll) to High(ConflictAll) do
    if Settings.ReadBool(Section, GetEnumName(TypeInfo(TConflictAll), Ord(ConflictAll)), True) then
      Include(FilterConflictAllSet, ConflictAll);

  FilterConflictThisSet := [];
  for ConflictThis := Low(ConflictThis) to High(ConflictThis) do
    if Settings.ReadBool(Section, GetEnumName(TypeInfo(TConflictThis), Ord(ConflictThis)), True) then
      Include(FilterConflictThisSet, ConflictThis);

  for i := 0 to Pred(clbConflictAll.Items.Count) do
    clbConflictAll.Checked[i] := TConflictAll(Succ(i)) in FilterConflictAllSet;
  for i := 0 to Pred(clbConflictThis.Items.Count) do
    clbConflictThis.Checked[i] := TConflictThis(i + 2) in FilterConflictThisSet;
end;

procedure TfrmFilterOptions.FilterSavePreset(aPresetName: string = '');
var
  i                    : integer;
  Section              : string;
  ConflictAll          : TConflictAll;
  ConflictThis         : TConflictThis;
  FilterConflictAllSet : TConflictAllSet;
  FilterConflictThisSet: TConflictThisSet;
begin
  Section := Trim(sFilterSection + ' ' + aPresetName);

  Settings.WriteBool(Section, 'ConflictAll', cbConflictAll.Checked);
  Settings.WriteBool(Section, 'ConflictThis', cbConflictThis.Checked);

  Settings.WriteBool(Section, 'ByInjectStatus', cbByInjectionStatus.Checked);
  Settings.WriteBool(Section, 'InjectStatus', cbInjected.Checked);

  Settings.WriteBool(Section, 'ByNotReachableStatus', cbByNotReachableStatus.Enabled);
  Settings.WriteBool(Section, 'NotReachableStatus', cbNotReachable.Checked);

  Settings.WriteBool(Section, 'ByReferencesInjectedStatus', cbByReferencesInjectedStatus.Checked);
  Settings.WriteBool(Section, 'ReferencesInjectedStatus', cbReferencesInjected.Checked);

  Settings.WriteBool(Section, 'ByEditorID', cbByEditorID.Checked);
  Settings.WriteString(Section, 'EditorID', edEditorID.Text);

  Settings.WriteBool(Section, 'ByName', cbByName.Checked);
  Settings.WriteString(Section, 'Name', edName.Text);

  Settings.WriteBool(Section, 'ByBaseEditorID', cbByBaseEditorID.Checked);
  Settings.WriteString(Section, 'BaseEditorID', edBaseEditorID.Text);

  Settings.WriteBool(Section, 'ByBaseName', cbByBaseName.Checked);
  Settings.WriteString(Section, 'BaseName', edBaseName.Text);

  Settings.WriteBool(Section, 'ScaledActors', cbScaledActors.Checked);

  Settings.WriteBool(Section, 'BySignature', cbRecordSignature.Checked);
  Settings.WriteString(Section, 'Signatures', RecordSignatures);

  Settings.WriteBool(Section, 'ByBaseSignature', cbBaseRecordSignature.Checked);
  Settings.WriteString(Section, 'BaseSignatures', BaseRecordSignatures);

  Settings.WriteBool(Section, 'ByPersistent', cbByPersistent.Checked);
  Settings.WriteBool(Section, 'Persistent', cbPersistent.Checked);
  Settings.WriteBool(Section, 'UnnecessaryPersistent', cbUnnecessaryPersistent.Checked);
  Settings.WriteBool(Section, 'MasterIsTemporary', cbMasterIsTemporary.Checked);
  Settings.WriteBool(Section, 'PersistentPosChanged', cbPersistentPosChanged.Checked);

  Settings.WriteBool(Section, 'Deleted', cbDeleted.Checked);

  Settings.WriteBool(Section, 'ByVWD', cbByVWD.Checked);
  Settings.WriteBool(Section, 'VWD', cbVWD.Checked);

  Settings.WriteBool(Section, 'ByHasVWDMesh', cbByHasVWDMesh.Checked);
  Settings.WriteBool(Section, 'HasVWDMesh', cbHasVWDMesh.Checked);

  Settings.WriteBool(Section, 'FlattenBlocks', cbFlattenBlocks.Checked);
  Settings.WriteBool(Section, 'FlattenCellChilds', cbFlattenCellChilds.Checked);
  Settings.WriteBool(Section, 'AssignPersWrldChild', cbAssignPersWrldChild.Checked);
  Settings.WriteBool(Section, 'InheritConflictByParent', cbInherit.Checked);

  FilterConflictAllSet := [];
  for i := 0 to Pred(clbConflictAll.Items.Count) do
    if clbConflictAll.Checked[i] then
      Include(FilterConflictAllSet, TConflictAll(Succ(i)));

  FilterConflictThisSet := [];
  for i := 0 to Pred(clbConflictThis.Items.Count) do
    if clbConflictThis.Checked[i] then
      Include(FilterConflictThisSet, TConflictThis(i + 2));

  for ConflictAll := Low(ConflictAll) to High(ConflictAll) do
    Settings.WriteBool(Section, GetEnumName(TypeInfo(TConflictAll), Ord(ConflictAll)), ConflictAll in FilterConflictAllSet);

  for ConflictThis := Low(ConflictThis) to High(ConflictThis) do
    Settings.WriteBool(Section, GetEnumName(TypeInfo(TConflictThis), Ord(ConflictThis)), ConflictThis in FilterConflictThisSet);

  Settings.UpdateFile;
end;

end.
