unit unCustomPanelButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.ImgList;


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
    FQImageIndex: Integer;
    FQImageList: TCustomImageList;
    FQImageWidth: Integer;
    FQTextFont: TFont;


    procedure setQImage(const Value: TPicture);
    procedure setFQTexCaption(const Value: String);
    procedure ArredondarImagem(Panel: TPanel);
    procedure setQImageIndex(const Value: Integer);
    procedure setQImageWidth(const Value: Integer);
    procedure setQImageList(const Value: TCustomImageList);
    procedure setQTextFont(const Value: TFont);

    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;

    procedure Resize(Sender:TObject);

  published
    { Published declarations }



    property QTexTCaption:String read FQTexCaption write setFQTexCaption;
    property QTextFont:TFont read FQTextFont write setQTextFont;
    property QImageIndex:Integer read FQImageIndex write setQImageIndex default -1;
    property QImageList: TCustomImageList read FQImageList write setQImageList;
    property QImageWidth: Integer read FQImageWidth write setQImageWidth;
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

  FQImageIndex        := -1;
  FQImageRedimensiar  := trAutomatico;

  Self.Padding.Left   := 3;
  Self.Padding.Right  := 3;
  Self.Padding.Top    := 3;
  Self.Padding.Bottom := 3;

  panelIMG              := TPanel.Create(Self);
  panelIMG.Parent       := Self;
  panelIMG.Width        := Trunc(Self.Width/3);
  panelIMG.Align        := TAlign.alLeft;
  panelIMG.BevelInner   := TBevelCut.bvNone;
  panelIMG.BevelKind    := TBevelKind.bkNone;
  panelIMG.BevelOuter   := TBevelCut.bvNone;
  panelIMG.OnResize     := Resize;

  panelLabel            := TPanel.Create(Self);
  panelLabel.Caption    := '';
  panelLabel.Parent     := Self;
  panelLabel.Width      := Trunc(Self.Width/3);
  panelLabel.Align      := TAlign.alClient;
  panelLabel.BevelInner := TBevelCut.bvNone;
  panelLabel.BevelKind  := TBevelKind.bkNone;
  panelLabel.BevelOuter := TBevelCut.bvNone;

  lbCaption             := TLabel.Create(panelLabel);
  lbCaption.Alignment   := TAlignment.taCenter;
  lbCaption.Layout      := TTextLayout.tlCenter;
  lbCaption.Caption     := Self.Caption;
  lbCaption.Parent      := panelLabel;
  lbCaption.Align       := TAlign.alClient;
  lbCaption.WordWrap    := true;

  Image1                := TImage.Create(Self);
  Image1.Parent         := panelIMG;
  Image1.Align          := TAlign.alClient;
  Image1.Stretch        := true;
  Image1.Visible        := true;

  FQTextFont            := TFont.Create;
  FQTextFont.Color      := clRed;
  FQTextFont.Name       := 'Segoe UI';
  FQTextFont.Size       := 10;
  FQTextFont.Style      := [];

  lbCaption.Font        := FQTextFont;






  //if (FQImageIndex >= 0) and Assigned(FQImageList) then
  //   QImageList.GetBitmap(FQImageIndex, Image1.Picture.Bitmap);

  Self.Caption         := ' ';


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
  case QImageRedimensiar of
    trManual:panelIMG.Width := FQImageWidth;
    trAutomatico:panelIMG.Width := Trunc(Self.Width/3);
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

procedure TCustomPanelButton.setQImageIndex(const Value: Integer);
begin
  FQImageIndex := Value;
  if (FQImageIndex >= 0) and Assigned(FQImageList) then
     QImageList.GetBitmap(FQImageIndex, Image1.Picture.Bitmap);
end;

procedure TCustomPanelButton.setQImageList(const Value: TCustomImageList);
begin
  if Assigned(Value) then
    FQImageList := Value;

  if (FQImageIndex >= 0) and Assigned(FQImageList) then
  begin
    QImageList.GetBitmap(FQImageIndex, Image1.Picture.Bitmap);
  end;
end;

procedure TCustomPanelButton.setQImageWidth(const Value: Integer);
begin
  FQImageWidth := Value;
  if QImageRedimensiar = trManual then
  begin
    panelIMG.Width := FQImageWidth;
  end;
end;

procedure TCustomPanelButton.setQTextFont(const Value: TFont);
begin
  FQTextFont.Assign(Value);
  if Assigned(FQTextFont) then
     lbCaption.Font.Assign(FQTextFont);
end;

end.
