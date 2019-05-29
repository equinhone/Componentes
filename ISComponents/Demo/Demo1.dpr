program Demo1;

uses
  System.StartUpCopy,
  FMX.Forms,
  uDemo in 'uDemo.pas' {Form37};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm37, Form37);
  Application.Run;
end.
