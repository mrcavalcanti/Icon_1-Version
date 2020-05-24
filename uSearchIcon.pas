unit uSearchIcon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, ExtCtrls, Grids, ShlObj, Buttons, ComCtrls;

type
  TFileIcon = record
    FileName : String[255];
    Index    : Integer;
    Category : String[50];
  end;
  
  TfSearchIcon = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    imgList: TImageList;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
    bShowIcon: Boolean;
    nCol: Integer;
    Ext: String;
    Path: String;
    FileIcon: array of TFileIcon;

  public
    { Public declarations }
  end;

var
  fSearchIcon: TfSearchIcon;

procedure SearchIcon(AOwner: TComponent);

implementation

uses uDlgSearchIcon, Unit1;

{$R *.dfm}

procedure SearchIcon(AOwner: TComponent);
begin
  if TWinControl(AOwner).FindComponent('fSearchIcon') <> nil then
    Exit;

  with TfSearchIcon.Create(Application.MainForm) do
  begin
    Path := 'C:\';
    ShowModal;
  end;
end;


function SelectFolder(wnd: HWND; Title: String): String;
var
  lpItemID: PItemIDList;
  BrowseInfo: TBrowseInfo;
  DisplayName: array[0..MAX_PATH] of char;
  TempPath: array[0..MAX_PATH] of char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := wnd;
  BrowseInfo.pszDisplayName := @DisplayName;
  BrowseInfo.lpszTitle := PChar(Title);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    GlobalFreePtr(lpItemID);
  end
  else
    Result := '';
end;

procedure TfSearchIcon.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0: Ext := '.ico';
    1: Ext := '.exe';
    2: Ext := '.dll';
    3: Ext := '.ocx';
  end;
end;

procedure TfSearchIcon.FormShow(Sender: TObject);
begin
  Ext := '.ico';
  Path := 'C:\';
  Edit1.Text := Path; 
  RadioGroup1.ItemIndex := 0;
  bShowIcon := False;
  imgList.Clear;
  FileIcon := nil;
  StringGrid1.ColCount := 1;
  StringGrid1.RowCount := 1;
end;

procedure TfSearchIcon.FormResize(Sender: TObject);
begin
  nCol := Trunc(StringGrid1.Width / StringGrid1.DefaultColWidth);
  if bShowIcon then
  begin
    StringGrid1.ColCount := nCol;
    StringGrid1.RowCount := Trunc((imgList.Count / StringGrid1.ColCount) + 1);
  end;
end;

procedure TfSearchIcon.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if imgList.Count > 0 then
  begin
    StatusBar1.Panels[0].Text := 'Categoria: ' + FileIcon[(nCol * ARow) + ACol].Category + #13#10 +
      'Arquivo de origem: ' + FileIcon[(nCol * ARow) + ACol].FileName + #13#10 +
      'Posição: ' + IntToStr(FileIcon[(nCol * ARow) + ACol].Index);
    Form1.ImgIconEditor1.Bitmap.Assign(nil);
    imgList.GetBitmap((nCol * ARow) + ACol, Form1.ImgIconEditor1.Bitmap);
    Form1.ImgIconEditor1.Paint;
  end;
end;

procedure TfSearchIcon.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Icone : TIcon;
begin
  if bShowIcon then
  begin
    Icone := TIcon.Create;
    StringGrid1.Canvas.FillRect(Rect);
    try
      imgList.GetIcon((nCol * ARow) + ACol, Icone);
      StringGrid1.Canvas.Draw(Rect.Left+4, Rect.Top+4, Icone);
    finally
      Icone.Free;
    end;
  end;
end;

procedure TfSearchIcon.Button2Click(Sender: TObject);
var
  I: Integer;
  Ico: TIcon;
begin
  bShowIcon := False;
  imgList.Clear;
  FileIcon := nil;

  with DlgSearchIcon(Self, Ext, Path, CheckBox1.Checked) do
  begin
    SetLength(FileIcon, High(FIcon));
    Ico := TIcon.Create;
    for I := Low(FIcon) to Pred(High(FIcon)) do
    begin
      FileIcon[I].FileName := FIcon[I].FileName;
      FileIcon[I].Index := FIcon[I].Index;
      FileIcon[I].Category := FIcon[I].Category;
    end;
    Ico.Free;
    bShowIcon := True;
  end;
  StringGrid1.ColCount := nCol;
  StringGrid1.RowCount := Trunc((imgList.Count / StringGrid1.ColCount) + 1);
  StringGrid1.Refresh;
end;

procedure TfSearchIcon.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  Action := caFree;
end;

procedure TfSearchIcon.SpeedButton1Click(Sender: TObject);
var
  strFolder: String;
begin
  strFolder := SelectFolder(Handle, 'Selecione a pasta desejada:');
  if strFolder <> '' then
  begin
    if Copy(strFolder, Length(strFolder), Length(strFolder)) <> '\' then
    begin
      strFolder := strFolder + '\';
    end;
    Path := strFolder;
    Edit1.Text := Path;
  end;
end;

end.
