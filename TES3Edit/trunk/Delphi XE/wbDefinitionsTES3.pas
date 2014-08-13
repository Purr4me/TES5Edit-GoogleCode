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
//------------------------------------------------------------------------------
// Placeholder for future expansion
//------------------------------------------------------------------------------
unit wbDefinitionsTES3;

interface

procedure DefineTES3;

implementation

uses
  Types, Classes, SysUtils, Math, Variants,
  wbInterface;

const
  AADT : TwbSignature = 'AADT'; { Morrowind }
  ACTI : TwbSignature = 'ACTI'; { Morrowind }
  AI_A : TwbSignature = 'AI'#$5F'A'; { Morrowind }
  AI_E : TwbSignature = 'AI'#$5F'E'; { Morrowind }
  AI_F : TwbSignature = 'AI'#$5F'F'; { Morrowind }
  AI_T : TwbSignature = 'AI'#$5F'T'; { Morrowind }
  AI_W : TwbSignature = 'AI'#$5F'W'; { Morrowind }
  AIDT : TwbSignature = 'AIDT'; { Morrowind }
  ALCH : TwbSignature = 'ALCH'; { Morrowind }
  ALDT : TwbSignature = 'ALDT'; { Morrowind }
  AMBI : TwbSignature = 'AMBI'; { Morrowind }
  ANAM : TwbSignature = 'ANAM'; { Morrowind }
  AODT : TwbSignature = 'AODT'; { Morrowind }
  APPA : TwbSignature = 'APPA'; { Morrowind }
  ARMO : TwbSignature = 'ARMO'; { Morrowind }
  ASND : TwbSignature = 'ASND'; { Morrowind }
  AVFX : TwbSignature = 'AVFX'; { Morrowind }
  BKDT : TwbSignature = 'BKDT'; { Morrowind }
  BNAM : TwbSignature = 'BNAM'; { Morrowind }
  BODY : TwbSignature = 'BODY'; { Morrowind }
  BOOK : TwbSignature = 'BOOK'; { Morrowind }
  BSGN : TwbSignature = 'BSGN'; { Morrowind }
  BSND : TwbSignature = 'BSND'; { Morrowind }
  BVFX : TwbSignature = 'BVFX'; { Morrowind }
  BYDT : TwbSignature = 'BYDT'; { Morrowind }
  CELL : TwbSignature = 'CELL'; { Morrowind }
  CLAS : TwbSignature = 'CLAS'; { Morrowind }
  CLDT : TwbSignature = 'CLDT'; { Morrowind }
  CLMT : TwbSignature = 'CLMT';
  CLOT : TwbSignature = 'CLOT'; { Morrowind }
  CNAM : TwbSignature = 'CNAM'; { Morrowind }
  CNDT : TwbSignature = 'CNDT'; { Morrowind }
  CNTO : TwbSignature = 'CNTO'; { Morrowind }
  CONT : TwbSignature = 'CONT'; { Morrowind }
  CREA : TwbSignature = 'CREA'; { Morrowind }
  CSAD : TwbSignature = 'CSAD';
  CSCR : TwbSignature = 'CSCR';
  CSDC : TwbSignature = 'CSDC';
  CSDI : TwbSignature = 'CSDI';
  CSDT : TwbSignature = 'CSDT';
  CSND : TwbSignature = 'CSND'; { Morrowind }
  CSTD : TwbSignature = 'CSTD';
  CSTY : TwbSignature = 'CSTY';
  CTDA : TwbSignature = 'CTDA'; { Not Morrowind but keep it }
  CTDT : TwbSignature = 'CTDT'; { Morrowind }
  CVFX : TwbSignature = 'CVFX'; { Morrowind }
  DATA : TwbSignature = 'DATA'; { Morrowind }
  DATX : TwbSignature = 'DATX';
  DELE : TwbSignature = 'DELE'; { Morrowind }
  DESC : TwbSignature = 'DESC'; { Morrowind }
  DIAL : TwbSignature = 'DIAL'; { Morrowind }
  DNAM : TwbSignature = 'DNAM'; { Morrowind }
  DODT : TwbSignature = 'DODT'; { Morrowind }
  DOOR : TwbSignature = 'DOOR'; { Morrowind }
  EDDX : TwbSignature = 'EDDX';
  EDID : TwbSignature = 'EDID';
  EFID : TwbSignature = 'EFID';
  EFII : TwbSignature = 'EFII';
  EFIT : TwbSignature = 'EFIT';
  EFIX : TwbSignature = 'EFIX';
  EFME : TwbSignature = 'EFME';
  EFSH : TwbSignature = 'EFSH';
  EFXX : TwbSignature = 'EFXX';
  ENAM : TwbSignature = 'ENAM'; { Morrowind }
  ENCH : TwbSignature = 'ENCH'; { Morrowind }
  ENDT : TwbSignature = 'ENDT'; { Morrowind }
  ENIT : TwbSignature = 'ENIT'; { Morrowind }
  ESCE : TwbSignature = 'ESCE';
  EYES : TwbSignature = 'EYES';
  FACT : TwbSignature = 'FACT'; { Morrowind }
  FADT : TwbSignature = 'FADT'; { Morrowind }
  FGGA : TwbSignature = 'FGGA';
  FGGS : TwbSignature = 'FGGS';
  FGTS : TwbSignature = 'FGTS';
  FLAG : TwbSignature = 'FLAG'; { Morrowind }
  FLOR : TwbSignature = 'FLOR';
  FLTV : TwbSignature = 'FLTV'; { Morrowind }
  FNAM : TwbSignature = 'FNAM'; { Morrowind }
  FRMR : TwbSignature = 'FRMR'; { Morrowind }
  FULL : TwbSignature = 'FULL';
  FURN : TwbSignature = 'FURN';
  GLOB : TwbSignature = 'GLOB'; { Morrowind }
  GMST : TwbSignature = 'GMST'; { Morrowind }
  GNAM : TwbSignature = 'GNAM';
  GRAS : TwbSignature = 'GRAS';
  HAIR : TwbSignature = 'HAIR';
  HCLR : TwbSignature = 'HCLR';
  HEDR : TwbSignature = 'HEDR'; { Morrowind }
  HNAM : TwbSignature = 'HNAM';
  HSND : TwbSignature = 'HSND'; { Morrowind }
  HVFX : TwbSignature = 'HVFX'; { Morrowind }
  ICO2 : TwbSignature = 'ICO2';
  ICON : TwbSignature = 'ICON';
  IDLE : TwbSignature = 'IDLE';
  INAM : TwbSignature = 'INAM'; { Morrowind }
  INDX : TwbSignature = 'INDX'; { Morrowind }
  INFO : TwbSignature = 'INFO'; { Morrowind }
  INGR : TwbSignature = 'INGR'; { Morrowind }
  INTV : TwbSignature = 'INTV'; { Morrowind }
  IRDT : TwbSignature = 'IRDT'; { Morrowind }
  ITEX : TwbSignature = 'ITEX'; { Morrowind }
  JNAM : TwbSignature = 'JNAM';
  KEYM : TwbSignature = 'KEYM';
  KFFZ : TwbSignature = 'KFFZ';
  KNAM : TwbSignature = 'KNAM'; { Morrowind }
  LAND : TwbSignature = 'LAND'; { Morrowind }
  LEVC : TwbSignature = 'LEVC'; { Morrowind }
  LEVI : TwbSignature = 'LEVI'; { Morrowind }
  LHDT : TwbSignature = 'LHDT'; { Morrowind }
  LIGH : TwbSignature = 'LIGH'; { Morrowind }
  LKDT : TwbSignature = 'LKDT'; { Morrowind }
  LNAM : TwbSignature = 'LNAM';
  LOCK : TwbSignature = 'LOCK'; { Morrowind }
  LSCR : TwbSignature = 'LSCR';
  LTEX : TwbSignature = 'LTEX'; { Morrowind }
  LVLC : TwbSignature = 'LVLC';
  LVLD : TwbSignature = 'LVLD';
  LVLF : TwbSignature = 'LVLF';
  LVLI : TwbSignature = 'LVLI';
  LVLO : TwbSignature = 'LVLO';
  LVSP : TwbSignature = 'LVSP';
  MAST : TwbSignature = 'MAST'; { Morrowind }
  MCDT : TwbSignature = 'MCDT'; { Morrowind }
  MEDT : TwbSignature = 'MEDT'; { Morrowind }
  MGEF : TwbSignature = 'MGEF'; { Morrowind }
  MISC : TwbSignature = 'MISC'; { Morrowind }
  MNAM : TwbSignature = 'MNAM'; { Morrowind }
  MO2B : TwbSignature = 'MO2B';
  MO2T : TwbSignature = 'MO2T';
  MO3B : TwbSignature = 'MO3B';
  MO3T : TwbSignature = 'MO3T';
  MO4B : TwbSignature = 'MO4B';
  MO4T : TwbSignature = 'MO4T';
  MOD2 : TwbSignature = 'MOD2';
  MOD3 : TwbSignature = 'MOD3';
  MOD4 : TwbSignature = 'MOD4';
  MODB : TwbSignature = 'MODB';
  MODL : TwbSignature = 'MODL'; { Morrowind }
  MODT : TwbSignature = 'MODT';
  NAM0 : TwbSignature = 'NAM0'; { Morrowind }
  NAM1 : TwbSignature = 'NAM1';
  NAM2 : TwbSignature = 'NAM2';
  NAM5 : TwbSignature = 'NAM5'; { Morrowind }
  NAM9 : TwbSignature = 'NAM9';
  NAME : TwbSignature = 'NAME'; { Morrowind }
  NIFT : TwbSignature = 'NIFT';
  NIFZ : TwbSignature = 'NIFZ';
  NNAM : TwbSignature = 'NNAM'; { Morrowind }
  NPC_ : TwbSignature = 'NPC_'; { Morrowind }
  NPCO : TwbSignature = 'NPCO'; { Morrowind }
  NPCS : TwbSignature = 'NPCS'; { Morrowind }
  NPDT : TwbSignature = 'NPDT'; { Morrowind }
  NULL : TwbSignature = 'NULL';
  OBME : TwbSignature = 'OBME';
  OFST : TwbSignature = 'OFST';
  ONAM : TwbSignature = 'ONAM'; { Morrowind }
  PACK : TwbSignature = 'PACK';
  PBDT : TwbSignature = 'PBDT'; { Morrowind }
  PFIG : TwbSignature = 'PFIG';
  PFPC : TwbSignature = 'PFPC';
  PGAG : TwbSignature = 'PGAG'; { Morrowind }
  PGRC : TwbSignature = 'PGRC'; { Morrowind }
  PGRD : TwbSignature = 'PGRD'; { Morrowind }
  PGRI : TwbSignature = 'PGRI';
  PGRL : TwbSignature = 'PGRL';
  PGRP : TwbSignature = 'PGRP'; { Morrowind }
  PGRR : TwbSignature = 'PGRR';
  PKDT : TwbSignature = 'PKDT';
  PKID : TwbSignature = 'PKID';
  PLDT : TwbSignature = 'PLDT';
  PLYR : TwbSignature = 'PLYR';
  PNAM : TwbSignature = 'PNAM'; { Morrowind }
  PROB : TwbSignature = 'PROB'; { Morrowind }
  PSDT : TwbSignature = 'PSDT';
  PTDT : TwbSignature = 'PTDT';
  PTEX : TwbSignature = 'PTEX'; { Morrowind }
  QNAM : TwbSignature = 'QNAM';
  QSDT : TwbSignature = 'QSDT';
  QSTA : TwbSignature = 'QSTA';
  QSTF : TwbSignature = 'QSTF'; { Morrowind }
  QSTI : TwbSignature = 'QSTI';
  QSTN : TwbSignature = 'QSTN'; { Morrowind }
  QSTR : TwbSignature = 'QSTR'; { Morrowind }
  QUST : TwbSignature = 'QUST';
  RACE : TwbSignature = 'RACE'; { Morrowind }
  RADT : TwbSignature = 'RADT'; { Morrowind }
  RCLR : TwbSignature = 'RCLR';
  RDAT : TwbSignature = 'RDAT';
  RDGS : TwbSignature = 'RDGS';
  RDMD : TwbSignature = 'RDMD';
  RDMP : TwbSignature = 'RDMP';
  RDOT : TwbSignature = 'RDOT';
  RDSD : TwbSignature = 'RDSD';
  RDWT : TwbSignature = 'RDWT';
  REFR : TwbSignature = 'REFR';
  REGN : TwbSignature = 'REGN'; { Morrowind }
  REPA : TwbSignature = 'REPA'; { Morrowind }
  RGNN : TwbSignature = 'RGNN'; { Morrowind }
  RIDT : TwbSignature = 'RIDT'; { Morrowind }
  RNAM : TwbSignature = 'RNAM'; { Morrowind }
  ROAD : TwbSignature = 'ROAD';
  RPLD : TwbSignature = 'RPLD';
  RPLI : TwbSignature = 'RPLI';
  SBSP : TwbSignature = 'SBSP';
  SCDA : TwbSignature = 'SCDA';
  SCDT : TwbSignature = 'SCDT'; { Morrowind }
  SCHD : TwbSignature = 'SCHD'; { Morrowind }
  SCHR : TwbSignature = 'SCHR';
  SCIP : TwbSignature = 'SCIP'; { Morrowind }
  SCIT : TwbSignature = 'SCIT';
  SCPT : TwbSignature = 'SCPT'; { Morrowind }
  SCRI : TwbSignature = 'SCRI'; { Morrowind }
  SCRO : TwbSignature = 'SCRO';
  SCRV : TwbSignature = 'SCRV';
  SCTX : TwbSignature = 'SCTX'; { Morrowind }
  SCVR : TwbSignature = 'SCVR'; { Morrowind }
  SGST : TwbSignature = 'SGST';
  SKDT : TwbSignature = 'SKDT'; { Morrowind }
  SKIL : TwbSignature = 'SKIL'; { Morrowind }
  SLCP : TwbSignature = 'SLCP';
  SLGM : TwbSignature = 'SLGM';
  SLSD : TwbSignature = 'SLSD';
  SNAM : TwbSignature = 'SNAM'; { Morrowind }
  SNDD : TwbSignature = 'SNDD';
  SNDG : TwbSignature = 'SNDG'; { Morrowind }
  SNDX : TwbSignature = 'SNDX';
  SOUL : TwbSignature = 'SOUL';
  SOUN : TwbSignature = 'SOUN'; { Morrowind }
  SPDT : TwbSignature = 'SPDT'; { Morrowind }
  SPEL : TwbSignature = 'SPEL'; { Morrowind }
  SPIT : TwbSignature = 'SPIT';
  SPLO : TwbSignature = 'SPLO';
  SSCR : TwbSignature = 'SSCR'; { Morrowind }
  STAT : TwbSignature = 'STAT'; { Morrowind }
  STRV : TwbSignature = 'STRV'; { Morrowind }
  TCLF : TwbSignature = 'TCLF';
  TCLT : TwbSignature = 'TCLT';
  TES3 : TwbSignature = 'TES3'; { Morrowind }
  TEXT : TwbSignature = 'TEXT'; { Morrowind }
  TNAM : TwbSignature = 'TNAM'; { Morrowind }
  TPIC : TwbSignature = 'TPIC';
  TRDT : TwbSignature = 'TRDT';
  TREE : TwbSignature = 'TREE';
  TRGT : TwbSignature = 'TRGT';
  UNAM : TwbSignature = 'UNAM'; { Morrowind }
  VCLR : TwbSignature = 'VCLR'; { Morrowind }
  VHGT : TwbSignature = 'VHGT'; { Morrowind }
  VNAM : TwbSignature = 'VNAM';
  VNML : TwbSignature = 'VNML';
  VTEX : TwbSignature = 'VTEX'; { Morrowind }
  VTXT : TwbSignature = 'VTXT';
  WATR : TwbSignature = 'WATR';
  WEAP : TwbSignature = 'WEAP'; { Morrowind }
  WEAT : TwbSignature = 'WEAT'; { Morrowind }
  WHGT : TwbSignature = 'WHGT'; { Morrowind }
  WLST : TwbSignature = 'WLST';
  WNAM : TwbSignature = 'WNAM';
  WPDT : TwbSignature = 'WPDT'; { Morrowind }
  WRLD : TwbSignature = 'WRLD';
  WTHR : TwbSignature = 'WTHR';
  XACT : TwbSignature = 'XACT';
  XCCM : TwbSignature = 'XCCM';
  XCHG : TwbSignature = 'XCHG'; { Morrowind }
  XCLC : TwbSignature = 'XCLC';
  XCLL : TwbSignature = 'XCLL';
  XCLR : TwbSignature = 'XCLR';
  XCLW : TwbSignature = 'XCLW';
  XCMT : TwbSignature = 'XCMT';
  XCNT : TwbSignature = 'XCNT';
  XCWT : TwbSignature = 'XCWT';
  XESP : TwbSignature = 'XESP';
  XGLB : TwbSignature = 'XGLB';
  XHLT : TwbSignature = 'XHLT';
  XHRS : TwbSignature = 'XHRS';
  XLCM : TwbSignature = 'XLCM';
  XLOC : TwbSignature = 'XLOC';
  XLOD : TwbSignature = 'XLOD';
  XMRC : TwbSignature = 'XMRC';
  XMRK : TwbSignature = 'XMRK';
  XNAM : TwbSignature = 'XNAM';
  XOWN : TwbSignature = 'XOWN';
  XPCI : TwbSignature = 'XPCI';
  XRGD : TwbSignature = 'XRGD';
  XRNK : TwbSignature = 'XRNK';
  XRTM : TwbSignature = 'XRTM';
  XSCL : TwbSignature = 'XSCL'; { Morrowind }
  XSED : TwbSignature = 'XSED';
  XSOL : TwbSignature = 'XSOL'; { Morrowind }
  XTEL : TwbSignature = 'XTEL';
  XTRG : TwbSignature = 'XTRG';
  XXXX : TwbSignature = 'XXXX';
  ZNAM : TwbSignature = 'ZNAM';

var
  wbEDID: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXGLB: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbSpecializationEnum: IwbEnumDef;
  wbOBMEResolutionInfo: IwbEnumDef;
  wbSoulGemEnum: IwbEnumDef;
  wbMusicEnum: IwbEnumDef;
  wbSLSD: IwbSubRecordDef;
  wbBodyDataIndex: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbSubRecordDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbCSDT: IwbSubRecordStructDef;
  wbCSDTs: IwbSubRecordArrayDef;
  wbFULL: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbXNAM: IwbSubRecordDef;
  wbXNAMs: IwbSubRecordArrayDef;
  wbDESC: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbDATAPosRot : IwbSubRecordDef;
  wbPosRot : IwbStructDef;
  wbMODL: IwbSubRecordStructDef;
  wbCTDA: IwbSubRecordUnionDef;
  wbSCHR: IwbSubRecordUnionDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbSCROs: IwbSubRecordArrayDef;
  wbPGRP: IwbSubRecordDef;
  wbPGRC: IwbSubRecordDef;
  wbResultScript: IwbSubRecordStructDef;
//  wbResultScriptOld: IwbSubRecordStructDef;
  wbSCRI: IwbSubRecordDef;
  wbFaceGen: IwbSubRecordStructDef;
  wbENAM: IwbSubRecordDef;
  wbFGGS: IwbSubRecordDef;
  wbXLOD: IwbSubRecordDef;
  wbICON: IwbSubRecordDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbFormTypeEnum: IwbEnumDef;
  wbSexEnum: IwbEnumDef;
  wbAxisEnum: IwbEnumDef;
  wbServiceFlags: IwbFlagsDef;
  wbSkillEnum: IwbEnumDef;
  wbPKDTType: IwbEnumDef;
  wbPKDTFlags: IwbFlagsDef;
  wbQuadrantEnum: IwbEnumDef;
  wbBlendModeEnum: IwbEnumDef;
  wbBlendOpEnum: IwbEnumDef;
  wbZTestFuncEnum: IwbEnumDef;
  wbEFID: IwbSubRecordDef;
  wbEFIDOBME: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbMagicSchoolEnum: IwbEnumDef;
  wbFunctionsEnum: IwbEnumDef;
  wbSCIT: IwbSubRecordStructDef;
  wbSCITOBME: IwbSubRecordStructDef;
  wbEffects: IwbSubRecordUnionDef;
  wbAttributeEnum: IwbEnumDef;

function wbClmtMoonsPhaseLength(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PhaseLength : Byte;
  Masser      : Boolean;
  Secunda     : Boolean;
begin
  Result := '';
  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt, 2);
  end else if aType = ctToStr then begin
    PhaseLength := aInt mod 64;
    Masser := (aInt and 64) <> 0;
    Secunda := (aInt and 128) <> 0;
    if Masser then
      if Secunda then
        Result := 'Masser, Secunda / '
      else
        Result := 'Masser / '
    else
      if Secunda then
        Result := 'Secunda / '
      else
        Result := 'No Moon / ';
    Result := Result + IntToStr(PhaseLength);
  end;
end;

function wbClmtTime(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) );
end;

var
  wbCtdaTypeFlags : IwbFlagsDef;

function wbCtdaType(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  s: string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and $F0 of
        $00 : Result := 'Equal to';
        $20 : Result := 'Not equal to';
        $40 : Result := 'Greater than';
        $60 : Result := 'Greater than or equal to';
        $80 : Result := 'Less than';
        $A0 : Result := 'Less than or equal to';
      else
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.ToString(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: begin
      case aInt and $F0 of
        $00, $20, $40, $60, $80, $A0 : Result := '';
      else
        Result := '<Unknown Compare operator>'
      end;

      if not Assigned(wbCtdaTypeFlags) then
        wbCtdaTypeFlags := wbFlags([
          {0x01} 'Or',
          {0x02} 'Run on target',
          {0x04} 'Use global'
        ]);

      s := wbCtdaTypeFlags.Check(aInt and $0F, aElement);

      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not $80 of
        0: Result := 'Lower Body';
        1: Result := 'Left Arm';
        2: Result := 'Left Hand';
        3: Result := 'Right Arm';
        4: Result := 'Special Idle';
        5: Result := 'Whole Body';
        6: Result := 'Upper Body';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $80)+'>';
      end;

      if (aInt and $80) = 0 then
        Result := Result + ', Must return a file';
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
    end;
    ctCheck: begin
      case aInt and not $80 of
        0..6: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not $80)+'>';
      end;
    end;
  end;
end;

function wbScaledInt4ToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
    ctToSortKey: begin
      Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
      if Length(Result) < 22 then
        Result := StringOfChar('0', 22 - Length(Result)) + Result;
      Result := PlusMinus[aInt < 0] + Result;
    end;
    ctCheck: Result := '';
  end;
end;

function wbScaledInt4ToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f * 10000;
  Result := Round(f);
end;

function wbHideFFFF(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType = ctToStr then
    if aInt = $FFFF then
      Result := 'None'
    else
      Result := IntToStr(aInt);
end;

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt div 17, 2) + IntToHex64(aInt mod 17, 2)
  else if aType = ctCheck then begin
    if (aInt < 0) or (aInt > 288) then
      Result := '<Out of range: '+IntToStr(aInt)+'>'
    else
      Result := '';
  end else if aType = ctToStr then
    Result := IntToStr(aInt) + ' -> ' + IntToStr(aInt div 17) + ':' + IntToStr(aInt mod 17);
end;

function wbWthrDataClassification(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt and not 192 of
        0: Result := 'None';
        1: Result := 'Pleasant';
        2: Result := 'Cloudy';
        3: Result := 'Rainy';
        4: Result := 'Snow';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2)
    end;
    ctCheck: begin
      case aInt and not 192 of
        0..4: Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt and not 192)+'>';
      end;
    end;
  end;
end;

function wbGLOBFNAM(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr: begin
      case aInt of
        Ord('s'): Result := 'Short';
        Ord('l'): Result := 'Long';
        Ord('f'): Result := 'Float';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
    ctToSortKey: Result := Chr(aInt);
    ctCheck: begin
      case aInt of
        Ord('s'), Ord('l'), Ord('f'): Result := '';
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
      end;
    end;
  end;
end;

function wbPlacedAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  s: string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['NAME'];
  if Assigned(Rec) then begin
    s := Trim(Rec.Value);
    if s <> '' then
      Result := 'places ' + s;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := Trim(Container.Name);
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + 'in ' + s;
    end;
  end;
end;

function wbCellAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  GroupRecord : IwbGroupRecord;
  s: string;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['XCLC'];
  if Assigned(Rec) then
      Result := 'at ' + Rec.Elements[0].Value + ',' + Rec.Elements[1].Value;

  Container := aMainRecord.Container;
  while Assigned(Container) and not
    (Supports(Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1))  do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := wbFormID.ToString(GroupRecord.GroupLabel, aMainRecord);
    if s <> '' then begin
      if Result <> '' then
        s := s + ' ';
      Result := 'in ' + s + Result;
    end;
  end;
end;

function wbNPCDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  SubRecord: IwbSubRecord;
begin
  Result := 0;
  if Assigned(aElement) and Supports(aElement.Container, IwbSubRecord, SubRecord) then
    if SubRecord.SubRecordHeaderSize = 12 then
      Result := 1;
end;

function wbGLOBUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rValue: IwbRecord;
  s: string;
begin
  Result := 0;
  rValue := aElement.Container.RecordBySignature[FNAM];
  if Assigned(rValue) then begin
    s := rValue.Value;
    if Length(s) > 0 then
      case s[1] of
        's': Result := 0;
        'l': Result := 1;
        'f': Result := 2;
      end;
  end;
end;

function wbMISCActorValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord : IwbMainRecord;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if (MainRecord.Flags._Flags and $000000C0) = $000000C0 then
    Result := 1;
end;

function wbXLOCFillerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 16 then
    Result := 1;
end;

function wbPACKPKDTDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 1;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 4 then
    Result := 0;
end;

function wbREFRXSEDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Container.DataSize = 4 then
    Result := 1;
end;


type
  TCTDAFunctionParamType = (
    ptNone,
    ptInteger,
    ptVariableName,  //Integer
    ptSex,           //Enum: Male, Female
    ptActorValue,    //Enum: wbActorValue
    ptCrimeType,     //?? Enum
    ptAxis,          //?? Char
    ptFormType,      //?? Enum
    ptQuestStage,

    ptObjectReference,    //REFR, ACHR, ACRE, PGRE
    ptInventoryObject,    //ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, NOTE, ARMA
    ptActor,              //ACHR, ACRE
    ptQuest,              //QUST
    ptFaction,            //FACT
    ptCell,               //CELL
    ptClass,              //CLAS
    ptRace,               //RACE
    ptActorBase,          //NPC_, CREA
    ptGlobal,             //GLOB
    ptWeather,            //WTHR
    ptPackage,            //PACK
    ptOwnerOpt,           //FACT, NPC_
    ptBirthsign,          //BSGN
    ptFurniture,          //FURN
    ptMagicItem,          //SPEL
    ptMagicEffect,        //MGEF
    ptWorldspace,         //WRLD
    ptReferencableObject
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..168] of TCTDAFunction = (
    (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),
    (Index:   5; Name: 'GetLocked'),
    (Index:   6; Name: 'GetPos'; ParamType1: ptAxis),
    (Index:   8; Name: 'GetAngle'; ParamType1: ptAxis),
    (Index:  10; Name: 'GetStartingPos'; ParamType1: ptAxis),
    (Index:  11; Name: 'GetStartingAngle'; ParamType1: ptAxis),
    (Index:  12; Name: 'GetSecondsPassed'),
    (Index:  14; Name: 'GetActorValue'; ParamType1: ptActorValue),
    (Index:  18; Name: 'GetCurrentTime'),
    (Index:  24; Name: 'GetScale'),
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
    (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; ParamType1: ptInteger),
    (Index:  39; Name: 'GetDisease'),
    (Index:  40; Name: 'GetVampire'),
    (Index:  41; Name: 'GetClothingValue'),
    (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),
    (Index:  43; Name: 'SameRace'; ParamType1: ptActor),
    (Index:  44; Name: 'SameSex'; ParamType1: ptActor),
    (Index:  45; Name: 'GetDetected'; ParamType1: ptActor),
    (Index:  46; Name: 'GetDead'),
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptInventoryObject),
    (Index:  48; Name: 'GetGold'),
    (Index:  49; Name: 'GetSleeping'),
    (Index:  50; Name: 'GetTalkedToPC'),
    (Index:  53; Name: 'GetScriptVariable'; ParamType1: ptObjectReference; ParamType2: ptVariableName),
    (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),
    (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
    (Index:  60; Name: 'GetFactionRankDifference'; ParamType1: ptFaction; ParamType2: ptActor),
    (Index:  61; Name: 'GetAlarmed'),
    (Index:  62; Name: 'IsRaining'),
    (Index:  63; Name: 'GetAttacked'),
    (Index:  64; Name: 'GetIsCreature'),
    (Index:  65; Name: 'GetLockLevel'),
    (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),
    (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),
    (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),
    (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),
    (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex),
    (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
    (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),
    (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),
    (Index:  75; Name: 'IsSnowing'),
    (Index:  76; Name: 'GetDisposition'; ParamType1: ptActor),
    (Index:  77; Name: 'GetRandomPercent'),
    (Index:  79; Name: 'GetQuestVariable'; ParamType1: ptQuest; ParamType2: ptVariableName),
    (Index:  80; Name: 'GetLevel'),
    (Index:  81; Name: 'GetArmorRating'),
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
    (Index:  91; Name: 'GetIsAlerted'),
    (Index:  98; Name: 'GetPlayerControlsDisabled'),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 104; Name: 'IsYielding'),
    (Index: 106; Name: 'IsFacingUp'),
    (Index: 107; Name: 'GetKnockedState'),
    (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'GetWeaponSkillType'),
    (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'GetCrimeGold'),
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'CanPayCrimeGold'),
    (Index: 128; Name: 'GetFatiguePercentage'),
    (Index: 129; Name: 'GetPCIsClass'; ParamType1: ptClass),
    (Index: 130; Name: 'GetPCIsRace'; ParamType1: ptRace),
    (Index: 131; Name: 'GetPCIsSex'; ParamType1: ptSex),
    (Index: 132; Name: 'GetPCInFaction'; ParamType1: ptFaction),
    (Index: 133; Name: 'SameFactionAsPC'),
    (Index: 134; Name: 'SameRaceAsPC'),
    (Index: 135; Name: 'SameSexAsPC'),
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
    (Index: 141; Name: 'IsTalking'),
    (Index: 142; Name: 'GetWalkSpeed'),
    (Index: 143; Name: 'GetCurrentAIProcedure'),
    (Index: 144; Name: 'GetTrespassWarningLevel'),
    (Index: 145; Name: 'IsTrespassing'),
    (Index: 146; Name: 'IsInMyOwnedCell'),
    (Index: 147; Name: 'GetWindSpeed'),
    (Index: 148; Name: 'GetCurrentWeatherPercent'),
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),
    (Index: 153; Name: 'CanHaveFlames'),
    (Index: 154; Name: 'HasFlames'),
    (Index: 157; Name: 'GetOpenState'),
    (Index: 159; Name: 'GetSitting'),
    (Index: 160; Name: 'GetFurnitureMarkerID'),
    (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),
    (Index: 170; Name: 'GetDayOfWeek'),
    (Index: 171; Name: 'IsPlayerInJail'),
    (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'GetDetectionLevel'; ParamType1: ptActor),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptInventoryObject),
    (Index: 185; Name: 'IsSwimming'),
    (Index: 190; Name: 'GetAmountSoldStolen'),
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),
    (Index: 197; Name: 'GetPCFactionSteal'; ParamType1: ptFaction),
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),
    (Index: 201; Name: 'GetPCFactionSubmitAuthority'; ParamType1: ptFaction),
    (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
    (Index: 215; Name: 'GetDoorDefaultOpen'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
    (Index: 224; Name: 'GetIsPlayerBirthsign'; ParamType1: ptBirthsign),
    (Index: 225; Name: 'GetPersuasionNumber'),
    (Index: 227; Name: 'HasVampireFed'),
    (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),
    (Index: 229; Name: 'GetClassDefaultMatch'),
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
    (Index: 237; Name: 'GetIsGhost'),
    (Index: 242; Name: 'GetUnconscious'),
    (Index: 244; Name: 'GetRestrained'),
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
    (Index: 249; Name: 'GetPCFame'),
    (Index: 251; Name: 'GetPCInfamy'),
    (Index: 254; Name: 'GetIsPlayableRace'),
    (Index: 255; Name: 'GetOffersServicesNow'),
    (Index: 258; Name: 'GetUsedItemLevel'),
    (Index: 259; Name: 'GetUsedItemActivate'),
    (Index: 264; Name: 'GetBarterGold'),
    (Index: 265; Name: 'IsTimePassing'),
    (Index: 266; Name: 'IsPleasant'),
    (Index: 267; Name: 'IsCloudy'),
    (Index: 274; Name: 'GetArmorRatingUpperBody'),
    (Index: 277; Name: 'GetBaseActorValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwnerOpt),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwnerOpt),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
    (Index: 288; Name: 'GetFriendHit'; ParamType1: ptActor),
    (Index: 289; Name: 'IsInCombat'),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 305; Name: 'GetInvestmentGold'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptInteger),
    (Index: 313; Name: 'IsActorEvil'),
    (Index: 314; Name: 'IsActorAVictim'),
    (Index: 315; Name: 'GetTotalPersuasionNumber'),
    (Index: 318; Name: 'GetIdleDoneOnce'),
    (Index: 320; Name: 'GetNoRumors'),
    (Index: 323; Name: 'WhichServiceMenu'),
    (Index: 327; Name: 'IsRidingHorse'),
    (Index: 329; Name: 'IsTurnArrest'),
    (Index: 332; Name: 'IsInDangerousWater'),
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenHorse'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
    (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'GetPlayerHasLastRiddenHorse'),
    (Index: 365; Name: 'GetPlayerInSEWorld')
  );

var
  wbCTDAFunctionEditInfo : string;

function CmpU32(a, b : Cardinal) : Integer;
asm
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;

function wbCTDAParamDescFromIndex(aIndex: Integer): PCTDAFunction;
var
  L, H, I, C: Integer;
begin
  Result := nil;

  L := Low(wbCTDAFunctions);
  H := High(wbCTDAFunctions);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpU32(wbCTDAFunctions[I].Index, aIndex);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        L := I;
        Result := @wbCTDAFunctions[L];
      end;
    end;
  end;
end;

function wbCTDACompValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  if Integer(Container.ElementByName['Type'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType1));
end;

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if Assigned(Desc) then
    Result := Succ(Integer(Desc.ParamType2));
end;
{
function wbCTDAFunction(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc: PCTDAFunction;
begin
  Result := '';
  case aType of
    ctToStr: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
  end;
end;
}
function wbCTDAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc : PCTDAFunction;
  i    : Integer;
begin
  Result := '';
  case aType of
    ctToStr, ctToEditValue: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else if aType = ctToEditValue then
        Result := IntToStr(aInt)
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+IntToStr(aInt)+'>';
    end;
    ctEditType:
      Result := 'ComboBox';
    ctEditInfo: begin
      Result := wbCTDAFunctionEditInfo;
      if Result = '' then begin
        with TStringList.Create do try
          for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
            Add(wbCTDAFunctions[i].Name);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
        wbCTDAFunctionEditInfo := Result;
      end;
    end;
  end;
end;

function wbCTDAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
    with wbCTDAFunctions[i] do
      if SameText(Name, aString) then begin
        Result := Index;
        Exit;
      end;
  Result := StrToInt64(aString);
end;

function wbCTDAParam2VariableNameToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  Variables  : TStringList;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    Exit;

  MainRecord := nil;
  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;
{    if Param1.NativeValue = 0 then
      if Supports(Container.Container, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbContainerElementRef, Container2) then
            if SameText(Container2.ElementValues['Function'], 'GetIsID') then begin
              Param1 := Container2.ElementByName['Parameter #1'];
              if Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
                Break;
            end;}

  if not Assigned(MainRecord) then
    Exit;

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not contain a SCRI subrecord>';
    end;
    Exit;
  end;

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" does not have a valid script>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      Variables := TStringList.Create;
  else
    Variables := nil;
  end;
  try
    if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
      for i := 0 to Pred(LocalVars.ElementCount) do
        if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
          j := LocalVar.ElementNativeValues['SLSD\Index'];
          s := LocalVar.ElementNativeValues['SCVR'];
          if Assigned(Variables) then
            Variables.AddObject(s, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToEditValue: Result := s;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Variable Index not found in "' + Script.Name + '">';
      ctCheck: Result := '<Warning: Variable Index not found in "' + Script.Name + '">';
      ctEditInfo: begin
        Variables.Sort;
        Result := Variables.CommaText;
      end;
    end;
  finally
    FreeAndNil(Variables);
  end;
end;

function wbCTDAParam2VariableNameToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  BaseRecord : IwbMainRecord;
  ScriptRef  : IwbElement;
  Script     : IwbMainRecord;
  LocalVars  : IwbContainerElementRef;
  LocalVar   : IwbContainerElementRef;
  i, j       : Integer;
  s          : string;
begin
  Result := StrToInt64Def(aString, Low(Cardinal));
  if Result <> Low(Cardinal) then
    Exit;

  if not Assigned(aElement) then
    raise Exception.Create('aElement not specified');

  Container := GetContainerRefFromUnionOrValue(aElement);

  if not Assigned(Container) then
    raise Exception.Create('Container not assigned');

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    raise Exception.Create('Could not find "Parameter #1"');

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    raise Exception.Create('"Parameter #1" does not reference a valid main record');

  BaseRecord := MainRecord.BaseRecord;
  if Assigned(BaseRecord) then
    MainRecord := BaseRecord;

  ScriptRef := MainRecord.RecordBySignature['SCRI'];

  if not Assigned(ScriptRef) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not contain a SCRI subrecord');

  if not Supports(ScriptRef.LinksTo, IwbMainRecord, Script) then
    raise Exception.Create('"'+MainRecord.ShortName+'" does not have a valid script');

  if Supports(Script.ElementByName['Local Variables'], IwbContainerElementRef, LocalVars) then begin
    for i := 0 to Pred(LocalVars.ElementCount) do
      if Supports(LocalVars.Elements[i], IwbContainerElementRef, LocalVar) then begin
        j := LocalVar.ElementNativeValues['SLSD\Index'];
        s := LocalVar.ElementNativeValues['SCVR'];
        if SameText(s, Trim(aString)) then begin
          Result := j;
          Exit;
        end;
      end;
  end;

  raise Exception.Create('Variable "'+aString+'" was not found in "'+MainRecord.ShortName+'"');
end;

function wbCTDAParam2QuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Stages     : IwbContainerElementRef;
  Stage      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr: Result := IntToStr(aInt) + ' <Warning: Could not resolve Parameter 1>';
    ctToEditValue: Result := IntToStr(aInt);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aElement) then Exit;
  Container := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(Container) then Exit;

  Param1 := Container.ElementByName['Parameter #1'];

  if not Assigned(Param1) then
    Exit;

  if not Supports(Param1.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      EditInfos := TStringList.Create;
  else
    EditInfos := nil;
  end;
  try
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX'];
          s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr: Result := IntToStr(aInt) + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

procedure wbRemoveOFST(const aElement: IwbElement);
var
  Container: IwbContainer;
  rOFST: IwbRecord;
begin
  if Supports(aElement, IwbContainer, Container) then begin
    rOFST := Container.RecordBySignature[OFST];
    if Assigned(rOFST) then
      Container.RemoveElement(rOFST);
  end;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  i            : Integer;
  IsInterior   : Boolean;
  GroupRecord  : IwbGroupRecord;
  Removed      : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Container.ElementExists['DATA'] then
      Exit;

    IsInterior := (Container.ElementNativeValues['DATA'] and 1) <> 0;

    if IsInterior then
      Container.Add('XCLL')
    else begin
      Container.Add('XCLC');
      if (Container.ElementNativeValues['DATA'] and 2) = 0 then
        if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
          if GroupRecord.GroupType = 1 then
            Container.ElementNativeValues['DATA'] :=
              Container.ElementNativeValues['DATA'] or 2;
    end;

    Removed := False;
    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
      for i:= Pred(Container2.ElementCount) downto 0 do
        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then begin
          if not Removed then begin
            Removed := True;
            Container2.MarkModifiedRecursive;
          end;
          Container2.RemoveElement(i);
        end;
      if Container2.ElementCount < 1 then
        Container2.Remove;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMGEFAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  _File        : IwbFile;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    _File := MainRecord._File;

    if not Assigned(_File) then
      Exit;

    if not SameText(_File.FileName, 'Oblivion.esm') then
      Exit;

    if SameText(MainRecord.EditorID, 'RSFI') or
       SameText(MainRecord.EditorID, 'RSFR') or
       SameText(MainRecord.EditorID, 'RSPA') or
       SameText(MainRecord.EditorID, 'RSSH') then begin

         Container.ElementNativeValues['DATA - Data\Flags'] :=
           Cardinal(Container.ElementNativeValues['DATA - Data\Flags']) or $8;

       end;

    if SameText(MainRecord.EditorID, 'REAN') then begin

         Container.ElementNativeValues['DATA - Data\Flags'] :=
           Cardinal(Container.ElementNativeValues['DATA - Data\Flags']) and not $20000;

       end;

  finally
    wbEndInternalEdit;
  end;
end;


procedure wbEFITAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  ActorValue: Variant;
  MainRecord: IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Element := Container.ElementByName['Magic effect name'];
    if not Assigned(Element) then
      Exit;
    if not Supports(Element.LinksTo, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.Signature <> 'MGEF' then
      Exit;

    if (MainRecord.ElementNativeValues['DATA - Data\Flags'] and $01000000) = 0 then
      Exit;

    ActorValue := MainRecord.ElementNativeValues['DATA - Data\Assoc. Item'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;
    if VarCompareValue(ActorValue, Container.ElementNativeValues['Actor Value']) <> vrEqual then
      Container.ElementNativeValues['Actor Value'] := ActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;
    if Container.ElementCount < 1 then
      Exit;

    Container.RemoveElement('XPCI');
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLIGHAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if Container.ElementExists['DATA'] then begin
      if SameValue(Container.ElementNativeValues['DATA\Falloff Exponent'], 0.0) then
        Container.ElementNativeValues['DATA\Falloff Exponent'] := 1.0;
      if SameValue(Container.ElementNativeValues['DATA\FOV'], 0.0) then
        Container.ElementNativeValues['DATA\FOV'] := 90.0;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLVLAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Chance     : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    Container.RemoveElement('DATA');

    Chance := Container.ElementNativeValues['LVLD'];
    if (Chance and $80) <> 0 then begin
      Chance := Chance and not $80;
      Container.ElementNativeValues['LVLD'] := Chance;
      Container.ElementNativeValues['LVLF'] := Container.ElementNativeValues['LVLF'] or $01;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbRPLDAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainer;
  a, b      : Single;
  NeedsFlip : Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    NeedsFlip := False;
    if Container.ElementCount > 1 then begin
      a := (Container.Elements[0] as IwbContainer).Elements[0].NativeValue;
      b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[0].NativeValue;
      case CompareValue(a, b) of
        EqualsValue: begin
          a := (Container.Elements[0] as IwbContainer).Elements[1].NativeValue;
          b := (Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[1].NativeValue;
          NeedsFlip := CompareValue(a, b) = GreaterThanValue;
        end;
        GreaterThanValue:
          NeedsFlip := True;
      end;
    end;
    if NeedsFlip then
      Container.ReverseElements;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRDAfterLoad(const aElement: IwbElement);
var
  Container   : IwbContainerElementRef;
  MainRecord  : IwbMainRecord;
  Points      : IwbContainerElementRef;
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  Point       : IwbContainerElementRef;
  Connection  : IwbContainerElementRef;
  Removed     : Boolean;
  FirstRemoved: Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Supports(Container.ElementBySignature['PGRP'], IwbContainerElementRef, Points) then
      Exit;

    if not Container.ElementExists['PGAG'] then
      Container.Add('PGAG').DataSize := (Points.ElementCount + 7) div 8;

    MainRecord.IsCompressed := True;

    if not Supports(Container.ElementBySignature['PGRR'], IwbContainerElementRef, Connections) then
      Exit;

    if Points.ElementCount < Connections.ElementCount then
      Exit;

    FirstRemoved := False;
    for i := Pred(Connections.ElementCount) downto 0 do begin
      Connection := Connections.Elements[i] as IwbContainerElementRef;

      Removed := False;
      j := Connection.ElementCount;
      while j > 0 do begin
        Dec(j);
        if Connection.Elements[j].NativeValue = 65535 then begin
          if not FirstRemoved then begin
            FirstRemoved := True;
            Connections.MarkModifiedRecursive;
          end;
          Connection.Elements[j].Remove;
          Removed := True;
        end else
          Break;
      end;

      if Removed then begin
        Point := Points.Elements[i] as IwbContainerElementRef;
        Point.ElementNativeValues['Connections'] := Connection.ElementCount;
      end;

    end;

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRRPointAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i           : Integer;
//  Index       : Integer;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;
    for i := Pred(Connections.ElementCount) downto 0 do
      if Connections.Elements[i].NativeValue = 65535 then begin
        Connections.RemoveElement(i);
      end;
{    if Removed then begin
      Index := aElement.Container.ElementCount;
      (aElement.ContainingMainRecord.RecordBySignature['PGRP'].Elements[Index] as IwbContainer).Elements[3].NativeValue := Connections.ElementCount;
    end;}
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbPGRIPointerAfterLoad(const aElement: IwbElement);
var
  Connections : IwbContainerElementRef;
  i, j        : Integer;
  s           : string;
  Keys        : TStringList;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Connections) then
      Exit;

    Keys := TStringList.Create;
    try
      Keys.Sorted := True;
      Keys.Duplicates := dupError;
      for i := Pred(Connections.ElementCount) downto 0 do begin
        s := Connections.Elements[i].SortKey[True];
        if Keys.Find(s, j) then
          Connections.RemoveElement(i, True)
        else
          Keys.Add(s);
      end;
    finally
      Keys.Free;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

{
function wbPGRPConnectionsCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Point : IwbContainerElementRef;
  s     : string;
  i     : Integer;
  PGRP  : IwbContainerElementRef;
  PGRD  : IwbMainRecord;
  PGRR  : IwbContainerElementRef;
  Cons  : IwbContainerElementRef;
begin
  Result := '';
  if aType = ctCheck then
    Exit;

  if wbFixupPGRD and (aInt > 0) and Assigned(aElement) and (aElement.ElementStates * [esModified] = []) then begin
    Point := aElement.Container as IwbContainerElementRef;
    if Assigned(Point) then begin
      s := Trim(Point.Name);
      i := Pos('#', s);
      if i > 0 then begin
        i := StrToIntDef(Copy(s, i+1, High(Integer)), -1);
        if i >= 0 then begin
          PGRP := Point.Container as IwbContainerElementRef;
          if Assigned(PGRP) then begin
            if Supports(PGRP.Container, IwbMainRecord, PGRD) then begin
              if (csInitDone in PGRD.ContainerStates) and (PGRD.Signature = 'PGRD') then begin
                PGRR := PGRD.RecordBySignature['PGRR'] as IwbContainerElementRef;
                if Assigned(PGRR) and (PGRR.ElementCount > 0) and (csInitDone in PGRR.ContainerStates) then begin
                  if (i < PGRR.ElementCount) then begin
                    if Supports(PGRR.Elements[i], IwbContainer, Cons) then begin
                      aInt := Cons.ElementCount;
                    end;
                  end;
                end;
                PGRR := nil;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 2)
  else if aType = ctToStr then
    Result := IntToStr(aInt);
end;
}

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  Result := Container.ElementByName['Type'].NativeValue;
end;

function wbCalcPGRRSize(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Index: Integer;
begin
  Index := aElement.Container.ElementCount;
  Result := ((aElement.Container.Container as IwbMainRecord).RecordBySignature['PGRP'].Elements[Pred(Index)] as IwbContainer).Elements[3].NativeValue;
end;

function wbMGEFFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  s: string;
  Container: IwbContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Container := GetContainerFromUnion(aElement);
  if not Assigned(Container) then Exit;

  s := Container.ElementByName['Flags'].SortKey[False];
  if s[17] = '1' then
    Result := 1
  else if s[18] = '1' then
    Result := 2
  else if s[19] = '1' then
    Result := 3
  else if s[25] = '1' then
    Result := 4;
end;

function wbEDDXDontShow(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := True;

  if Supports(aElement.Container, IwbMainRecord, MainRecord) then
    Result := not Assigned(MainRecord.ElementBySignature[OBME]);
end;

function wbOBMEDontShow(const aElement: IwbElement): Boolean;
var
  _File: IwbFile;
begin
  if not Assigned(aElement) then begin
    Result := True;
    Exit;
  end;

  Result := False;

  _File := aElement._File;
  if Assigned(_File) and SameText(_File.FileName, 'Oblivion.esm') then
    Result := True;
end;

procedure DefineTES3;
begin
  wbHeaderSignature := 'TES3';
  
  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags([
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {0x00000004}'Unknown 3',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Unknown 6',
    {0x00000040}'Unknown 7',
    {0x00000080}'Unknown 8',
    {0x00000100}'Unknown 9',
    {0x00000200}'Unknown 10',
    {Confirmed} {0x00000400}'PersistentReference', {TES3} {ACTI}
    {0x00000800}'Unknown 12',
    {0x00001000}'Unknown 13',
    {Confirmed} {0x00002000}'Blocked', {TES3} {ACTI}
    {0x00004000}'Unknown 15',
    {0x00008000}'Unknown 16',
    {0x00010000}'Unknown 17',
    {0x00020000}'Unknown 18',
    {0x00040000}'Unknown 19',
    {0x00080000}'Unknown 20',
    {0x00100000}'Unknown 21',
    {0x00200000}'Unknown 22',
    {0x00400000}'Unknown 23',
    {0x00800000}'Unknown 24',
    {0x01000000}'Unknown 25',
    {0x02000000}'Unknown 26',
    {0x04000000}'Unknown 27',
    {0x08000000}'Unknown 28',
    {0x10000000}'Unknown 29',
    {0x20000000}'Unknown 30',
    {0x40000000}'Unknown 31',
    {0x80000000}'Unknown 32'
  ]));

  wbMainRecordHeader := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    wbByteArray('Version Control Info', 4, cpIgnore),
    wbRecordFlags
  ]);

  wbSizeOfMainRecordStruct := 16;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbByteArray(XRGD, 'Ragdoll Data');

  wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);

  wbEDID := wbString(EDID, 'Editor ID', 0, cpBenign);
  wbFULL := wbString(FULL, 'Name', 0, cpTranslate);
  wbFULLReq := wbString(FULL, 'Name', 0, cpNormal, True);
  wbDESC := wbString(DESC, 'Description', 0, cpTranslate);
  wbXSCL := wbFloat(XSCL, 'Scale');

  wbPosRot :=
    wbStruct('Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ]);

  wbDATAPosRot :=
    wbStruct(DATA, 'Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
    ], cpNormal, True);

  wbMODL :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model Filename'),
      wbFloat(MODB, 'Bound Radius', cpBenign),
      wbByteArray(MODT, 'Texture Files Hashes', 0, cpIgnore)
//      wbArray(MODT, 'Unknown',
//        wbByteArray('Unknown', 24, cpBenign),
//      0, nil, cpBenign)
    ], []);

  wbSCRI := wbFormIDCk(SCRI, 'Script', [SCPT]);
  wbENAM := wbFormIDCk(ENAM, 'Enchantment', [ENCH]);

  wbXLOD := wbArray(XLOD, 'Distant LOD Data', wbFloat('Unknown'), 3);

  wbXOWN := wbFormIDCk(XOWN, 'Owner', [FACT, NPC_]);
  wbXGLB := wbFormIDCk(XGLB, 'Global variable', [GLOB]);

  {Done}
  wbRecord(ACTI, 'Activator', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbICON := wbString(ICON, 'Icon filename');

  wbActorValueEnum :=
    wbEnum([
      'Strength',
      'Intelligence',
      'Willpower',
      'Agility',
      'Speed',
      'Endurance',
      'Personality',
      'Luck',
      'Health',
      'Magicka',
      'Fatigue',
      'Encumbrance',
      'Armorer',
      'Athletics',
      'Blade',
      'Block',
      'Blunt',
      'Hand To Hand',
      'Heavy Armor',
      'Alchemy',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration',
      'Acrobatics',
      'Light Armor',
      'Marksman',
      'Mercantile',
      'Security',
      'Sneak',
      'Speechcraft',
 {33} 'Aggression',
 {34} 'Confidence',
 {35} 'Energy',
 {36} 'Responsibility',
 {37} 'Bounty',
 {38} 'Fame',
 {39} 'Infamy',
 {40} 'Magicka Multiplier',
 {41} 'Night Eye Bonus',
 {42} 'Attack Bonus',
 {43} 'Defend Bonus',
 {44} 'Casting Penalty',
 {45} 'Blindness',
 {46} 'Chameleon',
 {47} 'Invisibility',
 {48} 'Paralysis',
 {49} 'Silence',
 {50} 'Confusion',
 {51} 'Detect Item Range',
 {52} 'Spell Absorb Chance',
 {53} 'Spell Reflect Chance',
 {54} 'Swim Speed Multiplier',
 {55} 'Water Breathing',
 {56} 'Water Walking',
 {57} 'Stunted Magicka',
 {58} 'Detect Life Range',
 {59} 'Reflect Damage',
 {60} 'Telekinesis',
 {61} 'Resist Fire',
 {62} 'Resist Frost',
 {63} 'Resist Disease',
 {64} 'Resist Magic',
 {65} 'Resist Normal Weapons',
 {66} 'Resist Paralysis',
 {67} 'Resist Poison',
 {68} 'Resist Shock',
 {69} 'Vampirism',
 {70} 'Darkness',
 {71} 'Resist Water Damage'
    ], [
      -1, 'None'
    ]);

  wbSkillEnum :=
    wbEnum([
      'Block',
      'Armorer',
      'Medium Armor',
      'Heavy Armor',
      'Blunt Weapon',
      'Long Blade',
      'Axe',
      'Spear',
      'Athletics',
      'Enchant',
      'Destruction',
      'Alteration',
      'Illusion',
      'Conjuration',
      'Mysticism',
      'Restoration',
      'Alchemy',
      'Unarmored',
      'Security',
      'Sneak',
      'Acrobatics',
      'Light Armor',
      'Short Blade',
      'Marksman',
      'Mercantile',
      'Speechcraft',
      'Hand-To-Hand'
    ], [
      -1, 'None'
    ]);


  wbEFID := wbInteger(EFID, 'Magic effect name', itU32, wbChar4, cpNormal, True);

  wbEFIDOBME := wbStringMgefCode(EFID, 'Magic Effect Code', 4, cpNormal, True);

  wbEFIT :=
    wbStructSK(EFIT, [4, 5], '', [
      wbInteger('Magic effect name', itU32, wbChar4),
      wbInteger('Magnitude', itU32),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('Type', itU32, wbEnum(['Self', 'Touch', 'Target'])),
      wbInteger('Actor Value', itS32, wbActorValueEnum)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);


  wbMagicSchoolEnum :=
    wbEnum([
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Mysticism',
      'Restoration'
    ]);

  wbSCIT :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbInteger('Visual effect name', itU32, wbChar4),
        wbInteger('Flags', itU8, wbFlags(['Hostile'])),
        wbByteArray('Unused', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);

  wbSCITOBME :=
    wbRStructSK([0], 'Script effect', [
      wbStructSK(SCIT, [0], 'Script effect data', [
        wbFormIDCk('Script effect', [NULL, SCPT]),
        wbInteger('Magic school', itU32, wbMagicSchoolEnum),
        wbStringMgefCode('Visual Effect Code', 4),
        wbInteger('Flags', itU8, wbFlags(['Hostile'])),
        wbByteArray('Unused', 3)
      ], cpNormal, True, nil, 1),
      wbFULLReq
    ], []);


  wbOBMEResolutionInfo := wbEnum(['None', 'FormID', 'Magic Effect Code', 'Actor Value']);

  wbEffects :=
    wbRUnion('Effects', [
      wbRStruct('Effects', [
        wbRStructs('Effects','Effect', [
          wbEFID,
          wbEFIT,
          wbSCIT
        ], [])
      ], []),
      wbRStruct('Effects', [
        wbRStructs('Effects','Effect', [
          wbStruct(EFME, 'Oblivion Magic Extender', [
            wbInteger('Record Version', itU8),
            wbStruct('OBME Version', [
              wbInteger('Beta', itU8),
              wbInteger('Minor', itU8),
              wbInteger('Major', itU8)
            ]),
            wbInteger('EFIT Param Info', itU8, wbOBMEResolutionInfo),
            wbInteger('EFIX Param Info', itU8, wbOBMEResolutionInfo),
            wbByteArray('Unused', $0A)
          ]),
          wbEFIDOBME,
          wbSCITOBME,
          wbString(EFII, 'Icon')
        ], []),
        wbEmpty(EFXX, 'Effects End Marker', cpNormal, True),
        wbFULLReq
      ], [])
    ], []);

  wbRecord(ALCH, 'Potion', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(TEXT, 'Inventory Icon'),
    wbString(FNAM, 'Potion Name'),
    wbStruct(ALDT, '', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('AutoCalc', itU32)
    ]),
    wbRarray('Enchantments',
      wbStruct(ENAM, 'Enchantment', [
        wbInteger('short EffectID', itU16),
        wbInteger('byte  SkillID', itS8),
        wbInteger('byte  AttributeID', itS8),
        wbInteger('long  Unknown1', itU32),
        wbInteger('long  Unknown2', itU32),
        wbInteger('long  Duration', itU32),
        wbInteger('long  Magnitude', itU32),
        wbInteger('long  Unknown4', itU32)
      ])
    ),
    wbString(SCRI, 'ScriptID')
  ]);

  {Done}
  wbRecord(APPA, 'Alchemical Apparatus', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(AADT, '', [
      wbInteger('Type', itU32, wbEnum([
        'Mortar and Pestle',
        'Alembic',
        'Calcinator',
        'Retort'
      ])),
      wbFloat('Quality'),
      wbFloat('Weight'),
      wbInteger('Value', itU32)
    ], cpNormal, True),
    wbString(ITEX, 'Icon Filename')
  ]);

  {Done}
  wbRecord(ARMO, 'Armor', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(AODT, 'Armour Data', [
      wbInteger('Armour', itU32, wbEnum([
        'Helmet',
        'Cuirass',
        'L. Pauldron',
        'R. Pauldron',
        'Greaves',
        'Boots',
        'L. Gauntlet',
        'R. Gauntlet',
        'Shield',
        'L. Bracer',
        'R. Bracer'
      ])),
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Health', itU32),
      wbInteger('EnchantPts', itU32),
      wbInteger('Armour', itU32)
    ]),
    wbString(ITEX, 'Icon Filename'),
    wbRArray('Armour Data',
      wbRStruct('Armour', [
        wbInteger(INDX, 'Body Part Index', itU8, wbEnum([
          'Head',
          'Hair',
          'Neck',
          'Cuirass',
          'Groin',
          'Skirt',
          'Right Hand',
          'Left Hand',
          'Right Wrist',
          'Left Wrist',
          'Shield',
          'Right Forearm',
          'Left Forearm',
          'Right Upper Arm',
          'Left Upper Arm',
          'Right Foot',
          'Left Foot',
          'Right Ankle',
          'Left Ankle',
          'Right Knee',
          'Left Knee',
          'Right Upper Leg',
          'Left Upper Leg',
          'Right Pauldron',
          'Left Pauldron',
          'Weapon',
          'Tail'
        ])),
        wbString(BNAM, 'Male Part Name'),
        wbString(CNAM, 'Female Body Part Name')
      ], [])
    ),
    wbString(ENAM, 'EnchantID')
  ]);

  {Done}
  wbRecord(BOOK, 'Book', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Book Name'),
    wbStruct(BKDT, 'Book Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      { Not sure this might be a Flag, it's 0 when it's not a scroll
      and 01 when it is a scroll }
      wbInteger('Scroll', itU32, wbEnum([
        'Not A Scroll',
        'Scroll'
      ])),
      wbInteger('SkillID', itS32, wbSkillEnum),
      wbInteger('EnchantPts', itU32)
    ]),
    wbString(SCRI, 'ScriptID'),
    wbString(ITEX, 'Icon Filename'),
    {quotes don't work with wbString in the book text}
    {x93Such as?x94 asked Bianki, smiling.<BR>}
    wbString(TEXT, 'Book Text'),
    wbString(ENAM, 'EnchantID')
  ]);

  wbSPLO := wbFormIDCk(SPLO, 'Spell', [SPEL, LVSP]);
  wbSPLOs := wbRArrayS('Spells', wbSPLO);

  {Done}
  wbRecord(BSGN, 'Birthsign', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Book Name'),
    wbString(TNAM, 'Texture filename'),
    wbString(DESC, 'Description'),
    wbRArray('Spells',
      wbStringForward(NPCS, 'SpellID', 32)
    )
  ]);

  wbRecord(CELL, 'Cell', [
    wbString(NAME, 'NameID'),
    wbStruct(DATA, 'Cell Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x01} 'Is Interior Cell',
        {0x02} 'Has water',
        {0x04} 'Illegal to Sleep here',
        {0x08} 'Unknown4',
        {0x10} 'Unknown5',
        {0x20} 'Unknown6',
        {0x40} 'Unknown7',
        {0x80} 'Behave like exterior'
      ])),
      wbInteger('GridX', itS32),
      wbInteger('GridY', itS32)
    ]),
    wbInteger(INTV, 'Number of uses', itU32),
    wbString(RGNN, 'Activator ID Name'),

    {Exterior Cell Sub-Records}
    wbStruct(NAM5, 'Map Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Unused', 1)
    ]),

    {Exterior Cell Sub-Records}
    wbFloat(WHGT, 'Water Height'),
    wbStruct(AMBI, 'Map Color', [
        wbInteger('AmbientColor', itU32),
        wbInteger('SunlightColor', itU32),
        wbInteger('FogColor', itU32),
        wbFloat('FogDensity')
    ]),

    {Referenced Object Data Grouping}
    wbRarray('Referenced Objects',
      wbRStruct('Objects', [
        wbInteger(FRMR, 'Object Index', itS32),
        wbString(NAME, 'NameID'),
        wbFloat(XSCL, 'Scale'),
        wbInteger(DELE, 'Object Index', itS32),
        wbStruct(DODT, 'Cell Travel Destination', [
          wbFloat('XPos'),
          wbFloat('YPos'),
          wbFloat('ZPos'),
          wbFloat('XRot'),
          wbFloat('YRot'),
          wbFloat('ZRot')
        ]),
        wbString(DNAM, 'Door exit name'),
        wbInteger(FLTV, 'Lock Level', itS32),
        wbString(KNAM, 'Door key'),
        wbString(TNAM, 'Trap name'),
        wbInteger(UNAM, 'Reference Blocked', itU8),
        wbString(ANAM, 'Owner ID string'),
        wbString(BNAM, 'Global variable'),
        wbByteArray(XCHG, 'Unknown'),
        wbInteger(NAM9, 'Reference Blocked', itU32),
        wbString(XSOL, 'Soul Extra Data'),
        wbStruct(DATA, 'Reference Position Data', [
          wbFloat('XRefPos'),
          wbFloat('YRefPos'),
          wbFloat('ZRefPos'),
          wbFloat('XRefRot'),
          wbFloat('YRefRot'),
          wbFloat('ZRefRot')
        ])
      ], [])
    ),

    {Referenced Object Count}
    wbInteger(NAM0, 'Number of objects in cell for current file', itS32)
  ], True);

  wbServiceFlags :=
    wbFlags([
      {0x00000001} 'Weapons',
      {0x00000002} 'Armor',
      {0x00000004} 'Clothing',
      {0x00000008} 'Books',
      {0x00000010} 'Ingredients',
      {0x00000020} 'Picks',
      {0x00000040} 'Probes',
      {0x00000080} 'Lights',
      {0x00000100} 'Apparatus',
      {0x00000200} 'Repair',
      {0x00000400} 'Miscellaneous',
      {0x00000800} 'Spells',
      {0x00001000} 'Magic Items',
      {0x00002000} 'Potions',
      {0x00004000} 'Training',
      {0x00008000} 'Spellmaking',
      {0x00010000} 'Enchanting',
      {0x00020000} 'Repair Item'
    ]);

  wbSpecializationEnum := wbEnum(['Combat', 'Magic', 'Stealth']);

  wbRecord(CLAS, 'Class', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Class name string'),
    wbStruct(CLDT, '', [
      wbInteger('AttributeID1', itS32),
      wbInteger('AttributeID1', its32),
      wbInteger('AttributeID1', its32, wbSpecializationEnum),
      wbInteger('MinorID1', its32),
      wbInteger('MajorID1', its32),
      wbInteger('MinorID2', its32),
      wbInteger('MajorID2', its32),
      wbInteger('MinorID3', its32),
      wbInteger('MajorID3', its32),
      wbInteger('MinorID4', its32),
      wbInteger('MajorID4', its32),
      wbInteger('MinorID5', its32),
      wbInteger('MajorID5', its32),
      wbInteger('Flags', its32, wbFlags(['Playable'])),
      wbInteger('AutoCalcFlags', its32, wbServiceFlags)
    ]),
    wbString(DESC, 'Description')
  ]);

  wbRecord(CLOT, 'Clothing', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Clothing Name'),
    wbStruct(CTDT, '', [
      wbInteger('Biped Flags', itU32, wbEnum([
        {0} 'Pants',
        {1} 'Shoes',
        {2} 'Shirt',
        {3} 'Belt',
        {4} 'Robe',
        {5} 'Right Glove',
        {6} 'Left Glove',
        {7} 'Skirt',
        {8} 'Ring',
        {9} 'Amulet'
      ])),
      wbFloat('Weight'),
      wbInteger('Value', itU16),
      wbInteger('EnchantPts', itU16)
    ], cpNormal, True),
    wbString(ITEX, 'Inventory Icon'),
    wbRArray('Clothing Worn',
      wbRStruct('Clothes', [
        wbInteger(INDX, 'Body Part Index', itU8),
        wbString(BNAM, 'Male Body Part Name'),
        wbString(CNAM, 'Female Body Part Name')
      ], [])
    ),
    wbString(ENAM, 'EnchantID'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbCNTO :=
    wbStructSK(CNTO, [0], 'Item', [
      wbFormIDCk('Item', [ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, LVLI, KEYM, CLOT, ALCH, APPA, LIGH]),
      wbInteger('Count', itS32)
    ]);

  wbCNTOs := wbRArrayS('Items', wbCNTO);

  wbRecord(CONT, 'Container', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Container Name'),
    wbStruct(CNDT, 'Container Data', [
      wbFloat('Weight')
    ]),
    wbStruct(FLAG, 'Container Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Organic',
        {0x00000002} 'Respawns, organic only',
        {0x00000004} 'Unknown3',
        {0x00000008} 'Default, unknown',
        {0x00000010} 'Unknown5',
        {0x00000020} 'Unknown6',
        {0x00000040} 'Unknown7',
        {0x00000080} 'Unknown8'
      ]))
    ]),
    wbRArray('Referenced Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Item Name', 32)
      ])
    )
  ]);

  wbCSDT := wbRStructSK([0], 'Sound Type', [
    wbInteger(CSDT, 'Type', itU32,wbEnum([
      {0x00} 'Left Foot',
      {0x01} 'Right Foot',
      {0x02} 'Left Back Foot',
      {0x03} 'Right Back Foot',
      {0x04} 'Idle',
      {0x05} 'Aware',
      {0x06} 'Attack',
      {0x07} 'Hit',
      {0x08} 'Death',
      {0x09} 'Weapon'
    ])),
    wbRArrayS('Sounds', wbRStructSK([0], 'Sound', [
      wbFormIDCk(CSDI, 'Sound', [SOUN], False, cpNormal, True),
      wbInteger(CSDC, 'Sound Chance', itU8, nil, cpNormal, True)
    ], []), cpNormal, True)
  ], []);

  wbCSDTs := wbRArrayS('Sound Types', wbCSDT);

  wbSoulGemEnum := wbEnum([
    {0} 'None',
    {1} 'Petty',
    {2} 'Lesser',
    {3} 'Common',
    {4} 'Greater',
    {5} 'Grand'
  ]);

  wbRecord(CREA, 'Creature', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(CNAM, 'Creatures Naming'),
    wbString(FNAM, 'Creature Name'),
    wbString(SCRI, 'ScriptID'),
    wbStruct(NPDT, 'Creature Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Creature',
        {1} 'Daedra',
        {2} 'Undead',
        {3} 'Humanoid'
      ])),
      wbInteger('Level', itU32),
      wbInteger('Strength', itU32),
      wbInteger('Intelligence', itU32),
      wbInteger('Willpower', itU32),
      wbInteger('Agility', itU32),
      wbInteger('Speed', itU32),
      wbInteger('Endurance', itU32),
      wbInteger('Personality', itU32),
      wbInteger('Luck', itU32),
      wbInteger('Health', itU32),
      wbInteger('SpellPts', itU32),
      wbInteger('Fatigue', itU32),
      wbInteger('Soul', itU32),
      wbInteger('Combat', itU32),
      wbInteger('Magic', itU32),
      wbInteger('Stealth', itU32),
      wbInteger('AttackMin1', itU32),
      wbInteger('AttackMax1', itU32),
      wbInteger('AttackMin2', itU32),
      wbInteger('AttackMax2', itU32),
      wbInteger('AttackMin3', itU32),
      wbInteger('AttackMax3', itU32),
      wbInteger('Gold', itU32)
    ]),
    wbStruct(FLAG, 'Creature Flags', [
      {All these flage need verified}
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Biped',
        {0x00000002} 'Respawn',
        {0x00000004} 'Weapon and shield',
        {0x00000008} 'None',
        {0x00000010} 'Swims',
        {0x00000020} 'Flies',
        {0x00000040} 'Walks',
        {0x00000080} 'Default',
        {0x00000100} 'Unknown9',
        {0x00000200} 'Essential',
        {0x00000400} 'Skeleton Blood',
        {0x00000800} 'Metal Blood',
        {0x00001000} 'Unknown13',
        {0x00002000} 'Unknown14',
        {0x00004000} 'Unknown15',
        {0x00008000} 'Unknown16'
      ]))
    ]),
    wbByteArray(XSCL, 'Unknown'),
    wbRArray('Creature Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Name', 32)
      ])
    ),
    wbRArray('Creature Spell',
      wbStruct(NPCS, 'Spell', [
        wbString('Name', 32)
      ])
    ),
    wbStruct(AIDT, 'AI data', [
      wbInteger('Hello', itU8),
      wbInteger('Unknown1', itU8),
      wbInteger('Fight', itU8),
      wbInteger('Flee', itU8),
      wbInteger('Alarm', itU8),
      wbInteger('Unknown2', itU8),
      wbInteger('Unknown3', itU8),
      wbInteger('Unknown4', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Weapon',
        {0x00000002} 'Armor',
        {0x00000004} 'Clothing',
        {0x00000008} 'Books',
        {0x00000010} 'Ingrediant',
        {0x00000020} 'Picks',
        {0x00000040} 'Probes',
        {0x00000080} 'Lights',
        {0x00000100} 'Apparatus',
        {0x00000200} 'Repair',
        {0x00000400} 'Misc',
        {0x00000800} 'Spells',
        {0x00001000} 'Magic Items',
        {0x00002000} 'Potions',
        {0x00004000} 'Training',
        {0x00008000} 'Spellmaking',
        {0x00010000} 'Enchanting',
        {0x00020000} 'Repair Item',
        {0x00040000} 'Unknown 19',
        {0x00080000} 'Unknown 20'
      ]))
    ]),
    wbStruct(AI_W, 'AI Wander', [
      wbInteger('Distance', itU16),
      wbInteger('Duration', itU8),
      wbInteger('TimeOfDay', itU8),
      wbInteger('Idle', itU8),
      wbByteArray('Unknown' , 1),
      wbByteArray('Unknown' , 4),
      wbByteArray('Unknown' , 4),
      wbByteArray('Unknown')
    ], cpNormal, False, nil, 3),
    wbStruct(AI_T, 'AI Travel', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Unknown', itU32)
    ]),
    wbStruct(AI_F, 'AI Follow', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_E, 'AI Escort', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_A, 'AI Activate', [
      wbString('ID', 32),
      wbInteger('Unknown', itU8)
    ]),
    wbFloat(XSCL, 'Scale')
  ]);

{ What follows in the ESP/ESM are all the INFO records that belong to the
	DIAL record.  One of the few cases where order is important
}

  wbRecord(DIAL, 'Dialog Topic', [
    wbString(NAME, 'NameID'),
    wbInteger(DATA, 'Type', itU8, wbEnum([
      {0} 'Regular Topic',
      {1} 'Voice?',
      {2} 'Greeting?',
      {3} 'Persuasion?',
      {4} 'Journal'
    ]))
  ]);

  wbRecord(INFO, 'Dialog response', [
    wbString(INAM, 'Info name string'),
    wbString(PNAM, 'Previous info ID'),
    wbString(NNAM, 'Next info ID'),
    wbStruct(DATA, 'Info data', [
      wbInteger('Unknown', itU8),
      wbInteger('Disposition', itU8),
      wbInteger('Rank', itU8),
      wbInteger('Gender', itU8, wbEnum([], [
       $00, 'Male',
       $01, 'Female',
       $FF, 'None'
      ])),
      wbInteger('PCRank', itU8),
      wbInteger('Unknown', itU8)
    ]),
    wbString(ONAM, 'Actor string'),
    wbString(RNAM, 'Race string'),
    wbString(CNAM, 'Class string'),
    wbString(FNAM, 'Faction string'),
    wbString(ANAM, 'Cell string'),
    wbString(DNAM, 'PC Faction string'),
    wbString(NAME, 'NameID'),
    wbString(SNAM, 'Sound filename'),
    wbByteArray(QSTN, 'Journal Name', 4),
    wbByteArray(QSTF, 'Journal Finished', 4),
    wbByteArray(QSTR, 'Journal Restart', 4),
    wbByteArray(SNAM, 'String for the function/variable', 4),
    wbByteArray(INTV, 'Unknown', 4),
    wbByteArray(FLTV, 'The function/variable result for the previous SCVR', 4),
    wbByteArray(BNAM, 'Result text (not compiled)', 4)
  ]);

  wbRecord(DOOR, 'Door', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Door Name'),
    wbString(SCRI, 'ScriptID'),
	  {Needs verification, may not have an SCIP record}
    wbStringScript(SCIP, 'Script Source', 0),
    wbString(SNAM, 'Sound name open'),
    wbString(ANAM, 'Sound name close')
  ]);

  wbBlendModeEnum := wbEnum([
    '',
    'Zero',
    'One',
    'Source Color',
    'Source Inverse Color',
    'Source Alpha',
    'Source Inverted Alpha',
    'Dest Alpha',
    'Dest Inverted Alpha',
    'Dest Color',
    'Dest Inverse Color',
    'Source Alpha SAT'
  ]);

  wbBlendOpEnum := wbEnum([
    '',
    'Add',
    'Subtract',
    'Reverse Subtract',
    'Minimum',
    'Maximum'
  ]);
  wbZTestFuncEnum := wbEnum([
    '',
    '',
    '',
    'Equal To',
    'Normal',
    'Greater Than',
    '',
    'Greater Than or Equal Than',
    'Always Show'
  ]);

  wbRecord(ENCH, 'Enchantment', [
    wbString(NAME, 'NameID'),
    wbStruct(ENDT, 'Enchant Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Cast Once',
        {1} 'Cast Strikes',
        {2} 'Cast when Used',
        {3} 'Constant Effect'
      ])),
      wbInteger('Enchant Cost', itU32),
      wbInteger('Charge Amount', itU32),
      wbInteger('Auto Calc', itU32)
    ]),
    wbStruct(ENAM, 'Enchant Data', [
      wbInteger('EffectID', itU16),
      wbInteger('SkillID', itU8),
      wbInteger('AttributeID', itU8),
      wbInteger('RangeType', itU32, wbEnum([
        {0} 'Scroll',
        {1} 'Staff',
        {2} 'Weapon',
        {3} 'Apparel'
      ])),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32),
      wbInteger('MagMin', itU32),
      wbInteger('MagMax', itU32)
    ])
  ]);

  wbXNAM :=
    wbStructSK(XNAM, [0], 'Relation', [
      wbFormIDCk('Faction', [FACT, RACE]),
      wbInteger('Modifier', itS32)
    ]);

  wbXNAMs := wbRArrayS('Relations', wbXNAM);

  wbRecord(FACT, 'Faction', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Class name string'),
    wbRArray('Ranks', wbStringForward(RNAM, 'Rank')),
    wbStruct(FADT, '', [
      wbInteger('AttributeID1', itS32),
      wbInteger('AttributeID1', its32),
      wbInteger('AttributeID1', its32, wbSpecializationEnum),
      wbInteger('MinorID1', its32),
      wbInteger('MajorID1', its32),
      wbInteger('MinorID2', its32),
      wbInteger('MajorID2', its32),
      wbInteger('MinorID3', its32),
      wbInteger('MajorID3', its32),
      wbInteger('MinorID4', its32),
      wbInteger('MajorID4', its32),
      wbInteger('MinorID5', its32),
      wbInteger('MajorID5', its32),
      wbInteger('Flags', its32, wbFlags(['Playable'])),
      wbInteger('AutoCalcFlags', its32, wbServiceFlags),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4)
    ]),
    wbRStructs('Relations','Relation', [
      wbString(ANAM, 'Faction name string'),
      wbInteger(INTV, 'Faction reaction value', its32)
    ], [])
  ]);

  wbRecord(GLOB, 'Global', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Type', 1),
    wbUnion(FLTV, 'Value', wbGLOBUnionDecider, [
      wbFloat('Comparison Value - Short'),
      wbFloat('Comparison Value - Long'),
      wbFloat('Comparison Value - Float')
    ])
  ]);

  wbRecord(GMST, 'Game Setting', [
    wbString(NAME, 'NameID'),
    wbRUnion('Value', [
      wbString(STRV, 'String Value'),
      wbInteger(INTV, 'Interer Value', its32),
      wbFloat(FLTV, 'Float Value')
    ], [])
  ]);


  wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder',
      'Steal Horse'
    ], [
      -1, 'None'
    ]);

  wbFormTypeEnum :=
    wbEnum([], [
      $03, 'Game Setting',
      $04, 'Global',
      $05, 'Class',
      $06, 'Faction',
      $07, 'Hair',
      $08, 'Eyes',
      $09, 'Race',
      $0A, 'Sound',
      $0B, 'Skill',
      $0C, 'Magic Effect',
      $0D, 'Script',
      $0E, 'Land Texture',
      $0F, 'Enchantment',
      $10, 'Spell',
      $11, 'BirthSign',
      $12, 'Activator',
      $13, 'Apparatus',
      $14, 'Armor',
      $15, 'Book',
      $16, 'Clothing',
      $17, 'Container',
      $18, 'Door',
      $19, 'Ingredient',
      $1A, 'Light',
      $1B, 'Misc',
      $1C, 'Static',
      $1D, 'Grass',
      $1E, 'Tree',
      $1F, 'Flora',
      $20, 'Furniture',
      $21, 'Weapon',
      $22, 'Ammi',
      $23, 'NPC',
      $24, 'Creature',
      $25, 'Leveled Creature',
      $26, 'Soul Gem',
      $27, 'Key',
      $28, 'Alchemy',
      $29, 'SubSpace',
      $2A, 'Sigil Stone',
      $2B, 'Leveled Item',
      $2D, 'Weather',
      $2E, 'Climate',
      $2F, 'Region',
      $30, 'Cell',
      $31, 'Placed Object',
      $32, 'Placed NPC',
      $33, 'Placed Creature',
      $34, 'Path Grid',
      $35, 'Worldspace',
      $36, 'Landscape',
      $38, 'Road',
      $39, 'Dialog Topic',
      $3A, 'Dialog Response',
      $3B, 'Quest',
      $3C, 'Idle Animation',
      $3D, 'Package',
      $3E, 'Combat Style',
      $3F, 'Load Screen',
      $40, 'Leveled Spell',
      $41, 'Animated Object',
      $42, 'Water',
      $43, 'Effect Shader'
  ]);

  wbSexEnum :=
    wbEnum(['Male','Female']);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCTDA :=
    wbRUnion('Condition', [
      wbStruct(CTDA, 'Condition', [
        wbInteger('Type', itU8, wbCtdaType),
        wbByteArray('Unused', 3),
        wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
        wbInteger('Function', itU32, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
        wbUnion('Parameter #1', wbCTDAParam1Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32),
          {04} wbInteger('Sex', itU32, wbSexEnum),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage (INVALID)', itS32),
          {10} wbFormIDCk('Object Reference', [PLYR, REFR, TRGT]),
          {12} wbFormIDCk('Inventory Object', [ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('Actor', [PLYR, TRGT]),
          {14} wbFormIDCk('Quest', [QUST]),
          {15} wbFormIDCk('Faction', [FACT]),
          {16} wbFormIDCk('Cell', [CELL]),
          {17} wbFormIDCk('Class', [CLAS]),
          {18} wbFormIDCk('Race', [RACE]),
          {19} wbFormIDCk('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('Global', [GLOB]),
          {21} wbFormIDCk('Weather', [WTHR]),
          {22} wbFormIDCk('Package', [PACK]),
          {23} wbFormIDCk('Owner', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('Furniture', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('Worldspace', [WRLD]),
          {29} wbFormIDCk('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbUnion('Parameter #2', wbCTDAParam2Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('Sex', itU32, wbSexEnum),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCk('Object Reference', [PLYR, REFR, TRGT]),
          {12} wbFormIDCk('Inventory Object', [ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('Actor', [PLYR, TRGT]),
          {14} wbFormIDCk('Quest', [QUST]),
          {15} wbFormIDCk('Faction', [FACT]),
          {16} wbFormIDCk('Cell', [CELL]),
          {17} wbFormIDCk('Class', [CLAS]),
          {18} wbFormIDCk('Race', [RACE]),
          {19} wbFormIDCk('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('Global', [GLOB]),
          {21} wbFormIDCk('Weather', [WTHR]),
          {22} wbFormIDCk('Package', [PACK]),
          {23} wbFormIDCk('Owner', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('Furniture', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('Worldspace', [WRLD]),
          {29} wbFormIDCk('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbInteger('Unused', itU32, nil, cpIgnore)
      ], cpNormal, False, nil, 6),
      wbStruct(CTDT, 'Condition (old format)', [
        wbInteger('Type', itU8, wbCtdaType),
        wbByteArray('Unused', 3),
        wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
        wbInteger('Function', itU32, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
        wbUnion('Parameter #1', wbCTDAParam1Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name (INVALID)', itS32),
          {04} wbInteger('Sex', itU32, wbSexEnum),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage (INVALID)', itS32),
          {10} wbFormIDCk('Object Reference', [PLYR, REFR, TRGT]),
          {12} wbFormIDCk('Inventory Object', [ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('Actor', [PLYR, TRGT]),
          {14} wbFormIDCk('Quest', [QUST]),
          {15} wbFormIDCk('Faction', [FACT]),
          {16} wbFormIDCk('Cell', [CELL]),
          {17} wbFormIDCk('Class', [CLAS]),
          {18} wbFormIDCk('Race', [RACE]),
          {19} wbFormIDCk('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('Global', [GLOB]),
          {21} wbFormIDCk('Weather', [WTHR]),
          {22} wbFormIDCk('Package', [PACK]),
          {23} wbFormIDCk('Owner', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('Furniture', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('Worldspace', [WRLD]),
          {29} wbFormIDCk('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbUnion('Parameter #2', wbCTDAParam2Decider, [
          {00} wbByteArray('Unknown', 4),
          {01} wbByteArray('None', 4, cpIgnore),
          {02} wbInteger('Integer', itS32),
          {03} wbInteger('Variable Name', itS32, wbCTDAParam2VariableNameToStr, wbCTDAParam2VariableNameToInt),
          {04} wbInteger('Sex', itU32, wbSexEnum),
//          {05} wbInteger('Actor Value', itS32, wbActorValueEnum),
          {06} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {07} wbInteger('Axis', itU32, wbAxisEnum),
          {08} wbInteger('Form Type', itU32, wbFormTypeEnum),
          {09} wbInteger('Quest Stage', itS32, wbCTDAParam2QuestStageToStr, wbCTDAParam2QuestStageToInt),
          {10} wbFormIDCk('Object Reference', [PLYR, REFR, TRGT]),
          {12} wbFormIDCk('Inventory Object', [ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH]),
          {13} wbFormIDCk('Actor', [PLYR, TRGT]),
          {14} wbFormIDCk('Quest', [QUST]),
          {15} wbFormIDCk('Faction', [FACT]),
          {16} wbFormIDCk('Cell', [CELL]),
          {17} wbFormIDCk('Class', [CLAS]),
          {18} wbFormIDCk('Race', [RACE]),
          {19} wbFormIDCk('Actor Base', [NPC_, CREA, ACTI]),
          {20} wbFormIDCk('Global', [GLOB]),
          {21} wbFormIDCk('Weather', [WTHR]),
          {22} wbFormIDCk('Package', [PACK]),
          {23} wbFormIDCk('Owner', [FACT, NPC_]),
          {24} wbFormIDCk('Birthsign', [BSGN]),
          {25} wbFormIDCk('Furniture', [FURN]),
          {26} wbFormIDCk('Magic Item', [SPEL]),
          {27} wbFormIDCk('Magic Effect', [MGEF]),
          {28} wbFormIDCk('Worldspace', [WRLD]),
          {29} wbFormIDCk('Referenceable Object', [CREA, NPC_, TREE, SBSP, LVLC, SOUN, ACTI, DOOR, FLOR, STAT, FURN, CONT, ARMO, MISC, WEAP, INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, GRAS])
        ]),
        wbEmpty('Unused', cpIgnore)
      ])
    ], []);

  wbCTDAs := wbRArray('Conditions', wbCTDA);

  wbSCHR :=
    wbRUnion('Basic Script Data', [
      wbStruct(SCHR, 'Basic Script Data', [
        wbByteArray('Unused', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('Type', itU32, wbEnum([
          'Object',
          'Quest'
        ], [
          $100, 'Magic Effect'
        ]))
      ]),
      wbStruct(SCHD, 'Basic Script Data', [
        wbByteArray('Unused', 4),
        wbInteger('RefCount', itU32),
        wbInteger('CompiledSize', itU32),
        wbInteger('VariableCount', itU32),
        wbInteger('Type', itU32, wbEnum([
          'Object',
          'Quest'
        ], [
          $100, 'Magic Effect'
        ]))
      ])
    ], []);

  wbSCROs :=
    wbRArray('References',
      wbRUnion('', [
        wbFormIDCk(SCRO, 'Global Reference',
          [ACTI, DOOR, FLOR, STAT, FURN, CREA, SPEL, NPC_, CONT, ARMO, MISC, WEAP,
           INGR, SLGM, SGST, BOOK, KEYM, CLOT, ALCH, APPA, LIGH, QUST, PLYR, PACK, LVLI,
           FACT, REFR, GLOB, DIAL, CELL, SOUN, MGEF, WTHR, CLAS, EFSH, RACE,
           LVLC, CSTY, WRLD, SCPT, BSGN, TREE, NULL]),
        wbInteger(SCRV, 'Local Variable', itU32)
      ], [])
    );

  wbResultScript := wbRStruct('Result Script', [
    wbSCHR,
    wbByteArray(SCDA, 'Compiled result script'),
    wbStringScript(SCTX, 'Result script source'),
    wbSCROs
  ], []);
{
  wbResultScriptOld := wbRStruct('Result Script (Old Format?)', [
    wbByteArray(SCHD, 'Unknown (Script Header?)'),
    wbByteArray(SCDA, 'Compiled result script'),
    wbStringScript(SCTX, 'Result script source'),
    wbSCROs
  ], []);
}

  wbRecord(INGR, 'Ingredient', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbStruct(IRDT, 'Ingrediant Data', [
      wbFloat('Weight'),
      wbInteger('Value', itS32),
      wbInteger('EffectID', itS32),
      wbInteger('SkillID', itS32),
      wbInteger('AttributeID', itS32)
    ]),
    wbString(ITEX, 'Inventory icon'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbQuadrantEnum := wbEnum([
    {0} 'Bottom Left',
    {1} 'Bottom Right',
    {2} 'Top Left',
    {3} 'Top Right'
  ]);

  if wbSimpleRecords then begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertext Height Map'),
      wbByteArray(VCLR, 'Vertex Colours'),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Alpha Layer', [
          wbByteArray(VTXT, 'Alpha Layer Data')
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape', [
      wbByteArray(DATA, 'Unknown'),
//      wbStruct(DATA, '', [
//        wbInteger('Flags', itU8, wbFlags([])),
//        wbByteArray('Unknown')
//      ]),
      wbArray(VNML, 'Vertex Normals', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),
      wbStruct(VHGT, 'Vertext Height Map', [
        wbFloat('Offset'),
        wbArray('Rows', wbStruct('Row', [
          wbArray('Columns', wbInteger('Column', itU8), 33)
        ]), 33),
        wbByteArray('Unused', 3)
      ]),
      wbArray(VCLR, 'Vertex Colours', wbStruct('Row', [
        wbArray('Columns', wbStruct('Column', [
          wbInteger('X', itU8),
          wbInteger('Y', itU8),
          wbInteger('Z', itU8)
        ]), 33)
      ]), 33),

      wbRArrayS('Layers', wbRUnion('Layer', [
        wbRStructSK([0],'Alpha Layer', [
          wbArrayS(VTXT, 'Alpha Layer Data', wbStructSK([0], 'Cell', [
            wbInteger('Position', itU16, wbAtxtPosition),
            wbByteArray('Unused', 2),
            wbFloat('Opacity')
          ]))
        ], [])
      ], [])),

      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL]))
    ]);

  end;

  wbRecord(LIGH, 'Light', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Light Name'),
    wbString(ITEX, 'Inventory icon'),
    wbStruct(LHDT, 'Light Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Time', itS32),
      wbInteger('Radius', itU32),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbInteger('Unused', itU8)
      ]),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Dynamic',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Negative',
        {0x00000008} 'Flicker',
        {0x00000010} 'Fire',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Flicker Slow',
        {0x00000080} 'Pulse',
        {0x00000100} 'Pulse Slow'
      ]))
    ]),
    wbString(SCRI, 'ScriptID'),
    {Need to verify if it has an SCPT record}
    wbStringScript(SCPT, 'Script Source', 0),
    wbString(SNAM, 'Sound name')
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbString(NAME, 'NameID'),
    wbInteger(INTV, 'Landscape ID Number', itU32),
    wbString(DATA, 'FileName')
  ]);

  wbRecord(LEVC, 'Leveled Creature', [
    wbString(NAME, 'NameID'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ])),
    wbInteger(NNAM, 'Chance none', itU8),
    wbInteger(INDX, 'Count', itS32),
    wbRArray('Leveled Creature Entries',
      wbRStruct('Leveled Creature', [
        wbString(CNAM, 'Creature Name'),
        wbInteger(INTV, 'Creature Level', itS16)
      ], [])
    )
  ]);

  wbRecord(LEVI, 'Leveled Item', [
    wbString(NAME, 'NameID'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count'
    ])),
    wbInteger(NNAM, 'Chance none', itU8),
    wbInteger(INDX, 'Count', itS32),
    wbRArray('Leveled List Entries',
      wbRStruct('Leveled Item', [
        wbString(INAM, 'Item Name'),
        wbInteger(INTV, 'Item Level', itS16)
      ], [])
    )
  ]);

  wbRecord(MGEF, 'Magic Effect', [
    wbInteger(INDX, 'Magic Effect ID', itU32),
    wbStruct(MEDT, 'Effect Data', [
      wbInteger('SpellSchool', itU32, wbMagicSchoolEnum),
      wbFloat('Base cost'),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown1',
        {0x00000002} 'Unknown2',
        {0x00000004} 'Unknown3',
        {0x00000008} 'Unknown4',
        {0x00000010} 'Unknown5',
        {0x00000020} 'Unknown6',
        {0x00000040} 'Unknown7',
        {0x00000080} 'Unknown8',
        {0x00000100} 'Unknown9',
        {0x00000200} 'Spellmaking',
        {0x00000400} 'Enchanting',
        {0x00000800} 'Negative'
      ])),
      wbStruct('Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8),
        wbByteArray('Uknown', 1)
      ]),
      wbFloat('Speed Multiplier'),
      wbFloat('Size Multiplier'),
      wbFloat('SizeCap'),
      wbByteArray('Unknown', 4),
      wbByteArray('Unknown', 4)
    ]),
    wbString(ITEX, 'Effect Icon string'),
    wbString(PTEX, 'Particle texture string'),
    wbString(CVFX, 'Casting visual string'),
    wbString(BVFX, 'Bolt visual string'),
    wbString(HVFX, 'Hit visual string'),
    wbString(AVFX, 'Area visual string'),
    wbString(BSND, 'Bolt sound'),
    wbString(CSND, 'Cast sound'),
    wbString(HSND, 'Hit sound'),
    wbString(ASND, 'Area sound'),
    wbString(DESC, 'Description')
  ]);

  wbRecord(MISC, 'Misc. Item', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(MCDT, '', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Unknown', itS32)
    ]),
    wbString(SCRI, 'Script ID'),
    wbString(ITEX, 'Iventory Icon Filename'),
    wbString(ENAM, 'EnchantID')
  ]);

  wbFaceGen := wbRStruct('FaceGen Data', [
    wbByteArray(FGGS, 'FaceGen Geometry-Symmetric', 0, cpNormal, True),
    wbByteArray(FGGA, 'FaceGen Geometry-Asymmetric', 0, cpNormal, True),
    wbByteArray(FGTS, 'FaceGen Texture-Symmetric', 0, cpNormal, True)
  ], [], cpNormal, True);

  wbRecord(NPC_, 'Non-Player Character', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'NPC Name'),
    wbString(RNAM, 'Race Name', 0, cpNormal, True),
    wbString(CNAM, 'Class name'),
    wbString(ANAM, 'Faction name', 0, cpNormal, True),
    wbString(BNAM, 'Head model', 0, cpNormal, True),
    wbString(KNAM, 'Hair model', 0, cpNormal, True),
    wbString(SCRI, 'ScriptID'),
    wbStruct(NPDT, 'NPC Data', [
      wbUnion('Data', wbNPCDataDecider, [
        wbStruct('Data 52', [
          wbInteger('Level', itU16),
          wbInteger('Strength', itU8),
          wbInteger('Intelligence', itU8),
          wbInteger('Willpower', itU8),
          wbInteger('Agility', itU8),
          wbInteger('Speed', itU8),
          wbInteger('Endurance', itU8),
          wbInteger('Personality', itU8),
          wbInteger('Luck', itU8),
          wbArray('Skills', wbInteger('Value', itU8), 27),
          wbInteger('Reputation', itU8),
          wbInteger('Health', itU16),
          wbInteger('SpellPts', itU16),
          wbInteger('Fatigue', itU16),
          wbInteger('Disposition', itU8),
          wbInteger('FactionID', itU8),
          wbInteger('Rank', itU8),
          wbInteger('Unknown1', itU8),
          wbInteger('Gold', itU32)
        ]),
        wbStruct('Data 12', [
          wbInteger('Level', itU16),
          wbInteger('Disposition', itU8),
          wbInteger('FactionID', itU8),
          wbInteger('Rank', itU8),
          wbInteger('Unknown1', itU8),
          wbInteger('Unknown2', itU8),
          wbInteger('Unknown3', itU8),
          wbInteger('Gold', itU32)
        ])
      ])
    ]),
    wbStruct(FLAG, 'NPC Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x000001} 'Female',
        {0x000002} 'Essential',
        {0x000004} 'Respawn',
        {0x000008} 'None',
        {0x000010} 'Autocalc',
        {0x000020} 'Blood Skel',
        {0x000040} 'Blood Metal'
      ]))
    ]),
    wbRArray('NPC Items',
      wbStruct(NPCO, 'Item', [
        wbInteger('Count', itU32),
        wbString('Name', 32)
      ])
    ),
    wbRArray('NPC Spell',
      wbStruct(NPCS, 'Spell', [
        wbString('Name', 32)
      ])
    ),
    wbStruct(AIDT, 'AI data', [
      wbInteger('Hello', itU8),
      wbInteger('Unknown1', itU8),
      wbInteger('Fight', itU8),
      wbInteger('Flee)', itU8),
      wbInteger('Alarm', itU8),
      wbInteger('Unknown2', itU8),
      wbInteger('Unknown3', itU8),
      wbInteger('Unknown4', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Weapon',
        {0x00000002} 'Armor',
        {0x00000004} 'Clothing',
        {0x00000008} 'Books',
        {0x00000010} 'Ingrediant',
        {0x00000020} 'Picks',
        {0x00000040} 'Probes',
        {0x00000080} 'Lights',
        {0x00000100} 'Apparatus',
        {0x00000200} 'Repair',
        {0x00000400} 'Misc',
        {0x00000800} 'Spells',
        {0x00001000} 'Magic Items',
        {0x00002000} 'Potions',
        {0x00004000} 'Training',
        {0x00008000} 'Spellmaking',
        {0x00010000} 'Enchanting',
        {0x00020000} 'Repair Item',
        {0x00040000} 'Unknown 19',
        {0x00080000} 'Unknown 20'
      ]))
    ]),
    wbStruct(AI_W, 'AI Wander', [
      wbInteger('Distance', itU16),
      wbInteger('Duration', itU16),
      wbInteger('TimeOfDay', itU8),
      wbInteger('Idle', itU8),
      wbInteger('Unknown', itU8)
    ]),
    wbStruct(AI_T, 'AI Travel', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Unknown', itU32)
    ]),
    wbStruct(AI_F, 'AI Follow', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbStruct(AI_E, 'AI Escort', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z'),
      wbInteger('Duration', itU16),
      wbString('ID', 32),
      wbInteger('Unknown', itU16)
    ]),
    wbString(CNDT, 'Cell escort/follow to'),
    wbStruct(AI_A, 'AI Activate', [
      wbString('ID', 32),
      wbInteger('Unknown', itU8)
    ]),
    wbStruct(DODT, 'Cell Travel Destination', [
      wbFloat('XPos'),
      wbFloat('YPos'),
      wbFloat('ZPos'),
      wbFloat('XRot'),
      wbFloat('YRot'),
      wbFloat('ZRot')
    ]),
    wbString(DNAM, 'Cell escort/follow to'),
    wbFloat(XSCL, 'Scale')
  ]);

  wbPKDTFlags := wbFlags([
          {0x00000001} 'Offers services',
          {0x00000002} 'Must reach location',
          {0x00000004} 'Must complete',
          {0x00000008} 'Lock doors at package start',
          {0x00000010} 'Lock doors at package end',
          {0x00000020} 'Lock doors at location',
          {0x00000040} 'Unlock doors at package start',
          {0x00000080} 'Unlock doors at package end',
          {0x00000100} 'Unlock doors at location',
          {0x00000200} 'Continue if PC near',
          {0x00000400} 'Once per day',
          {0x00000800} 'Unused',
          {0x00001000} 'Skip fallout behavior',
          {0x00002000} 'Always run',
          {0x00004000} '',
          {0x00008000} '',
          {0x00010000} '',
          {0x00020000} 'Always sneak',
          {0x00040000} 'Allow swimming',
          {0x00080000} 'Allow falls',
          {0x00100000} 'Armor unequipped',
          {0x00200000} 'Weapons unequipped',
          {0x00400000} 'Defensive combat',
          {0x00800000} 'Use horse',
          {0x01000000} 'No idle anims',
          {0x02000000} '',
          {0x04000000} '',
          {0x08000000} '',
          {0x10000000} '',
          {0x20000000} '',
          {0x40000000} '',
          {0x80000000} ''
        ]);

  wbPKDTType := wbEnum([
           {0} 'Find',
           {1} 'Follow',
           {2} 'Escort',
           {3} 'Eat',
           {4} 'Sleep',
           {5} 'Wander',
           {6} 'Travel',
           {7} 'Accompany',
           {8} 'Use item at',
           {9} 'Ambush',
          {10} 'Flee not combat',
          {11} 'Cast magic'
        ]);

  {16 bytes }
  wbPGRP :=
    wbArray(PGRP, 'Points', wbStruct('Point', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z (Even = Red/Orange, Odd = Blue)'),
      wbInteger('Connections', itU8{, wbPGRPConnectionsCallback}),
      wbByteArray('Unused', 3)
    ]));

      {The Connection Count in the PGRP record specifies how many entries in this
       array belong to each point. If the first 4 points in the PGRP array have
       Connection Counts 2, 5, 2, 4 then the first 2 entries are the connections
       of point 0, then next 5 are the connections of point 1, the next 2 of point 2,
       the next 4 of point 3 and so on..., this can currently not be represented
       declaratively }

  {8 bytes or 4 bytes , anything else does not make it come out even at the end
  end of the array }
  wbPGRC :=
    wbArray(PGRP, 'Points', wbStruct('Point', [
      wbInteger('Unknown', itS32),
      wbInteger('Unknown', itS32)
    ]));

  wbRecord(PGRD, 'Path Grid', [
    wbStruct(DATA, 'Path Grid Data', [
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16)
    ], cpNormal, True),
    wbString(NAME, 'NameID'),
    wbByteArray(PGAG, 'Unknown'),
    { 1680, 1872, 2800  }
    {wbPGRP,}
    { 1656, 1760, 4016 }
    {wbPGRC,}
    {wbInteger(PGRP, 'Unknown', itU16),}
    {wbInteger(PGRC, 'Unknown', itU16),}
    wbByteArray(PGRP, 'Points', 0),
    wbByteArray(PGRC, 'Grids', 0)
{    wbInteger(DATA, 'Point Count', itU16, nil, cpNormal, True),
    wbPGRP,
    wbByteArray(PGAG, 'Unknown'),
    wbArray(PGRR, 'Point-to-Point Connections',
      wbArrayS('Point', wbInteger('Point', itU16), wbCalcPGRRSize, cpNormal, False, wbPGRRPointAfterLoad)
    ),
    wbArrayS(PGRI, 'Inter-Cell Connections', wbStructSK([0,2,3,4], 'Inter-Cell Connection', [
      wbInteger('Point', itU16),
      wbByteArray('Unused', 2),
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]), 0, cpNormal, False, wbPGRIPointerAfterLoad),
    wbRArrayS('Point-to-Reference Mappings',
      wbStructSK(PGRL, [0], 'Point-to-Reference Mapping', [
        wbFormIDCk('Reference', [REFR]),
        wbArrayS('Points', wbInteger('Point', itU32))
      ])
    )
}
  ], False, nil, cpNormal, False, wbPGRDAfterLoad);

  wbBodyDataIndex :=
    wbInteger(INDX, 'Index', itU32, wbEnum([
      'Upper Body',
      'Lower Body',
      'Hand',
      'Foot',
      'Tail'
    ]));

  {Done}
  wbRecord(BODY, 'Body Parts', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Racial Skin Type'),
    wbStruct(BYDT, 'Body Part Data', [
      wbInteger('Part', itU8, wbEnum([
        'Head',
        'Hair',
        'Neck',
        'Chest',
        'Groin',
        'Hand',
        'Wrist',
        'Forearm',
        'Upperarm',
        'Foot',
        'Ankle',
        'Knee',
        'Upperleg',
        'Clavicle',
        'Tail'
      ])),
      wbInteger('Skin Type', itU8, wbEnum([
        'None',
        'Vampire'
      ])),
      wbInteger('Flags', itU8, wbFlags([
        'Female',
        'Not Playable'
      ])),
      wbInteger('Body Part Type', itU8, wbEnum([
        'Skin',
        'Clothing',
        'Armor'
      ]))
    ])
  ]);

  wbRecord(RACE, 'Race', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbSPLOs,
    wbXNAMs,
    wbStruct(DATA, '', [
      wbArrayS('Skill Boosts', wbStructSK([0], 'Skill Boost', [
        wbInteger('Skill', itS8, wbActorValueEnum),
        wbInteger('Boost', itS8)
      ]), 7),
      wbByteArray('Unused', 2),
      wbFloat('Male Height'),
      wbFloat('Female Height'),
      wbFloat('Male Weight'),
      wbFloat('Female Weight'),
      wbInteger('Flags', itU32, wbFlags([
        'Playable'
      ]))
    ], cpNormal, True),
    wbStruct(VNAM, 'Voice', [
      wbFormIDCk('Male', [RACE, NULL]),
      wbFormIDCk('Female', [RACE, NULL])
    ]),
    wbStruct(DNAM, 'Default Hair', [
      wbFormIDCk('Male', [HAIR]),
      wbFormIDCk('Female', [HAIR])
    ]),
    wbInteger(CNAM, 'Default Hair Color', itU8, nil, cpNormal, True),
    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),
    wbStruct(RADT, 'Base Attributes', [
      wbStruct('Male', [
        wbInteger('Strength', itU8),
        wbInteger('Intelligence', itU8),
        wbInteger('Willpower', itU8),
        wbInteger('Agility', itU8),
        wbInteger('Speed', itU8),
        wbInteger('Endurance', itU8),
        wbInteger('Personality', itU8),
        wbInteger('Luck', itU8)
      ]),
      wbStruct('Female', [
        wbInteger('Strength', itU8),
        wbInteger('Intelligence', itU8),
        wbInteger('Willpower', itU8),
        wbInteger('Agility', itU8),
        wbInteger('Speed', itU8),
        wbInteger('Endurance', itU8),
        wbInteger('Personality', itU8),
        wbInteger('Luck', itU8)
      ])
    ]),
    wbRStruct('Face Data', [
      wbEmpty(NAM0, 'Face Data Marker'),
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbInteger(INDX, 'Index', itU32, wbEnum([
          'Head',
          'Ear (Male)',
          'Ear (Female)',
          'Mouth',
          'Teeth (Lower)',
          'Teeth (Upper)',
          'Tongue',
          'Eye (Left)',
          'Eye (Right)'
        ])),
        wbString(MODL, 'Model Filename'),
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbEmpty(NAM1, 'Body Data Marker', cpNormal, True),
    wbRStruct('Male Body Data', [
      wbEmpty(MNAM, 'Male Body Data Marker'),
      wbString(MODL, 'Model Filename'),
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbRStruct('Female Body Data', [
      wbEmpty(FNAM, 'Female Body Data Marker'),
      wbString(MODL, 'Model Filename'),
      wbRArrayS('Parts', wbRStructSK([0], 'Part', [
        wbBodyDataIndex,
        wbICON
      ], []))
    ], [], cpNormal, True),
    wbArrayS(HNAM, 'Hairs', wbFormIDCk('Hair', [HAIR]), 0, cpNormal, True),
    wbArrayS(ENAM, 'Eyes', wbFormIDCk('Eye', [EYES]),  0,  cpNormal, True),
    wbFaceGen,
    wbByteArray(SNAM, 'Unknown', 2, cpNormal, True)
  ], True);

  wbRecord(REGN, 'Region', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Sound Filename'),
    wbStruct(WEAT, 'Weather Type', [
      wbInteger('Clear', itU8),
      wbInteger('Cloudy', itU8),
      wbInteger('Foggy', itU8),
      wbInteger('Overcast', itU8),
      wbInteger('Rain', itU8),
      wbInteger('Thunder', itU8),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbByteArray('Unknonw', 1),
      wbByteArray('Unknonw', 1)
    ]),
    wbString(BNAM, 'Sleep creature string'),
    wbStruct(CNAM, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unused', 1)
    ]),
    wbRArray('Sound Records',
      wbStruct(SNAM, 'Sound Record', [
        wbstring('SoundName', 16),
        wbStruct('Sound Info 1', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 2', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 3', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbStruct('Sound Info 4', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8)
        ]),
        wbInteger('Chance', itU8)
      ])
    )
  ]);

  wbRecord(REPA, 'Repair Items', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbStruct(RIDT, 'Weather Type', [
      wbInteger('Clear', itU8),
      wbInteger('Cloudy', itU8),
      wbInteger('Foggy', itU8),
      wbInteger('Overcast', itU8),
      wbInteger('Rain', itU8),
      wbInteger('Thunder', itU8),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbByteArray('Unknonw', 1),
      wbByteArray('Unknonw', 1)
    ]),
    wbString(ITEX, 'Book Name'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbRecord(LOCK, 'Lockpicking Items', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbStruct(LKDT, 'Weather Type', [
      wbInteger('Clear', itU8),
      wbInteger('Cloudy', itU8),
      wbInteger('Foggy', itU8),
      wbInteger('Overcast', itU8),
      wbInteger('Rain', itU8),
      wbInteger('Thunder', itU8),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbByteArray('Unknonw', 1),
      wbByteArray('Unknonw', 1)
    ]),
    wbString(ITEX, 'Book Name'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbRecord(PROB, 'Probe Items', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Activator Name'),
    wbStruct(PBDT, 'Weather Type', [
      wbInteger('Clear', itU8),
      wbInteger('Cloudy', itU8),
      wbInteger('Foggy', itU8),
      wbInteger('Overcast', itU8),
      wbInteger('Rain', itU8),
      wbInteger('Thunder', itU8),
      wbInteger('Ash', itU8),
      wbInteger('Blight', itU8),
      wbByteArray('Unknonw', 1),
      wbByteArray('Unknonw', 1)
    ]),
    wbString(ITEX, 'Book Name'),
    wbString(SCRI, 'ScriptID')
  ]);


  wbSLSD := wbStructSK(SLSD, [0], 'Local Variable Data', [
    wbInteger('Index', itU32),
    wbByteArray('Unused', 12),
    wbInteger('Flags', itU8, wbFlags(['IsLongOrShort']), cpCritical),
    wbByteArray('Unused')
  ]);

  wbRecord(SCPT, 'Script', [
    wbStruct(SCHD, 'Script Header', [
      wbString('Name', 32),
      wbInteger('NumShorts', itS32),
      wbInteger('NumLongs', itS32),
      wbInteger('NumFloats', itS32),
      wbInteger('ScriptDataSize', itS32),
      wbInteger('LocalVarSize', itS32)
    ]),
    wbArray(SCVR, 'Script Variables', wbString('Script Variables')),
    wbByteArray(SCDT, 'Compiled Script'),
    wbStringScript(SCTX, 'Script Source', 0, cpNormal, True)
  ]);


  wbAttributeEnum :=
    wbEnum([
      'Strength',
      'Intelligence',
      'Willpower',
      'Agility',
      'Speed',
      'Endurance',
      'Personality',
      'Luck'
      ]);

  wbRecord(SKIL, 'Skill', [
    wbInteger(INDX, 'Skill', itS32, wbSkillEnum),
    wbStruct(SKDT, 'Skill Data', [
      wbInteger('Attribute', itS32, wbAttributeEnum),
      wbInteger('Type', itU32, wbEnum([
       {0}'Combat',
       {1}'Magic',
       {2}'Stealth'
      ])),
      wbFloat('Action One'),
      wbFloat('Action Two'),
      wbFloat('Action Three'),
      wbFloat('Action Four')
    ]),
    wbString(DESC, 'Description')
  ]);

  wbRecord(SNDG, 'Sound Generator', [
    wbString(NAME, 'NameID'),
    wbStruct(DATA, 'Sound Data', [
      wbInteger('Type', itU32, wbEnum([
       {0}'Left Foot',
       {0}'Right Foot',
       {0}'Swim Left',
       {0}'Swim Right',
       {0}'Moan',
       {0}'Roar',
       {0}'Scream',
       {0}'Land'
      ]))
    ]),
    wbString(SNAM, 'Sound ID string'),
    wbString(CNAM, 'Creature name')
  ]);

  wbRecord(SOUN, 'Sound', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Sound Filename'),
    wbStruct(DATA, 'Sound Data', [
      wbInteger('Volume', itU8),
      wbInteger('MinRange', itS8),
      wbInteger('MaxRange', itS8)
    ])
  ]);

  wbRecord(SPEL, 'Spell', [
    wbString(NAME, 'NameID'),
    wbString(FNAM, 'Spell Name'),
    wbStruct(SPDT, 'Spell Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Spell',
        {1} 'Ability',
        {2} 'Blight',
        {3} 'Disease',
        {4} 'Curse',
        {5} 'Power'
      ])),
      wbInteger('SpellCost', itU32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'AutoCalc',
        {0x00000002} 'PC Start',
        {0x00000004} 'Always Succeeds'
      ]))
    ]),
    wbRArray('Enchantment Data',
      wbByteArray(ENAM, 'Unknown', 0)
    )
  ]);

  wbRecord(SSCR, 'Start Script', [
    wbString(NAME, 'NameID'),
    wbString(DATA, 'Digits')
  ]);

  {Done}
  wbRecord(STAT, 'Static', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename')
  ]);

  wbRecord(TES3, 'Main File Header', [
    wbRStruct('Header Info', [
      wbStruct(HEDR, 'Header', [
        wbFloat('Version'),
        wbRecordFlags,
        wbString('Author', 32),
        wbString('Description', 256),
        wbInteger('Number of Records', itU32)
      ], cpNormal, True),
      wbRArray('Master Files', wbRStruct('Master File', [
        wbString(MAST, 'Filename', 0, cpNormal, True),
        wbInteger(DATA, 'Master Size', itU64)
      ], []))
    ], [])
  ], False, nil, cpNormal, True);

  wbRecord(WEAP, 'Weapon', [
    wbString(NAME, 'NameID'),
    wbString(MODL, 'Model Filename'),
    wbString(FNAM, 'Item Name'),
    wbStruct(WPDT, 'Weapon Data', [
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Type', itU16, wbEnum([
        {0} 'ShortBladeOneHand',
        {1} 'LongBladeOneHand',
        {2} 'LongBladeTwoClose',
        {3} 'BluntOneHand',
        {4} 'BluntTwoClose',
        {5} 'BluntTwoWide',
        {6} 'SpearTwoWide',
        {7} 'AxeOneHand',
        {8} 'AxeTwoHand',
        {9} 'MarksmanBow',
        {10} 'MarksmanCrossbow',
        {11} 'MarksmanThrown',
        {12} 'Arrow',
        {13} 'Bolt'
      ])),
      wbInteger('Health', itU16),
      wbFloat('Speed'),
      wbFloat('Reach'),
      wbInteger('EnchantPts', itU16),
      wbInteger('ChopMin', itU8),
      wbInteger('ChopMax', itU8),
      wbInteger('SlashMin', itU8),
      wbInteger('SlashMax', itU8),
      wbInteger('ThrustMin', itU8),
      wbInteger('ThrustMax', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown1',
        {0x00000002} 'Ignore Normal Weapon Resistance'
      ]))
    ]),
    wbString(ITEX, 'Iventory Icon Filename'),
    wbString(ENAM, 'Enchantment ID string'),
    wbString(SCRI, 'ScriptID')
  ]);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SKIL);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(SCPT);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(SSCR);  // To be confirmed
  wbAddGroupOrder(BSGN);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(CREA);
  wbAddGroupOrder(BODY);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(CLOT);
  wbAddGroupOrder(REPA);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(APPA);
  wbAddGroupOrder(LOCK);
  wbAddGroupOrder(PROB);
  wbAddGroupOrder(INGR);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(LEVI);
  wbAddGroupOrder(LEVC);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(LAND);
  wbAddGroupOrder(PGRD);
  wbAddGroupOrder(SNDG);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(INFO);
end;

initialization
end.
