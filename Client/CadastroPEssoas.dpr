program CadastroPEssoas;

uses
  Vcl.Forms,
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  uCadPessoa in 'uCadPessoa.pas' {frmCadPessoa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TfrmCadPessoa, frmCadPessoa);
  Application.Run;
end.
