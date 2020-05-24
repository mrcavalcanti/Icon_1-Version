unit uDlgSearchIcon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ShellAPI, ImgList, Buttons;

type
  TFileIcon = record
    FileName : String[255];
    Index    : Integer;
    Category : String[50];
  end;

  TfDlgSearchIcon = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lblFileName: TLabel;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    lblIconName: TLabel;
    Label3: TLabel;
    lblDirectory: TLabel;
    Bevel1: TBevel;
    Button2: TButton;
    imgList: TImageList;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Label4: TLabel;
    lblDeletado: TLabel;

    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    IntIcone: Integer;
    IntDel: Integer;
    FileIcon: array of TFileIcon;
    Ext: String;
    PathSearch: String;
    CompareIcon: Boolean;
    fCancelSearch: Boolean;
    procedure SearchIcon(nFile: String);
    procedure FindExt;
    function DeleteIconRepeat(A, B: TIcon): Boolean;
  public
    { Public declarations }
  end;

var
  fDlgSearchIcon: TfDlgSearchIcon;

type
  TResultSearch = Record
    FIcon: array of TFileIcon;
end;

function DlgSearchIcon(AOwner: TComponent; Extensao, Path: String;
  Compare: Boolean): TResultSearch;

implementation

uses Unit1, uSearchIcon;

{$R *.dfm}

function DlgSearchIcon(AOwner: TComponent; Extensao, Path: String;
  Compare: Boolean): TResultSearch;
var
  I: Integer;
  Ico: TIcon;
begin
  if TWinControl(AOwner).FindComponent('fDlgSearchIcon') <> nil then
    Exit;

  with TfDlgSearchIcon.Create(AOwner) do
  begin
    Ext := Extensao;
    PathSearch := Path;
    CompareIcon := Compare;
    lblDeletado.Visible := CompareIcon;
    ShowModal;

    Ico := TIcon.Create;
    for I := Low(FileIcon) to Pred(High(FileIcon)) do
    begin
      imgList.GetIcon(I, Ico);
      fSearchIcon.imgList.AddIcon(Ico);
    end;
    Ico.Free;

    SetLength(Result.FIcon, High(FileIcon));
    for I := Low(FileIcon) to Pred(High(FileIcon)) do
    begin
      Result.FIcon[I].FileName := FileIcon[I].FileName;
      Result.FIcon[I].Index := FileIcon[I].Index;
      Result.FIcon[I].Category := FileIcon[I].Category;
    end;
  end;
end;


procedure TfDlgSearchIcon.FindExt;
var
//  Drive: Char;
  ErrorMode: word;

  procedure ProcessMessages;
  var
    Msg: TMsg;
  begin
    while PeekMessage(Msg,0,0,0,PM_REMOVE) do
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;

  procedure ScanDirectory(FromDir: string);
  var
    SearchRec: TSearchRec;
    SearchResult: integer;
  begin
    if FromDir[Length(FromDir)] <> '\' then
      FromDir := FromDir + '\';
    SearchResult := FindFirst(FromDir + '*.*', faAnyFile,SearchRec);
    while (SearchResult = 0) do
    begin
      ProcessMessages;
      if (SearchRec.Attr and faDirectory) = faDirectory then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          ScanDirectory(FromDir + SearchRec.Name)
      end
      else if CompareText(ExtractFileExt(SearchRec.Name), Ext) = 0 then
      begin
        SearchIcon(FromDir + SearchRec.Name);
      end;
      lblDirectory.Caption := FromDir;
      if fCancelSearch then
        Break;
      SearchResult := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
  end;

begin
  ErrorMode := SetErrorMode(SEM_FailCriticalErrors);
  fCancelSearch := False;
  try
//    Drive := 'C';
    begin
      try
//        ScanDirectory(Drive + ':\');
        ScanDirectory(PathSearch);
//        Drive := char(ord(Drive) + 1);
      except
        raise exception.Create('Erro na pesquisa!');
      end;
    end;
  finally
    SetErrorMode(ErrorMode);
    if fCancelSearch then
      ShowMessage('Pesquisa interrompida!')
    else
      ShowMessage('Pesquisa concluída!');
  end;
  BitBtn1.Default := True;
  BitBtn1.Visible := True;
end;


procedure TfDlgSearchIcon.SearchIcon(nFile: String);
var
  I, J: Integer;
  Icon, IconMain: TIcon;
  ADD: Boolean;
begin
  ADD := True;
  if FileExists(nFile) then
  begin
    Icon := TIcon.Create;
    IconMain := TIcon.Create;
    try
      lblFileName.Caption := ExtractFilePath(nFile);
      {$IFDEF WIN32}
      IntIcone := ExtractIcon(HInstance, PChar(nFile), $FFFFFFFF);
      {$ELSE}
      IntIcone := ExtractIcon(HInstance, PChar(nFile), $FFFF);
      {$ENDIF}

      if IntIcone > 0 then
      begin
        ProgressBar1.Min := 0;
        ProgressBar1.Max := IntIcone;
        for I := 0 to Pred(IntIcone) do
        begin
          Icon.Handle := ExtractIcon(HInstance,PChar(nFile), I);
          if (imgList.Count > 0) then
          begin
            for J := 0 to Pred(imgList.Count) do
            begin
              imgList.GetIcon(J, IconMain);
              if CompareIcon then
                if DeleteIconRepeat(IconMain, Icon) then
                  ADD := False;
            end;
          end
          else
          begin
            ImgList.AddIcon(Icon);
            SetLength(FileIcon, ImgList.Count);
            lblIconName.Caption := ExtractFileName(nFile);
            Image1.Picture.Icon := Icon;
            ProgressBar1.Position := I + 1;
            FileIcon[Pred(ImgList.Count)].FileName := ExtractFileName(nFile);
            FileIcon[Pred(ImgList.Count)].Index := I;
            FileIcon[Pred(ImgList.Count)].Category := 'Teste';
          end;
          if ADD then
          begin
            ImgList.AddIcon(Icon);
            SetLength(FileIcon, ImgList.Count);
            lblIconName.Caption := ExtractFileName(nFile);
            Image1.Picture.Icon := Icon;
            ProgressBar1.Position := I + 1;
            FileIcon[Pred(ImgList.Count)].FileName := ExtractFileName(nFile);
            FileIcon[Pred(ImgList.Count)].Index := I;
            FileIcon[Pred(ImgList.Count)].Category := 'Teste';
          end;
          if fCancelSearch then
            Break;
          Application.ProcessMessages;
        end;
      end;
    finally
      Icon.Free;
      IconMain.Free;
    end;
  end;
  Caption := 'Pesquisar ícones - (' + IntToStr(imgList.Count) + ') ícones extraídos';
  ProgressBar1.Position := 0;
end;


function TfDlgSearchIcon.DeleteIconRepeat(A, B: TIcon): Boolean;
var
  FromF, FromF2: file;
  NumRead, NumRead2: Integer;
  Buf: array[1..512] of Char;  //2048
  Buf2: array[1..512] of Char;
  IconA, IconB: TIcon;
begin
  Result := True;
  A.SaveToFile(ExtractFilePath(Application.ExeName) + 'A.ico');
  B.SaveToFile(ExtractFilePath(Application.ExeName) + 'B.ico');
  AssignFile(FromF, ExtractFilePath(Application.ExeName) + 'A.ico');
  AssignFile(FromF2, ExtractFilePath(Application.ExeName) + 'B.ico');
  Reset(FromF, 1);	{ Record size = 1 }
  Reset(FromF2, 1);
  repeat
    Application.ProcessMessages;  
    BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
    BlockRead(FromF2, Buf2, SizeOf(Buf2), NumRead2);
    if Buf <> Buf2 then
    begin
      Result := False;
      Break;
    end;
    if fCancelSearch then
      Break;
  until (NumRead = 0);
  CloseFile(FromF);
  CloseFile(FromF2);
  if Result then
  begin
    Inc(IntDel);
    lblDeletado.Caption := 'Deletado: ' + IntToStr(intDel);
  end;
end;



procedure TfDlgSearchIcon.Button2Click(Sender: TObject);
begin
  fCancelSearch := True;
end;

procedure TfDlgSearchIcon.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfDlgSearchIcon.FormActivate(Sender: TObject);
begin
  FindExt;
end;

procedure TfDlgSearchIcon.Button1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfDlgSearchIcon.FormCreate(Sender: TObject);
begin
  IntDel := 0;
end;

end.
