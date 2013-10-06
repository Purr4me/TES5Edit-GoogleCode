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

unit wbHelpers;

interface

uses
  Classes, Windows, SysUtils, Graphics, ShellAPI,
  wbInterface;

function wbDistance(const a, b: TwbVector): Single; overload
function wbDistance(const a, b: IwbMainRecord): Single; overload;
function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
function FindMatchText(Strings: TStrings; const Str: string): Integer;
function IsFileESM(const aFileName: string): Boolean;
function IsFileESP(const aFileName: string): Boolean;
procedure DeleteDirectory(const DirName: string);
procedure wbFlipBitmap(aBitmap: TBitmap; MirrorType: Integer); // MirrorType: 1 - horizontal, 2 - vertical, 0 - both
function wbAlphaBlend(DestDC, X, Y, Width, Height,
  SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, Alpha: integer): Boolean;

type
  PnxLeveledListCheckCircularStack = ^TnxLeveledListCheckCircularStack;
  TnxLeveledListCheckCircularStack = record
    rllcLast       : PnxLeveledListCheckCircularStack;
    rllcMainRecord : IwbMainRecord;
  end;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);

type
  TnxFastStringList = class(TStringList)
  protected
    function CompareStrings(const S1, S2: string): Integer; override;
  public
    constructor CreateSorted(aDups : TDuplicates = dupError);

    procedure Clear(aFreeObjects: Boolean = False); reintroduce;
  end;

  TnxFastStringListCS = class(TnxFastStringList)
  public
    procedure AfterConstruction; override;
  end;

  TnxFastStringListIC = class(TnxFastStringList)
  end;


implementation

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);
var
  Stack    : TnxLeveledListCheckCircularStack;
  s          : string;
  CER        : IwbContainerElementRef;
  LLE        : IwbContainerElementRef;
  i          : Integer;
  LVLO       : IwbContainerElementRef;
  Reference  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  Stack.rllcLast := aStack;
  Stack.rllcMainRecord := aMainRecord;

  while Assigned(aStack) do begin
    if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then begin
      s := aMainRecord.Name;
      aStack := Stack.rllcLast;
      while Assigned(aStack) do begin
        s := ' -> ' + s;
        s := aStack.rllcMainRecord.Name + s;
        if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then
          Break;
        aStack := aStack.rllcLast;
      end;
      s := 'Circular Leveled List found: ' + s;
      raise Exception.Create(s);
    end;
    aStack := aStack.rllcLast;
  end;

  if aMainRecord.IsTagged then
    Exit;
  aMainRecord.Tag;

  if Supports(aMainRecord, IwbContainerElementRef, CER) then begin
    if Supports(CER.ElementByName['Leveled List Entries'], IwbContainerElementRef, LLE) then begin
      for i := 0 to Pred(LLE.ElementCount) do
        if Supports(LLE.Elements[i], IwbContainerElementRef, LVLO) then begin
          if Supports(LVLO.ElementByName['Reference'], IwbContainerElementRef, Reference) then begin
            if Supports(Reference.LinksTo, IwbMainRecord, MainRecord) then begin
              if (MainRecord.Signature = aMainRecord.Signature) then begin
                MainRecord := MainRecord.WinningOverride;
                wbLeveledListCheckCircular(MainRecord, @Stack);
              end;
            end;
          end;
        end;
    end;
  end;
end;

function Vec3Subtract(out vOut: TwbVector; const v1, v2: TwbVector): TwbVector;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
  end;
  Result := vOut;
end;

function Vec3Length(const v: TwbVector): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z);
end;

function wbDistance(const a, b: TwbVector): Single;
var
  t: TwbVector;
begin
  Result := Vec3Length(Vec3Subtract(t,a,b));
end;

function wbDistance(const a, b: IwbMainRecord): Single; overload;
var
  PosA, PosB: TwbVector;
begin
  if not a.GetPosition(PosA) then
    raise Exception.Create('GetPosition failed');
  if not b.GetPosition(PosB) then
    raise Exception.Create('GetPosition failed');
  Result := wbDistance(PosA, PosB);
end;

function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
var
  Count       : Integer;
  Position    : TwbVector;
  MaxLoadOrder: Integer;

  procedure FindREFRs(const aElement: IwbElement);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
    Temp       : TwbVector;
  begin
    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      if not (aMainRecord.LoadOrderFormID = MainRecord.LoadOrderFormID) and
        MainRecord.GetPosition(Temp) and
        (wbDistance(Temp,Position) <= aDistance) then begin

        if High(Result) < Count then
          SetLength(Result, Length(Result) * 2);
        Result[Count] := MainRecord.HighestOverrideOrSelf[MaxLoadOrder];
        Inc(Count);

      end;
    end else
      if Supports(aElement, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          FindREFRs(Container.Elements[i]);
  end;

var
  GroupRecord : IwbGroupRecord;
  CellMaster  : IwbMainRecord;
  i, j        : Integer;
begin
  Result := nil;
  if not aMainRecord.GetPosition(Position) then
    Exit;
  if not Supports(aMainRecord.Container, IwbGroupRecord, GroupRecord) then
    Exit;
  if not (GroupRecord.GroupType in [8..10]) then
    Exit;
  CellMaster := GroupRecord.ChildrenOf;
  if not Assigned(CellMaster) then
    Exit;
  CellMaster := CellMaster.MasterOrSelf;
  MaxLoadOrder := aMainRecord._File.LoadOrder;

  Count := 0;
  SetLength(Result, 1024);
  FindREFRs(CellMaster.ChildGroup);
  for i := 0 to Pred(CellMaster.OverrideCount) do
    if CellMaster.Overrides[i]._File.LoadOrder <= aMainRecord._File.LoadOrder then
      FindREFRs(CellMaster.Overrides[i])
    else
      Break;
  SetLength(Result, Count);


  if Length(Result) > 1 then begin
    QuickSort(@Result[0], Low(Result), High(Result), CompareElementsFormIDAndLoadOrder);

    j := 0;
    for i := Succ(Low(Result)) to High(Result) do begin
      if (Result[j].LoadOrderFormID <> Result[i].LoadOrderFormID) and not (Result[j].IsDeleted) then
        Inc(j);
      if j <> i then
        Result[j] := Result[i];
    end;
    SetLength(Result, Succ(j));
  end;
end;

function FindMatchText(Strings: TStrings; const Str: string): Integer;
begin
  for Result := 0 to Strings.Count-1 do
    if SameText(Strings[Result], Str) then
      Exit;
  Result := -1;
end;

function IsFileESM(const aFileName: string): Boolean;
const
  ghostesm = '.esm.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esm') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesm) + 1, Length(ghostesm)), ghostesm)
end;

function IsFileESP(const aFileName: string): Boolean;
const
  ghostesp = '.esp.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esp') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesp) + 1, Length(ghostesp)), ghostesp)
end;

procedure DeleteDirectory(const DirName: string);
var
  FileOp: TSHFileOpStruct;
begin
  FillChar(FileOp, SizeOf(FileOp), 0);
  FileOp.wFunc := FO_DELETE;
  FileOp.pFrom := PChar(DirName+#0);//double zero-terminated
  FileOp.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(FileOp);
end;

procedure wbFlipBitmap(aBitmap: TBitmap; MirrorType: Integer);
var
  MemBmp: TBitmap;
  Dest: TRect;
begin
  if not Assigned(aBitmap) then
    Exit;

  MemBmp := TBitmap.Create;
  try
    MemBmp.Assign(aBitmap);
    case MirrorType of
      1:
        begin
          Dest.Left := MemBmp.Width;
          Dest.Top := 0;
          Dest.Right := -MemBmp.Width;
          Dest.Bottom := MemBmp.Height
        end;
      2:
        begin
          Dest.Left := 0;
          Dest.Top := MemBmp.Height;
          Dest.Right := MemBmp.Width;
          Dest.Bottom := -MemBmp.Height
        end;
      0:
        begin
          Dest.Left := MemBmp.Width;
          Dest.Top := MemBmp.Height;
          Dest.Right := -MemBmp.Width;
          Dest.Bottom := -MemBmp.Height
        end;
    end;
    StretchBlt(MemBmp.Canvas.Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom,
               MemBmp.Canvas.Handle, 0, 0, MemBmp.Width, MemBmp.Height,
               SRCCOPY);
    aBitmap.Assign(MemBmp);
  finally
    FreeAndNil(MemBmp);
  end;
end;

function wbAlphaBlend(DestDC, X, Y, Width, Height,
  SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, Alpha: integer): Boolean;
var
  BlendFunc: TBlendFunction;
begin
  BlendFunc.BlendOp := AC_SRC_OVER;
  BlendFunc.BlendFlags := 0;
  BlendFunc.SourceConstantAlpha := Alpha;
  if Alpha = 255 then
    BlendFunc.AlphaFormat := AC_SRC_ALPHA
  else
    BlendFunc.AlphaFormat := 0;
  Result := Windows.AlphaBlend(DestDC, X, Y, Width, Height, SrcDC, SrcX, SrcY, SrcWidth, SrcHeight, BlendFunc);
end;


{ TnxFastStringList }

procedure TnxFastStringList.Clear(aFreeObjects: Boolean);
var
  i: Integer;
begin
  if aFreeObjects then
    for i := 0 to Pred(Count) do
      Objects[i].Free;
  inherited Clear;
end;

function TnxFastStringList.CompareStrings(const S1, S2: string): Integer;
begin
  {x$IFDEF DCC6OrLater}
  if CaseSensitive then
    Result := CompareStr(S1, S2)
  else
  {x$ENDIF}
    Result := CompareText(S1, S2);
end;

constructor TnxFastStringList.CreateSorted(aDups: TDuplicates);
begin
  Create;
  Duplicates := aDups;
  Sorted := True;
end;

{ TnxFastStringListCS }

procedure TnxFastStringListCS.AfterConstruction;
begin
  inherited;
  {x$IFDEF DCC6OrLater}
  CaseSensitive := True;
  {x$ENDIF}
end;

end.
