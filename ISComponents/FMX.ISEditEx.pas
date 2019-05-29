unit FMX.ISEditEx;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.UITypes, System.DateUtils, System.Generics.Collections, FMX.Utils, FMX.Types, FMX.Controls, FMX.Objects, FMX.StdCtrls, FMX.Graphics, FMX.MultiResBitmap,
  FMX.Ani, FMX.Effects, System.Actions, FMX.ActnList, FMX.Layouts, FMX.Filter.Effects, System.Rtti,

  FMX.Controls.Presentation,
  FMX.Styles.Objects,
  FMX.Edit,
  FMX.IS_Base;

Type

   TIS_Edit = Class(TEdit)
      Private
         FEnter : TNotifyEvent;
         FExit  : TNotifyEvent;
      Protected
         Procedure DoEnter; Override;
         Procedure DoExit; Override;
         Procedure ApplyStyleLookup; Override;
         Property ISOnEnter : TNotifyEvent    Read FEnter Write FEnter;
         property ISOnExit  : TNotifyEvent    Read FExit  Write FExit;
      Public
      End;

   [ComponentPlatformsAttribute (pidWin32 or pidWin64 or pidOSX32 or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
   TIS_EditEx = Class(TIS_Control)
      Private
         CLabel     : TLabel;
         CEdit      : TIS_Edit;
         function  GetKeyBoardType : TVirtualKeyBoardType;
         function  GetMaxLength    : Integer;
         function  GetText         : String;
         function  GetTextColor    : TAlphaColor;
         function  GetTextFont     : TFont;
         function  GetPrompt       : String;
         function  GetPromptColor  : TAlphaColor;
         procedure SetKeyBoardType(const Value: TVirtualKeyBoardType);
         procedure SetMaxLength   (const Value: Integer);
         procedure SetPrompt      (const Value: String);
         procedure SetPromptColor (const Value: TAlphaColor);
         procedure SetText        (const Value: String);
         procedure SetTextColor   (const Value: TAlphaColor);
         procedure SetTextFont    (const Value: TFont);
         procedure LabelDown;
         procedure LabelUp;
         Procedure EnterEdit      (Sender : TObject);
         Procedure ExitEdit       (Sender : TObject);
      Protected
         procedure Clicked; Override;
         procedure Resize; Override;
      Public
         Constructor Create(aOwner : TComponent); Override;
      Published
         Property Edit          : TIS_Edit             Read CEdit             Write CEdit;
         Property Text          : String               Read GetText           Write SetText;
         Property TextColor     : TAlphaColor          Read GetTextColor      Write SetTextColor;
         Property TextFont      : TFont                Read GetTextFont       Write SetTextFont;
         Property KeyBoardType  : TVirtualKeyBoardType Read GetKeyBoardType   Write SetKeyBoardType;
         Property MaxLength     : Integer              Read GetMaxLength      Write SetMaxLength;
         Property Prompt        : String               Read GetPrompt         Write SetPrompt;
         Property PromptColor   : TAlphaColor          Read GetPromptColor    Write SetPromptColor;
      End;


Procedure Register;

implementation

Procedure Register;
Begin
RegisterComponents('Imperium Software', [TIS_EditEx]);
End;


{ TISEdit }

procedure TIS_Edit.DoEnter;
begin
inherited;
if Assigned(ISOnEnter) then ISOnEnter(Self);
end;

procedure TIS_Edit.DoExit;
begin
inherited;
if Assigned(ISOnExit) then ISOnExit(Self);
end;

procedure TIS_Edit.ApplyStyleLookup;
Var
   Obj: TFmxObject;
begin
inherited;
Obj := FindStyleResource('background');
If Assigned(Obj) And (Obj is TActiveStyleObject) Then
   Begin
   TActiveStyleObject(Obj).Align      := TAlignLayout.None;
   TActiveStyleObject(Obj).Position.Y := -1000;
   Obj.DisposeOf;
   End;
end;


{ TIS_EditEx }

constructor TIS_EditEx.Create(aOwner: TComponent);
begin
inherited;
CEdit                 := TIS_edit.Create(Self);
CEdit.Parent          := Self;
Cedit.Stored          := False;
CEdit.Align           := TAlignLayout.None;
CEdit.Height          := 22;
CEdit.HitTest         := False;
CEdit.StyledSettings  := [];
CEdit.Font.Size       := 14;
CEdit.ISOnEnter       := EnterEdit;
CEdit.ISOnExit        := ExitEdit;
CLabel                := TLabel .Create(Self);
CLabel.Parent         := Self;
CLabel.Stored         := False;
CLabel.Text           := '';
CLabel.Height         := 22;
CLabel.AutoSize       := False;
CLabel.StyledSettings := [];
CLabel.Font.Size      := 14;
Width                 := 100;
Height                := 30;
end;

procedure TIS_EditEx.Resize;
begin
inherited;
CEdit .Position.X := 4;
CEdit .Position.Y := Self.Height - (CEdit.Height + 4);
CEdit .Width      := Self.Width  - 8;
CLabel.Position   := CEdit.Position;
CLabel.Width      := Self.Width  - 8;
end;

procedure TIS_EditEx.Clicked;
Begin
Inherited;
TThread.CreateAnonymousThread(
   Procedure
   Begin
   Sleep(20);
   TThread.Queue(Nil,
      Procedure
      Begin
      CEdit.BringToFront;
      CEdit.SetFocus;
      End);
   End).Start;
End;

procedure TIS_EditEx.LabelDown;
begin
if Not CLabel.Text.IsEmpty then
   Begin
   TAnimator.AnimateFloat(Clabel, 'Position.Y', CEdit.Position.Y);
   End;
end;

procedure TIS_EditEx.LabelUp;
begin
if Not CLabel.Text.IsEmpty then
   Begin
   TAnimator.AnimateFloat(Clabel, 'Position.Y', 4);
   End;
end;

procedure TIS_EditEx.EnterEdit(Sender: TObject);
begin
if CLabel.Position.Y > 4 Then LabelUp;
end;

procedure TIS_EditEx.ExitEdit(Sender: TObject);
begin
if CEdit.Text.IsEmpty then LabelDown;
end;

function TIS_EditEx.GetKeyBoardType: TVirtualKeyBoardType;
begin
Result := CEdit.KeyboardType;
end;

function TIS_EditEx.GetMaxLength: Integer;
begin
Result := CEdit.MaxLength;
end;

function TIS_EditEx.GetPrompt: String;
begin
Result := CLabel.Text;
end;

function TIS_EditEx.GetPromptColor: TAlphaColor;
begin
Result := CLabel.TextSettings.FontColor;
end;

function TIS_EditEx.GetText: String;
begin
Result := CEdit.Text;
end;

function TIS_EditEx.GetTextColor: TAlphaColor;
begin
Result := CEdit.TextSettings.FontColor;
end;

function TIS_EditEx.GetTextFont: TFont;
begin
Result := CEdit.TextSettings.Font;
end;

procedure TIS_EditEx.SetKeyBoardType(const Value: TVirtualKeyBoardType);
begin
Cedit.KeyboardType := Value;
end;

procedure TIS_EditEx.SetMaxLength(const Value: Integer);
begin
CEdit.MaxLength := Value;
end;

procedure TIS_EditEx.SetPrompt(const Value: String);
begin
CLabel.Text := Value;
if Value.IsEmpty then
   Self.Height := CEdit.Height + 8
Else
   Self.Height := Cedit.Height + 8 + 20;
end;

procedure TIS_EditEx.SetPromptColor(const Value: TAlphaColor);
begin
CLabel.TextSettings.FontColor := Value;
end;

procedure TIS_EditEx.SetText(const Value: String);
begin
CEdit.Text := Value;
if Value.IsEmpty then
   Begin
   if CLabel.Position.Y <> CEdit.Position.Y then CLabel.Position.Y := CEdit.Position.Y;
   End
Else
   Begin
   if CLabel.Position.Y =  CEdit.Position.Y then CLabel.Position.Y := 4;
   End;
end;

procedure TIS_EditEx.SetTextColor(const Value: TAlphaColor);
begin
Cedit.TextSettings.FontColor := Value;
end;

procedure TIS_EditEx.SetTextFont(const Value: TFont);
begin
CEdit.TextSettings.Font := Value;
end;

end.
