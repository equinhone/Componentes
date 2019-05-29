unit uDemo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.ISFloatMenu, FMX.IS_Base, FMX.ISIcons,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.ISEditEx;

type
  TForm37 = class(TForm)
    IS_FloatOption4: TIS_FloatOption;
    IS_FloatOption3: TIS_FloatOption;
    IS_FloatOption2: TIS_FloatOption;
    IS_FloatOption1: TIS_FloatOption;
    IS_Floatmenu1: TIS_Floatmenu;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    Memo1: TMemo;
    IS_EditEx1: TIS_EditEx;
    procedure IS_FloatOption4Clicked(Sender: TObject);
    procedure IS_FloatOption3Clicked(Sender: TObject);
    procedure IS_FloatOption2Clicked(Sender: TObject);
    procedure IS_FloatOption1Clicked(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form37: TForm37;

implementation

{$R *.fmx}

procedure TForm37.IS_FloatOption1Clicked(Sender: TObject);
begin
Memo1.Lines.Add('Opção 1');
end;

procedure TForm37.IS_FloatOption2Clicked(Sender: TObject);
begin
Memo1.Lines.Add('Opção 2');
end;

procedure TForm37.IS_FloatOption3Clicked(Sender: TObject);
begin
Memo1.Lines.Add('Opção 3');
end;

procedure TForm37.IS_FloatOption4Clicked(Sender: TObject);
begin
Memo1.Lines.Add('Opção 4');
end;

end.
