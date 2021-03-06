//             ____                 __    _ __
//            /  _/________  ____  / /   (_) /_  _________ ________  __
//            / // ___/ __ \/ __ \/ /   / / __ \/ ___/ __ `/ ___/ / / /
//          _/ // /__/ /_/ / / / / /___/ / /_/ / /  / /_/ / /  / /_/ /
//         /___/\___/\____/_/ /_/_____/_/_.___/_/   \__,_/_/   \__, /
//                                                            /____/

(*******************************************************************************
* IconTools 1.5                                                                *
*                                                                              *
* This file is part of the IconTools class library                             *
*                                                                              *
********************************************************************************
*                                                                              *
* If you find bugs, has ideas for missing featurs, feel free to contact me     *
*                           jpstotz@gmx.de                                     *
*                                                                              *
* The latest version of TShelltree can be found at:                            *
*     http://members.tripod.com/~JPStotz/IconTools/IconTools.html              *
********************************************************************************
* Date last modified:   May 12, 1999                                           *
*******************************************************************************)

unit IconLibrary;

interface

{.$Define Overseer}

{$IfDEF Overseer}
  {$DEFINE Writer16}
{$EndIf}

uses
{$IfDEF Overseer}
  udbg,
{$EndIf}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IconTools, IconTypes, ShellAPI;

(********************************************************************)
(**                      TIconLibrary declaration                  **)
(********************************************************************)

type
  TIconLibrary = class
  private
    FFilename : String;
  protected
    FIcons : TStringList;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure LoadFromFile(Filename : String);
    procedure SaveToFile(Filename : String);

    property Icons : TStringList read FIcons;
    property Filename : String read FFilename;
  end;

(********************************************************************)
(**                TICLReader abstract declaration                 **)
(********************************************************************)

type
  TICLReader = class
  private
  protected
    FFilename : String;
    FIcons : TStringList;
  public
    constructor Create(Filename : String); virtual;
    destructor Destroy; override;
    function Execute : Boolean; virtual; abstract;
    property Icons : TStringList read FIcons;
  end;

(********************************************************************)
(**                    T32BitReader declaration                    **)
(********************************************************************)

type
  T32BitReader = class(TICLReader)
  private
  protected
    Instance : THandle;
    FreeLib  : Boolean;
    procedure IconResFound(ResName : PChar);
  public
    constructor Create(Filename : String); override;
    function Execute : Boolean; override;
    destructor Destroy; override;
  end;

(********************************************************************)
(**                     TICL32Icon declaration                     **)
(********************************************************************)

type
  TICL32Icon = class(TResourceIcon)
  private

  protected
    FIconData : TMemoryStream;
    procedure BufferIconData;
    procedure LoadIconResInfos(Stream : TStream;Var Valid : Boolean;Var Count : Word); override;
    function  GetHIcon(Index : Word) : HIcon; override;
  public
    procedure WriteIconDataToStream(Stream : TStream;Index : Integer); override;
    destructor Destroy; override;
  end;

(********************************************************************)
(**                    T16BitReader declaration                    **)
(********************************************************************)

type
  T16BitReader = class(TICLReader)
  private
    FStream : TStream;
    FAlignShift         : Word;
    FWin16Offset        : Word;
    FResourceTableStart : DWord;
    FNamestableStart    : DWord;
    FIconCount          : Word;
    FGroupIconCount     : Word;
    FICLName            : String;
    FIconsRes           : PNameRecArray;
    FGroupIconsRes      : PNameRecArray;
  protected
    procedure ReadFileHeader;
    procedure ReadResourceTable;
    procedure ReadTypeInfo;
    procedure ReadResourceNames;
  public
    constructor Create(AFilename : String); override;
    destructor Destroy; override;
    function Execute : Boolean; override;
    function GetResourceIndex(ID : Word;GroupIcon : Boolean) : Integer;
    procedure ReadResource(Index : Word;GroupIcon : Boolean;Stream : TStream;Var ResName : String);
    property IconCount : Word read FGroupIconCount;
  end;

(********************************************************************)
(**                    T16BitWriter declaration                    **)
(********************************************************************)

type
  T16BitWriter = class
  private
    FShiftAlignOffs : DWord;
    FNamesTableOffs : DWord;
    FOfs_Icons  : PDWordArray;
    FOfs_GIcons : PDWordArray;
    FIcons      : Integer;
    FIconLib    : TIconLibrary;
    FAlignShift : Word;
    FStream : TMemoryStream;
    Null    : ARRAY[1..256] OF Char;
  protected
    procedure WriteShiftAlign;
    procedure UpdateTableEntry(EntryPos : DWord;StartOffset,EndOffset : DWord);
    procedure WriteHeader;
    procedure WriteResTable;
    procedure WriteNameTable;
    procedure WriteIconData;
    procedure Align;
    property Stream : TMemoryStream read FStream;
  public
    constructor Create(AIconLib : TIconLibrary);
    destructor Destroy; override;
    procedure SaveToFile(Filename : String);
    property IconLib : TIconLibrary read FIconLib;
  end;

(********************************************************************)
(**                      TICL16Icon declaration                    **)
(********************************************************************)

type
  TICL16Icon = class(TMultiIcon)
  private
    FResName : String;
    FICLReader : T16BitReader;
    function GeTICL16IconResInfo(Index : Word) : TFileIconResInfo;
  protected
    Icons : TMemoryStream;
    function GetHIcon(Index : Word) : HIcon; override;
    function GetIconSize(Index : Word) : TSize; override;
    procedure LoadIconResInfos(Stream : TStream;Var Valid : Boolean;Var Count : Word);override;
    function GetIconResInfo(Index : Word) : TIconResInfo; override;
  public
    procedure WriteIconDataToStream(Stream : TStream;Index : Integer); override;
    constructor ICLCreate(ICLReader : T16BitReader;Index : Word);
    destructor Destroy; override;
    property ResName : String read FResName;
    property ICLIconResInfo[Index : Word] : TFileIconResInfo read GeTICL16IconResInfo;
  end;

implementation

{$R-}

type
  EICLReadError  = class (Exception);
  EICLWriteError = class (Exception);

const
  IMAGE_DOS_SIGNATURE    = $5A4D;       { MZ }
  IMAGE_IM_SIGNATURE     = $4D49;       { IM }
  IMAGE_OS2_SIGNATURE    = $454E;       { NE }
  IMAGE_W32_SIGNATURE    = $4550;       { PE }
  IMAGE_NAMETABLE_ICL  : ARRAY[0..3] OF Char = 'ICL'+#0;

  E_R_InvWin16Offs    = 'Invalid Windows 16 Offset';
  E_R_InvWin16Header  = 'Invalid Windows 16 Header';
  E_R_NotValid16Bit   = 'Not a valid ICL File';
  E_R_NoResources     = 'No Resources in file';
  E_R_NoNamesTable    = 'Names Table not found';
  E_R_IconResNotFound = 'Icon Resource Not Found';
  E_R_ResTableError   = 'ResourceTable has an Error';
  E_W_NoIcons         = 'Unable to write Iconlibrary with no icons';
  E_W_TooManyIcons    = 'Iconlibraries with more than 32767 are not possible';

procedure ICLReadError(const ErrMsg: string);
begin
  raise EICLReadError.Create(ErrMsg);
end;

procedure ICLWriteError(const ErrMsg: string);
begin
  raise EICLReadError.Create(ErrMsg);
end;

function IsValidLib(Filename : String;Var Is32Bit : Boolean) : Boolean;
Var
  F : TFileStream;
  Sig : Word;
begin
  Result:=False;
  F:=TFileStream.Create(Filename,fmOpenRead or fmShareDenyWrite);
  With F DO
  try
    Read(Sig,SizeOf(Sig));
    IF (Sig <>IMAGE_DOS_SIGNATURE) Then exit;
    Seek($3C,soFromBeginning);
    Read(Sig,SizeOf(Sig));
    Seek(Sig,soFromBeginning);
    Read(Sig,SizeOf(Sig));
    Result:=(Sig = IMAGE_W32_SIGNATURE) OR (Sig = IMAGE_OS2_SIGNATURE);
    Is32Bit:=(Sig = IMAGE_W32_SIGNATURE);
  finally
    F.Free;
  end;
end;

(********************************************************************)
(**                  TIconLibrary implementation                   **)
(********************************************************************)

constructor TIconLibrary.Create;
begin
  FIcons := TStringList.Create;
end;

destructor TIconLibrary.Destroy;
Var
  I : Integer;
begin
  FOR I:=1 TO Icons.Count Do TMultiIcon(Icons.Objects[I-1]).Free;
  FIcons.Free;
end;

procedure TIconLibrary.LoadFromFile(Filename : String);
Var
  LoadedIcons,IconCount : Integer;
  Is32Bit : Boolean;
  Reader : TICLReader;
begin
  LoadedIcons:=0;
  IconCount:=ExtractIcon(HInstance,PChar(Filename),dword(-1));
  IF (IconCount=0) Then exit;
  IF NOT IsValidLib(Filename,Is32Bit) Then exit;
  FFilename:=Filename;
  IF NOT Is32Bit Then
    Reader:=T16BitReader.Create(Filename)
  else
    Reader:=T32BitReader.Create(Filename);
  try
    IF Reader.Execute Then begin
      LoadedIcons:=Reader.Icons.Count;
      Icons.Assign(Reader.Icons);
    end;
  finally
    Reader.Free;
  end;
  IF LoadedIcons<>IconCount Then begin
    beep;
  end;  
end;

procedure TIconLibrary.SaveToFile(Filename : String);
Var
  ICLFile  : T16BitWriter;
begin
  IF Icons.Count=0 Then ICLWriteError(E_W_NoIcons);
  IF Icons.Count>=$8000 Then ICLWriteError(E_W_TooManyIcons);
  ICLFile:=T16BitWriter.Create(self);
  try
    ICLFile.SaveToFile(Filename);
  finally
    ICLFile.Free;
  end;
end;

(********************************************************************)
(**                  TICLReader implementation                     **)
(********************************************************************)

constructor TICLReader.Create(Filename : String);
begin
  FIcons:=TStringList.Create;
  FFilename:=Filename;
end;

destructor TICLReader.Destroy;
begin
  IF Assigned(FIcons) Then FIcons.free;
  inherited;
end;

(********************************************************************)
(**                 T32BitReader implementation                    **)
(********************************************************************)

function EnumResNameProc(hModule : THandle;lpszType,lpszName : PChar;lParam : lParam) : Bool; stdcall;
begin
  Result:=True;
  T32BitReader(lParam).IconResFound(lpszName);
end;

constructor T32BitReader.Create(Filename : String);
begin
  inherited;
  FreeLib:=False;
  Instance:=0;
end;

function T32BitReader.Execute : Boolean;
begin
  Result:=False;
  try
    Instance:= windows.LoadLibraryEx(PChar(FFilename), 0, LOAD_LIBRARY_AS_DATAFILE);
  finally
  end;
  IF Instance=0 then exit;
  FreeLib:=True;
  Result:=True;
  EnumResourcenames(Instance,RT_GROUP_ICON,@EnumResNameProc,Integer(self));
end;

procedure T32BitReader.IconResFound(ResName : PChar);
Var
  Ico : TICL32Icon;
  IsID : Boolean;
  RName : String;
begin
  IsID:=IsBadStringPtr(ResName,63);
  IF IsID Then begin
    Ico:=TICL32Icon.CreateFromID(Instance,Loword(Integer(ResName)));
    RName:=InttoStr(Integer(Resname));
  end else begin
    Ico:=TICL32Icon.Create(Instance,Strpas(ResName));
    Rname:=Strpas(ResName);
  end;
  FIcons.AddObject(RName,Ico);
end;

destructor T32BitReader.Destroy;
begin
  inherited;
  IF FreeLib Then FreeLibrary(Instance);
end;

(********************************************************************)
(**                   TICL32Icon implementation                    **)
(********************************************************************)

procedure TICL32Icon.BufferIconData;
Var
  I : Integer;
  RStream : TResourceStream;
  SPos : DWord;
begin
  FIconData:=TMemoryStream.Create;
  With FIconData DO begin
    Clear;
    Seek(IconCount*SizeOf(DWord),soFromBeginning);
    FOR I:=1 TO IconCount DO
      With PResourceIconDirList(IconDirList)^[I-1] do begin
        RStream:=TResourceStream.CreateFromID(Instance,ID,RT_ICON);
        try
          SPos:=Position;
          Position:=SizeOf(DWord)*(I-1);
          Write(SPos,SizeOf(DWord));
          Position:=SPos;
          ResInfo.BytesInRes:=RStream.Size;
          CopyFrom(RStream,RStream.Size);
        finally
          RStream.Free;
        end;
      end;
  end;
end;

function TICL32Icon.GetHIcon(Index : Word) : HIcon;
Var
  DW : DWord;
begin
  Result:=0;
  IF Index>=IconCount Then exit;
  IF IconHandleList^[Index]=0 Then begin
    with ResourceIconResInfo[Index] do begin
      FIconData.Position:=Index*SizeOf(DWord);
      FIcondata.Read(DW,SizeOf(DWord));
      FIconData.Position:=DW;
      Result:=CreateIconFromStream(FIconData,ResInfo.BytesInRes,ResInfo);
      IconHandleList^[Index]:=Result;
    end;
  end else
    Result:=IconHandleList^[Index];
end;

procedure TICL32Icon.WriteIconDataToStream(Stream : TStream;Index : Integer);
Var
  DW : DWord;
begin
  IF Index>=IconCount Then exit;
  with ResourceIconResInfo[Index] do begin
    FIconData.Position:=Index*SizeOf(DWord);
    FIcondata.Read(DW,SizeOf(DWord));
    FIconData.Position:=DW;
    Stream.CopyFrom(FIconData,ResInfo.BytesInRes);
  end;
end;

procedure TICL32Icon.LoadIconResInfos(Stream : TStream;Var Valid : Boolean;Var Count : Word);
begin
  inherited;
  BufferIconData;
end;

destructor TICL32Icon.Destroy;
begin
  IF Assigned(FIconData) Then FIconData.Free;
  inherited;
end;

(********************************************************************)
(**                  T16BitReader implementation                   **)
(********************************************************************)

function T16BitReader.GetResourceIndex(ID : Word;GroupIcon : Boolean) : Integer;
Var
  Res : PNameRecArray;
  I,IMax : Integer;
begin
  Result:=-1;
  IF GroupIcon Then begin
    Res:=FGroupIconsRes;
    IMax:=FGroupIconCount;
  end else begin
    Res:=FIconsRes;
    IMax:=FIconCount;
  end;
  I:=0;
  While (I<IMax) DO begin
    IF (((Res^[I].rnID) XOR $8000)=ID) Then begin
      Result:=I;
      break;
    end;
    INC(I);
  end;
  IF Result>=0 Then exit;
  ICLReadError(E_R_IconResNotFound);
end;


procedure T16BitReader.ReadResource(Index : Word;GroupIcon : Boolean;
          Stream : TStream;Var ResName : String);
Var
  Namerec : TNameRec;
  ResStartPos : Longint;
  ResLength   : Longint;
begin
  IF GroupIcon Then NameRec:=FGroupIconsRes^[Index]
    else NameRec:=FIconsRes^[Index];
  ResName:=Format('%s %0.3d',[FICLName,Index+1]);
  ResStartPos:=NameRec.rnOffset shl FAlignShift;
  ResLength  :=NameRec.rnLength shl FAlignShift;
  FStream.Position:=ResStartPos;
  Stream.CopyFrom(FStream,ResLength);
end;

constructor T16BitReader.Create(AFilename : String);
begin
  inherited;
  FStream:=TFileStream.Create(AFilename,fmOpenRead or fmShareDenyWrite);
  FStream.Position:=0;
  FICLName:=ExtractFilename(AFilename);
  Delete(FICLName,Length(FICLName)-Length(ExtractFileExt(FICLname))+1,30);
end;

destructor T16BitReader.Destroy;
begin
  FStream.Free;
  inherited;
end;

function T16BitReader.Execute : Boolean;
Var
  ICLIcon : TICL16Icon;
  I,L : Integer;
  S : String;
  NameOfList : Boolean;
  SL : TStringList;
begin
  try
    FIconsRes:=nil;
    FGroupIconsRes:=nil;
    FIcons.Clear;
    ReadFileHeader;
    ReadResourceTable;
    SL:=TStringList.Create;
    try
      L:=FGroupIconCount;
      NameOfList:=(FIcons.Count=FGroupIconCount);
      FOR I:=1 TO L DO begin
        ICLIcon:=TICL16Icon.ICLCreate(self,I-1);
        IF NameOfList Then
          S:=FIcons.Strings[I-1]
        else
          S:=ICLIcon.ResName;
        SL.AddObject(S,ICLIcon);
      end;
      FIcons.Assign(SL);
    finally
      SL.Free;
    end;  
  except
    Result:=False;
    exit;
  end;
  Result:=True;
end;

procedure T16BitReader.ReadFileHeader;
Var
  DosSignature     : Word;
  Win16Signature   : Word;
  ResTableOffset   : Word;
  NamesTableOffset : Word;
begin
  With FStream DO begin
    Read(DosSignature,SizeOf(DosSignature));
    IF (DosSignature<>IMAGE_DOS_SIGNATURE) Then ICLReadError(E_R_NotValid16Bit);
    Seek($3C,soFromBeginning);
    Read(FWin16Offset,SizeOf(Word));
    IF (FWin16Offset<$3C) Then ICLReadError(E_R_InvWin16Offs);
    Seek(FWin16Offset,soFromBeginning);
    Read(Win16Signature,SizeOf(Win16Signature));
    IF (Win16Signature<>IMAGE_OS2_SIGNATURE) Then ICLReadError(E_R_InvWin16Header);
    Seek($22,soFromCurrent);
    Read(ResTableOffset,SizeOf(Word));
    IF (ResTableOffset=0) Then ICLReadError(E_R_NoResources);
    FResourceTableStart:=ResTableOffset+FWin16Offset;
    Read(NamesTableOffset,SizeOf(NamesTableOffset));
    IF (NamesTableOffset=0) Then ICLReadError(E_R_NoNamesTable);
    FNamesTableStart:=NamesTableOffset+FWin16Offset;
  end;
end;

procedure T16BitReader.ReadResourceTable;
Var
  EndTypes : Word;
begin
  with FStream DO begin
    Seek(FResourceTableStart,soFromBeginning);
    Read(FAlignShift,SizeOf(Word));
    Read(EndTypes,SizeOf(Word));
    While (Endtypes>0) DO begin
      Seek(-SizeOf(Word),sofromCurrent);
      ReadTypeInfo;
      Read(EndTypes,SizeOf(Word));
    end;
    IF (FGroupIconsRes=nil) OR (FIconsRes=nil) Then ICLReadError(E_R_ResTableError);
    ReadResourceNames;
  end;
end;

procedure T16BitReader.ReadResourceNames;
Var
  NameLen : byte;
  S : String;
begin
  With FStream DO begin
    Read(NameLen,SizeOf(NameLen));
    While (NameLen>0) DO begin
      SetString(S,nil,NameLen);
      Read(Pointer(S)^,NameLen);
      IF NOT ((FIcons.Count=0) AND (CompareStr(S,StrPas(IMAGE_NAMETABLE_ICL))=0)) Then
        FIcons.Add(S);
      Read(NameLen,SizeOf(NameLen));
    end;
  end;
end;

procedure T16BitReader.ReadTypeInfo;
Var
  TypeInfo : TTypeRec;
  I : Integer;
  TypeRead : Boolean;
begin
  With FStream DO begin
    Read(TypeInfo,SizeOf(TypeInfo));
    With TypeInfo DO begin
      I:=SizeOf(TNameRec)*rtResourceCount;
      TypeRead:=false;
      IF (rtTypeID or $8000 = rtTypeID) Then begin
        IF (Lo(rtTypeID)=Word(RT_ICON))       Then begin
          FIconCount:=rtResourceCount;
          GetMem(FIconsRes,I);
          Read(FIconsRes^,I);
          TypeRead:=True;
        end;
        IF (Lo(rtTypeID)=Word(RT_GROUP_ICON)) Then begin
          FGroupIconCount:=rtResourceCount;
          GetMem(FGroupIconsRes,I);
          Read(FGroupIconsRes^,I);
          TypeRead:=True;
        end;
      end;
    end;
    IF NOT TypeRead Then Seek(I,soFromCurrent);
  end;
end;

(********************************************************************)
(**                  T16BitWriter implementation                   **)
(********************************************************************)

constructor T16BitWriter.Create(AIconLib : TIconLibrary);
Var
  I : Integer;
begin
  {$IFDEF Writer16} Debugger.Enterproc('Constructor Create');{$ENDIF}
  FIconLib:=AIconLib;
  FIcons:=0;
  FStream:=TMemoryStream.Create;
  FOR I:=1 TO IconLib.Icons.Count DO
    INC(FIcons,TMultiIcon(IconLib.Icons.Objects[I-1]).IconCount);
  FAlignShift:=1;
  GetMem(FOfs_Icons,FIcons*SizeOf(DWord));
  GetMem(FOfs_GIcons,IconLib.Icons.Count*SizeOf(DWord));
  FillChar(Null,SizeOf(Null),#0);
  {$IFDEF Writer16} Debugger.Leaveproc('Constructor Create');{$ENDIF}
end;

procedure T16BitWriter.WriteShiftAlign;
Var
  I,J : Integer;
  Ico : TMultiIcon;
  IconDataSize : DWord;
  SavedPos : Cardinal;
begin
  {$IFDEF Writer16} Debugger.Enterproc('WriteShiftAlign');{$ENDIF}
  IconDataSize:=Stream.Position;
  FOR I:=1 TO IconLib.Icons.Count DO begin
    Ico:=TMultiIcon(IconLib.Icons.Objects[I-1]);
    INC(FIcons,Ico.IconCount);
    INC(IconDataSize,SizeOf(TIconHeader));
    FOR J:=1 TO Ico.IconCount DO begin
      INC(IconDataSize,SizeOf(TResourceIconResInfo));
      INC(IconDataSize,Ico.IconResInfo[J-1].BytesInRes);
    end;
  end;
  FAlignShift:=0;
  While ((MaxWord shl FAlignShift)<IconDataSize) DO INC(FAlignShift);
  With Stream DO begin
    SavedPos:=Position;
    Position:=FShiftAlignOffs;
    Write(FAlignShift,SizeOf(FAlignShift));
    Position:=SavedPos;
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('WriteShiftAlign');{$ENDIF}
end;

destructor T16BitWriter.Destroy;
begin
  {$IFDEF Writer16} Debugger.Enterproc('Destructor Destroy');{$ENDIF}
  FStream.Free;
  Freemem(FOfs_Icons);
  Freemem(FOfs_GIcons);
  inherited;
  {$IFDEF Writer16} Debugger.Leaveproc('Destructor Destroy'){$ENDIF}
end;

procedure T16BitWriter.SaveToFile(Filename : String);
begin
  {$IFDEF Writer16} Debugger.Enterproc('SaveToFile');{$ENDIF}
  try
    WriteHeader;
    WriteResTable;
    WriteNameTable;
    WriteShiftAlign;
    WriteIconData;
    FStream.SaveToFile(Filename);
  finally
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('SaveToFile');{$ENDIF}
end;

procedure T16BitWriter.WriteHeader;
var
  W : Word;
  Null : Array[1..100] OF Char;
begin
  {$IFDEF Writer16} Debugger.Enterproc('WriteHeader');{$ENDIF}
  FillChar(Null,SizeOf(Null),#0);
  With Stream DO begin
    W:=IMAGE_DOS_SIGNATURE;
    Write(W,SizeOf(W));
    Write(Null,58);
    W:=$80;
    Write(W,SizeOf(W));
    Write(Null,64);
    W:=IMAGE_IM_SIGNATURE;
    Write(W,SizeOf(W));
    W:=IMAGE_OS2_SIGNATURE;
    Write(W,SizeOf(W));
    Write(Null,32);
    W:=64;
    Write(W,SizeOf(W));
    Write(W,SizeOf(W));
    FNamesTableOffs:=Position;
    Write(Null,16);
    W:=$2; // 36h -> Operating System = Windows
    Write(W,SizeOf(W));
    Write(Null,7);
    W:=$3; // 3Eh -> expected Windows version number
    Write(W,1);
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('WriteHeader');{$ENDIF}
end;

procedure T16BitWriter.WriteResTable;
var
  W : Word;
  DW : DWord;
  I : Integer;
  NameInfo : TNameRec;
begin
  {$IFDEF Writer16} Debugger.Enterproc('WriteResTable');{$ENDIF}
  DW:=0;
  W:=0;
  With Stream DO begin
    FShiftAlignOffs:=Position;
    Write(W,SizeOf(W)); // rscAlignShift written later;
    W:=$800E;
    Write(W,SizeOf(W)); //rt_GroupIcon TypeInfo
    W:=IconLib.Icons.Count;
    Write(W,SizeOf(W)); //ResourceCount rt_GroupIcon
    Write(DW,SizeOf(DW));
    FillChar(NameInfo,SizeOf(NameInfo),#0);
    NameInfo.rnFlags:=$1C30;
    NameInfo.rnOffset:=$FF;
    NameInfo.rnLength:=$FF00;
  {$IFDEF Writer16} Debugger.Enterproc('Loop 1');{$ENDIF}
    FOR I:=1 TO IconLib.Icons.Count DO begin
      NameInfo.rnID:=I or $8000;
      FOfs_GIcons^[I-1]:=Position;
      Write(NameInfo,SizeOf(NameInfo));
    end;
  {$IFDEF Writer16} Debugger.Leaveproc('Loop 1');{$ENDIF}
    W:=$8003;
    Write(W,SizeOf(W)); //rt_Icon TypeInfo
    W:=FIcons;
    Write(W,SizeOf(W)); //ResourceCount rt_GroupIcon
    Write(DW,SizeOf(DW));
  {$IFDEF Writer16} Debugger.Enterproc('Loop 2');{$ENDIF}
    FOR I:=1 TO FIcons DO begin
      NameInfo.rnID:=I or $8000;
      FOfs_Icons^[I-1]:=Position;
      Write(NameInfo,SizeOf(NameInfo));
    end;
  {$IFDEF Writer16} Debugger.Leaveproc('Loop 2');{$ENDIF}
    W:=0;
    Write(W,SizeOf(W));
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('WriteResTable');{$ENDIF}
end;

procedure T16BitWriter.WriteNameTable;
Var
  B : byte;
  I : Integer;
  S : String;
  Pos : Integer;
  W : Word;
begin
  {$IFDEF Writer16} Debugger.Enterproc('WriteNameTable');{$ENDIF}
  With Stream DO begin
    Pos:=Position;
    Position:=FNamesTableOffs;
    W:=Pos-$80;
    Write(W,SizeOf(Word));
    Position:=Pos;
    B:=3;
    Write(B,SizeOf(B));
    Write(IMAGE_NAMETABLE_ICL,3);
    FOR I:=1 TO IconLib.Icons.Count DO begin
      S:=IconLib.Icons.Strings[I-1];
      B:=Length(S);
      Write(B,SizeOf(B));
      Write(Pointer(S)^,B)
    end;
    B:=0;
    Write(B,SizeOf(B));
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('WriteNameTable');{$ENDIF}
end;

procedure T16BitWriter.Align;
Var
  C : Integer;
begin
  With Stream DO begin
    C:=(Position shr FAlignShift);
    IF (C shl FAlignShift)=Position Then exit;
    INC(C);
    C:=(C shl FAlignShift)-Position;
    IF C>SizeOf(Null) Then begin
      While (C>SizeOf(Null)) DO begin
        Write(Null,SizeOf(Null));
        DEC(C,SizeOf(Null));
      end;
    end;
    Write(Null,C)
  end;
end;

procedure T16BitWriter.WriteIconData;
Var
  IID : Word;
  I,J : Integer;
  Ico : TMultiIcon;
  Header : TIconHeader;
  ResInfo : TResourceIconResInfo;
  SOffset,EOffset : DWord;
  W : Word;
begin
  {$IFDEF Writer16} Debugger.Enterproc('WriteIconData');{$ENDIF}
  Header.wReserved:=0;
  Header.wType:=1;
  IID:=1;
  Align;
  With Stream DO begin
    FOR I:=1 TO IconLib.Icons.Count DO begin
      SOffset:=Position;
      Ico:=TMultiIcon(IconLib.Icons.Objects[I-1]);
      Header.wCount:=Ico.IconCount;
      Write(Header,SizeOf(Header));
      FOR J:=1 TO Header.wCount DO begin
        ResInfo.ResInfo:=Ico.IconResInfo[J-1];
        ResInfo.ID:=IID;
        Write(ResInfo,SizeOf(ResInfo));
        INC(IID);
      end;
      Align;
      EOffset:=Position;
      UpdateTableEntry(FOfs_GIcons^[I-1],SOffset,EOffset);
    end;
    IID:=1;
    FOR I:=1 TO IconLib.Icons.Count DO begin
      Ico:=TMultiIcon(IconLib.Icons.Objects[I-1]);
      FOR J:=1 TO Ico.IconCount DO begin
        SOffset:=Position;
        Ico.WriteIconDataToStream(Stream,J-1);
        Align;
        EOffset:=Position;
        UpdateTableEntry(FOfs_Icons^[IID-1],SOffset,EOffset);
        INC(IID);
      end;
    end;
    W:=0;
    Write(W,SizeOf(W));
  end;
  {$IFDEF Writer16} Debugger.Leaveproc('WriteIconData');{$ENDIF}
end;

procedure T16BitWriter.UpdateTableEntry(EntryPos : DWord;StartOffset,EndOffset : DWord);
Var
  OldPos : cardinal;
  W : Word;
begin
  With Stream DO begin
    OldPos:=Position;
    try
      Position:=EntryPos;
      W:=StartOffset shr FAlignShift;
      Write(W,SizeOf(Word));
      W:=(EndOffset-StartOffset) shr FAlignShift;
      Write(W,SizeOf(Word));
    finally
      Position:=OldPos;
    end;
  end;
end;

(********************************************************************)
(**                    TICL16Icon implementation                   **)
(********************************************************************)

constructor TICL16Icon.ICLCreate(ICLReader : T16BitReader;Index : Word);
Var
  GroupIcon : TMemoryStream;
begin
  FICLReader:=ICLReader;
  CreateDefaults;
  Icons:=TMemoryStream.Create;
  GroupIcon:=TMemoryStream.Create;
  try
    ICLReader.ReadResource(Index,True,GroupIcon,FResname);
    GroupIcon.Position:=0;
    InitHeaders(GroupIcon);
  finally
    GroupIcon.Free;
  end;
end;

destructor TICL16Icon.Destroy;
begin
  Icons.free;
  inherited;
end;

function TICL16Icon.GeTICL16IconResInfo(Index : Word) : TFileIconResInfo;
begin
  IF Index>=IconCount Then exit;
  Result:=PFileIconDirList(IconDirList)^[Index];
end;

function TICL16Icon.GetHIcon(Index : Word) : HIcon;
begin
  Result:=0;
  IF Index>=IconCount Then exit;
  IF IconHandleList^[Index]=0 Then begin
    with ICLIconResInfo[Index] do begin
      Icons.Position:=dwImageOffset;
      Result:=CreateIconFromStream(Icons,ResInfo.BytesInres,ResInfo);
      IconHandleList^[Index]:=Result;
    end;
  end else
    Result:=IconHandleList^[Index];
end;

function TICL16Icon.GetIconSize(Index : Word) : TSize;
begin
  with IconResInfo[Index] do begin
    Result.cx:=Width;
    Result.cy:=Height;
  end;
end;

procedure TICL16Icon.LoadIconResInfos(Stream : TStream;Var Valid : Boolean;Var Count : Word);
Var
  I,ID          : Word;
  StartHeader : TIconHeader;
  TmpDirListLen  : Integer;
  TmpIconDirList : PResourceIconDirList;
  S : String;
begin
  With Stream DO begin
    Read(StartHeader,sizeOf(StartHeader));
    Valid:=((StartHeader.wReserved=0) AND (StartHeader.wType=1));
    IF NOT Valid Then exit;
    Count:=StartHeader.wCount;
    TmpDirListLen:=Count*SizeOf(TResourceIconResInfo);
    DirListLen   :=Count*SizeOf(TFileIconResInfo);
    HandleListLen:=Count*SizeOf(HIcon);
    TmpIconDirList:=AllocMem(TmpDirListlen);
    IconDirList   :=AllocMem(DirListlen);
    IconHandleList:=AllocMem(HandleListlen);
    FOR I:=1 TO IconCount DO IconHandleList^[I-1]:=0;
    ReadBuffer(TmpIconDirList^,TmpDirListLen);
  end;
  FOR I:=1 TO IconCount DO begin
    PFileIconDirList(IconDirList)^[I-1].ResInfo:=TmpIconDirList^[I-1].ResInfo;
    PFileIconDirList(IconDirList)^[I-1].dwImageOffset:=Icons.Position;
    ID:=FICLReader.GetResourceIndex(TmpIconDirList^[I-1].ID,False);
    IF ID>=0 Then FICLReader.ReadResource(ID,False,Icons,S);
  end;
end;

function TICL16Icon.GetIconResInfo(Index : Word) : TIconResInfo;
begin
  IF Index>=IconCount Then exit;
  Result:=PFileIconDirList(IconDirList)^[Index].ResInfo;
end;

procedure TICL16Icon.WriteIconDataToStream(Stream : TStream;Index : Integer);
begin
  IF Index>=IconCount Then exit;
  with ICLIconResInfo[Index] do begin
    Icons.Position:=dwImageOffset;
    Stream.CopyFrom(Icons,ResInfo.BytesInres);
  end;
end;

initialization
{$IfDEF Overseer}
  Debugger.Clear;
{$EndIf}
end.
