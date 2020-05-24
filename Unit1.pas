unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImgIconEdt, ColorGrd, ShellAPI, Buttons, ExtDlgs,
  Menus, Clipbrd, ComCtrls, ToolWin, ImgList, MccsPaletteColor, MccsAbout,
  jvIcon;

type
  TTools = (TTLapis, TTPincel, TTBrush, TTLimpar, TTGotas,
            TTQuadrado, TTCirculo, TTSpray, TTSelecao, TTZoom,
            TTLine);
  TPincel = (PEGrande, PEMedio, PEPeq, PRGrande, PRMedio, PRPeq);
  TPQuadrado = (TPPen, TPGeral, TPBrush);
  TPCirculo = (TPCPen, TPCGeral, TPCBrush);
  TSpray = (SGrande, SMedio, SPequeno);
  TTCursor = (TCBorracha, TCBrush, TCGota, TCLapis, TCPincel, TCSpray);
//  TSelecao = (SelecNormal, SelecPolig);

  TForm1 = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    Bevel1: TBevel;
    Opd: TOpenPictureDialog;
    Spd: TSavePictureDialog;
    PopupMenu1: TPopupMenu;
    OcultarGrid1: TMenuItem;
    ExibirGrid1: TMenuItem;
    PPincel: TPanel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    AbrirArquivo1: TMenuItem;
    SalvarComo1: TMenuItem;
    Sair1: TMenuItem;
    N1: TMenuItem;
    Sair2: TMenuItem;
    ScrollBox1: TScrollBox;
    ImgIconEditor1: TImgIconEditor;
    PZoom: TPanel;
    Bevel4: TBevel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Editar1: TMenuItem;
    Copiar1: TMenuItem;
    Colar1: TMenuItem;
    Sobre1: TMenuItem;
    SobreoSistema1: TMenuItem;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel2: TBevel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    PBranco: TPanel;
    Exibir1: TMenuItem;
    Testarcone1: TMenuItem;
    Novo1: TMenuItem;
    N2: TMenuItem;
    SpeedButton4: TSpeedButton;
    SpeedButton9: TSpeedButton;
    PQuadrado: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape10: TShape;
    PCirculo: TPanel;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    SpeedButton10: TSpeedButton;
    ToolButton4: TToolButton;
    PSpray: TPanel;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    SpeedButton11: TSpeedButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SpeedButton12: TSpeedButton;
    N3: TMenuItem;
    EfeitodeImagem1: TMenuItem;
    SpeedButton13: TSpeedButton;
    ColarSeleo1: TMenuItem;
    Panel5: TPanel;
    ImgIconEditor2: TImgIconEditor;
    ImageList1: TImageList;
    ListView1: TListView;
    Panel6: TPanel;
    ColorGrid2: TMccsPaletteColor;
    StatusBar1: TStatusBar;
    Panel4: TPanel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ILAjuda: TImageList;
    ILAnimal: TImageList;
    ILBandeira: TImageList;
    ILComputador: TImageList;
    ILComunicacao: TImageList;
    ILEmail: TImageList;
    ILEscrita: TImageList;
    ILEscritorio: TImageList;
    ILGrafico: TImageList;
    ILIndustria: TImageList;
    ILLixeira: TImageList;
    ILMiscelanea: TImageList;
    ILMultimidia: TImageList;
    ILNatureza: TImageList;
    ILProcurar: TImageList;
    ILRelatorio: TImageList;
    ILSeta: TImageList;
    ILTransito: TImageList;
    PProgress: TPanel;
    ILParamStr: TImageList;
    ProgressBar1: TProgressBar;
    MccsAbout1: TMccsAbout;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    Desfazer1: TMenuItem;
    N4: TMenuItem;
    Refazer1: TMenuItem;
    N5: TMenuItem;
    Pesquisarcones1: TMenuItem;
    procedure ImgIconEditor1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImgIconEditor1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImgIconEditor1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure OcultarGrid1Click(Sender: TObject);
    procedure ExibirGrid1Click(Sender: TObject);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AbrirArquivo1Click(Sender: TObject);
    procedure SalvarComo1Click(Sender: TObject);
    procedure ColorGrid2Change(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Colar1Click(Sender: TObject);
    procedure SobreoSistema1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Testarcone1Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Shape11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape13MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape14MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton10Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure ColarSeleo1Click(Sender: TObject);
    procedure ImgIconEditor2DblClick(Sender: TObject);
    procedure ImgIconEditor2MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImgIconEditor2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImgIconEditor2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ComboBox1Change(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure Desfazer1Click(Sender: TObject);
    procedure Pesquisarcones1Click(Sender: TObject);
  private
    { Private declarations }
      Dragging : Boolean;
      Tools : TTools;
      Pincel : TPincel;
      PreencherQuadrado : TPQuadrado;
      PreencherCirculo : TPCirculo;
//      Selecao : TSelecao;
      Spray : TSpray;
      TrocaCursor : TTCursor;
      XStart, YStart: Integer;
      fRect : TRect;
      NewBitmap : TBitmap;
      NewImageList : TImageList;
      ImgCache : array[1..100] of TImage;  // Copy 100 Image memory cache 

// Private do DropFile ListView
      Pic: TPicture;
      Fname : String;
      TempFile: array[0..255] of Char;
      Drop : THandle; {Handle for Msg.wParam}
      procedure WMDropFiles (var Msg: TMessage); message wm_DropFiles;

// Private
      procedure DefineIcone;
      procedure ConverteIcone(IconeStr: String);
      procedure BibliotecaIcone(TBiblioteca: TImageList);
      procedure StartCursor;
      procedure CopyCache; // Copy 100 Image memory cache

  public
    { Public declarations }
    MouseDownSpot: TPoint;
    Capturing: Bool;
  end;

var
  Form1: TForm1;

implementation

uses UnitTesteIcone, UnitEfeito, uSearchIcon;

{$R *.DFM}

const
Curs = 1;


procedure TForm1.WMDropFiles(var Msg: TMessage);
 var
   i,K,
   NumFiles, NameLength : integer;
   nIconsInFile : word;
   nTotal : word;
   NewItem: TListItem;
   Img: TBitmap;
 begin
  try
   screen.cursor := crHourglass;
   ImageList1.Clear;
   ListView1.Items.clear;
   Drop := Msg.wParam;
   nTotal := 0;
   ProgressBar1.Position := 0;
   {Query how many files were dropped on the app}
{$IFDEF WIN32}
   NumFiles := DragQueryFile(Msg.wParam, $FFFFFFFF, Nil, 0);
{$ELSE}
   NumFiles := DragQueryFile(Msg.wParam, $FFFF, Nil, 0);
{$ENDIF}
   for i := 0 to (NumFiles-1) do begin
     NameLength := DragQueryFile(Msg.wParam, i, Nil , 0);
     DragQueryFile(Msg.wParam, i, TempFile, NameLength+1);
     FName := StrPas(TempFile);
     { ShowMessage(FName);}

     {Query how many icons exist in the file (-1)}
{$IFDEF WIN32}
     nIconsInFile := ExtractIcon(HInstance, TempFile, $FFFFFFFF);
{$ELSE}
     nIconsInFile := ExtractIcon(HInstance, TempFile, $FFFF);
{$ENDIF}
     nTotal := nTotal + nIconsInFile;

     ProgressBar1.Max := nIconsInFile;
     PProgress.Visible := True;

       for K := 0 to nIconsInFile-1 do begin
         {Extract the icon}
         Icon.Handle := ExtractIcon(HInstance, TempFile, K);

         {Create a TPicture instance}
         Pic := TPicture.Create;
         {Assign the icon.handle to the Pic.icon property}
         Pic.Icon := Icon;

         {Add the Filename and icon to the ListView}
         begin
          ImageList1.AddIcon(Pic.Icon);
          ListView1.LargeImages := ImageList1;
          NewImageList := ImageList1;
          NewItem := ListView1.Items.Add;
          NewItem.Caption := '';
          NewItem.Caption := ExtractFileName(FName);
          NewItem.ImageIndex := K;
         end;

         if nIconsInFile <> 0 then
          begin
           ProgressBar1.Position := ProgressBar1.Position+1;
//           ProgressBar1.PaintTo(PProgress.Handle, 0, 0);
//           Provoca erro de Violação. Pois o mesmo faz parte de um "Panel" e, não
//           precisa do "PAINTTO", para desenhar o progresso da barra.
          end;
 //        Application.ProcessMessages;
       end;  {For K}

   end;  {For I}

   IF nTotal = 0 then
    begin
      StatusBar1.Panels[1].Text := 'Total de ícones: 0';
      Icon.Handle := Application.Icon.Handle;
    end
   ELSE
      StatusBar1.Panels[1].Text := 'Total de ícones: ' + IntToStr(nTotal);
      Icon.Handle := Application.Icon.Handle;
   finally
     screen.cursor := crDefault;
   end; {main begin}
     ProgressBar1.Position := 0;
//     ProgressBar1.PaintTo(PProgress.Handle, 0, 0);
//     Provoca erro de Violação. Pois o mesmo faz parte de um "Panel" e, não
//     precisa do "PAINTTO", para desenhar o progresso da barra.
     PProgress.Visible := False;

     Icon.Handle := 0;
     Img := TBitmap.Create;
     ImageList1.GetBitmap(0, Img);
     ImgIconEditor1.Bitmap := Img;
     ImgIconEditor1.Paint;
     DefineIcone;
     Img.Destroy;
end;  {WMDropFiles}


procedure TForm1.BibliotecaIcone(TBiblioteca: TImageList);
var
 NewItem: TListItem;
 I: Integer;
 Img: TBitmap;
begin
 if ListView1.Items.Count <> 0 then
  begin
   ListView1.Items.clear;
  end;
 ListView1.LargeImages := TBiblioteca;
 NewImageList := TBiblioteca;
 ProgressBar1.Max := NewImageList.Count - 1;
 ProgressBar1.Position := 0;
 PProgress.Visible := True;
 for I := 0 to NewImageList.Count - 1 do
  begin
   NewItem := ListView1.Items.Add;
   NewItem.Caption := '';
   NewItem.Caption := ComboBox1.Text;
   NewItem.ImageIndex := I;
   StatusBar1.Panels[1].Text := 'Total de ícones: ' + IntToStr(I + 1);
   ProgressBar1.Position := ProgressBar1.Position+1;
//   ProgressBar1.PaintTo(PProgress.Handle, 0, 0);
//   Provoca erro de Violação. Pois o mesmo faz parte de um "Panel" e, não
//   precisa do "PAINTTO", para desenhar o progresso da barra.
  end;
 ProgressBar1.Position := 0;
// ProgressBar1.PaintTo(PProgress.Handle, 0, 0);
//   Provoca erro de Violação. Pois o mesmo faz parte de um "Panel" e, não
//   precisa do "PAINTTO", para desenhar o progresso da barra.
 PProgress.Visible := False;
 Img := TBitmap.Create;
 NewImageList.GetBitmap(0, Img);
 ImgIconEditor1.Bitmap := Img;
 ImgIconEditor1.Paint;
 DefineIcone;
 Img.Destroy;
end;


procedure TForm1.StartCursor;
begin
  case TrocaCursor of
    TCBorracha : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Borracha1.cur');
        ImgIconEditor1.Cursor := Curs;
            end;

    TCBrush : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Brush1.cur');
        ImgIconEditor1.Cursor := Curs;
           end;

    TCGota : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Gota1.cur');
        ImgIconEditor1.Cursor := Curs;
            end;

    TCLapis : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Lapis1.cur');
        ImgIconEditor1.Cursor := Curs;
           end;

    TCPincel : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Pincel1.cur');
        ImgIconEditor1.Cursor := Curs;
            end;

    TCSpray : begin
        Screen.Cursors[Curs] := LoadCursorFromFile('Spray1.cur');
        ImgIconEditor1.Cursor := Curs;
           end;
   end;
end;


procedure TForm1.CopyCache;
var
I: Integer;
begin
 for i := Low(ImgCache) to High(ImgCache) do
  begin
   if ImgCache[i].Tag = 0 then
    begin
     ImgCache[i].Picture.Bitmap := ImgIconEditor1.Bitmap;
     ImgCache[i].Tag := 1;
     Break;
    end;
  end;
end;


procedure TForm1.DefineIcone;
var
Ico: TIcon;
begin
 ImgIconEditor1.Bitmap.Canvas.Pixels[0,0] := clWhite;
 ImgIconEditor1.Bitmap.SaveToFile('c:\windows\temp\iconedt.bmp');
 Ico := TIcon.Create;
 Ico.Handle := ExtractIcon(HInstance, Pchar('c:\windows\temp\iconedt.bmp'), 0);
 Ico.Transparent := True;
 Application.Icon := Ico;
 Image1.Picture.Icon := Ico;
 Ico.Free;
end;

procedure TForm1.ConverteIcone(IconeStr: String);
var
  Pic : TBitmap;
  TI : TIcon;
begin
  TI := TIcon.Create;
  Pic := TBitmap.Create;
  TI.LoadFromFile(IconeStr);
  Pic.Width := TI.Width;
  Pic.Height := TI.Height;
  Pic.Canvas.Draw(0, 0, TI);
  Image1.Picture.Bitmap := Pic;
  ImgIconEditor1.Bitmap := Pic;
  ImgIconEditor1.Paint;
  TI.Free;
  Pic.Free;
end;


procedure TForm1.ImgIconEditor1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
Cor: TColor;
begin
 XStart := X;
 YStart := Y;

 Case Button of
   mbLeft  : begin

 if Tools = TTLapis then
  begin
   ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
   ImgIconEditor1.Paint;
   DefineIcone;
  end;

 if Tools = TTBrush then
  begin
   Cor := ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y];
   ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
   ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
   ImgIconEditor1.Bitmap.Canvas.Pen.Color := clNone;
   ImgIconEditor1.Bitmap.Canvas.Pen.Style := psClear;
   ImgIconEditor1.Bitmap.Canvas.FloodFill(X, Y, Cor, fsSurface);
   ImgIconEditor1.Paint;
   DefineIcone;
  end;

 if Tools = TTPincel then
  begin
   if Pincel = PEGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 3, Y - 3, X + 3, Y + 3);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Pincel = PEMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 2, Y - 2, X + 2, Y + 2);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Pincel = PEPeq then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 1, Y - 1, X + 1, Y + 1);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Pincel = PRGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 3, Y - 3, X + 3, Y + 3);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Pincel = PRMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 2, Y - 2, X + 2, Y + 2);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Pincel = PRPeq then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 1, Y - 1, X + 1, Y + 1);
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
  end;


 if Tools = TTSpray then
  begin
   if Spray = SGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 4, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 4] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 4, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 4] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Spray = SMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Spray = SPequeno then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
  end;


 if Tools = TTGotas then
  begin
    Case Button of
      mbLeft  : begin
                 Case ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] of
                  clBlack   : ColorGrid2.ForegroundColor := clBlack;
                  clMaroon  : ColorGrid2.ForegroundColor := clMaroon;
                  clGreen   : ColorGrid2.ForegroundColor := clGreen;
                  clOlive   : ColorGrid2.ForegroundColor := clOlive;
                  clNavy    : ColorGrid2.ForegroundColor := clNavy;
                  clPurple  : ColorGrid2.ForegroundColor := clPurple;
                  clTeal    : ColorGrid2.ForegroundColor := clTeal;
                  clGray    : ColorGrid2.ForegroundColor := clGray;
                  clSilver  : ColorGrid2.ForegroundColor := clSilver;
                  clRed     : ColorGrid2.ForegroundColor := clRed;
                  clLime    : ColorGrid2.ForegroundColor := clLime;
                  clYellow  : ColorGrid2.ForegroundColor := clYellow;
                  clBlue    : ColorGrid2.ForegroundColor := clBlue;
                  clFuchsia : ColorGrid2.ForegroundColor := clFuchsia;
                  clAqua    : ColorGrid2.ForegroundColor := clAqua;
                  clWhite   : ColorGrid2.ForegroundColor := clWhite;
                 else
                 ColorGrid2.ForegroundColor := ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y];
                 end;
               end;

      mbRight : ColorGrid2.ForegroundColor := ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y];
    Else
      Exit;
    end;
  end;

 end
 else
  Exit;
 end;

 Dragging := True;

 
 fRect.Left := x * ImgIconEditor1.PixelSize;
 fRect.Top := y * ImgIconEditor1.PixelSize;
 fRect.BottomRight := fRect.TopLeft;
 ImgIconEditor1.Canvas.DrawFocusRect(fRect);

 CopyCache;
end;

procedure TForm1.ImgIconEditor1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if not Dragging then
  Exit;


 if Tools = TTLapis then
  begin
   DefineIcone;
   ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
   ImgIconEditor1.Paint;
  end;

  

 if Tools = TTSpray then
  begin
   if Spray = SGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 4, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 4] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 4, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 4] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Spray = SMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X - 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y - 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
   if Spray = SPequeno then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X + 2, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y + 2] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
     DefineIcone;
    end;
  end;



 if Tools = TTQuadrado then
  begin
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
   fRect.Right := X * ImgIconEditor1.PixelSize;
   fRect.Bottom := Y * ImgIconEditor1.PixelSize;
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
  end;

 if Tools = TTCirculo then
  begin
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
   fRect.Right := X * ImgIconEditor1.PixelSize;
   fRect.Bottom := Y * ImgIconEditor1.PixelSize;
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
  end;

 if Tools = TTLine then
  begin
   ImgIconEditor1.Paint;
   ImgIconEditor1.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
   ImgIconEditor1.Canvas.Pen.Style := psSolid;
   ImgIconEditor1.Canvas.Brush.Color := clNone;
   ImgIconEditor1.Canvas.Brush.Style := bsClear;
   ImgIconEditor1.Canvas.MoveTo(XStart * ImgIconEditor1.PixelSize, YStart * ImgIconEditor1.PixelSize);
   ImgIconEditor1.Canvas.LineTo(X * ImgIconEditor1.PixelSize, Y * ImgIconEditor1.PixelSize);
 //  ImgIconEditor1.Paint;
  end;

 if Tools = TTSelecao then
  begin
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
   fRect.Right := X * ImgIconEditor1.PixelSize;
   fRect.Bottom := Y * ImgIconEditor1.PixelSize;
   ImgIconEditor1.Canvas.DrawFocusRect(fRect);
  end;

 if Tools = TTPincel then
  begin
   if Pincel = PEGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 3, Y - 3, X + 3, Y + 3);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
   if Pincel = PEMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 2, Y - 2, X + 2, Y + 2);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
   if Pincel = PEPeq then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Ellipse (X - 1, Y - 1, X + 1, Y + 1);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
   if Pincel = PRGrande then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 3, Y - 3, X + 3, Y + 3);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
   if Pincel = PRMedio then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 2, Y - 2, X + 2, Y + 2);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
   if Pincel = PRPeq then
    begin
     ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
     ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
     ImgIconEditor1.Bitmap.Canvas.Rectangle (X - 1, Y - 1, X + 1, Y + 1);
     DefineIcone;
     ImgIconEditor1.Bitmap.Canvas.Pixels [X, Y] := ColorGrid2.ForegroundColor;
     ImgIconEditor1.Paint;
    end;
  end;

end;

procedure TForm1.ImgIconEditor1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
NewI: TRect;
begin
 Case Button of
  mbLeft  : begin

            if Tools = TTGotas then
             begin
              SpeedButton1.Down := True;
              SpeedButton1.OnClick(nil);
             end;

            if Tools = TTLine then
             begin
              ImgIconEditor1.Bitmap.Canvas.Brush.Color := clNone;
              ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsClear;
              ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
              ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
              ImgIconEditor1.Bitmap.Canvas.MoveTo(XStart, YStart);
              ImgIconEditor1.Bitmap.Canvas.LineTo(X, Y);
              DefineIcone;
              ImgIconEditor1.Paint;
             end;

            if Tools = TTQuadrado then
             begin
              if PreencherQuadrado = TPGeral then
               begin
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
                ImgIconEditor1.Bitmap.Canvas.Rectangle(XStart, YStart, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
               end;
              if PreencherQuadrado = TPPen then
               begin
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := clNone;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsClear;
                ImgIconEditor1.Bitmap.Canvas.Rectangle(XStart, YStart, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
               end;
              if PreencherQuadrado = TPBrush then
               begin
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := clNone;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psClear;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
                ImgIconEditor1.Bitmap.Canvas.Rectangle(XStart + 1, YStart + 1, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
               end;
             end;


            if Tools = TTCirculo then
             begin
              if PreencherCirculo = TPCGeral then
               begin
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
                ImgIconEditor1.Bitmap.Canvas.Ellipse(XStart, YStart, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := clNone;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := clNone;
               end;
              if PreencherCirculo = TPCPen then
               begin
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psSolid;
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := clNone;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsClear;
                ImgIconEditor1.Bitmap.Canvas.Ellipse(XStart, YStart, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
               end;
              if PreencherCirculo = TPCBrush then
               begin
                ImgIconEditor1.Bitmap.Canvas.Brush.Color := ColorGrid2.ForegroundColor;
                ImgIconEditor1.Bitmap.Canvas.Brush.Style := bsSolid;
                ImgIconEditor1.Bitmap.Canvas.Pen.Color := clNone;
                ImgIconEditor1.Bitmap.Canvas.Pen.Style := psClear;
                ImgIconEditor1.Bitmap.Canvas.Ellipse(XStart + 1, YStart + 1, X, Y);
                DefineIcone;
                ImgIconEditor1.Paint;
               end;
             end;

             if Tools = TTSelecao then
              begin
               NewBitmap := TBitmap.Create;
               NewBitmap.Height := Y - YStart;
               NewBitmap.Width := X - XStart;

               NewI := Rect(XStart, YStart, X, Y);
               NewBitmap.Canvas.CopyRect(Rect(0,0,X,Y),ImgIconEditor1.Bitmap.Canvas, NewI);
               ImgIconEditor2.Bitmap := NewBitmap;
               DefineIcone;
               SpeedButton1.Down := True;
               SpeedButton1.OnClick(nil);
              end;


//            if ImgIconEditor1.Bitmap.Canvas.Pixels [0, 0] <> clWhite then
//             begin
//              ImgIconEditor1.Bitmap.Canvas.Pixels [0, 0] := clWhite;
//             end;

            end;

 end;
  Dragging := False;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Tools := TTLapis;
 TrocaCursor := TCLapis;
 StartCursor;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 Tools := TTPincel;
 TrocaCursor := TCPincel;
 StartCursor;
 Pincel := PEGrande;
 PBranco.Visible := False;
 PPincel.Visible := True;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
 Shape4.Brush.Color := clGray;
 Shape5.Brush.Color := clWhite;
 Shape6.Brush.Color := clWhite;
 Shape7.Brush.Color := clWhite;
 Shape8.Brush.Color := clWhite;
 Shape9.Brush.Color := clWhite;
end;

procedure TForm1.OcultarGrid1Click(Sender: TObject);
begin
 OcultarGrid1.Checked := True;
 ImgIconEditor1.ShowGrid := False;
 ExibirGrid1.Checked := False;
end;

procedure TForm1.ExibirGrid1Click(Sender: TObject);
begin
 ExibirGrid1.Checked := True;
 ImgIconEditor1.ShowGrid := True;
 OcultarGrid1.Checked := False;
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PEGrande;
Shape4.Brush.Color := clGray;
Shape5.Brush.Color := clWhite;
Shape6.Brush.Color := clWhite;
Shape7.Brush.Color := clWhite;
Shape8.Brush.Color := clWhite;
Shape9.Brush.Color := clWhite;
end;

procedure TForm1.Shape5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PEMedio;
Shape4.Brush.Color := clWhite;
Shape5.Brush.Color := clGray;
Shape6.Brush.Color := clWhite;
Shape7.Brush.Color := clWhite;
Shape8.Brush.Color := clWhite;
Shape9.Brush.Color := clWhite;
end;

procedure TForm1.Shape6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PEPeq;
Shape4.Brush.Color := clWhite;
Shape5.Brush.Color := clWhite;
Shape6.Brush.Color := clGray;
Shape7.Brush.Color := clWhite;
Shape8.Brush.Color := clWhite;
Shape9.Brush.Color := clWhite;
end;

procedure TForm1.Shape7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PRGrande;
Shape4.Brush.Color := clWhite;
Shape5.Brush.Color := clWhite;
Shape6.Brush.Color := clWhite;
Shape7.Brush.Color := clGray;
Shape8.Brush.Color := clWhite;
Shape9.Brush.Color := clWhite;
end;

procedure TForm1.Shape8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PRMedio;
Shape4.Brush.Color := clWhite;
Shape5.Brush.Color := clWhite;
Shape6.Brush.Color := clWhite;
Shape7.Brush.Color := clWhite;
Shape8.Brush.Color := clGray;
Shape9.Brush.Color := clWhite;
end;

procedure TForm1.Shape9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Pincel := PRPeq;
Shape4.Brush.Color := clWhite;
Shape5.Brush.Color := clWhite;
Shape6.Brush.Color := clWhite;
Shape7.Brush.Color := clWhite;
Shape8.Brush.Color := clWhite;
Shape9.Brush.Color := clGray;
end;

procedure TForm1.AbrirArquivo1Click(Sender: TObject);
var
ExtStr: String;
BImg: TBitmap;
begin
 if Opd.Execute then
  ExtStr := ExtractFileExt(Opd.FileName);
   if ExtStr = '.bmp' then
    begin
     BImg := TBitmap.Create;
     BImg.LoadFromFile (Opd.FileName);
     if (BImg.Width <= 32) and (BImg.Height <= 32) then
      begin
//       Image1.Picture.LoadFromFile (Opd.FileName);
       Image1.Transparent := False;
       Image1.Picture.Bitmap := BImg;
       ImgIconEditor1.Bitmap.FreeImage;

       ImgIconEditor1.Bitmap := Image1.Picture.Bitmap;
       ImgIconEditor1.Paint;
       Image1.Transparent := True;
       ImgIconEditor1.RecalcSize;

       Image1.Picture.SaveToFile('c:\windows\temp\iconedt.bmp');
       Image1.Picture.Icon.Handle := ExtractIcon(HInstance, Pchar('c:\windows\temp\iconedt.bmp'), 0);
       BImg.Free;
      end
      else
      begin
       MessageDlg('A imagem selecionada, não poderá ser utilizada para a produção de um ícone.' + #13#10 + 'Ela ultrapassa o tamanho de 32x32 pixels.',
       mtError, [mbOk], 0);
       AbrirArquivo1.OnClick(nil);
      end;

    end;

   if ExtStr = '.ico' then
    begin
     ConverteIcone(Opd.Filename);
     Image1.Picture.SaveToFile('c:\windows\temp\iconedt.bmp');
     Image1.Picture.Icon.Handle := ExtractIcon(HInstance, Pchar('c:\windows\temp\iconedt.bmp'), 0);
    end;
end;

procedure TForm1.SalvarComo1Click(Sender: TObject);
var
  jv: TjvIcon;

  function BitmapToIcon(Bitmap: TBitmap): TIcon;
  var
    IconSizeX, IconSizeY : integer;
    IconInfo: TIconInfo;
    IconBitmap, MaskBitmap: TBitmap;
    x, y: Integer;
    TransparentColor: TColor;
  begin
    IconSizeX := GetSystemMetrics(SM_CXICON);
    IconSizeY := GetSystemMetrics(SM_CYICON);
    IconBitmap:= TBitmap.Create;
    IconBitmap.PixelFormat := pf24bit;
    IconBitmap.Width:= IconSizeX;
    IconBitmap.Height:= IconSizeY;
    IconBitmap.Canvas.StretchDraw(Rect(0, 0, IconSizeX, IconSizeY), Bitmap);
    IconBitmap.TransparentColor:= Bitmap.TransparentColor;
    TransparentColor:= IconBitmap.TransparentColor and $FFFFFF;
    MaskBitmap:= TBitmap.Create;
    MaskBitmap.PixelFormat := pf24bit;     
    MaskBitmap.Assign(IconBitmap);
    for y:= 0 to IconSizeY - 1 do
      for x:= 0 to IconSizeX - 1 do
        if IconBitmap.Canvas.Pixels[x, y] = TransparentColor then
          IconBitmap.Canvas.Pixels[x, y]:= clBlack;
    IconInfo.fIcon:= True;
    IconInfo.hbmMask:= MaskBitmap.MaskHandle;
    IconInfo.hbmColor:= IconBitmap.Handle;
    Result:= TIcon.Create;
    Result.Handle:= CreateIconIndirect(IconInfo);
    MaskBitmap.Free;
    IconBitmap.Free;
  end;
  
begin
 if Spd.Execute then
  if ExtractFileExt(Spd.FileName)  = '.bmp' then
   begin
    ImgIconEditor1.Bitmap.SaveToFile(Spd.FileName);
   end
   else
   begin
    jv := TjvIcon.Create(Self);
    jv.SaveToFileIcon256(BitmapToIcon(ImgIconEditor1.Bitmap), Spd.FileName);
    jv.Free;
   end;
end;

procedure TForm1.ColorGrid2Change(Sender: TObject);
begin
// ColorGrid2.ForegroundColor := ColorGrid2.ForegroundColor;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
 Tools := TTGotas;
 TrocaCursor := TCGota;
 StartCursor;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
 Tools := TTZoom;
 ImgIconEditor1.Cursor := crDefault;
 PBranco.Visible := False;
 PPincel.Visible := False;
 PZoom.Visible := True;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
 if ImgIconEditor1.PixelSize < 15 then
  begin
   ImgIconEditor1.PixelSize := ImgIconEditor1.PixelSize + 1;
  end
  else
  begin
  ImgIconEditor1.PixelSize := 15;
  end;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
 if ImgIconEditor1.PixelSize > 5 then
  begin
   ImgIconEditor1.PixelSize := ImgIconEditor1.PixelSize - 1;
  end
  else
  begin
  ImgIconEditor1.PixelSize := 5;
  end;
end;

procedure TForm1.Copiar1Click(Sender: TObject);
begin
Clipboard.Assign(ImgIconEditor1.Bitmap);
//Clipboard.Assign(ImgIconEditor2.Bitmap);
end;

procedure TForm1.Colar1Click(Sender: TObject);
begin
ImgIconEditor1.Bitmap.Assign(Clipboard);
ImgIconEditor1.RecalcSize;
ImgIconEditor1.Paint;
DefineIcone;
end;

procedure TForm1.SobreoSistema1Click(Sender: TObject);
begin
 MccsAbout1.Execute;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DeleteFile('c:\windows\temp\iconedt.bmp');
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
 TrocaCursor := TCBorracha;
 StartCursor;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
 with ImgIconEditor1 do
  begin
   Bitmap.Canvas.Pen.Color := clWhite;
   Bitmap.Canvas.Brush.Color := clWhite;
   Bitmap.Canvas.Rectangle(0, 0, 32, 32);
   Paint;
   DefineIcone;
  end;
 SpeedButton1.Down := True;
 SpeedButton1.OnClick(nil);
end;

procedure TForm1.Testarcone1Click(Sender: TObject);
begin
 ImgIconEditor1.Cursor := crDefault;
 Form2.Image1.Picture.Assign(nil);
 Form2.Image1.Picture.Icon := Image1.Picture.Icon;
 Form2.MouseX := 108;
 Form2.MouseY := 58;
 Form2.carregaImagem;
 Form2.ColorComboBox1.ColorValue := clWhite;
 Form2.ShowModal;
 SpeedButton1.Down := True;
 SpeedButton1.OnClick(nil);
end;

procedure TForm1.Novo1Click(Sender: TObject);
begin
SpeedButton3.OnClick(nil);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
 Tools := TTQuadrado;
 ImgIconEditor1.Cursor := crDefault;
 PreencherQuadrado := TPGeral;
 Shape1.Brush.Color := clGray;
 Shape3.Brush.Color := clBtnFace;
 Shape10.Brush.Color := clWhite;
 PBranco.Visible := False;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := True;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherQuadrado := TPGeral;
Shape1.Brush.Color := clGray;
Shape3.Brush.Color := clBtnFace;
Shape10.Brush.Color := clWhite;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherQuadrado := TPPen;
Shape1.Brush.Color := clWhite;
Shape3.Brush.Color := clGray;
Shape10.Brush.Color := clWhite;
end;

procedure TForm1.Shape10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherQuadrado := TPBrush;
Shape1.Brush.Color := clWhite;
Shape3.Brush.Color := clBtnFace;
Shape10.Brush.Color := clGray;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
 Tools := TTCirculo;
 ImgIconEditor1.Cursor := crDefault;
 PreencherCirculo := TPCGeral;
 Shape11.Brush.Color := clGray;
 Shape13.Brush.Color := clBtnFace;
 Shape14.Brush.Color := clWhite;
 PBranco.Visible := False;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := True;
 PSpray.Visible := False;
end;

procedure TForm1.Shape11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherCirculo := TPCGeral;
Shape11.Brush.Color := clGray;
Shape13.Brush.Color := clBtnFace;
Shape14.Brush.Color := clWhite;
end;

procedure TForm1.Shape13MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherCirculo := TPCPen;
Shape11.Brush.Color := clWhite;
Shape13.Brush.Color := clGray;
Shape14.Brush.Color := clWhite;
end;

procedure TForm1.Shape14MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
PreencherCirculo := TPCBrush;
Shape11.Brush.Color := clWhite;
Shape13.Brush.Color := clBtnFace;
Shape14.Brush.Color := clGray;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
 Tools := TTSpray;
 TrocaCursor := TCSpray;
 StartCursor;
 Spray := SPequeno;
 Shape15.Brush.Color := clWhite;
 Shape16.Brush.Color := clWhite;
 Shape17.Brush.Color := clGray;
 PBranco.Visible := False;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := True;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
 Tools := TTSpray;
 Spray := SGrande;
 Shape15.Brush.Color := clGray;
 Shape16.Brush.Color := clWhite;
 Shape17.Brush.Color := clWhite;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
 Tools := TTSpray;
 Spray := SMedio;
 Shape15.Brush.Color := clWhite;
 Shape16.Brush.Color := clGray;
 Shape17.Brush.Color := clWhite;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
 Tools := TTSpray;
 Spray := SPequeno;
 Shape15.Brush.Color := clWhite;
 Shape16.Brush.Color := clWhite;
 Shape17.Brush.Color := clGray;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
 ImgIconEditor1.Cursor := crDefault;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
 Form3.Image1.Picture.Bitmap := ImgIconEditor1.Bitmap;
 Form3.ImagePrincipal.Picture.Bitmap := ImgIconEditor1.Bitmap;
 Form3.ShowModal;
 SpeedButton1.Down := True;
 SpeedButton1.OnClick(nil);
 DefineIcone;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
 Tools := TTSelecao;
 ImgIconEditor1.Cursor := crDefault;
end;

procedure TForm1.ColarSeleo1Click(Sender: TObject);
begin
 ImgIconEditor2.PixelSize := ImgIconEditor1.PixelSize;
 Panel5.Visible := True;
end;

procedure TForm1.ImgIconEditor2DblClick(Sender: TObject);
var
Rec, Rec1: TRect;
begin
Rec := Rect((0 + Panel5.Left) - 3 ,(0 + Panel5.Top) - 3,
 (Panel5.Width + Panel5.Left) - 3,
 (Panel5.Height + Panel5.Top) - 3);
Rec1 := Rect(0,0,ImgIconEditor2.Width, ImgIconEditor2.Height);

//ImgIconEditor1.Canvas.CopyRect(Rec,ImgIconEditor2.Bitmap.canvas,Rec1);
ImgIconEditor1.Bitmap.Canvas.BrushCopy(Rec,ImgIconEditor2.Bitmap,Rec1,clWhite);
//DefineIcone;
ImgIconEditor1.Paint;
Panel5.Visible := False;
end;

procedure TForm1.ImgIconEditor2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 Capturing := True;
 MouseDownSpot.x := x;
 MouseDownSpot.y := y;
end;

procedure TForm1.ImgIconEditor2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if Capturing then begin
  Panel5.Left:= Panel5.Left-(MouseDownSpot.x-x);
  Panel5.Top:= Panel5.Top - (MouseDownSpot.y-y);
 end;
end;

procedure TForm1.ImgIconEditor2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Capturing then begin
  ReleaseCapture;
  Capturing := False;
  Panel5.Left:= Panel5.Left-(MouseDownSpot.x-x);
  Panel5.Top:= Panel5.Top - (MouseDownSpot.y-y);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
i: Integer;
begin
// Para arrastar imagem DragDrop
 DragAcceptFiles(Handle, True);
 Icon := TIcon.Create;
// Para colocar o pprogress na barra de status
 PProgress.Parent := StatusBar1;
 PProgress.SetBounds(120,3,StatusBar1.Panels[0].Width - 128,StatusBar1.Height - 4);
// Para trocar o cursor
 TrocaCursor := TCLapis;
 StartCursor;
// Para criar o copy memory cache
 for i := Low(ImgCache) to High(ImgCache) do
  begin
   ImgCache[i] := TImage.Create (Self);
   ImgCache[i].Picture.Bitmap.Assign(nil);
   ImgCache[i].Tag := 0;
  end;
 ImgCache[1].Picture.Bitmap := ImgIconEditor1.Bitmap;
 ImgCache[1].Tag := 1;
end;

procedure TForm1.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
IMove: Integer;
Img: TBitmap;
begin
 Img := TBitmap.Create;
 if ListView1.Selected <> nil then
  begin
   IMove := ListView1.Selected.Index;
   ImgIconEditor1.Bitmap.FreeImage;
//   ImageList1.GetBitmap(IMove, Img);
   NewImageList.GetBitmap(IMove, Img);
   ImgIconEditor1.Bitmap := Img;
   ImgIconEditor1.Paint;
   DefineIcone;
  end;
  Img.Destroy;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 case ComboBox1.ItemIndex of
  0 : BibliotecaIcone(ILAjuda);
  1 : BibliotecaIcone(ILAnimal);
  2 : BibliotecaIcone(ILBandeira);
  3 : BibliotecaIcone(ILComputador);
  4 : BibliotecaIcone(ILComunicacao);
  5 : BibliotecaIcone(ILEmail);
  6 : BibliotecaIcone(ILEscrita);
  7 : BibliotecaIcone(ILEscritorio);
  8 : BibliotecaIcone(ILGrafico);
  9 : BibliotecaIcone(ILIndustria);
  10 : BibliotecaIcone(ILLixeira);
  11 : BibliotecaIcone(ILMiscelanea);
  12 : BibliotecaIcone(ILMultimidia);
  13 : BibliotecaIcone(ILNatureza);
  14 : BibliotecaIcone(ILProcurar);
  15 : BibliotecaIcone(ILRelatorio);
  16 : BibliotecaIcone(ILSeta);
  17 : BibliotecaIcone(ILTransito);

 end;
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
 PProgress.DrawTextBiDiModeFlagsReadingOnly;
end;

procedure TForm1.FormShow(Sender: TObject);
var
 LoadFile, FileExt: String;
 Count, I: Integer;
 NewItem: TListItem;
 Img: TBitmap;
 Ico: TIcon;
begin
  if ParamCount >= 1 then
  begin
  Img := TBitmap.Create;
  Ico := TIcon.Create;
  I := 1;
   for Count := 0 to ParamCount - I do
    begin
     LoadFile := ParamStr(Count + 1);
     FileExt := LowerCase (ExtractFileExt(LoadFile));
     if FileExt = '.bmp' then
      begin
       Img.LoadFromFile(LoadFile);
       ILParamStr.Add(Img, Img);
       ListView1.LargeImages := ILParamStr;
       NewImageList := ILParamStr;
       NewItem := ListView1.Items.Add;
       NewItem.Caption := '';
       NewItem.Caption := ExtractFileName(LoadFile);
       NewItem.ImageIndex := Count;
       ImgIconEditor1.Bitmap.FreeImage;
      end
      else
      if FileExt = '.ico' then
      begin
       Ico.LoadFromFile(LoadFile);
       ILParamStr.AddIcon(Ico);
       ListView1.LargeImages := ILParamStr;
       NewImageList := ILParamStr;
       NewItem := ListView1.Items.Add;
       NewItem.Caption := '';
       NewItem.Caption := ExtractFileName(LoadFile);
       NewItem.ImageIndex := Count;
       ImgIconEditor1.Bitmap.FreeImage;
      end
      else
      begin
       MessageDlg(LoadFile + ', não é um arquivo de imagem válido.' + #13#10#13 + 'O programa será finalizado.',
       mtError, [mbOk],0);
       Application.Terminate;
      end;
    end;
    ImgIconEditor1.Bitmap.FreeImage;
    ILParamStr.GetBitmap(0, Img);
    ImgIconEditor1.Bitmap := Img;
    ImgIconEditor1.Paint;
    DefineIcone;
    Img.Destroy;
    Ico.Destroy;
  end;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
 Tools := TTBrush;
 TrocaCursor := TCBrush;
 StartCursor;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
 Tools := TTLine;
 ImgIconEditor1.Cursor := crDefault;
 PBranco.Visible := True;
 PPincel.Visible := False;
 PZoom.Visible := False;
 PQuadrado.Visible := False;
 PCirculo.Visible := False;
 PSpray.Visible := False;
end;

procedure TForm1.Desfazer1Click(Sender: TObject);
var
A, B: Integer;
begin
 for a := Low(ImgCache) to High(ImgCache) do
  if ImgCache[a].Tag = 0 then
   begin
    b := a - 1;
    if b <= 1 then
     begin
      ImgIconEditor1.Bitmap := ImgCache[1].Picture.Bitmap;
      ImgIconEditor1.Paint;
      DefineIcone;
     end
     else
     begin
      ImgIconEditor1.Bitmap := ImgCache[b - 1].Picture.Bitmap;
      ImgIconEditor1.Paint;
      DefineIcone;
      ImgCache[b].Tag := 0;
      Break;
     end;
   end;

end;

procedure TForm1.Pesquisarcones1Click(Sender: TObject);
begin
//  SearchIcon(Self);
  fSearchIcon.ShowModal;
end;

end.
