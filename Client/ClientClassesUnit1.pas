//
// Created by the DataSnap proxy generator.
// 07/12/2022 06:54:49
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type

  IDSRestCachedTStringList = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FSetPessoaCommand: TDSRestCommand;
    FModifyPessoaCommand: TDSRestCommand;
    FDeletePessoaCommand: TDSRestCommand;
    FGetPessoaCommand: TDSRestCommand;
    FGetProximoCodigoPessoaCommand: TDSRestCommand;
    FSetEnderecoCommand: TDSRestCommand;
    FSetEnderecoIntegracaoCommand: TDSRestCommand;
    FModifyEnderecoCommand: TDSRestCommand;
    FModifyEnderecoIntegracaoCommand: TDSRestCommand;
    FGetProximoCodigoEnderecoCommand: TDSRestCommand;
    FGetEnderecoCommand: TDSRestCommand;
    FExisteEnderecoCommand: TDSRestCommand;
    FGetListaEnderecosCommand: TDSRestCommand;
    FGetListaEnderecosCommand_Cache: TDSRestCommand;
    FGetIdenderecoCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    procedure SetPessoa(pIdPessoa: string; pNatureza: string; pDocumentio: string; pPrimeiroNome: string; pSegundoNome: string);
    procedure ModifyPessoa(pIdPessoa: string; pNatureza: string; pDocumentio: string; pPrimeiroNome: string; pSegundoNome: string);
    procedure DeletePessoa(pIdPessoa: Integer);
    procedure GetPessoa(pIdPessoa: Integer; var pNatureza: string; var pDocumentio: string; var pPrimeiroNome: string; var pSegundoNome: string; var pDataRegistro: string; const ARequestFilter: string = '');
    function GetProximoCodigoPessoa(pSQL: string; const ARequestFilter: string = ''): Integer;
    procedure SetEndereco(pIdPEssoa: string; pIdEndereco: string; pCEP: string);
    procedure SetEnderecoIntegracao(pIdEndereco: string; pUf: string; pCidade: string; pBairro: string; pLogradouro: string; pComplemento: string);
    procedure ModifyEndereco(pIdPEssoa: string; pIdEndereco: string; pCEP: string);
    procedure ModifyEnderecoIntegracao(pIdEndereco: string; pUf: string; pCidade: string; pBairro: string; pLogradouro: string; pComplemento: string);
    function GetProximoCodigoEndereco(pSQL: string; const ARequestFilter: string = ''): Integer;
    procedure GetEndereco(pIdPessoa: string; pIdEndereco: string; var pCep: string; var pUf: string; var pCidade: string; var pBairro: string; var pLogradouro: string; var pComplemento: string; const ARequestFilter: string = '');
    function ExisteEndereco(pSQL: string; var pidendereco: Integer; const ARequestFilter: string = ''): Boolean;
    function GetListaEnderecos(const ARequestFilter: string = ''): TStringList;
    function GetListaEnderecos_Cache(const ARequestFilter: string = ''): IDSRestCachedTStringList;
    function GetIdendereco(pIdPessoa: string; const ARequestFilter: string = ''): string;
  end;

  IDSRestCachedTStringList = interface(IDSRestCachedObject<TStringList>)
  end;

  TDSRestCachedTStringList = class(TDSRestCachedObject<TStringList>, IDSRestCachedTStringList, IDSRestCachedCommand)
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_SetPessoa: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pNatureza'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pDocumentio'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pPrimeiroNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pSegundoNome'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ModifyPessoa: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pNatureza'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pDocumentio'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pPrimeiroNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pSegundoNome'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DeletePessoa: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_GetPessoa: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'pNatureza'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pDocumentio'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pPrimeiroNome'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pSegundoNome'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pDataRegistro'; Direction: 3; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetProximoCodigoPessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_SetEndereco: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPEssoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pIdEndereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pCEP'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_SetEnderecoIntegracao: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'pIdEndereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pUf'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pCidade'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pBairro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pLogradouro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pComplemento'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ModifyEndereco: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPEssoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pIdEndereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pCEP'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ModifyEnderecoIntegracao: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'pIdEndereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pUf'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pCidade'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pBairro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pLogradouro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pComplemento'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetProximoCodigoEndereco: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_GetEndereco: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pIdEndereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pCep'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pUf'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pCidade'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pBairro'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pLogradouro'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: 'pComplemento'; Direction: 3; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ExisteEndereco: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'pSQL'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'pidendereco'; Direction: 3; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_GetListaEnderecos: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TStringList')
  );

  TServerMethods1_GetListaEnderecos_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetIdendereco: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIdPessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

procedure TServerMethods1Client.SetPessoa(pIdPessoa: string; pNatureza: string; pDocumentio: string; pPrimeiroNome: string; pSegundoNome: string);
begin
  if FSetPessoaCommand = nil then
  begin
    FSetPessoaCommand := FConnection.CreateCommand;
    FSetPessoaCommand.RequestType := 'GET';
    FSetPessoaCommand.Text := 'TServerMethods1.SetPessoa';
    FSetPessoaCommand.Prepare(TServerMethods1_SetPessoa);
  end;
  FSetPessoaCommand.Parameters[0].Value.SetWideString(pIdPessoa);
  FSetPessoaCommand.Parameters[1].Value.SetWideString(pNatureza);
  FSetPessoaCommand.Parameters[2].Value.SetWideString(pDocumentio);
  FSetPessoaCommand.Parameters[3].Value.SetWideString(pPrimeiroNome);
  FSetPessoaCommand.Parameters[4].Value.SetWideString(pSegundoNome);
  FSetPessoaCommand.Execute;
end;

procedure TServerMethods1Client.ModifyPessoa(pIdPessoa: string; pNatureza: string; pDocumentio: string; pPrimeiroNome: string; pSegundoNome: string);
begin
  if FModifyPessoaCommand = nil then
  begin
    FModifyPessoaCommand := FConnection.CreateCommand;
    FModifyPessoaCommand.RequestType := 'GET';
    FModifyPessoaCommand.Text := 'TServerMethods1.ModifyPessoa';
    FModifyPessoaCommand.Prepare(TServerMethods1_ModifyPessoa);
  end;
  FModifyPessoaCommand.Parameters[0].Value.SetWideString(pIdPessoa);
  FModifyPessoaCommand.Parameters[1].Value.SetWideString(pNatureza);
  FModifyPessoaCommand.Parameters[2].Value.SetWideString(pDocumentio);
  FModifyPessoaCommand.Parameters[3].Value.SetWideString(pPrimeiroNome);
  FModifyPessoaCommand.Parameters[4].Value.SetWideString(pSegundoNome);
  FModifyPessoaCommand.Execute;
end;

procedure TServerMethods1Client.DeletePessoa(pIdPessoa: Integer);
begin
  if FDeletePessoaCommand = nil then
  begin
    FDeletePessoaCommand := FConnection.CreateCommand;
    FDeletePessoaCommand.RequestType := 'GET';
    FDeletePessoaCommand.Text := 'TServerMethods1.DeletePessoa';
    FDeletePessoaCommand.Prepare(TServerMethods1_DeletePessoa);
  end;
  FDeletePessoaCommand.Parameters[0].Value.SetInt32(pIdPessoa);
  FDeletePessoaCommand.Execute;
end;

procedure TServerMethods1Client.GetPessoa(pIdPessoa: Integer; var pNatureza: string; var pDocumentio: string; var pPrimeiroNome: string; var pSegundoNome: string; var pDataRegistro: string; const ARequestFilter: string);
begin
  if FGetPessoaCommand = nil then
  begin
    FGetPessoaCommand := FConnection.CreateCommand;
    FGetPessoaCommand.RequestType := 'GET';
    FGetPessoaCommand.Text := 'TServerMethods1.GetPessoa';
    FGetPessoaCommand.Prepare(TServerMethods1_GetPessoa);
  end;
  FGetPessoaCommand.Parameters[0].Value.SetInt32(pIdPessoa);
  FGetPessoaCommand.Parameters[1].Value.SetWideString(pNatureza);
  FGetPessoaCommand.Parameters[2].Value.SetWideString(pDocumentio);
  FGetPessoaCommand.Parameters[3].Value.SetWideString(pPrimeiroNome);
  FGetPessoaCommand.Parameters[4].Value.SetWideString(pSegundoNome);
  FGetPessoaCommand.Parameters[5].Value.SetWideString(pDataRegistro);
  FGetPessoaCommand.Execute(ARequestFilter);
  pNatureza := FGetPessoaCommand.Parameters[1].Value.GetWideString;
  pDocumentio := FGetPessoaCommand.Parameters[2].Value.GetWideString;
  pPrimeiroNome := FGetPessoaCommand.Parameters[3].Value.GetWideString;
  pSegundoNome := FGetPessoaCommand.Parameters[4].Value.GetWideString;
  pDataRegistro := FGetPessoaCommand.Parameters[5].Value.GetWideString;
end;

function TServerMethods1Client.GetProximoCodigoPessoa(pSQL: string; const ARequestFilter: string): Integer;
begin
  if FGetProximoCodigoPessoaCommand = nil then
  begin
    FGetProximoCodigoPessoaCommand := FConnection.CreateCommand;
    FGetProximoCodigoPessoaCommand.RequestType := 'GET';
    FGetProximoCodigoPessoaCommand.Text := 'TServerMethods1.GetProximoCodigoPessoa';
    FGetProximoCodigoPessoaCommand.Prepare(TServerMethods1_GetProximoCodigoPessoa);
  end;
  FGetProximoCodigoPessoaCommand.Parameters[0].Value.SetWideString(pSQL);
  FGetProximoCodigoPessoaCommand.Execute(ARequestFilter);
  Result := FGetProximoCodigoPessoaCommand.Parameters[1].Value.GetInt32;
end;

procedure TServerMethods1Client.SetEndereco(pIdPEssoa: string; pIdEndereco: string; pCEP: string);
begin
  if FSetEnderecoCommand = nil then
  begin
    FSetEnderecoCommand := FConnection.CreateCommand;
    FSetEnderecoCommand.RequestType := 'GET';
    FSetEnderecoCommand.Text := 'TServerMethods1.SetEndereco';
    FSetEnderecoCommand.Prepare(TServerMethods1_SetEndereco);
  end;
  FSetEnderecoCommand.Parameters[0].Value.SetWideString(pIdPEssoa);
  FSetEnderecoCommand.Parameters[1].Value.SetWideString(pIdEndereco);
  FSetEnderecoCommand.Parameters[2].Value.SetWideString(pCEP);
  FSetEnderecoCommand.Execute;
end;

procedure TServerMethods1Client.SetEnderecoIntegracao(pIdEndereco: string; pUf: string; pCidade: string; pBairro: string; pLogradouro: string; pComplemento: string);
begin
  if FSetEnderecoIntegracaoCommand = nil then
  begin
    FSetEnderecoIntegracaoCommand := FConnection.CreateCommand;
    FSetEnderecoIntegracaoCommand.RequestType := 'GET';
    FSetEnderecoIntegracaoCommand.Text := 'TServerMethods1.SetEnderecoIntegracao';
    FSetEnderecoIntegracaoCommand.Prepare(TServerMethods1_SetEnderecoIntegracao);
  end;
  FSetEnderecoIntegracaoCommand.Parameters[0].Value.SetWideString(pIdEndereco);
  FSetEnderecoIntegracaoCommand.Parameters[1].Value.SetWideString(pUf);
  FSetEnderecoIntegracaoCommand.Parameters[2].Value.SetWideString(pCidade);
  FSetEnderecoIntegracaoCommand.Parameters[3].Value.SetWideString(pBairro);
  FSetEnderecoIntegracaoCommand.Parameters[4].Value.SetWideString(pLogradouro);
  FSetEnderecoIntegracaoCommand.Parameters[5].Value.SetWideString(pComplemento);
  FSetEnderecoIntegracaoCommand.Execute;
end;

procedure TServerMethods1Client.ModifyEndereco(pIdPEssoa: string; pIdEndereco: string; pCEP: string);
begin
  if FModifyEnderecoCommand = nil then
  begin
    FModifyEnderecoCommand := FConnection.CreateCommand;
    FModifyEnderecoCommand.RequestType := 'GET';
    FModifyEnderecoCommand.Text := 'TServerMethods1.ModifyEndereco';
    FModifyEnderecoCommand.Prepare(TServerMethods1_ModifyEndereco);
  end;
  FModifyEnderecoCommand.Parameters[0].Value.SetWideString(pIdPEssoa);
  FModifyEnderecoCommand.Parameters[1].Value.SetWideString(pIdEndereco);
  FModifyEnderecoCommand.Parameters[2].Value.SetWideString(pCEP);
  FModifyEnderecoCommand.Execute;
end;

procedure TServerMethods1Client.ModifyEnderecoIntegracao(pIdEndereco: string; pUf: string; pCidade: string; pBairro: string; pLogradouro: string; pComplemento: string);
begin
  if FModifyEnderecoIntegracaoCommand = nil then
  begin
    FModifyEnderecoIntegracaoCommand := FConnection.CreateCommand;
    FModifyEnderecoIntegracaoCommand.RequestType := 'GET';
    FModifyEnderecoIntegracaoCommand.Text := 'TServerMethods1.ModifyEnderecoIntegracao';
    FModifyEnderecoIntegracaoCommand.Prepare(TServerMethods1_ModifyEnderecoIntegracao);
  end;
  FModifyEnderecoIntegracaoCommand.Parameters[0].Value.SetWideString(pIdEndereco);
  FModifyEnderecoIntegracaoCommand.Parameters[1].Value.SetWideString(pUf);
  FModifyEnderecoIntegracaoCommand.Parameters[2].Value.SetWideString(pCidade);
  FModifyEnderecoIntegracaoCommand.Parameters[3].Value.SetWideString(pBairro);
  FModifyEnderecoIntegracaoCommand.Parameters[4].Value.SetWideString(pLogradouro);
  FModifyEnderecoIntegracaoCommand.Parameters[5].Value.SetWideString(pComplemento);
  FModifyEnderecoIntegracaoCommand.Execute;
end;

function TServerMethods1Client.GetProximoCodigoEndereco(pSQL: string; const ARequestFilter: string): Integer;
begin
  if FGetProximoCodigoEnderecoCommand = nil then
  begin
    FGetProximoCodigoEnderecoCommand := FConnection.CreateCommand;
    FGetProximoCodigoEnderecoCommand.RequestType := 'GET';
    FGetProximoCodigoEnderecoCommand.Text := 'TServerMethods1.GetProximoCodigoEndereco';
    FGetProximoCodigoEnderecoCommand.Prepare(TServerMethods1_GetProximoCodigoEndereco);
  end;
  FGetProximoCodigoEnderecoCommand.Parameters[0].Value.SetWideString(pSQL);
  FGetProximoCodigoEnderecoCommand.Execute(ARequestFilter);
  Result := FGetProximoCodigoEnderecoCommand.Parameters[1].Value.GetInt32;
end;

procedure TServerMethods1Client.GetEndereco(pIdPessoa: string; pIdEndereco: string; var pCep: string; var pUf: string; var pCidade: string; var pBairro: string; var pLogradouro: string; var pComplemento: string; const ARequestFilter: string);
begin
  if FGetEnderecoCommand = nil then
  begin
    FGetEnderecoCommand := FConnection.CreateCommand;
    FGetEnderecoCommand.RequestType := 'GET';
    FGetEnderecoCommand.Text := 'TServerMethods1.GetEndereco';
    FGetEnderecoCommand.Prepare(TServerMethods1_GetEndereco);
  end;
  FGetEnderecoCommand.Parameters[0].Value.SetWideString(pIdPessoa);
  FGetEnderecoCommand.Parameters[1].Value.SetWideString(pIdEndereco);
  FGetEnderecoCommand.Parameters[2].Value.SetWideString(pCep);
  FGetEnderecoCommand.Parameters[3].Value.SetWideString(pUf);
  FGetEnderecoCommand.Parameters[4].Value.SetWideString(pCidade);
  FGetEnderecoCommand.Parameters[5].Value.SetWideString(pBairro);
  FGetEnderecoCommand.Parameters[6].Value.SetWideString(pLogradouro);
  FGetEnderecoCommand.Parameters[7].Value.SetWideString(pComplemento);
  FGetEnderecoCommand.Execute(ARequestFilter);
  pCep := FGetEnderecoCommand.Parameters[2].Value.GetWideString;
  pUf := FGetEnderecoCommand.Parameters[3].Value.GetWideString;
  pCidade := FGetEnderecoCommand.Parameters[4].Value.GetWideString;
  pBairro := FGetEnderecoCommand.Parameters[5].Value.GetWideString;
  pLogradouro := FGetEnderecoCommand.Parameters[6].Value.GetWideString;
  pComplemento := FGetEnderecoCommand.Parameters[7].Value.GetWideString;
end;

function TServerMethods1Client.ExisteEndereco(pSQL: string; var pidendereco: Integer; const ARequestFilter: string): Boolean;
begin
  if FExisteEnderecoCommand = nil then
  begin
    FExisteEnderecoCommand := FConnection.CreateCommand;
    FExisteEnderecoCommand.RequestType := 'GET';
    FExisteEnderecoCommand.Text := 'TServerMethods1.ExisteEndereco';
    FExisteEnderecoCommand.Prepare(TServerMethods1_ExisteEndereco);
  end;
  FExisteEnderecoCommand.Parameters[0].Value.SetWideString(pSQL);
  FExisteEnderecoCommand.Parameters[1].Value.SetInt32(pidendereco);
  FExisteEnderecoCommand.Execute(ARequestFilter);
  pidendereco := FExisteEnderecoCommand.Parameters[1].Value.GetInt32;
  Result := FExisteEnderecoCommand.Parameters[2].Value.GetBoolean;
end;

function TServerMethods1Client.GetListaEnderecos(const ARequestFilter: string): TStringList;
begin
  if FGetListaEnderecosCommand = nil then
  begin
    FGetListaEnderecosCommand := FConnection.CreateCommand;
    FGetListaEnderecosCommand.RequestType := 'GET';
    FGetListaEnderecosCommand.Text := 'TServerMethods1.GetListaEnderecos';
    FGetListaEnderecosCommand.Prepare(TServerMethods1_GetListaEnderecos);
  end;
  FGetListaEnderecosCommand.Execute(ARequestFilter);
  if not FGetListaEnderecosCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetListaEnderecosCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TStringList(FUnMarshal.UnMarshal(FGetListaEnderecosCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetListaEnderecosCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetListaEnderecos_Cache(const ARequestFilter: string): IDSRestCachedTStringList;
begin
  if FGetListaEnderecosCommand_Cache = nil then
  begin
    FGetListaEnderecosCommand_Cache := FConnection.CreateCommand;
    FGetListaEnderecosCommand_Cache.RequestType := 'GET';
    FGetListaEnderecosCommand_Cache.Text := 'TServerMethods1.GetListaEnderecos';
    FGetListaEnderecosCommand_Cache.Prepare(TServerMethods1_GetListaEnderecos_Cache);
  end;
  FGetListaEnderecosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTStringList.Create(FGetListaEnderecosCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetIdendereco(pIdPessoa: string; const ARequestFilter: string): string;
begin
  if FGetIdenderecoCommand = nil then
  begin
    FGetIdenderecoCommand := FConnection.CreateCommand;
    FGetIdenderecoCommand.RequestType := 'GET';
    FGetIdenderecoCommand.Text := 'TServerMethods1.GetIdendereco';
    FGetIdenderecoCommand.Prepare(TServerMethods1_GetIdendereco);
  end;
  FGetIdenderecoCommand.Parameters[0].Value.SetWideString(pIdPessoa);
  FGetIdenderecoCommand.Execute(ARequestFilter);
  Result := FGetIdenderecoCommand.Parameters[1].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FSetPessoaCommand.DisposeOf;
  FModifyPessoaCommand.DisposeOf;
  FDeletePessoaCommand.DisposeOf;
  FGetPessoaCommand.DisposeOf;
  FGetProximoCodigoPessoaCommand.DisposeOf;
  FSetEnderecoCommand.DisposeOf;
  FSetEnderecoIntegracaoCommand.DisposeOf;
  FModifyEnderecoCommand.DisposeOf;
  FModifyEnderecoIntegracaoCommand.DisposeOf;
  FGetProximoCodigoEnderecoCommand.DisposeOf;
  FGetEnderecoCommand.DisposeOf;
  FExisteEnderecoCommand.DisposeOf;
  FGetListaEnderecosCommand.DisposeOf;
  FGetListaEnderecosCommand_Cache.DisposeOf;
  FGetIdenderecoCommand.DisposeOf;
  inherited;
end;

end.

