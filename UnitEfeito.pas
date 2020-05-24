unit UnitEfeito;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ColorGrd, RxCombos;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    PCorSel: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    ColorComboBox1: TColorComboBox;
    Label3: TLabel;
    ImagePrincipal: TImage;
    PVazio: TPanel;
    PTons: TPanel;
    Label4: TLabel;
    ColorComboBox2: TColorComboBox;
    PEspelho: TPanel;
    Label5: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Label6: TLabel;
    R1: TRadioButton;
    R2: TRadioButton;
    R3: TRadioButton;
    R4: TRadioButton;
    PListra: TPanel;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Label7: TLabel;
    RT1: TRadioButton;
    RT2: TRadioButton;
    RT3: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
var
i, j: Integer;
Bmp: TBitmap;
Line: PByteArray;
H, W, RH, RW: Integer;
RecPaste, RecPaste1,
RecPaste2, RecPaste3,
RecCopy, RecCopy1,
RecCopy2, RecCopy3: TRect;
begin
 Bmp := ImagePrincipal.Picture.Bitmap;

 if ListBox1.ItemIndex = 0 then
  begin
   for i := 0 to Bmp.Width do
    for j := 0 to Bmp.Height do
     if Bmp.Canvas.Pixels[i,j] = Shape1.Brush.Color then
      begin
       Bmp.Canvas.Pixels[i,j] := ColorComboBox1.ColorValue;
      end;
   Image2.Picture.Bitmap := Bmp;
   Bmp.FreeImage;
   ImagePrincipal.Picture.Bitmap.FreeImage;
   ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

 if ListBox1.ItemIndex = 1 then
  begin
   for i := 0 to Bmp.Width do
    for j := 0 to Bmp.Height do
     Bmp.Canvas.Pixels[i,j] := Bmp.Canvas.Pixels[i,j] xor $00ffffff;
     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

 if ListBox1.ItemIndex = 2 then
  begin
   Bmp.Monochrome := True;
   Image2.Picture.Bitmap := Bmp;
   Bmp.FreeImage;
   ImagePrincipal.Picture.Bitmap.FreeImage;
   ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

 if ListBox1.ItemIndex = 3 then
  begin

   Bmp.Height := Image1.Height;
   Bmp.Width := Image1.Width;

   Bmp := Image1.Picture.Bitmap;

   RecPaste := Rect(0, 0, Image1.Width div 2, Image1.Height div 2);
   RecCopy := Rect(Image1.Width div 2, Image1.Height div 2, Image1.Width, Image1.Height);
   Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);


   RecPaste1 := Rect(Image1.Width div 2, 0, Image1.Width, Image1.Height div 2);
   RecCopy1 := Rect(0, Image1.Height div 2, Image1.Width div 2, Image1.Height);
   Bmp.Canvas.CopyRect(RecPaste1, ImagePrincipal.Canvas, RecCopy1);

   RecPaste2 := Rect(0, Image1.Height div 2, Image1.Width div 2, Image1.Height);
   RecCopy2 := Rect(Image1.Width div 2, 0, Image1.Width, Image1.Height div 2);
   Bmp.Canvas.CopyRect(RecPaste2, ImagePrincipal.Canvas, RecCopy2);

   RecPaste3 := Rect(Image1.Width div 2, Image1.Height div 2, Image1.Width, Image1.Height);
   RecCopy3 := Rect(0, 0, Image1.Width div 2, Image1.Height div 2);
   Bmp.Canvas.CopyRect(RecPaste3, ImagePrincipal.Canvas, RecCopy3);

   Image2.Picture.Bitmap := Bmp;
   Bmp.FreeImage;
   ImagePrincipal.Picture.Bitmap.FreeImage;
   ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
   Image1.Picture.Bitmap.FreeImage;
   Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

 if ListBox1.ItemIndex = 4 then
  begin
   for i := 0 to Bmp.Width do
    for j := 0 to Bmp.Height do
     Bmp.Canvas.Pixels[i,j] := Bmp.Canvas.Pixels[i,j] or ColorComboBox2.ColorValue;
     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

 if ListBox1.ItemIndex = 5 then
  begin
   if R1.Checked then
    begin
     Bmp.Height := Image1.Height;
     Bmp.Width := Image1.Width;
     Bmp := Image1.Picture.Bitmap;
     RecCopy := Rect(0, 0, Image1.Width, Image1.Height div 2);
     RecPaste := Rect(0, Image1.Height, Image1.Width, Image1.Height div 2);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
     Image1.Picture.Bitmap.FreeImage;
     Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
   if R2.Checked then
    begin
     Bmp.Height := Image1.Height;
     Bmp.Width := Image1.Width;
     Bmp := Image1.Picture.Bitmap;
     RecCopy := Rect(0, 0, Image1.Width div 2, Image1.Height);
     RecPaste := Rect(Image1.Width, 0, Image1.Width div 2, Image1.Height);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
     Image1.Picture.Bitmap.FreeImage;
     Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
   if R3.Checked then
    begin
     Bmp.Height := Image1.Height;
     Bmp.Width := Image1.Width;
     Bmp := Image1.Picture.Bitmap;
     RecCopy := Rect(0, 0, Image1.Width, Image1.Height);
     RecPaste := Rect(0, 0, Image1.Width, (Image1.Height div 2) + 1);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     RecCopy := Rect(0, 0, Image1.Width, Image1.Height);
     RecPaste := Rect(0, Image1.Height, Image1.Width, (Image1.Height div 2) -1);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
     Image1.Picture.Bitmap.FreeImage;
     Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
   if R4.Checked then
    begin
     Bmp.Height := Image1.Height;
     Bmp.Width := Image1.Width;
     Bmp := Image1.Picture.Bitmap;
     RecCopy := Rect(0, 0, Image1.Width, Image1.Height);
     RecPaste := Rect(0, 0, (Image1.Width div 2) + 1, Image1.Height);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     RecCopy := Rect(0, 0, Image1.Width, Image1.Height);
     RecPaste := Rect(Image1.Width, 0, (Image1.Width div 2) - 1, Image1.Height);
     Bmp.Canvas.CopyRect(RecPaste, ImagePrincipal.Canvas, RecCopy);

     Image2.Picture.Bitmap := Bmp;
     Bmp.FreeImage;
     ImagePrincipal.Picture.Bitmap.FreeImage;
     ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
     Image1.Picture.Bitmap.FreeImage;
     Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
  end;

 if ListBox1.ItemIndex = 6 then
  begin
   if RT1.Checked then
    begin
     for W := 0 to Image1.Width do
      begin
       RW := W;
      for H := 0 to Image1.Height do
       begin
        RH := H * 2;
        ImagePrincipal.Canvas.Pixels[RW, RH] := Image2.Canvas.Pixels[RW, RH] or $ffffff;
       end;
      end;
    Image2.Picture.Bitmap := ImagePrincipal.Picture.Bitmap;
    ImagePrincipal.Picture.Bitmap.FreeImage;
    ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
   if RT2.Checked then
    begin
     for W := 0 to Image1.Width do
      begin
       RW := W * 2;
       for H := 0 to Image1.Height do
        begin
         RH := H;
         ImagePrincipal.Canvas.Pixels[RW, RH] := Image2.Canvas.Pixels[RW, RH] or $ffffff;
        end;
      end;
    Image2.Picture.Bitmap := ImagePrincipal.Picture.Bitmap;
    ImagePrincipal.Picture.Bitmap.FreeImage;
    ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
   if RT3.Checked then
    begin
     for W := 0 to Image1.Width do
      begin
       RW := W * 2;
       for H := 0 to Image1.Height do
       begin
        RH := H * 2;
        ImagePrincipal.Canvas.Pixels[RW, RH] := Image2.Canvas.Pixels[RW, RH] or $ffffff;
       end;
      end;
    Image2.Picture.Bitmap := ImagePrincipal.Picture.Bitmap;
    ImagePrincipal.Picture.Bitmap.FreeImage;
    ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
    end;
  end;

 if ListBox1.ItemIndex = 7 then
  begin
   Bmp := Image1.Picture.Bitmap;
   Bmp.PixelFormat := pf24bit;
   Bmp.Width := Image1.Width;
   Bmp.Height := Image1.Height;
   for I := 0 to Bmp.Height - 1 do
   begin
    Line := Bmp.ScanLine[I];
     for J := 0 to Bmp.Width - 1 do
      begin
       Line [j * i] := Line[j] or $00ffffff;
      end;
   end;
   Image2.Picture.Bitmap := Bmp;
   Bmp.FreeImage;
   ImagePrincipal.Picture.Bitmap.FreeImage;
   ImagePrincipal.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
   Image1.Picture.Bitmap.FreeImage;
   Image1.Picture.Bitmap := Form1.ImgIconEditor1.Bitmap;
  end;

end;

procedure TForm3.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ListBox1.ItemIndex = 0 then
  begin
   Shape2.Brush.Color := Image1.Canvas.Pixels[x,y];
   begin
   Label2.caption := 'Coordenadas: ' + 'X: ' + IntToStr(X) + ' Y: ' + IntToStr(Y);
    if ((X >= 0) and (Y >= 0) and (X <= 31) and (Y <= 31)) then
     Shape2.Visible := True
    else
     Shape2.Visible := False;
   end;
   begin
    if X < Image1.Width then
     Shape2.Left := X
     else
     Shape2.Left := X;
   end;
   begin
    if Y < Image1.Height then
     Shape2.Top := Y
    else
    Shape2.Top := Y + 4;
   end;
  end;
end;

procedure TForm3.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ((X > Image1.Left) and (Y > Image1.Top) and (X < Image1.Width) and (Y < Image1.Height)) then
  Shape2.Visible := True
 else
  Shape2.Visible := False;
end;

procedure TForm3.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if ListBox1.ItemIndex = 0 then
  begin
   Shape1.Brush.Color := Shape2.Brush.Color;
  end
  else
  begin
   Shape1.Brush.Color := clWhite;
  end;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
begin
 Image2.Picture.Bitmap := ImagePrincipal.Picture.Bitmap;
 
 if ListBox1.ItemIndex = 0 then
  begin
   PCorSel.Visible := True;
   PVazio.Visible := False;
   PTons.Visible := False;
   PEspelho.Visible := False;
   Label2.Visible := True;
   Shape1.Brush.Color := clWhite;
   ColorComboBox1.ColorValue := clWhite;
  end;

 if ListBox1.ItemIndex = 1 then
  begin
   PCorSel.Visible := False;
   PVazio.Visible := True;
   PTons.Visible := False;
   PEspelho.Visible := False;
   PListra.Visible := False;
   Label2.Visible := False;
  end;

 if ListBox1.ItemIndex = 2 then
  begin
   PCorSel.Visible := False;
   PVazio.Visible := True;
   PTons.Visible := False;
   PEspelho.Visible := False;
   PListra.Visible := False;
   Label2.Visible := False;
  end;

 if ListBox1.ItemIndex = 3 then
  begin
   PCorSel.Visible := False;
   PVazio.Visible := True;
   PTons.Visible := False;
   PEspelho.Visible := False;
   PListra.Visible := False;
   Label2.Visible := False;
  end;

 if ListBox1.ItemIndex = 4 then
  begin
   PCorSel.Visible := False;
   PVazio.Visible := False;
   PTons.Visible := True;
   PEspelho.Visible := False;
   PListra.Visible := False;
   Label2.Visible := False;
   ColorComboBox2.ColorValue := clWhite;
  end;

 if ListBox1.ItemIndex = 5 then
  begin
   R1.Checked := True;
   PCorSel.Visible := False;
   PVazio.Visible := False;
   PTons.Visible := False;
   PEspelho.Visible := True;
   PListra.Visible := False;
   Label2.Visible := False;
  end;

 if ListBox1.ItemIndex = 6 then
  begin
   RT1.Checked := True;
   PCorSel.Visible := False;
   PVazio.Visible := False;
   PTons.Visible := False;
   PEspelho.Visible := False;
   PListra.Visible := True;
   Label2.Visible := False;
  end;

 if ListBox1.ItemIndex = 7 then
  begin
   PCorSel.Visible := False;
   PVazio.Visible := True;
   PTons.Visible := False;
   PEspelho.Visible := False;
   PListra.Visible := False;
   Label2.Visible := False;
  end;

  
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
 Image2.Picture.Bitmap := ImagePrincipal.Picture.Bitmap;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
Form1.ImgIconEditor1.Bitmap := Image2.Picture.Bitmap;
Form1.ImgIconEditor1.Paint;
Form3.Close;
end;

end.
