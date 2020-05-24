program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitTesteIcone in 'UnitTesteIcone.pas' {Form2},
  UnitEfeito in 'UnitEfeito.pas' {Form3},
  uSearchIcon in 'uSearchIcon.pas' {fSearchIcon},
  uDlgSearchIcon in 'uDlgSearchIcon.pas' {fDlgSearchIcon},
  jvIcon in 'jvIcon.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Editor de Ícones';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfSearchIcon, fSearchIcon);
  Application.Run;
end.
