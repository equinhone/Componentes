unit FMX.IS_Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.Ani,
  FMX.Effects, FMX.Filter.Effects, FMX.Objects, FMX.StdCtrls, FMX.Forms;


type

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_Control  = Class(TRectangle)
      Private
         FCornerWidth   : Single;
         FLoadresources : Boolean;
         FCanFocus      : Boolean;
         FShadow        : TShadowEffect;
         FShadowColor   : TAlphaColor;
         FClicked       : TNotifyEvent;
         function  GetEdgeSize    : Single;
         function  GetShowShadow  : Boolean;
         function  GetEdgeColor   : TAlphaColor;
         function  GetShadowColor : TAlphaColor;
         function  GetColor       : TAlphaColor;
         procedure SetCornerWidth(const Value: Single);
         procedure SetEdgeSize   (const Value: Single);
         procedure SetShowShadow (const Value: Boolean);
         procedure SetEdgeColor  (const Value: TAlphaColor);
         procedure SetShadowColor(const Value: TAlphaColor);
      Protected
         {$IfDef MSWINDOWS}
         procedure Click; Override;
         {$ELSE}
         procedure Tap(const Point:TPointF); Override;
         {$ENDIF}
         Procedure Clicked; Virtual;
         function  GetForm: TForm; Virtual;
         procedure SetColor(const Value: TAlphaColor); Virtual;
         Procedure LoadResources; Virtual;
         Procedure RepaintControl; Virtual;
         Procedure DoFocus; Virtual;
         Procedure Paint; Override;
         procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
      Published
         Property Form        : TForm         read GetForm;
         Property Color       : TAlphaColor   read GetColor       write SetColor;
         property EdgeSize    : Single        read GetEdgeSize    write SetEdgeSize;
         property EdgeColor   : TAlphaColor   read GetEdgeColor   write SetEdgeColor;
         property CornerWidth : Single        read FCornerWidth   write SetCornerWidth;
         Property ShowShadow  : Boolean       read GetShowShadow  write SetShowShadow;
         Property ShadowColor : TAlphaColor   read GetShadowColor Write SetShadowColor;
         Property CanFocus    : Boolean       read FCanFocus      write FCanFocus;
         Property OnClicked   : TNotifyEvent  Read FClicked       write FClicked;
     End;

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_CircleControl  = Class(TCircle)
      Private
         FLoadresources : Boolean;
         FCanFocus      : Boolean;
         FShadow        : TShadowEffect;
         FShadowColor   : TAlphaColor;
         FClicked       : TNotifyEvent;
         function  GetEdgeSize   : Single;
         function  GetShowShadow : Boolean;
         function  GetEdgeColor  : TAlphaColor;
         function  GetColor      : TAlphaColor;
         procedure SetEdgeSize   (const Value: Single);
         procedure SetShowShadow (const Value: Boolean);
         procedure SetEdgeColor  (const Value: TAlphaColor);
         function  GetShadowColor: TAlphaColor;
         procedure SetShadowColor(const Value: TAlphaColor);
      Protected
         {$IfDef MSWINDOWS}
         procedure Click; Override;
         {$ELSE}
         procedure Tap(const Point:TPointF); Override;
         {$ENDIF}
         Procedure Clicked; Virtual;
         function  GetForm: TForm; Virtual;
         procedure SetColor(const Value: TAlphaColor); Virtual;
         Procedure LoadResources; Virtual;
         Procedure RepaintControl; Virtual;
         Procedure DoFocus; Virtual;
         Procedure Paint; Override;
         procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
      Published
         Property Form        : TForm         read GetForm;
         Property Color       : TAlphaColor   read GetColor       write SetColor;
         property EdgeSize    : Single        read GetEdgeSize    write SetEdgeSize;
         property EdgeColor   : TAlphaColor   read GetEdgeColor   write SetEdgeColor;
         Property ShowShadow  : Boolean       read GetShowShadow  write SetShowShadow;
         Property ShadowColor : TAlphaColor   read GetShadowColor Write SetShadowColor;
         Property CanFocus    : Boolean       read FCanFocus      write FCanFocus;
         Property OnClicked   : TNotifyEvent  Read FClicked       write FClicked;
     End;

implementation

{ TIS_Control }

procedure TIS_Control.Clicked;
begin
TThread.Queue(Nil,
   procedure
   Begin
   if Assigned(OnClicked) then OnClicked(Self);
   End);
end;

{$IfDef MSWINDOWS}
procedure TIS_Control.Click;
Begin
Clicked;
End;
{$ELSE}
procedure TIS_Control.Tap(const Point:TPointF);
Begin
Clicked;
End;
{$ENDIF}

function TIS_Control.GetForm: TForm;
Var
   Form : TFMXObject;
begin
Form := Parent;
while Not(Form Is TForm) And Not(Form = Nil) do Form := Form.Parent;
Result := Form As TForm;
end;

constructor TIS_Control.Create(aOwner: TComponent);
begin
inherited;
FShadow        := Nil;
FLoadResources := True;
CornerWidth    := 2;
EdgeSize       := 0;
CanFocus       := True;
Color          := TAlphaColorRec.White;
ShadowColor    := TAlphaColorRec.Gray;
end;

procedure TIS_Control.SetColor(const Value: TAlphaColor);
begin
Fill.Color := Value;
end;

procedure TIS_Control.SetCornerWidth(const Value: Single);
begin
Self.XRadius := Value;
Self.YRadius := Value;
FCornerWidth := Value;
Repaint;
end;

procedure TIS_Control.SetEdgeColor(const Value: TAlphaColor);
begin
Stroke.Color := Value;
end;

procedure TIS_Control.SetEdgeSize(const Value: Single);
begin
Stroke.Thickness := Value;
if Value = 0 then
   Stroke.Kind := TBrushKind.None
Else
   Stroke.Kind := TBrushKind.Solid;
end;

procedure TIS_Control.SetShadowColor(const Value: TAlphaColor);
begin
FShadowColor := Value;
if FShadow <> Nil Then
   Begin
   FShadow.ShadowColor := FShadowColor;
   End;
end;

procedure TIS_Control.SetShowShadow(const Value: Boolean);
begin
if Value And (FShadow = Nil) Then
   Begin
   FShadow             := TShadowEffect.Create(Self);
   FShadow.Stored      := False;
   FShadow.Parent      := Self;
   FShadow.ShadowColor := FShadowColor;
   FShadow.Enabled     := True;
   End;
if FShadow <> Nil then FShadow.Enabled := Value;
end;

procedure TIS_Control.DoFocus;
begin
end;

function TIS_Control.GetColor: TAlphaColor;
begin
Result := Fill.Color;
end;

function TIS_Control.GetEdgeColor: TAlphaColor;
begin
Result := Stroke.Color;
end;

function TIS_Control.GetEdgeSize: Single;
begin
Result := Stroke.Thickness;
end;

function TIS_Control.GetShadowColor: TAlphaColor;
begin
Result := FShadowColor;
end;

function TIS_Control.GetShowShadow: Boolean;
begin
If FShadow <> Nil Then Result := FShadow.enabled Else Result := False;
end;

procedure TIS_Control.LoadResources;
begin
FLoadResources := False;
end;

procedure TIS_Control.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
   Form : TForm;
   Obj  : TFMXObject;
begin
inherited;
if FCanFocus then
   Begin
   form := GetForm;
   Obj  := Nil;
   if (Form <> Nil) And (Form.Focused <> Nil) Then
      Begin
      Obj := Form.Focused.GetObject;
      End;
   if Obj Is TControl then (Obj as TControl).ResetFocus;
   Setfocus;
   DoFocus;
   End;
end;

procedure TIS_Control.Paint;
begin
if FLoadResources then
   Begin
   LoadResources;
   End;
inherited;
end;

procedure TIS_Control.RepaintControl;
begin
FLoadResources := True;
Repaint;
end;

{ TIS_CircleControl }

procedure TIS_CircleControl.Clicked;
begin
if Assigned(OnClicked) then OnClicked(Self);
end;

{$IFDEF MSWINDOWS}
procedure TIS_CircleControl.Click;
Begin
Clicked;
End;
{$ELSE}
procedure TIS_CircleControl.Tap(const Point:TPointF);
Begin
Clicked;
End;
{$ENDIF}

function TIS_CircleControl.GetForm: TForm;
Var
   Form : TFMXObject;
begin
Form := Parent;
while Not(Form Is TForm) And Not(Form = Nil) do Form := Form.Parent;
Result := Form As TForm;
end;

constructor TIS_CircleControl.Create(aOwner: TComponent);
begin
inherited;
FShadow        := Nil;
FLoadResources := True;
EdgeSize       := 0;
CanFocus       := True;
Width          := 50;
Height         := 50;
Color          := TAlphaColorRec.White;
ShadowColor    := TAlphaColorRec.Gray;
end;

procedure TIS_CircleControl.DoFocus;
begin
end;

function TIS_CircleControl.GetColor: TAlphaColor;
begin
Result := Fill.Color;
end;

function TIS_CircleControl.GetEdgeColor: TAlphaColor;
begin
Result := Stroke.Color;
end;

function TIS_CircleControl.GetEdgeSize: Single;
begin
Result := Stroke.Thickness;
end;

procedure TIS_CircleControl.SetColor(const Value: TAlphaColor);
begin
Fill.Color := Value;
end;

procedure TIS_CircleControl.SetEdgeColor(const Value: TAlphaColor);
begin
Stroke.Color := Value;
end;

procedure TIS_CircleControl.SetEdgeSize(const Value: Single);
begin
Stroke.Thickness := Value;
end;

function TIS_CircleControl.GetShadowColor: TAlphaColor;
begin
Result := FShadowColor;
end;

function TIS_CircleControl.GetShowShadow: Boolean;
begin
If FShadow <> Nil Then Result := FShadow.enabled Else Result := False;
end;

procedure TIS_CircleControl.SetShadowColor(const Value: TAlphaColor);
begin
FShadowColor := Value;
if FShadow <> Nil Then
   Begin
   FShadow.ShadowColor := FShadowColor;
   End;
end;

procedure TIS_CircleControl.SetShowShadow(const Value: Boolean);
begin
if Value And (FShadow = Nil) Then
   Begin
   FShadow             := TShadowEffect.Create(Self);
   FShadow.Stored      := False;
   FShadow.Parent      := Self;
   FShadow.ShadowColor := FShadowColor;
   FShadow.Enabled     := True;
   End;
if FShadow <> Nil then FShadow.Enabled := Value;
end;

procedure TIS_CircleControl.LoadResources;
begin
FLoadResources := False;
end;

procedure TIS_CircleControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
   Form : TForm;
   Obj  : TFMXObject;
begin
inherited;
if FCanFocus then
   Begin
   form := GetForm;
   Obj  := Nil;
   if (Form <> Nil) And (Form.Focused <> Nil) Then
      Begin
      Obj := Form.Focused.GetObject;
      End;
   if Obj Is TControl then (Obj as TControl).ResetFocus;
   Self.Setfocus;
   DoFocus;
   End;
end;

procedure TIS_CircleControl.Paint;
begin
if FLoadResources then
   Begin
   LoadResources;
   End;
inherited;
end;

procedure TIS_CircleControl.RepaintControl;
begin
FLoadResources := True;
Repaint;
end;

end.
