unit CardLTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TLTECard = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lbTextTitle: TLabel;
    lbTextValue: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Image1: TImage;
  private
    FTextTitle: String;
    FTextValue: Currency;
    FProgressValue: Integer;
    FBackgroundPanel1: TColor;
    FBackgroundPanel2: TColor;
    FIcoImage: TPicture;
    procedure SetTextTitle(const Value: String);
    procedure SetTextValue(const Value: Currency);
    procedure SetProgressValue(const Value: Integer);
    procedure SetBackgroundPanel1(const Value: TColor);
    procedure SetBackgroundPanel2(const Value: TColor);
    procedure SetIcoImage(const Value: TPicture);
    { Private declarations }
  public
    { Public declarations }

  published
    property IcoImage : TPicture read FIcoImage write SetIcoImage;
    property TextTitle : String read FTextTitle write SetTextTitle;
    property TextValue : Currency read FTextValue write SetTextValue;
    property ProgressValue : Integer read FProgressValue write SetProgressValue;
    property BackgroundPanel1 : TColor read FBackgroundPanel1 write SetBackgroundPanel1;
    property BackgroundPanel2 : TColor read FBackgroundPanel2 write SetBackgroundPanel2;

  end;

procedure Register;

implementation

{$R *.dfm}

procedure Register;
begin
  RegisterComponents('LTE Components', [TLTECard]);
end;

{ TLTECard }

procedure TLTECard.SetBackgroundPanel1(const Value: TColor);
begin
  FBackgroundPanel1 := Value;
  Panel2.Color := FBackgroundPanel1;
end;

procedure TLTECard.SetBackgroundPanel2(const Value: TColor);
begin
  FBackgroundPanel2 := Value;
  Panel3.Color := FBackgroundPanel2;
end;

procedure TLTECard.SetIcoImage(const Value: TPicture);
begin
  try
  FIcoImage := Value;
  Image1.Picture.Assign(FIcoImage);
  except
    on e:Exception do
    begin
      raise Exception.Create(e.Message);
      Image1.Picture := nil;
    end;
  end;
end;

procedure TLTECard.SetProgressValue(const Value: Integer);
begin
  FProgressValue := Value;
  Shape2.Width := Round(Value * (Shape1.Width / 100));


end;

procedure TLTECard.SetTextTitle(const Value: String);
begin
  FTextTitle := Value;
  lbTextTitle.Caption := FTextTitle;
end;

procedure TLTECard.SetTextValue(const Value: Currency);
begin
  FTextValue := Value;
  lbTextValue.Caption := FormatCurr('#,##0.00', FTextValue);
end;

end.
