unit unCustomPanelButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics, Vcl.StdCtrls;


type
  TRedimensionar = (trManual, trAutomatico);

  TCustomPanelButton = class(TPanel)
  private
    FQImage: TPicture;
    panelIMG:Tpanel;
    panelLabel:Tpanel;
    Image1: TImage;
    lbCaption: TLabel;
    FQImageRedimensiar: TRedimensionar;
    FQTexCaption: String;


    procedure setQImage(const Value: TPicture);
    procedure setFQTexCaption(const Value: String);
    procedure ArredondarImagem(Panel: TPanel);

    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;

    procedure Resize(Sender:TObject);

  published
    { Published declarations }



    property QTexCaption:String read FQTexCaption write setFQTexCaption;
    property QImage:TPicture read FQImage write setQImage;
    property QImageRedimensiar:TRedimensionar read FQImageRedimensiar write FQImageRedimensiar;


  end;

procedure Register;

implementation

uses
  Winapi.Windows;

procedure Register;
begin
  RegisterComponents('Suites Quinhone', [TCustomPanelButton]);
end;

{ TCustomPanelButton }

constructor TCustomPanelButton.Create(AOwner: TComponent);
begin
  inherited;

  Self.Padding.Left   := 3;
  Self.Padding.Right  := 3;
  Self.Padding.Top    := 3;
  Self.Padding.Bottom := 3;

  FQImageRedimensiar := trAutomatico;

  panelIMG            := TPanel.Create(Self);
  panelIMG.Parent     := Self;
  panelIMG.Width      := Trunc(Self.Width/3);
  panelIMG.Align      := TAlign.alLeft;
  panelIMG.BevelInner := TBevelCut.bvNone;
  panelIMG.BevelKind  := TBevelKind.bkNone;
  panelIMG.BevelOuter := TBevelCut.bvNone;
  panelIMG.OnResize   := Resize;

  panelLabel            := TPanel.Create(Self);
  panelLabel.Caption    := '';
  panelLabel.Parent     := Self;
  panelLabel.Width      := Trunc(Self.Width/3);
  panelLabel.Align      := TAlign.alClient;
  panelLabel.BevelInner := TBevelCut.bvNone;
  panelLabel.BevelKind  := TBevelKind.bkNone;
  panelLabel.BevelOuter := TBevelCut.bvNone;

  lbCaption            := TLabel.Create(panelLabel);
  lbCaption.Alignment  := TAlignment.taCenter;
  lbCaption.Layout     := TTextLayout.tlCenter;
  lbCaption.Caption    := Self.Caption;
  lbCaption.Parent     := panelLabel;
  lbCaption.Align      := TAlign.alClient;
  lbCaption.WordWrap   := true;

  Image1               := TImage.Create(Self);
  Image1.Parent        := panelIMG;
  Image1.Align         := TAlign.alClient;
  Image1.Stretch       := true;

  Self.Caption         := ' ';

  //ArredondarImagem(Self);

end;

procedure TCustomPanelButton.ArredondarImagem(Panel : TPanel);
var
   rgn: HRGN;
   dc: HDC;
begin
     rgn := CreateRoundRectRgn(0, 0, Panel.Width, Panel.Height, 350, 350);
     dc := GetDC(Panel.Handle);
     SetWindowRgn(Panel.Handle, rgn, true);
     ReleaseDC(Panel.Handle, dc);
     DeleteObject(rgn);
end;

procedure TCustomPanelButton.Resize(Sender:TObject);
begin
  if QImageRedimensiar = trAutomatico then
  begin
    panelIMG.Width := Trunc(Self.Width/3);
    //Self.Caption     := Self.Width.ToString;
    //panelIMG.Caption := panelIMG.Width.ToString;
  end;
end;
procedure TCustomPanelButton.setFQTexCaption(const Value: String);
begin
  FQTexCaption := Value;
  lbCaption.Caption := FQTexCaption;
end;

procedure TCustomPanelButton.setQImage(const Value: TPicture);
begin
  FQImage.Assign(Value);
end;

end.
