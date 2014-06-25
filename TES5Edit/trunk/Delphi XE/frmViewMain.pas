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

unit frmViewMain;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  Menus,
  Math,
  IniFiles,
  ClipBrd,
  TypInfo,
  ActiveX,
  Buttons,
  ActnList,
  ShellAPI,
  IOUtils,
  Actions,
  pngimage,
  VirtualTrees,
  VTEditors,
  VirtualEditTree,
  JvComponentBase,
  JvInterpreter,
  wbInterface,
  wbImplementation,
  wbBSA,
  wbNifScanner,
  wbHelpers,
  wbInit,
  wbLocalization;

const
  DefaultInterval             = 1 / 24 / 6;

type
  TDynBooleans = array of Boolean;

  TNavNodeFlag = (
    nnfInjected,
    nnfNotReachable,
    nnfReferencesInjected
  );

  TNavNodeFlags = set of TNavNodeFlag;

  PNavNodeData = ^TNavNodeData;
  TNavNodeData = record
    Element      : IwbElement;
    Container    : IwbContainer;
    ConflictAll  : TConflictAll;
    ConflictThis : TConflictThis;
    Flags        : TNavNodeFlags;
  end;

  TViewNodeFlag = (
    vnfDontShow,
    vnfIgnore
  );
  TViewNodeFlags = set of TViewNodeFlag;

  PViewNodeData = ^TViewNodeData;
  TViewNodeData = record
    Element: IwbElement;
    Container: IwbContainerElementRef;
    ConflictAll: TConflictAll;
    ConflictThis: TConflictThis;
    ViewNodeFlags: TViewNodeFlags;
    procedure UpdateRefs;
  end;

  PSpreadSheetNodeData = ^TSpreadSheetNodeData;
  TSpreadSheetNodeData = record
    Element: IwbElement;
  end;

  TViewNodeDatas = array[Word] of TViewNodeData;
  PViewNodeDatas = ^TViewNodeDatas;

  TDynViewNodeDatas = array of TViewNodeData;

  TSpreadSheetNodeDatas = array[Word] of TSpreadSheetNodeData;
  PSpreadSheetNodeDatas = ^TSpreadSheetNodeDatas;

  TDynSpreadSheetNodeDatas = array of TSpreadSheetNodeData;

  TAfterCopyCallback = procedure(const aElement: IwbElement);

  TwbPluggyLinkState = (
    plsNone,
    plsReference,
    plsBase,
    plsInventory,
    plsEnchantment,
    plsSpell
  );

  TPluggyLinkThread = class;

  TfrmMain = class(TForm)
    vstNav: TVirtualEditTree;
    splElements: TSplitter;
    pgMain: TPageControl;
    tbsView: TTabSheet;
    tbsMessages: TTabSheet;
    mmoMessages: TMemo;
    tmrStartup: TTimer;
    tmrMessages: TTimer;
    vstView: TVirtualEditTree;
    stbMain: TStatusBar;
    Panel1: TPanel;
    pmuNav: TPopupMenu;
    mniNavFilterRemove: TMenuItem;
    mniNavFilterApply: TMenuItem;
    tbsInfo: TTabSheet;
    Memo1: TMemo;
    mniNavCheckForErrors: TMenuItem;
    tbsReferencedBy: TTabSheet;
    lvReferencedBy: TListView;
    N1: TMenuItem;
    mniNavChangeFormID: TMenuItem;
    pmuView: TPopupMenu;
    mniViewEdit: TMenuItem;
    mniNavChangeReferencingRecords: TMenuItem;
    mniViewRemove: TMenuItem;
    N2: TMenuItem;
    mniNavBuildRef: TMenuItem;
    mniViewAdd: TMenuItem;
    mniNavRemove: TMenuItem;
    pnlTop: TPanel;
    bnBack: TSpeedButton;
    bnForward: TSpeedButton;
    lblPath: TEdit;
    ActionList1: TActionList;
    acBack: TAction;
    acForward: TAction;
    N3: TMenuItem;
    mniNavCompareTo: TMenuItem;
    odModule: TOpenDialog;
    tbsWEAPSpreadsheet: TTabSheet;
    vstSpreadSheetWeapon: TVirtualEditTree;
    tbsARMOSpreadsheet: TTabSheet;
    tbsAMMOSpreadsheet: TTabSheet;
    vstSpreadsheetArmor: TVirtualEditTree;
    vstSpreadSheetAmmo: TVirtualEditTree;
    pmuSpreadsheet: TPopupMenu;
    mniSpreadsheetRebuild: TMenuItem;
    mniNavAdd: TMenuItem;
    mniNavAddMasters: TMenuItem;
    pmuViewHeader: TPopupMenu;
    mniViewHeaderCopyAsOverride: TMenuItem;
    mniViewHeaderCopyAsNewRecord: TMenuItem;
    mniNavCopyAsOverride: TMenuItem;
    mniNavCopyAsNewRecord: TMenuItem;
    mniViewHeaderRemove: TMenuItem;
    mniViewHeaderCopyAsWrapper: TMenuItem;
    mniNavCopyAsWrapper: TMenuItem;
    mniViewCopyToSelectedRecords: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    mniNavCompareSelected: TMenuItem;
    mniViewSort: TMenuItem;
    tmrCheckUnsaved: TTimer;
    mniViewRemoveFromSelected: TMenuItem;
    pnlNav: TPanel;
    Panel5: TPanel;
    Panel3: TPanel;
    edFormIDSearch: TLabeledEdit;
    Panel4: TPanel;
    edEditorIDSearch: TLabeledEdit;
    mniSpreadsheetCompareSelected: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    mniViewHideNoConflict: TMenuItem;
    mniNavSortMasters: TMenuItem;
    mniNavCleanMasters: TMenuItem;
    ColumnWidths1: TMenuItem;
    mniViewColumnWidthStandard: TMenuItem;
    mniViewColumnWidthFitAll: TMenuItem;
    mniViewColumnWidthFitText: TMenuItem;
    N10: TMenuItem;
    mniNavHidden: TMenuItem;
    N11: TMenuItem;
    mniViewHeaderHidden: TMenuItem;
    mniViewCompareReferencedRow: TMenuItem;
    mniNavBuildReachable: TMenuItem;
    mniNavCleanupInjected: TMenuItem;
    pmuNavHeaderPopup: TPopupMenu;
    Files1: TMenuItem;
    mniNavHeaderFilesDefault: TMenuItem;
    mniNavHeaderFilesLoadOrder: TMenuItem;
    mniNavHeaderFilesFileName: TMenuItem;
    N12: TMenuItem;
    mniViewMoveUp: TMenuItem;
    mniViewMoveDown: TMenuItem;
    mniNavBatchChangeReferencingRecords: TMenuItem;
    odCSV: TOpenDialog;
    mniNavDeepCopyAsOverride: TMenuItem;
    TabSheet2: TTabSheet;
    DisplayPanel: TPanel;
    N5: TMenuItem;
    mniNavCellChildPers: TMenuItem;
    mniNavCellChildTemp: TMenuItem;
    mniNavCellChildNotVWD: TMenuItem;
    mniNavCellChildVWD: TMenuItem;
    pmuRefBy: TPopupMenu;
    mniRefByNotVWD: TMenuItem;
    mniRefByVWD: TMenuItem;
    mniNavRemoveIdenticalToMaster: TMenuItem;
    N14: TMenuItem;
    mniRefByCopyOverrideInto: TMenuItem;
    mniRefByDeepCopyOverrideInto: TMenuItem;
    mniRefByCopyAsNewInto: TMenuItem;
    mniNavSetVWDAuto: TMenuItem;
    mniNavSetVWDAutoInto: TMenuItem;
    N15: TMenuItem;
    mniNavGenerateObjectLOD: TMenuItem;
    N16: TMenuItem;
    mniNavTest: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    mniNavCheckForCircularLeveledLists: TMenuItem;
    pmuPath: TPopupMenu;
    mniPathPluggyLink: TMenuItem;
    mniPathPluggyLinkDisabled: TMenuItem;
    mniPathPluggyLinkReference: TMenuItem;
    mniPathPluggyLinkBaseObject: TMenuItem;
    mniPathPluggyLinkInventory: TMenuItem;
    mniPathPluggyLinkSpell: TMenuItem;
    mniPathPluggyLinkEnchantment: TMenuItem;
    mniNavBanditFix: TMenuItem;
    N20: TMenuItem;
    mniRefByRemove: TMenuItem;
    mniNavRaceLVLIs: TMenuItem;
    mniRefByCopyDisabledOverrideInto: TMenuItem;
    mniNavCopyAsSpawnRateOverride: TMenuItem;
    pmuNavAdd: TPopupMenu;
    mniNavUndeleteAndDisableReferences: TMenuItem;
    mniNavMarkModified: TMenuItem;
    mniNavCreateMergedPatch: TMenuItem;
    mniNavCopyIdle: TMenuItem;
    mniNavRenumberFormIDsFrom: TMenuItem;
    imgFlattr: TImage;
    tmrGenerator: TTimer;
    mniNavLocalizationEditor: TMenuItem;
    mniNavLocalizationSwitch: TMenuItem;
    mniNavLocalization: TMenuItem;
    mniNavLocalizationLanguage: TMenuItem;
    mniNavFilterForCleaning: TMenuItem;
    mniNavCreateSEQFile: TMenuItem;
    mniNavApplyScript: TMenuItem;
    mniNavOptions: TMenuItem;
    mniNavLogAnalyzer: TMenuItem;
    mniNavOther: TMenuItem;
    N13: TMenuItem;
    mniRefByMarkModified: TMenuItem;
    mniViewNextMember: TMenuItem;
    mniViewPreviousMember: TMenuItem;
    mniViewHeaderJumpTo: TMenuItem;
    acScript: TAction;

    {--- Form ---}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure splElementsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    {--- pgMain ---}
    procedure tbsMessagesShow(Sender: TObject);
    procedure tbsViewShow(Sender: TObject);
    procedure tbsSpreadsheetShow(Sender: TObject);

    {--- Timer ---}
    procedure tmrStartupTimer(Sender: TObject);
    procedure tmrMessagesTimer(Sender: TObject);
    procedure tmrCheckUnsavedTimer(Sender: TObject);

    {--- lvReferencedBy ---}
    procedure lvReferencedByDblClick(Sender: TObject);

    {--- edFormIDSearch ---}
    procedure edFormIDSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFormIDSearchChange(Sender: TObject);
    procedure edFormIDSearchEnter(Sender: TObject);

    {--- edEditorIDSearch ---}
    procedure edEditorIDSearchChange(Sender: TObject);
    procedure edEditorIDSearchEnter(Sender: TObject);
    procedure edEditorIDSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    {--- vstNav ---}
    procedure vstNavBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vstNavChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstNavCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstNavFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstNavGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstNavHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vstNavIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstNavInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstNavInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstNavPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);

    {--- pmuNavPopup ---}
    procedure pmuNavPopup(Sender: TObject);
    procedure mniNavAddClick(Sender: TObject);
    procedure mniNavAddMastersClick(Sender: TObject);
    procedure mniNavBatchChangeReferencingRecordsClick(Sender: TObject);
    procedure mniNavBuildReachableClick(Sender: TObject);
    procedure mniNavBuildRefClick(Sender: TObject);
    procedure mniNavChangeFormIDClick(Sender: TObject);
    procedure mniNavChangeReferencingRecordsClick(Sender: TObject);
    procedure mniNavCheckForErrorsClick(Sender: TObject);
    procedure mniNavCleanMastersClick(Sender: TObject);
    procedure mniNavCleanupInjectedClick(Sender: TObject);
    procedure mniNavCellChild(Sender: TObject);
    procedure mniNavCompareSelectedClick(Sender: TObject);
    procedure mniNavCompareToClick(Sender: TObject);
    procedure mniNavCopyIntoClick(Sender: TObject);
    procedure mniNavFilterApplyClick(Sender: TObject);
    procedure mniNavFilterRemoveClick(Sender: TObject);
    procedure mniNavGenerateObjectLODClick(Sender: TObject);
    procedure mniNavHiddenClick(Sender: TObject);
    procedure mniNavRemoveClick(Sender: TObject);
    procedure mniNavRemoveIdenticalToMasterClick(Sender: TObject);
    procedure mniNavSetVWDAutoClick(Sender: TObject);
    procedure mniNavSetVWDAutoIntoClick(Sender: TObject);
    procedure mniNavSortMastersClick(Sender: TObject);

    {--- pmuNavHeaderPopup ---}
    procedure mniNavHeaderFilesClick(Sender: TObject);

    {--- vstView ---}
    procedure vstViewAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
    procedure vstViewBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstViewBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vstViewCheckHotTrack(Sender: TBaseVirtualTree; HotNode: PVirtualNode; HotColumn: TColumnIndex; var Allow: Boolean);
    procedure vstViewClick(Sender: TObject);
    procedure vstViewCollapsing(Sender: TBaseVirtualTree; Node: PVirtualNode; var Allowed: Boolean);
    procedure vstViewDblClick(Sender: TObject);
    procedure vstViewDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstViewDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstViewDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstViewEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstViewFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vstViewFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure vstViewFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstViewGetEditText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var CellText: string);
    procedure vstViewGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
    procedure vstViewGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstViewHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vstViewHeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
    procedure vstViewInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstViewInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vstViewNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure vstViewPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstViewResize(Sender: TObject);

    {--- pmuViewPopup ---}
    procedure pmuViewPopup(Sender: TObject);
    procedure mniViewAddClick(Sender: TObject);
    procedure mniViewColumnWidthClick(Sender: TObject);
    procedure mniViewCompareReferencedRowClick(Sender: TObject);
    procedure mniViewCopyToSelectedRecordsClick(Sender: TObject);
    procedure mniViewEditClick(Sender: TObject);
    procedure mniViewHideNoConflictClick(Sender: TObject);
    procedure mniViewMoveUpClick(Sender: TObject);
    procedure mniViewMoveDownClick(Sender: TObject);
    procedure mniViewRemoveClick(Sender: TObject);
    procedure mniViewRemoveFromSelectedClick(Sender: TObject);
    procedure mniViewSortClick(Sender: TObject);

    {--- pmuViewHeaderPopup ---}
    procedure pmuViewHeaderPopup(Sender: TObject);
    procedure mniViewHeaderCopyIntoClick(Sender: TObject);
    procedure mniViewHeaderHiddenClick(Sender: TObject);
    procedure mniViewHeaderRemoveClick(Sender: TObject);

    {--- pmuRefByPopup ---}
    procedure pmuRefByPopup(Sender: TObject);
    procedure mniRefByVWDClick(Sender: TObject);
    procedure mniRefByCopyIntoClick(Sender: TObject);
    procedure mniRefByRemoveClick(Sender: TObject);

    {--- vstSpreadSheet ---}
    procedure vstSpreadSheetWeaponInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstSpreadsheetArmorInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstSpreadSheetAmmoInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);

    procedure vstSpreadSheetCheckHotTrack(Sender: TBaseVirtualTree; HotNode: PVirtualNode; HotColumn: TColumnIndex; var Allow: Boolean);
    procedure vstSpreadSheetClick(Sender: TObject);
    procedure vstSpreadSheetCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstSpreadSheetDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstSpreadSheetDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstSpreadSheetDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstSpreadSheetEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstSpreadSheetFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstSpreadSheetGetEditText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var CellText: string);
    procedure vstSpreadSheetGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
    procedure vstSpreadSheetGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstSpreadSheetIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstSpreadSheetNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure vstSpreadSheetPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);

    {--- pmuSpreadSheet ---}
    procedure pmuSpreadsheetPopup(Sender: TObject);
    procedure mniSpreadsheetCompareSelectedClick(Sender: TObject);
    procedure mniSpreadsheetRebuildClick(Sender: TObject);

    {--- actions ---}
    procedure acBackUpdate(Sender: TObject);
    procedure acBackExecute(Sender: TObject);

    procedure acForwardUpdate(Sender: TObject);
    procedure acForwardExecute(Sender: TObject);
    procedure mniNavCheckForCircularLeveledListsClick(Sender: TObject);
    procedure mniPathPluggyLinkClick(Sender: TObject);
    procedure mniNavBanditFixClick(Sender: TObject);
    procedure mniNavRaceLVLIsClick(Sender: TObject);
    procedure mniRefByCopyDisabledOverrideIntoClick(Sender: TObject);
    procedure lvReferencedByColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvReferencedByCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure vstViewCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure vstNavKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pmuPathPopup(Sender: TObject);
    procedure mniNavUndeleteAndDisableReferencesClick(Sender: TObject);
    procedure mniNavMarkModifiedClick(Sender: TObject);
    procedure mniNavCreateMergedPatchClick(Sender: TObject);
    procedure mniNavTestClick(Sender: TObject);
    procedure mniNavCopyIdleClick(Sender: TObject);
    procedure mniNavRenumberFormIDsFromClick(Sender: TObject);
    procedure stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure stbMainResize(Sender: TObject);
    procedure stbMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrGeneratorTimer(Sender: TObject);
    procedure mmoMessagesDblClick(Sender: TObject);
    procedure mniNavLocalizationEditorClick(Sender: TObject);
    procedure mniNavLocalizationSwitchClick(Sender: TObject);
    procedure mniNavLocalizationLanguageClick(Sender: TObject);
    procedure mniNavFilterForCleaningClick(Sender: TObject);
    procedure mniNavCreateSEQFileClick(Sender: TObject);
    procedure vstNavExpanding(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var Allowed: Boolean);
    procedure mniNavApplyScriptClick(Sender: TObject);
    procedure mniNavOptionsClick(Sender: TObject);
    procedure JvInterpreterProgram1GetValue(Sender: TObject; Identifier: string;
      var Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean);
    procedure JvInterpreterProgram1GetUnitSource(UnitName: string; var Source: string;
      var Done: Boolean);
    procedure mniNavLogAnalyzerClick(Sender: TObject);
    procedure mniRefByMarkModifiedClick(Sender: TObject);
    procedure JvInterpreterProgram1SetValue(Sender: TObject; Identifier: string;
      const Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean);
    procedure mniViewNextMemberClick(Sender: TObject);
    procedure mniViewPreviousMemberClick(Sender: TObject);
    procedure mniViewHeaderJumpToClick(Sender: TObject);
    procedure acScriptExecute(Sender: TObject);
  protected
    BackHistory: IInterfaceList;
    ForwardHistory: IInterfaceList;
    EditWarnOk: Boolean;
    SaveInterval: TDateTime;
    LastViewColumn: TColumnIndex;
    HideNoConflict: Boolean;
    UserWasActive: Boolean;
    TotalUsageTime: TDateTime;
    RateNoticeGiven: Integer;
    ReachableBuild: Boolean;
    ReferencedBySortColumn: TListColumn;

    EditInfoCache: string;
    EditInfoCacheID: Cardinal;

    function GetRefBySelectionAsMainRecords: TDynMainRecords;
    function GetRefBySelectionAsElements: TDynElements;

    procedure GenerateLOD(const aWorldspace: IwbMainRecord);
    procedure DoGenerateLOD;

    function CopyInto(AsNew, AsWrapper, AsSpawnRate, DeepCopy: Boolean; const aElements: TDynElements; aAfterCopyCallback: TAfterCopyCallback = nil): TDynElements;

    procedure BuildAllRef;
    procedure ResetAllTags;

    procedure ConflictLevelForMainRecord(const aMainRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);
    function ConflictLevelForChildNodeDatas(const aNodeDatas: TDynViewNodeDatas; aSiblingCompare, aInjected: Boolean): TConflictAll;
    function ConflictLevelForNodeDatas(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer; aSiblingCompare, aInjected: Boolean): TConflictAll;

    function GetUniqueLinksTo(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer): TDynMainRecords;

    procedure InitChilds(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer; var aChildCount: Cardinal);
    procedure InitNodes(const aNodeDatas, aParentDatas: PViewNodeDatas; aNodeCount: Integer; aIndex: Cardinal; var aInitialStates: TVirtualNodeInitStates);
    procedure InitConflictStatus(aNode: PVirtualNode; aInjected: Boolean; aNodeDatas: PViewNodeDatas = nil);
    procedure InheritStateFromChilds(Node: PVirtualNode; NodeData: PNavNodeData);

    function NodeDatasForMainRecord(const aMainRecord: IwbMainRecord): TDynViewNodeDatas;

    procedure ShowChangeReferencedBy(OldFormID: Cardinal; NewFormID: Cardinal; const ReferencedBy: TDynMainRecords; aSilent: Boolean);
    function GetDragElements(Target: TBaseVirtualTree; Source: TObject; out TargetNode: PVirtualNode; out TargetIndex: Integer; out TargetElement: IwbElement; out SourceElement: IwbElement): Boolean;
    function GetAddElement(out TargetNode: PVirtualNode; out TargetIndex: Integer; out TargetElement: IwbElement): Boolean;

    procedure ClearConflict(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure InvalidateElementsTreeView(aNodes: TNodeArray);
    procedure ResetActiveTree;
    procedure PostResetActiveTree;

    function AddRequiredMasters(const aSourceElement: IwbElement; const aTargetFile: IwbFile; aAsNew: Boolean): Boolean; overload;
    function AddRequiredMasters(aMasters: TStrings; const aTargetFile: IwbFile): Boolean; overload;

    function CheckForErrorsLinear(const aElement: IwbElement; LastRecord: IwbMainRecord): IwbMainRecord;
    function CheckForErrors(const aIndent: Integer; const aElement: IwbElement): Boolean;

    function AddNewFile(out aFile: IwbFile): Boolean;

    procedure SaveChanged;
    procedure JumpTo(aInterface: IInterface; aBackward: Boolean);
    function FindNodeForElement(const aElement: IwbElement): PVirtualNode;
    function EditWarn: Boolean;
    function RemoveableSelection(ContainsChilds: PBoolean): TNodeArray;
    function EditableSelection(ContainsChilds: PBoolean): TNodeArray;

    function SelectionIncludesNonCopyNewRecords: Boolean;
    function SelectionIncludesAnyDeepCopyRecords: Boolean;
    function SelectionIncludesOnlyDeepCopyRecords: Boolean;

    function ByRefSelectionIncludesNonCopyNewRecords(aSelection: TDynMainRecords): Boolean;
    function ByRefSelectionIncludesAnyDeepCopyRecords(aSelection: TDynMainRecords): Boolean;
    function ByRefSelectionIncludesOnlyDeepCopyRecords(aSelection: TDynMainRecords): Boolean;

    function SelectionIncludesOnlyREFR(Selection: TNodeArray): Boolean;
    function SelectionIncludesAnyNotVWD(Selection: TNodeArray): Boolean;
    function SelectionIncludesAnyVWD(Selection: TNodeArray): Boolean;
    procedure CheckHistoryRemove(const aList: IInterfaceList; const aMainRecord: IwbMainRecord);
    procedure UpdateColumnWidths;

    function SetAllToMaster: Boolean;
    function RestorePluginsFromMaster: Boolean;
    procedure ApplyScript(aScript: string);
    procedure CreateActionsForScripts;
  private
    procedure WMUser(var Message: TMessage); message WM_USER;
    procedure WMUser1(var Message: TMessage); message WM_USER + 1;
    procedure WMUser2(var Message: TMessage); message WM_USER + 2;
    procedure WMUser3(var Message: TMessage); message WM_USER + 3;
    procedure WMUser4(var Message: TMessage); message WM_USER + 4;
  private
    Files: TDynFiles;
    NewMessages: TStringList;
    ActiveIndex: TColumnIndex;
    ActiveRecord: IwbMainRecord;
    ActiveMaster: IwbMainRecord;
    ActiveRecords: TDynViewNodeDatas;
    LoaderStarted: Boolean;
    ForceTerminate: Boolean;
    ModGroups: TStringList;
    Settings: TMemIniFile;
    AutoSave: Boolean;

    FilterPreset: Boolean; // new: flag to skip filter window
    FilterScripted: Boolean; // new: flag to use scripted filtering function
    FilterApplied: Boolean;

    FilterConflictAll: Boolean;
    FilterConflictAllSet: TConflictAllSet;

    FilterConflictThis: Boolean;
    FilterConflictThisSet: TConflictThisSet;

    FilterByInjectStatus: Boolean;
    FilterInjectStatus: Boolean;

    FilterByNotReachableStatus: Boolean;
    FilterNotReachableStatus: Boolean;

    FilterByReferencesInjectedStatus: Boolean;
    FilterReferencesInjectedStatus: Boolean;

    FilterByEditorID: Boolean;
    FilterEditorID: string;

    FilterByName: Boolean;
    FilterName: string;

    FilterByBaseEditorID: Boolean;
    FilterBaseEditorID: string;

    FilterByBaseName: Boolean;
    FilterBaseName: string;

    FilterScaledActors: Boolean;

    FilterBySignature: Boolean;
    FilterSignatures: string;

    FilterByBaseSignature: Boolean;
    FilterBaseSignatures: string;

    FilterByPersistent: Boolean;
    FilterPersistent: Boolean;
    FilterUnnecessaryPersistent: Boolean;
    FilterMasterIsTemporary: Boolean;
    FilterIsMaster: Boolean;
    FilterPersistentPosChanged: Boolean;
    FilterDeleted: Boolean;

    FilterByVWD: Boolean;
    FilterVWD: Boolean;

    FilterByHasVWDMesh: Boolean;
    FilterHasVWDMesh: Boolean;

    FlattenBlocks: Boolean;
    FlattenCellChilds: Boolean;
    AssignPersWrldChild: Boolean;
    InheritConflictByParent: Boolean;

    InitStarted: Boolean;
    GeneratorStarted: Boolean;
    GeneratorDone: Boolean;

    ComparingSiblings: Boolean;
    CompareRecords: TDynMainRecords;

    ScriptEngine: TJvInterpreterProgram;
    ScriptProcessElements: TwbElementTypes;
    ScriptHotkeys: TStringList;

//    STATsWithWindows: TStringList;

    PluggyLinkState: TwbPluggyLinkState;
    PluggyFormID: Cardinal;
    PluggyBaseFormID: Cardinal;
    PluggyInventoryFormID: Cardinal;
    PluggyEnchantmentFormID: Cardinal;
    PluggySpellFormID: Cardinal;
    PluggyLinkThread: TPluggyLinkThread;

    procedure DoInit;
    procedure SetDoubleBuffered(aWinControl: TWinControl);
    procedure SetActiveRecord(const aMainRecord: IwbMainRecord); overload;
    procedure SetActiveRecord(const aMainRecords: TDynMainRecords); overload;

    procedure ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
//    procedure ScriptScanProgress(aTotalCount, aCount: Integer);
  public
    destructor Destroy; override;

    procedure AddMessage(const s: string);
    procedure AddFile(const aFile: IwbFile);

    procedure ReInitTree;

    procedure PostAddMessage(const s: string);
    procedure SendAddFile(const aFile: IwbFile);
    procedure SendLoaderDone;

    procedure PostPluggyChange(aFormID, aBaseFormID, aInventoryFormID, aEnchantmentFormID, aSpellFormID: Cardinal);
  end;

  TLoaderThread = class(TThread)
  protected
    ltLoadOrderOffset: Integer;
    ltLoadList: TStringList;
    ltDataPath: string;
    ltMaster: string;
    ltFiles: array of IwbFile;
    ltTemporary: Boolean;

    procedure Execute; override;
  public
    constructor Create(var aList: TStringList; IsTemporary: Boolean = False); overload;
    constructor Create(aFileName: string; aMaster: string; aLoadOrder: Integer; IsTemporary: Boolean = False); overload;
    destructor Destroy; override;
  end;

  TPluggyLinkThread = class(TThread)
  private
    plFolder                : string;
    plLastFormID            : Cardinal;
    plLastBaseFormID        : Cardinal;
    plLastInventoryFormID   : Cardinal;
    plLastEnchantmentFormID : Cardinal;
    plLastSpellFormID       : Cardinal;
  protected
    procedure Execute; override;
    procedure ChangeDetected;
  end;

  IHistoryEntry = interface
    ['{C15C6B99-F25D-4CF3-8E60-ED26A42D6BFB}']
    function Remove(const aMainRecord: IwbMainRecord): Boolean;
    procedure Show;
  end;

  THistoryEntry = class(TInterfacedObject, IHistoryEntry)
  protected
    {--- IHistoryEntry ---}
    function Remove(const aMainRecord: IwbMainRecord): Boolean; virtual;
    procedure Show; virtual; abstract;
  end;

  TTabHistoryEntry = class(THistoryEntry)
  private
    tiTabSheet: TTabSheet;
  protected
    {--- IHistoryEntry ---}
    procedure Show; override;
  public
    constructor Create(aTabSheet: TTabSheet);
  end;

  TCompareRecordsHistoryEntry = class(THistoryEntry)
  private
    crRecords: TDynMainRecords;
    crRecordsChanged: Boolean;
  protected
    {--- IHistoryEntry ---}
    function Remove(const aMainRecord: IwbMainRecord): Boolean; override;
    procedure Show; override;
  public
    constructor Create(const aCompareRecords: TDynMainRecords);
  end;

  TCompareRecordsPosHistoryEntry = class(TCompareRecordsHistoryEntry)
  private
    crpOffsetXY: TPoint;
    crpFocusNode: PVirtualNode;                             {only use for if Assigned check!}
    crpFocusRect: TRect;
    crpFocusColumn: TColumnIndex;
    crpColumnWidths: array of Integer;
  protected
    {--- IHistoryEntry ---}
    procedure Show; override;
  public
    constructor Create(const aCompareRecords: TDynMainRecords);
  end;

  TMainRecordHistoryEntry = class(THistoryEntry)
  private
    mrRecord: IwbMainRecord;
  protected
    function GetTabSheet: TTabSheet; virtual;

    {--- IHistoryEntry ---}
    function Remove(const aMainRecord: IwbMainRecord): Boolean; override;
    procedure Show; override;
  public
    constructor Create(const aMainRecord: IwbMainRecord);
  end;

  TMainRecordRefByHistoryEntry = class(TMainRecordHistoryEntry)
  protected
    function GetTabSheet: TTabSheet; override;
  end;

  TMainRecordPosHistoryEntry = class(TMainRecordHistoryEntry)
  private
    mrpOffsetXY: TPoint;
    mrpFocusNode: PVirtualNode;                             {only use for if Assigned check!}
    mrpFocusRect: TRect;
    mrpFocusColumn: TColumnIndex;
    mrpColumnWidths: array of Integer;
  protected
    {--- IHistoryEntry ---}
    procedure Show; override;
  public
    constructor Create(const aMainRecord: IwbMainRecord);
  end;

var
  frmMain                     : TfrmMain;
  FilesToRename               : TStringList;

procedure DoRename;

implementation

{$R *.dfm}

uses
  Colors,
  Mask,
  {$IFNDEF LiteVersion}
  cxVTEditors,
  {$ENDIF}
  ShlObj,
  Registry,
  StrUtils,
  Types,
  {$IFNDEF VER220}
  UITypes,
  {$ENDIF VER220}
  wbScriptAdapter,
  FilterOptionsFrm,
  FileSelectFrm,
  ViewElementsFrm,
  EditWarningFrm,
  frmLocalizationForm,
  frmLocalizePluginForm,
  frmScriptForm,
  frmLogAnalyzerForm,
  frmOptionsForm;

var
  NoNodes                     : TNodeArray;

function Displayable(aSignature: TwbSignature): String;
var
  Sig : TwbSignature;
  i   : Integer;
begin
  Sig := aSignature;
  for i := Low(Sig) to High(Sig) do
    if Ord(Sig[i]) < 32 then
      Sig[i] := AnsiChar( Ord('a') + Ord(Sig[i]) );

  Result := Sig;
end;

function GetFormIDCallback(const aElement: IwbElement): Cardinal;
var
  s                           : string;
begin
  if Assigned(aElement) then
    s := IntToHex64(aElement._File.FileFormIDtoLoadOrderFormID(aElement._File.NewFormID), 8);

  Result := 0;

  if InputQuery('New FormID', 'Please enter the new FormID in hex. e.g. 0404CC43. The FormID needs to be a load order corrected form ID.', s) then try
    Result := StrToInt64('$' + s);
  except
    on E: Exception do
      Application.HandleException(E);
  end;
end;

procedure DoRename;
var
  i       : Integer;
  s,
  f,
  t,
  e       : string;
  OrgDate : Integer;
begin
  wbFileForceClosed;

  if wbDontSave then
    Exit;

  if Assigned(FilesToRename) then
    for i := 0 to Pred(FilesToRename.Count) do begin
      // create backup file
      s := FilesToRename.Names[i];
      f := wbDataPath + s;
      OrgDate := FileAge(f);
      t := wbBackupPath + ExtractFileName(s) + '.backup.' + FormatDateTime('yyyy_mm_dd_hh_nn_ss', Now);
      if not wbDontBackup then begin
        // backup original file
        if not RenameFile(f, t) then begin
          MessageBox(0, PChar('Could not rename "' + f + '" to "' + t + '".'), 'Error', 0);
          Continue;
        end;
      end else
        // remove original file
        if not SysUtils.DeleteFile(f) then begin
          MessageBox(0, PChar('Could not delete "' + f + '".'), 'Error', 0);
          Continue;
        end;
      // rename temp save file to original
      t := f;
      s := FilesToRename.ValueFromIndex[i];
      f := wbDataPath + s;
      if not RenameFile(f, t) then
        MessageBox(0, PChar('Could not rename "' + f + '" to "' + t + '".'), 'Error', 0)
      else begin
        // restore timestamp on a new file
        e := ExtractFileExt(t);
        if SameText(e, '.esp') or SameText(e, '.esm') or SameText(e, '.ghost') then
          FileSetDate(t, OrgDate);
      end;
    end;
end;

procedure TfrmMain.acBackExecute(Sender: TObject);
var
  Intf                        : IInterface;
begin
  if Assigned(BackHistory) and (BackHistory.Count > 0) then begin
    Intf := BackHistory.Last;
    BackHistory.Remove(Intf);
    JumpTo(Intf, True);
  end;
end;

procedure TfrmMain.acBackUpdate(Sender: TObject);
begin
  acBack.Enabled := Assigned(BackHistory) and (BackHistory.Count > 0);
end;

procedure TfrmMain.acForwardExecute(Sender: TObject);
var
  Intf                        : IInterface;
begin
  if Assigned(ForwardHistory) and (ForwardHistory.Count > 0) then begin
    Intf := ForwardHistory.Last;
    ForwardHistory.Remove(Intf);
    JumpTo(Intf, False);
  end;
end;

procedure TfrmMain.acForwardUpdate(Sender: TObject);
begin
  acForward.Enabled := Assigned(ForwardHistory) and (ForwardHistory.Count > 0);
end;

procedure TfrmMain.acScriptExecute(Sender: TObject);
var
  slScript: TStringList;
  i: integer;
  s: string;
begin
  if not Assigned(Sender) then
    Exit;

  i := Pred((Sender as TAction).Tag);
  if i >= ScriptHotkeys.Count then
    Exit;

  slScript := TStringList.Create;
  try
    slScript.LoadFromFile(ScriptHotkeys[i]);
    s := slScript.Text;
  finally
    slScript.Free;
  end;

  ApplyScript(s);
end;

procedure TfrmMain.AddFile(const aFile: IwbFile);
begin
  SetLength(Files, Succ(Length(Files)));
  Files[High(Files)] := aFile;

  vstNav.AddChild(nil, Pointer(aFile));
  aFile._AddRef;
end;

procedure TfrmMain.AddMessage(const s: string);
begin
  mmoMessages.Lines.Add(s);
  stbMain.Panels[0].Text := s;

  mmoMessages.CaretPos := Point(0, mmoMessages.Lines.Count - 1);
  mmoMessages.SelLength := 1;
  mmoMessages.SelLength := 0;

  if pgMain.ActivePage <> tbsMessages then
    tbsMessages.Highlighted := True;
end;

function TfrmMain.AddNewFile(out aFile: IwbFile): Boolean;
var
  s                           : string;
  LoadOrder                   : Integer;
begin
  aFile := nil;
  Result := False;
  s := '';
  if InputQuery('New Module File', 'Filename without extension:', s) then begin
    Result := True;
    if s = '' then
      Exit;
    s := s + '.esp';
    if FileExists(wbDataPath + s) then begin
      ShowMessage('A file of that name exists already.');
      Exit;
    end;

    LoadOrder := 0;
    if Length(Files) > 0 then
      LoadOrder := Succ(Files[High(Files)].LoadOrder);

    aFile := wbNewFile(wbDataPath + s, LoadOrder);
    SetLength(Files, Succ(Length(Files)));
    Files[High(Files)] := aFile;
    vstNav.AddChild(nil, Pointer(aFile));
    aFile._AddRef;
  end;
end;

function CompareLoadOrder(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if Index1 = Index2 then begin
    Result := 0;
    Exit;
  end;

  Result := CmpI32(
    IwbFile(Pointer(List.Objects[Index1])).LoadOrder,
    IwbFile(Pointer(List.Objects[Index2])).LoadOrder);
end;

function TfrmMain.AddRequiredMasters(aMasters: TStrings; const aTargetFile: IwbFile): Boolean;
var
  sl                          : TStringList;
  i, j                        : Integer;
begin
  Result := True;

  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    sl.AddStrings(aMasters);

    for i := 0 to Pred(aTargetFile.MasterCount) do
      if sl.Find(aTargetFile.Masters[i].FileName, j) then
        sl.Delete(j);
    if sl.Find(aTargetFile.FileName, j) then
      sl.Delete(j);

    if sl.Count > 0 then begin

      for i := 0 to Pred(sl.Count) do
        if IwbFile(Pointer(sl.Objects[i])).LoadOrder >= aTargetFile.LoadOrder then
          raise Exception.Create('The required master "' + sl[i] + '" can not be added to "' + aTargetFile.FileName + '" as it has a higher load order');

      Result := MessageDlg('To continue the following files need to be added to "' +
        aTargetFile.FileName + '" as masters:'#13#13 + sl.Text +
        #13'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;

      sl.Sorted := False;
      sl.CustomSort(CompareLoadOrder);

      if Result then
        aTargetFile.AddMasters(sl);
    end else
      Result := True;
  finally
    sl.Free;
  end;
end;

function TfrmMain.AddRequiredMasters(const aSourceElement: IwbElement; const aTargetFile: IwbFile; aAsNew: Boolean): Boolean;
var
  sl                          : TStringList;
  i, j                        : Integer;

begin
  Result := True;
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    aSourceElement.ReportRequiredMasters(sl, aAsNew);

    for i := 0 to Pred(aTargetFile.MasterCount) do
      if sl.Find(aTargetFile.Masters[i].FileName, j) then
        sl.Delete(j);
    if sl.Find(aTargetFile.FileName, j) then
      sl.Delete(j);

    if sl.Count > 0 then begin

      for i := 0 to Pred(sl.Count) do
        if IwbFile(Pointer(sl.Objects[i])).LoadOrder >= aTargetFile.LoadOrder then
          raise Exception.Create('The required master "' + sl[i] + '" can not be added to "' + aTargetFile.FileName + '" as it has a higher load order');

      Result := MessageDlg('To continue the following files need to be added to "' +
        aTargetFile.FileName + '" as masters:'#13#13 + sl.Text +
        #13'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;

      sl.Sorted := False;
      sl.CustomSort(CompareLoadOrder);

      if Result then
        aTargetFile.AddMasters(sl);
    end else
      Result := True;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = 524 {WM_XBUTTONUP} then
    case LongRec(Msg.wParam).Hi of
      1: Handled := acBack.Execute;
      2: Handled := acForward.Execute;
    end;
end;

type
  TCoords = TwbVector;

  PRefInfo = ^TRefInfo;
  TRefInfo = record
    FormID : Cardinal;
    Pos    : TCoords;
    Rot    : TCoords;
    Scale  : Single;
    Next   : PRefInfo;
  end;

procedure TfrmMain.mniPathPluggyLinkClick(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := True;

  if mniPathPluggyLinkReference.Checked then
    PluggyLinkState := plsReference
  else if mniPathPluggyLinkBaseObject.Checked then
    PluggyLinkState := plsBase
  else if mniPathPluggyLinkInventory.Checked then
    PluggyLinkState := plsInventory
  else if mniPathPluggyLinkEnchantment.Checked then
    PluggyLinkState := plsEnchantment
  else if mniPathPluggyLinkSpell.Checked then
    PluggyLinkState := plsSpell
  else
    PluggyLinkState := plsNone;

  if (PluggyLinkState = plsNone) or Assigned(PluggyLinkThread) and (PluggyLinkThread.Terminated) then
    FreeAndNil(PluggyLinkThread);

  if (PluggyLinkState <> plsNone) and not Assigned(PluggyLinkThread) then
    PluggyLinkThread := TPluggyLinkThread.Create(False);
end;

procedure TfrmMain.BuildAllRef;
var
  i     : Integer;
  _File : IwbFile;
begin
  wbStartTime := Now;
  pgMain.ActivePage := tbsMessages;

  Enabled := False;
  try
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      if not (csRefsBuild in _File.ContainerStates) then begin
        pgMain.ActivePage := tbsMessages;
        wbCurrentAction := 'Building reference information for ' + _File.Name;
        AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] ' + wbCurrentAction);
        Application.ProcessMessages;
        _File.BuildRef;
      end;
    end;
    AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] All done!');
  finally
    wbCurrentAction := '';
    Caption := Application.Title;
    Enabled := True;
  end;
end;

function TfrmMain.ByRefSelectionIncludesAnyDeepCopyRecords(aSelection: TDynMainRecords): Boolean;
var
  i                           : Integer;
  MainRecord                  : IwbMainRecord;
begin
  Result := True;
  if Length(aSelection) < 1 then
    aSelection := GetRefBySelectionAsMainRecords;
  if Length(aSelection) < 1 then
    Exit;
  for i := Low(aSelection) to High(aSelection) do begin
    MainRecord := aSelection[i];
    if Assigned(MainRecord.ChildGroup) then
      Exit;
  end;
  Result := False;
end;

function TfrmMain.ByRefSelectionIncludesNonCopyNewRecords(aSelection: TDynMainRecords): Boolean;
var
  i                           : Integer;
  MainRecord                  : IwbMainRecord;
  Signature                   : TwbSignature;
begin
  Result := True;
  if Length(aSelection) < 1 then
    aSelection := GetRefBySelectionAsMainRecords;
  if Length(aSelection) < 1 then
    Exit;
  for i := Low(aSelection) to High(aSelection) do begin
    MainRecord := aSelection[i];
    Signature := MainRecord.Signature;
    if (Signature = 'CELL') or (Signature = 'WRLD') or (Signature = 'ROAD') or (Signature = 'LAND') or (Signature = 'PGRD') or (Signature = 'NAVM') or (Signature = 'NAVI') then
      Exit;
  end;
  Result := False;
end;

function TfrmMain.ByRefSelectionIncludesOnlyDeepCopyRecords(aSelection: TDynMainRecords): Boolean;
begin
  Result := False;
end;

procedure TfrmMain.ConflictLevelForMainRecord(const aMainRecord: IwbMainRecord; out aConflictAll: TConflictAll; out aConflictThis: TConflictThis);

  procedure Fix(const aMainRecord: IwbMainRecord);
  begin
    with aMainRecord do begin
      ConflictAll := aConflictAll;
      if ConflictThis = ctUnknown then begin
        ConflictThis := ctHiddenByModGroup;
      end;
    end;
  end;

var
  NodeDatas                   : TDynViewNodeDatas;
  i                           : Integer;
  Master                      : IwbMainRecord;
begin
  aConflictAll := aMainRecord.ConflictAll;
  aConflictThis := aMainRecord.ConflictThis;

  if aConflictAll > caUnknown then
    Exit;

  Master := aMainRecord.MasterOrSelf;
  if (Master.OverrideCount = 0) and not wbTranslationMode and not (Master.Signature = 'GMST') then begin
    aConflictAll := caOnlyOne;
    aConflictThis := ctOnlyOne;
    aMainRecord.ConflictAll := aConflictAll;
    aMainRecord.ConflictThis := aConflictThis;
  end else begin
    NodeDatas := NodeDatasForMainRecord(aMainRecord);
    aConflictAll := ConflictLevelForChildNodeDatas(NodeDatas, False, (aMainRecord.MasterOrSelf.IsInjected and not (aMainRecord.Signature = 'GMST')) );

    for i := Low(NodeDatas) to High(NodeDatas) do
      with NodeDatas[i] do
        if Assigned(Element) then
          with (Element as IwbMainRecord) do begin
            ConflictAll := aConflictAll;
            ConflictThis := NodeDatas[i].ConflictThis;
          end;

    Fix(Master);
    for i := 0 to Pred(Master.OverrideCount) do
      Fix(Master.Overrides[i]);

    aConflictThis := aMainRecord.ConflictThis;
  end;
end;

function TfrmMain.ConflictLevelForNodeDatas(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer; aSiblingCompare, aInjected: Boolean): TConflictAll;
var
  Element             : IwbElement;
  CompareElement      : IwbElement;
  i{, j }             : Integer;
  UniqueValues        : TnxFastStringListCS;

  FirstElement        : IwbElement;
  LastElement         : IwbElement;
  SameAsLast          : Boolean;
  SameAsFirst         : Boolean;
  OverallConflictThis : TConflictThis;
  Priority            : TwbConflictPriority;
//  IgnoreConflicts     : Boolean;
  FoundAny            : Boolean;
begin
//  if aSiblingCompare then
//    Priority := cpBenign
//  else
//    Priority := cpNormal;
//  IgnoreConflicts := False;
  FoundAny := False;
  OverallConflictThis := ctUnknown;
  case aNodeCount of
    0: Result := caUnknown;
    1: begin
        Element := aNodeDatas[0].Element;
        if Assigned(Element) then begin
          if Element.ConflictPriority = cpIgnore then
            aNodeDatas[0].ConflictThis := ctIgnored
          else
            aNodeDatas[0].ConflictThis := ctOnlyOne;
        end else
          aNodeDatas[0].ConflictThis := ctNotDefined;
        Result := caOnlyOne;
      end
  else
    LastElement := aNodeDatas[Pred(aNodeCount)].Element;
    FirstElement := aNodeDatas[0].Element;

    UniqueValues := TnxFastStringListCS.Create;
    UniqueValues.Sorted := True;
    UniqueValues.Duplicates := dupIgnore;
    Priority := cpNormal;
    try
      for i := 0 to Pred(aNodeCount) do begin
        Element := aNodeDatas[i].Element;
        if Assigned(Element) then begin
          FoundAny := True;
          Priority := Element.ConflictPriority;
          if Priority = cpIgnore then begin
//            IgnoreConflicts := True;
//            for j := 0 to Pred(i) do
//              aNodeDatas[j].ConflictThis := ctIgnored
          end else if aSiblingCompare then
            if Priority > cpBenign then
              Priority := cpBenign;
          if aInjected and (Priority >= cpNormal) then
            Priority := cpCritical;

          if Priority <> cpIgnore then
            UniqueValues.Add(Element.SortKey[True]);
        end else
          if not (vnfIgnore in aNodeDatas[i].ViewNodeFlags) then
            UniqueValues.Add('');

        if Priority = cpIgnore then
          aNodeDatas[i].ConflictThis := ctIgnored
        else if aSiblingCompare then
          aNodeDatas[i].ConflictThis := ctOnlyOne
        else if i = 0 then begin

          if Assigned(Element) then
            aNodeDatas[i].ConflictThis := ctMaster
          else
            aNodeDatas[i].ConflictThis := ctUnknown;

        end else begin
          SameAsLast := (i = Pred(aNodeCount)) or not (
            (Assigned(Element) <> Assigned(LastElement)) or
            (Assigned(Element) and not SameStr(Element.SortKey[True], LastElement.SortKey[True]))
            );

          SameAsFirst := not (
            (Assigned(Element) <> Assigned(FirstElement)) or
            (Assigned(Element) and not SameStr(Element.SortKey[True], FirstElement.SortKey[True]))
            );
          if not SameAsFirst and
             (Priority = cpBenignIfAdded) and
             SameAsLast and  // We are not overriden later
             not Assigned(FirstElement) then begin // The master did not have that element
            Priority := cpBenign;
            SameAsFirst := True;
          end;

          if SameAsFirst then
            aNodeDatas[i].ConflictThis := ctIdenticalToMaster
          else if SameAsLast then
            aNodeDatas[i].ConflictThis := ctConflictWins
          else
            aNodeDatas[i].ConflictThis := ctConflictLoses;
        end;

        if (Priority = cpBenign) and (aNodeDatas[i].ConflictThis > ctConflictBenign) then
          aNodeDatas[i].ConflictThis := ctConflictBenign;

        if aNodeDatas[i].ConflictThis > OverallConflictThis then
          OverallConflictThis := aNodeDatas[i].ConflictThis;
      end;

//      if IgnoreConflicts then
//        Result := caNoConflict
//      else
      case UniqueValues.Count of
        0: Result := caNoConflict;
        1: Result := caNoConflict;
        2: begin
            Element := aNodeDatas[0].Element;
            CompareElement := aNodeDatas[Pred(aNodeCount)].Element;
            if (Assigned(Element) <> Assigned(CompareElement)) or
              (Assigned(Element) and not SameStr(Element.SortKey[True], CompareElement.SortKey[True])) then
              Result := caOverride
            else if (UniqueValues.IndexOf('') >= 0) and Assigned(CompareElement) and (CompareElement.SortKey[True] <> '') then
              Result := caOverride
            else
              Result := caConflict;
          end
      else
        Result := caConflict;
      end;

      if aSiblingCompare and (Result > caConflictBenign) then
        Result := caConflictBenign;

      if not FoundAny then
        for i := 0 to Pred(aNodeCount) do
          aNodeDatas[i].ConflictThis := ctNotDefined;

      if Result > caNoConflict then
        case Priority of
          cpBenign: Result := caConflictBenign;
          cpCritical: begin
              if UniqueValues.Find('', i) then
                UniqueValues.Delete(i);
              if UniqueValues.Count > 1 then
                Result := caConflictCritical;
            end;
        end;

      if Priority > cpBenign then
        if OverallConflictThis > ctOverride then
          with aNodeDatas[Pred(aNodeCount)] do
            if ConflictThis < ctOverride then
              if ConflictThis = ctIdenticalToMaster then
                ConflictThis := ctIdenticalToMasterWinsConflict
              else
                ConflictThis := ctConflictWins;

      if Result in [caNoConflict, caOverride, caConflict] then
        for i := 0 to Pred(aNodeCount) do begin
          case aNodeDatas[i].ConflictThis of
            ctIdenticalToMaster: case Result of
                caNoConflict: ;
                caOverride, caConflict: if i = Pred(aNodeCount) then
                  aNodeDatas[i].ConflictThis := ctIdenticalToMasterWinsConflict
              end;
            ctConflictWins: case Result of
              caNoConflict: aNodeDatas[i].ConflictThis := ctIdenticalToMaster;
              caOverride: aNodeDatas[i].ConflictThis := ctOverride;
              caConflict: ;
            end;
          end;
        end;

      if Result < caConflict then
        for i := 0 to Pred(aNodeCount) do
          if aNodeDatas[i].ConflictThis >= ctIdenticalToMasterWinsConflict then begin
            Result := caConflict;
            Break;
          end;

    finally
      FreeAndNil(UniqueValues);
    end;
  end;
end;

procedure AfterCopyAdjustSpawnRate(const aElement: IwbElement);
var
  MainRecord         : IwbMainRecord;
  LeveledListEntries : IwbContainerElementRef;
  LeveledListEntry   : IwbContainerElementRef;
  Entries            : array of IwbContainerElementRef;
  i, j               : Integer;
const
  Counts : array [0..8] of Integer = (1,1,2,2,2,2,2,3,3);
begin
  if Supports(aElement, IwbMainRecord, MainRecord) then begin

    LeveledListEntries := MainRecord.ElementByName['Leveled List Entries'] as IwbContainerElementRef;
    Assert(Assigned(LeveledListEntries));

    for i := 0 to Pred(LeveledListEntries.ElementCount) do
      if Supports(LeveledListEntries.Elements[i], IwbContainerElementRef, LeveledListEntry) and
        SameText(LeveledListEntry.Name, 'LVLO - Leveled List Entry') then begin
          SetLength(Entries, Succ(Length(Entries)));
          Entries[High(Entries)] := LeveledListEntry;
        end;

    for i := Low(Entries) to High(Entries) do
      for j := Low(Counts) to High(Counts) do begin
        LeveledListEntry := LeveledListEntries.Assign(Low(Integer), Entries[i], False) as IwbContainerElementRef;
        LeveledListEntry.ElementByName['Count'].NativeValue := Counts[j];
      end;
  end;
end;

function TfrmMain.CopyInto(AsNew, AsWrapper, AsSpawnRate, DeepCopy: Boolean; const aElements: TDynElements; aAfterCopyCallback: TAfterCopyCallback): TDynElements;
var
  MainRecord           : IwbMainRecord;
  MainRecord2          : IwbMainRecord;
  Master               : IwbMainRecord;
  ReferenceFile        : IwbFile;
  sl                   : TStringList;
  i, j                 : Integer;
  EditorID             : string;
  EditorIDPrefixRemove : string;
  EditorIDPrefix       : string;
  EditorIDSuffix       : string;
  Multiple             : Boolean;
  LeveledListEntries   : IwbContainerElementRef;
  LeveledListEntry     : IwbContainerElementRef;
  CopiedElement        : IwbElement;
  Container            : IwbContainer;
begin
  if Assigned(aAfterCopyCallback) then begin
    Assert(not AsNew);
    Assert(not AsWrapper);
    Assert(not AsSpawnRate);
    Assert(not DeepCopy);
  end;

  if AsSpawnRate then begin
    Assert(not AsNew);
    Assert(not AsWrapper);
    Assert(not DeepCopy);
    aAfterCopyCallback := AfterCopyAdjustSpawnRate;
  end;

  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    for i := Low(aElements) to High(aElements) do begin
      aElements[i].ReportRequiredMasters(sl, AsNew);
      Container := aElements[i].Container;
      while Assigned(Container) do begin
        Container.ReportRequiredMasters(sl, AsNew, False, True);
        Container := Container.Container;
      end;
    end;

    j := 0;
    for i := 0 to Pred(sl.Count) do
      with IwbFile(Pointer(sl.Objects[i])) do
        if LoadOrder > j then
          j := LoadOrder;

    with TfrmFileSelect.Create(Self) do try

      for i := j to High(Files) do
        if Files[i].IsEditable then
          CheckListBox1.AddItem(Files[i].Name, Pointer(Files[i]));

      Multiple := (Length(aElements) > 1) or (aElements[0].ElementType <> etMainRecord);
      EditorID := '';
      EditorIDPrefixRemove := '';
      EditorIDPrefix := '';
      EditorIDSuffix := '';

      if not Multiple then begin
        MainRecord := (aElements[0] as IwbMainRecord);
        Master := MainRecord.MasterOrSelf;
        if not (AsNew or AsWrapper) then begin
          j := CheckListBox1.Items.IndexOf(Master._File.Name);
          if j >= 0 then
            CheckListBox1.Items.Delete(j);

          for i := 0 to Pred(Master.OverrideCount) do begin
            j := CheckListBox1.Items.IndexOf(Master.Overrides[i]._File.Name);
            if j >= 0 then
              CheckListBox1.Items.Delete(j);
          end;
        end
        else begin
          EditorID := MainRecord.EditorID;
          repeat
            if AsWrapper then begin
              if not InputQuery('EditorID', 'Please enter the EditorID for the wrapped copy', EditorID) then
                Exit;
            end
            else begin
              if not InputQuery('EditorID', 'Please change the EditorID', EditorID) then
                Exit;
            end;
            if EditorID = '' then
              Break;
            if not SameText(EditorID, MainRecord.EditorID) then
              Break;
            if AsWrapper then
              ShowMessage('You need to specify a different EditorID for the wrapped copy.')
            else if MessageDlg('Are you sure you don''t want to change the EditorID?' +
              ' EditorID conflicts will cause error messages in CS when loading.',
              mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
              Break;
          until False;
        end;
      end
      else begin
        if AsWrapper then
          if aElements[0].ElementType <> etMainRecord then
            raise Exception.Create('Can not wrap complete groups');

        if AsNew or AsWrapper then
          repeat
            if not InputQuery('EditorID Prefix', 'Please enter the prefix that should be removed from the EditorIDs if present', EditorIDPrefixRemove) then
              Exit;
            if not InputQuery('EditorID Prefix', 'Please enter the prefix that should be added to EditorIDs', EditorIDPrefix) then
              Exit;
            if not InputQuery('EditorID Suffix', 'Please enter the suffix that should be added to EditorIDs', EditorIDSuffix) then
              Exit;
            if (EditorIDPrefix <> '') or (EditorIDSuffix <> '') then
              Break;
            if AsWrapper then
              ShowMessage('You need to specify a prefix or suffix.')
            else if MessageDlg('Are you sure you don''t want to change the EditorID?' +
              ' EditorID conflicts will cause error messages in CS when loading.',
              mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
              Break;
          until False;
      end;

      CheckListBox1.AddItem('<new file>', nil);

      if Multiple then
        Caption := 'Which files do you want to add these records to?'
      else
        Caption := 'Which files do you want to add this record to?';

      ShowModal;

      SetLength(Result, Length(aElements));

      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then begin
          ReferenceFile := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));
          while not Assigned(ReferenceFile) do
            if not AddNewFile(ReferenceFile) then
              Break;

          if Assigned(ReferenceFile) and AddRequiredMasters(sl, ReferenceFile) then begin

            if AsWrapper then begin

              for j := Low(aElements) to High(aElements) do begin
                MainRecord := aElements[j] as IwbMainRecord;

                MainRecord2 := wbCopyElementToFile(MainRecord, ReferenceFile, True, True, EditorIDPrefixRemove, EditorIDPrefix, EditorIDSuffix) as IwbMainRecord;
                Assert(Assigned(MainRecord2));
                if not Multiple then
                  MainRecord2.EditorID := EditorID;

                EditorID := MainRecord.EditorID;
                MainRecord := wbCopyElementToFile(MainRecord, ReferenceFile, False, False, '', '', '') as IwbMainRecord;
                Assert(Assigned(MainRecord));
                MainRecord.Assign(Low(Integer), nil, False);
                LeveledListEntries := MainRecord.ElementByName['Leveled List Entries'] as IwbContainerElementRef;
                Assert(Assigned(LeveledListEntries));
                Assert(LeveledListEntries.ElementCount = 1);
                LeveledListEntry := LeveledListEntries.Elements[0] as IwbContainerElementRef;
                Assert(Assigned(LeveledListEntry));
                LeveledListEntry.ElementByName['Reference'].EditValue := MainRecord2.EditValue;
                LeveledListEntry.ElementByName['Count'].EditValue := '1';
                LeveledListEntry.ElementByName['Level'].EditValue := '1';
                MainRecord.EditorID := EditorID;
                Result[j] := MainRecord;
              end;

            end
            else if Multiple then begin
              for j := Low(aElements) to High(aElements) do
                try
                  if DeepCopy and Supports(aElements[j], IwbMainRecord, MainRecord) and Assigned(MainRecord.ChildGroup) then
                    Result[j] := wbCopyElementToFile(MainRecord.ChildGroup, ReferenceFile, AsNew, True, EditorIDPrefixRemove, EditorIDPrefix, EditorIDSuffix)
                  else begin
                    CopiedElement := wbCopyElementToFile(aElements[j], ReferenceFile, AsNew, True, EditorIDPrefixRemove, EditorIDPrefix, EditorIDSuffix);
                    if Assigned(CopiedElement) then begin
                      if Assigned(aAfterCopyCallback) then
                        aAfterCopyCallback(CopiedElement);
                    end;
                    Result[j] := CopiedElement;
                  end;
                except
                  on E: Exception do
                    AddMessage('Error while copying '+aElements[j].Name+': '+E.Message);
                end;
            end else begin
              MainRecord := nil;
              if DeepCopy and Supports(aElements[0], IwbMainRecord, MainRecord) and Assigned(MainRecord.ChildGroup) then
                Result[0] := wbCopyElementToFile(MainRecord.ChildGroup, ReferenceFile, AsNew, True, '', '', '')
              else begin
                CopiedElement := wbCopyElementToFile(aElements[0], ReferenceFile, AsNew, True, '', '', '');
                if Assigned(CopiedElement) then begin
                  if Assigned(aAfterCopyCallback) then
                    aAfterCopyCallback(CopiedElement);
                end;
                Result[0] := CopiedElement;
                if not Supports(CopiedElement, IwbMainRecord, MainRecord) then
                  MainRecord := nil;
              end;
              if AsNew and Assigned(MainRecord) then
                MainRecord.EditorID := EditorID;
            end;
          end;
        end;
    finally
      Free;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.mniNavChangeReferencingRecordsClick(Sender: TObject);
var
  s                           : string;
  i                           : Integer;
  NewFormID                   : Cardinal;
  OldFormID                   : Cardinal;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  ReferencedBy                : TDynMainRecords;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  MainRecord := NodeData.Element as IwbMainRecord;

  if not EditWarn then
    Exit;

  SetLength(ReferencedBy, ActiveMaster.ReferencedByCount);
  for i := 0 to Pred(ActiveMaster.ReferencedByCount) do
    ReferencedBy[i] := ActiveMaster.ReferencedBy[i];

  if InputQuery('New FormID', 'Please enter the new FormID in hex. e.g. 0404CC43. The FormID needs to be a load order corrected form ID.', s) then try
    NewFormID := StrToInt64('$' + s);
    if NewFormID = 0 then
      raise Exception.Create('00000000 is not a valid FormID');
    if NewFormID = $14 then
      raise Exception.Create('00000014 is not a valid FormID');

    OldFormID := MainRecord.LoadOrderFormID;
    if NewFormID = OldFormID then begin
      ShowMessage('Old and new FormID are identical');
      Exit;
    end;

    if Length(ReferencedBy) > 0 then
      ShowChangeReferencedBy(OldFormID, NewFormID, ReferencedBy, False)
    else
      raise Exception.Create('No other records reference this record');
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

function TfrmMain.CheckForErrorsLinear(const aElement: IwbElement; LastRecord: IwbMainRecord): IwbMainRecord;
var
  Error                       : string;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
begin
  Error := aElement.Check;
  if Error <> '' then begin
    Result := aElement.ContainingMainRecord;
    // first error in this record - show record's name
    if Assigned(Result) and (Result <> LastRecord) then
      wbProgressCallback(Result.Name);
    wbProgressCallback('    ' + aElement.Path + ' -> ' + Error);
  end else
    // passing through last record with error
    Result := LastRecord;
  if Supports(aElement, IwbContainerElementRef, Container) then
    for i := 0 to Pred(Container.ElementCount) do
      Result := CheckForErrorsLinear(Container.Elements[i], Result);
end;

function TfrmMain.CheckForErrors(const aIndent: Integer; const aElement: IwbElement): Boolean;
var
  Error                       : string;
  Container                   : IwbContainerElementRef;
  i                           : Integer;
begin
  Error := aElement.Check;
  Result := Error <> '';
  if Result then begin
    Error := aElement.Check;
    wbProgressCallback(StringOfChar(' ', aIndent * 2) + aElement.Name + ' -> ' + Error);
  end else
    wbProgressCallback('');
//!!!!
  if Supports(aElement, IwbContainerElementRef, Container) then
    for i := Pred(Container.ElementCount) downto 0 do
      Result := CheckForErrors(aIndent + 1, Container.Elements[i]) or Result;

  if Result and (Error = '') then begin
    wbProgressCallback(StringOfChar(' ', aIndent * 2) + 'Above errors were found in :' + aElement.Name);
  end;
end;

procedure TfrmMain.CheckHistoryRemove(const aList: IInterfaceList; const aMainRecord: IwbMainRecord);
var
  i                           : Integer;
  Intf                        : IInterface;
  HistoryEntry                : IHistoryEntry;
begin
  if not Assigned(aList) then
    Exit;
  if not Assigned(aMainRecord) then
    Exit;
  for i := Pred(aList.Count) downto 0 do begin
    Intf := aList[i];
    if Supports(Intf, IHistoryEntry, HistoryEntry) then
      if HistoryEntry.Remove(aMainRecord) then
        aList.Remove(Intf);
  end;
end;

procedure TfrmMain.mniNavCheckForCircularLeveledListsClick(Sender: TObject);

  procedure CheckGroup(const aGroup: IwbGroupRecord);
  var
    i          : Integer;
    MainRecord : IwbMainRecord;
  begin
    if not Assigned(aGroup) then
      Exit;
    for i := 0 to Pred(aGroup.ElementCount) do
      if Supports(aGroup.Elements[i], IwbMainRecord, MainRecord) then try
        wbLeveledListCheckCircular(MainRecord.WinningOverride, nil);
      except
        on e: Exception do
          PostAddMessage(E.Message);
      end;
  end;

var
  i     : Integer;
  _File : IwbFile;
begin
  ResetAllTags;
  for i := Low(Files) to High(Files) do begin
    _File := Files[i];
    CheckGroup(_File.GroupBySignature['LVLI']);
    CheckGroup(_File.GroupBySignature['LVLC']);
    CheckGroup(_File.GroupBySignature['LVLN']);
    CheckGroup(_File.GroupBySignature['LVSP']);
  end;
end;

procedure TfrmMain.mniNavCheckForErrorsClick(Sender: TObject);
var
  Nodes                       : TNodeArray;
  NodeData                    : PNavNodeData;
  i                           : Integer;
begin
  UserWasActive := True;

  Inc(wbShowStartTime);
  wbStartTime := Now;
  Enabled := False;
  pgMain.ActivePage := tbsMessages;
  try
    Nodes := vstNav.GetSortedSelection(True);
    for i := Low(Nodes) to High(Nodes) do begin
      NodeData := vstNav.GetNodeData(Nodes[i]);
      if Assigned(NodeData) then
        if Assigned(NodeData.Container) then begin
          wbCurrentAction := 'Checking for Errors in ' + NodeData.Container.Name;
          wbProgressCallback(wbCurrentAction);
          CheckForErrorsLinear(NodeData.Container, nil)
          //CheckForErrors(0, NodeData.Container)
        end else if Assigned(NodeData.Element) then begin
          wbCurrentAction := 'Checking for Errors in ' + NodeData.Element.Name;
          wbProgressCallback(wbCurrentAction);
          CheckForErrorsLinear(NodeData.Element, nil)
          //CheckForErrors(0, NodeData.Element);
        end;
    end;
    wbProgressCallback('All Done!');
  finally
    wbCurrentAction := '';
    Caption := Application.Title;
    Enabled := True;
    Dec(wbShowStartTime);
  end;
end;

procedure TfrmMain.mniNavCleanMastersClick(Sender: TObject);
var
  Nodes                       : TNodeArray;
  NodeData                    : PNavNodeData;
  _File                       : IwbFile;
  i                           : Integer;
begin
  UserWasActive := True;

  Nodes := vstNav.GetSortedSelection(True);
  for i := Low(Nodes) to High(Nodes) do begin
    NodeData := vstNav.GetNodeData(Nodes[i]);
    if Assigned(NodeData) and Supports(NodeData.Element, IwbFile, _File) then
      if _File.IsEditable then
        _File.CleanMasters;
  end;
end;

procedure TfrmMain.mniNavCompareSelectedClick(Sender: TObject);
var
  SelectedNodes               : TNodeArray;
  NodeData                    : PNavNodeData;
  MainRecords                 : TDynMainRecords;
  i                           : Integer;
begin
  SelectedNodes := vstNav.GetSortedSelection(True);
  if Length(SelectedNodes) < 2 then
    Exit;

  SetLength(MainRecords, Length(SelectedNodes));
  for i := Low(SelectedNodes) to High(SelectedNodes) do begin
    NodeData := vstNav.GetNodeData(SelectedNodes[i]);
    MainRecords[i] := NodeData.Element as IwbMainRecord;
  end;

  SetActiveRecord(MainRecords);
end;

procedure TfrmMain.mniNavCompareToClick(Sender: TObject);
var
  _File        : IwbFile;
  NodeData     : PNavNodeData;
  CompareFile  : string;
  s            : String;
  i            : Integer;
  Temporary    : Boolean;
begin
  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  if not Assigned(NodeData) then
    Exit;
  if not Supports(NodeData.Element, IwbFile, _File) then
    Exit;

  with odModule do begin
    FileName := '';
    InitialDir := wbDataPath;
    if not Execute then
      Exit;

    CompareFile := FileName;
    // copy selected file to Data directory without overwriting an existing file
    if not SameText(ExtractFilePath(CompareFile), wbDataPath) then begin
      s := wbDataPath + ExtractFileName(CompareFile);
      if FileExists(s) then // Finds a unique name
        for i := 0 to 255 do begin
          s := wbDataPath + ChangeFileExt(ExtractFileName(CompareFile), '.' + IntToHex(i, 3));
          if not FileExists(s) then Break;
        end;
      if FileExists(s) then begin
        wbProgressCallback('Could not copy '+FileName+' into '+wbDataPath);
        Exit;
      end;
      CompareFile := s;
      CopyFile(PChar(FileName), PChar(CompareFile), false);
      // We need to propagate a flag to mark the copy temporary, so it can be deleted on close
      Temporary := True;
    end else
      Temporary := False;

  end;

  vstNav.PopupMenu := nil;
  wbLoaderDone := False;
  wbLoaderError := False;
  SetActiveRecord(nil);
  mniNavFilterRemoveClick(Sender);
  wbStartTime := Now;
  TLoaderThread.Create(CompareFile, _File.FileName, _File.LoadOrder, Temporary);
end;

procedure TfrmMain.mniNavCopyIdleClick(Sender: TObject);
var
  i, j, k        : Integer;
  Container      : IwbContainerElementRef;
  MainRecord     : IwbMainRecord;
  MainRecords    : TDynMainRecords;
  s              : string;
  sl             : TwbFastStringListIC;
  List           : TList;
  OldElements    : TDynElements;
  NewElements    : TDynElements;
  OldModelPrefix : string;
  NewModelPrefix : string;
  OldFormIDs     : array of Cardinal;
  NewFormIDs     : array of Cardinal;
  OldMainRecord  : IwbMainRecord;
  NewMainRecord  : IwbMainRecord;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  ResetAllTags;

  sl := TwbFastStringListIC.CreateSorted;
  try
    for i := Low(Files) to High(Files) do
      if Supports(Files[i].GroupBySignature['IDLE'], IwbContainerElementRef, Container) then begin
        for j := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[j], IwbMainRecord, MainRecord) then begin
            MainRecord := MainRecord.WinningOverride;
            if not MainRecord.IsTagged then begin
              MainRecord.Tag;
              s := Trim(LowerCase((MainRecord.ElementEditValues['MODL\MODL'])));
              if ExtractFileExt(s) <> '' then
                s := ExtractFilePath(s);
              s := ExcludeTrailingPathDelimiter(s);

              if not sl.Find(s, k) then
                k := sl.AddObject(s, TList.Create);

              TList(sl.Objects[k]).Add(Pointer(MainRecord));

              SetLength(MainRecords, Succ(Length(MainRecords)));
              MainRecords[High(MainRecords)] := MainRecord;
            end;
          end;
      end;

      with TfrmFileSelect.Create(nil) do try

        CheckListBox1.Items.Assign(sl);
        Caption := 'Which Idles do you want to copy?';

        ShowModal;

        for i := 0 to Pred(CheckListBox1.Items.Count) do
          if CheckListBox1.Selected[i] then begin
            List := CheckListBox1.Items.Objects[i] as TList;
            SetLength(OldElements, List.Count);
            for j := 0 to Pred(List.Count) do
              Supports(IInterface(List[j]), IwbElement, OldElements[j]);

            OldModelPrefix := CheckListBox1.Items[i];
            NewModelPrefix := OldModelPrefix;

            repeat
              if not InputQuery('Model Prefix', 'Please change the model prefix', NewModelPrefix) then
                Exit;
            until not SameText(OldModelPrefix, NewModelPrefix);

            NewElements := CopyInto(True, False, False, True, OldElements);
            Assert(Length(NewElements) = Length(OldElements));

            SetLength(OldFormIDs, Length(NewElements));
            SetLength(NewFormIDs, Length(NewElements));

            for j := Low(NewElements) to High(NewElements) do begin
              if not Supports(OldElements[j], IwbMainRecord, OldMainRecord) then
                Assert(False);
              if not Supports(NewElements[j], IwbMainRecord, NewMainRecord) then
                Assert(False);

              OldFormIDs[j] := OldMainRecord.LoadOrderFormID;
              NewFormIDs[j] := NewMainRecord.LoadOrderFormID;
            end;

            for j := Low(NewElements) to High(NewElements) do begin
              if not Supports(NewElements[j], IwbMainRecord, NewMainRecord) then
                Assert(False);

              s := Trim(LowerCase((NewMainRecord.ElementValues['MODL\MODL'])));
              s := NewModelPrefix + Copy(s, Succ(Length(OldModelPrefix)), High(Integer));
              NewMainRecord.ElementEditValues['MODL\MODL'] := s;

              for k := Low(OldFormIDs) to High(OldFormIDs) do
                NewMainRecord.CompareExchangeFormID(OldFormIDs[k], NewFormIDs[k]);
            end;
          end;
      finally
        Free;
      end;

  finally
    for i := 0 to Pred(sl.Count) do
      sl.Objects[i].Free;
    sl.Free;
  end;
end;

procedure TfrmMain.mniNavCopyIntoClick(Sender: TObject);
var
  SelectedNodes               : TNodeArray;
  NodeData                    : PNavNodeData;
  Elements                    : TDynElements;
  i                           : Integer;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  SelectedNodes := vstNav.GetSortedSelection(True);
  if Length(SelectedNodes) < 1 then
    Exit;

  SetLength(Elements, Length(SelectedNodes));
  for i := Low(SelectedNodes) to High(SelectedNodes) do begin
    NodeData := vstNav.GetNodeData(SelectedNodes[i]);
    Elements[i] := NodeData.Element;
  end;

  try
    wbCurrentAction := 'Copying...';
    wbStartTime := now;
    wbShowStartTime := 1;
    wbCurrentTick := GetTickCount;

    CopyInto(
      Sender = mniNavCopyAsNewRecord,
      Sender = mniNavCopyAsWrapper,
      Sender = mniNavCopyAsSpawnRateOverride,
      Sender = mniNavDeepCopyAsOverride,
      Elements);

    for i := Low(SelectedNodes) to High(SelectedNodes) do
      vstNav.IterateSubtree(SelectedNodes[i], ClearConflict, nil);
    InvalidateElementsTreeView(SelectedNodes);
    PostResetActiveTree;
    if (Length(Elements) > 1) or (Elements[0].ElementType <> etMainRecord) then
      vstNav.Invalidate;
  finally
    wbProgressCallback('Copying done.');
    wbCurrentAction := '';
    wbCurrentTick := 0;
    wbShowStartTime := 0;
    Caption := Application.Title;
  end;
end;

procedure TfrmMain.mniNavCreateMergedPatchClick(Sender: TObject);
var
  KeepAlive       : array of IwbContainerElementRef;
  TargetFile      : IwbFile;

  procedure UpdateOrderedTargetList(LeftList, RightList, TargetList: TStringList);
  var
    i: Integer;
  begin
    for i := LeftList.Count to Pred(RightList.Count) do
      TargetList.AddObject(RightList[i], RightList.Objects[i]);
  end;

  procedure UpdateTargetList(LeftList, RightList, TargetList: TStringList);
  var
    Left, Right : Integer;
    Index       : Integer;
  begin
    Left := 0;
    Right := 0;

    while (Left < LeftList.Count) and (Right < RightList.Count) do
      case CompareText(LeftList[Left], RightList[Right]) of
        Low(Integer)..-1: begin
          if TargetList.Find(LeftList[Left], Index) then
            TargetList.Delete(Index);
          Inc(Left);
        end;
        0: begin
          if TargetList.Find(LeftList[Left], Index) then
            TargetList.Objects[Index] := RightList.Objects[Right];
          Inc(Left);
          Inc(Right);
        end;
        1..High(Integer): begin
          if not TargetList.Find(RightList[Right], Index) then
            TargetList.AddObject(RightList[Right], RightList.Objects[Right]);
          Inc(Right);
        end;
      end;

    while (Left < LeftList.Count) do begin
      if TargetList.Find(LeftList[Left], Index) then
        TargetList.Delete(Index);
      Inc(Left);
    end;

    while (Right < RightList.Count) do begin
      if not TargetList.Find(RightList[Right], Index) then
        TargetList.AddObject(RightList[Right], RightList.Objects[Right]);
      Inc(Right);
    end;
  end;

  function ListsEqual(Left, Right: TStringList; ForOrderedList: Boolean = False): Boolean;
  var
    i: Integer;
  begin
    if ForOrderedList then
      Result := Left.Count <= Right.Count
    else
      Result := Left.Count = Right.Count;

    if Result then
      for i := 0 to Pred(Left.Count) do
        if not SameText(Left[i], Right[i]) then begin
          Result := False;
          Exit;
        end;
  end;

  procedure CheckGroup(const aGroup: IwbGroupRecord; const aListNames: array of string;
                       const aCntNames: array of string; aAsSet: Boolean = False);
  var
    IsOrderedList: Boolean;

    function BuildList(const aEntries: IwbElement): TStringList;
    var
      i       : Integer;
      Entries : IwbContainerElementRef;
      Entry   : IwbContainerElementRef;
      Last    : string;
      Count   : Integer;
    begin
      Result := TStringList.Create;
      try
        if aAsSet and not IsOrderedList then begin
          Result.Sorted := True;
          Result.Duplicates := dupIgnore;
        end;
        if not Supports(aEntries, IwbContainerElementRef, Entries) then
          Exit;
        for i := 0 to Pred(Entries.ElementCount) do
          if Supports(Entries.Elements[i], IwbContainerElementRef, Entry) then begin
            SetLength(KeepAlive, Succ(Length(KeepAlive)));
            KeepAlive[High(KeepAlive)] := Entry;
            Result.AddObject(Entry.SortKey[True], Pointer(Entry));
          end;
        if not aAsSet then begin
          Result.Sort;
          Last := '';
          Count := 0;
          for i := 0 to Pred(Result.Count) do begin
            if Result[i] = Last then
              Inc(Count)
            else begin
              Count := 0;
              Last := Result[i];
            end;
            Result[i] := Result[i] + '#' + IntToHex64(Count, 4);
          end;
          Result.Sorted := True;
        end;
      except
        FreeAndNil(Result);
        raise;
      end;
    end;

  var
    i, j, k, l         : Integer;
    MainRecord         : IwbMainRecord;
    TargetRecord       : IwbMainRecord;
    Master             : IwbMainRecord;
    TargetLists        : array of TStringList;
    WinningLists       : array of TStringList;
    CurrentList        : TStringList;
    CurrentMasterList  : TStringList;
    CurrentMasters     : TDynMainRecords;
    CurrentMaster      : IwbMainRecord;
    EditorID           : string;
    SortableContainer  : IwbSortableContainer;
    IsFaultyOrderedList: Boolean;
    CountElement       : IwbElement;
    Entries            : IwbContainerElementRef;
  const
    OrderedList = 'OrderedList';
  begin
    if not Assigned(aGroup) then
      Exit;
    for i := 0 to Pred(aGroup.ElementCount) do
      if Supports(aGroup.Elements[i], IwbMainRecord, MainRecord) then try
        IsFaultyOrderedList := False;
        Master := MainRecord.MasterOrSelf;
        if Master.IsTagged then
          Continue;
        Master.Tag;
        if Master.OverrideCount < 2 then
          Continue;

        SetLength(TargetLists, Length(aListNames));
        SetLength(WinningLists, Length(aListNames));

        for l := Low(aListNames) to High(aListNames) do begin
          IsOrderedList := False;
          if Supports(Master.ElementByName[aListNames[l]], IwbSortableContainer, SortableContainer) then
            if not SortableContainer.Sorted then begin
              EditorID := Master.EditorID;
              if Length(EditorID) > Length(OrderedList) then
                Delete(EditorID, 1, Length(EditorID)-Length(OrderedList));
              IsOrderedList := SameText(EditorID, OrderedList);
              if not IsOrderedList then
                Continue;
            end;

          TargetLists[l] := BuildList(Master.ElementByName[aListNames[l]]);
          for j := 0 to Pred(Master.OverrideCount) do begin
            MainRecord := Master.Overrides[j];
            CurrentList := BuildList(MainRecord.ElementByName[aListNames[l]]);
            CurrentMasters := MainRecord.MasterRecordsFromMasterFilesAndSelf;
            CurrentMaster := nil;
            for k := High(CurrentMasters) downto Low(CurrentMasters) do
              if not MainRecord.Equals(CurrentMasters[k]) then begin
                CurrentMaster := CurrentMasters[k];
                Break;
              end;
            if not Assigned(CurrentMaster) then
              Continue;
            CurrentMasterList := BuildList(CurrentMaster.ElementByName[aListNames[l]]);

            if IsOrderedList then begin
              if not ListsEqual(CurrentMasterList, CurrentList, True) then begin
                ListsEqual(CurrentMasterList, CurrentList, True);
                IsFaultyOrderedList := True
              end else
                UpdateOrderedTargetList(CurrentMasterList, CurrentList, TargetLists[l]);
            end else
              UpdateTargetList(CurrentMasterList, CurrentList, TargetLists[l]);

            CurrentList.Free;
            CurrentMasterList.Free;
            if IsFaultyOrderedList then
              Break;
          end;
          if IsFaultyOrderedList then
            Break;
          MainRecord := Master.WinningOverride;
          WinningLists[l] := BuildList(MainRecord.ElementByName[aListNames[l]]);
        end;

        if IsFaultyOrderedList then begin
          PostAddMessage('Error: Can''t merge faulty ordered list ' + Master.Name);
        end else begin
          TargetRecord := nil;
          for l := Low(aListNames) to High(aListNames) do
            if Assigned(TargetLists[l]) and Assigned(WinningLists[l]) then
              if not ListsEqual(TargetLists[l], WinningLists[l]) then begin
                if not Assigned(TargetRecord) then
                  TargetRecord := wbCopyElementToFile(MainRecord, TargetFile, False, True, '', '', '') as IwbMainRecord;

                TargetRecord.RemoveElement(aListNames[l]);
                for j := 0 to Pred(TargetLists[l].Count) do
                  wbCopyElementToRecord(IwbElement(Pointer(TargetLists[l].Objects[j])), TargetRecord, True, True);

                // update counts
                if (l <= High(aCntNames)) and (aCntNames[l] <> '') then begin
                  TargetRecord.Add(aCntNames[l], True);
                  CountElement := TargetRecord.ElementByPath[aCntNames[l]];
                  if Assigned(CountElement) then
                    if Supports(TargetRecord.ElementByName[aListNames[l]], IwbContainerElementRef, Entries) then
                      CountElement.NativeValue := Entries.ElementCount
                    else
                      CountElement.Remove;
                end;

              end;
        end;

        for l := Low(aListNames) to High(aListNames) do begin
          FreeAndNil(WinningLists[l]);
          FreeAndNil(TargetLists[l]);
        end;
        KeepAlive := nil;
      except
        on e: Exception do
          PostAddMessage(E.Message);
      end;
  end;

var
  sl              : TStringList;
  LastLoadOrder   : Integer;
  i               : Integer;
begin
  if wbGameMode in [gmTES5] then begin
    if MessageDlg('Merged patch is unsupported for ' + wbGameName +
      '. Create it only if you know what you are doing and can troubleshoot possible issues yourself. ' +
      'Do you want to continue?',
      mtWarning, mbYesNo, 0) <> mrYes
    then
      Exit;
  end;

  TargetFile := nil;

  while not Assigned(TargetFile) do
    if not AddNewFile(TargetFile) then
      Exit;

  sl := TStringList.Create;
  try
    LastLoadOrder := -1;
    for i := Low(Files) to Pred(High(Files)) do
      with Files[i] do
        if LoadOrder > LastLoadOrder then begin
          LastLoadOrder := LoadOrder;
          sl.Add(FileName);
        end;
    TargetFile.AddMasters(sl);
  finally
    FreeAndNil(sl);
  end;

  ResetAllTags;
  for i := Succ(Low(Files)) to Pred(High(Files)) do with Files[i] do begin
    CheckGroup(GroupBySignature['LVLI'], ['Leveled List Entries'], ['LLCT']);
    CheckGroup(GroupBySignature['LVLC'], ['Leveled List Entries'], ['LLCT']);
    CheckGroup(GroupBySignature['LVLN'], ['Leveled List Entries'], ['LLCT']);
    CheckGroup(GroupBySignature['LVSP'], ['Leveled List Entries'], ['LLCT']);
    CheckGroup(GroupBySignature['CONT'], ['Items'], ['COCT']);
    CheckGroup(GroupBySignature['FACT'], ['Relations'], []);
    CheckGroup(GroupBySignature['RACE'], ['HNAM - Hairs', 'ENAM - Eyes', 'Actor Effects'], ['', '', 'SPCT']);
    CheckGroup(GroupBySignature['FLST'], ['FormIDs'], [], True);
    CheckGroup(GroupBySignature['CREA'], ['Items', 'Factions'], ['COCT']);
    // exclude Head Parts for Skyrim, causes issues
    if wbGameMode >= gmTES5 then
      CheckGroup(GroupBySignature['NPC_'], ['Items', 'Factions', 'Actor Effects', 'Perks', 'KWDA - Keywords'], ['COCT', '', 'SPCT', 'PRKZ', 'KSIZ'])
    else
      CheckGroup(GroupBySignature['NPC_'], ['Items', 'Factions', 'Head Parts', 'Actor Effects'], []);
    // keywords
    if wbGameMode >= gmTES5 then begin
      CheckGroup(GroupBySignature['ALCH'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['ARMO'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['AMMO'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['BOOK'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['FLOR'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['FURN'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['INGR'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['MGEF'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['MISC'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['SCRL'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['SLGM'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['SPEL'], ['KWDA - Keywords'], ['KSIZ']);
      CheckGroup(GroupBySignature['WEAP'], ['KWDA - Keywords'], ['KSIZ']);
    end;
  end;

  TargetFile.CleanMasters;
end;

procedure TfrmMain.mniNavCreateSEQFileClick(Sender: TObject);
var
  SelectedNodes  : TNodeArray;
  NodeData       : PNavNodeData;
  _File          : IwbFile;
  Group          : IwbGroupRecord;
  i, n, j, Count : Integer;
  MainRecord     : IwbMainRecord;
  QustFlags      : IwbElement;
  FormIDs        : array of Cardinal;
  FileStream     : TFileStream;
  p, s           : string;
begin
  SelectedNodes := vstNav.GetSortedSelection(True);
  if Length(SelectedNodes) < 1 then
    Exit;

  Count := 0;
  j := 0;

  for i := Low(SelectedNodes) to High(SelectedNodes) do begin
    NodeData := vstNav.GetNodeData(SelectedNodes[i]);

    if Assigned(NodeData.Element) and (NodeData.Element.ElementType = etFile) then begin
      SetLength(FormIDs, 0);

      if not Supports(NodeData.Element, IwbFile, _File) then
        Continue;

      if _File.LoadOrder = 0 then
        Continue;

      Group := _File.GroupBySignature['QUST'];

      if Assigned(Group) then begin
        for n := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[n], IwbMainRecord, MainRecord) then begin
            QustFlags := MainRecord.ElementByPath['DNAM - General\Flags'];
            // include SGE (start game enabled) quests which are new or set SGE flag on master quest
            if Assigned(QustFlags) and (QustFlags.NativeValue and 1 > 0) then
              if not Assigned(MainRecord.Master) or (MainRecord.Master.ElementNativeValues['DNAM\Flags'] and 1 = 0) then begin
                SetLength(FormIDs, Succ(Length(FormIDs)));
                FormIDs[High(FormIDs)] := MainRecord.FixedFormID;
              end;
          end;
      end;

      if Length(FormIDs) = 0 then
        PostAddMessage('Skipped: ' + _File.FileName + ' doesn''t need sequence file')
      else try
        try
          p := wbDataPath + 'Seq\';
          if not DirectoryExists(p) then
            if not ForceDirectories(p) then
              raise Exception.Create('Unable to create SEQ directory in game''s Data');
          s := p + ChangeFileExt(_File.FileName, '.seq');
          FileStream := TFileStream.Create(s, fmCreate);
          FileStream.WriteBuffer(FormIDs[0], Length(FormIDs)*SizeOf(Cardinal));
          PostAddMessage('Created: ' + s);
          Inc(j);
        finally
          if Assigned(FileStream) then
            FreeAndNil(FileStream);
        end;
      except
        on e: Exception do begin
          PostAddMessage('Error: Can''t create ' + s + ', ' + E.Message);
          Exit;
        end;
      end;

      Inc(Count);
    end;
  end;
  PostAddMessage('[Create SEQ file done] Processed Plugins: ' + IntToStr(Count) + ', Sequence Files Created: ' + IntToStr(j));
end;

procedure TfrmMain.mniNavCleanupInjectedClick(Sender: TObject);
var
  SelectedNodes               : TNodeArray;
  NodeData                    : PNavNodeData;
  Elements                    : array of IwbElement;
  ReferenceFile               : IwbFile;
  Container                   : IwbContainer;
  InjectionSourceFiles        : TDynFiles;
  sl                          : TStringList;
  i, j                        : Integer;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  SelectedNodes := vstNav.GetSortedSelection(True);
  if Length(SelectedNodes) < 1 then
    Exit;

  j := 0;
  SetLength(Elements, Length(SelectedNodes));
  for i := Low(SelectedNodes) to High(SelectedNodes) do begin
    NodeData := vstNav.GetNodeData(SelectedNodes[i]);
    if Assigned(NodeData.Element) and (NodeData.Element.ElementType = etMainRecord) then begin
      InjectionSourceFiles := NodeData.Element.InjectionSourceFiles;
      if Length(InjectionSourceFiles) = 1 then begin
        if not Assigned(ReferenceFile) then
          ReferenceFile := InjectionSourceFiles[0]
        else
          if not ReferenceFile.Equals(InjectionSourceFiles[0]) then
            Continue;
        Elements[j] := NodeData.Element;
        Inc(j);
      end;
    end;
  end;
  if j < 1 then
    Exit;
  SetLength(Elements, j);

  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    for i := Low(Elements) to High(Elements) do begin
      Elements[i].ReportRequiredMasters(sl, False);
      Container := Elements[i].Container;
      while Assigned(Container) do begin
        Container.ReportRequiredMasters(sl, False, False);
        Container := Container.Container;
      end;
    end;

    if AddRequiredMasters(sl, ReferenceFile) then
      for j := Low(Elements) to High(Elements) do begin
        wbCopyElementToFile(Elements[j], ReferenceFile, False, True, '', '','');
        if Elements[j].RemoveInjected(False) then begin
          pgMain.ActivePage := tbsMessages;
          AddMessage('Injected references in '+Elements[j].Name+' could not all be removed automatically.');
        end;
      end;
  finally
    sl.Free;
  end;

  for i := Low(SelectedNodes) to High(SelectedNodes) do
    vstNav.IterateSubtree(SelectedNodes[i], ClearConflict, nil);
  InvalidateElementsTreeView(SelectedNodes);
  PostResetActiveTree;
  vstNav.Invalidate;
end;

procedure TfrmMain.ClearConflict(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  NodeData                    : PNavNodeData;
begin
  NodeData := vstNav.GetNodeData(Node);
  if Assigned(NodeData) then begin
    with NodeData^ do begin
      ConflictAll := caUnknown;
      ConflictThis := ctUnknown;
      if Assigned(Element) then
        Element.ResetConflict;
    end;
    Sender.InvalidateNode(Node);
  end;
end;

function TfrmMain.ConflictLevelForChildNodeDatas(const aNodeDatas: TDynViewNodeDatas; aSiblingCompare, aInjected: Boolean): TConflictAll;
var
  ChildCount                  : Cardinal;
  i, j                        : Integer;
  NodeDatas                   : TDynViewNodeDatas;
  InitialStates               : TVirtualNodeInitStates;
  ConflictAll                 : TConflictAll;
  ConflictThis                : TConflictThis;
  Element                     : IwbElement;
begin
  case Length(aNodeDatas) of
    0: Result := caUnknown;
    1: begin
      Result := caOnlyOne;
      aNodeDatas[0].ConflictThis := ctOnlyOne;
    end;
  else
    Result := caNoConflict;
  end;

  if wbTranslationMode then begin
    if Result < caOnlyOne then
      Exit;
  end
  else begin
    if Result < caNoConflict then
      Exit;
  end;

  ChildCount := 0;
  InitChilds(@aNodeDatas[0], Length(aNodeDatas), ChildCount);
  if ChildCount > 0 then
    for i := 0 to Pred(ChildCount) do begin
      NodeDatas := nil;
      SetLength(NodeDatas, Length(aNodeDatas));
      InitialStates := [];
      InitNodes(@NodeDatas[0], @aNodeDatas[0], Length(aNodeDatas), i, InitialStates);
      if not (ivsDisabled in InitialStates) then begin

        if ivsHasChildren in InitialStates then
          ConflictAll := ConflictLevelForChildNodeDatas(NodeDatas, aSiblingCompare, aInjected)
        else
          ConflictAll := ConflictLevelForNodeDatas(@NodeDatas[0], Length(NodeDatas), aSiblingCompare, aInjected);

        if ConflictAll > Result then
          Result := ConflictAll;

        for j := Low(aNodeDatas) to High(aNodeDatas) do
          if NodeDatas[j].ConflictThis > aNodeDatas[j].ConflictThis then
            aNodeDatas[j].ConflictThis := NodeDatas[j].ConflictThis;

      end
      else begin

        ConflictThis := ctNotDefined;

        for j := Low(aNodeDatas) to High(aNodeDatas) do begin
          Element := aNodeDatas[j].Container;
          if Assigned(Element) then
            Break;
        end;

        if Assigned(Element) and (Element.ElementType in [etMainRecord, etSubRecordStruct]) then begin
          j := (Element as IwbContainer).AdditionalElementCount;
          if i >= j then
            with (Element.Def as IwbRecordDef).Members[i - j] do
              if (wbTranslationMode and (ConflictPriority <> cpTranslate)) or
                (wbTranslationMode and (ConflictPriority = cpIgnore)) then
                ConflictThis := ctIgnored;
        end;

        for j := Low(aNodeDatas) to High(aNodeDatas) do
          if ConflictThis > aNodeDatas[j].ConflictThis then
            aNodeDatas[j].ConflictThis := ConflictThis;
      end;
    end;
end;

function PluginListCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  IsESM1                      : Boolean;
  IsESM2                      : Boolean;
  FileAge1                    : Integer;
  FileAge2                    : Integer;
  FileDateTime1               : TDateTime;
  FileDateTime2               : TDateTime;
begin
  IsESM1 := IsFileESM(List[Index1]);
  IsESM2 := IsFileESM(List[Index2]);

  if IsESM1 = IsESM2 then begin

    FileAge1 := Integer(List.Objects[Index1]);
    FileAge2 := Integer(List.Objects[Index2]);

    if FileAge1 < FileAge2 then
      Result := -1
    else if FileAge1 > FileAge2 then
      Result := 1
    else begin
      if not SameText(List[Index1], List[Index1]) and FileAge(List[Index1], FileDateTime1) and FileAge(List[Index2], FileDateTime2) then begin
        if FileDateTime1 < FileDateTime2 then
          Result := -1
        else if FileDateTime1 > FileDateTime2 then
          Result := 1
        else
          Result := 0;
      end else
        Result := 0;
    end;

  end else if IsESM1 then
    Result := -1
  else
    Result := 1;
end;

destructor TfrmMain.Destroy;
begin
  inherited;
  FreeAndNil(NewMessages);
  FreeAndNil(ScriptHotkeys);
  FreeAndNil(ModGroups);
  FreeAndNil(Settings);
end;

procedure TfrmMain.DoGenerateLOD;
var
  i, j        : Integer;
  _File       : IwbFile;
  Group       : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Worldspaces : TDynMainRecords;
begin
  try
    frmMain.PostAddMessage('[' + FormatDateTime('hh:nn:ss', Now - wbStartTime) + '] LOD Generator: starting');

    Worldspaces := nil;
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      if Supports(_File.GroupBySignature['WRLD'], IwbContainerElementRef, Group) then begin
        for j := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then begin
            if Mainrecord.Signature = 'WRLD' then begin
              SetLength(Worldspaces, Succ(Length(Worldspaces)));
              Worldspaces[High(Worldspaces)] := MainRecord;
            end;
          end;
      end;
    end;

    if Length(WorldSpaces) > 1 then begin
      QuickSort(@WorldSpaces[0], Low(WorldSpaces), High(WorldSpaces), CompareElementsFormIDAndLoadOrder);

      j := 0;
      for i := Succ(Low(WorldSpaces)) to High(WorldSpaces) do begin
        if WorldSpaces[j].LoadOrderFormID <> WorldSpaces[i].LoadOrderFormID then
          Inc(j);
        if j <> i then
          WorldSpaces[j] := WorldSpaces[i];
      end;
      SetLength(WorldSpaces, Succ(j));
    end;

    if Length(Worldspaces) = 0 then
      Exit;

    try
      try
        for i := Low(WorldSpaces) to High(WorldSpaces) do begin
          GenerateLOD(WorldSpaces[i]);
          if ForceTerminate then
            Abort;
        end;
      except
        on E: Exception do begin
          frmMain.PostAddMessage('[' + FormatDateTime('hh:nn:ss', Now - wbStartTime) + '] LOD Generator: <Error: '+E.Message+'>');
          raise;
        end;
      end;
      frmMain.PostAddMessage('[' + FormatDateTime('hh:nn:ss', Now - wbStartTime) + '] LOD Generator: finished (you can close this application now)');
    finally
      Self.Caption := Application.Title;
    end;
  finally
    GeneratorDone := True;
  end;
end;

procedure TfrmMain.DoInit;

  // remove comments and empty lines from list
  procedure RemoveCommentsAndEmpty(sl: TStrings);
  var
    i, j: integer;
    s: string;
  begin
    for i := Pred(sl.Count) downto 0 do begin
      s := Trim(sl.Strings[i]);
      j := Pos('#', s);
      if j > 0 then
        System.Delete(s, j, High(Integer));
      if Trim(s) = '' then
        sl.Delete(i);
    end;
  end;

  // remove missing files from list
  procedure RemoveMissingFiles(sl: TStrings);
  var
    i: integer;
  begin
    for i := Pred(sl.Count) downto 0 do
      if not FileExists(wbDataPath + sl.Strings[i]) then
        sl.Delete(i);
  end;

  // add missing plugin files to list sorted by timestamps
  procedure AddMissingToLoadList(sl: TStrings);
  var
    F     : TSearchRec;
    slNew : TStringList;
    i, j  : integer;
  begin
    if FindFirst(wbDataPath + '*.*', faAnyFile, F) = 0 then try
      slNew := TStringList.Create;
      try
        repeat
          if IsFileESM(F.Name) or IsFileESP(F.Name) then begin
            if SameText(F.Name, wbGameName + '.hardcoded.esp') then
              DeleteFile(wbDataPath + F.Name)
            else
            if FindMatchText(sl, F.Name) < 0 then
              slNew.AddObject(F.Name, TObject(FileAge(wbDataPath + F.Name)));
          end;
        until FindNext(F) <> 0;
        slNew.CustomSort(PluginListCompare);
        // add esm masters after the last master, add esp plugins at the end
        // find position of the last master
        // The for loop won't initialize j if sl.count = 0, we must force it to -1 so inserting will happen at index 0
        if sl.Count=0 then
          j := -1
        else
          for j := Pred(sl.Count) downto 0 do
            if IsFileESM(sl[j]) then
              Break;
        Inc(j);
        for i := 0 to Pred(slNew.Count) do begin
          if IsFileESM(slNew[i]) then begin
            sl.InsertObject(j, slNew[i], slNew.Objects[i]);
            Inc(j);
          end else
            sl.AddObject(slNew[i], slNew.Objects[i]);
        end;
      finally
        slNew.Free;
      end;
    finally
      FindClose(F);
    end;
  end;

var
  i, j, k      : Integer;
  s            : string;
  sl, sl2      : TStringList;
  ConflictAll  : TConflictAll;
  ConflictThis : TConflictThis;
  Age          : Integer;
  AgeDateTime  : TDateTime;

begin
  SetDoubleBuffered(Self);
  SaveInterval := DefaultInterval;
  TfrmMain(splElements).OnMouseDown := splElementsMouseDown;

  wbGetFormIDCallback := GetFormIDCallback;

  tbsWEAPSpreadsheet.TabVisible := False;
  tbsARMOSpreadsheet.TabVisible := False;
  tbsAMMOSpreadsheet.TabVisible := False;

  pgMain.ActivePage := tbsMessages;
  Application.OnMessage := ApplicationMessage;
  lblPath.DoubleBuffered := True;

  wbDisplayLoadOrderFormID := True;
  wbSortSubRecords := True;
  wbDisplayShorterNames := True;
  wbHideUnused := True;
  wbFlagsAsArray := True;
  wbRequireLoadOrder := True;
  AutoSave := False;

  vstNav.NodeDataSize := SizeOf(TNavNodeData);
  vstView.DragImageKind := diDragColumnOnly;
  vstView.LineMode := lmSeparateTopNodes;
  vstView.TreeOptions.PaintOptions := vstView.TreeOptions.PaintOptions + [toAdvHotTrack];
  vstView.OnGetEditText := vstViewGetEditText;
  vstView.OnCheckHotTrack := vstViewCheckHotTrack;

  vstSpreadSheetWeapon.OnGetEditText := vstSpreadSheetGetEditText;
  vstSpreadSheetWeapon.OnCheckHotTrack := vstSpreadSheetCheckHotTrack;
  vstSpreadSheetWeapon.TreeOptions.PaintOptions := vstSpreadSheetWeapon.TreeOptions.PaintOptions + [toZebra, toAdvHotTrack];

  vstSpreadSheetArmor.OnGetEditText := vstSpreadSheetGetEditText;
  vstSpreadSheetArmor.OnCheckHotTrack := vstSpreadSheetCheckHotTrack;
  vstSpreadSheetArmor.TreeOptions.PaintOptions := vstSpreadSheetArmor.TreeOptions.PaintOptions + [toZebra, toAdvHotTrack];

  vstSpreadSheetAmmo.OnGetEditText := vstSpreadSheetGetEditText;
  vstSpreadSheetAmmo.OnCheckHotTrack := vstSpreadSheetCheckHotTrack;
  vstSpreadSheetAmmo.TreeOptions.PaintOptions := vstSpreadSheetAmmo.TreeOptions.PaintOptions + [toZebra, toAdvHotTrack];

  ModGroups := TStringList.Create;


  AddMessage(wbApplicationTitle + ' starting session ' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));

  AddMessage('Using '+wbGameName+' Data Path: ' + wbDataPath);


  AddMessage('Using ini: ' + wbTheGameIniFileName);
  if not FileExists(wbTheGameIniFileName) then begin
    AddMessage('Fatal: Could not find ini');
    Exit;
  end;

  AddMessage('Using plugin list: ' + wbPluginsFileName);
  if not FileExists(wbPluginsFileName) then begin
    AddMessage('Fatal: Could not find plugin list');
    Exit;
  end;

  AddMessage('Using settings file: ' + wbSettingsFileName);

  Settings := TMemIniFile.Create(wbSettingsFileName);

  LoadFont(Settings, 'UI', 'FontRecords', vstNav.Font);
  LoadFont(Settings, 'UI', 'FontRecords', vstView.Font);
  LoadFont(Settings, 'UI', 'FontMessages', mmoMessages.Font);

  // skip reading main form position if Shift is pressed
  if GetKeyState(VK_SHIFT) >= 0 then begin
    Left := Settings.ReadInteger(Name, 'Left', Left);
    Top := Settings.ReadInteger(Name, 'Top', Top);
    Width := Settings.ReadInteger(Name, 'Width', Width);
    Height := Settings.ReadInteger(Name, 'Height', Height);
    WindowState := TWindowState(Settings.ReadInteger(Name, 'WindowState', Integer(WindowState)));
  end;

  AddMessage('Loading active plugin list: ' + wbPluginsFileName);

  try
    sl := TStringList.Create;
    try

      with TfrmFileSelect.Create(nil) do try

        {
           *** Load order handling for Skyrim and later games ***
           Plugins are sorted by the order in plugins.txt
           1. Load plugins list from plugins file
           2. Add missing files from BOSS list loadorder.txt
        }
        if not (wbGameMode in [gmTES4, gmFO3, gmFNV]) then begin
          sl.LoadFromFile(wbPluginsFileName);
          RemoveCommentsAndEmpty(sl); // remove comments
          RemoveMissingFiles(sl); // remove nonexisting files
          // Skyrim always loads Skyrim.esm and Update.esm first and second no matter what
          // even if not present in plugins.txt
          j := FindMatchText(sl, wbGameName+'.esm');
          if j = -1 then sl.Insert(0, wbGameName+'.esm');
          j := FindMatchText(sl, 'Update.esm');
          if j = -1 then sl.Insert(1, 'Update.esm');

          s := ExtractFilePath(wbPluginsFileName) + 'loadorder.txt';
          if FileExists(s) then begin
            AddMessage('Found BOSS load order list: ' + s);
            sl2 := TStringList.Create;
            try
              sl2.LoadFromFile(s);
              RemoveMissingFiles(sl2); // remove nonexisting files from BOSS list
              // skip first line "Skyrim.esm" in BOSS list
              for i := 1 to Pred(sl2.Count) do begin
                j := FindMatchText(sl, sl2[i]);
                // if plugin exists in plugins file, skip
                if j <> -1 then Continue;
                // otherwise insert it after position of previous plugin
                j := FindMatchText(sl, sl2[i-1]);
                if j <> -1 then
                  sl.Insert(j+1, sl2[i]);
              end;
            finally
              sl2.Free;
            end;
          end;
        end;

        {
           *** Load order handling for Oblivion, Fallout3 and New Vegas ***
           Plugins are sorted by timestamps.
           Add files missing in plugins.txt and loadorder.txt for Skyrim and later games.
        }
        AddMissingToLoadList(sl);

        if (wbToolMode in [tmMasterUpdate, tmMasterRestore]) and (sl.Count > 1) and (wbGameMode in [gmFO3, gmFNV]) then begin
          Age := Integer(sl.Objects[0]);
          AgeDateTime := FileDateToDateTime(Age);
          for i := 1 to Pred(sl.Count) do begin
            AgeDateTime := AgeDateTime + (1/24/60);
            Age := DateTimeToFileDate(AgeDateTime);
            FileSetDate(wbDataPath + sl[i], Age);
          end;
        end;

        CheckListBox1.Items.Assign(sl);

        // check active files using the game's plugins list
        sl.LoadFromFile(wbPluginsFileName);
        for i := Pred(sl.Count) downto 0 do begin
          s := Trim(sl.Strings[i]);
          j := Pos('#', s);
          if j > 0 then
            System.Delete(s, j, High(Integer));
          s := Trim(s);
          if s = '' then begin
            sl.Delete(i);
            Continue;
          end;

          j := CheckListBox1.Items.IndexOf(s);
          if j < 0 then
            AddMessage('Note: Active plugin List contains nonexisting file "' + s + '"')
          else
            CheckListBox1.Checked[j] := True;
        end;

        if not (wbToolMode in [tmMasterUpdate, tmMasterRestore, tmLODgen]) then begin
          ShowModal;
          if ModalResult <> mrOk then begin
            frmMain.Close;
            Exit;
          end;
        end;

        sl2 := TStringList.Create;
        try
          sl2.Sorted := True;
          sl2.Duplicates := dupIgnore;

          sl.Clear;
          for i := 0 to Pred(CheckListBox1.Count) do
            if CheckListBox1.Checked[i] then
              sl.Add(CheckListBox1.Items[i]);

          while sl.Count > 0 do begin
            sl2.Clear;
            for i := 0 to Pred(sl.Count) do
              wbMastersForFile(wbDataPath + sl[i], sl2);

            sl.Clear;
            if sl2.Count > 0 then
              for i := 0 to Pred(CheckListBox1.Count) do
                if not CheckListBox1.Checked[i] then
                  if sl2.Find(CheckListBox1.Items[i], j) then begin
                    CheckListBox1.Checked[i] := True;
                    sl.Add(CheckListBox1.Items[i]);
                    sl2.Delete(j);
                    if sl2.Count < 1 then
                      Break;
                  end;
          end;

        finally
          FreeAndNil(sl2);
        end;


        sl.Clear;
        for i := 0 to Pred(CheckListBox1.Count) do
          if CheckListBox1.Checked[i] then
            sl.Add(CheckListBox1.Items[i]);

      finally
        Free;
      end;

      if not (wbToolMode in [tmMasterUpdate, tmMasterRestore, tmLODgen]) then
        with TfrmFileSelect.Create(nil) do try

          if (not wbEditAllowed) or wbTranslationMode then begin
            Caption := 'Skip these records:';

            sl2 := TStringList.Create;
            try
              sl2.Sorted := True;
              sl2.Duplicates := dupIgnore;
              sl2.CommaText := Settings.ReadString('RecordsToSkip', 'Selection', 'LAND,ROAD,PGRD,REGN,NAVI,NAVM,IMAD');

              for i := 0 to Pred(wbRecordDefMap.Count) do
                with IwbRecordDef(Pointer(wbRecordDefMap.Objects[i])) do begin
                  j := CheckListBox1.Items.Add(DefaultSignature + ' - ' + GetName);
                  if sl2.IndexOf(DefaultSignature) >= 0 then
                    CheckListBox1.Checked[j] := True;
                end;

              ShowModal;

              sl2.Clear;
              for i := 0 to Pred(CheckListBox1.Count) do
                if CheckListBox1.Checked[i] then begin
                  RecordToSkip.Add(Copy(CheckListBox1.Items[i], 1, 4));
                  sl2.Add(Copy(CheckListBox1.Items[i], 1, 4));
                end;
              Settings.WriteString('RecordsToSkip', 'Selection', sl2.CommaText);
              Settings.UpdateFile;
            finally
              FreeAndNil(sl2);
            end;
          end;

          s := wbModGroupFileName;
          if FileExists(s) then
            with TMemIniFile.Create(s) do try
              ReadSections(ModGroups);
              for i := Pred(ModGroups.Count) downto 0 do begin
                sl2 := TStringList.Create;
                try
                  ReadSectionValues(ModGroups[i], sl2);

                  for j := Pred(sl2.Count) downto 0 do begin
                    s := sl2[j];
                    k := sl.IndexOf(s);
                    if k >= 0 then
                      sl2.Objects[j] := TObject(k)
                    else
                      sl2.Delete(j);
                  end;

                  if sl2.Count < 2 then begin
                    AddMessage('Ignoring ModGroup ' + ModGroups[i] + ': less then 2 plugins active');
                    ModGroups.Delete(i);
                  end
                  else begin
                    k := Integer(sl2.Objects[0]);
                    for j := 1 to Pred(sl2.Count) do begin
                      if Integer(sl2.Objects[j]) <= k then begin
                        sl2.Clear;
                        AddMessage('Ignoring ModGroup ' + ModGroups[i] + ': plugins are not in the correct order');
                        ModGroups.Delete(i);
                        Break;
                      end;
                    end;
                    if sl2.Count >= 2 then begin
                      ModGroups.Objects[i] := sl2;
                      sl2 := nil;
                    end;
                  end;

                finally
                  FreeAndNil(sl2);
                end;
              end;
            finally
              Free;
            end;
        finally
          Free;
        end;

      if ModGroups.Count > 0 then begin
        with TfrmFileSelect.Create(nil) do try
          Caption := 'Select ModGroups';

          sl2 := TStringList.Create;
          try
            sl2.Sorted := True;
            sl2.Duplicates := dupIgnore;
            sl2.CommaText := Settings.ReadString('ModGroups', 'Selection', '');

            CheckListBox1.Items.Assign(ModGroups);
            for i := Pred(ModGroups.Count) downto 0 do
              if sl2.IndexOf(ModGroups[i]) >= 0 then
                CheckListBox1.Checked[i] := True;

            ShowModal;

            sl2.Clear;
            for i := Pred(ModGroups.Count) downto 0 do
              if not CheckListBox1.Checked[i] then
                ModGroups.Delete(i)
              else
                sl2.Add(ModGroups[i]);

            Settings.WriteString('ModGroups', 'Selection', sl2.CommaText);
            Settings.UpdateFile;
          finally
            FreeAndNil(sl2);
          end;

        finally
          Free;
        end;
      end;

      // hold shift to skip bulding references
      if GetKeyState(VK_SHIFT) < 0 then begin
        wbBuildRefs := False;
        AddMessage('The SHIFT key is pressed, skip building references for all plugins!');
      end;

      wbStartTime := Now;
      TLoaderThread.Create(sl);
    finally
      FreeAndNil(sl);
    end;
  except
    on E: Exception do begin
      AddMessage('Fatal: Error loading plugin list: <' + E.ClassName + ': ' + E.Message + '>');
      Exit;
    end;
  end;

  TotalUsageTime := Settings.ReadFloat('Usage', 'TotalTime', 0);
  RateNoticeGiven := Settings.ReadInteger('Usage', 'RateNoticeGiven', 0);

  FilterConflictAll := Settings.ReadBool('Filter', 'ConflictAll', True);
  FilterConflictThis := Settings.ReadBool('Filter', 'ConflictThis', True);

  FilterByInjectStatus := Settings.ReadBool('Filter', 'byInjectStatus', False);
  FilterInjectStatus := Settings.ReadBool('Filter', 'InjectStatus', True);

  FilterByNotReachableStatus := Settings.ReadBool('Filter', 'byNotReachableStatus', False);
  FilterNotReachableStatus := Settings.ReadBool('Filter', 'NotReachableStatus', True);

  FilterByReferencesInjectedStatus := Settings.ReadBool('Filter', 'byReferencesInjectedStatus', False);
  FilterReferencesInjectedStatus := Settings.ReadBool('Filter', 'ReferencesInjectedStatus', True);

  FilterByEditorID := Settings.ReadBool('Filter', 'ByEditorID', False);
  FilterEditorID := Settings.ReadString('Filter', 'EditorID', '');

  FilterByName := Settings.ReadBool('Filter', 'ByName', False);
  FilterName := Settings.ReadString('Filter', 'Name', '');

  FilterByBaseEditorID := Settings.ReadBool('Filter', 'ByBaseEditorID', False);
  FilterBaseEditorID := Settings.ReadString('Filter', 'BaseEditorID', '');

  FilterByBaseName := Settings.ReadBool('Filter', 'ByBaseName', False);
  FilterBaseName := Settings.ReadString('Filter', 'BaseName', '');

  FilterScaledActors := Settings.ReadBool('Filter', 'ScaledActors', False);

  FilterBySignature := Settings.ReadBool('Filter', 'BySignature', False);
  FilterSignatures := Settings.ReadString('Filter', 'Signatures', '');

  FilterByBaseSignature := Settings.ReadBool('Filter', 'ByBaseSignature', False);
  FilterBaseSignatures := Settings.ReadString('Filter', 'BaseSignatures', '');

  FilterByPersistent := Settings.ReadBool('Filter', 'ByPersistent', False);
  FilterPersistent := Settings.ReadBool('Filter', 'Persistent', True);
  FilterUnnecessaryPersistent := Settings.ReadBool('Filter', 'UnnecessaryPersistent', False);
  FilterMasterIsTemporary := Settings.ReadBool('Filter', 'MasterIsTemporary', False);
  FilterIsMaster := Settings.ReadBool('Filter', 'IsMaster', False);
  FilterPersistentPosChanged := Settings.ReadBool('Filter', 'PersistentPosChanged', False);

  FilterDeleted := Settings.ReadBool('Filter', 'Deleted', False);

  FilterByVWD := Settings.ReadBool('Filter', 'ByVWD', False);
  FilterVWD := Settings.ReadBool('Filter', 'VWD', True);

  FilterByHasVWDMesh := Settings.ReadBool('Filter', 'ByHasVWDMesh', False);
  FilterHasVWDMesh := Settings.ReadBool('Filter', 'HasVWDMesh', True);

  FilterConflictAllSet := [];
  for ConflictAll := Low(ConflictAll) to High(ConflictAll) do
    if Settings.ReadBool('Filter', GetEnumName(TypeInfo(TConflictAll), Ord(ConflictAll)), True) then
      Include(FilterConflictAllSet, ConflictAll);

  FilterConflictThisSet := [];
  for ConflictThis := Low(ConflictThis) to High(ConflictThis) do
    if Settings.ReadBool('Filter', GetEnumName(TypeInfo(TConflictThis), Ord(ConflictThis)), True) then
      Include(FilterConflictThisSet, ConflictThis);

  FlattenBlocks := Settings.ReadBool('Filter', 'FlattenBlocks', False);
  FlattenCellChilds := Settings.ReadBool('Filter', 'FlattenCellChilds', False);
  AssignPersWrldChild := Settings.ReadBool('Filter', 'AssignPersWrldChild', False);
  InheritConflictByParent := Settings.ReadBool('Filter', 'InheritConflictByParent', True);

  AutoSave := Settings.ReadBool('Options', 'AutoSave', AutoSave);

  wbHideUnused := Settings.ReadBool('Options', 'HideUnused', wbHideUnused);
  wbHideIgnored := Settings.ReadBool('Options', 'HideIgnored', wbHideIgnored);
  wbHideNeverShow := Settings.ReadBool('Options', 'HideNeverShow', wbHideNeverShow);
  wbActorTemplateHide := Settings.ReadBool('Options', 'ActorTemplateHide', wbActorTemplateHide);
  wbColumnWidth := Settings.ReadInteger('Options', 'ColumnWidth', wbColumnWidth);
  wbSortFLST := Settings.ReadBool('Options', 'SortFLST', wbSortFLST);
  wbSortGroupRecord := Settings.ReadBool('Options', 'SortGroupRecord', wbSortGroupRecord);
  wbRemoveOffsetData := Settings.ReadBool('Options', 'RemoveOffsetData', wbRemoveOffsetData);
  //wbIKnowWhatImDoing := Settings.ReadBool('Options', 'IKnowWhatImDoing', wbIKnowWhatImDoing);
  wbUDRSetXESP := Settings.ReadBool('Options', 'UDRSetXESP', wbUDRSetXESP);
  wbUDRSetScale := Settings.ReadBool('Options', 'UDRSetScale', wbUDRSetScale);
  wbUDRSetScaleValue := Settings.ReadFloat('Options', 'UDRSetScaleValue', wbUDRSetScaleValue);
  wbUDRSetZ := Settings.ReadBool('Options', 'UDRSetZ', wbUDRSetZ);
  wbUDRSetZValue := Settings.ReadFloat('Options', 'UDRSetZValue', wbUDRSetZValue);
  wbUDRSetMSTT := Settings.ReadBool('Options', 'UDRSetMSTT', wbUDRSetMSTT);
  wbUDRSetMSTTValue := Settings.ReadInteger('Options', 'UDRSetMSTTValue', wbUDRSetMSTTValue);
  for ConflictThis := Low(TConflictThis) to High(TConflictThis) do
    wbColorConflictThis[ConflictThis] := Settings.ReadInteger('ColorConflictThis', GetEnumName(TypeInfo(TConflictThis), Integer(ConflictThis)), Integer(wbColorConflictThis[ConflictThis]));
  for ConflictAll := Low(TConflictAll) to High(TConflictAll) do
    wbColorConflictAll[ConflictAll] := Settings.ReadInteger('ColorConflictAll', GetEnumName(TypeInfo(TConflictAll), Integer(ConflictAll)), Integer(wbColorConflictAll[ConflictAll]));
  Settings.ReadSection('DoNotBuildRefsFor', wbDoNotBuildRefsFor);
  if (wbDoNotBuildRefsFor.Count = 0) and (wbGameMode = gmFNV) then
    wbDoNotBuildRefsFor.Add('Fallout3.esm');

  HideNoConflict := Settings.ReadBool('View', 'HodeNoConflict', False);
  mniViewHideNoConflict.Checked := HideNoConflict;

  case Settings.ReadInteger('View', 'ColumnWidth', 0) of
    1: mniViewColumnWidthFitAll.Checked := True;
    2: mniViewColumnWidthFitText.Checked := True;
  else
    mniViewColumnWidthStandard.Checked := True;
  end;

  case Settings.ReadInteger('Nav', 'FilesSort', 0) of
    1: mniNavHeaderFilesLoadOrder.Checked := True;
    2: mniNavHeaderFilesFileName.Checked := True;
  else
    mniNavHeaderFilesDefault.Checked := True;
  end;

  CreateActionsForScripts;
end;

procedure TfrmMain.edEditorIDSearchChange(Sender: TObject);
begin
  edEditorIDSearch.Color := clWindow;
end;

procedure TfrmMain.edEditorIDSearchEnter(Sender: TObject);
begin
  edEditorIDSearch.SelectAll;
end;

procedure TfrmMain.edEditorIDSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  EditorID                    : string;
  Node                        : PVirtualNode;
  NodeData                    : PNavNodeData;
begin
  if (Key = VK_RETURN) and (Shift = []) then begin
    Key := 0;
    EditorID := Trim(edEditorIDSearch.Text);
    if EditorID = '' then begin
      edEditorIDSearch.Color := Lighter(clRed, 0.85);
      edEditorIDSearch.SelectAll;
      Exit;
    end;

    Node := vstNav.FocusedNode;
    if Assigned(Node) then
      if not StartsWith(vstNav.Text[Node, 1, False], EditorID) then
        Node := nil;

    if Assigned(Node) then
      Node := vstNav.GetNext(Node)
    else
      Node := vstNav.GetFirst;

    while Assigned(Node) do begin
      // don't search in hidden elements
      NodeData := vstNav.GetNodeData(Node);
      if Assigned(NodeData) and Assigned(NodeData.Element) and not NodeData.Element.IsHidden then
        if StartsWith(vstNav.Text[Node, 1, False], EditorID) then begin
          if not vstNav.FullyVisible[Node] then begin
            vstNav.FullyVisible[Node] := True;
            Node := vstNav.NodeParent[Node];
          end
          else begin
            edEditorIDSearch.Color := Lighter(clLime, 0.85);
            vstNav.ClearSelection;
            vstNav.FocusedNode := Node;
            vstNav.Selected[vstNav.FocusedNode] := True;
            edEditorIDSearch.SelectAll;
            Exit;
          end;
        end;
      Node := vstNav.GetNext(Node)
    end;

    if edEditorIDSearch.Color = Lighter(clLime, 0.85) then
      edEditorIDSearch.Color := Lighter(clYellow, 0.85)
    else
      edEditorIDSearch.Color := Lighter(clRed, 0.85);
    edEditorIDSearch.SelectAll;
    Exit;
  end;
end;

procedure TfrmMain.edFormIDSearchChange(Sender: TObject);
begin
  edFormIDSearch.Color := clWindow;
end;

procedure TfrmMain.edFormIDSearchEnter(Sender: TObject);
begin
  edFormIDSearch.SelectAll;
end;

procedure TfrmMain.edFormIDSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  s                           : string;
  FormID                      : Cardinal;
  FileID                      : Integer;
  _File                       : IwbFile;
  MainRecord                  : IwbMainRecord;
  Node                        : PVirtualNode;
  i, j                        : Integer;

begin
  if (Key = VK_RETURN) and (Shift = []) then begin
    Key := 0;

    s := Trim(edFormIDSearch.Text);
    FormID := StrToInt64Def('$' + edFormIDSearch.Text, 0);
    FileID := FormID shr 24;
    if FormID <> 0 then begin
      _File := nil;
      j := Low(Files);
      while (j <= High(Files)) and not Assigned(_File) do begin
        if Files[j].LoadOrder = FileID then
          _File := Files[j];
        Inc(j);
      end;
      while Assigned(_File) do begin
        FormID := (FormID and $00FFFFFF) or (Cardinal(_File.MasterCount) shl 24);
        MainRecord := _File.RecordByFormID[FormID, True];
        if Assigned(MainRecord) then begin
          Node := FindNodeForElement(MainRecord);
          if not Assigned(Node) then
            for i := 0 to Pred(MainRecord.OverrideCount) do begin
              // don't search in hidden elements
              if MainRecord.Overrides[i].IsHidden then
                Continue;
              Node := FindNodeForElement(MainRecord.Overrides[i]);
              if Assigned(Node) then
                Break;
            end;
          if Assigned(Node) then begin
            edFormIDSearch.Color := Lighter(clLime, 0.85);
            JumpTo(MainRecord, False);
  //          vstNav.ClearSelection;
  //          vstNav.FocusedNode := FindNodeForElement(MainRecord);
  //          vstNav.Selected[vstNav.FocusedNode] := True;
  //          SetActiveRecord(MainRecord);
          end
          else begin
            edFormIDSearch.Color := Lighter(clYellow, 0.85);
            JumpTo(MainRecord, False);
  //          SetActiveRecord(MainRecord);
          end;
          edFormIDSearch.SelectAll;
          Exit;
        end;
        _File := nil;
        while (j <= High(Files)) and not Assigned(_File) do begin
          if Files[j].LoadOrder = FileID then
            _File := Files[j];
          Inc(j);
        end;
      end;
    end;
    edFormIDSearch.Color := Lighter(clRed, 0.85);
    edFormIDSearch.SelectAll;
  end;
end;

function TfrmMain.EditableSelection(ContainsChilds: PBoolean): TNodeArray;
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  i, j                        : Integer;
begin
  SetLength(Result, 0);
  if Assigned(ContainsChilds) then
    ContainsChilds^ := False;

  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  Result := vstNav.GetSortedSelection(True);
  j := Low(Result);
  for i := Low(Result) to High(Result) do begin
    NodeData := vstNav.GetNodeData(Result[i]);
    if not Assigned(NodeData) then
      Continue;
    Element := NodeData.Element;
    if not Assigned(Element) then
      Continue;
    if not Element.IsEditable then
      Continue;

    if Assigned(ContainsChilds) then
      ContainsChilds^ := ContainsChilds^ or
        (Assigned(NodeData.Container) and (NodeData.Container.ElementCount > 0));

    if i <> j then
      Result[j] := Result[i];
    Inc(j);
  end;
  SetLength(Result, j);
end;

function TfrmMain.EditWarn: Boolean;
var
  EditWarnCount: Integer;
begin
  Result := EditWarnOk or (DebugHook <> 0) or wbIKnowWhatImDoing;
  if not Result then
    with TfrmEditWarning.Create(Self) do try
      EditWarnCount := Settings.ReadInteger('Usage', 'EditWarnCount', 0);

      TimerCount := TimerCount - (EditWarnCount div 10);

      Result := ShowModal = mrOk;
      if Result then begin
        EditWarnOk := True;
        Inc(EditWarnCount);
        Settings.WriteInteger('Usage', 'EditWarnCount', EditWarnCount);
      end;

    finally
      Free;
    end;
end;

function NormalizeRotation(const aRot: TwbVector): TwbVector;

  function NormalizeAxis(const aValue: Single): Single;
  begin
    Result := aValue;
    while Result < (-Pi) do
      Result := Result + (2*Pi);
    while Result > Pi do
      Result := Result - (2*Pi);
  end;

begin
  Result.x := NormalizeAxis(aRot.x);
  Result.y := NormalizeAxis(aRot.y);
  Result.z := NormalizeAxis(aRot.z);
end;

function MainRecordToRefInfo(const aMainRecord: IwbMainRecord; out aRefInfo: TRefInfo): Boolean;
var
  MainRecord : IwbMainRecord;
  NameRec    : IwbContainerElementRef;
  DataRec    : IwbContainerElementRef;
begin
  Result := False;
  if Supports(aMainRecord.RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
     Supports(NameRec.LinksTo, IwbMainRecord, MainRecord) and
     Supports(aMainRecord.RecordBySignature['DATA'], IwbContainerElementRef, DataRec) and
     (DataRec.ElementCount = 2) then begin
    try
      with aRefInfo do begin
        FormID := MainRecord.LoadOrderFormID;

        with Pos, (DataRec.Elements[0] as IwbContainerElementRef) do begin
          if ElementCount >= 1 then
            X := StrToFloatDef(Elements[0].Value, 0);
          if ElementCount >= 2 then
            Y := StrToFloatDef(Elements[1].Value, 0);
          if ElementCount >= 3 then
            Z := StrToFloatDef(Elements[2].Value, 0);
        end;
        with Rot, (DataRec.Elements[1] as IwbContainerElementRef) do begin
          if ElementCount >= 1 then
            X := StrToFloatDef(Elements[0].Value, 0);
          if ElementCount >= 2 then
            Y := StrToFloatDef(Elements[1].Value, 0);
          if ElementCount >= 3 then
            Z := StrToFloatDef(Elements[2].Value, 0);
        end;
        Rot := NormalizeRotation(Rot);
        if Supports(aMainRecord.RecordBySignature['XSCL'], IwbContainerElementRef, DataRec) then
          Scale := StrToFloatDef(DataRec.Value, 1)
        else
          Scale := 1;
      end;
      Result := True;
    except
      on E: Exception do
//        AddMessage('Error while processing ' + aMainRecord.Name+': '+E.Message);
    end;
  end;
end;

function RotDistance(a, b: TCoords): Single;
begin
  a := NormalizeRotation(a);
  b := NormalizeRotation(b);
  if a.x < 0 then
    a.x := a.x + (2*Pi);
  if a.y < 0 then
    a.y := a.y + (2*Pi);
  if a.z < 0 then
    a.z := a.z + (2*Pi);
  if b.x < 0 then
    b.x := b.x + (2*Pi);
  if b.y < 0 then
    b.y := b.y + (2*Pi);
  if b.z < 0 then
    b.z := b.z + (2*Pi);
  Result := wbDistance(a, b);
end;

function StrRight(const s: String; Len: Integer): string;
begin
  Result := s;
  while Length(Result)<Len do
    Result := ' ' + Result;
end;

function SnapRot(s: Single): Single;
begin
  if (s > -2) and (s < 2) then
    Result := 0
  else if (s > 88) and (s < 92) then
    Result := 90
  else if (s > 178) or (s < -178) then
    Result := 180
  else if (s > -92) and (s < -88) then
    Result := -90
  else
    Result := s;
end;

//var
//  sl: TStringList;

type
  TNifInfo = class(TObject)
    MainRecords : TDynMainRecords;
    HasLights: Boolean;
    HasOthers: Boolean;
  public
    constructor Create(const aMainRecord: IwbMainRecord);
    procedure Add(const aMainRecord: IwbMainRecord);
  end;

constructor TNifInfo.Create(const aMainRecord: IwbMainRecord);
begin
  Add(aMainRecord);
end;

procedure TNifInfo.Add(const aMainRecord: IwbMainRecord);
begin
  SetLength(MainRecords, Succ(Length(MainRecords)));
  MainRecords[High(MainRecords)] := aMainRecord;
  HasLights := HasLights or (aMainRecord.Signature = 'LIGH');
  HasOthers := HasOthers or (aMainRecord.Signature <> 'LIGH');
end;

procedure TfrmMain.mniNavUndeleteAndDisableReferencesClick(Sender: TObject);
const
  sJustWait                   = 'Undeleting and Disabling References. Please wait...';
var
  Selection                   : TNodeArray;
  StartNode, Node, NextNode   : PVirtualNode;
  NodeData                    : PNavNodeData;
  Count                       : Cardinal;
  UndeletedCount              : Cardinal;
  DeletedNAVM                 : Cardinal;
  StartTick                   : Cardinal;
  i {, n}                     : Integer;
  MainRecord, LinksToRecord   : IwbMainRecord;
  Element                     : IwbElement;
  Position                    : TwbVector;
  Cntr {, Cntr2}              : IwbContainerElementRef;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := vstNav.GetSortedSelection(True);

  if Length(Selection) < 1 then
    Exit;

  if not FilterApplied or
    FilterConflictAll or
    FilterConflictThis or
    FilterByInjectStatus or
    FilterByPersistent or
    FilterByVWD or
    (FilterByNotReachableStatus and ReachableBuild) or
    FilterByReferencesInjectedStatus or
    FilterByEditorID or
    FilterByName or
    FilterBySignature or
    FilterByBaseEditorID or
    FilterByBaseName or
    FilterScaledActors or
    FilterByBaseSignature or
    FlattenBlocks or
    FlattenCellChilds or
    AssignPersWrldChild or
    not InheritConflictByParent then begin

    MessageDlg('To use this function you need to apply a filter with *only* the option "Conflict status inherited by parent" active.', mtError, [mbOk], 0);
    Exit;
  end;

  if not EditWarn then
    Exit;

  vstNav.BeginUpdate;
  try
    StartTick := GetTickCount;
    wbStartTime := Now;

    Enabled := False;

    UndeletedCount := 0;
    DeletedNAVM := 0;
    Count := 0;
    for i := Low(Selection) to High(Selection) do try
      StartNode := Selection[i];
      if Assigned(StartNode) then
        Node := vstNav.GetLast(StartNode)
      else
        Node := nil;
      while Assigned(Node) do begin
        NextNode := vstNav.GetPrevious(Node);
        NodeData := vstNav.GetNodeData(Node);

        if Supports(NodeData.Element, IwbMainRecord, MainRecord) then with MainRecord do begin
          if IsEditable and
             (IsDeleted or (GetPosition(Position) and (Position.z = -30000.0)) and (MainRecord.ElementNativeValues['XESP\Reference'] <> $14) ) and
             (
               (Signature = 'REFR') or
               (Signature = 'PGRE') or
               (Signature = 'PMIS') or
               (Signature = 'ACHR') or
               (Signature = 'ACRE') or
               (Signature = 'NAVM') or
               (Signature = 'PARW') or {>>> Skyrim <<<}
               (Signature = 'PBAR') or {>>> Skyrim <<<}
               (Signature = 'PBEA') or {>>> Skyrim <<<}
               (Signature = 'PCON') or {>>> Skyrim <<<}
               (Signature = 'PFLA') or {>>> Skyrim <<<}
               (Signature = 'PHZD')    {>>> Skyrim <<<}
             ) then
          //begin
          if Signature = 'NAVM' then Inc(DeletedNAVM) else begin
            IsDeleted := True;
            IsDeleted := False;
            PostAddMessage('Undeleting: ' + MainRecord.Name);
            if (wbGameMode in [gmFO3, gmFNV, gmTES5]) and ((Signature = 'ACHR') or (Signature = 'ACRE')) then
              IsPersistent := True
            else if wbGameMode = gmTES4 then
              IsPersistent := False;
            if not IsPersistent then
              if wbUDRSetZ and GetPosition(Position) then begin
                Position.z := wbUDRSetZValue;
                SetPosition(Position);
              end;
            RemoveElement('Enable Parent');
            RemoveElement('XTEL');
            IsInitiallyDisabled := True;
            if wbUDRSetXESP and Supports(Add('XESP', True), IwbContainerElementRef, Cntr) then begin
              Cntr.ElementNativeValues['Reference'] := $14;
              Cntr.ElementNativeValues['Flags'] := 1;
            end;

            if wbUDRSetScale then begin
              if not Assigned(ElementBySignature['XSCL']) then
                Element := Add('XSCL', True);
                if Assigned(Element) then
                  Element.NativeValue := wbUDRSetScaleValue;
            end;

            if wbUDRSetMSTT and (wbGameMode in [gmFO3, gmFNV]) then begin
              Element := ElementBySignature['NAME'];
              if Assigned(Element) then
                if Supports(Element.LinksTo, IwbMainRecord, LinksToRecord) then
                  if LinksToRecord.Signature = 'MSTT' then
                    Element.NativeValue := wbUDRSetMSTTValue;
            end;

            // Undeleting NAVM, needs to update NAVI as well
//            if (Signature = 'NAVM') then
//              if wbGameMode in [gmTES5] then begin
//                if Supports(MainRecord.ElementByPath['NVNM - Geometry\Vertices'], IwbContainerElementRef, Cntr) then begin
//                  for n := 0 to Pred(Cntr.ElementCount) do
//                    if Supports(Cntr.Elements[n], IwbContainerElementRef, Cntr2) then
//                      Cntr2.ElementByName['Z'].NativeValue := -30000;
//                end;
//              end else
//                Inc(DeletedNAVM);

            Inc(UndeletedCount);
          end;
        end;

        Node := NextNode;
        Inc(Count);
        if StartTick + 500 < GetTickCount then begin
          Caption := sJustWait + ' Processed Records: ' + IntToStr(Count) +
            ' Removed Records: ' + IntToStr(UndeletedCount) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
        if Node = StartNode then
          Node := nil;
      end;

    finally
      Enabled := True;
    end;

    PostAddMessage('[Undeleting and Disabling References done] ' + ' Processed Records: ' + IntToStr(Count) +
      ', Undeleted Records: ' + IntToStr(UndeletedCount) +
      ', Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime));
    if DeletedNAVM > 0 then
      PostAddMessage('<Warning: Plugin contains ' + IntToStr(DeletedNAVM) + ' deleted NavMeshes which can not be undeleted>');
  finally
    vstNav.EndUpdate;
    Caption := Application.Title;
  end;
end;

function TfrmMain.FindNodeForElement(const aElement: IwbElement): PVirtualNode;
var
  Container                   : IwbContainer;
  Node                        : PVirtualNode;
  NodeData                    : PNavNodeData;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Container := aElement.Container;
  if Assigned(Container) then
    Result := FindNodeForElement(Container)
  else
    Result := vstNav.RootNode;

  if not Assigned(Result) then
    Exit;

  Node := vstNav.GetFirstChild(Result);
  while Assigned(Node) do begin
    NodeData := vstNav.GetNodeData(Node);
    if Assigned(NodeData) then begin
      if aElement.Equals(NodeData.Element) or aElement.Equals(NodeData.Container) then begin
        Result := Node;
        Exit;
      end;
    end;

    Node := vstNav.GetNextSibling(Node);
  end;

  if Result = vstNav.RootNode then
    Result := nil;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s        : string;
  txt      : AnsiString;
  fs       : TFileStream;
begin
  Action := caFree;
  if LoaderStarted and not wbLoaderDone then begin
    ForceTerminate := True;
    Caption := 'Waiting for Background Loader to terminate...';
    Enabled := False;
    try
      while not wbLoaderDone do begin
        Application.ProcessMessages;
        Sleep(100);
      end;
    finally
      Enabled := True;
    end;
  end;

  if Assigned(PluggyLinkThread) then
    PluggyLinkThread.Terminate;
  FreeAndNil(PluggyLinkThread);

  SaveChanged;

  if Assigned(Settings) then begin
    Settings.WriteInteger(Name, 'WindowState', Integer(WindowState));
    if WindowState = wsNormal then begin
      Settings.WriteInteger(Name, 'Left', Left);
      Settings.WriteInteger(Name, 'Top', Top);
      Settings.WriteInteger(Name, 'Width', Width);
      Settings.WriteInteger(Name, 'Height', Height);
    end;
    Settings.UpdateFile;
  end;

  try
    s := wbProgramPath + wbAppName + 'Edit_log.txt';
    if FileExists(s) then begin
      fs := TFileStream.Create(s, fmOpenReadWrite);
      fs.Seek(0, soFromEnd);
    end else
      fs := TFileStream.Create(s, fmCreate);
    if fs.Size > 3 * 1024 * 1024 then // truncate log file at 3MB
      fs.Size := 0;
    txt := AnsiString(mmoMessages.Lines.Text) + #13#10;
    fs.WriteBuffer(txt[1], Length(txt));
  finally
    if Assigned(fs) then
      FreeAndNil(fs);
  end;
  if DirectoryExists(wbTempPath) and wbRemoveTempPath then
    DeleteDirectory(wbTempPath); // remove temp folder unless it existed

  BackHistory := nil;
  ForwardHistory := nil;
  SetActiveRecord(nil);
  vstNav.Free;
  vstView.Free;
  vstSpreadSheetWeapon.Free;
  vstSpreadSheetArmor.Free;
  vstSpreadSheetAmmo.Free;
  pnlNav.Free;
  Files := nil;
  wbProgressCallback := nil;
end;

var
  LastUpdate    : Cardinal;

procedure GeneralProgress(const s: string);
begin
  if s <> '' then
    if wbShowStartTime > 0 then
      frmMain.PostAddMessage(FormatDateTime('[nn:ss] ', Now - wbStartTime) + s)
    else
      frmMain.PostAddMessage(s);
  if LastUpdate + 500 < GetTickCount then begin
    if wbCurrentAction <> '' then
      frmMain.Caption := '['+wbCurrentAction+'] Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    LastUpdate := GetTickCount;
  end;
  if frmMain.ForceTerminate then
    Abort;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  _BlockInternalEdit := True;
  wbProgressCallback := GeneralProgress;
  LastUpdate := GetTickCount;
  Font := Screen.IconFont;
  Caption := Application.Title;
  if (wbToolMode in [tmMasterUpdate, tmMasterRestore, tmLODgen]) then begin
    mmoMessages.Parent := Self;
    pnlNav.Visible := False;
    pnlTop.Visible := False;
    tbsView.TabVisible := False;
    tbsInfo.TabVisible := False;
    stbMain.Visible := False;
    pgMain.Visible := False;
    splElements.Visible := False;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  OffsetXY                    : TPoint;
  Column                      : TColumnIndex;
  NavNode                     : PVirtualNode;
  ViewNode                    : PVirtualNode;
  r                           : TRect;
begin
  if (Key = Ord('S')) and (Shift = [ssCtrl]) then
    SaveChanged;
  vstView.UpdateHotTrack;
  vstSpreadSheetWeapon.UpdateHotTrack;
  vstSpreadsheetArmor.UpdateHotTrack;
  vstSpreadSheetAmmo.UpdateHotTrack;
  if Key = VK_SHIFT then
    vstView.Header.Options := vstView.Header.Options + [hoAutoSpring];
  if (Shift = [ssAlt]) and (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT])then begin
    if not Assigned(vstView) then
      Exit;
    if not Assigned(vstNav) then
      Exit;
    if pgMain.ActivePage <> tbsView then
      Exit;
    if Assigned(vstView.EditLink) then
      Exit;

    vstView.BeginUpdate;
    try
      OffsetXY := vstView.OffsetXY;
      Column := vstView.FocusedColumn;
      ViewNode := vstView.FocusedNode;
      if Assigned(ViewNode) then
        r := vstView.GetDisplayRect(ViewNode, Column, False);
      case Key of
        VK_UP: begin
          NavNode := vstNav.FocusedNode;
          if not Assigned(NavNode) then
            NavNode := vstNav.GetLast
          else
            NavNode := vstNav.GetPreviousVisible(NavNode);
          if Assigned(NavNode) then begin
            vstNav.ClearSelection;
            vstNav.FocusedNode := NavNode;
            vstNav.Selected[vstNav.FocusedNode] := True;
          end;
        end;
        VK_DOWN: begin
          NavNode := vstNav.FocusedNode;
          if not Assigned(NavNode) then
            NavNode := vstNav.GetFirst
          else
            NavNode := vstNav.GetNextVisible(NavNode);
          if Assigned(NavNode) then begin
            vstNav.ClearSelection;
            vstNav.FocusedNode := NavNode;
            vstNav.Selected[vstNav.FocusedNode] := True;
          end;
        end;
        VK_LEFT: begin
          NavNode := vstNav.FocusedNode;
          if Assigned(NavNode) then
            NavNode := vstNav.NodeParent[NavNode];
          if Assigned(NavNode) then begin
            vstNav.ClearSelection;
            vstNav.FocusedNode := NavNode;
            vstNav.Selected[vstNav.FocusedNode] := True;
            vstNav.Expanded[vstNav.FocusedNode] := False;
          end;
        end;
        VK_RIGHT: begin
          NavNode := vstNav.FocusedNode;
          if Assigned(NavNode) then begin
            vstNav.Expanded[NavNode] := True;
            NavNode := vstNav.GetFirstVisibleChild(NavNode);
          end;
          if Assigned(NavNode) then begin
            vstNav.ClearSelection;
            vstNav.FocusedNode := NavNode;
            vstNav.Selected[vstNav.FocusedNode] := True;
          end;
        end;
      else
        Exit;
      end;
      if Assigned(NavNode) then begin
        vstView.UpdateScrollBars(False);
        vstView.OffsetXY := OffsetXY;
        if Assigned(ViewNode) then begin
          ViewNode := vstView.GetNodeAt(r.Left + 2, r.Top + 2);
          if Assigned(ViewNode) then
            vstView.FocusedNode := ViewNode;
        end;
        vstView.FocusedColumn := Column;
        vstView.OffsetXY := OffsetXY;
      end;
    finally
      vstView.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  vstView.UpdateHotTrack;
  vstSpreadSheetWeapon.UpdateHotTrack;
  vstSpreadsheetArmor.UpdateHotTrack;
  vstSpreadSheetAmmo.UpdateHotTrack;
  if Key = VK_SHIFT then
    vstView.Header.Options := vstView.Header.Options - [hoAutoSpring];
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  tmrStartup.Enabled := True;
end;

function CompareRefInfos(Item1, Item2: Pointer): Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  Result := CmpW32(PRefInfo(Item1).FormID, PRefInfo(Item2).FormID);

  if frmMain.ForceTerminate then
    Abort;
end;

procedure TfrmMain.GenerateLOD(const aWorldspace: IwbMainRecord);
var
  StartTick: Cardinal;

  procedure FindREFRs(const aElement: IwbElement; var REFRs: TDynMainRecords; var TotalCount, Count: Integer);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
  begin
    if StartTick + 500 < GetTickCount then begin
      Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(TotalCount) +
        ' References Found: ' + IntToStr(Count) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;
    end;

    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      if MainRecord.Signature = 'REFR' then begin
        if High(REFRs) < Count then
          SetLength(REFRs, Length(REFRs) * 2);
        REFRs[Count] := MainRecord;
        Inc(Count);
      end;
    end else if Supports(aElement, IwbContainerElementRef, Container) then
      for i := 0 to Pred(Container.ElementCount) do
        FindREFRs(Container.Elements[i], REFRs, TotalCount, Count);
  end;

type
  TRule = (rSkip, rClear, rReplace);

var
  Master     : IwbMainRecord;
  REFRs      : TDynMainRecords;
  Count      : Integer;
  TotalCount : Integer;
  i, j, k, l : Integer;
  NameRec    : IwbContainerElementRef;
  DataRec    : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  RefInfos   : array of TRefInfo;
  MinX, MaxX : Single;
  MinY, MaxY : Single;
  MinCell    : TwbGridCell;
  MaxCell    : TwbGridCell;
  Cells      : array of array of PRefInfo;
  RefInfo    : PRefInfo;
  RefsInCell : array of PRefInfo;
  CmpStream  : TwbFileStream;
  LODScale   : Single;
  LODAdd     : Single;
  F          : TSearchRec;
  s          : string;
  Rule       : TRule;
  lx,ly      : Integer;
begin
  LODScale := 100;
  LODAdd := 0.970001220703;

  Master := aWorldspace.MasterOrSelf;

  s := Settings.ReadString('Worldspace', Master.EditorID, '');
  if s = '' then
    s := Settings.ReadString('Default', 'Rule', 'Replace');

  Rule := rSkip;
  if SameText(s, 'Replace') then begin
    Rule := rReplace;
    s := 'Replacing';
  end else if SameText(s, 'Clear') then begin
    Rule := rClear;
    s := 'Clearing';
  end else if not SameText(s, 'Skip') then begin
    frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] <Warning: Unknown Rule "'+s+'"> Worldspace is being skipped.');
    s := 'Skipping';
  end else
    s := 'Skipping';

  frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: '+s+' ' + Master.Name);

  if Rule = rSkip then
    Exit;

  if Rule > rClear then begin
    Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: 0 '+
      'References Found: 0 Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    Count := 0;
    TotalCount := 0;
    REFRs := nil;
    SetLength(REFRs, 1024);
    FindREFRs(Master.ChildGroup, REFRs, TotalCount, Count);
    for i := 0 to Pred(Master.OverrideCount) do
      FindREFRs(Master.Overrides[i].ChildGroup, REFRs, TotalCount, Count);
    SetLength(REFRs, Count);

    {only keep the newest version of each}
    if Length(REFRs) > 1 then begin
      Caption := 'Sorting References: ' + aWorldspace.Name +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;

      QuickSort(@REFRs[0], Low(REFRs), High(REFRs), CompareElementsFormIDAndLoadOrder);

      Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
        ' Unique References Found: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      j := 0;
      for i := Succ(Low(REFRs)) to High(REFRs) do begin
        if REFRs[j].LoadOrderFormID <> REFRs[i].LoadOrderFormID then
          Inc(j);
        if j <> i then
          REFRs[j] := REFRs[i];

        if ForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Unique References Found: ' + IntToStr(j) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;
      SetLength(REFRs, Succ(j));
    end;

    MinX := MaxSingle;
    MaxX := -MaxSingle;
    MinY := MaxSingle;
    MaxY := -MaxSingle;

    Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Matching Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    SetLength(RefInfos, Length(REFRs));
    if Length(REFRs) > 0 then begin
      j := -1;
      for i := Low(REFRs) to High(REFRs) do begin

        if Supports(REFRs[i].RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
           Supports(NameRec.LinksTo, IwbMainRecord, MainRecord) and
           MainRecord.WinningOverride.HasVisibleWhenDistantMesh and
           Supports(REFRs[i].RecordBySignature['DATA'], IwbContainerElementRef, DataRec) and
           (DataRec.ElementCount = 2) and
           not REFRs[i].Flags.IsInitiallyDisabled and
           not REFRs[i].Flags.IsDeleted then begin
          try
            with RefInfos[Succ(j)] do begin
              FormID := MainRecord.LoadOrderFormID;

              with Pos, (DataRec.Elements[0] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Round(Elements[0].NativeValue)+0.5;
                if ElementCount >= 2 then
                  Y := Round(Elements[1].NativeValue)+0.5;
                if ElementCount >= 3 then
                  Z := Round(Elements[2].NativeValue)+0.970703125;

                if (x < -10000000.0) or (x > 10000000.0) or
                   (y < -10000000.0) or (y > 10000000.0) then
                  raise Exception.Create('Position out of bounds');

                if X < MinX then
                  MinX := x;
                if X > MaxX then
                  MaxX := x;
                if Y < MinY then
                  MinY := Y;
                if Y > MaxY then
                  MaxY := Y;
              end;
              with Rot, (DataRec.Elements[1] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Elements[0].NativeValue / wbRotationFactor;
                if ElementCount >= 2 then
                  Y := Elements[1].NativeValue / wbRotationFactor;
                if ElementCount >= 3 then
                  Z := Elements[2].NativeValue / wbRotationFactor;
              end;
              if Supports(REFRs[i].RecordBySignature['XSCL'], IwbContainerElementRef, DataRec) then
                Scale := DataRec.NativeValue
              else
                Scale := 1;
              Scale := RoundTo(Scale, -2);
              Scale := (Scale * LODScale);
              Scale := Scale + LODAdd;
            end;
            Inc(j);
          except
            on E: Exception do
              frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: <Error while processing ' + REFRs[i].Name+': '+E.Message + '>');
          end;
        end;

        if ForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Matching Records: ' + IntToStr(Succ(j)) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;

      end;
      SetLength(RefInfos, Succ(j));
    end;

    if Length(RefInfos) < 1 then
      Exit;

    MinCell.x := Trunc(MinX / 4096);
    if MinX < 0 then
      Dec(MinCell.x);
    MinCell.y := Trunc(MinY / 4096);
    if MinY < 0 then
      Dec(MinCell.y);
    MaxCell.x := Trunc(MaxX / 4096);
    if MaxX < 0 then
      Dec(MaxCell.x);
    MaxCell.y := Trunc(MaxY / 4096);
    if MaxY < 0 then
      Dec(MaxCell.y);

    SetLength(Cells, Succ(-(MinCell.x-MaxCell.x)), Succ(-(MinCell.y-MaxCell.y)));

    if ForceTerminate then
      Abort;
  end;

  ForceDirectories(wbDataPath + 'DistantLOD\');

  i := 0;
  Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
    ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
  Application.ProcessMessages;
  StartTick := GetTickCount;

  if ForceTerminate then
    Abort;

  if FindFirst(wbDataPath + 'DistantLOD\'+aWorldspace.EditorID+'*.lod', faAnyFile, F) = 0 then try
    repeat
      DeleteFile(wbDataPath + 'DistantLOD\' + F.Name);
      Inc(i);

      if StartTick + 500 < GetTickCount then begin
        Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;

      if ForceTerminate then
        Abort;

    until FindNext(F) <> 0;
  finally
    FindClose(F);
  end;

  if Rule > rClear then begin
    CmpStream := TwbFileStream.Create(wbDataPath + 'DistantLOD\'+aWorldspace.EditorID+'.cmp', fmCreate);
    try
      Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(RefInfos) to High(RefInfos) do
        with RefInfos[i], wbPositionToGridCell(Pos) do begin
          lX := x - MinCell.x;
          ly := y - MinCell.y;
          Next := Cells[lx,ly];
          Cells[lx,ly] := @RefInfos[i];

          if ForceTerminate then
            Abort;
          if StartTick + 500 < GetTickCount then begin
            Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(i) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;

      Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(Cells) to High(Cells) do
        for j := Low(Cells[i]) to High(Cells[i]) do begin
          RefInfo := Cells[i,j];
          Count := 0;
          while Assigned(RefInfo) do begin
            Inc(Count);
            RefInfo := RefInfo.Next;
          end;
          if Count > 0 then begin
            SetLength(RefsInCell, Count);

            RefInfo := Cells[i,j];
            Count := 0;
            while Assigned(RefInfo) do begin
              RefsInCell[Count] := RefInfo;
              RefInfo := RefInfo.Next;
              RefsInCell[Count].Next := nil;
              Inc(Count);
            end;

            QuickSort(@RefsInCell[0], Low(RefsInCell), High(RefsInCell), CompareRefInfos);

            l := 0;
            for k := Succ(Low(RefsInCell)) to High(RefsInCell) do begin
              if RefsInCell[l].FormID = RefsInCell[k].FormID then begin
                RefsInCell[k].Next := RefsInCell[l];
              end else
                Inc(l);
              if l <> k then
                RefsInCell[l] := RefsInCell[k];
            end;
            SetLength(RefsInCell, Succ(l));

            with TwbFileStream.Create(wbDataPath + 'DistantLOD\'+aWorldspace.EditorID+'_'+IntToStr(i+MinCell.x)+'_'+IntToStr(j+MinCell.y)+'.lod', fmCreate) do try
              WriteCardinal(Length(RefsInCell));

              for l := Low(RefsInCell) to High(RefsInCell) do begin
                RefInfo := RefsInCell[l];
                WriteCardinal(RefInfo.FormID);

                Count := 0;
                while Assigned(RefInfo) do begin
                  Inc(Count);
                  RefInfo := RefInfo.Next;
                end;
                WriteCardinal(Count);

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Pos, SizeOf(RefInfo.Pos));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Rot, SizeOf(RefInfo.Rot));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Scale, SizeOf(RefInfo.Scale));
                  RefInfo := RefInfo.Next;
                end;

              end;
            finally
              Free;
            end;
            CmpStream.WriteSmallInt(j+MinCell.y);
            CmpStream.WriteSmallInt(i+MinCell.x);
          end;

          if StartTick + 500 < GetTickCount then begin
            Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(i * Length(Cells[i]) + j) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;
      CmpStream.WriteCardinal(7);
    finally
      CmpStream.Free;
    end;
  end;
end;

function TfrmMain.GetAddElement(out TargetNode: PVirtualNode; out TargetIndex: Integer;
  out TargetElement: IwbElement): Boolean;
var
  NodeDatas                   : PViewNodeDatas;
  Container                   : IwbContainerElementRef;
begin
  TargetIndex := High(Integer);
  Result := False;

  if Pred(vstView.FocusedColumn) > High(ActiveRecords) then
    Exit;

  TargetNode := vstView.FocusedNode;
  while Assigned(TargetNode) do begin
    if TargetNode = vstView.RootNode then
      NodeDatas := @ActiveRecords[0]
    else
      NodeDatas := vstView.GetNodeData(TargetNode);
    if Assigned(NodeDatas) then begin
      TargetElement := NodeDatas[Pred(vstView.FocusedColumn)].Element;
      if Assigned(TargetElement) then begin
        if (TargetIndex < High(Integer)) and Supports(TargetElement, IwbContainerElementRef, Container) then
          Dec(TargetIndex, Container.AdditionalElementCount);
        Break;
      end;
    end;
    TargetIndex := TargetNode.Index;
    if TargetNode = vstView.RootNode then
      Break;
    TargetNode := TargetNode.Parent;
  end;
  if not Assigned(TargetElement) then
    Exit;

  Result := True;
end;

function TfrmMain.GetDragElements(Target: TBaseVirtualTree; Source: TObject;
  out TargetNode: PVirtualNode; out TargetIndex: Integer; out TargetElement, SourceElement: IwbElement): Boolean;
var
  SourceTree                  : TVirtualEditTree;
  NodeDatas                   : PViewNodeDatas;
  Container                   : IwbContainerElementRef;
begin
  TargetIndex := Low(Integer);
  Result := False;

  if Target.DropTargetColumn < 1 then
    Exit;
  if Pred(Target.DropTargetColumn) > High(ActiveRecords) then
    Exit;

  TargetNode := Target.DropTargetNode;
  while Assigned(TargetNode) do begin
    if TargetNode = Target.RootNode then
      NodeDatas := @ActiveRecords[0]
    else
      NodeDatas := Target.GetNodeData(TargetNode);
    if Assigned(NodeDatas) then begin
      TargetElement := NodeDatas[Pred(Target.DropTargetColumn)].Element;
      if Assigned(TargetElement) then begin
        if (TargetIndex >= 0) and Supports(TargetElement, IwbContainerElementRef, Container) then
          Dec(TargetIndex, Container.AdditionalElementCount);
        Break;
      end;
    end;
    TargetIndex := TargetNode.Index;
    if TargetNode = Target.RootNode then
      Break;
    TargetNode := TargetNode.Parent;
  end;
  if not Assigned(TargetElement) then
    Exit;

  if not (Source is TVirtualEditTree) then
    Exit;
  SourceTree := TVirtualEditTree(Source);

  if SourceTree.DragColumn < 1 then
    Exit;
  if Pred(SourceTree.DragColumn) > High(ActiveRecords) then
    Exit;

  if Length(SourceTree.DragSelection) <> 1 then
    Exit;

  NodeDatas := SourceTree.GetNodeData(SourceTree.DragSelection[0]);
  if not Assigned(NodeDatas) then
    Exit;

  SourceElement := NodeDatas[Pred(SourceTree.DragColumn)].Element as IwbElement;
  if not Assigned(SourceElement) then
    Exit;

  if SourceElement.Equals(TargetElement) then
    Exit;

  Result := True;
end;

function TfrmMain.GetRefBySelectionAsElements: TDynElements;
var
  i, j: Integer;
  ListItem                    : TListItem;
begin
  j := 0;
  Result := nil;
  SetLength(Result, lvReferencedBy.Items.Count);
  for i := 0 to Pred(lvReferencedBy.Items.Count) do begin
    ListItem := lvReferencedBy.Items[i];
    if Assigned(ListItem) and Assigned(ListItem.Data) and ListItem.Selected then begin
      Result[j] := IwbMainRecord(ListItem.Data);
      Inc(j);
    end;
  end;
  SetLength(Result, j);
end;

function TfrmMain.GetRefBySelectionAsMainRecords: TDynMainRecords;
var
  i, j: Integer;
  ListItem                    : TListItem;
begin
  j := 0;
  Result := nil;
  SetLength(Result, lvReferencedBy.Items.Count);
  for i := 0 to Pred(lvReferencedBy.Items.Count) do begin
    ListItem := lvReferencedBy.Items[i];
    if Assigned(ListItem) and Assigned(ListItem.Data) and ListItem.Selected then begin
      Result[j] := IwbMainRecord(ListItem.Data);
      Inc(j);
    end;
  end;
  SetLength(Result, j);
end;

function CompareElementID(Item1, Item2: Pointer): Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  Result := CmpW32(
    IwbElement(Item1).ElementID,
    IwbElement(Item2).ElementID);
end;

function TfrmMain.GetUniqueLinksTo(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer): TDynMainRecords;
var
  i, j, k : Integer;
  Element : IwbElement;
  LastID  : Cardinal;
begin
  SetLength(Result, aNodeCount);
  j := 0;
  for i := 0 to Pred(aNodeCount) do begin
    Element := aNodeDatas[i].Element;
    if Assigned(Element) and Supports(Element.LinksTo, IwbMainRecord, Result[j]) then begin
      Result[j] := Result[j].MasterOrSelf;
      if Result[j].OverrideCount > 0 then
        Result[j] := Result[j].Overrides[Pred(Result[j].OverrideCount)];
      Inc(j);
    end;
  end;
  case j of
    0: Result := nil;
    1: SetLength(Result, 1);
  else
    QuickSort(@Result[0], 0, Pred(j), CompareElementID);
    k := 1;
    LastID := Result[0].ElementID;
    for i := 1 to Pred(j) do
      if Result[i].ElementID <> LastID then begin
        LastID := Result[i].ElementID;
        if i <> k then
          Result[k] := Result[i];
        Inc(k);
      end;
    SetLength(Result, k);
  end;
end;

procedure TfrmMain.InheritStateFromChilds(Node: PVirtualNode; NodeData: PNavNodeData);
var
  ChildNode                   : PVirtualNode;
  ChildData                   : PNavNodeData;
begin
  ChildNode := vstNav.GetFirstChild(Node);
  while Assigned(ChildNode) do begin
    ChildData := vstNav.GetNodeData(ChildNode);

    if ChildData.ConflictAll > NodeData.ConflictAll then
      NodeData.ConflictAll := ChildData.ConflictAll;

    if ChildData.ConflictThis > NodeData.ConflictThis then
      NodeData.ConflictThis := ChildData.ConflictThis;

    if (nnfInjected in ChildData.Flags) then
      Include(NodeData.Flags, nnfInjected);
    if (nnfNotReachable in ChildData.Flags) then
      Include(NodeData.Flags, nnfNotReachable);
    if (nnfReferencesInjected in ChildData.Flags) then
      Include(NodeData.Flags, nnfReferencesInjected);

    ChildNode := vstNav.GetNextSibling(ChildNode);
  end;
end;

procedure TfrmMain.InitChilds(const aNodeDatas: PViewNodeDatas; aNodeCount: Integer;
  var aChildCount: Cardinal);
var
  NodeData                    : PNavNodeData;
  Container                   : IwbContainer;
  FirstContainer              : IwbContainer;
  SortableContainer           : IwbSortableContainer;
  Element                     : IwbElement;
  i, j, k                     : Integer;
  SortedCount                 : Integer;
  NonSortedCount              : Integer;
  SortedKeys                  : array of TnxFastStringListCS;
  Sortables                   : array of IwbSortableContainer;
  SortKey                     : string;
  LastSortKey                 : string;
  DupCounter                  : Integer;
begin
  SortedCount := 0;
  NonSortedCount := 0;
  FirstContainer := nil;
  for i := 0 to Pred(aNodeCount) do begin
    NodeData := @aNodeDatas[i];
    Container := NodeData.Container;
    if not Assigned(FirstContainer) then
      FirstContainer := Container;
    if Assigned(Container) then
      if Supports(Container, IwbSortableContainer, SortableContainer) and SortableContainer.Sorted then
        Inc(SortedCount)
      else
        Inc(NonSortedCount);
  end;

  if (NonSortedCount > 0) and (SortedCount > 0) then begin
    if Assigned(FirstContainer) then
      PostAddMessage('Warning: Comparing sorted and unsorted entrie for "' + FirstContainer.Path + '" in "'+FirstContainer.ContainingMainRecord.Name+'"');
    SortedCount := 0;
  end;

  if SortedCount > 0 then begin
//    Assert(NonSortedCount = 0);

    SetLength(SortedKeys, Succ(aNodeCount));
    for i := Low(SortedKeys) to High(SortedKeys) do begin
      SortedKeys[i] := TnxFastStringListCS.Create;
      SortedKeys[i].Sorted := True;
      SortedKeys[i].Duplicates := dupError;
    end;

    try
      SortedKeys[aNodeCount].Duplicates := dupIgnore;

      SetLength(Sortables, aNodeCount);

      for i := 0 to Pred(aNodeCount) do
        if Supports(aNodeDatas[i].Container, IwbSortableContainer, Sortables[i]) then begin
          SortableContainer := Sortables[i];
          DupCounter := 0;
          LastSortKey := '';
          for j := 0 to Pred(SortableContainer.ElementCount) do begin
            Element := SortableContainer.Elements[j];
            SortKey := Element.SortKey[False];
            if SameStr(LastSortKey, SortKey) then
              Inc(DupCounter)
            else begin
              DupCounter := 0;
              LastSortKey := SortKey;
            end;

            SortKey := SortKey + '<' + IntToHex64(DupCounter, 4) + '>';

            SortedKeys[i].AddObject(SortKey, Pointer(Element));
            SortedKeys[aNodeCount].Add(SortKey);
          end;
        end;

      aChildCount := SortedKeys[aNodeCount].Count;

      for j := 0 to Pred(aChildCount) do begin
        SortKey := SortedKeys[aNodeCount].Strings[j];
        for i := 0 to Pred(aNodeCount) do
          if SortedKeys[i].Find(SortKey, k) then
            IwbElement(Pointer(SortedKeys[i].Objects[k])).SortOrder := j;
      end;

    finally

      for i := Low(SortedKeys) to High(SortedKeys) do
        FreeAndNil(SortedKeys[i]);

    end;

  end
  else
    for i := 0 to Pred(aNodeCount) do begin
      NodeData := @aNodeDatas[i];
      Container := NodeData.Container;

      if Assigned(Container) then begin
        case Container.ElementType of
          etMainRecord, etSubRecordStruct: begin
              aChildCount := (Container.Def as IwbRecordDef).MemberCount;
              Inc(aChildCount, Container.AdditionalElementCount);
              if Cardinal(Container.ElementCount) > aChildCount then begin
                PostAddMessage('Error: Container.ElementCount {'+IntToStr(Container.ElementCount)+'} > aChildCount {'+IntToStr(aChildCount)+'} for ' + Container.Path + ' in ' + Container.ContainingMainRecord.Name);
                for j := 0 to Pred(Container.ElementCount) do
                PostAddMessage('  #'+IntToStr(j)+': ' + Container.Elements[j].Name);
                //Assert(Cardinal(Container.ElementCount) <= aChildCount);
              end;
            end;
          etSubRecordArray, etArray, etStruct, etSubRecord, etValue, etUnion, etStructChapter:
            if aChildCount < Cardinal(Container.ElementCount) then
              aChildCount := Container.ElementCount;
        end;
      end;
    end;
end;

procedure TfrmMain.InitConflictStatus(aNode: PVirtualNode; aInjected: Boolean; aNodeDatas: PViewNodeDatas = nil);

  procedure InheritConflict(Parent, Child: PNavNodeData);
  begin
    if Child.ConflictAll > Parent.ConflictAll then
      Parent.ConflictAll := Child.ConflictAll;
    if Child.ConflictThis > Parent.ConflictThis then
      Parent.ConflictThis := Child.ConflictThis;
  end;

var
  ChildNode                   : PVirtualNode;
  ChildNodeDatas              : PViewNodeDatas;
  NodeDatas                   : PViewNodeDatas;
  i                           : Integer;
  ConflictAll                 : TConflictAll;
  ConflictThis                : TConflictThis;
  Element                     : IwbElement;
  lDontShow                    : Boolean;
begin
  lDontShow := False;
  if not Assigned(aNodeDatas) then begin
    aNodeDatas := vstView.GetNodeData(aNode);
    if Assigned(ActiveMaster) then
      aInjected := ActiveMaster.IsInjected;
  end;

  ChildNode := vstView.GetFirstChild(aNode);
  if not Assigned(ChildNode) then
    aNodeDatas[0].ConflictAll := ConflictLevelForNodeDatas(aNodeDatas, Length(ActiveRecords), ComparingSiblings, aInjected)
  else
    while Assigned(ChildNode) do begin
      ChildNodeDatas := vstView.GetNodeData(ChildNode);
      InitConflictStatus(ChildNode, aInjected, ChildNodeDatas);
      for i := Low(ActiveRecords) to High(ActiveRecords) do
        InheritConflict(@aNodeDatas[i], @ChildNodeDatas[i]);
      ChildNode := vstView.GetNextSibling(ChildNode);
    end;

  ConflictAll := caUnknown;
  ConflictThis := ctUnknown;
  for i := Low(ActiveRecords) to High(ActiveRecords) do begin
    if aNodeDatas[i].ConflictAll > ConflictAll then
      ConflictAll := aNodeDatas[i].ConflictAll;
    if aNodeDatas[i].ConflictThis > ConflictThis then
      ConflictThis := aNodeDatas[i].ConflictThis;
  end;

  for i := Low(ActiveRecords) to High(ActiveRecords) do
    aNodeDatas[i].ConflictAll := ConflictAll;

  if aNodeDatas[0].ConflictAll = caUnknown then
    Assert(False);

  if aNode <> vstView.RootNode then begin

    for i := Low(ActiveRecords) to High(ActiveRecords) do begin
      if vnfDontShow in aNodeDatas[i].ViewNodeFlags then
        lDontShow := True;
      if Assigned(aNodeDatas[i].Container) then begin
        lDontShow := False;
        Break;
      end;
    end;

    case ConflictThis of
      ctUnknown: vstView.IsVisible[aNode] := not lDontShow and not wbTranslationMode;
      ctIgnored: vstView.IsVisible[aNode] := not wbHideIgnored;
      ctNotDefined: begin
          if aNode.Parent = vstView.RootNode then
            ChildNodeDatas := @ActiveRecords[0]
          else
            ChildNodeDatas := vstView.GetNodeData(aNode.Parent);

          for i := Low(ActiveRecords) to High(ActiveRecords) do begin
            Element := ChildNodeDatas[i].Container;
            if Assigned(Element) then
              Break;
          end;

          if Assigned(Element) and (Element.ElementType in [etMainRecord, etSubRecordStruct]) then begin
            i := (Element as IwbContainer).AdditionalElementCount;
            if Integer(aNode.Index) >= i then
              with (Element.Def as IwbRecordDef).Members[Integer(aNode.Index) - i] do begin
                if (wbTranslationMode and (ConflictPriority <> cpTranslate)) or
                  (wbTranslationMode and (ConflictPriority = cpIgnore)) then begin
                  ConflictThis := ctIgnored;
                  for i := Low(ActiveRecords) to High(ActiveRecords) do
                    aNodeDatas[i].ConflictThis := ConflictThis;
                end;

                if (ConflictThis <> ctIgnored) and HasDontShow then begin
                  lDontShow := True;
                  for i := Low(ActiveRecords) to High(ActiveRecords) do begin
                    Element := ChildNodeDatas[i].Container;
                    if Assigned(Element) then begin
                      lDontShow := DontShow[Element];
                      if not lDontShow then
                        Break;
                    end;
                  end;
                end;
              end;
          end;

          if ConflictThis = ctNotDefined then begin
            NodeDatas := vstView.GetNodeData(aNode.Parent);
            if not Assigned(NodeDatas) then
              NodeDatas := @ActiveRecords[0];
            for i := Low(ActiveRecords) to High(ActiveRecords) do begin
              Element := NodeDatas[i].Container;
              if Assigned(Element) then
                Break;
            end;
            if Assigned(Element) and (Element.ElementType in [etMainRecord, etSubRecordStruct]) then begin
              i := (Element as IwbContainer).AdditionalElementCount;
              if Integer(aNode.Index) >= i then
                with (Element.Def as IwbRecordDef).Members[Integer(aNode.Index) - i] do
                  if ConflictPriority = cpIgnore then
                    ConflictThis := ctIgnored;
            end;
          end;

          vstView.IsVisible[aNode] := ((ConflictThis <> ctIgnored) or not wbHideIgnored) and not lDontShow;
        end;
    else
      vstView.IsVisible[aNode] := not lDontShow;
    end;
    if not ComparingSiblings then begin
      if HideNoConflict then
        if ConflictThis < ctOverride then
          vstView.IsVisible[aNode] := False;
    end;
  end;
end;

procedure TfrmMain.InitNodes(const aNodeDatas: PViewNodeDatas;
  const aParentDatas: PViewNodeDatas;
  aNodeCount: Integer;
  aIndex: Cardinal;
  var aInitialStates: TVirtualNodeInitStates);
var
  NodeData                    : PViewNodeData;
  ParentData                  : PViewNodeData;
  Container                   : IwbContainerElementRef;
  SortableContainer           : IwbSortableContainer;
  i                           : Integer;
begin
  for i := 0 to Pred(aNodeCount) do begin
    NodeData := @aNodeDatas[i];
    ParentData := @aParentDatas[i];

    Container := ParentData.Container;
    if Assigned(Container) then begin
      if Supports(Container, IwbSortableContainer, SortableContainer) and SortableContainer.Sorted then
        NodeData.Element := Container.ElementBySortOrder[aIndex]
      else
        case Container.ElementType of
          etMainRecord, etSubRecordStruct:
            NodeData.Element := Container.ElementBySortOrder[aIndex];
          etSubRecordArray, etArray, etStruct, etSubRecord, etValue, etUnion, etStructChapter:
            if aIndex < Cardinal(Container.ElementCount) then
              NodeData.Element := Container.Elements[aIndex];
        end;
    end;
    if Assigned(NodeData.Element) and NodeData.Element.DontShow then begin
      NodeData.Element := nil;
      Include(NodeData.ViewNodeFlags, vnfDontShow);
    end;
  end;

  aInitialStates := [ivsDisabled];
  for i := 0 to Pred(aNodeCount) do
    with aNodeDatas[i] do begin
      if Assigned(Element) then
        Exclude(aInitialStates, ivsDisabled)
      else
        if Assigned(aParentDatas) and ((vnfIgnore in aParentDatas[i].ViewNodeFlags) or (Assigned(aParentDatas[i].Element) and (aParentDatas[i].Element.ConflictPriority = cpIgnore))) then
          Include(ViewNodeFlags, vnfIgnore);

      if not Assigned(Container) then
        if Supports(Element, IwbContainerElementRef, Container) then begin
          //          if Container.ElementCount = 0 then
          //            Container := nil;
        end;

      if Assigned(Container) then
        if Container.ElementCount > 0 then
          Include(aInitialStates, ivsHasChildren);
    end;
end;

procedure TfrmMain.InvalidateElementsTreeView(aNodes: TNodeArray);
var
  Node                        : PVirtualNode;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  i                           : Integer;
begin
  if Length(aNodes) = 0 then
    aNodes := vstNav.GetSortedSelection(True);
  for i := -1 to High(aNodes) do begin
    if i < 0 then
      Node := vstNav.FocusedNode
    else
      Node := aNodes[i];

    while Assigned(Node) and (Node <> vstNav.RootNode) do begin
      NodeData := vstNav.GetNodeData(Node);
      if Assigned(NodeData) then begin
        with NodeData^ do begin
          ConflictAll := caUnknown;
          ConflictThis := ctUnknown;
          Flags := [];
        end;

        if Assigned(NodeData.Element) and (NodeData.Element.ElementType = etMainRecord) then begin
          MainRecord := (NodeData.Element as IwbMainRecord);
          with MainRecord do begin
            ConflictAll := caUnknown;
            ConflictThis := ctUnknown;
          end;
          ConflictLevelForMainRecord(MainRecord, NodeData.ConflictAll, NodeData.ConflictThis);
          if MainRecord.IsInjected then
            Include(NodeData.Flags, nnfInjected);
          if MainRecord.IsNotReachable then
            Include(NodeData.Flags, nnfNotReachable);
          if MainRecord.ReferencesInjected then
            Include(NodeData.Flags, nnfReferencesInjected);
        end;

        if InheritConflictByParent and (Node.ChildCount > 0) then
          InheritStateFromChilds(Node, NodeData);

        vstNav.InvalidateNode(Node);
      end;
      Node := Node.Parent;
    end;
  end;
end;

procedure TfrmMain.JumpTo(aInterface: IInterface; aBackward: Boolean);
var
  Current                     : IInterface;
  MainRecord                  : IwbMainRecord;
  HistoryEntry                : IHistoryEntry;
begin
  UserWasActive := True;

  if (pgMain.ActivePage = tbsView) or (pgMain.ActivePage = tbsReferencedBy) then begin
    if Assigned(ActiveRecord) then begin
      if pgMain.ActivePage = tbsView then
        Current := TMainRecordPosHistoryEntry.Create(ActiveRecord)
      else
        Current := TMainRecordRefByHistoryEntry.Create(ActiveRecord);
    end else if (Length(CompareRecords) > 0) then
      Current := TCompareRecordsPosHistoryEntry.Create(CompareRecords);
  end
  else
    Current := TTabHistoryEntry.Create(pgMain.ActivePage);

  if Assigned(Current) then begin
    if aBackward then begin
      if not Assigned(ForwardHistory) then
        ForwardHistory := TInterfaceList.Create;
      ForwardHistory.Add(Current);
    end
    else begin
      if not Assigned(BackHistory) then
        BackHistory := TInterfaceList.Create;
      BackHistory.Add(Current);
    end;
  end;

  if Supports(aInterface, IwbMainRecord, MainRecord) then
    aInterface := TMainRecordHistoryEntry.Create(MainRecord);

  if Supports(aInterface, IHistoryEntry, HistoryEntry) then
    HistoryEntry.Show;
end;

procedure TfrmMain.lvReferencedByColumnClick(Sender: TObject; Column: TListColumn);
begin
  ReferencedBySortColumn := Column;
  lvReferencedBy.AlphaSort;
end;

procedure TfrmMain.lvReferencedByCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if not Assigned(ReferencedBySortColumn) or (ReferencedBySortColumn.Index = 0) then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    Compare := CompareText(Item1.SubItems[Pred(ReferencedBySortColumn.Index)], Item2.SubItems[Pred(ReferencedBySortColumn.Index)])
end;

procedure TfrmMain.lvReferencedByDblClick(Sender: TObject);
var
  ListItem                    : TListItem;
begin
  ListItem := lvReferencedBy.Selected;
  if Assigned(ListItem) and Assigned(ListItem.Data) then
    JumpTo(IwbMainRecord(ListItem.Data), False);
end;

procedure TfrmMain.mniViewAddClick(Sender: TObject);
var
  TargetNode                  : PVirtualNode;
  TargetIndex                 : Integer;
  TargetElement               : IwbElement;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if GetAddElement(TargetNode, TargetIndex, TargetElement) then begin
    if not EditWarn then
      Exit;

    //    vstView.BeginUpdate;
    try
      TargetElement.Assign(TargetIndex, nil, False);
      ActiveRecords[Pred(vstView.FocusedColumn)].UpdateRefs;
      TargetElement := nil;
      PostResetActiveTree;
    finally
      //      vstView.EndUpdate;
    end;

    InvalidateElementsTreeView(NoNodes);
  end;
end;

procedure TfrmMain.mniViewColumnWidthClick(Sender: TObject);
var
  i: Integer;
begin
  UserWasActive := True;

  if mniViewColumnWidthFitAll.Checked then
    i := 1
  else if mniViewColumnWidthFitText.Checked then
    i := 2
  else
    i := 0;
  Settings.WriteInteger('View','ColumnWidth',i);
  Settings.UpdateFile;
  UpdateColumnWidths;
end;

procedure TfrmMain.mniViewCompareReferencedRowClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Records                     : TDynMainRecords;
begin
  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if not Assigned(NodeDatas) then
    Exit;
  Records := GetUniqueLinksTo(NodeDatas, Length(ActiveRecords));
  JumpTo(TCompareRecordsHistoryEntry.Create(Records), False);
end;

procedure TfrmMain.mniViewCopyToSelectedRecordsClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  MainRecords                 : array of IwbMainRecord;
  SelectedNodes               : TNodeArray;
  i, j                        : Integer;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin

      SelectedNodes := vstNav.GetSortedSelection(True);
      if Length(SelectedNodes) < 2 then
        Exit;
      SetLength(MainRecords, Length(SelectedNodes));
      j := 0;
      for i := Low(SelectedNodes) to High(SelectedNodes) do begin
        NodeData := vstNav.GetNodeData(SelectedNodes[i]);
        if Assigned(NodeData) and not Element.Equals(NodeData.Element) and
          Supports(NodeData.Element, IwbMainRecord, MainRecords[j]) then
          Inc(j);
      end;
      SetLength(MainRecords, j);
      if Length(MainRecords) < 1 then
        Exit;

      with TfrmFileSelect.Create(Self) do try

        Caption := 'Which records should this value be copied to?';

        for i := Low(MainRecords) to High(MainRecords) do begin
          CheckListBox1.AddItem(MainRecords[i].Name, nil);
          CheckListBox1.Checked[i] := True;
        end;

        ShowModal;

        for i := Low(MainRecords) to High(MainRecords) do
          if CheckListBox1.Checked[i] then begin
            if not EditWarn then
              Exit;

            wbCopyElementToRecord(Element, MainRecords[i], False, True);
          end;

      finally
        Free;
      end;

    end;
  end;

  for i := Low(SelectedNodes) to High(SelectedNodes) do
    vstNav.IterateSubtree(SelectedNodes[i], ClearConflict, nil);
  InvalidateElementsTreeView(SelectedNodes);
  PostResetActiveTree;
  vstNav.Invalidate;
end;

procedure TfrmMain.mniNavAddMastersClick(Sender: TObject);
var
  NodeData                    : PNavNodeData;
  _File                       : IwbFile;
  i, j                        : Integer;
begin
  UserWasActive := True;

  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  if Assigned(NodeData) and Supports(NodeData.Element, IwbFile, _File) then begin
    with TfrmFileSelect.Create(Self) do try

      for i := Low(Files) to High(Files) do begin
        if Files[i].LoadOrder >= _File.LoadOrder then
          Break;
        if not (fsIsHardcoded in Files[i].FileStates) then
          CheckListBox1.AddItem(Files[i].FileName, Pointer(Files[i]));
      end;

      for i := 0 to Pred(_File.MasterCount) do begin
        j := CheckListBox1.Items.IndexOf(_File.Masters[i].FileName);
        if j >= 0 then
          CheckListBox1.Items.Delete(j);
      end;

      Caption := 'Which masters do you want to add?';

      ShowModal;

      for i := Pred(CheckListBox1.Count) downto 0 do
        if not CheckListBox1.Checked[i] then
          CheckListBox1.Items.Delete(i);

      if CheckListBox1.Count < 1 then
        Exit;

      _File.AddMasters(CheckListBox1.Items);
    finally
      Free;
    end;
  end;
end;

procedure TfrmMain.ApplyScript(aScript: string);
const
  sJustWait                   = 'Applying script. Please wait...';
  sTerminated                 = 'Script terminated itself, Result=';
var
  Selection                   : TNodeArray;
  StartNode, Node, NextNode   : PVirtualNode;
  NodeData                    : PNavNodeData;
  Count                       : Cardinal;
  StartTick                   : Cardinal;
  jvi                         : TJvInterpreterProgram;
  i, p                        : Integer;
  bCheckUnsaved               : Boolean;
  bShowMessages               : Boolean;
begin
  // prevent execution of new scripts if already executing
  if Assigned(ScriptEngine) then
    Exit;

  if Trim(aScript) = '' then
    Exit;

  p := Pos('Mode:', aScript);
  bShowMessages := not ContainsText(Copy(aScript, p, PosEx(#10, aScript, p) - p), 'Silent');

  bCheckUnsaved := tmrCheckUnsaved.Enabled;
  tmrCheckUnsaved.Enabled := False;

  Count := 0;
  ScriptProcessElements := [etMainRecord];

  jvi := TJvInterpreterProgram.Create(Self);
  try
    ScriptEngine := jvi;
    jvi.OnGetValue := JvInterpreterProgram1GetValue;
    jvi.OnSetValue := JvInterpreterProgram1SetValue;
    jvi.OnGetUnitSource := JvInterpreterProgram1GetUnitSource;
    jvi.Pas.Text := aScript;
    jvi.Compile;

    if bShowMessages then pgMain.ActivePage := tbsMessages;
    Selection := vstNav.GetSortedSelection(True);
    vstNav.BeginUpdate;
    try
      StartTick := GetTickCount;
      wbStartTime := Now;

      Enabled := False;

      if bShowMessages then AddMessage('Applying script...');
      Application.ProcessMessages;

      if jvi.FunctionExists('', 'Initialize') then begin
        jvi.CallFunction('Initialize', nil, []);
        if jvi.VResult <> 0 then begin
          if bShowMessages then PostAddMessage(sTerminated + IntToStr(jvi.VResult));
          Exit;
        end;
      end;

      for i := Low(Selection) to High(Selection) do begin
        StartNode := Selection[i];
        if Assigned(StartNode) then begin
          Node := vstNav.GetLast(StartNode);
          if not Assigned(Node) then
            Node := StartNode;
        end else
          Node := nil;
        while Assigned(Node) do begin
          NextNode := vstNav.GetPrevious(Node);
          NodeData := vstNav.GetNodeData(Node);

          if Assigned(NodeData.Element) then
            if NodeData.Element.ElementType in ScriptProcessElements then begin

              if jvi.FunctionExists('', 'Process') then begin
                jvi.CallFunction('Process', nil, [NodeData.Element]);
                if jvi.VResult <> 0 then begin
                  if bShowMessages then PostAddMessage(sTerminated + IntToStr(jvi.VResult));
                  Exit;
                end;
              end else
                Break;

              Inc(Count);
            end;

          if Node = StartNode then
            Node := nil
          else
            Node := NextNode;

          if StartTick + 500 < GetTickCount then begin
            Caption := sJustWait + ' Processed Records: ' + IntToStr(Count) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;
      end;

      if jvi.FunctionExists('', 'Finalize') then begin
        jvi.CallFunction('Finalize', nil, []);
        if jvi.VResult <> 0 then begin
          if bShowMessages then PostAddMessage(sTerminated + IntToStr(jvi.VResult));
          Exit;
        end;
      end;

    finally
      vstNav.EndUpdate;
      Enabled := True;
      Caption := Application.Title;
      if bShowMessages then PostAddMessage('[Apply Script done] ' + ' Processed Records: ' + IntToStr(Count) +
        ', Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime));
    end;

    InvalidateElementsTreeView(NoNodes);
    vstNav.Invalidate;
  finally
    jvi.Free;
    ScriptEngine := nil;
    tmrCheckUnsaved.Enabled := bCheckUnsaved;
  end;
end;

procedure TfrmMain.mniNavApplyScriptClick(Sender: TObject);
var
  Scr: string;
begin
  with TfrmScript.Create(Self) do try
    Path := wbScriptsPath;
    LastUsedScript := Settings.ReadString('View', 'LastUsedScript', '');
    if ShowModal <> mrOK then
      Exit;
    Scr := Script;
    Settings.WriteString('View', 'LastUsedScript', LastUsedScript);
    Settings.UpdateFile;
    CreateActionsForScripts;
  finally
    Free;
  end;
  ApplyScript(Scr);
end;

procedure TfrmMain.CreateActionsForScripts;
const
  HotkeyToken = 'Hotkey: ';
var
  scr, s               : string;
  F                    : TSearchRec;
  slScript             : TStringList;
  i                    : integer;
  ShortCut             : TShortCut;
  Action               : TAction;
begin
  if not Assigned(ScriptHotkeys) then
    ScriptHotkeys := TStringList.Create;

  ScriptHotkeys.Clear;
  for i := Pred(ActionList1.ActionCount) downto 0 do
    if ActionList1.Actions[i].Tag > 0 then
      ActionList1.Actions[i].Free;

  if FindFirst(wbScriptsPath + '*.pas', faAnyFile, F) = 0 then try
    slScript := TStringList.Create;
    repeat
      scr := wbScriptsPath + F.Name;
      slScript.LoadFromFile(scr);
      for i := 0 to Pred(slScript.Count) do begin
        s := Trim(slScript[i]);
        if SameText(Copy(s, 1, Length(HotkeyToken)), HotkeyToken) then begin
          s := Copy(s, Succ(Length(HotkeyToken)), Length(s));
          ShortCut := TextToShortCut(s);
          if (ShortCut <> 0) and (ScriptHotkeys.IndexOfObject(TObject(ShortCut)) = -1) then begin
            Action := TAction.Create(Self);
            Action.ActionList := ActionList1;
            Action.OnExecute := acScriptExecute;
            Action.ShortCut := ShortCut;
            ScriptHotkeys.AddObject(scr, TObject(ShortCut));
            Action.Tag := ScriptHotkeys.Count;
          end;
          Break;
        end;
      end;
    until FindNext(F) <> 0;
  finally
    FindClose(F);
    FreeAndNil(slScript);
  end;

end;

procedure TfrmMain.mniViewHideNoConflictClick(Sender: TObject);
begin
  mniViewHideNoConflict.Checked := not mniViewHideNoConflict.Checked;
  HideNoConflict := mniViewHideNoConflict.Checked;
  ResetActiveTree;
  Settings.WriteBool('View', 'HodeNoConflict', HideNoConflict);
  Settings.UpdateFile;
end;

procedure TfrmMain.mniViewMoveDownClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin
      if not EditWarn then
        Exit;

      Element.MoveDown;
      PostResetActiveTree;
    end;
  end;
end;

procedure TfrmMain.mniViewMoveUpClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin
      if not EditWarn then
        Exit;

      Element.MoveUp;
      PostResetActiveTree;
    end;
  end;
end;

procedure AfterCopyDisable(const aElement: IwbElement);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(aElement, IwbMainRecord, MainRecord) then
    MainRecord.IsInitiallyDisabled := True;
end;

procedure TfrmMain.mniRefByCopyDisabledOverrideIntoClick(Sender: TObject);
var
  Elements                    : TDynElements;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  Elements := GetRefBySelectionAsElements;

  CopyInto(
    False,
    False,
    False,
    False,
    Elements,
    AfterCopyDisable);

  vstNav.Invalidate;
end;

procedure TfrmMain.mniRefByCopyIntoClick(Sender: TObject);
var
  Elements                    : TDynElements;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  Elements := GetRefBySelectionAsElements;

  CopyInto(
    Sender = mniRefByCopyAsNewInto,
    False,
    False,
    Sender = mniRefByDeepCopyOverrideInto,
    Elements);

  vstNav.Invalidate;
end;

procedure TfrmMain.mniRefByMarkModifiedClick(Sender: TObject);
var
  MainRecords                 : TDynMainRecords;
  i                           : Integer;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;
  if not EditWarn then
    Exit;

  UserWasActive := True;

  MainRecords := GetRefBySelectionAsMainRecords;

  for i := Low(MainRecords) to High(MainRecords) do
    MainRecords[i].MarkModifiedRecursive;

  MainRecords := nil;
  vstNav.Invalidate;
end;

procedure TfrmMain.mniRefByRemoveClick(Sender: TObject);
var
  MainRecords                 : TDynMainRecords;
  i                           : Integer;
  lActiveRecord               : IwbMainRecord;
  Container                   : IwbContainerElementRef;
  NextContainer               : IwbContainerElementRef;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  MainRecords := GetRefBySelectionAsMainRecords;

  for i := Low(MainRecords) to High(MainRecords) do begin
    Supports(MainRecords[i].Container, IwbContainerElementRef, Container);
    MainRecords[i].Remove;
    MainRecords[i] := nil;
    while Assigned(Container) and (Container.ElementCount = 0) do begin
      Supports(Container, IwbContainerElementRef, NextContainer);
      Container.Remove;
      Container := NextContainer;
    end;
  end;
  MainRecords := nil;

  lActiveRecord := ActiveRecord;
  ActiveRecord := nil;
  SetActiveRecord(lActiveRecord);

  vstNav.Invalidate;
end;

procedure TfrmMain.mmoMessagesDblClick(Sender: TObject);
var
  s: string;
  Key: Word;
begin
  s := Trim(mmoMessages.SelText);
  if Length(s) < 8 then
    Exit;
  if (s[1] = '[') and (s[Length(s)] = ']') then
    s := Copy(s, 2, Length(s) - 2);
  if Length(s) < 8 then
    Exit;
  if s[5] = ':' then
    s := Copy(s, 6, High(Integer));
  if Length(s) <> 8 then
    Exit;
  if GetKeyState(VK_CONTROL) >= 0 then
    Exit;
  edFormIDSearch.Text := s;
  Key := VK_RETURN;
  edFormIDSearchKeyDown(edFormIDSearch, Key, []);
end;

procedure TfrmMain.mniNavAddClick(Sender: TObject);
var
  NodeData                    : PNavNodeData;
  Container                   : IwbContainerElementRef;
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
begin
  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  if Assigned(NodeData) and Supports(NodeData.Element, IwbContainerElementRef, Container) then begin
    vstNav.FullyVisible[vstNav.FocusedNode] := True;
    vstNav.Expanded[vstNav.FocusedNode] := True;
    Element := Container.Add(StringReplace((Sender as TMenuItem).Caption, '&', '', [rfReplaceAll]), False);
    if Assigned(Element) then begin
      vstNav.AddChild(vstNav.FocusedNode, Pointer(Element));
      Element._AddRef;

      vstNav.ClearSelection;
      vstNav.FocusedNode := FindNodeForElement(Element);
      vstNav.Selected[vstNav.FocusedNode] := True;

      if Supports(Element, IwbMainRecord, MainRecord) then
        SetActiveRecord(MainRecord)
      else
        SetActiveRecord(nil);

    end;
  end;
end;

function StrContaines(const aStr, aSubStr: string) : Boolean;
begin
  Result := (Pos(AnsiUpperCase(aSubStr), AnsiUpperCase(aStr)) > 0);
end;

procedure TfrmMain.mniNavBanditFixClick(Sender: TObject);
var
  i, j              : Integer;
  MMMESM            : Integer;
  CSNPC             : IwbMainRecord;
  CSNPCBoss         : IwbMainRecord;
  CSNPCBandit       : IwbMainRecord;
  CSNPCBanditBoss   : IwbMainRecord;
  CSNPCID           : string;
  CSNPCBossID       : string;
  CSNPCBanditID     : string;
  CSNPCBanditBossID : string;
  Group             : IwbContainerElementRef;
  MainRecord        : IwbMainRecord;
  MainRecordRef     : IwbContainerElementRef;
  s                 : string;
begin
  MMMESM := -1;
  for i := Low(Files) to High(Files) do
    if SameText(Files[i].FileName, 'Mart''s Monster Mod.esm') then begin
      MMMESM := i;
      Break
    end;
  if MMMESM < 1 then
    raise Exception.Create('Can''t find Mart''s Monster Mod.esm');

  if Supports(Files[MMMESM].GroupBySignature['SCPT'], IwbContainerElementRef, Group) then
    for j := 0 to Pred(Group.ElementCount) do
      if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then
        if SameText(MainRecord.EditorID,'CSNPC') then
          CSNPC := MainRecord
        else if SameText(MainRecord.EditorID,'CSNPCBoss') then
          CSNPCBoss := MainRecord
        else if SameText(MainRecord.EditorID,'CSNPCBandit') then
          CSNPCBandit := MainRecord
        else if SameText(MainRecord.EditorID,'CSNPCBanditBoss') then
          CSNPCBanditBoss := MainRecord;

  if not Assigned(CSNPC) then
    raise Exception.Create('Can''t find CSNPC script');
  if not Assigned(CSNPC) then
    raise Exception.Create('Can''t find CSNPCBoss script');
  if not Assigned(CSNPC) then
    raise Exception.Create('Can''t find CSNPCBandit script');
  if not Assigned(CSNPC) then
    raise Exception.Create('Can''t find CSNPCBanditBoss script');

  CSNPCID           := IntToHex64(CSNPC.LoadOrderFormID, 8);
  CSNPCBossID       := IntToHex64(CSNPCBoss.LoadOrderFormID, 8);
  CSNPCBanditID     := IntToHex64(CSNPCBandit.LoadOrderFormID, 8);
  CSNPCBanditBossID := IntToHex64(CSNPCBanditBoss.LoadOrderFormID, 8);

  for i := MMMESM to High(Files) do
    if (i = MMMESM) or Files[i].HasMaster('Mart''s Monster Mod.esm') then
      if Supports(Files[i].GroupBySignature['NPC_'], IwbContainerElementRef, Group) then
        for j := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then
            if not StrContaines(MainRecord.EditorID, 'Adven') and
               (
                 StrContaines(MainRecord.EditorID, 'Bandit') or
                 StrContaines(MainRecord.EditorID, 'Maraud') or
                 StrContaines(MainRecord.EditorID, 'Raider')
               ) then begin
              MainRecordRef := MainRecord as IwbContainerElementRef;

              s := Trim(MainRecordRef.ElementEditValues['SCRI']);
              if s = '' then
                if StrContaines(MainRecord.EditorID, 'Boss') then
                  s := CSNPCBanditBossID
                else
                  s := CSNPCBanditID
              else if s = CSNPCID then
                s := CSNPCBanditID
              else if s = CSNPCBossID then
                s := CSNPCBanditBossID
              else
                Continue;

              MainRecordRef.ElementEditValues['SCRI'] := s;
            end;
end;

procedure TfrmMain.mniNavBatchChangeReferencingRecordsClick(Sender: TObject);

  function FindFile(const s: String): IwbFile;
  var
    i: Integer;
  begin
    for i := Low(Files) to High(Files) do
      if AnsiSameText(Files[i].FileName, s) then begin
        Result := Files[i];
        Exit;
      end;
    Result := nil;
  end;

var
  _File                       : IwbFile;
  NodeData                    : PNavNodeData;
  CSV, Line                   : TStringList;
  i, j, k, l                  : Integer;
  s                           : string;
  OldMaster                   : IwbFile;
  NewMaster                   : IwbFile;
  OldRecord                   : IwbMainRecord;
  NewRecord                   : IwbMainRecord;
  RefRecord                   : IwbMainRecord;
  ReferencedBy                : TDynMainRecords;
  NewMasters                  : TStringList;
  ReplaceList                 : array of record
    rlOldRecord: IwbMainRecord;
    rlNewRecord: IwbMainRecord;
    rlReferencedBy : TDynMainRecords;
  end;
begin
  ReplaceList := nil;
  l := 0;

  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  if not Assigned(NodeData) then
    Exit;
  if not Supports(NodeData.Element, IwbFile, _File) then
    Exit;

  with odCSV do begin
    FileName := '';
    InitialDir := wbDataPath;
    if not Execute then
      Exit;
  end;

  NewMasters := TStringList.Create;
  try
    NewMasters.Sorted := True;
    NewMasters.Duplicates := dupError;

    CSV := TStringList.Create;
    try
      CSV.LoadFromFile(odCSV.FileName);
      Line := TStringList.Create;
      try
        SetLength(ReplaceList, CSV.Count);
        for i := 1 to Pred(CSV.Count) do begin //ignore first line
          Line.CommaText := CSV[i];
          if Line.Count <> 7 then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': 7 values expected but '+IntToStr(Line.Count)+' found.');
            Continue;
          end;

          s := Trim(Line[1]);
          OldMaster := FindFile(s);
          if not Assigned(OldMaster) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old Master "'+s+'" is not loaded.');
            Continue;
          end else if OldMaster.LoadOrder < 0 then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old Master "'+s+'" does not have a load order assigned.');
            Continue;
          end;

          s := Trim(Line[5]);
          NewMaster := FindFile(s);
          if not Assigned(NewMaster) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': New Master "'+s+'" is not loaded.');
            Continue;
          end else if NewMaster.LoadOrder < 0 then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': New Master "'+s+'" does not have a load order assigned.');
            Continue;
          end;

          s := Trim(Line[2]);
          j := StrToIntDef(s, -1);
          if (j < 0) or (j > $FFFFFF) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old FormID "'+s+'" is not in the valid range.');
            Continue;
          end;
          OldRecord := OldMaster.RecordByFormID[(Cardinal(OldMaster.LoadOrder) shl 24) or Cardinal(j), True];
          if not Assigned(OldRecord) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old Record with FormID "'+s+'" was not found in old Master "'+OldMaster.FileName+'".');
            Continue;
          end;

          s := Trim(Line[6]);
          j := StrToIntDef(s, -1);
          if (j < 0) or (j > $FFFFFF) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': New FormID "'+s+'" is not in the valid range.');
            Continue;
          end;
          NewRecord := NewMaster.RecordByFormID[(Cardinal(NewMaster.LoadOrder) shl 24) or Cardinal(j), True];
          if not Assigned(NewRecord) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': New Record with FormID "'+s+'" was not found in new Master "'+NewMaster.FileName+'".');
            Continue;
          end;

          if OldRecord.Equals(NewRecord) then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old and new Record are identical".');
            Continue;
          end;

          s := Trim(Line[0]);
          if not SameText(OldRecord.Signature, s) then
            AddMessage('Warning line '+IntToStr(i+1)+': Old Record do not have expected Signature ("'+OldRecord.Signature+'" vs. "'+s+'")".');
          if not SameText(NewRecord.Signature, s) then
            AddMessage('Warning line '+IntToStr(i+1)+': New Record do not have expected Signature ("'+NewRecord.Signature+'" vs. "'+s+'")".');

          s := Trim(Line[3]);
          if not SameText(OldRecord.EditorID, s) then
            AddMessage('Warning line '+IntToStr(i+1)+': Old Record does not have expected EditorID ("'+OldRecord.EditorID+'" vs. "'+s+'")".');

          s := Trim(Line[4]);
          if not SameText(NewRecord.EditorID, s) then
            AddMessage('Warning line '+IntToStr(i+1)+': New Record does not have expected EditorID ("'+NewRecord.EditorID+'" vs. "'+s+'")".');

          ReferencedBy := nil;
          SetLength(ReferencedBy, OldRecord.ReferencedByCount);
          k := 0;

          for j := 0 to Pred(OldRecord.ReferencedByCount) do begin
            RefRecord := OldRecord.ReferencedBy[j];
            if _File.Equals(RefRecord._File) then begin
              ReferencedBy[k] := RefRecord;
              Inc(k);
            end;
          end;

          SetLength(ReferencedBy, k);

          if k < 1 then begin
            AddMessage('Skipping line '+IntToStr(i+1)+': Old Record "'+OldRecord.Name+'" is not referenced by any record in file "'+_File.Name+'".');
            Continue;
          end;

          with ReplaceList[l] do begin
            rlOldRecord := OldRecord;
            rlNewRecord := NewRecord;
            rlReferencedBy := ReferencedBy;
            OldRecord := nil;
            NewRecord := nil;
            RefRecord := nil;
            ReferencedBy := nil;
          end;
          Inc(l);

          if not NewMaster.Equals(_File) then
            if not NewMasters.Find(NewMaster._File.FileName, k) then
              NewMasters.AddObject(NewMaster._File.FileName, Pointer(NewMaster._File));
        end;
      finally
        FreeAndNil(Line);
      end;
    finally
      FreeAndNil(CSV);
    end;
    SetLength(ReplaceList, l);

    if l > 0 then
      if not EditWarn then
        Exit;

    if AddRequiredMasters(NewMasters, _File) then
      for i := 0 to Pred(l) do with ReplaceList[i] do begin
        ShowChangeReferencedBy(rlOldRecord.LoadOrderFormID, rlNewRecord.LoadOrderFormID, rlReferencedBy, True);
        RefRecord := _File.RecordByFormID[rlOldRecord.LoadOrderFormID, False];
        if Assigned(RefRecord) and _File.Equals(RefRecord._File) then begin
          AddMessage('Changing FormID ['+IntToHex64(RefRecord.LoadOrderFormID, 8)+'] to ['+IntToHex(rlNewRecord.LoadOrderFormID, 8)+']');
          RefRecord.LoadOrderFormID := rlNewRecord.LoadOrderFormID;
        end;
      end;
  finally
    NewMasters.Free;
  end;
end;

procedure TfrmMain.mniNavBuildReachableClick(Sender: TObject);
var
  i     : Integer;
  _File : IwbFile;
begin
  wbStartTime := Now;
  pgMain.ActivePage := tbsMessages;
  ReachableBuild := True;

  Enabled := False;
  try
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      if not (csRefsBuild in _File.ContainerStates) then begin
        wbCurrentAction := 'Building reference information for ' + _File.Name;
        AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] ' + wbCurrentAction);
        Application.ProcessMessages;
        _File.BuildRef;
      end;
      _File.ResetReachable;
    end;
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      wbCurrentAction := 'Building reachable information for ' + _File.Name;
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] ' + wbCurrentAction);
      Application.ProcessMessages;
      _File.BuildReachable;
    end;
    AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] All done!');
  finally
    wbCurrentAction := '';
    Caption := Application.Title;
    Enabled := True;
  end;
end;

procedure TfrmMain.mniNavBuildRefClick(Sender: TObject);
var
  i                           : Integer;
  _File                       : IwbFile;
  //  wbStartTime                   : TDateTime;
begin
  with TfrmFileSelect.Create(nil) do try
    Caption := 'Build reference information for:';

    for i := Low(Files) to High(Files) do
      if not (csRefsBuild in Files[i].ContainerStates) then
        CheckListBox1.AddItem(Files[i].FileName, Pointer(Files[i]));
    CheckListBox1.Sorted := True;

    if CheckListBox1.Count = 0 then begin
      ShowMessage('There are no files without reference information');
      Exit;
    end;

    ShowModal;

    wbStartTime := Now;

    Application.ProcessMessages;

    Enabled := False;
    try
      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then begin
          pgMain.ActivePage := tbsMessages;
          _File := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));
          wbCurrentAction := 'Building reference information for ' + _File.Name;
          AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] ' + wbCurrentAction);
          Application.ProcessMessages;
          _File.BuildRef;
        end;
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] All done!');
    finally
      wbCurrentAction := '';
      Caption := Application.Title;
      Enabled := True;
    end;

  finally
    Free;
  end;
end;

procedure TfrmMain.mniNavCellChild(Sender: TObject);
var
  SelectedNodes               : TNodeArray;
  CellNodes                   : TNodeArray;
  Node                        : PVirtualNode;
  NodeData                    : PNavNodeData;
  MainRecords                 : array of IwbMainRecord;
  MainRecord                  : IwbMainRecord;
  i, j ,k                     : Integer;
  FoundIt                     : Boolean;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  SelectedNodes := vstNav.GetSortedSelection(True);
  if Length(SelectedNodes) < 1 then
    Exit;

  CellNodes := nil;
  k := 0;
  SetLength(MainRecords, Length(SelectedNodes));
  for i := Low(SelectedNodes) to High(SelectedNodes) do begin
    Node := SelectedNodes[i];
    NodeData := vstNav.GetNodeData(Node);
    if not Assigned(NodeData) then
      Continue;
    if not Supports(NodeData.Element, IwbMainRecord, MainRecords[k]) then
      Continue;
    if (MainRecords[k].Signature <> 'REFR') then
      Continue;

    Inc(k);

    if Node = vstNav.RootNode then
      Continue;
    Node := Node.Parent;
    if Node = vstNav.RootNode then
      Continue;
    Node := Node.Parent;
    if Node = vstNav.RootNode then
      Continue;
    NodeData := vstNav.GetNodeData(Node);
    if not Assigned(NodeData) then
      Continue;
    if not Supports(NodeData.Element, IwbMainRecord, MainRecord) then
      Continue;
    if MainRecord.Signature <> 'CELL' then
      Continue;

    FoundIt := False;
    for j := Low(CellNodes) to High(CellNodes) do
      if CellNodes[j] = Node then begin
        FoundIt := True;
        Break;
      end;
    if FoundIt then
      Continue;
    SetLength(CellNodes, Succ(Length(CellNodes)));
    CellNodes[High(CellNodes)] := Node;
  end;
  SetLength(MainRecords, k);

  for i := Low(MainRecords) to High(MainRecords) do begin
    MainRecord := MainRecords[i];
    if Sender = mniNavCellChildTemp then
      MainRecord.IsPersistent := False
    else if Sender = mniNavCellChildPers then
      MainRecord.IsPersistent := True
    else if Sender = mniNavCellChildNotVWD then
      MainRecord.IsVisibleWhenDistant := False
    else if Sender = mniNavCellChildVWD then
      MainRecord.IsVisibleWhenDistant := True;
  end;

  vstNav.ClearSelection;
  vstNav.BeginUpdate;
  try
    InvalidateElementsTreeView(SelectedNodes);
    SelectedNodes := nil;
    for i := Low(CellNodes) to High(CellNodes) do begin
      vstNav.Expanded[CellNodes[i]] := False;
      vstNav.FullExpand(CellNodes[i]);
    end;
    for i := Low(MainRecords) to High(MainRecords) do begin
      Node := FindNodeForElement(MainRecords[i]);
      if not Assigned(Node) then
        Continue;
      vstNav.FocusedNode := Node;
      vstNav.Selected[Node] := True;
    end;
    SelectedNodes := vstNav.GetSortedSelection(True);
    if Length(SelectedNodes) < 1 then
      Exit;
    vstNav.FocusedNode := SelectedNodes[0];
  finally
    vstNav.EndUpdate;
  end;
end;

procedure TfrmMain.mniNavChangeFormIDClick(Sender: TObject);
var
  s                           : string;
  i, j                        : Integer;
  NewFormID                   : Cardinal;
  OldFormID                   : Cardinal;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  ReferencedBy                : TDynMainRecords;
  Nodes                       : TNodeArray;
//  NewFileID                   : Integer;
  OldFileID                   : Integer;
  AnyErrors                   : Boolean;
  Master                      : IwbMainRecord;
  _File                       : IwbFile;
  FoundNone                   : Boolean;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  AnyErrors := False;
  _File := nil;
//  NewFileID := -1;
  NewFormID := 0;
  Nodes := vstNav.GetSortedSelection(True);
  if Length(Nodes)>1 then begin
    NodeData := vstNav.GetNodeData(Nodes[0]);
    if not Assigned(NodeData) then
      Exit;
    if not Assigned(NodeData.Element) then
      Exit;

    if not EditWarn then
      Exit;

    with TfrmFileSelect.Create(Self) do try

      Caption := 'Select a single target file';

      _File := NodeData.Element._File;

      for i := 0 to Pred(_File.MasterCount) do
        CheckListBox1.AddItem(_File.Masters[i].Name, Pointer(_File.Masters[i]));

      CheckListBox1.AddItem(_File.Name, Pointer(_File));

      repeat
        ShowModal;

        _File := nil;

        FoundNone := True;
        for i := 0 to Pred(CheckListBox1.Count) do
          if CheckListBox1.Checked[i] then begin
            FoundNone := False;
            if Assigned(_File) then begin
              ShowMessage('Please select only a single target file.');
              _File := nil;
              Break;
            end;
            _File := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));
          end;
        if FoundNone then
          Exit;
      until Assigned(_File);
    finally
      Free;
    end;
{
    s := IntToHex64(NodeData.Element._File.LoadOrder, 2);
    if not InputQuery('New FileID', 'Please enter the load order of the file which '+
      'these records should be attributed to in hex. e.g. 1C.'#13#13 +
      'All selected records which currently have a FormID starting with a different file number '+
      'will be changed and all references to these records will be automatically updated.', s) then
      Exit;
    NewFileID := StrToInt64('$'+s);

    if (NewFileID < Low(Files)) or (NewFileID > High(Files)) then
      raise Exception.Create('This is not a valid load order number');
    NodeData.Element._File.LoadOrderFormIDtoFileFormID(Cardinal(NewFileID) shl 24);
}
  end;

  for j := Low(Nodes) to High(Nodes) do begin
    NodeData := vstNav.GetNodeData(Nodes[j]);
    if not Assigned(NodeData) then
      Continue;
    if not Assigned(NodeData.Element) then
      Continue;
    if not Supports(NodeData.Element, IwbMainRecord, MainRecord) then
      Continue;

    OldFormID := MainRecord.LoadOrderFormID;
    if not Assigned(_File) then begin

      s := IntToHex64(OldFormID, 8);
      if InputQuery('New FormID', 'Please enter the new FormID in hex. e.g. 0404CC43. The FormID needs to be a load order corrected form ID.', s) then begin

        if s = '' then begin
          s := IntToHex64(MainRecord._File.FileFormIDtoLoadOrderFormID(MainRecord._File.NewFormID), 8);
          if not InputQuery('New FormID generated', 'Please verify the newly generated FormID. The FormID needs to be a load order corrected form ID.', s) then
            Exit;
        end;
        NewFormID := StrToInt64('$' + s);
        if NewFormID = 0 then
          raise Exception.Create('00000000 is not a valid FormID');
        if NewFormID = $14 then
          raise Exception.Create('00000014 is not a valid FormID');
      end else
        Exit;

    end else begin

      OldFileID := OldFormID shr 24;
      if OldFileID = _File.LoadOrder then
        Continue;
      NewFormID := _File.FileFormIDtoLoadOrderFormID(_File.NewFormID);
    end;

    if NewFormID = OldFormID then
      Continue;

    pgMain.ActivePage := tbsMessages;

    AddMessage('Changing FormID ['+IntToHex64(OldFormID, 8)+'] in file "'+MainRecord._File.FileName+'" to ['+IntToHex(NewFormID, 8)+']');

    Master := MainRecord.MasterOrSelf;
    SetLength(ReferencedBy, Master.ReferencedByCount);
    for i := 0 to Pred(Master.ReferencedByCount) do
      ReferencedBy[i] := Master.ReferencedBy[i];

    AddMessage('Record is referenced by '+IntToStr(Length(ReferencedBy))+' other record(s)');
    try
      MainRecord.LoadOrderFormID := NewFormID;

      NodeData.ConflictAll := caUnknown;
      NodeData.ConflictThis := ctUnknown;
      NodeData.Flags := [];
      vstNav.InvalidateNode(vstNav.FocusedNode);

      if Length(ReferencedBy) > 0 then
        ShowChangeReferencedBy(OldFormID, NewFormID, ReferencedBy, Assigned(_File) );
    except
      on E: Exception do begin
        AddMessage('Error: ' + E.Message);
        AnyErrors := True;
      end;
    end;
  end;
  if AnyErrors then begin
    pgMain.ActivePage := tbsMessages;
    AddMessage('!!! Errors have occured. It is highly recommended to exit without saving as partial changes might have occured !!!');
  end;
end;

procedure TfrmMain.mniViewEditClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  EditValue                   : string;
//  StringDef                   : IwbStringDef;
  IntegerDef                  : IwbIntegerDef;
  Flags                       : IwbFlagsDef;
  i, StringID                 : Integer;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin
      if not EditWarn then
        Exit;

      EditValue := Element.EditValue;

      // flags editor
      if Supports(Element.Def, IwbIntegerDef, IntegerDef) and Supports(IntegerDef.Formater, IwbFlagsDef, Flags) then begin

        with TfrmFileSelect.Create(Self) do try
          Caption := 'Edit Value';

          for i := 0 to Pred(Flags.FlagCount) do begin
            CheckListBox1.AddItem(Flags.Flags[i], nil);
            CheckListBox1.Checked[i] := (i < Length(EditValue)) and (EditValue[i+1] = '1');
          end;
          ShowModal;
          EditValue := StringOfChar('0', CheckListBox1.Items.Count);
          for i := 0 to Pred(CheckListBox1.Items.Count) do begin
            if CheckListBox1.Checked[i] then
              EditValue[i+1] := '1';
          end;

        finally
          Free;
        end;

      end

      // localization editor
      else if Element._File.IsLocalized and Assigned(Element.ValueDef) and (Element.ValueDef.DefType = dtLString) then begin
        with TfrmLocalization.Create(Self) do try
          wbLocalizationHandler.NoTranslate := true;
          StringID := StrToInt64Def('$' + Element.Value, 0);
          wbLocalizationHandler.NoTranslate := false;
          EditValue(Element._File.FileName, StringID);
          ShowModal;
        finally
          wbLocalizationHandler.NoTranslate := false;
          Free;
        end;
        vstView.Invalidate;
        Exit;
      end

      // string editor
      else if not InputQuery('Edit Value', 'Please change the value:', EditValue) then
        Exit;

      Element.EditValue := EditValue;
      ActiveRecords[Pred(vstView.FocusedColumn)].UpdateRefs;
      Element := nil;
      PostResetActiveTree;
      InvalidateElementsTreeView(NoNodes);
    end;
  end;
end;

procedure TfrmMain.mniViewHeaderCopyIntoClick(Sender: TObject);
var
  Column                      : TColumnIndex;
  MainRecord                  : IwbMainRecord;
  MainRecord2                 : IwbMainRecord;
  Master                      : IwbMainRecord;
  ReferenceFile               : IwbFile;
  sl                          : TStringList;
  i, j                        : Integer;
  AsNew                       : Boolean;
  AsWrapper                   : Boolean;
  EditorID                    : string;
  LeveledListEntries          : IwbContainerElementRef;
  LeveledListEntry            : IwbContainerElementRef;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  AsNew := Sender = mniViewHeaderCopyAsNewRecord;
  AsWrapper := Sender = mniViewHeaderCopyAsWrapper;

  Column := vstView.Header.Columns.PopupIndex;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  if not Supports(ActiveRecords[Column].Element, IwbMainRecord, MainRecord) then
    Exit;

  ReferenceFile := MainRecord.ReferenceFile;
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    MainRecord.ReportRequiredMasters(sl, AsNew);

    j := ReferenceFile.LoadOrder;
    for i := 0 to Pred(sl.Count) do
      with IwbFile(Pointer(sl.Objects[i])) do
        if LoadOrder > j then
          j := LoadOrder;

    with TfrmFileSelect.Create(Self) do try

      for i := j to High(Files) do
        if Files[i].IsEditable then
          CheckListBox1.AddItem(Files[i].Name, Pointer(Files[i]));

      Master := MainRecord.MasterOrSelf;

      if not (AsNew or AsWrapper) then begin
        j := CheckListBox1.Items.IndexOf(Master._File.Name);
        if j >= 0 then
          CheckListBox1.Items.Delete(j);

        for i := 0 to Pred(Master.OverrideCount) do begin
          j := CheckListBox1.Items.IndexOf(Master.Overrides[i]._File.Name);
          if j >= 0 then
            CheckListBox1.Items.Delete(j);
        end;
      end
      else begin
        EditorID := MainRecord.EditorID;
        repeat
          if AsWrapper then begin
            if not InputQuery('EditorID', 'Please enter the EditorID for the wrapped copy', EditorID) then
              Exit;
          end
          else begin
            if not InputQuery('EditorID', 'Please change the EditorID', EditorID) then
              Exit;
          end;
          if EditorID = '' then
            Break;
          if not SameText(EditorID, MainRecord.EditorID) then
            Break;
          if AsWrapper then begin
            ShowMessage('You need to specify a different EditorID for the wrapped copy.');
          end
          else begin
            if MessageDlg('Are you sure you don''t want to change the EditorID?' +
              ' EditorID conflicts will cause error messages in CS when loading.',
              mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
              Break;
          end;
        until False;
      end;

      CheckListBox1.AddItem('<new file>', nil);

      Caption := 'Which files do you want to add this record to?';

      ShowModal;

      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then begin
          ReferenceFile := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));

          while not Assigned(ReferenceFile) do
            if not AddNewFile(ReferenceFile) then
              Break;

          if Assigned(ReferenceFile) and AddRequiredMasters(MainRecord, ReferenceFile, AsNew) then begin
            MainRecord2 := wbCopyElementToFile(MainRecord, ReferenceFile, AsNew or AsWrapper, True, '', '', '') as IwbMainRecord;
            Assert(Assigned(MainRecord2));
            if AsNew or AsWrapper then
              MainRecord2.EditorID := EditorID;
            if AsWrapper then begin
              EditorID := MainRecord.EditorID;
              MainRecord := wbCopyElementToFile(MainRecord, ReferenceFile, False, False, '', '', '') as IwbMainRecord;
              Assert(Assigned(MainRecord));
              MainRecord.Assign(Low(Integer), nil, False);
              LeveledListEntries := MainRecord.ElementByName['Leveled List Entries'] as IwbContainerElementRef;
              Assert(Assigned(LeveledListEntries));
              Assert(LeveledListEntries.ElementCount = 1);
              LeveledListEntry := LeveledListEntries.Elements[0] as IwbContainerElementRef;
              Assert(Assigned(LeveledListEntry));
              LeveledListEntry.ElementByName['Reference'].EditValue := MainRecord2.EditValue;
              LeveledListEntry.ElementByName['Count'].EditValue := '1';
              LeveledListEntry.ElementByName['Level'].EditValue := '1';
              MainRecord.EditorID := EditorID;
            end;
          end;
        end;

      Master.ResetConflict;
    finally
      Free;
    end;

  finally
    sl.Free;
  end;

  PostResetActiveTree;
  InvalidateElementsTreeView(NoNodes);
end;

procedure TfrmMain.mniViewHeaderHiddenClick(Sender: TObject);
var
  Column                      : TColumnIndex;
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
begin
  Column := vstView.Header.Columns.PopupIndex;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  Element := ActiveRecords[Column].Element;
  if not Supports(Element, IwbMainRecord, MainRecord) then
    Exit;
  if mniViewHeaderHidden.Checked then
    MainRecord.Hide
  else
    MainRecord.Show;
  PostResetActiveTree;
  InvalidateElementsTreeView(NoNodes);
end;

procedure TfrmMain.mniViewHeaderJumpToClick(Sender: TObject);
var
  Column                      : TColumnIndex;
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
begin
  Column := vstView.Header.Columns.PopupIndex;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  Element := ActiveRecords[Column].Element;
  if not Supports(Element, IwbMainRecord, MainRecord) then
    Exit;
  JumpTo(MainRecord, True);
end;

procedure TfrmMain.mniViewHeaderRemoveClick(Sender: TObject);
var
  Column                      : TColumnIndex;
  NodeData                    : PNavNodeData;
  Node                        : PVirtualNode;
  Element                     : IwbElement;
  DialogResult                : Integer;
  MainRecord                  : IwbMainRecord;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  Column := vstView.Header.Columns.PopupIndex;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  Element := ActiveRecords[Column].Element;
  if not Supports(Element, IwbMainRecord, MainRecord) then
    Exit;

  if not EditWarn then
    Exit;

  DialogResult := MessageDlg('Are you sure you want to permanently remove ' + Element.Name + ' from file "' + Element._File.FileName + '"?', mtConfirmation, [mbYes, mbNo], 0);

  if DialogResult <> mrYes then
    Exit;

  CheckHistoryRemove(BackHistory, MainRecord);
  CheckHistoryRemove(ForwardHistory, MainRecord);

  Node := FindNodeForElement(Element);
  NodeData := vstNav.GetNodeData(Node);

  if Assigned(NodeData) then begin
    if Element.Equals(NodeData.Container) then
      NodeData.Container := nil;
    if Assigned(NodeData.Container) then
      NodeData.Container.Remove;
  end;
  Element.Remove;
  if Assigned(NodeData) then begin
    NodeData.Element := nil;
    NodeData.Container := nil;
  end;

  MainRecord := ActiveRecord;
  if Element.Equals(MainRecord) then
    MainRecord := nil;
  SetActiveRecord(nil);

  Element := nil;

  if Assigned(Node) then
    vstNav.DeleteNode(Node, False);

  SetActiveRecord(MainRecord);
  InvalidateElementsTreeView(NoNodes);
end;

procedure TfrmMain.mniNavGenerateObjectLODClick(Sender: TObject);
var
  Selection   : TNodeArray;
  i, j        : Integer;
  NodeData    : PNavNodeData;
  _File       : IwbFile;
  Group       : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Worldspaces : TDynMainRecords;
begin
  Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;

  Worldspaces := nil;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Supports(NodeData.Element, IwbFile, _File) then begin
      if Supports(_File.GroupBySignature['WRLD'], IwbContainerElementRef, Group) then begin
        for j := 0 to Pred(Group.ElementCount) do
          if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then begin
            if Mainrecord.Signature = 'WRLD' then begin
              SetLength(Worldspaces, Succ(Length(Worldspaces)));
              Worldspaces[High(Worldspaces)] := MainRecord;
            end;
          end;
      end;
    end;
  end;

  if Length(WorldSpaces) > 1 then begin
    QuickSort(@WorldSpaces[0], Low(WorldSpaces), High(WorldSpaces), CompareElementsFormIDAndLoadOrder);

    j := 0;
    for i := Succ(Low(WorldSpaces)) to High(WorldSpaces) do begin
      if WorldSpaces[j].LoadOrderFormID <> WorldSpaces[i].LoadOrderFormID then
        Inc(j);
      if j <> i then
        WorldSpaces[j] := WorldSpaces[i];
    end;
    SetLength(WorldSpaces, Succ(j));
  end;

  if Length(Worldspaces) = 0 then
    Exit;

  with TfrmFileSelect.Create(Self) do try
    for i := Low(WorldSpaces) to High(WorldSpaces) do
      CheckListBox1.AddItem(WorldSpaces[i].Name, TObject(Integer(WorldSpaces[i])));
    CheckListBox1.Sorted := True;
    Caption := 'Select Worldspaces';
    ShowModal;

    wbStartTime := Now;
    Self.Enabled := False;
    try
      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then
          GenerateLOD(IwbMainRecord(Integer(CheckListBox1.Items.Objects[i])));
    finally
      Self.Enabled := True;
      Self.Caption := Application.Title
    end;
  finally
    Free;
  end;
end;

procedure TfrmMain.mniNavRaceLVLIsClick(Sender: TObject);
var
  LVLIs       : TStringList;
  i, j, k, l  : Integer;
  Group       : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  MainRecord2 : IwbMainRecord;
  Container   : IwbContainerElementRef;
  Container2  : IwbContainerElementRef;
  Race        : string;
  FormID      : Cardinal;
begin
  LVLIs := TStringList.Create;
  LVLIs.Sorted := True;
  LVLIs.Duplicates := dupIgnore;

  for i := Low(Files) to High(Files) do
    if Supports(Files[i].GroupBySignature['LVLI'], IwbContainerElementRef, Group) then
      for j := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then
          if MainRecord.IsMaster and (MainRecord.EditorID <> '') then
            LVLIs.AddObject(MainRecord.EditorID, Pointer(MainRecord.LoadOrderFormID));

  for i := Low(Files) to High(Files) do
    if Supports(Files[i].GroupBySignature['NPC_'], IwbContainerElementRef, Group) then
      for j := 0 to Pred(Group.ElementCount) do
        if Supports(Group.Elements[j], IwbMainRecord, MainRecord) then begin

          Race := '';
          if Supports(MainRecord.RecordBySignature['RNAM'], IwbContainerElementRef, Container) then
            if Supports(Container.LinksTo, IwbMainRecord, MainRecord2) then
              Race := MainRecord2.EditorID;

          if Race = '' then
            Continue;

          if Supports(MainRecord.ElementByName['Items'], IwbContainerElementRef, Container) then
            for k := 0 to Pred(Container.ElementCount) do
              if Supports(Container.Elements[k], IwbContainerElementRef, Container2) then
                if Container2.ElementCount = 2 then begin
                  if Supports(Container2.Elements[0].LinksTo, IwbMainRecord, MainRecord2) then begin
                    if MainRecord2.Signature = 'LVLI' then
                      if LVLIs.Find(MainRecord2.EditorID+Race, l) then begin
                        FormID := Cardinal(LVLIs.Objects[l]);
                        if Integer(FormID shr 24) <= Files[i].LoadOrder then try
                          Container2.Elements[0].EditValue := IntToHex64(FormID, 8);
                        except
                          on E: Exception do
                            PostAddMessage('Error updating Item '+MainRecord2.Name+' for '+MainRecord.Name+': '+ E.Message);
                        end;
                      end;
                  end;
                end;
        end;
end;

procedure TfrmMain.mniNavRemoveClick(Sender: TObject);
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  DialogResult                : Integer;
  MainRecord                  : IwbMainRecord;
  Selection                   : TNodeArray;
  i                           : Integer;
  ContainsChilds              : Boolean;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := RemoveableSelection(@ContainsChilds);

  if Length(Selection) < 1 then
    Exit;

  if not EditWarn then
    Exit;

  if Length(Selection) = 1 then begin
    NodeData := vstNav.GetNodeData(Selection[0]);
    Element := NodeData.Element;
    if ContainsChilds then
      DialogResult := MessageDlg('Are you sure you want to permanently remove ' + Element.Name + ' and all other records it contains?', mtWarning, [mbYes, mbNo], 0)
    else
      DialogResult := MessageDlg('Are you sure you want to permanently remove ' + Element.Name + '?', mtConfirmation, [mbYes, mbNo], 0);
  end
  else begin
    if ContainsChilds then
      DialogResult := MessageDlg('Are you sure you want to permanently remove the ' + IntToStr(Length(Selection)) + ' removeable selected records and all other records they contain?', mtWarning, [mbYes, mbNo], 0)
    else
      DialogResult := MessageDlg('Are you sure you want to permanently remove the ' + IntToStr(Length(Selection)) + ' removeable selected records?', mtConfirmation, [mbYes, mbNo], 0);
  end;

  if DialogResult <> mrYes then
    Exit;

  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    Element := NodeData.Element;

    if Supports(Element, IwbMainRecord, MainRecord) then begin
      CheckHistoryRemove(BackHistory, MainRecord);
      CheckHistoryRemove(ForwardHistory, MainRecord);
    end;

    SetActiveRecord(nil);
    if Element.Equals(NodeData.Container) then
      NodeData.Container := nil;
    if Assigned(NodeData.Container) then
      NodeData.Container.Remove;
    Element.Remove;
    NodeData.Element := nil;
    NodeData.Container := nil;
    Element := nil;
    vstNav.DeleteNode(Selection[i], False);
  end;
  InvalidateElementsTreeView(NoNodes);
end;

function IsExterior(aElement: IwbElement): Boolean;
var
  GroupRecord: IwbGroupRecord;
begin
  Result := False;
  if not Assigned(aElement) then
    Exit;
  if Supports(aElement, IwbGroupRecord, GroupRecord) then
    case GroupRecord.GroupType of
      0: begin
        Result := TwbSignature(GroupRecord.GroupLabel) = 'WRLD';
        Exit;
      end;
      1, 4, 5: begin
        Result := True;
        Exit;
      end;
      2, 3: Exit;
    end;
  Result := IsExterior(aElement.Container);
end;

procedure TfrmMain.mniNavSetVWDAutoClick(Sender: TObject);
const
  sJustWait                   = 'Setting VWD for all REFR with VWD Mesh. Please wait...';
var
  Selection                   : TNodeArray;
  StartNode, Node, NextNode   : PVirtualNode;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  MainRecord2                 : IwbMainRecord;
  NameRec                     : IwbContainerElementRef;
  Count                       : Cardinal;
  ChangeCount                 : Cardinal;
  StartTick                   : Cardinal;
  i                           : Integer;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := vstNav.GetSortedSelection(True);

  if Length(Selection) < 1 then
    Exit;

  if not EditWarn then
    Exit;

  vstNav.BeginUpdate;
  try
    StartTick := GetTickCount;
    wbStartTime := Now;

    Enabled := False;

    ChangeCount := 0;
    Count := 0;
    for i := Low(Selection) to High(Selection) do try
      StartNode := Selection[i];
      if Assigned(StartNode) then
        Node := vstNav.GetLast(StartNode)
      else
        Node := nil;

      while Assigned(Node) do begin
        NextNode := vstNav.GetPrevious(Node);
        NodeData := vstNav.GetNodeData(Node);

        if Supports(NodeData.Element, IwbMainRecord, MainRecord) and
          (MainRecord.Signature = 'REFR') and
          not MainRecord.IsVisibleWhenDistant and
          IsExterior(MainRecord) and
          Supports(MainRecord.RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
          Supports(NameRec.LinksTo, IwbMainRecord, MainRecord2) and
          MainRecord2.HasVisibleWhenDistantMesh then begin

          if not MainRecord.IsEditable then
            AddMessage('Can''t change: ' + MainRecord.Name)
          else begin
            AddMessage('Setting VWD: ' + MainRecord.Name);
            MainRecord.IsVisibleWhenDistant := True;
            Inc(ChangeCount);
            vstNav.DeleteNode(Node, False);
          end;

        end;

        Node := NextNode;
        Inc(Count);
        if StartTick + 500 < GetTickCount then begin
          Caption := sJustWait + ' Processed Records: ' + IntToStr(Count) +
            ' Change Records: ' + IntToStr(ChangeCount) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
        if Node = StartNode then
          Node := nil;
      end;

    finally
      Enabled := True;
    end;

    AddMessage('[Setting VWD for all REFR with VWD Mesh] ' + ' Processed Records: ' + IntToStr(Count) +
      ' Change Records: ' + IntToStr(ChangeCount) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime));
    vstNav.Invalidate;
  finally
    vstNav.EndUpdate;
    Caption := Application.Title;
  end;
end;

procedure SetVWDCallback(const aElement: IwbElement);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(aElement, IwbMainRecord, MainRecord) then
    MainRecord.IsVisibleWhenDistant := True;
end;

procedure TfrmMain.mniNavSetVWDAutoIntoClick(Sender: TObject);
const
  sJustWaitScan               = 'Scanning for REFR without VWD Flag but with VWD Mesh. Please wait...';
var
  Selection                   : TNodeArray;
  StartNode, Node, NextNode   : PVirtualNode;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  MainRecord2                 : IwbMainRecord;
  NameRec                     : IwbContainerElementRef;
  i,j                         : Integer;
  Elements                    : TDynElements;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := vstNav.GetSortedSelection(True);

  if Length(Selection) < 1 then
    Exit;

  if not EditWarn then
    Exit;

  vstNav.BeginUpdate;
  try
    Caption := sJustWaitScan;

    wbStartTime := Now;

    Enabled := False;
    j := 0;
    Elements := nil;
    SetLength(Elements, 1024);
    try
      for i := Low(Selection) to High(Selection) do begin
        StartNode := Selection[i];
        if Assigned(StartNode) then
          Node := vstNav.GetLast(StartNode)
        else
          Node := nil;

        while Assigned(Node) do begin
          NextNode := vstNav.GetPrevious(Node);
          NodeData := vstNav.GetNodeData(Node);

          if Supports(NodeData.Element, IwbMainRecord, MainRecord) and
            (MainRecord.Signature = 'REFR') and IsExterior(MainRecord) then begin

              if j > High(Elements) then
                SetLength(Elements, Length(Elements)*2);
              Elements[j] := MainRecord;
              Inc(j);

            end;

          Node := NextNode;
          if Node = StartNode then
            Node := nil;
        end;
      end;
    finally
      Enabled := True;
    end;

    SetLength(Elements, j);

    if Length(Elements) > 1 then begin
      QuickSort(@Elements[0], Low(Elements), High(Elements), CompareElementsFormIDAndLoadOrder);

      j := 0;
      for i := Succ(Low(Elements)) to High(Elements) do begin
        if (Elements[j] as IwbMainRecord).LoadOrderFormID <> (Elements[i] as IwbMainRecord).LoadOrderFormID then
          Inc(j);
        if j <> i then
          Elements[j] := Elements[i];
      end;
      SetLength(Elements, Succ(j));
    end;

    if Length(Elements) > 0 then begin

      j := 0;
      for i := Low(Elements) to High(Elements) do begin
        MainRecord := Elements[i] as IwbMainRecord;
        if not MainRecord.IsVisibleWhenDistant and
          Supports(MainRecord.RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
          Supports(NameRec.LinksTo, IwbMainRecord, MainRecord2) and
          MainRecord2.HasVisibleWhenDistantMesh then begin

          if MainRecord.HasErrors then
            AddMessage('[Setting VWD for all REFR with VWD Mesh] Skipping: ' + MainRecord.Name)
          else begin
            if j <> i then
              Elements[j] := Elements[i];
            Inc(j);
          end;

        end;
      end;
      SetLength(Elements, j);

    end;

    if Length(Elements) > 0 then
      CopyInto(False, False, False, False, Elements, SetVWDCallback);

    vstNav.Invalidate;
  finally
    vstNav.EndUpdate;
    Caption := Application.Title;
  end;
end;

procedure TfrmMain.mniNavSortMastersClick(Sender: TObject);
var
  Nodes                       : TNodeArray;
  NodeData                    : PNavNodeData;
  _File                       : IwbFile;
  i                           : Integer;
begin
  UserWasActive := True;

  Nodes := vstNav.GetSortedSelection(True);
  for i := Low(Nodes) to High(Nodes) do begin
    NodeData := vstNav.GetNodeData(Nodes[i]);
    if Assigned(NodeData) and Supports(NodeData.Element, IwbFile, _File) then
      if _File.IsEditable then
        _File.SortMasters;
  end;
end;
{
procedure TfrmMain.mniNavTestClick(Sender: TObject);
var
  MainRecord : IwbMainRecord;
  AddOnsList : TDynMainRecords;

  Kits       : TDynMainRecords;
  FromWeapon : TDynMainRecords;
  ToWeapon   : TDynMainRecords;
  KitConfigs : TDynMainRecords;

  i          : Integer;
begin
  MainRecord := wbFindWinningMainRecordByEditorID('FLST', 'FO3EditAddOnsOrderedList');
  if not Assigned(MainRecord) then
    raise Exception.Create('Can''t find FO3EditAddOnsOrderedList');

  AddOnsList := wbFormListToArray(MainRecord, 'FLST');
  if Length(AddOnsList) <> 3 then
    raise Exception.Create('FO3EditAddOnsOrderedList must have exactly 3 entries of type FLST');

  Kits := wbFormListToArray(AddOnsList[0], 'MISC');
  FromWeapon := wbFormListToArray(AddOnsList[1], 'FLST');
  ToWeapon := wbFormListToArray(AddOnsList[2], 'FLST');

  if (Length(Kits) <> Length(FromWeapon)) or (Length(Kits) <> Length(ToWeapon)) then
    raise Exception.Create('The 3 FormLists from FO3EditAddOnsOrderedList must have the same number of entries');

  SetLength(KitConfigs, Length(Kits));
  for i := Low(Kits) to High(Kits) do begin
    KitConfigs[i] := wbFindWinningMainRecordByEditorID('BOOK', 'FO3EditAddOns' + Kits[i].EditorID + 'Config');
    if not Assigned(KitConfigs[i]) then
      raise Exception.Create('Could not find the Config record for ' + Kits[i].EditorID);
  end;

  //!!!
end;
}
{
procedure TfrmMain.mniNavTestClick(Sender: TObject);
var
  Group: IwbGroupRecord;
  GroupSP: IwbGroupRecord;
  i: Integer;
  MainRecord: IwbMainRecord;
  MainRecordSP: IwbMainRecord;
  sl : TStringList;
begin
  sl := TStringList.Create;
  Group := Files[0].GroupBySignature['STAT'];
  GroupSP := Files[2].GroupBySignature['MSTT'];
  for i := 0 to Pred(GroupSP.ElementCount) do
    if Supports(GroupSP.Elements[i], IwbMainRecord, MainRecordSP) then begin
      MainRecord := Group.MainRecordByEditorID[Copy(MainRecordSP.EditorID, 3, High(Integer))];
      if Assigned(MainRecord) then begin
        sl.Add('# ' + MainRecord.EditorID + ' -> ' + MainRecordSP.EditorID);
        sl.Add('MATCH REFR WHERE NAME = Fallout3.esm:' + IntToHex64(MainRecord.FormID and $FFFFFF, 6) );
        sl.Add('  SET NAME TO "SP_Destruction_MASTER.esm:'+IntToHex64(MainRecordSP.FormID and $FFFFFF, 6)+'"');
        sl.Add('END MATCH');
      end else
        sl.Add('# !!!' + MainRecordSP.EditorID + ' -> ' + MainRecord.EditorID + ' !!!');
      sl.Add('');
    end;
  sl.SaveToFile('D:\Program Files (x86)\Bethesda Softworks\Fallout 3\Data\SP_Destruction_MASTER.fo3editscript');
  sl.Free;

  sl := TStringList.Create;
  Group := Files[0].GroupBySignature['STAT'];
  GroupSP := Files[2].GroupBySignature['ACTI'];
  for i := 0 to Pred(GroupSP.ElementCount) do
    if Supports(GroupSP.Elements[i], IwbMainRecord, MainRecordSP) then begin
      MainRecord := Group.MainRecordByEditorID[Copy(MainRecordSP.EditorID, 3, High(Integer))];
      if Assigned(MainRecord) then begin
        sl.Add('# ' + MainRecord.EditorID + ' -> ' + MainRecordSP.EditorID);
        sl.Add('MATCH REFR WHERE NAME = Fallout3.esm:' + IntToHex64(MainRecord.FormID and $FFFFFF, 6) );
        sl.Add('  SET NAME TO "SP_Destruction_MASTER.esm:'+IntToHex64(MainRecordSP.FormID and $FFFFFF, 6)+'"');
        sl.Add('END MATCH');
      end else
        sl.Add('# !!! ' + MainRecordSP.EditorID+ ' !!!');
      sl.Add('');
    end;
  sl.SaveToFile('D:\Program Files (x86)\Bethesda Softworks\Fallout 3\Data\SP_Destruction - last - Lights.fo3editscript');
  sl.Free;
end;
}

procedure TfrmMain.mniNavTestClick(Sender: TObject);
var
  _File   : IwbFile;
  Records : array of IwbMainRecord;
  i {, j} : Integer;
  s       : string;
  Allowed : TStringList;
  Silent  : TStringList;
//  BaseRecord: IwbMainRecord;
//  FormID, FileID: Cardinal;
//  ContainerRef : IwbContainerElementRef;
begin
  _File := Files[2];
  SetLength(Records, _File.RecordCount);
  for i := low(Records) to high(Records) do
    Records[i] := _File.Records[i];

  {
  for i := low(Records) to high(Records) do begin
    FormID := Records[i].LoadOrderFormID;
    FileID := FormID shr 24;
    FormID := FormID and $00FFFFFF;
    if (FileID = 0) and (FormID <> 0) then begin
      FileID := 1;
      FileID := FileID shl 24;
      FormID := FormID or FileID;
      Records[i].LoadOrderFormID := FormID;
    end;
  end;
  }

  {
  for i := low(Records) to high(Records) do begin
    s := Records[i].Signature;
    if s = 'WRLD' then
      Continue;
    if s = 'CELL' then
      Continue;
    if s = 'LAND' then
      Continue;
    if s = 'REFR' then
      Continue;
    if s = 'TES4' then
      Continue;
    Records[i].Remove;
  end;
  }

  for i := low(Records) to high(Records) do begin
    s := Records[i].EditorID;
    if s <> '' then begin
      s := 'Hummer' + s;
      Records[i].EditorID := s;
    end;
  end;

  {
  for i := low(Records) to high(Records) do begin
    BaseRecord := Records[i].BaseRecord;
    if Assigned(BaseRecord) then begin
      s := BaseRecord.Signature;
      if s = 'IDLM' then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove
      end else if BaseRecord.FixedFormID < $800 then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end else if not BaseRecord.HasMesh then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end;
    end;
  end;
  }

  Allowed := TStringList.Create;
  Allowed.Sorted := True;
  Allowed.Add('DATA - Position/Rotation');
  Allowed.Add('NAME - Base');
  Allowed.Add('Record Header');
  Allowed.Add('Cell');
  Allowed.Add('XSCL - Scale');
  Allowed.Add('XRGD - Ragdoll Data');
  Allowed.Add('XEMI - Emittance');
  Allowed.Add('XSED - SpeedTree Seed');
  Allowed.Add('EDID - Editor ID');
  Allowed.Add('XESP - Enable Parent');

  Silent := TStringList.Create;
  Silent.Sorted := True;
  Silent.Add('Reflected/Refracted By');
  Silent.Add('XLOD - Distant LOD Data');
  Silent.Add('Ownership');
  Silent.Add('XNDP - Navigation Door Link');
  Silent.Add('XTEL - Teleport Destination');
  Silent.Add('XLOC - Lock Data');
  Silent.Add('XLKR - Linked Reference');
  Silent.Add('Patrol Data');
  Silent.Add('Activate Parents');
  Silent.Add('ONAM - Open by Default');
  Silent.Add('XACT - Action Flag');
  {
  for i := low(Records) to high(Records) do begin
    BaseRecord := Records[i].BaseRecord;
    if Assigned(BaseRecord) then begin
      s := BaseRecord.Signature;
      if s = 'WEAP' then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end else if s = 'ARMO' then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end else if s = 'AMMO' then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end else if s = 'TACT' then begin
        PostAddMessage('Removing: ' + Records[i].Name);
        Records[i].Remove;
      end
    end;
  end;}

  {
  for i := low(Records) to high(Records) do begin
    s := Records[i].Signature;
    if s = 'REFR' then
      if Supports(Records[i], IwbContainerElementRef, ContainerRef) then begin
        if Assigned(Records[i].RecordBySignature['XMBO']) then begin
          PostAddMessage('Removing: ' + Records[i].Name);
          Records[i].Remove;
        end else if Assigned(Records[i].RecordBySignature['XPRM']) then begin
          PostAddMessage('Removing: ' + Records[i].Name);
          Records[i].Remove;
        end else
          for j := Pred(ContainerRef.ElementCount) downto 0 do begin
            s := ContainerRef.Elements[j].Name;
            if Allowed.IndexOf(s) < 0 then begin
              if Silent.IndexOf(s) < 0 then
                PostAddMessage('Removing: ' + s);
              ContainerRef.Elements[j].Remove;
            end;
          end;
      end;
  end;
  }                        {
  for i := low(Records) to high(Records) do begin
    s := Records[i].Signature;
    if s = 'REFR' then
      if Records[i].IsPersistent then try
        Records[i].IsPersistent := False;
      except end;
  end;

  }
  PostAddMessage('Done');
end;

procedure TfrmMain.mniRefByVWDClick(Sender: TObject);
var
  Selected   : TDynMainRecords;
  Cells      : TDynMainRecords;
  MainRecord : IwbMainRecord;
  GroupRecord: IwbGroupRecord;
  FoundIt    : Boolean;
  i, j, k    : Integer;
  Node       : PVirtualNode;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if not EditWarn then
    Exit;

  Cells := nil;
  Selected := GetRefBySelectionAsMainRecords;
  k := 0;
  SetLength(Cells, Length(Selected));
  for i := Low(Selected) to High(Selected) do
    if (Selected[i].Signature = 'REFR') and Selected[i].IsEditable then begin
      if Sender = mniRefByNotVWD then
        Selected[i].IsVisibleWhenDistant := False
      else
        Selected[i].IsVisibleWhenDistant := True;

      if not Assigned(Selected[i].Container) then
        Continue;
      if not Assigned(Selected[i].Container.Container) then
        Continue;
      if not Supports(Selected[i].Container.Container, IwbGroupRecord, GroupRecord) then
        Continue;
      if GroupRecord.GroupType <> 6 then
        Continue;
      MainRecord := GroupRecord.ChildrenOf;
      if not Assigned(MainRecord) then
        Continue;
      if MainRecord.Signature <> 'CELL' then
        Continue;

      FoundIt := False;
      for j := Low(Cells) to Pred(k) do
        if MainRecord.Equals(Cells[i]) then begin
          FoundIt := True;
          Break;
        end;
      if FoundIt then
        Continue;

      Cells[k] := MainRecord;
      Inc(k);
    end;
  SetLength(Cells, k);
  for i := Low(Cells) to High(Cells) do begin
    Node := FindNodeForElement(Cells[i]);
    if not Assigned(Node) then
      Continue;
    vstNav.Expanded[Node] := False;
    InvalidateElementsTreeView(TNodeArray.Create(Node));
  end;
end;

procedure TfrmMain.mniNavRemoveIdenticalToMasterClick(Sender: TObject);
const
  sJustWait                   = 'Removing "Identical to Master" records. Please wait...';
var
  Selection                   : TNodeArray;
  StartNode, Node, NextNode   : PVirtualNode;
  NodeData                    : PNavNodeData;
  Count                       : Cardinal;
  RemovedCount                : Cardinal;
  StartTick                   : Cardinal;
  i                           : Integer;
  MainRecord                  : IwbMainRecord;
  GroupRecord                 : IwbGroupRecord;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := vstNav.GetSortedSelection(True);

  if Length(Selection) < 1 then
    Exit;

  if not FilterApplied or
    FilterConflictAll or
    FilterConflictThis or
    FilterByInjectStatus or
    FilterByPersistent or
    FilterByVWD or
    (FilterByNotReachableStatus and ReachableBuild) or
    FilterByReferencesInjectedStatus or
    FilterByEditorID or
    FilterByName or
    FilterBySignature or
    FilterByBaseEditorID or
    FilterByBaseName or
    FilterScaledActors or
    FilterByBaseSignature or
    FlattenBlocks or
    FlattenCellChilds or
    AssignPersWrldChild or
    not InheritConflictByParent then begin

    MessageDlg('To use this function you need to apply a filter with *only* the option "Conflict status inherited by parent" active.', mtError, [mbOk], 0);
    Exit;
  end;

  if not EditWarn then
    Exit;

  vstNav.BeginUpdate;
  try
    StartTick := GetTickCount;
    wbStartTime := Now;

    Enabled := False;

    RemovedCount := 0;
    Count := 0;
    for i := Low(Selection) to High(Selection) do try
      StartNode := Selection[i];
      if Assigned(StartNode) then
        Node := vstNav.GetLast(StartNode)
      else
        Node := nil;
      while Assigned(Node) do begin
        NextNode := vstNav.GetPrevious(Node);
        NodeData := vstNav.GetNodeData(Node);

        if Assigned(NodeData.Element) then begin
          if (Node.ChildCount = 0) {and (NodeData.ConflictAll = caNoConflict)} and
            (
              (NodeData.ConflictThis = ctIdenticalToMaster) or
              (
                (NodeData.ConflictThis = ctConflictBenign) and
                Supports(NodeData.Element, IwbMainRecord, MainRecord) and
                (MainRecord.Signature = 'NAVM')
              ) or
              (
                Supports(NodeData.Element, IwbGroupRecord, GroupRecord)
              )
            ) then begin
            MainRecord := nil;

            if not NodeData.Element.IsRemoveable then
              PostAddMessage('Can''t remove: ' + NodeData.Element.Name)
            else begin
              PostAddMessage('Removing: ' + NodeData.Element.Name);
              if Assigned(NodeData.Container) and not NodeData.Container.Equals(NodeData.Element) then
                NodeData.Container.Remove;
              NodeData.Element.Remove;
              NodeData.Container := nil;
              NodeData.Element := nil;
              Inc(RemovedCount);
              vstNav.DeleteNode(Node, False);
            end;
          end;
        end;

        Node := NextNode;
        Inc(Count);
        if StartTick + 500 < GetTickCount then begin
          Caption := sJustWait + ' Processed Records: ' + IntToStr(Count) +
            ' Removed Records: ' + IntToStr(RemovedCount) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
        if Node = StartNode then
          Node := nil;
      end;

    finally
      Enabled := True;
    end;

    PostAddMessage('[Removing "Identical to Master" records done] ' + ' Processed Records: ' + IntToStr(Count) +
      ', Removed Records: ' + IntToStr(RemovedCount) +
      ', Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime)); // Does not show up if handling "a lot" of records !
  finally
    vstNav.EndUpdate;
    Caption := Application.Title;
  end;
end;

procedure TfrmMain.mniSpreadsheetCompareSelectedClick(Sender: TObject);
var
  vstSpreadsheet              : TVirtualEditTree;
  Nodes                       : TNodeArray;
  NodeDatas                   : PSpreadSheetNodeDatas;
  Records                     : TDynMainRecords;
  i                           : Integer;
begin
  vstSpreadsheet := pmuSpreadsheet.PopupComponent as TVirtualEditTree;
  Nodes := vstSpreadsheet.GetSortedSelection(True);
  SetLength(Records, Length(Nodes));
  for i := Low(Nodes) to High(Nodes) do begin
    NodeDatas := vstSpreadsheet.GetNodeData(Nodes[i]);
    Records[i] := NodeDatas[0].Element as IwbMainRecord;
  end;
  JumpTo(TCompareRecordsHistoryEntry.Create(Records), False);
end;

procedure TfrmMain.mniSpreadsheetRebuildClick(Sender: TObject);
var
  vstSpreadsheet              : TVirtualEditTree;
begin
  vstSpreadsheet := pmuSpreadsheet.PopupComponent as TVirtualEditTree;
  vstSpreadsheet.Clear;
  vstSpreadsheet.NodeDataSize := 0;
  tbsSpreadsheetShow(vstSpreadsheet.Parent);
end;

procedure TfrmMain.mniViewRemoveClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  NextNode                    : PVirtualNode;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  NextNode := vstView.GetNextVisibleSibling(vstView.FocusedNode);
  if not Assigned(NextNode) then
    NextNode := vstView.GetPreviousVisibleSibling(vstView.FocusedNode);
  if not Assigned(NextNode) then begin
    NextNode := vstView.FocusedNode.Parent;
    if vstView.RootNode = NextNode then
      NextNode := nil;
  end;

  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin

      if not EditWarn then
        Exit;

      //      vstView.BeginUpdate;
      try

        Element.Remove;
        ActiveRecords[Pred(vstView.FocusedColumn)].UpdateRefs;
        Element := nil;
        PostResetActiveTree;

      finally
        //        vstView.EndUpdate;
      end;

      if Assigned(NextNode) then
        vstView.FocusedNode := NextNode;
      InvalidateElementsTreeView(NoNodes);
    end;
  end;
end;

procedure TfrmMain.mniViewRemoveFromSelectedClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  i                           : Integer;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then
    for i := Low(ActiveRecords) to High(ActiveRecords) do begin
      Element := NodeDatas[i].Element;
      if Assigned(Element) and Element.IsRemoveable then begin
        if not EditWarn then
          Exit;
        Element.Remove;
        (ActiveRecords[i].Element as IwbMainRecord).UpdateRefs;
        Element := nil;
      end;
    end;
  PostResetActiveTree;
  InvalidateElementsTreeView(NoNodes);
end;

function CompareViewRow(List: TStringList; Index1, Index2: Integer): Integer;
var
  SortKey1, SortKey2          : string;
  Order1, Order2              : Integer;
begin
  SortKey1 := List[Index1];
  SortKey2 := List[Index2];

  if SortKey1 = '' then begin
    if SortKey2 = '' then begin
      Result := 0;
    end
    else begin
      Result := 1;
    end;
  end
  else begin
    if SortKey2 = '' then begin
      Result := -1;
    end
    else begin
      Result := CompareStr(SortKey1, SortKey2);
    end;
  end;

  if Result = 0 then begin
    Order1 := Integer(List.Objects[Index1]);
    Order2 := Integer(List.Objects[Index2]);
    Result := CmpI32(Order1, Order2);
  end;
end;

procedure TfrmMain.mniViewSortClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  sl                          : TStringList;
  i                           : integer;
  Element                     : IwbElement;
  Recs                        : TDynMainRecords;
  OffsetXY                    : TPoint;
begin
  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);

  sl := TStringList.Create;
  try
    Assert(Length(ActiveRecords) = Length(CompareRecords));

    for i := Low(ActiveRecords) to High(ActiveRecords) do begin
      Element := NodeDatas[i].Element;
      if Assigned(Element) then
        sl.AddObject(Element.SortKey[True], Pointer(i))
      else
        sl.AddObject('', Pointer(i));
    end;

    Assert(Length(ActiveRecords) = sl.Count);

    sl.CustomSort(CompareViewRow);
    SetLength(Recs, Length(CompareRecords));
    for i := 0 to Pred(sl.Count) do
      Recs[i] := CompareRecords[Integer(sl.Objects[i])];
  finally
    sl.Free;
  end;

  vstView.BeginUpdate;
  try
    OffsetXY := vstView.OffsetXY;
    SetActiveRecord(Recs);
    vstView.OffsetXY := OffsetXY;
  finally
    vstView.EndUpdate;
  end;
end;

procedure TfrmMain.mniNavFilterRemoveClick(Sender: TObject);
begin
  vstNav.BeginUpdate;
  try
    ReInitTree;
    vstNav.TreeOptions.AutoOptions := vstNav.TreeOptions.AutoOptions + [toAutoFreeOnCollapse];
  finally
    vstNav.EndUpdate;
  end;
end;

procedure TfrmMain.mniNavHeaderFilesClick(Sender: TObject);
var
  i: Integer;
begin
  UserWasActive := True;

  if mniNavHeaderFilesLoadOrder.Checked then
    i := 1
  else if mniNavHeaderFilesFileName.Checked then
    i := 2
  else
    i := 0;
  Settings.WriteInteger('Nav','FilesSort',i);
  Settings.UpdateFile;
  vstNav.Header.SortTree;
  vstNav.ScrollIntoView(vstNav.FocusedNode, True);
end;

procedure TfrmMain.mniNavHiddenClick(Sender: TObject);
var
  Nodes                       : TNodeArray;
  NodeData                    : PNavNodeData;
  i                           : Integer;
begin
  UserWasActive := True;

  Nodes := vstNav.GetSortedSelection(True);
  for i := Low(Nodes) to High(Nodes) do begin
    NodeData := vstNav.GetNodeData(Nodes[i]);
    if Assigned(NodeData) and Assigned(NodeData.Element) then begin
      if mniNavHidden.Checked then
        NodeData.Element.Hide
      else
        NodeData.Element.Show;
      NodeData.ConflictAll := caUnknown;
      NodeData.ConflictThis := ctUnknown;
      vstNav.InvalidateNode(Nodes[i]);
    end;
  end;
  PostResetActiveTree;
  InvalidateElementsTreeView(NoNodes);
end;

procedure TfrmMain.mniNavLocalizationEditorClick(Sender: TObject);
begin
  if not Assigned(wbLocalizationHandler) then
    Exit;

  with TfrmLocalization.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmMain.mniNavLocalizationLanguageClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  if not Assigned(wbLocalizationHandler) then
    Exit;

  s := StringReplace(TMenuItem(Sender).Caption, '&', '', []);

  if wbLanguage = s then
    Exit;

  wbLanguage := s;

  wbLocalizationHandler.Clear;
  for i := Low(Files) to High(Files) do
    if Files[i].IsLocalized then
      wbLocalizationHandler.LoadForFile(Files[i].FileName);

  vstNav.Invalidate;
  vstView.Invalidate;
end;

procedure TfrmMain.mniNavLocalizationSwitchClick(Sender: TObject);

  procedure GatherLStrings(const aElement: IwbElement; var lst: TDynElements);
  var
    Container  : IwbContainerElementRef;
    i          : Integer;
  begin
    if Assigned(aElement.ValueDef) and (aElement.ValueDef.DefType = dtLString) then begin
      SetLength(lst, Succ(Length(lst)));
      lst[High(lst)] := aElement;
      //wbProgressCallback('LString found in : ' + aElement.FullPath);
    end;
    if Supports(aElement, IwbContainerElementRef, Container) then
      for i := Pred(Container.ElementCount) downto 0 do
        GatherLStrings(Container.Elements[i], lst);
  end;

var
  NodeData            : PNavNodeData;
  _File               : IwbFile;
  i, j, Translated    : integer;
  ID, StartTick       : Cardinal;
  Element             : IwbElement;
  lstrings            : TDynElements;
  fLocalize, ok       : boolean;
  fTranslate          : boolean;
  s                   : string;
  lFiles              : TStringList;
  lFrom, lTo          : TwbFastStringList;
  wblf                : TwbLocalizationFile;
begin
  if not wbEditAllowed then
    Exit;

  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);

  if not Assigned(NodeData) then
    Exit;

  if not Supports(NodeData.Element, IwbFile, _File) then
    Exit;

  fLocalize := not _File.IsLocalized;
  fTranslate := false;
  Translated := 0;

  if fLocalize then begin

    with TfrmLocalizePlugin.Create(Self) do try

      lFiles := wbLocalizationHandler.AvailableLocalizationFiles;
      clbFrom.Items.AddStrings(lFiles);
      clbTo.Items.AddStrings(lFiles);

      if ShowModal <> mrOk then begin
        FreeAndNil(lFiles);
        Exit;
      end;

      fTranslate := cbTranslation.Checked;

      if fTranslate then
        for i := 0 to Pred(lFiles.Count) do begin
          j := 0;
          if clbFrom.Checked[i] then j := j or 1;
          if clbTo.Checked[i] then j := j or 2;
          lFiles.Objects[i] := Pointer(j);
        end;

    finally
      Free;
    end;

  end;

  if not EditWarn then
    Exit;

  ok := false;

  try
    if fLocalize then
      Caption := 'Localizing Records. Please wait...'
    else
      Caption := 'Delocalizing Records. Please wait...';
    pgMain.ActivePage := tbsMessages;

    StartTick := GetTickCount;
    wbStartTime := Now;
    Enabled := false;

    if fTranslate then begin
      PostAddMessage('[Processing] Building translation index...');

      lFrom := TwbFastStringList.Create;
      lTo := TwbFastStringList.Create;

      for i := 0 to Pred(lFiles.Count) do begin
        if Integer(lFiles.Objects[i]) and 1 > 0 then begin
          wblf := TwbLocalizationFile.Create(wbLocalizationHandler.StringsPath + lFiles[i]);
          for j := 0 to Pred(wblf.Count) do
            lFrom.Add(AnsiLowerCase(wblf.Items[j]));
          wblf.Destroy;
        end;

        if Integer(lFiles.Objects[i]) and 2 > 0 then begin
          wblf := TwbLocalizationFile.Create(wbLocalizationHandler.StringsPath + lFiles[i]);
          lTo.AddStrings(wblf.Items);
          wblf.Destroy;
        end;
      end;

      if lFrom.Count <> lTo.Count then begin
        PostAddMessage('[Error] Number of strings in vocabulary does not match. Check parameters and run again.');
        Exit;
      end;
    end;


    PostAddMessage('[Processing] Collecting localizable values...');
    GatherLStrings(_File, lstrings);

    PostAddMessage('[Processing] Performing operation...');
    for i := Low(lstrings) to High(lstrings) do begin

      Element := lstrings[i];
      if fLocalize then begin
        s := Element.EditValue;
        if fTranslate then begin
          j := lFrom.IndexOf(AnsiLowerCase(s));
          if j <> -1 then begin
            s := lTo[j];
            Inc(Translated);
          end else
            // count empty strings as translated too
            if s = '' then Inc(Translated);
        end;
        ID := wbLocalizationHandler.AddValue(s, Element);
        Element.EditValue := sStringID + IntToHex(ID, 8);
      end else begin
        s := Element.EditValue;
        wbLocalizationHandler.NoTranslate := true;
        Element.EditValue := s;
        wbLocalizationHandler.NoTranslate := false;
      end;

      if StartTick + 500 < GetTickCount then begin
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;

    end;

    _File.IsLocalized := not _File.IsLocalized;

    vstNav.Invalidate;
    ok := true;

  finally
    if fLocalize and fTranslate then begin
      FreeAndNil(lFiles);
      FreeAndNil(lFrom);
      FreeAndNil(lTo);
    end;

    wbLocalizationHandler.NoTranslate := false;
    Enabled := true;
    PostAddMessage('[Processing done] ' +
      ' Localizable Strings: ' + IntToStr(Length(lstrings)) +
      ' Translated: ' + IntToStr(Translated) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime));
    Caption := Application.Title;

    // that "(de)localization" is a very dirty hack which can probably lead
    // to problems if user continues to work with a plugin, so
    // immediately force a "save changes" window and quit.
    if ok then Close;
  end;
end;

procedure TfrmMain.mniNavLogAnalyzerClick(Sender: TObject);
begin
  with TfrmLogAnalyzer.Create(Self) do begin
    Caption := StringReplace((Sender as TMenuItem).Caption, '&', '', [rfReplaceAll]);
    lDataPath := wbDataPath;
    lMyGamesTheGamePath := wbMyGamesTheGamePath;
    PFiles := @Files;
    JumpTo := frmMain.JumpTo;
    ltLog := TLogType(TMenuItem(Sender).Tag);
    Show;
  end;
end;

procedure TfrmMain.mniNavMarkModifiedClick(Sender: TObject);
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  Selection                   : TNodeArray;
  i                           : Integer;
  ContainsChilds              : Boolean;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  UserWasActive := True;

  Selection := EditableSelection(@ContainsChilds);

  if Length(Selection) < 1 then
    Exit;

  if not EditWarn then
    Exit;

  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    Element := NodeData.Element;
    if Assigned(Element) then
      Element.MarkModifiedRecursive;
  end;
  InvalidateElementsTreeView(NoNodes);
end;

procedure TfrmMain.mniNavRenumberFormIDsFromClick(Sender: TObject);
var
  s                           : string;
  i, j, k, l                  : Integer;
  NewFormID                   : Cardinal;
  OldFormID                   : Cardinal;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  ReferencedBy                : TDynMainRecords;
  Nodes                       : TNodeArray;
//  NewFileID                   : Integer;
//  OldFileID                   : Integer;
  AnyErrors                   : Boolean;
  Master                      : IwbMainRecord;
  _File                       : IwbFile;
//  FoundNone                   : Boolean;
  MainRecords                 : TDynMainRecords;
  Overrides                   : TDynMainRecords;

  StartFormID                 : Cardinal;
  EndFormID                   : Cardinal;
  TakenFormIDs                : array of Boolean;

  StartTick                   : Cardinal;
begin
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  AnyErrors := False;
  _File := nil;

  Nodes := vstNav.GetSortedSelection(True);
  if (Length(Nodes) <> 1) then
    Exit;

  NodeData := vstNav.GetNodeData(Nodes[0]);
  if not Assigned(NodeData) then
    Exit;
  if not Assigned(NodeData.Element) then
    Exit;
  if not Supports(NodeData.Element, IwbFile, _File) then
    Exit;

  if not EditWarn then
    Exit;

  s := '';
  repeat
    if s <> '' then
      ShowMessage('"'+s+'" is not a valid start FormID.');

    if not InputQuery('Start from...', 'Please enter the new module specific start FormID in hex. e.g. 200000. Specify only the last 6 digits.', s) then
      Exit;

    StartFormID := StrToInt64Def('$' + s, 0);
  until ((StartFormID and $FF000000) = 0) and (StartFormID > $800);

  SetLength(MainRecords, _File.RecordCount);
  j := 0;
  for i := Pred(_File.RecordCount) downto 0 do begin
    MainRecords[j] := _File.Records[i];
    if (MainRecords[j].LoadOrderFormID shr 24) = _File.LoadOrder then
      Inc(j);
  end;
  if j < 1 then
    Exit;

  SetLength(MainRecords, j);

  TakenFormIDs := nil;
  SetLength(TakenFormIDs, j);

  StartFormID := StartFormID or (Cardinal(_File.LoadOrder) shl 24);
  EndFormID := StartFormID + j;

  for i := Low(MainRecords) to High(MainRecords) do begin
    OldFormID := MainRecords[i].LoadOrderFormID;
    if (OldFormID >= StartFormID) and (OldFormID <= EndFormID) then
      TakenFormIDs[OldFormID - StartFormID] := True;
  end;

  StartTick := GetTickCount;
  wbStartTime := Now;
  Inc(wbShowStartTime);
  Enabled := False;
  try
    j := 0;
    Caption := '[Changing FormIDs] Processed Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    for k := High(MainRecords) downto Low(MainRecords) do begin
      MainRecord := MainRecords[k];
      OldFormID := MainRecord.LoadOrderFormID;

      if (OldFormID >= StartFormID) and (OldFormID <= EndFormID) then
        Continue;

      while TakenFormIDs[j] do
        Inc(j);
      NewFormID := StartFormID + j;
      Inc(j);

      if NewFormID = OldFormID then
        Continue;

      pgMain.ActivePage := tbsMessages;

      AddMessage('Changing FormID ['+IntToHex64(OldFormID, 8)+'] in file "'+MainRecord._File.FileName+'" to ['+IntToHex(NewFormID, 8)+']');

      Master := MainRecord.MasterOrSelf;
      SetLength(ReferencedBy, Master.ReferencedByCount);
      for i := 0 to Pred(Master.ReferencedByCount) do
        ReferencedBy[i] := Master.ReferencedBy[i];

      AddMessage('Record is referenced by '+IntToStr(Length(ReferencedBy))+' other record(s)');
      try
        SetLength(Overrides, MainRecord.OverrideCount);
        for l := 0 to Pred(MainRecord.OverrideCount) do
          Overrides[l] := MainRecord.Overrides[l];

        MainRecord.LoadOrderFormID := NewFormID;
        for l := Low(Overrides) to High(Overrides) do
          Overrides[l].LoadOrderFormID := NewFormID;

        Overrides := nil;

        NodeData.ConflictAll := caUnknown;
        NodeData.ConflictThis := ctUnknown;
        NodeData.Flags := [];

        if Length(ReferencedBy) > 0 then
          ShowChangeReferencedBy(OldFormID, NewFormID, ReferencedBy, True );
      except
        on E: Exception do begin
          AddMessage('Error: ' + E.Message);
          AnyErrors := True;
        end;
      end;

      if StartTick + 500 < GetTickCount then begin
        Caption := '[Changing FormIDs] Processed Records: ' + IntToStr(High(MainRecords) - k) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
        if ForceTerminate then
          Abort;
      end;
    end;
    if Supports(_File.Elements[0], IwbMainRecord, MainRecord) and (MainRecord.Signature = 'TES4') then
      MainRecord.ElementNativeValues['HEDR\Next Object ID'] := (Succ(EndFormID) and $FFFFFF);
    if AnyErrors then begin
      pgMain.ActivePage := tbsMessages;
      AddMessage('!!! Errors have occured. It is highly recommended to exit without saving as partial changes might have occured !!!');
    end;
  finally
    Dec(wbShowStartTime);
    Caption := Application.Title;
    Enabled := True;
    vstNav.Invalidate;
  end;
end;

function IsMasterTemporary(MainRecord: IwbMainRecord): Boolean;
begin
  Result :=
    not MainRecord.IsMaster and
    not MainRecord.Master.IsPersistent;
end;

function IsPositionChanged(MainRecord: IwbMainRecord): Boolean;
var
  Master    : IwbMainRecord;
  MasterPos : IwbRecord;
  ThisPos   : IwbRecord;
begin
  Result := False;
  if MainRecord.ConflictThis in [ctMaster, ctIdenticalToMaster] then
    Exit;
  if MainRecord.IsMaster then
    Exit;
  if MainRecord.Flags.IsDeleted then
    Exit;
  Master := MainRecord.Master;
  if not Assigned(Master) then
    Exit;
  MasterPos := Master.RecordBySignature['DATA'];
  ThisPos := MainRecord.RecordBySignature['DATA'];

  if Assigned(MasterPos) <> Assigned(ThisPos) then begin
    Result := True;
    Exit;
  end;

  if not Assigned(MasterPos) then
    Exit;

  Result := MasterPos.SortKey[True] <> ThisPos.SortKey[True];
end;

function IsUnnecessaryPersistent(MainRecord: IwbMainRecord): Boolean;
var
  NAME       : IwbRecord;
  BaseRecord : IwbMainRecord;
begin
  if MainRecord.Flags.IsDeleted then begin
    Result := IsMasterTemporary(MainRecord);
    Exit;
  end;

  Result := False;
  if MainRecord.Signature <> 'REFR' then
    Exit;
  if MainRecord.EditorID <> '' then
    Exit;
  if MainRecord.ReferencedByCount > 0 then
    Exit;

  if Assigned(MainRecord.RecordBySignature['XESP']) then
    Exit;
  if Assigned(MainRecord.RecordBySignature['XLOC']) then
    Exit;
  if Assigned(MainRecord.ElementByName['Map Marker']) then
    Exit;
  if Assigned(MainRecord.RecordBySignature['XRTM']) then
    Exit;
  if Assigned(MainRecord.RecordBySignature['XTEL']) then
    Exit;


  NAME := MainRecord.RecordBySignature['NAME'];
  if not Assigned(NAME) then
    Exit;

  if not Supports(NAME.LinksTo, IwbMainRecord, BaseRecord) then
    Exit;

  if Assigned(BaseRecord.RecordBySignature['SCRI']) then
    Exit;

  if BaseRecord.Signature = 'CONT' then
    Exit;

  if BaseRecord.Signature = 'SBSP' then
    Exit;

  Result := True;
end;


procedure TfrmMain.mniNavFilterApplyClick(Sender: TObject);

  function CustomScriptFilter(MainRecord: IwbMainRecord): Boolean;
  begin
    Result := False;

    if not ScriptEngine.FunctionExists('', 'Filter') then
      Exit;

    ScriptEngine.CallFunction('Filter', nil, [MainRecord]);
    Result := Boolean(ScriptEngine.VResult);
  end;

const
  sJustWait                   = 'Filtering. Please wait... (yes, this takes a while, just wait!)';
var
  Node, NextNode              : PVirtualNode;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  Count                       : Cardinal;
  StartTick                   : Cardinal;
  //  wbStartTime                   : TDateTime;
  ConflictAll                 : TConflictAll;
  ConflictThis                : TConflictThis;
  Signatures                  : TStringList;
  BaseSignatures              : TStringList;
  Dummy                       : Integer;
  Rec                         : IwbRecord;
  GroupRecord                 : IwbGroupRecord;
  i                           : Integer;

  PersCellChecked             : Boolean;
  PersCellNode                : PVirtualNode;

  Node2, NextNode2            : PVirtualNode;
  NodeData2                   : PNavNodeData;
  MainRecord2                 : IwbMainRecord;
  FoundAny                    : Boolean;
  GridCell                    : TwbGridCell;
  Position                    : TwbVector;

  Cells                       : array of array of array of PVirtualNode;
  FileFiltered                : array of Integer;
begin
  PersCellNode := nil;
  PersCellChecked := False;

  if not FilterPreset then begin

    with TfrmFilterOptions.Create(nil) do try
      cbConflictAll.Checked := FilterConflictAll;
      cbConflictThis.Checked := FilterConflictThis;

      cbByInjectionStatus.Checked := FilterByInjectStatus;
      cbInjected.Checked := FilterInjectStatus;

      cbByNotReachableStatus.Checked := FilterByNotReachableStatus;
      cbNotReachable.Checked := FilterNotReachableStatus;

      cbByNotReachableStatus.Enabled := ReachableBuild;
      cbNotReachable.Enabled := ReachableBuild;

      cbByReferencesInjectedStatus.Checked := FilterByReferencesInjectedStatus;
      cbReferencesInjected.Checked := FilterReferencesInjectedStatus;

      cbByEditorID.Checked := FilterByEditorID;
      edEditorID.Text := FilterEditorID;

      cbByName.Checked := FilterByName;
      edName.Text := FilterName;

      cbByBaseEditorID.Checked := FilterByBaseEditorID;
      edBaseEditorID.Text := FilterBaseEditorID;

      cbByBaseName.Checked := FilterByBaseName;
      edBaseName.Text := FilterBaseName;

      cbScaledActors.Checked := FilterScaledActors;

      cbByPersistent.Checked := FilterByPersistent;
      cbPersistent.Checked := FilterPersistent;
      cbUnnecessaryPersistent.Checked := FilterUnnecessaryPersistent;
      cbMasterIsTemporary.Checked := FilterMasterIsTemporary;
      cbIsMaster.Checked := FilterIsMaster;
      cbPersistentPosChanged.Checked := FilterPersistentPosChanged;
      cbDeleted.Checked := FilterDeleted;

      cbByVWD.Checked := FilterByVWD;
      cbVWD.Checked := FilterVWD;

      cbByHasVWDMesh.Checked := FilterByHasVWDMesh;
      cbHasVWDMesh.Checked := FilterHasVWDMesh;

      cbRecordSignature.Checked := FilterBySignature;
      RecordSignatures := FilterSignatures;

      cbBaseRecordSignature.Checked := FilterByBaseSignature;
      BaseRecordSignatures := FilterBaseSignatures;

      for i := 0 to Pred(clbConflictAll.Items.Count) do
        clbConflictAll.Checked[i] := TConflictAll(Succ(i)) in FilterConflictAllSet;
      for i := 0 to Pred(clbConflictThis.Items.Count) do
        clbConflictThis.Checked[i] := TConflictThis(i + 2) in FilterConflictThisSet;
      cbFlattenBlocks.Checked := FlattenBlocks;
      cbFlattenCellChilds.Checked := FlattenCellChilds;
      cbAssignPersWrldChild.Checked := AssignPersWrldChild;
      cbInherit.Checked := InheritConflictByParent;

      if ShowModal <> mrOk then
        Exit;

      FilterConflictAll := cbConflictAll.Checked;
      FilterConflictThis := cbConflictThis.Checked;

      FilterByInjectStatus := cbByInjectionStatus.Checked;
      FilterInjectStatus := cbInjected.Checked;

      FilterByNotReachableStatus := cbByNotReachableStatus.Checked;
      FilterNotReachableStatus := cbNotReachable.Checked;

      FilterByReferencesInjectedStatus := cbByReferencesInjectedStatus.Checked;
      FilterReferencesInjectedStatus := cbReferencesInjected.Checked;

      FilterByEditorID := cbByEditorID.Checked;
      FilterEditorID := edEditorID.Text;

      FilterByName := cbByName.Checked;
      FilterName := edName.Text;

      FilterByBaseEditorID := cbByBaseEditorID.Checked;
      FilterBaseEditorID := edBaseEditorID.Text;

      FilterByBaseName := cbByBaseName.Checked;
      FilterBaseName := edBaseName.Text;

      FilterScaledActors := cbScaledActors.Checked;

      FilterByPersistent := cbByPersistent.Checked;
      FilterPersistent := cbPersistent.Checked;
      FilterUnnecessaryPersistent := cbUnnecessaryPersistent.Checked;
      FilterMasterIsTemporary := cbMasterIsTemporary.Checked;
      FilterIsMaster := cbIsMaster.Checked;
      FilterPersistentPosChanged := cbPersistentPosChanged.Checked;

      FilterDeleted := cbDeleted.Checked;

      FilterByVWD := cbByVWD.Checked;
      FilterVWD := cbVWD.Checked;

      FilterByHasVWDMesh := cbByHasVWDMesh.Checked;
      FilterHasVWDMesh := cbHasVWDMesh.Checked;

      FilterBySignature := cbRecordSignature.Checked;
      FilterSignatures := RecordSignatures;

      FilterByBaseSignature := cbBaseRecordSignature.Checked;
      FilterBaseSignatures := BaseRecordSignatures;

      FilterConflictAllSet := [];
      for i := 0 to Pred(clbConflictAll.Items.Count) do
        if clbConflictAll.Checked[i] then
          Include(FilterConflictAllSet, TConflictAll(Succ(i)));

      FilterConflictThisSet := [];
      for i := 0 to Pred(clbConflictThis.Items.Count) do
        if clbConflictThis.Checked[i] then
          Include(FilterConflictThisSet, TConflictThis(i + 2));

      FlattenBlocks := cbFlattenBlocks.Checked;
      FlattenCellChilds := cbFlattenCellChilds.Checked;
      AssignPersWrldChild := cbAssignPersWrldChild.Checked;
      InheritConflictByParent := cbInherit.Checked;
    finally
      Free;
    end;

    Settings.WriteBool('Filter', 'ConflictAll', FilterConflictAll);
    Settings.WriteBool('Filter', 'ConflictThis', FilterConflictThis);

    Settings.WriteBool('Filter', 'ByInjectStatus', FilterByInjectStatus);
    Settings.WriteBool('Filter', 'InjectStatus', FilterInjectStatus);

    Settings.WriteBool('Filter', 'ByNotReachableStatus', FilterByNotReachableStatus);
    Settings.WriteBool('Filter', 'NotReachableStatus', FilterNotReachableStatus);

    Settings.WriteBool('Filter', 'ByReferencesInjectedStatus', FilterByReferencesInjectedStatus);
    Settings.WriteBool('Filter', 'ReferencesInjectedStatus', FilterReferencesInjectedStatus);

    Settings.WriteBool('Filter', 'ByEditorID', FilterByEditorID);
    Settings.WriteString('Filter', 'EditorID', FilterEditorID);

    Settings.WriteBool('Filter', 'ByName', FilterByName);
    Settings.WriteString('Filter', 'Name', FilterName);

    Settings.WriteBool('Filter', 'ByBaseEditorID', FilterByBaseEditorID);
    Settings.WriteString('Filter', 'BaseEditorID', FilterBaseEditorID);

    Settings.WriteBool('Filter', 'ByBaseName', FilterByBaseName);
    Settings.WriteString('Filter', 'BaseName', FilterBaseName);

    Settings.WriteBool('Filter', 'ScaledActors', FilterScaledActors);

    Settings.WriteBool('Filter', 'ByPersistent', FilterByPersistent);
    Settings.WriteBool('Filter', 'Persistent', FilterPersistent);
    Settings.WriteBool('Filter', 'UnnecessaryPersistent', FilterUnnecessaryPersistent);
    Settings.WriteBool('Filter', 'MasterIsTemporary', FilterMasterIsTemporary);
    Settings.WriteBool('Filter', 'PersistentPosChanged', FilterPersistentPosChanged);

    Settings.WriteBool('Filter', 'Deleted', FilterDeleted);

    Settings.WriteBool('Filter', 'ByVWD', FilterByVWD);
    Settings.WriteBool('Filter', 'VWD', FilterVWD);

    Settings.WriteBool('Filter', 'ByHasVWDMesh', FilterByHasVWDMesh);
    Settings.WriteBool('Filter', 'HasVWDMesh', FilterHasVWDMesh);

    Settings.WriteBool('Filter', 'BySignature', FilterBySignature);
    Settings.WriteString('Filter', 'Signatures', FilterSignatures);

    Settings.WriteBool('Filter', 'ByBaseSignature', FilterByBaseSignature);
    Settings.WriteString('Filter', 'BaseSignatures', FilterBaseSignatures);

    for ConflictAll := Low(ConflictAll) to High(ConflictAll) do
      Settings.WriteBool('Filter', GetEnumName(TypeInfo(TConflictAll), Ord(ConflictAll)), ConflictAll in FilterConflictAllSet);

    for ConflictThis := Low(ConflictThis) to High(ConflictThis) do
      Settings.WriteBool('Filter', GetEnumName(TypeInfo(TConflictThis), Ord(ConflictThis)), ConflictThis in FilterConflictThisSet);

    Settings.WriteBool('Filter', 'FlattenBlocks', FlattenBlocks);
    Settings.WriteBool('Filter', 'FlattenCellChilds', FlattenCellChilds);
    Settings.WriteBool('Filter', 'AssignPersWrldChild', AssignPersWrldChild);
    Settings.WriteBool('Filter', 'InheritConflictByParent', InheritConflictByParent);
    Settings.UpdateFile;

  end;

  Caption := sJustWait;

  SetLength(FileFiltered, Length(Files));

  if FilterByPersistent and FilterPersistent and FilterUnnecessaryPersistent then
    BuildAllRef;

  if FilterBySignature then begin
    Signatures := TStringList.Create;
    Signatures.CommaText := FilterSignatures;
    Signatures.Sorted := True;
  end else
    Signatures := nil;
  if FilterByBaseSignature then begin
    BaseSignatures := TStringList.Create;
    BaseSignatures.CommaText := FilterBaseSignatures;
    BaseSignatures.Sorted := True;
  end else
    BaseSignatures := nil;

  vstNav.Visible:= False;
  vstNav.BeginUpdate;
  try
    ReInitTree;

    StartTick := GetTickCount;
    wbStartTime := Now;

    Enabled := False;

    Count := 0;
    try
      vstNav.TreeOptions.AutoOptions := vstNav.TreeOptions.AutoOptions - [toAutoFreeOnCollapse];

      if wbTranslationMode then begin
        Node := vstNav.GetFirst;
        NodeData := vstNav.GetNodeData(Node);
        if Assigned(NodeData) and Assigned(NodeData.Element) and (NodeData.Element.ElementType = etFile) then
          if SameText((NodeData.Element as IwbFile).FileName, wbGameName + '.esm') then
            vstNav.DeleteNode(Node);
      end;

      Node := vstNav.GetLast(nil);
      while Assigned(Node) do begin
        NextNode := vstNav.GetPrevious(Node);
        NodeData := vstNav.GetNodeData(Node);
        FoundAny := False;

        if Assigned(NodeData.Element) then begin

          if NodeData.Element.ElementType = etMainRecord then begin
            MainRecord := NodeData.Element as IwbMainRecord;
            ConflictLevelForMainRecord(MainRecord, NodeData.ConflictAll, NodeData.ConflictThis);
            if MainRecord.IsInjected then
              Include(NodeData.Flags, nnfInjected);
            if MainRecord.IsNotReachable then
              Include(NodeData.Flags, nnfNotReachable);
            if MainRecord.ReferencesInjected then
              Include(NodeData.Flags, nnfReferencesInjected);

            if FlattenCellChilds and AssignPersWrldChild then
              if (MainRecord.Signature = 'WRLD') then begin
                Cells := nil;
                PersCellChecked := False;
                PersCellNode := nil;
              end else if (MainRecord.Signature = 'CELL') and
                Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
                case GroupRecord.GroupType of
                  5: begin {exterior cell}
                    if not PersCellChecked then begin
                      PersCellChecked := True;
                      PersCellNode := nil;
                      Cells := nil;

                      Node2 := Node.Parent;
                      if Assigned(Node2) then begin
                        NodeData2 := vstNav.GetNodeData(Node2);
                        if Assigned(NodeData2) and
                          Supports(NodeData2.Element, IwbGroupRecord, GroupRecord) and
                          (GroupRecord.GroupType = 5) then begin

                          Node2 := Node2.Parent;
                          if Assigned(Node2) then begin
                            NodeData2 := vstNav.GetNodeData(Node2);
                            if Assigned(NodeData2) and
                              Supports(NodeData2.Element, IwbGroupRecord, GroupRecord) and
                              (GroupRecord.GroupType = 4) then begin

                              Node2 := Node2.Parent;
                              if Assigned(Node2) then begin
                                NodeData2 := vstNav.GetNodeData(Node2);
                                if Assigned(NodeData2) and
                                  Supports(NodeData2.Element, IwbMainRecord, MainRecord2) and
                                  (MainRecord2.Signature = 'WRLD') then begin

                                  Node2 := vstNav.GetFirstChild(Node2);

                                  while Assigned(Node2) and not Assigned(PersCellNode) do begin
                                    NodeData2 := vstNav.GetNodeData(Node2);
                                    if Assigned(NodeData2) and
                                      Supports(NodeData2.Element, IwbMainRecord, MainRecord2) and
                                      (MainRecord2.Signature = 'CELL') then
                                      PersCellNode := Node2;

                                    Node2 := vstNav.GetNextSibling(Node2);
                                  end;

                                  if Assigned(PersCellNode) then begin
                                    Node2 := vstNav.GetFirstChild(PersCellNode);
                                    PersCellNode := nil;

                                    while Assigned(Node2) and not Assigned(PersCellNode) do begin
                                      NodeData2 := vstNav.GetNodeData(Node2);
                                      if Assigned(NodeData2) and
                                        Supports(NodeData2.Element, IwbGroupRecord, GroupRecord) and
                                        (GroupRecord.GroupType = 8) then begin
                                        PersCellNode := Node2;
                                        end;

                                      Node2 := vstNav.GetNextSibling(Node2);
                                    end;

                                    SetLength(Cells, 1000, 1000);

                                    Node2 := vstNav.GetLastChild(PersCellNode);
                                    while Assigned(Node2) do begin
                                      NextNode2 := vstNav.GetPreviousSibling(Node2);

                                      NodeData2 := vstNav.GetNodeData(Node2);
                                      if Assigned(NodeData2) and
                                        Supports(NodeData2.Element, IwbMainRecord, MainRecord2) and
                                        MainRecord2.GetPosition(Position) then begin

                                        GridCell := wbPositionToGridCell(Position);
                                        with GridCell do begin
                                          Inc(x, 500);
                                          Inc(y, 500);

                                          if (x >= Low(Cells)) and (x <= High(Cells)) and
                                            (y >= Low(Cells[x])) and (y <= High(Cells[x])) then begin

                                            SetLength(Cells[x,y], Succ(Length(Cells[x,y])));
                                            Cells[x,y, High(Cells[x,y])] := Node2;

                                          end;

                                        end;

                                      end;

                                      Node2 := NextNode2;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                    end;

                    if Assigned(PersCellNode) and MainRecord.GetGridCell(GridCell) then begin

                      with GridCell do begin
                        Inc(x, 500);
                        Inc(y, 500);

                        if (x >= Low(Cells)) and (x <= High(Cells)) and
                          (y >= Low(Cells[x])) and (y <= High(Cells[x])) then begin

                          for i := Low(Cells[x,y]) to High(Cells[x,y]) do begin

                            Node2 := Cells[x,y,i];
                            {NodeData2 :=} vstNav.GetNodeData(Node2);
                            vstNav.MoveTo(Node2, Node, amAddChildFirst, False);
                            if not FoundAny then begin
                              FoundAny := True;
                              NextNode := Node2;
                            end;
                          end;
                          Cells[x,y] := nil;

                        end;

                      end;
                    end;

                  end;
                end;

          end else if NodeData.Element.ElementType = etGroupRecord then
            if Supports(NodeData.Element, IwbGroupRecord, GroupRecord) then
              if GroupRecord.GroupType = 1 then begin
                if Assigned(PersCellNode) then begin
                  PersCellChecked := False;
                  PersCellNode := nil;
                  Cells := nil;
                end;
              end;

          if FoundAny then begin
            Node := NextNode;
            Continue;
          end;

          if not (vsVisible in Node.States) then begin
            vstNav.DeleteNode(Node, False)
          end else if Node.ChildCount > 0 then begin
            if
              (FlattenBlocks or FlattenCellChilds) and
              Supports(NodeData.Element, IwbGroupRecord, GroupRecord) and
              (
                (FlattenBlocks and (GroupRecord.GroupType in [2..5])) or
                (FlattenCellChilds and (GroupRecord.GroupType in [8..10]))
              ) then begin

              vstNav.MoveTo(Node, Node, amInsertBefore, True);
              vstNav.DeleteNode(Node, False);

            end else
              if InheritConflictByParent and (PersCellNode <> Node) then
                InheritStateFromChilds(Node, NodeData);
          end else if NodeData.Element.Skipped then begin
            vstNav.DeleteNode(Node, False)
          end else if (FlattenBlocks or FlattenCellChilds) and
                  Supports(NodeData.Element, IwbGroupRecord, GroupRecord) and
                  (
                    (FlattenBlocks and (GroupRecord.GroupType in [2..5])) or
                    (FlattenCellChilds and (GroupRecord.GroupType in [8..10]))
                  ) then
                    vstNav.DeleteNode(Node, False);
        end else
          vstNav.DeleteNode(Node, False);

        Node := NextNode;
        Inc(Count);
        if StartTick + 500 < GetTickCount then begin
          Caption := sJustWait + ' [Pass 1] Processed Records: ' + IntToStr(Count) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;

    finally
      Enabled := True;
    end;

    Count := 0;
    try
      vstNav.TreeOptions.AutoOptions := vstNav.TreeOptions.AutoOptions - [toAutoFreeOnCollapse];
      Node := vstNav.GetLast(nil);
      while Assigned(Node) do begin
        NextNode := vstNav.GetPrevious(Node);
        NodeData := vstNav.GetNodeData(Node);

        if Node.ChildCount = 0 then
          if
            (FilterConflictAll and not (NodeData.ConflictAll in FilterConflictAllSet)) or
            (FilterConflictThis and not (NodeData.ConflictThis in FilterConflictThisSet)) or
            (FilterByInjectStatus and ((nnfInjected in NodeData.Flags) <> FilterInjectStatus)) or
            (FilterByReferencesInjectedStatus and ((nnfReferencesInjected in NodeData.Flags) <> FilterReferencesInjectedStatus)) or
            (FilterByNotReachableStatus and ReachableBuild and ((nnfNotReachable in NodeData.Flags) <> FilterNotReachableStatus)) or
            (
              (FilterByEditorID or FilterByName) and (
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                (FilterByEditorID and (Pos(AnsiUpperCase(FilterEditorID), AnsiUpperCase(MainRecord.EditorID)) < 1)) or
                (FilterByName and (Pos(AnsiUpperCase(FilterName), AnsiUpperCase(MainRecord.DisplayName)) < 1))
              )
            ) or
            (Assigned(Signatures) and
              (
              not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
              not Signatures.Find(MainRecord.Signature, Dummy)
              )
            ) or
            (Assigned(BaseSignatures) and
              (
              not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
              not (
                    (MainRecord.Signature = 'REFR') or
                    (MainRecord.Signature = 'PGRE') or
                    (MainRecord.Signature = 'PMIS') or
                    (MainRecord.Signature = 'ACHR') or
                    (MainRecord.Signature = 'ACRE') or
                    (MainRecord.Signature = 'PHZD') or
                    (MainRecord.Signature = 'PARW') or
                    (MainRecord.Signature = 'PBAR') or
                    (MainRecord.Signature = 'PBEA') or
                    (MainRecord.Signature = 'PCON') or
                    (MainRecord.Signature = 'PFLA')
                  ) or
              not Supports(MainRecord.RecordBySignature['NAME'], IwbRecord, Rec) or
              not Supports(Rec.LinksTo, IwbMainRecord, MainRecord) or
              not BaseSignatures.Find(MainRecord.Signature, Dummy)
              )
            ) or
            (
              (FilterScaledActors) and (
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                not (
                      (MainRecord.Signature = 'ACHR') or
                      (MainRecord.Signature = 'ACRE')
                    ) or
                not Supports(MainRecord.RecordBySignature['XSCL'], IwbRecord, Rec) or
                SameValue(Rec.NativeValue, 1)
              )
            ) or
            (
              (FilterByBaseEditorID or FilterByBaseName) and (
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                not (
                      (MainRecord.Signature = 'REFR') or
                      (MainRecord.Signature = 'PGRE') or
                      (MainRecord.Signature = 'PMIS') or
                      (MainRecord.Signature = 'ACHR') or
                      (MainRecord.Signature = 'ACRE') or
                      (MainRecord.Signature = 'PHZD') or
                      (MainRecord.Signature = 'PARW') or
                      (MainRecord.Signature = 'PBAR') or
                      (MainRecord.Signature = 'PBEA') or
                      (MainRecord.Signature = 'PCON') or
                      (MainRecord.Signature = 'PFLA')
                    ) or
                not Supports(MainRecord.RecordBySignature['NAME'], IwbRecord, Rec) or
                not Supports(Rec.LinksTo, IwbMainRecord, MainRecord) or
                (FilterByBaseEditorID and (Pos(AnsiUpperCase(FilterBaseEditorID), AnsiUpperCase(MainRecord.EditorID)) < 1)) or
                (FilterByBaseName and (Pos(AnsiUpperCase(FilterBaseName), AnsiUpperCase(MainRecord.DisplayName)) < 1))
              )
            ) or
            (
              (FilterDeleted) and (
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                not MainRecord.IsDeleted
              )
            ) or
            (
              (FilterByPersistent or FilterByVWD or FilterByHasVWDMesh) and (
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                (
                  (MainRecord.Signature <> 'REFR') and
                  (MainRecord.Signature <> 'PGRE') and
                  (MainRecord.Signature <> 'PMIS') and
                  (MainRecord.Signature <> 'ACRE') and
                  (MainRecord.Signature <> 'ACHR') and
                  (MainRecord.Signature <> 'PHZD') and
                  (MainRecord.Signature <> 'PARW') and
                  (MainRecord.Signature <> 'PBAR') and
                  (MainRecord.Signature <> 'PBEA') and
                  (MainRecord.Signature <> 'PCON') and
                  (MainRecord.Signature <> 'PFLA')
                ) or
                (
                  FilterByPersistent and
                  (
                    (MainRecord.IsPersistent <> FilterPersistent) or
                    (
                      FilterUnnecessaryPersistent and
                      (
                        not IsUnnecessaryPersistent(MainRecord) or
                        (
                          FilterMasterIsTemporary and
                          (
                            not IsMasterTemporary(MainRecord) and
                            not (FilterIsMaster and MainRecord.IsMaster)
                          )
                        )
                      )
                    ) or
                    (
                      FilterPersistentPosChanged and
                      not IsPositionChanged(MainRecord)
                    )
                  )
                ) or
                (
                  FilterByVWD and
                  (
                    MainRecord.IsVisibleWhenDistant <> FilterVWD
                  )
                ) or
                (
                  FilterByHasVWDMesh and
                  (
                    (
                      (MainRecord.Signature = 'REFR') and
                      Supports(MainRecord.RecordBySignature['NAME'], IwbRecord, Rec) and
                      Supports(Rec.LinksTo, IwbMainRecord, MainRecord) and
                      MainRecord.HasVisibleWhenDistantMesh
                    ) <> FilterHasVWDMesh
                  )
                )
              )
            ) or
            (
              (FilterScripted) and
              (
                not Assigned(ScriptEngine) or
                not Supports(NodeData.Element, IwbMainRecord, MainRecord) or
                not CustomScriptFilter(MainRecord)
              )
            )
            then begin
            if Supports(NodeData.Element, IwbMainRecord, MainRecord) then
              if Assigned(MainRecord._File) {and (MainRecord.Signature <> 'TES4')} then begin
                for i := Low(Files) to High(Files) do
                  if Files[i] = MainRecord._File then Break;
                Inc(FileFiltered[i]);
              end;
            vstNav.DeleteNode(Node, False);
          end;

        Node := NextNode;
        Inc(Count);
        if StartTick + 500 < GetTickCount then begin
          Caption := sJustWait + ' [Pass 2] Processed Records: ' + IntToStr(Count) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;

    finally
      Enabled := True;
    end;

    for i := Low(Files) to High(Files) do
      if (FileFiltered[i] > 0) and (FileFiltered[i] < Files[i].RecordCount) then
        PostAddMessage(Format('[%s] Filtered %.0n of %.0n records',
          [Files[i].FileName, Min(Files[i].RecordCount, FileFiltered[i]) + 0.0, Files[i].RecordCount + 0.0]));

    PostAddMessage('[Filtering done] ' + ' Processed Records: ' + IntToStr(Count) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime));
    FilterApplied := True;
  finally
    vstNav.EndUpdate;
    Caption := Application.Title;
    Signatures.Free;
    BaseSignatures.Free;
    vstNav.Visible:= True;
    FilterScripted := False;
  end;
end;

procedure TfrmMain.mniNavFilterForCleaningClick(Sender: TObject);
begin
  FilterConflictAll := False;
  FilterConflictThis := False;

  FilterByInjectStatus := False;
  FilterInjectStatus := False;

  FilterByNotReachableStatus := False;
  FilterNotReachableStatus := False;

  FilterByReferencesInjectedStatus := False;
  FilterReferencesInjectedStatus := False;

  FilterByEditorID := False;
  FilterEditorID := '';

  FilterByName := False;
  FilterName := '';

  FilterByBaseEditorID := False;
  FilterBaseEditorID := '';

  FilterByBaseName := False;
  FilterBaseName := '';

  FilterScaledActors := False;

  FilterByPersistent := False;
  FilterPersistent := False;
  FilterUnnecessaryPersistent := False;
  FilterMasterIsTemporary := False;
  FilterIsMaster := False;
  FilterPersistentPosChanged := False;

  FilterDeleted := False;

  FilterByVWD := False;
  FilterVWD := False;

  FilterByHasVWDMesh := False;
  FilterHasVWDMesh := False;

  FilterBySignature := False;
  FilterSignatures := '';

  FilterByBaseSignature := False;
  FilterBaseSignatures := '';

  FilterConflictAllSet := [];
  FilterConflictThisSet := [];

  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := True;

  FilterPreset := True;
  try
    mniNavFilterApplyClick(Sender);
  finally
    FilterPreset := False;
  end;
end;

procedure TfrmMain.mniNavOptionsClick(Sender: TObject);
var
  ct: TConflictThis;
  ca: TConflictAll;
  i: integer;
begin
  with TfrmOptions.Create(Self) do try

    pnlFontRecords.Font := vstNav.Font;
    pnlFontMessages.Font := mmoMessages.Font;
    pnlFontViewer.Font := Self.Font; LoadFont(Settings, 'UI', 'FontViewer', pnlFontViewer.Font);
    cbHideUnused.Checked := wbHideUnused;
    cbHideIgnored.Checked := wbHideIgnored;
    cbHideNeverShow.Checked := wbHideNeverShow;
    cbActorTemplateHide.Checked := wbActorTemplateHide;
    cbLoadBSAs.Checked := wbLoadBSAs;
    cbSortFLST.Checked := wbSortFLST;
    cbSortGroupRecord.Checked := wbSortGroupRecord;
    cbRemoveOffsetData.Checked := wbRemoveOffsetData;
    cbShowFlagEnumValue.Checked := wbShowFlagEnumValue;
    cbSimpleRecords.Checked := wbSimpleRecords;
    edColumnWidth.Text := IntToStr(wbColumnWidth);
    cbAutoSave.Checked := AutoSave;
    //cbIKnow.Checked := wbIKnowWhatImDoing;
    cbTrackAllEditorID.Checked := wbTrackAllEditorID;
    cbUDRSetXESP.Checked := wbUDRSetXESP;
    cbUDRSetScale.Checked := wbUDRSetScale;
    edUDRSetScaleValue.Text := FloatToStrF(wbUDRSetScaleValue, ffFixed, 99, wbFloatDigits);
    cbUDRSetZ.Checked := wbUDRSetZ;
    edUDRSetZValue.Text := FloatToStrF(wbUDRSetZValue, ffFixed, 99, wbFloatDigits);
    cbUDRSetMSTT.Checked := wbUDRSetMSTT;
    edUDRSetMSTTValue.Text := IntToHex(wbUDRSetMSTTValue, 8);
    lbDoNotBuildRef.Items.Assign(wbDoNotBuildRefsFor);
    _Files := @Files;

    if ShowModal <> mrOK then
      Exit;

    vstNav.Font := pnlFontRecords.Font;
    vstView.Font := pnlFontRecords.Font;
    mmoMessages.Font := pnlFontMessages.Font;
    wbHideUnused := cbHideUnused.Checked;
    wbHideIgnored := cbHideIgnored.Checked;
    wbHideNeverShow := cbHideNeverShow.Checked;
    wbActorTemplateHide := cbActorTemplateHide.Checked;
    wbLoadBSAs := cbLoadBSAs.Checked;
    wbSortFLST := cbSortFLST.Checked;
    wbSortGroupRecord := cbSortGroupRecord.Checked;
    wbRemoveOffsetData := cbRemoveOffsetData.Checked;
    wbShowFlagEnumValue := cbShowFlagEnumValue.Checked;
    wbSimpleRecords := cbSimpleRecords.Checked;
    wbColumnWidth := StrToIntDef(edColumnWidth.Text, wbColumnWidth);
    AutoSave := cbAutoSave.Checked;
    //wbIKnowWhatImDoing := cbIKnow.Checked;
    wbTrackAllEditorID := cbTrackAllEditorID.Checked;
    wbUDRSetXESP := cbUDRSetXESP.Checked;
    wbUDRSetScale := cbUDRSetScale.Checked;
    wbUDRSetScaleValue := StrToFloatDef(edUDRSetScaleValue.Text, wbUDRSetScaleValue);
    wbUDRSetZ := cbUDRSetZ.Checked;
    wbUDRSetZValue := StrToFloatDef(edUDRSetZValue.Text, wbUDRSetZValue);
    wbUDRSetMSTT := cbUDRSetMSTT.Checked;
    wbUDRSetMSTTValue := StrToInt64Def('$' + edUDRSetMSTTValue.Text, wbUDRSetMSTTValue);
    wbDoNotBuildRefsFor.Assign(lbDoNotBuildRef.Items);

    SaveFont(Settings, 'UI', 'FontRecords', vstNav.Font);
    SaveFont(Settings, 'UI', 'FontMessages', mmoMessages.Font);
    SaveFont(Settings, 'UI', 'FontViewer', pnlFontViewer.Font);
    Settings.WriteBool('Options', 'AutoSave', AutoSave);
    Settings.WriteBool('Options', 'HideUnused', wbHideUnused);
    Settings.WriteBool('Options', 'HideIgnored', wbHideIgnored);
    Settings.WriteBool('Options', 'HideNeverShow', wbHideNeverShow);
    Settings.WriteBool('Options', 'ActorTemplateHide', wbActorTemplateHide);
    Settings.WriteBool('Options', 'LoadBSAs', wbLoadBSAs);
    Settings.WriteBool('Options', 'SortFLST', wbSortFLST);
    Settings.WriteBool('Options', 'SortGroupRecord', wbSortGroupRecord);
    Settings.WriteBool('Options', 'RemoveOffsetData', wbRemoveOffsetData);
    Settings.WriteBool('Options', 'ShowFlagEnumValue', wbShowFlagEnumValue);
    Settings.WriteBool('Options', 'SimpleRecords', wbSimpleRecords);
    Settings.WriteInteger('Options', 'ColumnWidth', wbColumnWidth);
    //Settings.WriteBool('Options', 'IKnowWhatImDoing', wbIKnowWhatImDoing);
    Settings.WriteBool('Options', 'TrackAllEditorID', wbTrackAllEditorID);
    Settings.WriteBool('Options', 'UDRSetXESP', wbUDRSetXESP);
    Settings.WriteBool('Options', 'UDRSetScale', wbUDRSetScale);
    Settings.WriteFloat('Options', 'UDRSetScaleValue', wbUDRSetScaleValue);
    Settings.WriteBool('Options', 'UDRSetZ', wbUDRSetZ);
    Settings.WriteFloat('Options', 'UDRSetZValue', wbUDRSetZValue);
    Settings.WriteBool('Options', 'UDRSetMSTT', wbUDRSetMSTT);
    Settings.WriteInteger('Options', 'UDRSetMSTTValue', wbUDRSetMSTTValue);
    for ct := Low(TConflictThis) to High(TConflictThis) do
      Settings.WriteInteger('ColorConflictThis', GetEnumName(TypeInfo(TConflictThis), Integer(ct)), Integer(wbColorConflictThis[ct]));
    for ca := Low(TConflictAll) to High(TConflictAll) do
      Settings.WriteInteger('ColorConflictAll', GetEnumName(TypeInfo(TConflictAll), Integer(ca)), Integer(wbColorConflictAll[ca]));
    for i := 0 to Pred(wbDoNotBuildRefsFor.Count) do
      Settings.WriteInteger('DoNotBuildRefsFor', wbDoNotBuildRefsFor[i], 1);

    Settings.UpdateFile;

  finally
    Free;
  end;
end;

procedure TfrmMain.mniViewNextMemberClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin
      if not EditWarn then
        Exit;

      Element.NextMember;
      PostResetActiveTree;
    end;
  end;
end;

function TfrmMain.NodeDatasForMainRecord(const aMainRecord: IwbMainRecord): TDynViewNodeDatas;
var
  Master                      : IwbMainRecord;
  Rec                         : IwbMainRecord;
  i, j, k                     : Integer;
  sl                          : TStringList;
  Records                     : TStringList;
  MadeChanges                 : Boolean;
  AnyHidden                   : Boolean;
  IsGMST                      : Boolean;
  EditorID                    : string;
  Group                       : IwbGroupRecord;
begin
  Assert(wbLoaderDone);
  IsGMST := False;
  AnyHidden := False;

  if aMainRecord.Signature = 'NAVI' then begin
    SetLength(Result, 1);
    Result[0].Element := aMainRecord;
    Result[0].Container := aMainRecord as IwbContainerElementRef;
    if aMainRecord.ElementCount < 1 then
      Result[0].Container := nil;
    Exit;
  end;

  if aMainRecord.Signature = 'GMST' then begin
    IsGMST := True;
    EditorID := aMainRecord.EditorID;
    SetLength(Result, Length(Files));
    Master := nil;
    for i := Low(Files) to High(Files) do begin
      Group := Files[i].GroupBySignature['GMST'];
      if Assigned(Group) then begin
        Rec := Group.MainRecordByEditorID[EditorID];
        if Assigned(Rec) then begin
          if not Assigned(Master) then
            Master := Rec;
          Result[i].Element := Rec;
        end;
      end;
    end;

  end else begin
    Master := aMainRecord.MasterOrSelf;

    SetLength(Result, Succ(Master.OverrideCount));

    AnyHidden := Master.IsHidden;
    if not AnyHidden then
      for i := 0 to Pred(Master.OverrideCount) do begin
        AnyHidden := Master.Overrides[i].IsHidden;
        if AnyHidden then
          Break;
      end;
  end;

  if (Length(Result) > 1) and ((ModGroups.Count > 0) or AnyHidden) or IsGMST then begin

    Records := TStringList.Create;
    try
      if IsGMST then begin
        for i := Low(Result) to High(Result) do
          if Supports(Result[i].Element, IwbMainRecord, Rec) then
             Records.AddObject(Rec._File.FileName, Pointer(Rec));
        Result := nil;
      end else begin
        Records.AddObject(Master._File.FileName, Pointer(Master));
        for i := 0 to Pred(Master.OverrideCount) do begin
          Rec := Master.Overrides[i];
          Records.AddObject(Rec._File.FileName, Pointer(Rec));
        end;
      end;

      repeat
        MadeChanges := False;
        sl := TStringList.Create;
        try
          for i := 0 to Pred(ModGroups.Count) do begin
            sl.Assign(TStrings(ModGroups.Objects[i]));
            for j := Pred(sl.Count) downto 0 do begin
              k := Records.IndexOf(sl[j]);
              if K >= 0 then
                sl.Objects[j] := TObject(k)
              else
                sl.Delete(j);
            end;
            if sl.Count > 1 then begin
              k := Integer(sl.Objects[0]);
              j := 1;
              if k = 0 then begin
                while (j < sl.Count) and (Integer(sl.Objects[j]) = k + 1) do begin
                  Records.Objects[Integer(sl.Objects[Pred(j)])] := nil;
                  Inc(k);
                  Inc(j);
                end;
                Inc(j);
              end;
              while (j < sl.Count) do begin
                Records.Objects[Integer(sl.Objects[Pred(j)])] := nil;
                Inc(j);
              end;
              for j := Pred(Records.Count) downto 0 do
                if Records.Objects[j] = nil then begin
                  Records.Delete(j);
                  MadeChanges := True;
                end;
            end;
            if Records.Count < 2 then
              Break;
          end;
        finally
          sl.Free;
        end;
      until not MadeChanges;

      i := 0;
      while (i < Records.Count) and (Records.Count > 1) do
        if IwbElement(Pointer(Records.Objects[i])).IsHidden then
          Records.Delete(i)
        else
          Inc(i);

      SetLength(Result, Records.Count);
      for i := 0 to Pred(Records.Count) do
        with Result[i] do begin
          Rec := IwbMainRecord(Pointer(Records.Objects[i]));
          if i = 0 then
            Master := Rec;

          Container := Rec as IwbContainerElementRef;
          Element := Container;
          if (Container.ElementCount = 0) or (Rec.Signature <> Master.Signature) then
            Container := nil;
        end;

    finally
      FreeAndNil(Records);
    end;

    Exit;
  end;

  Result[0].Element := Master;
  Result[0].Container := Master as IwbContainerElementRef;
  if Master.ElementCount < 1 then
    Result[0].Container := nil;

  for i := 0 to Pred(Master.OverrideCount) do
    with Result[Succ(i)] do begin
      Container := Master.Overrides[i] as IwbContainerElementRef;
      Element := Container;
      if (Container.ElementCount = 0) or (Master.Overrides[i].Signature <> Master.Signature) then
        Container := nil;
    end;
end;

procedure TfrmMain.pmuNavPopup(Sender: TObject);
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  Container                   : IwbContainerElementRef;
  AddList                     : TDynStrings;
  MenuItem                    : TMenuItem;
  MainRecord                  : IwbMainRecord;
  i                           : Integer;
  Nodes                       : TNodeArray;
  sl                          : TStringList;
begin
  mniNavTest.Visible := DebugHook <> 0;

  NodeData := vstNav.GetNodeData(vstNav.FocusedNode);
  if Assigned(NodeData) then
    Element := NodeData.Element;

  mniNavHidden.Visible := Assigned(Element);
  mniNavHidden.Checked := Assigned(Element) and (esHidden in Element.ElementStates);

  mniNavChangeFormID.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    Assigned(Element) and
    (Element.ElementType = etMainRecord) and
    Element.IsEditable;
//  if mniNavChangeFormID.Visible then
//    with Element as IwbMainRecord do
//      mniNavChangeFormID.Visible :=
//        {(Signature <> 'CELL') and (Signature <> 'WRLD') {and (Signature <> 'DIAL')};

  mniNavRenumberFormIDsFrom.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    Assigned(Element) and
    (Element.ElementType = etFile) and
    Element.IsEditable;

  mniNavChangeReferencingRecords.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    Assigned(Element) and
    (Element.ElementType = etMainRecord) and
    ((Element as IwbMainRecord).MasterOrSelf.ReferencedByCount > 0);

  mniNavCheckForErrors.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    Assigned(Element);

  mniNavSetVWDAuto.Visible := mniNavCheckForErrors.Visible and (wbGameMode = gmTES4);
  mniNavSetVWDAutoInto.Visible := mniNavCheckForErrors.Visible and (wbGameMode = gmTES4);
  mniNavRemoveIdenticalToMaster.Visible := mniNavCheckForErrors.Visible;

  mniNavRemove.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    (Length(RemoveableSelection(nil)) > 0);
  mniNavMarkModified.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    (Length(EditableSelection(nil)) > 0);

  mniNavCompareTo.Visible := Supports(Element, IwbFile);
  mniNavAddMasters.Visible := mniNavCheckForErrors.Visible and Supports(Element, IwbFile);
  mniNavSortMasters.Visible := mniNavAddMasters.Visible;
  mniNavCleanMasters.Visible := mniNavAddMasters.Visible;
  mniNavBatchChangeReferencingRecords.Visible := mniNavAddMasters.Visible;
  mniNavApplyScript.Visible := mniNavCheckForErrors.Visible;

  mniNavGenerateObjectLOD.Visible := mniNavCompareTo.Visible and (wbGameMode = gmTES4);

  mniNavAdd.Clear;
  pmuNavAdd.Items.Clear;

  if Supports(Element, IwbContainerElementRef, Container) then
    if Container.IsElementEditable(nil) then begin
      AddList := Container.GetAddList;
      for i := Low(AddList) to High(AddList) do begin
        MenuItem := TMenuItem.Create(mniNavAdd);
        MenuItem.Caption := AddList[i];
        MenuItem.OnClick := mniNavAddClick;
        mniNavAdd.Add(MenuItem);

        MenuItem := TMenuItem.Create(mniNavAdd);
        MenuItem.Caption := AddList[i];
        MenuItem.OnClick := mniNavAddClick;
        pmuNavAdd.Items.Add(MenuItem);
      end;
    end;

  mniNavAdd.Visible := mniNavAdd.Count > 0;

  mniNavCopyAsOverride.Visible := mniNavCheckForErrors.Visible and not mniNavAddMasters.Visible;
  mniNavDeepCopyAsOverride.Visible := mniNavCopyAsOverride.Visible and SelectionIncludesAnyDeepCopyRecords;
  mniNavCopyAsNewRecord.Visible := mniNavCopyAsOverride.Visible and not SelectionIncludesNonCopyNewRecords;

  if mniNavDeepCopyAsOverride.Visible and SelectionIncludesOnlyDeepCopyRecords then
    mniNavCopyAsOverride.Visible := False;

  mniNavCopyAsWrapper.Visible := False;
  if mniNavCopyAsOverride.Visible and Supports(Element, IwbMainRecord, MainRecord) then
    mniNavCopyAsWrapper.Visible :=
      (MainRecord.Signature = 'LVLN') or
      (MainRecord.Signature = 'LVLC') or
      (MainRecord.Signature = 'LVLI') or
      (MainRecord.Signature = 'LVSP');
  mniNavCopyAsSpawnRateOverride.Visible :=
    mniNavCopyAsWrapper.Visible;

  mniNavCleanupInjected.Visible :=
    mniNavCopyAsOverride.Visible and
    Supports(Element, IwbMainRecord, MainRecord) and
    MainRecord.ReferencesInjected;

  mniNavCompareSelected.Visible := False;
  if Supports(Element, IwbMainRecord, MainRecord) then begin
    Nodes := vstNav.GetSortedSelection(True);
    for i := Low(Nodes) to High(Nodes) do begin
      NodeData := vstNav.GetNodeData(Nodes[i]);
      if not Assigned(NodeData) then
        Exit;
      Element := NodeData.Element;
      if Element.ElementType <> etMainRecord then
        Exit;
      if (Element as IwbMainRecord).Signature <> MainRecord.Signature then
        Exit;
    end;
    mniNavCompareSelected.Visible := Length(Nodes) > 1;
  end;

  mniNavCellChildPers.Visible := False;
  mniNavCellChildTemp.Visible := False;
  mniNavCellChildNotVWD.Visible := mniNavCheckForErrors.Visible and SelectionIncludesOnlyREFR(NoNodes);
  mniNavCellChildVWD.Visible := mniNavCellChildNotVWD.Visible;
  if mniNavCellChildNotVWD.Visible then begin
    mniNavCellChildNotVWD.Checked := SelectionIncludesAnyNotVWD(NoNodes);
    mniNavCellChildVWD.Checked := SelectionIncludesAnyVWD(NoNodes);
  end;

  mniNavCreateSEQFile.Visible := (wbGameMode = gmTES5) and
     Assigned(Element) and
    (Element.ElementType = etFile);

  mniNavLocalization.Visible := (wbGameMode = gmTES5);
  mniNavLocalizationSwitch.Visible :=
     Assigned(Element) and
    (Element.ElementType = etFile) and
    (Element._File.LoadOrder > 0);
  if mniNavLocalizationSwitch.Visible then
    if Element._File.IsLocalized then
      mniNavLocalizationSwitch.Caption := 'Delocalize plugin'
    else
      mniNavLocalizationSwitch.Caption := 'Localize plugin';

  if wbGameMode = gmTES5 then begin
    mniNavLocalizationLanguage.Clear;
    sl := wbLocalizationHandler.AvailableLanguages;
    for i := 0 to Pred(sl.Count) do begin
      MenuItem := TMenuItem.Create(mniNavLocalizationLanguage);
      MenuItem.Caption := sl[i];
      MenuItem.RadioItem := true;
      if SameText(sl[i], wbLanguage) then
        MenuItem.Checked := true;
      MenuItem.OnClick := mniNavLocalizationLanguageClick;
      mniNavLocalizationLanguage.Add(MenuItem);
    end;
    sl.Free;
  end;

  mniNavLogAnalyzer.Visible := (wbGameMode in [gmTES4, gmTES5]);
  mniNavLogAnalyzer.Clear;
  if wbGameMode = gmTES5 then begin
    MenuItem := TMenuItem.Create(mniNavLogAnalyzer);
    MenuItem.OnClick := mniNavLogAnalyzerClick;
    MenuItem.Caption := 'Papyrus Log';
    MenuItem.Tag := Integer(ltTES5Papyrus);
    mniNavLogAnalyzer.Add(MenuItem);
  end else
  if wbGameMode = gmTES4 then begin
    MenuItem := TMenuItem.Create(mniNavLogAnalyzer);
    MenuItem.OnClick := mniNavLogAnalyzerClick;
    MenuItem.Caption := 'RuntimeScriptProfiler OBSE Extension Log';
    MenuItem.Tag := Integer(ltTES4RuntimeScriptProfiler);
    mniNavLogAnalyzer.Add(MenuItem);
  end;

  //if wbGameMode = gmTES5 then begin
  //  mniNavCreateMergedPatch.Visible := False;
  //end;
end;

procedure TfrmMain.pmuPathPopup(Sender: TObject);
begin
  mniPathPluggyLink.Visible := wbGameMode = gmTES4;
end;

procedure TfrmMain.pmuRefByPopup(Sender: TObject);
var
  Selected  : TDynMainRecords;
  AnyVWD    : Boolean;
  AnyNotVWD : Boolean;
  i         : Integer;
  Rec       : IwbMainRecord;
begin
  Selected := GetRefBySelectionAsMainRecords;

  mniRefByCopyOverrideInto.Visible :=
    not wbTranslationMode and
    wbEditAllowed and
    (Length(Selected) > 0);
  mniRefByDeepCopyOverrideInto.Visible := mniRefByCopyOverrideInto.Visible and ByRefSelectionIncludesAnyDeepCopyRecords(Selected);
  mniRefByCopyAsNewInto.Visible := mniRefByCopyOverrideInto.Visible and not ByRefSelectionIncludesNonCopyNewRecords(Selected);
  mniRefByCopyDisabledOverrideInto.Visible := mniRefByCopyOverrideInto.Visible;
  mniRefByRemove.Visible := mniRefByCopyOverrideInto.Visible;
  mniRefByMarkModified.Visible := mniRefByCopyOverrideInto.Visible;

  if mniRefByDeepCopyOverrideInto.Visible and ByRefSelectionIncludesOnlyDeepCopyRecords(Selected) then
    mniRefByCopyOverrideInto.Visible := False;

  mniRefByVWD.Visible := False;
  mniRefByNotVWD.Visible := False;

  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  if Length(Selected) < 1 then
    Exit;

  AnyVWD    := False;
  AnyNotVWD := False;

  for i := Low(Selected) to High(Selected) do begin
    Rec := Selected[i];
    if Rec.Signature <> 'REFR' then
      Exit;
    if not Rec.IsEditable then
      Exit;
    if Rec.IsVisibleWhenDistant then
      AnyVWD := True
    else
      AnyNotVWD := True;
  end;

  mniRefByVWD.Visible := AnyNotVWD;
  mniRefByNotVWD.Visible := AnyVWD;
end;

procedure TfrmMain.pmuSpreadsheetPopup(Sender: TObject);
begin
  mniSpreadsheetCompareSelected.Visible :=
    Length((pmuSpreadsheet.PopupComponent as TVirtualEditTree).
    GetSortedSelection(True)) > 1;
end;

procedure TfrmMain.pmuViewHeaderPopup(Sender: TObject);
var
  Column                      : TColumnIndex;
  MainRecord                  : IwbMainRecord;
begin
  mniViewHeaderCopyAsOverride.Visible := False;
  mniViewHeaderCopyAsNewRecord.Visible := False;
  mniViewHeaderCopyAsWrapper.Visible := False;
  mniViewHeaderRemove.Visible := False;
  mniViewHeaderHidden.Visible := False;
  mniViewHeaderJumpTo.Visible := False;
  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;
  Column := vstView.Header.Columns.PopupIndex;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  if not Supports(ActiveRecords[Column].Element, IwbMainRecord, MainRecord) then
    Exit;

  mniViewHeaderCopyAsOverride.Visible := True;
  mniViewHeaderCopyAsNewRecord.Visible := not(
    (MainRecord.Signature = 'CELL') or
    (MainRecord.Signature = 'WRLD') or
    (MainRecord.Signature = 'PGRD') or
    (MainRecord.Signature = 'NAVM') or
    (MainRecord.Signature = 'NAVI') or
    (MainRecord.Signature = 'LAND') or
    (MainRecord.Signature = 'ROAD')
  );
  mniViewHeaderCopyAsWrapper.Visible := (MainRecord.Signature = 'LVLC') or (MainRecord.Signature = 'LVLI') or (MainRecord.Signature = 'LVSP') or (MainRecord.Signature = 'LVLN');

  mniViewHeaderJumpTo.Visible := True;
  mniViewHeaderHidden.Visible := True;
  mniViewHeaderHidden.Checked := esHidden in MainRecord.ElementStates;
  if not ActiveRecords[Column].Element._File.IsEditable then
    Exit;
  if DebugHook = 0 then //reserve Delete for debugging until we know why it can go "crazy"
    Exit;
  mniViewHeaderRemove.Visible := True;
end;

procedure TfrmMain.pmuViewPopup(Sender: TObject);
var
  NodeDatas     : PViewNodeDatas;
  Element       : IwbElement;
  TargetNode    : PVirtualNode;
  TargetIndex   : Integer;
  TargetElement : IwbElement;
begin
  mniViewHideNoConflict.Visible := not ComparingSiblings;
  mniViewEdit.Visible := False;
  mniViewAdd.Visible := False;
  mniViewNextMember.Visible := False;
  mniViewPreviousMember.Visible := False;
  mniViewRemove.Visible := False;
  mniViewRemoveFromSelected.Visible := False;
  mniViewSort.Visible := ComparingSiblings;
  mniViewCopyToSelectedRecords.Visible := False;
  mniViewCompareReferencedRow.Visible := False;

  if not wbEditAllowed then
    Exit;

  if Length(ActiveRecords) < 1 then
    Exit;

  if vstView.FocusedColumn > 0 then begin
    NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
    if Assigned(NodeDatas) then begin
      Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
      mniViewEdit.Visible := Assigned(Element) and Element.IsEditable;
      mniViewRemove.Visible := not wbTranslationMode and Assigned(Element) and Element.IsRemoveable;
      mniViewMoveUp.Visible := not wbTranslationMode and Assigned(Element) and Element.CanMoveUp;
      mniViewMoveDown.Visible := not wbTranslationMode and Assigned(Element) and Element.CanMoveDown;
      mniViewRemoveFromSelected.Visible := not wbTranslationMode and mniViewRemove.Visible and ComparingSiblings;
      mniViewCopyToSelectedRecords.Visible :=
        (vstView.FocusedColumn > 0) and
        not wbTranslationMode and
        Assigned(Element) and
        (Length(vstNav.GetSortedSelection(True)) > 1) and
        (
        (Assigned(ActiveRecord) and (ActiveRecord._File.IsEditable)) or
        ((Length(CompareRecords) > 0) and (CompareRecords[0]._File.IsEditable))
        );
      mniViewCompareReferencedRow.Visible := not wbTranslationMode and (Length(GetUniqueLinksTo(NodeDatas, Length(ActiveRecords))) > 1);
      mniViewNextMember.Visible := not wbTranslationMode and Assigned(Element) and Element.CanChangeMember;
      mniViewPreviousMember.Visible := not wbTranslationMode and Assigned(Element) and Element.CanChangeMember;
    end;
    mniViewAdd.Visible := not wbTranslationMode and GetAddElement(TargetNode, TargetIndex, TargetElement) and
      TargetElement.CanAssign(TargetIndex, nil, True) and not (esNotSuitableToAddTo in TargetElement.ElementStates);
  end;
end;

procedure TfrmMain.PostAddMessage(const s: string);
var
  t                           : string;
  p                           : Pointer;
begin
  t := s;
  UniqueString(t);
  p := Pointer(t);
  Pointer(t) := nil;
  PostMessage(Handle, WM_USER, Integer(p), 0);
end;

procedure TfrmMain.PostPluggyChange(aFormID, aBaseFormID, aInventoryFormID, aEnchantmentFormID, aSpellFormID: Cardinal);
begin
  PluggyFormID := aFormID;
  PluggyBaseFormID := aBaseFormID;
  PluggyInventoryFormID := aInventoryFormID;
  PluggyEnchantmentFormID := aEnchantmentFormID;
  PluggySpellFormID := aSpellFormID;
  PostMessage(Handle, WM_USER + 4, 0, 0);
end;

procedure TfrmMain.PostResetActiveTree;
begin
  PostMessage(Handle, WM_USER + 3, 0, 0);
end;

procedure TfrmMain.mniViewPreviousMemberClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if Assigned(Element) then begin
      if not EditWarn then
        Exit;

      Element.PreviousMember;
      PostResetActiveTree;
    end;
  end;
end;

procedure TfrmMain.ReInitTree;
var
  i                           : Integer;
  _File                       : IwbFile;
begin
  FilterApplied := False;
  vstNav.BeginUpdate;
  try
    vstNav.Clear;
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      vstNav.AddChild(nil, Pointer(_File));
      _File._AddRef;
    end;
  finally
    vstNav.EndUpdate;
  end;
end;

function TfrmMain.RemoveableSelection(ContainsChilds: PBoolean): TNodeArray;
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  i, j                        : Integer;
begin
  SetLength(Result, 0);
  if Assigned(ContainsChilds) then
    ContainsChilds^ := False;

  if not wbEditAllowed then
    Exit;
  if wbTranslationMode then
    Exit;

  Result := vstNav.GetSortedSelection(True);
  j := Low(Result);
  for i := Low(Result) to High(Result) do begin
    NodeData := vstNav.GetNodeData(Result[i]);
    if not Assigned(NodeData) then
      Continue;
    Element := NodeData.Element;
    if not Assigned(Element) then
      Continue;
    if not Element.IsRemoveable then
      Continue;

    if Assigned(ContainsChilds) then
      ContainsChilds^ := ContainsChilds^ or
        (Assigned(NodeData.Container) and (NodeData.Container.ElementCount > 0));

    if i <> j then
      Result[j] := Result[i];
    Inc(j);
  end;
  SetLength(Result, j);
end;

procedure TfrmMain.ResetActiveTree;
var
  OffsetXY                    : TPoint;
  RootNodeCount               : Integer;
  MainRecord                  : IwbMainRecord;
  Column                      : TColumnIndex;
  Node                        : PVirtualNode;
  r                           : TRect;
begin
  vstView.BeginUpdate;
  try
    OffsetXY := vstView.OffsetXY;
    Column := vstView.FocusedColumn;
    Node := vstView.FocusedNode;
    if Assigned(Node) then
      r := vstView.GetDisplayRect(Node, Column, False);

    if Assigned(ActiveRecord) then begin
      MainRecord := ActiveRecord;
      SetActiveRecord(nil);
      SetActiveRecord(MainRecord);
    end
    else if Length(ActiveRecords) > 0 then begin
      RootNodeCount := vstView.RootNodeCount;
      vstView.Clear;
      vstView.RootNodeCount := RootNodeCount;
      InitConflictStatus(vstView.RootNode, False, @ActiveRecords[0]);
      vstView.FullExpand;
    end;
    vstView.UpdateScrollBars(False);
    vstView.OffsetXY := OffsetXY;
    if Assigned(Node) then begin
      Node := vstView.GetNodeAt(r.Left + 2, r.Top + 2);
      if Assigned(Node) then
        vstView.FocusedNode := Node;
    end;
    vstView.FocusedColumn := Column;
    vstView.OffsetXY := OffsetXY;
  finally
    vstView.EndUpdate;
  end;
end;

procedure TfrmMain.ResetAllTags;
var
  i     : Integer;
  _File : IwbFile;
begin
  wbStartTime := Now;

  Enabled := False;
  try
    for i := Low(Files) to High(Files) do begin
      _File := Files[i];
      wbCurrentAction := 'Resetting tags for ' + _File.Name;
      Application.ProcessMessages;
      _File.ResetTags;
    end;
  finally
    wbCurrentAction := '';
    Caption := Application.Title;
    Enabled := True;
  end;
end;

function TfrmMain.RestorePluginsFromMaster: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(Files) to High(Files) do with Files[i] do
    if IsESM and (not (fsIsHardcoded in FileStates)) and SameText(ExtractFileExt(FileName), '.esp') then begin
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Removing ESM Flag: ' + FileName);
      IsESM := False;
      Result := True;
    end;
end;

procedure TfrmMain.SaveChanged;
var
  i                           : Integer;
  FileStream                  : TFileStream;
  FileType                    : array of Byte;
  _File                       : IwbFile;
  _LFile                      : TwbLocalizationFile;
  NeedsRename                 : Boolean;
  u                           : string;
  s                           : string;
  t                           : string;
  SavedAny                    : Boolean;
  AnyErrors                   : Boolean;
begin
  if wbDontSave or (wbToolMode in [tmLODgen]) then
    Exit;

  pgMain.ActivePage := tbsMessages;

  with TfrmFileSelect.Create(nil) do try
    for i := Low(Files) to High(Files) do
      if (Files[i].IsEditable) and (esUnsaved in Files[i].ElementStates) or wbTestWrite then begin
        CheckListBox1.AddItem(Files[i].FileName, Pointer(Files[i]));
        CheckListBox1.Checked[Pred(CheckListBox1.Count)] := esUnsaved in Files[i].ElementStates;
        SetLength(FileType, Succ(Length(FileType))); FileType[High(FileType)] := 0;
      end;

    for i := 0 to Pred(wbLocalizationHandler.Count) do
      if wbLocalizationHandler[i].Modified  or wbTestWrite then begin
        CheckListBox1.AddItem(wbLocalizationHandler[i].Name, Pointer(wbLocalizationHandler[i]));
        CheckListBox1.Checked[Pred(CheckListBox1.Count)] := wbLocalizationHandler[i].Modified;
        SetLength(FileType, Succ(Length(FileType))); FileType[High(FileType)] := 1;
      end;

    Caption := 'Save changed files:';
    cbBackup.Visible := True;
    if Assigned(Settings) then
      cbBackup.Checked := not Settings.ReadBool(frmMain.Name, 'DontBackup', not cbBackup.Checked);

    if (CheckListBox1.Count > 0) and not (wbToolMode in [tmMasterUpdate, tmMasterRestore]) then begin
      ShowModal;
      wbDontBackup := not cbBackup.Checked;
      if Assigned(Settings) then begin
        Settings.WriteBool(frmMain.Name, 'DontBackup', wbDontBackup);
        Settings.UpdateFile;
      end;
      wbStartTime := Now;
    end;

    Inc(wbShowStartTime);
    try
      SavedAny := False;
      AnyErrors := False;
      t := '.save.' + FormatDateTime('yyyy_mm_dd_hh_nn_ss', Now);

      for i := 0 to Pred(CheckListBox1.Items.Count) do
        if CheckListBox1.Checked[i] then begin

          // localization file
          if FileType[i] = 1 then begin
            _LFile := TwbLocalizationFile(CheckListBox1.Items.Objects[i]);
            s := _LFile.FileName;
            NeedsRename := FileExists(s);
            s := Copy(s, length(wbDataPath) + 1, length(s)); // relative path to string file from Data folder
            u := s;
            if NeedsRename then
              s := s + t;

            try
              FileStream := TFileStream.Create(wbDataPath + s, fmCreate);
              try
                PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Saving: ' + s);
                _LFile.WriteToStream(FileStream);
                SavedAny := True;
              finally
                FileStream.Free;
              end;

            except
              on E: Exception do begin
                AnyErrors := True;
                PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Error saving ' + s + ': ' + E.Message);
              end;
            end;


          end else

          // plugin file
          begin

            _File := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));

            s := CheckListBox1.Items[i];
            u := s;
            NeedsRename := FileExists(wbDataPath + CheckListBox1.Items[i]);
            if NeedsRename then
              s := s + t;

            //try
              FileStream := TFileStream.Create(wbDataPath + s, fmCreate);
              try
                PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Saving: ' + s);
                _File.WriteToStream(FileStream);
                SavedAny := True;
              finally
                FileStream.Free;
              end;

            {except
              on E: Exception do begin
                AnyErrors := True;
                PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Error saving ' + s + ': ' + E.Message);
              end;
            end;}

          end;

          if NeedsRename then begin
            if not Assigned(FilesToRename) then
              FilesToRename := TStringList.Create;
            // s - rename from, relative to DataPath
            // u - rename to, relative to DataPath
            FilesToRename.Values[u] := s;
          end;

          Application.ProcessMessages;
          tmrMessagesTimer(nil);
        end;

    finally
      Application.ProcessMessages;
      tmrMessagesTimer(nil);
      Dec(wbShowStartTime);
    end;

    if AnyErrors then
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Errors have occured. At least one file was not saved.');
    if SavedAny then
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Done saving.');
    if AnyErrors then
      Abort;
  finally
    Free;
  end;
end;

function TfrmMain.SelectionIncludesAnyDeepCopyRecords: Boolean;
var
  Selection                   : TNodeArray;
  i                           : Integer;
  NodeData                    : PNavNodeData;
  GroupRecord                 : IwbGroupRecord;
  MainRecord                  : IwbMainRecord;
begin
  Result := True;
  Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if Supports(NodeData.Element, IwbGroupRecord, GroupRecord) then
        Exit;
      if Supports(NodeData.Element, IwbMainRecord, MainRecord) then
        if Assigned(MainRecord.ChildGroup) then
          Exit;
    end;
  end;
  Result := False;
end;

function TfrmMain.SelectionIncludesAnyNotVWD(Selection: TNodeArray): Boolean;
var
  i                           : Integer;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
begin
  Result := False;
  if Length(Selection) = 0 then
    Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if Supports(NodeData.Element, IwbMainRecord, MainRecord) then begin
        if not MainRecord.IsVisibleWhenDistant then begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

function TfrmMain.SelectionIncludesAnyVWD(Selection: TNodeArray): Boolean;
var
  i                           : Integer;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
begin
  Result := False;
  if Length(Selection) = 0 then
    Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if Supports(NodeData.Element, IwbMainRecord, MainRecord) then begin
        if MainRecord.IsVisibleWhenDistant then begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

function TfrmMain.SelectionIncludesNonCopyNewRecords: Boolean;
var
  Selection                   : TNodeArray;
  i                           : Integer;
  NodeData                    : PNavNodeData;
  GroupRecord                 : IwbGroupRecord;
  MainRecord                  : IwbMainRecord;
  Signature                   : TwbSignature;
begin
  Result := True;
  Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if Supports(NodeData.Element, IwbMainRecord, MainRecord) then begin
        Signature := MainRecord.Signature;
        if (Signature = 'CELL') or (Signature = 'WRLD') or (Signature = 'ROAD') or (Signature = 'LAND') or (Signature = 'PGRD') or (Signature = 'NAVM') or (Signature = 'NAVI') then
          Exit;
      end;

      if Supports(NodeData.Element, IwbGroupRecord, GroupRecord) then
        case GroupRecord.GroupType of
        0: begin
          Signature := TwbSignature(GroupRecord.GroupLabel);
          if (Signature = 'CELL') or (Signature = 'WRLD') then
            Exit;
        end;
        1..6, 9:
          Exit;
        end;

    end;
  end;
  Result := False;
end;

function TfrmMain.SelectionIncludesOnlyDeepCopyRecords: Boolean;
var
  Selection                   : TNodeArray;
  i                           : Integer;
  NodeData                    : PNavNodeData;
  GroupRecord                 : IwbGroupRecord;
begin
  Result := False;
  Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if Supports(NodeData.Element, IwbGroupRecord, GroupRecord) then
        Continue;
      Exit;
    end;
  end;
  Result := True;
end;

function TfrmMain.SelectionIncludesOnlyREFR(Selection: TNodeArray): Boolean;
var
  i                           : Integer;
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
  Signature                   : TwbSignature;
begin
  Result := False;
  if Length(Selection) = 0 then
    Selection := vstNav.GetSortedSelection(True);
  if Length(Selection) < 1 then
    Exit;
  for i := Low(Selection) to High(Selection) do begin
    NodeData := vstNav.GetNodeData(Selection[i]);
    if Assigned(NodeData) then begin
      if not Supports(NodeData.Element, IwbMainRecord, MainRecord) then
        Exit;
      Signature := MainRecord.Signature;
      if (Signature <> 'REFR') then
          Exit;
    end;
  end;
  Result := True;
end;

procedure TfrmMain.SendAddFile(const aFile: IwbFile);
begin
  SendMessage(Handle, WM_USER + 1, Integer(Pointer(aFile)), 0);
end;

procedure TfrmMain.SendLoaderDone;
begin
  SendMessage(Handle, WM_USER + 2, 0, 0);
end;

procedure TfrmMain.SetActiveRecord(const aMainRecords: TDynMainRecords);
var
  i                           : Integer;
begin
  UserWasActive := True;

  if Length(aMainRecords) < 2 then begin
    if Length(aMainRecords) = 1 then
      SetActiveRecord(aMainRecords[0])
    else
      SetActiveRecord(IwbMainRecord(nil));
    Exit;
  end;

  ComparingSiblings := True;
  CompareRecords := aMainRecords;
  lvReferencedBy.Items.BeginUpdate;
  try
    vstView.BeginUpdate;
    try
      lvReferencedBy.Items.Clear;
      vstView.Clear;
      vstView.NodeDataSize := 0;
      SetLength(ActiveRecords, 0);
      ActiveMaster := nil;
      ActiveRecord := nil;
      ActiveIndex := NoColumn;

      SetLength(ActiveRecords, Length(aMainRecords));
      for i := Low(ActiveRecords) to High(ActiveRecords) do
        with ActiveRecords[i] do begin
          Element := aMainRecords[i];
          Container := aMainRecords[i] as IwbContainerElementRef;
        end;

      with vstView.Header.Columns do begin
        BeginUpdate;
        try
          Clear;
          with Add do begin
            Text := '';
            Width := wbColumnWidth;
            Options := Options - [coDraggable];
            Options := Options + [coFixed];
          end;
          for I := Low(ActiveRecords) to High(ActiveRecords) do
            with Add do begin
              Text := (ActiveRecords[i].Element as IwbMainRecord).EditorID;
              Style := vsOwnerDraw;
              Width := wbColumnWidth;
              MinWidth := 5;
              MaxWidth := 3000;
              Options := Options - [coAllowclick, coDraggable];
              Options := Options + [coAutoSpring];
            end;
          if Length(ActiveRecords) > 1 then
            with Add do begin
              Text := '';
              Width := 1;
              MinWidth := 1;
              MaxWidth := 3000;
              Options := Options - [coAllowclick, coDraggable];
            end;
        finally
          EndUpdate;
        end;
      end;

      vstView.NodeDataSize := SizeOf(TNavNodeData) * Length(ActiveRecords);
      vstView.RootNodeCount := (aMainRecords[0].Def as IwbRecordDef).MemberCount + aMainRecords[0].AdditionalElementCount;
      InitConflictStatus(vstView.RootNode, False, @ActiveRecords[0]);
      vstView.FullExpand;
      pgMain.ActivePage := tbsView;
    finally
      vstView.EndUpdate;
    end;
    tbsReferencedBy.TabVisible := False;
  finally
    lvReferencedBy.Items.EndUpdate;
  end;
end;

function TfrmMain.SetAllToMaster: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(Files) to High(Files) do with Files[i] do
    if (not IsESM) and (not (fsIsHardcoded in FileStates)) then begin
      AddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Setting ESM Flag: ' + FileName);
      IsESM := True;
      Result := True;
    end else begin
      if wbMasterUpdateFilterONAM and (MasterCount > 0) then
        Elements[0].MarkModifiedRecursive;
    end;
end;

procedure TfrmMain.SetDoubleBuffered(aWinControl: TWinControl);
var
  i                           : Integer;
begin
  aWinControl.DoubleBuffered := True;
  for i := Pred(aWinControl.ControlCount) downto 0 do
    if aWinControl.Controls[i] is TWinControl then
      SetDoubleBuffered(TWinControl(aWinControl.Controls[i]))
    else
      Exit;
end;

procedure TfrmMain.SetActiveRecord(const aMainRecord: IwbMainRecord);
var
  i                           : Integer;
begin
  UserWasActive := True;

  ComparingSiblings := False;
  CompareRecords := nil;

  if (ActiveRecord = aMainRecord) and (Assigned(ActiveRecord) = (Length(ActiveRecords) > 0)) then
    Exit;

  lvReferencedBy.Items.BeginUpdate;
  try
    vstView.BeginUpdate;
    try
      lvReferencedBy.Items.Clear;
      vstView.Clear;
      vstView.NodeDataSize := 0;
      SetLength(ActiveRecords, 0);
      ActiveMaster := nil;
      ActiveIndex := NoColumn;
      ActiveRecord := aMainRecord;

      if Assigned(ActiveRecord) then begin
        ActiveMaster := nil;
        if wbLoaderDone then
          ActiveMaster := ActiveRecord.MasterOrSelf
        else
          ActiveMaster := ActiveRecord;

        if wbLoaderDone then begin
          ActiveRecords := NodeDatasForMainRecord(ActiveRecord);
        end else begin
          SetLength(ActiveRecords, 1);
          ActiveRecords[0].Element := ActiveRecord;
          ActiveRecords[0].Container := ActiveRecord as IwbContainerElementRef;
        end;

        with vstView.Header.Columns do begin
          BeginUpdate;
          try
            Clear;
            with Add do begin
              Text := '';
              Width := wbColumnWidth;
              Options := Options - [coDraggable];
              Options := Options + [coFixed];
            end;
            for I := Low(ActiveRecords) to High(ActiveRecords) do
              with Add do begin
                Text := ActiveRecords[i].Element._File.Name;
                Style := vsOwnerDraw;
                Width := wbColumnWidth;
                MinWidth := 5;
                MaxWidth := 3000;
                Options := Options - [coAllowclick, coDraggable];
                Options := Options + [coAutoSpring];
                if ActiveRecord.Equals(ActiveRecords[i].Element) then
                  ActiveIndex := i;
              end;
            if Length(ActiveRecords) > 1 then
              with Add do begin
                Text := '';
                Width := 1;
                MinWidth := 1;
                MaxWidth := 3000;
                Options := Options - [coAllowclick, coDraggable];
              end;
          finally
            EndUpdate;
          end;
        end;
        vstView.NodeDataSize := SizeOf(TNavNodeData) * Length(ActiveRecords);
        vstView.RootNodeCount := (ActiveMaster.Def as IwbRecordDef).MemberCount + ActiveMaster.AdditionalElementCount;
        InitConflictStatus(vstView.RootNode, ActiveMaster.IsInjected and not (ActiveMaster.Signature = 'GMST'), @ActiveRecords[0]);
        vstView.FullExpand;
        UpdateColumnWidths;
        if pgMain.ActivePage <> tbsReferencedBy then
          pgMain.ActivePage := tbsView;
      end
      else begin
        with vstView.Header.Columns do begin
          BeginUpdate;
          try
            Clear;
            with Add do begin
              Text := '';
              Width := wbColumnWidth;
            end;
          finally
            EndUpdate;
          end;
        end;
      end;
    finally
      vstView.EndUpdate;
    end;

    if Assigned(ActiveMaster) then
      for i := 0 to Pred(ActiveMaster.ReferencedByCount) do
        with lvReferencedBy.Items.Add do begin
          Caption := ActiveMaster.ReferencedBy[i].Name;
          SubItems.Add(ActiveMaster.ReferencedBy[i]._File.Name);
          Data := Pointer(ActiveMaster.ReferencedBy[i]);
        end;

    tbsReferencedBy.TabVisible := wbLoaderDone and (lvReferencedBy.Items.Count > 0);
  finally
    lvReferencedBy.Items.EndUpdate;
  end;
end;

procedure TfrmMain.ShowChangeReferencedBy(OldFormID, NewFormID: Cardinal; const ReferencedBy: TDynMainRecords; aSilent: Boolean);
var
  Counter    : Integer;
  i          : Integer;
  Error      : Boolean;
begin
  with TfrmFileSelect.Create(nil) do try
    Caption := 'Please select records to update';

    Counter := 0;
    for i := Low(ReferencedBy) to High(ReferencedBy) do begin
      CheckListBox1.AddItem(ReferencedBy[i].Name + ' - ' + ReferencedBy[i]._File.Name, Pointer(ReferencedBy[i]));
      if ReferencedBy[i].IsEditable then begin
        CheckListBox1.ItemEnabled[i] := True;
        Inc(Counter)
      end else
        CheckListBox1.ItemEnabled[i] := False;
    end;

    if Counter <= 0 then begin
      if not aSilent then
        ShowMessage('There are ' + IntToStr(Length(ReferencedBy)) + ' records referencing FormID ' + IntToHex64(OldFormID, 8) + ' but non of them are in editable files.');
      Exit;
    end;

    if not aSilent then begin
      ShowModal;

      for i := Pred(CheckListBox1.Count) downto 0 do
        if not CheckListBox1.Checked[i] then
          CheckListBox1.Items.Delete(i)
        else
          CheckListBox1.Checked[i] := False;
    end;

    if CheckListBox1.Count > 0 then begin

      Counter := 0;
      Error := False;
      for i := 0 to Pred(CheckListBox1.Count) do try
        CheckListBox1.Checked[i] := IwbMainRecord(Pointer(CheckListBox1.Items.Objects[i])).CompareExchangeFormID(OldFormID, NewFormID);
        if CheckListBox1.Checked[i] then
          Inc(Counter)
      except
        on E: Exception do begin
          AddMessage('Error updating FormID for ' + CheckListBox1.Items[i] + ': ' + E.Message);
          Error := True;
        end;
      end;

      AddMessage(IntToStr(Counter) + ' records out of '+IntToStr(Length(ReferencedBy))+' total records which reference FormID ['+IntToHex64(OldFormID, 8)+'] have been updated to ['+IntToHex64(NewFormID, 8)+']');

      if not aSilent then begin
        if Error then
          ShowMessage('At least one record could not be updated. Check the message log for detailed error messages');

        Caption := 'These records have been successfully updated:';

        ShowModal;
      end;

    end;

  finally
    Free;
  end;
end;

procedure TfrmMain.splElementsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    pnlNav.Visible := not pnlNav.Visible;
end;

procedure TfrmMain.stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  StatusBar.Canvas.Draw(Rect.Left, Rect.Top, imgFlattr.Picture.Graphic);
end;

procedure TfrmMain.stbMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (X > stbMain.Panels[0].Width) then
  case wbGameMode of
    gmTES4:
      ShellExecute(Handle, 'open', 'https://flattr.com/thing/77985/TES4Edit-Editor-for-The-Elder-Scrolls-IV-Oblivion', '', '', 0);
    gmFO3:
      ShellExecute(Handle, 'open', 'https://flattr.com/thing/77983/FO3Edit-Editor-for-Fallout-3', '', '', 0);
    gmFNV:
      ShellExecute(Handle, 'open', 'https://flattr.com/thing/77972/FNVEdit-Editor-for-Fallout-New-Vegas', '', '', 0);
    gmTES5:
      ShellExecute(Handle, 'open', 'https://flattr.com/thing/77985/TES4Edit-Editor-for-The-Elder-Scrolls-IV-Oblivion', '', '', 0);
  end;
end;

procedure TfrmMain.stbMainResize(Sender: TObject);
begin
  stbMain.Panels[0].Width := stbMain.ClientWidth - stbMain.Panels[1].Width;
end;

procedure TfrmMain.tbsMessagesShow(Sender: TObject);
begin
  mmoMessages.CaretPos := Point(0, mmoMessages.Lines.Count - 1);
  mmoMessages.SelLength := 1;
  mmoMessages.SelLength := 0;
  tbsMessages.Highlighted := False;
end;

procedure TfrmMain.tbsSpreadsheetShow(Sender: TObject);
var
  i                           : Integer;
  j                           : Integer;
  _File                       : IwbFile;
  Group                       : IwbGroupRecord;
  Element                     : IwbElement;
  vstSpreadSheet              : TVirtualEditTree;
  Signature                   : TwbSignature;
  sl2                         : TStringList;
begin
  if not wbLoaderDone then
    Exit;

  pnlNav.Hide;
  lblPath.Visible := False;

  vstSpreadSheet := ((Sender as TTabSheet).Controls[0] as TVirtualEditTree);
  if vstSpreadSheet.NodeDataSize > 0 then
    Exit;

  Signature := StrToSignature(Copy((Sender as TComponent).Name, 4, 4));
  with TfrmFileSelect.Create(nil) do try

    Caption := 'Select files to compare';

    sl2 := TStringList.Create;
    try
      sl2.Sorted := True;
      sl2.Duplicates := dupIgnore;
      sl2.CommaText := Settings.ReadString(Signature + ' Spreadsheet', 'Selection', '');

      for i := Low(Files) to High(Files) do
        if Files[i].HasGroup(Signature) then begin
          CheckListBox1.AddItem(Files[i].FileName, Pointer(Files[i]));
          if sl2.IndexOf(Files[i].FileName) >= 0 then
            CheckListBox1.Checked[Pred(CheckListBox1.Items.Count)] := True;
        end;
      CheckListBox1.Sorted := True;

      ShowModal;

      sl2.Clear;
      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then
          sl2.Add(CheckListBox1.Items[i]);

      Settings.WriteString(Signature + ' Spreadsheet', 'Selection', sl2.CommaText);
      Settings.UpdateFile;
    finally
      FreeAndNil(sl2);
    end;

    vstSpreadSheet.BeginUpdate;
    try
      vstSpreadSheet.Clear;
      vstSpreadSheet.NodeDataSize := vstSpreadSheet.Header.Columns.Count * SizeOf(TSpreadSheetNodeData);

      for i := 0 to Pred(CheckListBox1.Count) do
        if CheckListBox1.Checked[i] then begin
          _File := IwbFile(Pointer(CheckListBox1.Items.Objects[i]));
          Group := _File.GroupBySignature[Signature];
          for j := 0 to Pred(Group.ElementCount) do begin
            Element := Group.Elements[j];
            vstSpreadSheet.AddChild(nil, Pointer(Element));
            Element._AddRef;
          end;
        end;

      with vstSpreadSheet.Header.Columns do
        for i := 0 to Pred(Count) do
          with Items[i] do
            MaxWidth := 200;
      vstSpreadSheet.Header.AutoFitColumns(False);
      with vstSpreadSheet.Header.Columns do
        for i := 0 to Pred(Count) do
          with Items[i] do
            MaxWidth := 1000;
    finally
      vstSpreadSheet.EndUpdate;
    end;
  finally
    Free;
  end;
end;

procedure TfrmMain.tbsViewShow(Sender: TObject);
begin
  pnlNav.Show;
  vstNavChange(vstNav, vstNav.FocusedNode);
end;

procedure TfrmMain.tmrStartupTimer(Sender: TObject);
begin
  tmrStartup.Enabled := False;
  if InitStarted then
    Exit;
  InitStarted := True;

  DoInit;
end;

procedure TfrmMain.UpdateColumnWidths;
var
  i        : Integer;
  ColWidth : Integer;
begin
  if vstView.Header.Columns.Count > 2 then
    if mniViewColumnWidthFitAll.Checked then begin
      ColWidth := (vstView.ClientWidth - vstView.Header.Columns[0].Width) div (vstView.Header.Columns.Count - 2);
      for i := 1 to (vstView.Header.Columns.Count - 2) do
        vstView.Header.Columns[i].Width := ColWidth;
    end else if mniViewColumnWidthFitText.Checked then
      vstView.Header.AutoFitColumns(False)
    else begin
      ColWidth := wbColumnWidth;
      for i := 0 to Pred(vstView.Header.Columns.Count) do
        vstView.Header.Columns[i].Width := ColWidth;
    end;
end;

procedure TfrmMain.tmrCheckUnsavedTimer(Sender: TObject);
var
  i, j                        : Integer;
const
  SiteName : array[TwbGameMode] of string =
    ('Fallout3', 'NewVegas', 'Oblivion', 'Oblivion', 'Skyrim');
begin
  if not wbLoaderDone then
    Exit;

  if UserWasActive then begin
    UserWasActive := False;
    TotalUsageTime := TotalUsageTime + 1 / 24 / 60 / 2;
    Settings.WriteFloat('Usage', 'TotalTime', TotalUsageTime);
    Settings.UpdateFile;
    if (RateNoticeGiven < 2) and (TotalUsageTime > 1 / 8) then begin
      RateNoticeGiven := 2;
      Settings.WriteInteger('Usage', 'RateNoticeGiven', RateNoticeGiven);
      Settings.UpdateFile;
      ShowMessage('You''ve been actively using this program for a while now.'#13#13 +
        'If you should find this program useful I would greatly appreciate it if you ' +
        'would go to the download page at '+SiteName[wbGameMode]+' Nexus and give it an endorsement.'#13#13 +
        'If you have already endorsed this program I would like to thank you for your support and '+
        'if you have any suggestions how to improve this program please don''t hesitate to let me know about '+
        'them via the release topic on the Bethesda Game Studios Forums.');
    end;

  end;

  if not AutoSave then
    Exit;

  if vstView.IsEditing then
    Exit;

  tmrCheckUnsaved.Enabled := False;
  try
      for i := Low(Files) to High(Files) do
        if esUnsaved in Files[i].ElementStates then
          if Files[i].UnsavedSince < Now - SaveInterval then begin
            if MessageDlg('You have changes which are unsaved for a while already. Do you want to save now?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then begin
              SaveChanged;
              SaveInterval := DefaultInterval;
            end;
            Exit;
          end;
  finally
    for j := Low(Files) to High(Files) do
      if esUnsaved in Files[j].ElementStates then
        if Files[j].UnsavedSince < Now - SaveInterval then
          SaveInterval := (Now - Files[j].UnsavedSince) + DefaultInterval;

    tmrCheckUnsaved.Enabled := True;
  end;
end;

procedure TfrmMain.tmrGeneratorTimer(Sender: TObject);
begin
  tmrGenerator.Enabled := False;
  if GeneratorStarted then
    Exit;
  GeneratorStarted := True;
  DoGenerateLOD;
end;

procedure TfrmMain.tmrMessagesTimer(Sender: TObject);
var
  ChangesMade : Boolean;
begin
  if Assigned(NewMessages) and (NewMessages.Count > 0) then begin
    mmoMessages.Lines.AddStrings(NewMessages);
    NewMessages.Clear;
    mmoMessages.CaretPos := Point(0, mmoMessages.Lines.Count - 1);
    mmoMessages.SelLength := 1;
    mmoMessages.SelLength := 0;
    stbMain.Panels[0].Text := mmoMessages.Lines[Pred(mmoMessages.Lines.Count)];
    if pgMain.ActivePage <> tbsMessages then
      tbsMessages.Highlighted := True;
  end;

  if (wbToolMode in [tmMasterUpdate, tmMasterRestore]) and wbLoaderDone and not wbMasterUpdateDone then begin
    wbMasterUpdateDone := True;
    if wbLoaderError then begin
      wbDontSave := True;
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] --= Error =--');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] An error occured while loading your active modules.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Please look at the log above to determine which of your modules caused that problem.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] The most likely reason for this is a module file that contains structural errors.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + ']');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] !!! No changes have been made to any of your active modules.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] !!! You have to resolve the problem and run this program again.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + ']');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Loading and saving the problematic module in GECK can sometimes produce');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] a working version. But it is recommended to contact the author of the module');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] to get the original fixed.');
    end else try
      if (wbToolMode in [tmMasterRestore]) then
        ChangesMade := RestorePluginsFromMaster
      else
        ChangesMade := SetAllToMaster;
      SaveChanged;
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] --= All Done =--');
      if ChangesMade then begin
        PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] You have to close this program to finalize renaming of the .save files.');
        PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] It is still possible for the renaming to fail if any of your original module files is still open by another process.')
      end else begin
        PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Non of your active modules required changes.');
      end;
      if (wbToolMode in [tmMasterUpdate]) then begin
        PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + ']');
        PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] !!! Remember to run this program again any time you make changes to your active mods. !!!.');
      end;
    except
      wbDontSave := True;
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] --= Error =--');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] An error occured while trying to change the ESM flag or saving the modified files.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Please look at the log above to determine which of your modules caused that problem.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] The most likely reason for this is a module file that contains structural errors.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + ']');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] !!! No changes have been made to any of your active modules.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] !!! You have to resolve the problem and run this program again.');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + ']');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Loading and saving the problematic module in GECK can sometimes produce');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] a working version. But it is recommended to contact the author of the module');
      PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] to get the original fixed.');
    end;
  end;
end;

procedure TfrmMain.vstSpreadSheetAmmoInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  MainRecord                  : IwbMainRecord;
  Rec                         : IwbRecord;
begin
  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  if not Supports(NodeDatas[0].Element, IwbMainRecord, MainRecord) then
    Exit;

  NodeDatas[2].Element := MainRecord.RecordBySignature['EDID'];
  NodeDatas[3].Element := MainRecord.RecordBySignature['FULL'];
  NodeDatas[4].Element := MainRecord.RecordBySignature['ENAM'];

  Rec := MainRecord.RecordBySignature['DATA'];
  if Assigned(Rec) then begin
    NodeDatas[5].Element := Rec.ElementByName['Speed'];
    NodeDatas[6].Element := Rec.ElementByName['Value'];
    NodeDatas[7].Element := Rec.ElementByName['Weight'];
    NodeDatas[8].Element := Rec.ElementByName['Damage'];
  end;
end;

procedure TfrmMain.vstSpreadsheetArmorInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  MainRecord                  : IwbMainRecord;
  Rec                         : IwbRecord;
begin
  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  if not Supports(NodeDatas[0].Element, IwbMainRecord, MainRecord) then
    Exit;

  NodeDatas[2].Element := MainRecord.RecordBySignature['EDID'];
  NodeDatas[3].Element := MainRecord.RecordBySignature['FULL'];
  NodeDatas[4].Element := MainRecord.RecordBySignature['ENAM'];

  Rec := MainRecord.RecordBySignature['BMDT'];
  if Assigned(Rec) then begin
    NodeDatas[5].Element := Rec.Elements[0];
    NodeDatas[6].Element := Rec.Elements[1];
  end;

  Rec := MainRecord.RecordBySignature['DATA'];
  if Assigned(Rec) then begin
    NodeDatas[7].Element := Rec.Elements[0];
    NodeDatas[8].Element := Rec.Elements[1];
    NodeDatas[9].Element := Rec.Elements[2];
    NodeDatas[10].Element := Rec.Elements[3];
  end;
end;

procedure TfrmMain.vstViewAdvancedHeaderDraw(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
begin
  //...
end;

procedure TfrmMain.vstViewBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  NodeDatas                   : PViewNodeDatas;
  Factor                      : Double;
begin
  NodeDatas := Sender.GetNodeData(Node);
  Dec(Column);
  if Column > High(ActiveRecords) then
    Column := High(ActiveRecords);
  if Column >= 0 then begin
    if not Assigned(NodeDatas[Column].Element) or (Column = ActiveIndex) then begin

      Factor := 0.85;

      if not Assigned(NodeDatas[Column].Element) then
        Factor := Factor + 0.08;

      if Column = ActiveIndex then begin
        Factor := Factor - 0.04;
        if not Assigned(NodeDatas[Column].Element) then
          Factor := Factor + 0.015;
      end;

      if NodeDatas[Column].ConflictAll >= caNoConflict then
        TargetCanvas.Brush.Color := Lighter(ConflictAllToColor(NodeDatas[Column].ConflictAll), Factor)
      else
        Exit;

      TargetCanvas.FillRect(CellRect);

    end;
  end;
end;

procedure TfrmMain.vstViewBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  NodeDatas                   : PViewNodeDatas;
begin
  NodeDatas := Sender.GetNodeData(Node);
  if NodeDatas[0].ConflictAll = caUnknown then
    Assert(False);

  if NodeDatas[0].ConflictAll >= caNoConflict then
    ItemColor := Lighter(ConflictAllToColor(NodeDatas[0].ConflictAll), 0.85)
  else
    Exit;

  EraseAction := eaColor;
end;

procedure TfrmMain.vstViewCheckHotTrack(Sender: TBaseVirtualTree;
  HotNode: PVirtualNode; HotColumn: TColumnIndex; var Allow: Boolean);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  Allow := False;

  if HotColumn < 1 then
    Exit;
  if GetKeyState(VK_CONTROL) >= 0 then
    Exit;

  Dec(HotColumn);

  if (HotColumn < Low(ActiveRecords)) or (HotColumn > High(ActiveRecords)) then
    Exit;

  NodeDatas := vstView.GetNodeData(HotNode);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[HotColumn].Element;
  if not Assigned(Element) then
    Exit;

  Element := Element.LinksTo;
  while Assigned(Element) and (Element.ElementType <> etMainRecord) do
    Element := Element.Container;

  Allow := Assigned(Element) and not Element.Equals(ActiveRecord);
end;

procedure TfrmMain.vstViewClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if vstView.HotColumn < 1 then
    Exit;
  if GetKeyState(VK_CONTROL) >= 0 then
    Exit;
  if not vstView.HotTrack then
    Exit;

  if (Pred(vstView.HotColumn) < Low(ActiveRecords)) or (Pred(vstView.HotColumn) > High(ActiveRecords)) then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.HotNode);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Pred(vstView.HotColumn)].Element;
  if not Assigned(Element) then
    Exit;

  Element := Element.LinksTo;
  while Assigned(Element) and (Element.ElementType <> etMainRecord) do
    Element := Element.Container;

  if Assigned(Element) and not Element.Equals(ActiveRecord) then begin
    ForwardHistory := nil;
    JumpTo(Element as IwbMainRecord, False);
  end;
end;

procedure TfrmMain.vstViewCollapsing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
  Allowed := False;
end;

Type
  TwbComboEditLink = class(TComboEditLink)
    procedure SetBounds(R: TRect); override;
  end;

  TwbCheckComboEditLink = class(TcheckComboEditLink)
  end;

procedure TfrmMain.vstViewCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;

  {$IFNDEF LiteVersion}
  i                           : Integer;
  TextLink                    : TcxTextEditLink;
  ComboLink                   : TcxComboEditLink;
  CheckComboLink              : TcxCheckComboEditLink;
  {$ELSE}
  ComboLink                   : TwbComboEditLink;
  CheckComboLink              : TwbCheckComboEditLink;
  {$ENDIF}
begin
  if Column < 1 then
    Exit;
  if GetKeyState(VK_SHIFT) < 0 then
    Exit;

  Dec(Column);

  if (Column < Low(ActiveRecords)) or (Column > High(ActiveRecords)) then
    Exit;

  NodeDatas := vstView.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Column].Element;
  if not Assigned(Element) then
    Exit;

  case Element.EditType of
  {$IFNDEF LiteVersion}
    etDefault: begin
      TextLink := TcxTextEditLink.Create;
      EditLink := TextLink;
    end;
    etComboBox: begin
      ComboLink := TcxComboEditLink.Create;
      EditLink := ComboLink;
      if Element.ElementID <> EditInfoCacheID then begin
        EditInfoCacheID := Element.ElementID;
        EditInfoCache := Element.EditInfo;
      end;
      ComboLink.Properties.Items.CommaText := EditInfoCache;
      ComboLink.Properties.Sorted := True;
    end;
    etCheckComboBox: begin
      CheckComboLink := TcxCheckComboEditLink.Create;
      EditLink := CheckComboLink;
      with TStringList.Create do try
        CommaText := Element.EditInfo;
        for i := 0 to Pred(Count) do
          CheckComboLink.Properties.Items.AddCheckItem(Strings[i]);
        CheckComboLink.Properties.DropDownRows := Count;
        if CheckComboLink.Properties.DropDownRows > 32 then
          CheckComboLink.Properties.DropDownRows := 32;
      finally
        Free;
      end;
      CheckComboLink.Properties.Delimiter := ', ';
      CheckComboLink.Properties.ShowEmptyText := False;
//      CheckComboLink.Properties.DropDownSizeable := True;
      CheckComboLink.Properties.DropDownAutoWidth := True;
    end;
    {$ELSE}
    etComboBox: begin
      ComboLink := TwbComboEditLink.Create(Self);
      EditLink := ComboLink;
      if Element.ElementID <> EditInfoCacheID then begin
        EditInfoCacheID := Element.ElementID;
        EditInfoCache := Element.EditInfo;
      end;
      ComboLink.PickList.CommaText := EditInfoCache;
      ComboLink.Sorted := True;
    end;
    etCheckComboBox: begin
      CheckComboLink := TwbCheckComboEditLink.Create;
      EditLink := CheckComboLink;
      if Element.ElementID <> EditInfoCacheID then begin
        EditInfoCacheID := Element.ElementID;
        EditInfoCache := Element.EditInfo;
      end;
      CheckComboLink.PickList.CommaText := EditInfoCache;
    end;
  {$ENDIF}
  end;
end;

procedure TfrmMain.vstViewDblClick(Sender: TObject);
var
  NodeDatas                   : PViewNodeDatas;
  i                           : Integer;
  ModalEdit                   : Boolean;
begin
  UserWasActive := True;

  if (vstView.FocusedColumn = 0) and ComparingSiblings then begin
    mniViewSort.Click;
    Exit;
  end;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then begin
    with TfrmViewElements.Create(nil) do begin
      Caption := vstView.Path(vstView.FocusedNode, 0, ttNormal, '\');
      Settings := Self.Settings;
      if Assigned(ActiveMaster) then
        Caption := ActiveMaster.Name + '\' + Caption;

      ModalEdit := GetKeyState(VK_SHIFT) < 0;

      for i := Low(ActiveRecords) to High(ActiveRecords) do
        AddElement(NodeDatas[i].Element, vstView.FocusedColumn = Succ(i),
          ModalEdit and Assigned(NodeDatas[i].Element) and NodeDatas[i].Element.IsEditable);
      if not ModalEdit then
        Show
      else
        ShowModal;
    end;
  end;
end;

procedure TfrmMain.vstViewDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  NodeDatas                   : PViewNodeDatas;
begin
  Allowed := False;
  if not wbEditAllowed then
    Exit;
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;
  NodeDatas := vstView.GetNodeData(Node);
  Allowed := Assigned(NodeDatas[Column].Element);
end;

procedure TfrmMain.vstViewDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  TargetElement               : IwbElement;
  SourceElement               : IwbElement;
  TargetNode                  : PVirtualNode;
  TargetIndex                 : Integer;
begin
  if not wbEditAllowed then
    Exit;

  UserWasActive := True;

  if GetDragElements(Sender, Source, TargetNode, TargetIndex, TargetElement, SourceElement) then begin

    if not EditWarn then
      Exit;

    if not AddRequiredMasters(SourceElement, TargetElement._File, False) then
      Exit;

    vstView.BeginUpdate;
    try
      TargetElement.Assign(TargetIndex, SourceElement, False);
      ActiveRecords[Pred(Sender.DropTargetColumn)].UpdateRefs;
      TargetElement := nil;
      SourceElement := nil;
      PostResetActiveTree;
    finally
      vstView.EndUpdate;
    end;
    InvalidateElementsTreeView(NoNodes);
  end;
end;

procedure TfrmMain.vstViewDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  TargetNode                  : PVirtualNode;
  TargetIndex                 : Integer;
  TargetElement               : IwbElement;
  SourceElement               : IwbElement;
begin
  Accept := False;

  if not wbEditAllowed then
    Exit;

  Accept := GetDragElements(Sender, Source, TargetNode, TargetIndex, TargetElement, SourceElement) and
    (TargetElement <> SourceElement) and
    TargetElement.CanAssign(TargetIndex, SourceElement, True);
end;

procedure TfrmMain.vstViewEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  Allowed := False;

  if not wbEditAllowed then
    Exit;

  if Column < 1 then
    Exit;
  Dec(Column);

  if Column > High(ActiveRecords) then
    Exit;

  NodeDatas := vstView.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Column].Element;

  if not Assigned(Element) then
    Exit;

  Allowed := Element.IsEditable and EditWarn;
end;

procedure TfrmMain.vstViewFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  if Column <> LastViewColumn then begin
    if ComparingSiblings then
      vstView.Invalidate
    else
      vstView.InvalidateColumn(0);

    LastViewColumn := Column;
  end;
end;

procedure TfrmMain.vstViewFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
  //  if NewColumn < 1 then
  //    Exit;
  if (NewColumn = Pred(TVirtualEditTree(Sender).Header.Columns.Count)) and (Length(ActiveRecords) > 1) then
    Exit;
  Allowed := True;
end;

procedure TfrmMain.vstViewFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeDatas                   : PViewNodeDatas;
  i                           : integer;
begin
  NodeDatas := Sender.GetNodeData(Node);

  for i := Low(ActiveRecords) to High(ActiveRecords) do begin
    NodeDatas[i].Element := nil;
    NodeDatas[i].Container := nil;
  end;
end;

procedure TfrmMain.vstViewGetEditText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var CellText: string);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  CellText := '';
  if Column < 1 then
    Exit;
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;

  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Column].Element;
  if Assigned(Element) and Element.IsEditable then
    CellText := Element.EditValue;
end;

procedure TfrmMain.vstViewGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: string);
begin
  if GetKeyState(VK_SHIFT) < 0 then
    HintText := vstView.Text[Node, Column, False];
end;

procedure TfrmMain.vstViewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  i                           : Integer;
begin
  CellText := '';
  NodeDatas := Sender.GetNodeData(Node);

  if Pred(Column) > High(ActiveRecords) then
    Exit;

  if Column < 1 then begin

    if (vstView.FocusedColumn > 0) and (Pred(vstView.FocusedColumn) <= High(ActiveRecords)) then
      Element := NodeDatas[Pred(vstView.FocusedColumn)].Element;
    if not Assigned(Element) then
      for i := Low(ActiveRecords) to High(ActiveRecords) do begin
        Element := NodeDatas[i].Element;
        if Assigned(Element) then
          Break;
      end;

  end else
    Element := NodeDatas[Pred(Column)].Element;

  if Assigned(Element) then begin
    if TextType = ttNormal then begin
      if Column < 1 then
        CellText := Element.DisplayName
      else begin
        if (Element.ConflictPriority <> cpIgnore) or not wbHideIgnored then
          CellText := Element.Value;
      end;
    end
  end else if TextType = ttNormal then
    if Column < 1 then begin
      NodeDatas := Sender.GetNodeData(Node.Parent);
      if not Assigned(NodeDatas) then
        NodeDatas := @ActiveRecords[0];
      for i := Low(ActiveRecords) to High(ActiveRecords) do begin
        Element := NodeDatas[i].Container;
        if Assigned(Element) then
          Break;
      end;
      if Assigned(Element) and (Element.ElementType in [etMainRecord, etSubRecordStruct]) then begin
        i := (Element as IwbContainer).AdditionalElementCount;
        if Integer(Node.Index) >= i then
          with (Element.Def as IwbRecordDef).Members[Integer(Node.Index) - i] do begin
            if DefType = dtSubRecord then
              CellText := Displayable(DefaultSignature) + ' - ' + GetName
            else
              CellText := GetName;
          end
        else
          CellText := Element.Name;
      end;
    end;
end;

procedure TfrmMain.vstViewHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
var
  i        : Integer;
  ColWidth : Integer;
begin
  with HitInfo do begin
    if vstView.Header.Columns.Count < 3 then
      Exit;
    if Column = 0 then
      if Shift = [ssShift] then begin
        ColWidth := wbColumnWidth;
        for i := 0 to Pred(vstView.Header.Columns.Count) do
          vstView.Header.Columns[i].Width := ColWidth;
      end else case Button of
        mbLeft: begin
          ColWidth := (vstView.ClientWidth - vstView.Header.Columns[0].Width) div (vstView.Header.Columns.Count - 2);
          for i := 1 to (vstView.Header.Columns.Count - 2) do
            vstView.Header.Columns[i].Width := ColWidth;
        end;
        mbRight:
          vstView.Header.AutoFitColumns(False);
      end;
  end;
end;

procedure TfrmMain.vstViewHeaderDrawQueryElements(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
begin
  if Assigned(PaintInfo.Column) and
    (PaintInfo.Column.Index > 0) and
    (PaintInfo.Column.Index <= Length(ActiveRecords)) then begin

    if ActiveRecords[Pred(PaintInfo.Column.Index)].Element.Modified then
      PaintInfo.TargetCanvas.Font.Style := [fsBold]
    else
      PaintInfo.TargetCanvas.Font.Style := [];

    if ActiveRecords[Pred(PaintInfo.Column.Index)].Element.IsInjected then
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style + [fsItalic]
    else
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style - [fsItalic];

    if ActiveRecords[Pred(PaintInfo.Column.Index)].Element.IsNotReachable then
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style + [fsStrikeOut]
    else
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style - [fsStrikeOut];

    if ActiveRecords[Pred(PaintInfo.Column.Index)].Element.ReferencesInjected then
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style + [fsUnderline]
    else
      PaintInfo.TargetCanvas.Font.Style := PaintInfo.TargetCanvas.Font.Style - [fsUnderline];

    if ActiveRecords[0].ConflictAll = caUnknown then
      Assert(False);

    if ActiveRecords[0].ConflictAll >= caNoConflict then
      Sender.Background := Lighter(ConflictAllToColor(ActiveRecords[0].ConflictAll), 0.85);
    PaintInfo.TargetCanvas.Brush.Color := Sender.Background;
    Sender.Font.Color := ConflictThisToColor(
      ActiveRecords[Pred(PaintInfo.Column.Index)].ConflictThis);
  end;
end;

procedure TfrmMain.vstViewInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
begin
  InitChilds(Sender.GetNodeData(Node), Length(ActiveRecords), ChildCount);
end;

procedure TfrmMain.vstViewInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeDatas                   : PViewNodeDatas;
  ParentDatas                 : PViewNodeDatas;
begin
  NodeDatas := Sender.GetNodeData(Node);
  ParentDatas := Sender.GetNodeData(ParentNode);
  if not Assigned(ParentDatas) then
    ParentDatas := @ActiveRecords[0];
  InitNodes(NodeDatas, ParentDatas, Length(ActiveRecords), Node.Index, InitialStates);
end;

procedure TfrmMain.vstViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  Column                      : TColumnIndex;
begin
  UserWasActive := True;

  if not wbEditAllowed then
    Exit;

  Column := Pred(vstView.FocusedColumn);

  if Column > High(ActiveRecords) then
    Exit;
  if Column < Low(ActiveRecords) then
    Exit;

  NodeDatas := vstView.GetNodeData(vstView.FocusedNode);
  if Assigned(NodeDatas) then
    Element := NodeDatas[Column].Element;

  if Shift = [ssCtrl] then begin
    if not Assigned(Element) then
      Exit;

    case Key of
      VK_UP: begin
        if not Element.CanMoveUp then
          Exit;
        Key := 0;
        Element.MoveUp;
        vstView.FocusedNode := vstView.GetPreviousSibling(vstView.FocusedNode);
      end;
      VK_DOWN: begin
        if not Element.CanMoveDown then
          Exit;
        Key := 0;
        Element.MoveDown;
        vstView.FocusedNode := vstView.GetNextSibling(vstView.FocusedNode);
      end;
      Ord('C'): begin
        Clipboard.AsText := Element.EditValue;
        //vstView.CopyToClipBoard;
        Exit;
      end;
    else
      Exit;
    end;

    PostResetActiveTree;

  end else if Shift = [] then begin

    case Key of
      VK_INSERT: begin
        pmuViewPopup(nil);
        Key := 0;
        if mniViewAdd.Visible and mniViewAdd.Enabled then
          mniViewAdd.Click;
      end;
      VK_DELETE: begin
        pmuViewPopup(nil);
        Key := 0;
        if mniViewRemove.Visible and mniViewRemove.Enabled then
          mniViewRemove.Click;
      end;
    else
      Exit;
    end;

    PostResetActiveTree;

  end;

end;

procedure TfrmMain.vstViewNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  UserWasActive := True;

  if Pred(Column) > High(ActiveRecords) then
    Exit;

  NodeDatas := vstView.GetNodeData(Node);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Pred(Column)].Element;
    if Assigned(Element) and Element.IsEditable then begin

      if not EditWarn then
        Exit;

      //      vstView.BeginUpdate;
      try

        Element.EditValue := NewText;
        ActiveRecords[Pred(vstView.FocusedColumn)].UpdateRefs;
        Element := nil;
        PostResetActiveTree;
      finally
        //        vstView.EndUpdate;
      end;

      InvalidateElementsTreeView(NoNodes);

    end;
  end;
end;

procedure TfrmMain.vstViewPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeDatas                   : PViewNodeDatas;
  Element                     : IwbElement;
  i                           : Integer;
  ConflictThis                : TConflictThis;
  Modified                    : Boolean;
  ReferencesInjected          : Boolean;
  SortKeyFocus                : string;
  SortKeyThis                 : string;
  FocusedColumn               : TColumnIndex;
begin
  NodeDatas := Sender.GetNodeData(Node);
  Dec(Column);
  if Column > High(ActiveRecords) then
    Exit;

  Modified := False;
  ReferencesInjected := False;
  if Column >= 0 then begin
    Element := NodeDatas[Column].Element;
    if Assigned(Element) then begin
      Modified := Element.Modified;
      ReferencesInjected := Element.ReferencesInjected;
    end;
    ConflictThis := NodeDatas[Column].ConflictThis
  end
  else begin
    ConflictThis := ctUnknown;
    for i := Low(ActiveRecords) to High(ActiveRecords) do begin
      if NodeDatas[i].ConflictThis > ConflictThis then
        ConflictThis := NodeDatas[i].ConflictThis;
      if not Modified then begin
        Element := NodeDatas[i].Element;
        if Assigned(Element) then
          Modified := Element.Modified;
      end;
      if not ReferencesInjected then begin
        Element := NodeDatas[i].Element;
        if Assigned(Element) then
          ReferencesInjected := Element.ReferencesInjected;
      end;
    end;
  end;

  FocusedColumn := Pred(vstView.FocusedColumn);

  if ComparingSiblings and (Column >= 0) and (FocusedColumn >= 0) and (Column <= High(ActiveRecords)) and (FocusedColumn <= High(ActiveRecords)) then
    if Column = FocusedColumn then
      ConflictThis := ctMaster
    else begin

      Element := NodeDatas[FocusedColumn].Element;
      if Assigned(Element) then
        SortKeyFocus := Element.SortKey[True]
      else
        SortKeyFocus := '';

      Element := NodeDatas[Column].Element;
      if Assigned(Element) then
        SortKeyThis := Element.SortKey[True]
      else
        SortKeyThis := '';

      if SameStr(SortKeyFocus, SortKeyThis) then
        ConflictThis := ctOverride
      else
        ConflictThis := ctConflictLoses;

    end;

  TargetCanvas.Font.Color := ConflictThisToColor(ConflictThis);

  if Modified then
    TargetCanvas.Font.Style := [fsBold];
  if ReferencesInjected then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsItalic];
end;

procedure TfrmMain.vstViewResize(Sender: TObject);
begin
  if mniViewColumnWidthFitAll.Checked then
    UpdateColumnWidths;
end;

procedure TfrmMain.vstNavBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
begin
  if wbLoaderDone then begin
    NodeData := Sender.GetNodeData(Node);

    if Assigned(NodeData) and Assigned(NodeData.Element) and
      (NodeData.Element.ElementType = etMainRecord) then begin
      MainRecord := NodeData.Element as IwbMainRecord;

      if NodeData.ConflictAll = caUnknown then begin
        ConflictLevelForMainRecord(MainRecord, NodeData.ConflictAll, NodeData.ConflictThis);
        if MainRecord.IsInjected then
          Include(NodeData.Flags, nnfInjected)
        else
          Exclude(NodeData.Flags, nnfInjected);
        if MainRecord.IsNotReachable then
          Include(NodeData.Flags, nnfNotReachable)
        else
          Exclude(NodeData.Flags, nnfNotReachable);
        if MainRecord.ReferencesInjected then
          Include(NodeData.Flags, nnfReferencesInjected)
        else
          Exclude(NodeData.Flags, nnfReferencesInjected);
      end;
    end;

    if NodeData.ConflictAll >= caNoConflict then
      ItemColor := Lighter(ConflictAllToColor(NodeData.ConflictAll), 0.85)
    else
      Exit;

    EraseAction := eaColor;
  end;
end;

procedure TfrmMain.vstNavChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  s, t, u                     : string;
begin
  NodeData := Sender.GetNodeData(Sender.FocusedNode);
  if Assigned(NodeData) then begin
    Element := NodeData.Element;
    if Assigned(Element) then
      if Element.ElementType <> etMainRecord then
        Element := nil;

    if NodeData.ConflictAll >= caNoConflict then
      lblPath.Color := Lighter(ConflictAllToColor(NodeData.ConflictAll), 0.85)
    else
      lblPath.Color := vstNav.Color;

    lblPath.Font.Color := ConflictThisToColor(NodeData.ConflictThis);

    s := '';
    while Assigned(Node) do begin
      if s <> '' then
        s := ' \ ' + s;
      t := vstNav.Text[Node, 0, False];
      u := vstNav.Text[Node, 1, False];
      if u <> '' then
        u := ' <' + u + '>';
      s := t + u + s;
      Node := vstNav.NodeParent[Node];
    end;
    s := ' ' + s;
    lblPath.Text := s;
    lblPath.Visible := True;
  end
  else begin
    lblPath.Visible := False;
  end;
  SetActiveRecord(Element as IwbMainRecord);
end;

function FindSortElement(const aElement: IwbElement): IwbElement;
var
  GroupRecord                 : IwbGroupRecord;
begin
  if Supports(aElement, IwbGroupRecord, GroupRecord) then begin
    Result := GroupRecord.ChildrenOf;
    if Assigned(Result) then
      Exit;
  end;
  Result := aElement;
end;

procedure TfrmMain.vstNavCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Element1                    : IwbElement;
  Element2                    : IwbElement;
  SortElement1                : IwbElement;
  SortElement2                : IwbElement;
  GroupRecord1                : IwbGroupRecord;
  GroupRecord2                : IwbGroupRecord;
  MainRecord1                 : IwbMainRecord;
  MainRecord2                 : IwbMainRecord;
begin
  Element1 := PNavNodeData(Sender.GetNodeData(Node1)).Element;
  Element2 := PNavNodeData(Sender.GetNodeData(Node2)).Element;

  if Element1 = Element2 then begin
    Result := 0;
    Exit;
  end;

  if Assigned(Element1) <> Assigned(Element2) then begin
    if Assigned(Element1) then
      Result := -1
    else
      Result := 1;
    Exit;
  end
  else if not Assigned(Element1) then begin
    Result := 0;
    Exit;
  end;

  {"ChildrenOf" groups always sort like their owner}
  SortElement1 := FindSortElement(Element1);
  SortElement2 := FindSortElement(Element2);

  if Assigned(SortElement1) <> Assigned(SortElement2) then begin
    if Assigned(SortElement1) then
      Result := -1
    else
      Result := 1;
    Exit;
  end
  else if not Assigned(SortElement1) then begin
    Result := 0;
    Exit;
  end;

  Result := CmpI32(Ord(SortElement1.ElementType), Ord(SortElement2.ElementType));
  if Result = 0 then
    case SortElement1.ElementType of
      etFile: begin
          Assert(SortElement2.ElementType = etFile);

          if mniNavHeaderFilesLoadOrder.Checked then
            Column := 0
          else if mniNavHeaderFilesFileName.Checked then
            Column := 1;

          case Column of
            1, 2: Result := CompareText((SortElement1 as IwbFile).FileName, (SortElement2 as IwbFile).FileName);
          else
            Result := CmpB8((SortElement1 as IwbFile).LoadOrder, (SortElement2 as IwbFile).LoadOrder);
          end;

          Exit;
        end;
      etGroupRecord: begin
          Assert(SortElement2.ElementType = etGroupRecord);
          GroupRecord1 := SortElement1 as IwbGroupRecord;
          GroupRecord2 := SortElement2 as IwbGroupRecord;
          Assert(GroupRecord1.GroupType = GroupRecord2.GroupType);
          case GroupRecord1.GroupType of
            0: Result := CompareText(
                TwbSignature(GroupRecord1.GroupLabel),
                TwbSignature(GroupRecord2.GroupLabel));
            2, 3: Result := CmpI32(
                Integer(GroupRecord1.GroupLabel),
                Integer(GroupRecord2.GroupLabel));
            4, 5: begin
                Result := CmpI32(
                  LongRecSmall(GroupRecord1.GroupLabel).Hi,
                  LongRecSmall(GroupRecord2.GroupLabel).Hi);
                if Result = 0 then
                  Result := CmpI32(
                    LongRecSmall(GroupRecord1.GroupLabel).Lo,
                    LongRecSmall(GroupRecord2.GroupLabel).Lo);
              end;
          else
            Assert(False);
          end;
        end;
      etMainRecord: begin
          Assert(SortElement2.ElementType = etMainRecord);
          MainRecord1 := SortElement1 as IwbMainRecord;
          MainRecord2 := SortElement2 as IwbMainRecord;
          Result := 0;
          case Column of
            1: Result := CompareText(MainRecord1.EditorID, MainRecord2.EditorID);
            2: Result := CompareText(MainRecord1.DisplayNameKey, MainRecord2.DisplayNameKey);
          end;
          if Result = 0 then begin
            Result := CmpI32(MainRecord1.SortPriority, MainRecord2.SortPriority);
            if Result = 0 then begin
              Result := CmpW32(MainRecord1.LoadOrderFormID, MainRecord2.LoadOrderFormID);
              if Result = 0 then
                Result := CmpW32(Cardinal(Pointer(MainRecord1)), Cardinal(Pointer(MainRecord2)));
            end;
          end;
        end
    else
      Assert(False);
    end;

  if Result = 0 then
    if Element1 <> SortElement1 then begin
      if Element2 <> SortElement2 then begin
        {both are groups of the same element }
        GroupRecord1 := Element1 as IwbGroupRecord;
        GroupRecord2 := Element2 as IwbGroupRecord;
        Result := CmpI32(GroupRecord1.GroupType, GroupRecord2.GroupType);
        if Result = 0 then
          Result := CmpW32(GroupRecord1.GroupLabel, GroupRecord2.GroupLabel);
      end
      else begin
        {element1 is a group of element2}
        Result := 1;
      end;
    end
    else begin
      if Element2 <> SortElement2 then begin
        {element2 is a group of element1}
        Result := -1;
      end
      else begin
        {really seems to be the same}
      end;
    end;
end;

procedure TfrmMain.vstNavExpanding(Sender: TBaseVirtualTree; Node: PVirtualNode;
  var Allowed: Boolean);
begin
  // Fullexpand when Alt is pressed
  // No fullexpand if script is running because it can be hotkeyed to Alt+...
  // and use JumpTo() command which expands the navigation tree
  if (GetKeyState(VK_MENU) < 0) and not Assigned(ScriptEngine) then
    Sender.FullExpand(Node);
end;

procedure TfrmMain.vstNavFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  with PNavNodeData(Sender.GetNodeData(Node))^ do begin
    Element := nil;
    Container := nil;
  end;
end;

procedure TfrmMain.vstNavGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
  GroupRecord                 : IwbGroupRecord;
begin
  CellText := '';

  Element := PNavNodeData(Sender.GetNodeData(Node)).Element;

  if Assigned(Element) then begin
    if TextType = ttNormal then begin
      if Element.ElementType = etGroupRecord then begin
        GroupRecord := Element as IwbGroupRecord;
        if Column < 1 then
          CellText := GroupRecord.ShortName;
        Exit;
      end
      else if Element.ElementType = etMainRecord then begin
        MainRecord := Element as IwbMainRecord;
        case Column of
          -1, 0: begin
              if MainRecord.Signature = 'TES4' then
                CellText := 'File Header'
              else
                CellText := IntToHex64(MainRecord.LoadOrderFormID, 8)
            end;
          1: CellText := MainRecord.EditorID;
          2: CellText := MainRecord.DisplayName;
        end;
        Exit;
      end;

      if Column < 1 then
        CellText := Element.Name
      else
        CellText := Element.Value;
    end
    else begin
      if (Column < 1) and (Element.ElementType = etMainRecord) then begin
        if Supports(Element.Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType in [1, 8..10]) then begin
          MainRecord := Element as IwbMainRecord;
          if Assigned(MainRecord.Def) then
            CellText := MainRecord.Def.GetName
          else
            CellText := MainRecord.Signature;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.vstNavHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  with HitInfo do begin
    UserWasActive := True;

    if Button <> mbLeft then
      Exit;

    if Sender.SortColumn = Column then
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending
    else begin
      Sender.SortColumn := Column;
    end;
    vstNav.ScrollIntoView(vstNav.FocusedNode, True);
  end;
end;

procedure TfrmMain.vstNavIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
  GroupRecord                 : IwbGroupRecord;
  _File                       : IwbFile;
  CompareText                 : string;
  s                           : string;
  i                           : Integer;
begin
  UserWasActive := True;

  Result := 1;

  CompareText := '';

  Element := PNavNodeData(Sender.GetNodeData(Node)).Element;
  if Assigned(Element) then
    if Element.ElementType = etGroupRecord then begin
      GroupRecord := Element as IwbGroupRecord;
      if GroupRecord.GroupType = 0 then
        CompareText := GroupRecord.ShortName;
    end
    else if Element.ElementType = etMainRecord then begin
      MainRecord := Element as IwbMainRecord;
      case vstNav.Header.SortColumn of
        -1, 0: begin
            if MainRecord.Signature = 'TES4' then
              CompareText := 'File Header'
            else
              CompareText := IntToHex64(MainRecord.LoadOrderFormID, 8)
          end;
        1: CompareText := MainRecord.EditorID;
        2: CompareText := MainRecord.DisplayName;
      end;
    end
    else if Element.ElementType = etFile then begin
      _File := Element as IwbFile;
      CompareText := _File.FileName;
    end;

  s := SearchText;

  if Length(s) > Length(CompareText) then
    Exit;

  for i := 1 to Length(s) do
    if UpCase(s[i]) <> UpCase(CompareText[i]) then
      Exit;

  Result := 0;
end;

procedure TfrmMain.vstNavInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  Container                   : IwbContainer;
begin
  Container := PNavNodeData(Sender.GetNodeData(Node)).Container;

  if Assigned(Container) then
    ChildCount := Container.ElementCount
  else
    ChildCount := 0;
end;

procedure TfrmMain.vstNavInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData                    : PNavNodeData;
  Element                     : IwbElement;
  Container                   : IwbContainerElementRef;
  GroupRecord                 : IwbGroupRecord;
begin
  GroupRecord := nil;
  NodeData := PNavNodeData(Sender.GetNodeData(Node));
  Element := NodeData.Element;
  if Element = nil then begin
    Container := PNavNodeData(Sender.GetNodeData(Node.Parent)).Container as IwbContainerElementRef;
    if Assigned(Container) and (Node.Index < Cardinal(Container.ElementCount)) then begin
      Element := Container.Elements[Node.Index];
      if Element.ElementType = etMainRecord then
        if Integer(Succ(Node.Index)) < Container.ElementCount then begin
          if Supports(Container.Elements[Succ(Node.Index)], IwbGroupRecord, GroupRecord) then begin
            if (not (GroupRecord.GroupType in [1, 6, 7])) or
              ((Element as IwbMainRecord).FormID <> GroupRecord.GroupLabel) then
              GroupRecord := nil;
          end;
        end;
      NodeData.Element := Element;
    end
    else
      Element := nil;
  end;

  if not Assigned(Element) then begin
    Include(InitialStates, ivsHidden);
    Exit;
  end;

  if Element.ElementType <> etMainRecord then begin
    if Supports(Element, IwbContainerElementRef, Container) and (Container.ElementCount > 0) then begin
      Include(InitialStates, ivsHasChildren);
      NodeData.Container := IInterface(Container) as IwbContainer;
    end
  end
  else if Assigned(GroupRecord) then begin
    if GroupRecord.ElementCount > 0 then
      Include(InitialStates, ivsHasChildren);
    NodeData.Container := GroupRecord;
  end;

  if Node.Index > 0 then
    if Supports(Element, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType in [1, 6, 7]) then begin
      Container := PNavNodeData(Sender.GetNodeData(Node.Parent)).Container as IwbContainerElementRef;
      if Assigned(Container) and (Integer(Node.Index) < Container.ElementCount) then begin
        Element := Container.Elements[Pred(Node.Index)];
        if (Element.ElementType = etMainRecord) and
          ((Element as IwbMainRecord).FormID = GroupRecord.GroupLabel) then begin
          Include(InitialStates, ivsHidden);
          Exclude(InitialStates, ivsHasChildren);
          NodeData.Container := nil;
          NodeData.Element := nil;
          Exit;
        end;
      end;
    end;
end;

procedure TfrmMain.vstNavKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  r: TRect;
  p: TPoint;
begin
  case Key of
    VK_DELETE: begin
      pmuNavPopup(nil);
      if mniNavRemove.Enabled and mniNavRemove.Visible then
        mniNavRemove.Click;
    end;
    VK_INSERT: begin
      pmuNavPopup(nil);
      if mniNavAdd.Enabled and mniNavAdd.Visible then begin
        if mniNavAdd.Count = 1 then
          mniNavAdd.Items[0].Click
        else begin
          r := vstNav.GetDisplayRect(vstNav.FocusedNode, 0, True);
          p := vstNav.ClientToScreen(Point(r.Left, r.Bottom));
          pmuNavAdd.Popup(p.X, p.Y);
        end;
      end;
    end;
    VK_F2: begin
      pmuNavPopup(nil);
      if mniNavChangeFormID.Enabled and mniNavChangeFormID.Visible then
        mniNavChangeFormID.Click;
    end;
  end;
end;

procedure TfrmMain.vstNavPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeData                    : PNavNodeData;
  MainRecord                  : IwbMainRecord;
begin
  TargetCanvas.Font.Color := clWindowText;
  if wbLoaderDone then begin
    NodeData := Sender.GetNodeData(Node);

    MainRecord := nil;
    if Assigned(NodeData) and Assigned(NodeData.Element) then begin
      if (NodeData.Element.ElementType = etMainRecord) then begin
        MainRecord := NodeData.Element as IwbMainRecord;

        if NodeData.ConflictThis = ctUnknown then begin
          ConflictLevelForMainRecord(MainRecord, NodeData.ConflictAll, NodeData.ConflictThis);
          if MainRecord.IsInjected then
            Include(NodeData.Flags, nnfInjected)
          else
            Exclude(NodeData.Flags, nnfInjected);
          if MainRecord.IsNotReachable then
            Include(NodeData.Flags, nnfNotReachable)
          else
            Exclude(NodeData.Flags, nnfNotReachable);
          if MainRecord.ReferencesInjected then
            Include(NodeData.Flags, nnfReferencesInjected)
          else
            Exclude(NodeData.Flags, nnfReferencesInjected);
        end;
      end;
      if NodeData.Element.Modified then
        TargetCanvas.Font.Style := [fsBold];
      if nnfInjected in NodeData.Flags then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsItalic]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsItalic];
      if nnfNotReachable in NodeData.Flags then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsStrikeOut]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsStrikeOut];
      if nnfReferencesInjected in NodeData.Flags then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsUnderline];
    end;

    TargetCanvas.Font.Color := ConflictThisToColor(NodeData.ConflictThis);
  end;
end;

procedure TfrmMain.vstSpreadSheetCheckHotTrack(Sender: TBaseVirtualTree; HotNode: PVirtualNode; HotColumn: TColumnIndex; var Allow: Boolean);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  Element                     : IwbElement;
begin
  Allow := False;

  if GetKeyState(VK_CONTROL) >= 0 then
    Exit;

  if (HotColumn < 1) or (HotColumn >= TVirtualEditTree(Sender).Header.Columns.Count) then
    Exit;

  NodeDatas := Sender.GetNodeData(HotNode);
  if not Assigned(NodeDatas) then
    Exit;

  if HotColumn = 1 then begin
    Element := NodeDatas[0].Element
  end
  else begin
    Element := NodeDatas[HotColumn].Element;

    if not Assigned(Element) then
      Exit;

    Element := Element.LinksTo;
    while Assigned(Element) and (Element.ElementType <> etMainRecord) do
      Element := Element.Container;
  end;

  Allow := Assigned(Element);
end;

procedure TfrmMain.vstSpreadSheetCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeDatas1                  : PSpreadSheetNodeDatas;
  NodeDatas2                  : PSpreadSheetNodeDatas;

  Element1                    : IwbElement;
  Element2                    : IwbElement;
begin
  NodeDatas1 := PSpreadSheetNodeDatas(Sender.GetNodeData(Node1));
  NodeDatas2 := PSpreadSheetNodeDatas(Sender.GetNodeData(Node2));

  if NodeDatas1 = NodeDatas2 then begin
    Result := 0;
    Exit;
  end;

  if Column < 2 then begin
    Element1 := NodeDatas1[0].Element;
    Element2 := NodeDatas2[0].Element;
  end
  else begin
    Element1 := NodeDatas1[Column].Element;
    Element2 := NodeDatas2[Column].Element;
  end;

  if Assigned(Element1) <> Assigned(Element2) then begin
    if Assigned(Element1) then
      Result := -1
    else
      Result := 1;
    Exit;
  end
  else if not Assigned(Element1) then begin
    Result := 0;
    Exit;
  end;

  case Column of
    0: Result := CompareText(Element1._File.FileName, Element2._File.FileName);
    1: Result := CmpW32((Element1 as IwbMainRecord).LoadOrderFormID, (Element2 as IwbMainRecord).LoadOrderFormID);
  else
    Result := CompareStr(Element1.SortKey[True], Element2.SortKey[True]);
  end;
end;

procedure TfrmMain.vstSpreadSheetDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
begin
  Allowed := False;
  if not wbEditAllowed then
    Exit;
  if Column < Sender.Tag then
    Exit;
  NodeDatas := Sender.GetNodeData(Node);
  Allowed := Assigned(NodeDatas[Column].Element);
end;

procedure TfrmMain.vstSpreadSheetDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  TargetElement               : IwbElement;
  SourceElement               : IwbElement;
begin
  if not wbEditAllowed then
    Exit;
  if Source <> Sender then
    Exit;

  UserWasActive := True;

  if Sender.DropTargetColumn < Sender.Tag then
    Exit;
  NodeDatas := Sender.GetNodeData(Sender.DropTargetNode);
  TargetElement := NodeDatas[Sender.DropTargetColumn].Element;
  if not Assigned(TargetElement) then
    Exit;

  if TVirtualEditTree(Sender).DragColumn < Sender.Tag then
    Exit;
  if Length(TVirtualEditTree(Sender).DragSelection) <> 1 then
    Exit;

  NodeDatas := Sender.GetNodeData(TVirtualEditTree(Sender).DragSelection[0]);
  SourceElement := NodeDatas[TVirtualEditTree(Sender).DragColumn].Element;
  if not Assigned(SourceElement) then
    Exit;

  if TargetElement.Equals(SourceElement) then
    Exit;

  if not TargetElement.CanAssign(Low(Integer), SourceElement, True) then
    Exit;

  if not EditWarn then
    Exit;

  TargetElement.Assign(Low(Integer), SourceElement, False);
end;

procedure TfrmMain.vstSpreadSheetDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  TargetElement               : IwbElement;
  SourceElement               : IwbElement;
begin
  Accept := True;
  if not wbEditAllowed then
    Exit;
  if Source <> Sender then
    Exit;

  if Sender.DropTargetColumn < Sender.Tag then
    Exit;
  NodeDatas := Sender.GetNodeData(Sender.DropTargetNode);
  TargetElement := NodeDatas[Sender.DropTargetColumn].Element;
  if not Assigned(TargetElement) then
    Exit;

  if TVirtualEditTree(Sender).DragColumn < Sender.Tag then
    Exit;
  if Length(TVirtualEditTree(Sender).DragSelection) <> 1 then
    Exit;

  NodeDatas := Sender.GetNodeData(TVirtualEditTree(Sender).DragSelection[0]);
  SourceElement := NodeDatas[TVirtualEditTree(Sender).DragColumn].Element;
  if not Assigned(SourceElement) then
    Exit;

  if TargetElement.Equals(SourceElement) then
    Exit;

  if not TargetElement.CanAssign(Low(Integer), SourceElement, True) then
    Exit;

  Accept := True;
end;

procedure TfrmMain.vstSpreadSheetEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  Element                     : IwbElement;
begin
  Allowed := False;

  if not wbEditAllowed then
    Exit;

  if Column < Sender.Tag then
    Exit;

  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Column].Element;

  if not Assigned(Element) then
    Exit;

  Allowed := Element.IsEditable and EditWarn;
end;

procedure TfrmMain.vstSpreadSheetFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  i                           : integer;
begin
  NodeDatas := Sender.GetNodeData(Node);
  for i := 0 to Pred(TVirtualEditTree(Sender).Header.Columns.Count) do
    NodeDatas[i].Element := nil;
end;

procedure TfrmMain.vstSpreadSheetGetEditText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var CellText: string);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  Element                     : IwbElement;
begin
  CellText := '';
  if Column < Sender.Tag then
    Exit;

  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  Element := NodeDatas[Column].Element;
  if Assigned(Element) and Element.IsEditable then
    CellText := Element.EditValue;
end;

procedure TfrmMain.vstSpreadSheetGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  Element                     : IwbElement;
  MainRecord                  : IwbMainRecord;
begin
  CellText := '';

  if (Column < 0) or (Column >= TVirtualEditTree(Sender).Header.Columns.Count) then
    Exit;

  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;
  Element := NodeDatas[0].Element;
  if not Assigned(Element) then
    Exit;

  case Column of
    0: CellText := Element._File.Name;
    1: CellText := IntToHex64((Element as IwbMainRecord).LoadOrderFormID, 8);
    4: begin
        Element := NodeDatas[Column].Element;
        if not Assigned(Element) then
          Exit;
        Element := Element.LinksTo;
        if Supports(Element, IwbMainRecord, MainRecord) then begin
          CellText := MainRecord.EditorID;
          if CellText = '' then
            CellText := IntToHex64(MainRecord.LoadOrderFormID, 8);
        end;
      end
  else
    Element := NodeDatas[Column].Element;
    if not Assigned(Element) then
      Exit;
    CellText := Element.Value;
  end;
end;

procedure TfrmMain.vstSpreadSheetClick(Sender: TObject);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  Element                     : IwbElement;
  HotColumn                   : TColumnIndex;
begin
  if GetKeyState(VK_CONTROL) >= 0 then
    Exit;

  HotColumn := TVirtualEditTree(Sender).HotColumn;

  if (HotColumn < 1) or (HotColumn >= TVirtualEditTree(Sender).Header.Columns.Count) then
    Exit;

  NodeDatas := TVirtualEditTree(Sender).GetNodeData(TVirtualEditTree(Sender).HotNode);
  if not Assigned(NodeDatas) then
    Exit;

  if HotColumn = 1 then begin
    Element := NodeDatas[0].Element
  end
  else begin
    Element := NodeDatas[HotColumn].Element;

    if not Assigned(Element) then
      Exit;

    Element := Element.LinksTo;
    while Assigned(Element) and (Element.ElementType <> etMainRecord) do
      Element := Element.Container;
  end;

  if Assigned(Element) then begin
    ForwardHistory := nil;
    JumpTo(Element as IwbMainRecord, False);
  end;
end;

procedure TfrmMain.vstSpreadSheetGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
begin
  if GetKeyState(VK_SHIFT) < 0 then
    HintText := TVirtualEditTree(Sender).Text[Node, Column, False];
end;

procedure TfrmMain.vstSpreadSheetIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  CompareText                 : string;
  s                           : string;
  i                           : Integer;
begin
  UserWasActive := True;

  Result := 1;

  CompareText := TVirtualEditTree(Sender).
    Text[Node, Sender.FocusedColumn, False];

  s := SearchText;

  if Length(s) > Length(CompareText) then
    Exit;

  for i := 1 to Length(s) do
    if UpCase(s[i]) <> UpCase(CompareText[i]) then
      Exit;

  Result := 0;
end;

procedure TfrmMain.vstSpreadSheetWeaponInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  MainRecord                  : IwbMainRecord;
  DATA                        : IwbRecord;
begin
  NodeDatas := Sender.GetNodeData(Node);
  if not Assigned(NodeDatas) then
    Exit;

  if not Supports(NodeDatas[0].Element, IwbMainRecord, MainRecord) then
    Exit;

  NodeDatas[2].Element := MainRecord.RecordBySignature['EDID'];
  NodeDatas[3].Element := MainRecord.RecordBySignature['FULL'];
  NodeDatas[4].Element := MainRecord.RecordBySignature['ENAM'];

  DATA := MainRecord.RecordBySignature['DATA'];
  if Assigned(DATA) then begin
    NodeDatas[5].Element := DATA.Elements[0];
    NodeDatas[6].Element := DATA.Elements[1];
    NodeDatas[7].Element := DATA.Elements[2];
    NodeDatas[8].Element := DATA.Elements[4];
    NodeDatas[9].Element := DATA.Elements[5];
    NodeDatas[10].Element := DATA.Elements[6];
    NodeDatas[11].Element := DATA.Elements[7];
  end;
end;

procedure TfrmMain.vstSpreadSheetPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeDatas                   : PSpreadsheetNodeDatas;
  Element                     : IwbElement;
begin
  TargetCanvas.Font.Color := clWindowText;

  if (Column < 0) or (Column >= TVirtualEditTree(Sender).Header.Columns.Count) then
    Exit;

  if Column >= Sender.Tag then begin
    NodeDatas := Sender.GetNodeData(Node);
    if Assigned(NodeDatas) then
      Element := NodeDatas[Column].Element;
  end;

  if Assigned(Element) then begin
    if Element.Modified then
      TargetCanvas.Font.Style := [fsBold]
    else
      TargetCanvas.Font.Style := [];
    if Element.IsInjected then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsItalic]
    else
      TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsItalic];
  end;
end;

procedure TfrmMain.vstSpreadSheetNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  NodeDatas                   : PSpreadSheetNodeDatas;
  Element                     : IwbElement;
begin
  if not wbEditAllowed then
    Exit;

  UserWasActive := True;

  if Column < Sender.Tag then
    Exit;

  NodeDatas := Sender.GetNodeData(Node);
  if Assigned(NodeDatas) then begin
    Element := NodeDatas[Column].Element;
    if Assigned(Element) and Element.IsEditable then begin

      if not EditWarn then
        Exit;

      Element.EditValue := NewText;
    end;
  end;
end;

procedure TfrmMain.JvInterpreterProgram1GetValue(Sender: TObject;
  Identifier: string; var Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  Element             : IwbElement;
  MainRecord          : IwbMainRecord;
  _File               : IwbFile;
  Node                : PVirtualNode;
  NodeData            : PNavNodeData;
  ConflictThis        : TConflictThis;
  ConflictAll         : TConflictAll;
  i                   : Integer;
begin
  if SameText(Identifier, 'wbGameMode') and (Args.Count = 0) then begin
    Value := wbGameMode;
    Done := True;
  end else
  if SameText(Identifier, 'wbGameName') and (Args.Count = 0) then begin
    Value := wbGameName;
    Done := True;
  end else
  if SameText(Identifier, 'wbAppName') and (Args.Count = 0) then begin
    Value := wbAppName;
    Done := True;
  end else
  if SameText(Identifier, 'wbLoadBSAs') and (Args.Count = 0) then begin
    Value := wbLoadBSAs;
    Done := True;
  end else
  if SameText(Identifier, 'wbSimpleRecords') and (Args.Count = 0) then begin
    Value := wbSimpleRecords;
    Done := True;
  end else
  if SameText(Identifier, 'wbTrackAllEditorID') and (Args.Count = 0) then begin
    Value := wbTrackAllEditorID;
    Done := True;
  end else
  if SameText(Identifier, 'wbRecordDefMap') and (Args.Count = 0) then begin
    Value := O2V(wbRecordDefMap);
    Done := True;
  end else
  if (SameText(Identifier,   'ProgramPath') and (Args.Count = 0)) or
     (SameText(Identifier, 'wbProgramPath') and (Args.Count = 0)) then begin
    Value := wbProgramPath;
    Done := True;
  end else
  if (SameText(Identifier,   'ScriptsPath') and (Args.Count = 0)) or
     (SameText(Identifier, 'wbScriptsPath') and (Args.Count = 0)) then begin
    Value := wbScriptsPath;
    Done := True;
  end else
  if (SameText(Identifier, 'wbDataPath') and (Args.Count = 0)) or
     (SameText(Identifier, 'DataPath') and (Args.Count = 0)) then begin
    Value := wbDataPath;
    Done := True;
  end else
  if (SameText(Identifier, 'wbTempPath') and (Args.Count = 0)) or
     (SameText(Identifier, 'TempPath') and (Args.Count = 0)) then begin
    Value := wbTempPath;
    Done := True;
  end else
  if (SameText(Identifier, 'wbSettingsFileName') and (Args.Count = 0)) then begin
    Value := wbSettingsFileName;
    Done := True;
  end else
  if (SameText(Identifier, 'wbSettings') and (Args.Count = 0)) then begin
    Value := O2V(Settings);
    Done := True;
  end else
  if SameText(Identifier, 'FilterApplied') and (Args.Count = 0) then begin
    Value := FilterApplied;
    Done := True;
  end else
  if SameText(Identifier, 'frmMain') and (Args.Count = 0) then begin
    Value := O2V(frmMain);
    Done := True;
  end else
  if SameText(Identifier, 'AddMessage') then begin
    if (Args.Count = 1) and VarIsStr(Args.Values[0]) then begin
      AddMessage(Args.Values[0]);
      Done := True;
      Application.ProcessMessages;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'ClearMessages') and (Args.Count = 0) then begin
    mmoMessages.Clear;
    Done := True;
    Application.ProcessMessages;
  end else
  if SameText(Identifier, 'FileCount') and (Args.Count = 0) then begin
    Value := Length(Files);
    Done := True;
  end else
  if SameText(Identifier, 'FileByIndex') then begin
    if (Args.Count = 1) and VarIsNumeric(Args.Values[0]) and (Args.Values[0] < Length(Files)) then begin
      Value := Files[Integer(Args.Values[0])];
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0); // or  ieNotEnoughParams, ieIncompatibleTypes or others.
  end else
  if SameText(Identifier, 'FileByLoadOrder') then begin
    if (Args.Count = 1) and VarIsNumeric(Args.Values[0]) and (Args.Values[0] < Length(Files)) then begin
      for i := Low(Files) to High(Files) do
        if Files[i].LoadOrder = Integer(Args.Values[0]) then begin
          Value := Files[i];
          Break;
        end;
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'IsPositionChanged') and (Args.Count = 1) then begin
    if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
      Value := IsPositionChanged(MainRecord);
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'AddNewFile') and (Args.Count = 0) then begin
    AddNewFile(_File);
    Value := _File;
    Done := True;
  end else
  if SameText(Identifier, 'AddRequiredElementMasters') and (Args.Count = 3) then begin
    Value := false;
    if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
      if Supports(IInterface(Args.Values[1]), IwbFile, _File) then
        Value := AddRequiredMasters(Element, _File, Args.Values[2]);
    Done := True;
  end else
  if SameText(Identifier, 'RemoveNode') and (Args.Count = 1) then begin
    Value := False;
    if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
      Node := FindNodeForElement(Element);
      if Assigned(Node) then begin
        NodeData := vstNav.GetNodeData(Node);
        if Supports(Element, IwbMainRecord, MainRecord) then begin
          CheckHistoryRemove(BackHistory, MainRecord);
          CheckHistoryRemove(ForwardHistory, MainRecord);
        end;
        SetActiveRecord(nil);
        if Element.Equals(NodeData.Container) then
          NodeData.Container := nil;
        if Assigned(NodeData.Container) then
          NodeData.Container.Remove;
        Element.Remove;
        NodeData.Element := nil;
        NodeData.Container := nil;
        Element := nil;
        vstNav.DeleteNode(Node, False);
        Value := True;
      end;
    end;
    Done := True;
  end else
  if SameText(Identifier, 'ConflictThisForMainRecord') and (Args.Count = 1) then begin
    if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
      ConflictLevelForMainRecord(MainRecord, ConflictAll, ConflictThis);
      Value := ConflictThis;
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'ConflictAllForMainRecord') and (Args.Count = 1) then begin
    if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
      ConflictLevelForMainRecord(MainRecord, ConflictAll, ConflictThis);
      Value := ConflictAll;
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'ConflictThisForNode') and (Args.Count = 1) then begin
    if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
      Node := FindNodeForElement(Element);
      if Assigned(Node) then begin
        NodeData := vstNav.GetNodeData(Node);
        Value := NodeData.ConflictThis;
      end;
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'ConflictAllForNode') and (Args.Count = 1) then begin
    if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
      Node := FindNodeForElement(Element);
      if Assigned(Node) then begin
        NodeData := vstNav.GetNodeData(Node);
        Value := NodeData.ConflictAll;
      end;
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'JumpTo') and (Args.Count = 2) then begin
    if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
      vstNav.EndUpdate;
      if not vstNav.Enabled then vstNav.Enabled := True;
      JumpTo(MainRecord, Boolean(Args.Values[1]));
      Done := True;
    end else
      JvInterpreterError(ieDirectInvalidArgument, 0);
  end else
  if SameText(Identifier, 'ApplyFilter') and (Args.Count = 0) then begin
    FilterPreset := True; // skip filter dialog
    try
      mniNavFilterApplyClick(Sender);
    finally
      FilterPreset := False;
      Done := True;
    end;
  end else
  if SameText(Identifier, 'frmFileSelect') and (Args.Count = 0) then begin
    Value := O2V(TfrmFileSelect.Create(nil));
    Done := True;
  end;
end;

procedure TfrmMain.JvInterpreterProgram1SetValue(Sender: TObject;
  Identifier: string; const Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  i, v: Integer;
begin
  if SameText(Identifier, 'ScriptProcessElements') then begin
    ScriptProcessElements := [];
    v := V2S(Value);
    for i := Integer(Low(TwbElementType)) to Integer(High(TwbElementType)) do
      if (v and (1 shl i)) > 0 then
        Include(ScriptProcessElements, TwbElementType(i));
    if ScriptProcessElements = [] then
      ScriptProcessElements := [etMainRecord];
    Done := True;
  end else
  if SameText(Identifier, 'FilterScripted') then begin
    FilterScripted := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictAll') then begin
    FilterConflictAll := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictAllSet') then begin
    FilterConflictAllSet := [];
    v := V2S(Value);
    for i := Integer(Low(TConflictAll)) to Integer(High(TConflictAll)) do
      if (v and (1 shl i)) > 0 then
        Include(FilterConflictAllSet, TConflictAll(i));
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictThis') then begin
    FilterConflictThis := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictThisSet') then begin
    FilterConflictThisSet := [];
    v := V2S(Value);
    for i := Integer(Low(TConflictThis)) to Integer(High(TConflictThis)) do
      if (v and (1 shl i)) > 0 then
        Include(FilterConflictThisSet, TConflictThis(i));
    Done := True;
  end else
  if SameText(Identifier, 'FilterByInjectStatus') then begin
    FilterByInjectStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterInjectStatus') then begin
    FilterInjectStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByNotReachableStatus') then begin
    FilterByNotReachableStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterNotReachableStatus') then begin
    FilterNotReachableStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByReferencesInjectedStatus') then begin
    FilterByReferencesInjectedStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterReferencesInjectedStatus') then begin
    FilterReferencesInjectedStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByEditorID') then begin
    FilterByEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterEditorID') then begin
    FilterEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByName') then begin
    FilterByName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterName') then begin
    FilterName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseEditorID') then begin
    FilterByBaseEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseEditorID') then begin
    FilterBaseEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseName') then begin
    FilterByBaseName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseName') then begin
    FilterBaseName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterScaledActors') then begin
    FilterScaledActors := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBySignature') then begin
    FilterBySignature := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterSignatures') then begin
    FilterSignatures := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseSignature') then begin
    FilterByBaseSignature := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseSignatures') then begin
    FilterBaseSignatures := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByPersistent') then begin
    FilterByPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterPersistent') then begin
    FilterPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterUnnecessaryPersistent') then begin
    FilterUnnecessaryPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterMasterIsTemporary') then begin
    FilterMasterIsTemporary := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterIsMaster') then begin
    FilterIsMaster := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterPersistentPosChanged') then begin
    FilterPersistentPosChanged := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterDeleted') then begin
    FilterDeleted := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByVWD') then begin
    FilterByVWD := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterVWD') then begin
    FilterVWD := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByHasVWDMesh') then begin
    FilterByHasVWDMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterHasVWDMesh') then begin
    FilterHasVWDMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FlattenBlocks') then begin
    FlattenBlocks := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FlattenCellChilds') then begin
    FlattenCellChilds := Value;
    Done := True;
  end else
  if SameText(Identifier, 'AssignPersWrldChild') then begin
    AssignPersWrldChild := Value;
    Done := True;
  end else
  if SameText(Identifier, 'InheritConflictByParent') then begin
    InheritConflictByParent := Value;
    Done := True;
  end;
end;

procedure TfrmMain.JvInterpreterProgram1GetUnitSource(UnitName: string;
  var Source: string; var Done: Boolean);
var
  sl: TStringList;
  UnitFile: string;
begin
  UnitFile := wbScriptsPath + UnitName + '.pas';
  sl := TStringList.Create;
  try
    sl.LoadFromFile(UnitFile);
    Source := sl.Text;
    Done := True;
  finally
    sl.Free;
  end;
end;

procedure TfrmMain.WMUser(var Message: TMessage);
var
  t                           : string;
begin
  Pointer(t) := Pointer(Message.WParam);
  if not Assigned(NewMessages) then
    NewMessages := TStringList.Create;
  NewMessages.Add(t);
end;

procedure TfrmMain.WMUser1(var Message: TMessage);
begin
  AddFile(IwbFile(Pointer(Message.WParam)));
end;

procedure TfrmMain.WMUser2(var Message: TMessage);
begin
  wbLoaderDone := True;

  if wbLoaderError then begin
    ShowMessage('An error occured while loading modules. Editing is disabled. Check the message log and correct the error.');
    Exit;
  end;

  if (wbToolMode in [tmLODgen]) then begin
    if not ForceTerminate then
      tmrGenerator.Enabled := True;
    Exit;
  end;

  _BlockInternalEdit := False;

  vstNav.PopupMenu := pmuNav;

  tbsWEAPSpreadsheet.TabVisible := wbGameMode = gmTES4;
  tbsARMOSpreadsheet.TabVisible := wbGameMode = gmTES4;
  tbsAMMOSpreadsheet.TabVisible := wbGameMode = gmTES4;

  tmrCheckUnsaved.Enabled := wbEditAllowed and not (wbToolMode in [tmMasterUpdate, tmMasterRestore, tmLODgen]) and not wbIKnowWhatImDoing;
end;

procedure TfrmMain.WMUser3(var Message: TMessage);
begin
  ResetActiveTree;
end;

procedure TfrmMain.WMUser4(var Message: TMessage);
var
  FormID                      : Cardinal;
  FileID                      : Integer;
  _File                       : IwbFile;
  MainRecord                  : IwbMainRecord;
  Node                        : PVirtualNode;
  i                           : Integer;
begin
  case PluggyLinkState of
    plsReference: begin
      FormID := PluggyFormID;
      if (FormID and $FF000000) = $FF000000 then
        FormID := PluggyBaseFormID;
    end;
    plsBase:
      FormID := PluggyBaseFormID;
    plsInventory:
      FormID := PluggyInventoryFormID;
    plsEnchantment:
      FormID := PluggyEnchantmentFormID;
    plsSpell:
      FormID := PluggySpellFormID;
  else
    Exit;
  end;

  if FormID = 0 then
    Exit;

  FileID := FormID shr 24;
  if (FormID <> 0) and (FileID >= Low(Files)) and (FileID <= High(Files)) then begin
    _File := Files[FileID];
    FormID := (FormID and $00FFFFFF) or (Cardinal(_File.MasterCount) shl 24);
    MainRecord := _File.RecordByFormID[FormID, True];
    if Assigned(MainRecord) then begin
      MainRecord := MainRecord.WinningOverride;

      if MainRecord.Equals(ActiveRecord) then
        Exit;

      Node := FindNodeForElement(MainRecord);
      if not Assigned(Node) then begin
        MainRecord := MainRecord.MasterOrSelf;
        for i := 0 to Pred(MainRecord.OverrideCount) do begin
          Node := FindNodeForElement(MainRecord.Overrides[i]);
          if Assigned(Node) then
            Break;
        end;
      end;
      if Assigned(Node) then begin
        vstNav.ClearSelection;
        vstNav.FocusedNode := Node;
        vstNav.Selected[vstNav.FocusedNode] := True;
        SetActiveRecord(MainRecord);
      end else
        SetActiveRecord(MainRecord);
    end;
  end;
end;

{ TLoaderThread }

constructor TLoaderThread.Create(var aList: TStringList; IsTemporary: Boolean = False);
begin
  ltDataPath := wbDataPath;
  ltMaster := '';
  ltLoadList := aList;
  aList := nil;
  ltTemporary := IsTemporary;
  inherited Create(False);
  FreeOnTerminate := True;
end;

constructor TLoaderThread.Create(aFileName: string; aMaster: string; aLoadOrder: Integer; IsTemporary: Boolean = False);
begin
  ltLoadOrderOffset := aLoadOrder;
  ltDataPath := '';
  ltLoadList := TStringList.Create;
  ltLoadList.Add(aFileName);
  ltMaster := aMaster;
  ltTemporary := IsTemporary;
  inherited Create(False);
  FreeOnTerminate := True;
end;

destructor TLoaderThread.Destroy;
begin
  inherited;
  FreeAndNil(ltLoadList);
end;

procedure LoaderProgress(const s: string);
begin
  if s <> '' then
    frmMain.PostAddMessage('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] Background Loader: ' + s);
  if frmMain.ForceTerminate then
    Abort;
end;

procedure TLoaderThread.Execute;
var
  i                           : Integer;
  dummy                       : Integer;
  _File                       : IwbFile;
  s,t                         : string;
  F                           : TSearchRec;
begin
  LoaderProgress('starting...');
  try
    frmMain.LoaderStarted := True;
    wbProgressCallback := LoaderProgress;
    try
      wbStartTime := Now;

      if not Assigned(wbContainerHandler) then begin
        wbContainerHandler := wbCreateContainerHandler;

        with TMemIniFile.Create(wbTheGameIniFileName) do try
          with TStringList.Create do try
            if wbGameMode in [gmTES4, gmFO3, gmFNV] then
              Text := StringReplace(ReadString('Archive', 'sArchiveList', ''), ',' ,#10, [rfReplaceAll])
            else
              Text := StringReplace(
                ReadString('Archive', 'sResourceArchiveList', '') + ',' + ReadString('Archive', 'sResourceArchiveList2', ''),
                ',', #10, [rfReplaceAll]
              );
            for i := 0 to Pred(Count) do begin
              s := Trim(Strings[i]);
              if Length(s) < 5 then
                Continue;
              if not ((s[1] = '\') or (s[2] = ':')) then
                t := ltDataPath + s
              else
                t := s;
              if not FileExists(t) then
                LoaderProgress('Warning: <Can''t find ' + t + '>')
              else begin
                if wbContainerHandler.ContainerExists(t) then
                  Continue;
                if wbLoadBSAs then begin
                  LoaderProgress('[' + s + '] Loading Resources.');
                  wbContainerHandler.AddBSA(t);
                end else
                  LoaderProgress('[' + s + '] Skipped.');
              end;
            end;
          finally
            Free;
          end;
        finally
          Free;
        end;

        for i := 0 to Pred(ltLoadList.Count) do begin
          s := ChangeFileExt(ltLoadList[i], '');
          // all games prior to Skyrim load BSA files with partial matching, Skyrim requires exact names match
          if wbGameMode in [gmTES4, gmFO3, gmFNV] then
            s := s + '*';
          if FindFirst(ltDataPath + s + '.bsa', faAnyFile, F) = 0 then try
            repeat
              if wbContainerHandler.ContainerExists(ltDataPath + F.Name) then
                Continue;
              if wbLoadBSAs then begin
                LoaderProgress('[' + F.Name + '] Loading Resources.');
                wbContainerHandler.AddBSA(ltDataPath + F.Name);
              end else
                LoaderProgress('[' + F.Name + '] Skipped.');
            until FindNext(F) <> 0;
          finally
            FindClose(F);
          end;
        end;
        LoaderProgress('[' + ltDataPath + '] Setting Resource Path.');
        wbContainerHandler.AddFolder(ltDataPath);
      end;

      for i := 0 to Pred(ltLoadList.Count) do begin
        LoaderProgress('loading "' + ltLoadList[i] + '"...');
        _File := wbFile(ltDataPath + ltLoadList[i], i + ltLoadOrderOffset, ltMaster, ltTemporary);
        if wbEditAllowed and not wbTranslationMode then begin
          SetLength(ltFiles, Succ(Length(ltFiles)));
          ltFiles[High(ltFiles)] := _File;
        end;
        frmMain.SendAddFile(_File);

        if frmMain.ForceTerminate then
          Exit;

        if (i = 0) and (ltMaster = '') and (ltLoadOrderOffset = 0) and (ltLoadList.Count > 0) and SameText(ltLoadList[0], wbGameName + '.esm') then begin
          t := wbGameName + '.Hardcoded.keep.this.with.the.exe.and.otherwise.ignore.it.I.really.mean.it.dat';
          s := wbProgramPath + t;
          if FileExists(s) then begin
            LoaderProgress('loading "' + t + '"...');
            _File := wbFile(s, 0, ltDataPath + ltLoadList[i]);
            frmMain.SendAddFile(_File);
            if frmMain.ForceTerminate then
              Exit;

            t := wbGameName + '.Hardcoded.esp';
            s := wbProgramPath + t;
            if FileExists(s) then
              DeleteFile(s);
          end;
        end;
      end;

      if wbBuildRefs then
        for i := Low(ltFiles) to High(ltFiles) do
          if not SameText(ltFiles[i].FileName, wbGameName + '.esm') and not wbDoNotBuildRefsFor.Find(ltFiles[i].FileName, dummy) then begin
            LoaderProgress('[' + ltFiles[i].FileName + '] Building reference info.');
            ltFiles[i].BuildRef;
            if frmMain.ForceTerminate then
              Exit;
          end;

    except
      on E: Exception do begin
        LoaderProgress('Fatal: <' + e.ClassName + ': ' + e.Message + '>');
        wbLoaderError := True;
      end;
    end;
  finally
    frmMain.SendLoaderDone;
    LoaderProgress('finished');
    wbProgressCallback := nil;
  end;
  {
    CELLList.Sorted := False;
    for i := 0 to Pred(CELLList.Count) do begin
      CELLList[i] := CELLList[i] + ' ('+IntToStr(Integer(CELLList.Objects[i]))+')';
    end;
    CELLList.SaveToFile('scptlist.txt');
  }
end;

{ TViewNodeData }

procedure TViewNodeData.UpdateRefs;
begin
  if Assigned(Element) and (Element.ElementType = etMainRecord) then
    (Element as IwbMainRecord).UpdateRefs;
end;

{ TTabHistoryEntry }

constructor TTabHistoryEntry.Create(aTabSheet: TTabSheet);
begin
  tiTabSheet := aTabSheet;
  inherited Create;
end;

procedure TTabHistoryEntry.Show;
begin
  frmMain.pgMain.ActivePage := tiTabSheet;
end;

{ TCompareRecordsHistoryEntry }

constructor TCompareRecordsHistoryEntry.Create(const aCompareRecords: TDynMainRecords);
begin
  crRecords := aCompareRecords;
  inherited Create;
end;

function TCompareRecordsHistoryEntry.Remove(const aMainRecord: IwbMainRecord): Boolean;
var
  i, j                        : Integer;
begin
  j := 0;
  SetLength(crRecords, Length(crRecords));
  for i := Low(crRecords) to High(crRecords) do
    if not crRecords[i].Equals(aMainRecord) then begin
      if i <> j then
        crRecords[j] := crRecords[i];
      Inc(j);
    end;
  if j <> Length(crRecords) then begin
    SetLength(crRecords, j);
    crRecordsChanged := True;
  end;
  Result := Length(crRecords) < 2;
end;

procedure TCompareRecordsHistoryEntry.Show;
var
  i                           : Integer;
begin
  with frmMain do begin
    vstNav.ClearSelection;
    for i := Low(crRecords) to High(crRecords) do begin
      vstNav.FocusedNode := FindNodeForElement(crRecords[i]);
      vstNav.Selected[vstNav.FocusedNode] := True;
    end;
    SetActiveRecord(crRecords);
    pgMain.ActivePage := tbsView;
  end;
end;

{ THistoryEntry }

function THistoryEntry.Remove(const aMainRecord: IwbMainRecord): Boolean;
begin
  Result := False;
end;

{ TCompareRecordsPosHistoryEntry }

constructor TCompareRecordsPosHistoryEntry.Create(const aCompareRecords: TDynMainRecords);
var
  i                           : Integer;
begin
  inherited;
  with frmMain, vstView, Header, Columns do begin
    crpOffsetXY := OffsetXY;
    crpFocusNode := FocusedNode;
    crpFocusColumn := FocusedColumn;
    if Assigned(crpFocusNode) then
      crpFocusRect := GetDisplayRect(crpFocusNode, crpFocusColumn, False);
    SetLength(crpColumnWidths, Count);
    for i := 0 to Pred(Count) do
      crpColumnWidths[i] := Items[i].Width;
  end;
end;

procedure TCompareRecordsPosHistoryEntry.Show;
var
  i                           : Integer;
  Node                        : PVirtualNode;
begin
  with frmMain, vstView, Header, Columns do begin

    inherited;

    if not crRecordsChanged then begin

      if Count <> Length(crpColumnWidths) then
        Exit;

      for i := 0 to Pred(Count) do
        Items[i].Width := crpColumnWidths[i];

      UpdateScrollBars(False);

      OffsetXY := crpOffsetXY;

      if Assigned(crpFocusNode) then begin
        Node := vstView.GetNodeAt(crpFocusRect.Left + 2, crpFocusRect.Top + 2);
        if Assigned(Node) then
          FocusedNode := Node;
      end;
      FocusedColumn := crpFocusColumn;

      OffsetXY := crpOffsetXY;
    end;
  end;
end;

{ TMainRecordPosHistoryEntry }

constructor TMainRecordPosHistoryEntry.Create(const aMainRecord: IwbMainRecord);
var
  i                           : Integer;
begin
  inherited;
  with frmMain, vstView, Header, Columns do begin
    mrpOffsetXY := OffsetXY;
    mrpFocusNode := FocusedNode;
    mrpFocusColumn := FocusedColumn;
    if Assigned(mrpFocusNode) then
      mrpFocusRect := GetDisplayRect(mrpFocusNode, mrpFocusColumn, False);
    SetLength(mrpColumnWidths, Count);
    for i := 0 to Pred(Count) do
      mrpColumnWidths[i] := Items[i].Width;
  end;
end;

procedure TMainRecordPosHistoryEntry.Show;
var
  i                           : Integer;
  Node                        : PVirtualNode;
begin
  with frmMain, vstView, Header, Columns do begin
    inherited;

    if Count <> Length(mrpColumnWidths) then
      Exit;

    for i := 0 to Pred(Count) do
      Items[i].Width := mrpColumnWidths[i];

    UpdateScrollBars(False);

    OffsetXY := mrpOffsetXY;

    if Assigned(mrpFocusNode) then begin
      Node := vstView.GetNodeAt(mrpFocusRect.Left + 2, mrpFocusRect.Top + 2);
      if Assigned(Node) then
        FocusedNode := Node;
    end;
    FocusedColumn := mrpFocusColumn;

    OffsetXY := mrpOffsetXY;
  end;
end;

{ TMainRecordHistoryEntry }

constructor TMainRecordHistoryEntry.Create(const aMainRecord: IwbMainRecord);
begin
  mrRecord := aMainRecord;
  inherited Create;
end;

function TMainRecordHistoryEntry.GetTabSheet: TTabSheet;
begin
  Result := frmMain.tbsView;
end;

function TMainRecordHistoryEntry.Remove(const aMainRecord: IwbMainRecord): Boolean;
begin
  Result := mrRecord.Equals(aMainRecord);
end;

procedure TMainRecordHistoryEntry.Show;
begin
  with frmMain do begin
    vstNav.ClearSelection;
    vstNav.FocusedNode := FindNodeForElement(mrRecord);
    vstNav.Selected[vstNav.FocusedNode] := True;
    SetActiveRecord(mrRecord);
    pgMain.ActivePage := GetTabSheet;
  end;
end;

{ TMainRecordRefByHistoryEntry }

function TMainRecordRefByHistoryEntry.GetTabSheet: TTabSheet;
begin
  Result := frmMain.tbsReferencedBy;
end;

{ TPluggyLinkThread }

procedure TPluggyLinkThread.ChangeDetected;
var
  s                                                : string;
  FormID, BaseFormID, InventoryFormID, EnchantmentFormID, SpellFormID : Cardinal;
begin
  with TFileStream.Create(plFolder + 'Pluggy'+wbAppName+'ViewWorld.csv', fmOpenRead or fmShareDenyNone) do try
    Position := Size - 2024;
    SetLength(s, 64 * 1024);
    SetLength(s, Read(s[1], 64 * 1024));
  finally
    Free;
  end;
  with TStringList.Create do try
    Text := s;
    if Count < 2 then
      Exit;
    CommaText := Strings[Pred(Count)];
    if Count < 2 then
      Exit;
    FormID := StrToInt64('$'+Strings[0]);
    BaseFormID := StrToInt64('$'+Strings[1]);
  finally
    Free;
  end;
  with TFileStream.Create(plFolder + 'Pluggy'+wbAppName+'ViewInventory.csv', fmOpenRead or fmShareDenyNone) do try
    Position := Size - 2024;
    SetLength(s, 64 * 1024);
    SetLength(s, Read(s[1], 64 * 1024));
  finally
    Free;
  end;
  with TStringList.Create do try
    Text := s;
    if Count < 2 then
      Exit;
    CommaText := Strings[Pred(Count)];
    if Count < 2 then
      Exit;
    InventoryFormID := StrToInt64('$'+Strings[0]);
    EnchantmentFormID := StrToInt64('$'+Strings[1]);
  finally
    Free;
  end;
  with TFileStream.Create(plFolder + 'Pluggy'+wbAppName+'ViewSpells.csv', fmOpenRead or fmShareDenyNone) do try
    Position := Size - 2024;
    SetLength(s, 64 * 1024);
    SetLength(s, Read(s[1], 64 * 1024));
  finally
    Free;
  end;
  with TStringList.Create do try
    Text := s;
    if Count < 2 then
      Exit;
    CommaText := Strings[Pred(Count)];
    if Count < 1 then
      Exit;
    SpellFormID := StrToInt64('$'+Strings[0]);
  finally
    Free;
  end;


  if (FormID <> plLastFormID) or
     (BaseFormID <> plLastBaseFormID) or
     (InventoryFormID <> plLastBaseFormID) or
     (EnchantmentFormID <> plLastBaseFormID) or
     (SpellFormID <> plLastBaseFormID) then begin

    plLastFormID := FormID;
    plLastBaseFormID := BaseFormID;
    plLastInventoryFormID := InventoryFormID;
    plLastEnchantmentFormID := EnchantmentFormID;
    plLastSpellFormID := SpellFormID;

    frmMain.PostPluggyChange(FormID, BaseFormID, InventoryFormID, EnchantmentFormID, SpellFormID);
  end;
end;

procedure TPluggyLinkThread.Execute;
var
  WaitHandle : THandle;
begin
  plFolder := wbMyGamesTheGamePath + 'Pluggy\User Files\';
  frmMain.PostAddMessage('[PluggyLink] Starting for: ' + plFolder);
  try
    WaitHandle := FindFirstChangeNotification(
      PChar(plFolder),
      False,
      FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_LAST_WRITE
    );
    if WaitHandle = INVALID_HANDLE_VALUE then
      RaiseLastOSError;
    try
      repeat
        case WaitForSingleObject(WaitHandle, 1000) of
          WAIT_OBJECT_0: begin
            ChangeDetected;
            if not FindNextChangeNotification(WaitHandle) then
              RaiseLastOSError;
          end;
          WAIT_FAILED:
            RaiseLastOSError;
        end;
      until Terminated or frmMain.ForceTerminate;
    finally
      if not FindCloseChangeNotification(WaitHandle) then
        RaiseLastOSError;
    end;
  except
    on E: Exception do
      frmMain.PostAddMessage('[PluggyLink] Error: ' + E.Message);
  end;
  frmMain.PostAddMessage('[PluggyLink] terminated');
end;


{ TwbComboEditLink }

procedure TwbComboEditLink.SetBounds(R: TRect);
var
  H : Integer;
begin  // Let's show from 1 to 32 lines to pick from
  H := PickList.Count;
  if H > 32 then
    H := 32
   else if H < 1 then
     H := 1;
  H := H * TComboBox(FEdit).Font.Height ;
  R.Bottom := R.Bottom + Abs(H);

  inherited;
end;

end.
