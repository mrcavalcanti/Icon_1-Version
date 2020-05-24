unit UnitTesteIcone;

interface

uses
    Windows, Forms, StdCtrls, RxCombos, Controls, ExtCtrls, Graphics, Classes,
    Messages;

//  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
//  StdCtrls, RxCombos, ExtCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ColorComboBox1: TColorComboBox;
    Button1: TButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label6: TLabel;
    Image6: TImage;
    imgFundo: TImage;

    procedure Button1Click(Sender: TObject);
    procedure ColorComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgFundoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgFundoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgFundoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    XOriginal, YOriginal: Integer;
    procedure WMEraseBkgnd(var m: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public declarations }
    Capturing: Bool;
    MouseX, MouseY: Integer;
    procedure CarregaImagem;
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}


// API utilizada para não permitir que a Image fique piscando
procedure TForm2.WMEraseBkgnd(var m : TWMEraseBkgnd);
begin
  m.Result := LRESULT(False);
end;


procedure TForm2.CarregaImagem;
begin
  ImgFundo.Canvas.Draw(0, 0, Image6.Picture.Graphic);
  ImgFundo.Canvas.Brush.Style := bsClear;
  ImgFundo.Canvas.Draw(25, 0, Image2.Picture.Graphic);
  ImgFundo.Canvas.TextOut(0, 33, Label2.Caption);
  ImgFundo.Canvas.Draw(25, 58, Image3.Picture.Graphic);
  ImgFundo.Canvas.TextOut(1, 92, Label3.Caption);
  ImgFundo.Canvas.Draw(25, 115, Image4.Picture.Graphic);
  ImgFundo.Canvas.TextOut(25, 149, Label4.Caption);
  ImgFundo.Canvas.Draw(108, 0, Image5.Picture.Graphic);
  ImgFundo.Canvas.TextOut(88, 33, Label5.Caption);
  ImgFundo.Canvas.Draw(MouseX, MouseY, Image1.Picture.Graphic);
  ImgFundo.Canvas.TextOut(MouseX - 14, MouseY + 34, Label6.Caption);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.ColorComboBox1Change(Sender: TObject);
begin
  Color := ColorComboBox1.ColorValue;
  Image6.Canvas.Pen.Color := clNone;
  Image6.Canvas.Pen.Style := psClear;
  Image6.Canvas.Brush.Color := Color;
  Image6.Canvas.Rectangle(Rect(0, 0, 389, 192));
  CarregaImagem;
  ImgFundo.Update;
  if Color = clBlack then
  begin
    Label2.Font.Color := clWhite;
    Label3.Font.Color := clWhite;
    Label4.Font.Color := clWhite;
    Label5.Font.Color := clWhite;
    Label6.Font.Color := clWhite;
  end
  else
  begin
    Label2.Font.Color := clBlack;
    Label3.Font.Color := clBlack;
    Label4.Font.Color := clBlack;
    Label5.Font.Color := clBlack;
    Label6.Font.Color := clBlack;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  MouseX := 108;
  MouseY := 58;
  Image2.Picture.Bitmap.TransparentColor := clWhite;
  CarregaImagem;
  ImgFundo.Update;
end;

procedure TForm2.imgFundoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Capturing := True;
  XOriginal := X - MouseX;
  YOriginal := Y - MouseY;
end;

procedure TForm2.imgFundoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Capturing then
  begin
    MouseX := X - XOriginal;
    MouseY := Y - YOriginal;
    CarregaImagem;
  end;
end;

procedure TForm2.imgFundoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Capturing := False;
  ImgFundo.Update;
end;

end.
