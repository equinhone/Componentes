unit FMX.ISFloatMenu;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, System.DateUtils, System.Generics.Collections, FMX.Utils, FMX.Types, FMX.Controls, FMX.Objects, FMX.StdCtrls, FMX.Graphics, FMX.MultiResBitmap,
  FMX.Ani, FMX.Effects, System.Actions, FMX.ActnList, FMX.Layouts, FMX.Filter.Effects, System.Rtti,

  FMX.IS_Base,
  FMX.ISIcons;

Type

   TIS_Floatmenu = Class;

   TIS_Hint = Class(TIS_Control)
      Private
         FTextColor : TAlphaColor;
         FTextFont  : TFont;
         FText      : String;
         FTextAlign : TTextAlign;
         FTimer     : TTimer;
         procedure SetText     (const Value: String);
         procedure SetTextColor(const Value: TAlphaColor);
         procedure SetTextFont (const Value: TFont);
         procedure SetTextAlign(const Value: TTextAlign);
      Protected
         Procedure Paint; Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
         Procedure Show;
         procedure Hide(Sender : TObject);
         Property Text      : String      Read FText      Write SetText;
         Property TextFont  : TFont       Read FTextFont  Write SetTextFont;
         Property TextColor : TAlphaColor Read FTextColor Write SetTextColor;
         Property TextAlign : TTextAlign  Read FTextAlign Write SetTextAlign;
      End;

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_FloatOption = Class(TIS_CircleIcon)
      Private
         FHint      : TIS_Hint;
         FAni       : TFloatAnimation;
         FOpen      : Boolean;
         FFloatMenu : TIS_FloatMenu;
         FShowHint  : Boolean;
         function GetText           : String;
         function GetTextBackground : TAlphaColor;
         function GetTextColor      : TAlphaColor;
         function GetTextFont       : TFont;
         function GetTextAlign      : TTextAlign;
         function GetHintColor      : TAlphaColor;
         procedure SetText          (const Value: String);
         procedure SetTextBackground(const Value: TAlphaColor);
         procedure SetTextColor     (const Value: TAlphaColor);
         procedure SetTextFont      (const Value: TFont);
         procedure SetTextAlign     (const Value: TTextAlign);
         procedure SetHintColor     (const Value: TAlphaColor);
         procedure FinishAnimation  (Sender: TObject);
      Protected
         procedure Loaded; Override;
         Procedure Clicked; Override;
         Property Open           : Boolean          Read FOpen             Write FOpen;
         Property FloatMenu      : TIS_FloatMenu    Read FFloatMenu        Write FFloatMenu;
      Public
         Constructor Create(aOwner : TComponent); Override;
         Procedure HideHint;
      Published
         Property ShowHint       : Boolean          Read FShowHint         Write FShowHint;
         Property HintColor      : TAlphaColor      Read GetHintColor      Write SetHintColor;
         Property Text           : String           Read GetText           Write SetText;
         Property TextColor      : TAlphaColor      Read GetTextColor      Write SetTextColor;
         Property TextFont       : TFont            Read GetTextFont       Write SetTextFont;
         Property TextBackground : TAlphaColor      Read GetTextBackground Write SetTextBackground;
         Property TextAlign      : TTextAlign       Read GetTextAlign      Write SetTextAlign;
      End;

   TIS_OptionItem = class(TCollectionItem)
      Private
         FOption : TIS_FloatOption;
      Protected
         function GetDisplayName: String; override;
      Public
         constructor Create(Collection: TCollection); Override;
      published
         property Opcao : TIS_FloatOption read FOption write FOption;
      end;

   TIS_Options = class(TCollection)
      Private
         FImageMenu : TIS_FloatMenu;
         function  GetItem(Index: Integer): TIS_OptionItem;
         procedure SetItem(Index: Integer; Value: TIS_OptionItem);
      Protected
         function GetOwner: TPersistent; override;
      Public
         constructor Create;
         function    Add: TIS_OptionItem;
         property    Items[Index: Integer]: TIS_OptionItem read GetItem write SetItem;
      end;

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_FloatMenu = Class(TIS_CircleIcon)
      Private
         FAnimate      : Boolean;
         FAnimateTime  : Single;
         FSpace        : Single;
         FOptions      : TIS_Options;
         FOpen         : Boolean;
      Protected
         procedure DoCloseMenu; Virtual;
         procedure DoOpenMenu; Virtual;
         Procedure Clicked; Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
         Procedure OpenMenu;
         Procedure CloseMenu;
      Published
         Property Animate      : Boolean     Read FAnimate          Write FAnimate;
         Property AnimateTime  : Single      Read FAnimateTime      Write FAnimateTime;
         Property Options      : TIS_Options Read FOptions          Write FOptions;
         Property Space        : Single      Read FSpace            Write FSpace;
      End;

Procedure Register;

implementation

Procedure Register;
Begin
RegisterComponents('Imperium Software', [TIS_FloatMenu, TIS_FLoatOption]);
End;

//   TIS_OptionItem

constructor TIS_OptionItem.Create(Collection: TCollection);
Begin
Inherited;
FOption := TIS_FloatOption.Create(FOption);
End;

function TIS_OpTionItem.GetDisplayName: String;
Begin
Result := 'Option'+(ID+1).ToString;
End;

//   TIS_Options

Constructor TIS_Options.Create;
begin
inherited Create(TIS_OptionItem);
end;

Function TIS_Options.Add : TIS_OptionItem;
begin
Result := TIS_OptionItem(inherited Add);
end;

Function TIS_Options.GetItem(Index: Integer): TIS_OptionItem;
begin
Result := TIS_OptionItem(inherited GetItem(Index));
end;

Procedure TIS_Options.SetItem(Index: Integer; Value: TIS_OptionItem);
begin
inherited SetItem(Index, Value);
end;

function TIS_Options.GetOwner: TPersistent;
begin
Result := FImageMenu;
end;


{ TIS_Hint }

constructor TIS_Hint.Create(aOwner: TComponent);
begin
inherited;
Width     := 150;
Height    := 26;
Color     := TAlphaColorRec.Gray;
Text      := 'Hint...';
TextColor := TAlphaColorRec.Black;
FTimer    := TTimer.Create(Self);
FTimer.Interval := 4003;
FTimer.OnTimer  := Hide;
FTimer.Enabled  := False;
end;

procedure TIS_Hint.Show;
begin
Visible        := True;
Opacity        := 1;
FTimer.Enabled := True;
BringToFront;
end;

procedure TIS_Hint.Hide(Sender: TObject);
begin
FTimer.Enabled := False;
TAnimator.AnimateFloat(Self, 'Opacity', 0, 1);
end;

procedure TIS_Hint.Paint;
Var
    Save : TCanvasSaveState;
begin
inherited;
Save := Canvas.SaveState;
Canvas.Fill.Color := TextColor;
Canvas.Font.Assign(TextFont);
Canvas.FillText(TRectF.Create(0, 0, Width-1, Height-1), Text, False, Opacity, [], TextAlign);
Canvas.RestoreState(Save);
end;

procedure TIS_Hint.SetText(const Value: String);
begin
FText := Value;
Repaint;
end;

procedure TIS_Hint.SetTextAlign(const Value: TTextAlign);
begin
FTextAlign := Value;
Repaint;
end;

procedure TIS_Hint.SetTextColor(const Value: TAlphaColor);
begin
FTextColor := Value;
Repaint;
end;

procedure TIS_Hint.SetTextFont(const Value: TFont);
begin
FTextFont := Value;
Repaint;
end;



{ TIS_FloatOption }

procedure TIS_FloatOption.Clicked;
begin
inherited;
FloatMenu.CloseMenu;
end;

constructor TIS_FloatOption.Create(aOwner: TComponent);
begin
inherited;
FHint := TIS_Hint       .Create(Self);
FAni  := TFloatAnimation.Create(Self);
FAni.Parent       := Self;
FAni.PropertyName := 'Position.Y';
FAni.OnFinish     := FinishAnimation;
FAni.Stored       := False;
FHint.Stored      := False;
FShowHint         := False;
end;

Procedure TIS_FloatOption.FinishAnimation(Sender : TObject);
Begin
if Not FOpen then
   Begin
   Visible := False;
   End
Else
   Begin
   If FShowHint Then
      Begin
      FHint.Parent     := Self.Parent;
      FHint.Position.Y := Position.Y + (Height - FHint.Height)/2;
      FHint.Position.X := Position.X - 170;
      FHint.Show;
      End;
   End;
End;

function TIS_FloatOption.GetHintColor: TAlphaColor;
begin
Result := FHint.Color;
end;

function TIS_FloatOption.GetText: String;
begin
Result := FHint.Text;
end;

function TIS_FloatOption.GetTextAlign: TTextAlign;
begin
Result := FHint.TextAlign;
end;

function TIS_FloatOption.GetTextBackground: TAlphaColor;
begin
Result := FHint.Color;
end;

function TIS_FloatOption.GetTextColor: TAlphaColor;
begin
Result := FHint.textColor;
end;

function TIS_FloatOption.GetTextFont: TFont;
begin
Result := FHint.TextFont;
end;

procedure TIS_FloatOption.HideHint;
begin
FHint.Visible := False;
end;

procedure TIS_FloatOption.Loaded;
begin
inherited;
if not (csDesigning in ComponentState) then
   Position.Y := -1000;
end;

procedure TIS_FloatOption.SetHintColor(const Value: TAlphaColor);
begin
FHint.Color := Value;
end;

procedure TIS_FloatOption.SetText(const Value: String);
begin
FHint.Text := Value;
end;

procedure TIS_FloatOption.SetTextAlign(const Value: TTextAlign);
begin
FHint.TextAlign := Value;
end;

procedure TIS_FloatOption.SetTextBackground(const Value: TAlphaColor);
begin
FHint.Color := Value;
end;

procedure TIS_FloatOption.SetTextColor(const Value: TAlphaColor);
begin
FHint.TextColor := Value;
end;

procedure TIS_FloatOption.SetTextFont(const Value: TFont);
begin
FHint.TextFont.Assign(Value);
end;

{ TIS_FloatMenu }

procedure TIS_FloatMenu.DoOpenMenu;
Var
   x : Integer;
   O : TIS_FloatOption;
Begin
FOpen := True;
for x := 0 to Options.Count-1 do
   Begin
   O := Options.Items[x].FOption;
   O.Parent     := Parent;
   O.FloatMenu  := Self;
   O.Position.X := Position.X + (Width -O.Width )/2;
   O.Position.Y := Position.Y + (Height-O.Height)/2;
   O.Visible    := True;
   O.Open       := True;
   O.BringToFront;
   O.FAni.StartValue := O.Position.Y;
   O.FAni.StopValue  := O.Position.Y - (Height+FSpace) * (X+1);
   O.FAni.Duration   := FAnimateTime;
   O.FAni.Start;
   End;
BringToFront;
End;

procedure TIS_FloatMenu.DoCloseMenu;
Var
   x : Integer;
   O : TIS_FloatOption;
Begin
FOpen := False;
for x := 0 to Options.Count-1 do
   Begin
   O := Options.Items[x].FOption;
   O.HideHint;
   O.Open            := False;
   O.FAni.StartValue := O.Position.Y;
   O.FAni.StopValue  := Position.Y + (Height-O.Height)/2;
   O.FAni.Start;
   End;
End;

procedure TIS_FloatMenu.OpenMenu;
begin
DoOpenMenu;
end;

procedure TIS_FloatMenu.CloseMenu;
begin
DoCloseMenu;
end;

procedure TIS_FloatMenu.Clicked;
begin
inherited;
if Not FOpen then
   Begin
   if FAnimate then TAnimator.AnimateFloat(Self.FIcon, 'RotationAngle', 90, FAnimateTime);
   DoOpenMenu;
   End
Else
   Begin
   if FAnimate then TAnimator.AnimateFloat(Self.FIcon, 'RotationAngle', 0, FAnimateTime);
   DoCloseMenu;
   end;
Inherited;
end;

constructor TIS_FloatMenu.Create(aOwner: TComponent);
begin
inherited;
RotationAngle := 0;
FSpace        := 10;
FOpen         := False;
Options       := TIS_Options.Create;
ShowShadow    := True;
Color         := TAlphaColorRec.Cadetblue;
IconColor     := TAlphaColorRec.White;
FAnimate      := True;
FAnimateTime  := 0.3;
end;

end.
