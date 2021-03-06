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

unit wbInit;

interface

var
  wbApplicationTitle: string;

procedure wbDoInit;

implementation

uses
  SysUtils,
  Dialogs,
  wbInterface,
  wbImplementation,
  wbDefinitionsTES4,
  wbDefinitionsFO3,
  wbDefinitionsFNV,
  wbDefinitionsTES5,
  nxExeConst;

procedure wbDoInit;
begin
  wbReportMode := False;

  if FindCmdLineSwitch('TES5') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'TES5') then begin
    wbGameMode := gmTES5;
    wbAppName := 'TES5';
    wbGameName := 'Skyrim';
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    DefineTES5;
  end else if FindCmdLineSwitch('FNV') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FNV') then begin
    wbGameMode := gmFNV;
    wbAppName := 'FNV';
    wbGameName := 'FalloutNV';
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    DefineFNV;
  end else if FindCmdLineSwitch('FO3') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 3), 'FO3') then begin
    wbGameMode := gmFO3;
    wbAppName := 'FO3';
    wbGameName := 'Fallout3';
    wbVWDInTemporary := True;
    wbLoadBSAs := False;
    DefineFO3;
  end else if FindCmdLineSwitch('TES4') or SameText(Copy(ExtractFileName(ParamStr(0)), 1, 4), 'TES4') then begin
    wbGameMode := gmTES4;
    wbAppName := 'TES4';
    wbGameName := 'Oblivion';
    wbLoadBSAs := True;
    DefineTES4;
  end else begin
    ShowMessage('Application name must start with FNV, FO3 or TES4 to select mode.');
    Exit;
  end;

  if FindCmdLineSwitch('fixup') then
    wbAllowInternalEdit := True
  else if FindCmdLineSwitch('nofixup') then
    wbAllowInternalEdit := False;

  if FindCmdLineSwitch('skipbsa') then
    wbLoadBSAs := False
  else if FindCmdLineSwitch('forcebsa') then
    wbLoadBSAs := True;

  if FindCmdLineSwitch('showfixup') then
    wbShowInternalEdit := True
  else if FindCmdLineSwitch('hidefixup') then
    wbShowInternalEdit := False;

  wbApplicationTitle := wbAppName + 'View ' + VersionString;
  if FindCmdLineSwitch('lodgen') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'LODGen.exe') then begin
    if wbGameMode <> gmTES4 then begin
      ShowMessage('LODGen mode is only possible for TES4.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'LODGen ' + VersionString;
    wbEditAllowed := False;
    wbDontSave := True;
    wbMasterUpdate := False;
    wbLODGen := True;
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := True;
    wbBuildRefs := False;
  end else if FindCmdLineSwitch('masterupdate') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'MasterUpdate.exe') then begin
    if not (wbGameMode in [gmFO3, gmFNV, gmTES5]) then begin
      ShowMessage('MasterUpdate mode is only possible for FO3, FNV and TES5.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'MasterUpdate ' + VersionString;
    wbEditAllowed := True;
    wbMasterUpdate := True;
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := False;
    wbBuildRefs := False;
    if FindCmdLineSwitch('filteronam') then
      wbMasterUpdateFilterONAM := True;
    if FindCmdLineSwitch('FixPersistence') then
      wbMasterUpdateFixPersistence := True
    else if FindCmdLineSwitch('NoFixPersistence') then
      wbMasterUpdateFixPersistence := False;
  end else if FindCmdLineSwitch('masterrestore') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'MasterRestore.exe') then begin
    if not (wbGameMode in [gmFO3, gmFNV, gmTES5]) then begin
      ShowMessage('MasterRestore mode is only possible for FO3, FNV and TES5.');
      Exit;
    end;
    wbApplicationTitle := wbAppName + 'MasterRestore ' + VersionString;
    wbEditAllowed := True;
    wbMasterUpdate := True;
    wbMasterRestore := True;
    wbIKnowWhatImDoing := True;
    wbAllowInternalEdit := False;
    wbShowInternalEdit := False;
    wbLoadBSAs := False;
    wbBuildRefs := False;
  end else if FindCmdLineSwitch('edit') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'Edit.exe') then begin
    wbApplicationTitle := wbAppName + 'Edit ' + VersionString;
    wbEditAllowed := True;
  end else if FindCmdLineSwitch('translate') or SameText(ExtractFileName(ParamStr(0)), wbAppName + 'Trans.exe') then begin
    wbApplicationTitle := wbAppName + 'Trans ' + VersionString;
    wbEditAllowed := True;
    wbTranslationMode := True;
  end else
    wbDontSave := True;

  nxAppDataSubdirVista := wbAppName;
  if wbTranslationMode then
    nxAppDataSubdirVista := nxAppDataSubdirVista + 'Trans'
  else if wbMasterRestore then
    nxAppDataSubdirVista := nxAppDataSubdirVista + 'MasterRestore'
  else if wbMasterUpdate then
    nxAppDataSubdirVista := nxAppDataSubdirVista + 'MasterUpdate'
  else if wbEditAllowed then
    nxAppDataSubdirVista := nxAppDataSubdirVista + 'Edit'
  else
    nxAppDataSubdirVista := nxAppDataSubdirVista + 'View';

  if FindCmdLineSwitch('fixuppgrd') then
    wbFixupPGRD := True;
  if FindCmdLineSwitch('IKnowWhatImDoing') then
    wbIKnowWhatImDoing := True;
end;

initialization
  wbDoInit;
end.
