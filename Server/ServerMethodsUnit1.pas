unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait,
  FireDAC.Phys.SQLiteWrapper, FireDAC.Phys.SQLite, FireDAC.Comp.UI,
  Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, System.Variants;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDConnection1: TFDConnection;
    DataSetProvider1: TDataSetProvider;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDSQLiteFunction1: TFDSQLiteFunction;
    FDPessoa: TFDTable;
    FDQuery: TFDQuery;
    FDEndereco: TFDTable;
    FDPessoaidpessoa: TLargeintField;
    FDPessoaflnatureza: TSmallintField;
    FDPessoadsdocumento: TWideStringField;
    FDPessoanmprimeiro: TWideStringField;
    FDPessoanmsegundo: TWideStringField;
    FDPessoadtregistro: TDateField;
    FDEnderecodscep: TWideStringField;
    FDEnderecoidendereco: TLargeintField;
    FDEnderecoidpessoa: TLargeintField;
    FDEndereco_Integracao: TFDTable;
    FDEndereco_Integracaoidendereco: TLargeintField;
    FDEndereco_Integracaodsuf: TWideStringField;
    FDEndereco_Integracaonmcidade: TWideStringField;
    FDEndereco_Integracaonmbairro: TWideStringField;
    FDEndereco_Integracaonmlogradouro: TWideStringField;
    FDEndereco_Integracaodscomplemento: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    procedure SetPessoa(const pIdPessoa, pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome : String);
    procedure ModifyPessoa(const pIdPessoa, pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome : String);
    procedure DeletePessoa(const pIdPessoa: Integer);
    procedure GetPessoa(const pIdPessoa: integer; var pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome, pDataRegistro: String) ;
    function GetProximoCodigoPessoa(const pSQL: String): Integer;

    procedure SetEndereco(const pIdPEssoa,pIdEndereco, pCEP: String);
    procedure SetEnderecoIntegracao(const pIdEndereco, pUf, pCidade, pBairro, pLogradouro, pComplemento: String);

    procedure ModifyEndereco(const pIdPEssoa,pIdEndereco, pCEP: String);
    procedure ModifyEnderecoIntegracao(const pIdEndereco, pUf, pCidade, pBairro, pLogradouro, pComplemento: String);

    function GetProximoCodigoEndereco(const pSQL: String): Integer;
    procedure GetEndereco(const pIdPessoa, pIdEndereco: String; var pCep ,pUf, pCidade, pBairro, pLogradouro, pComplemento: String);
    function ExisteEndereco(const pSQL: String; var pidendereco: Integer): Boolean;
    function GetListaEnderecos: TStringList;
    function GetIdendereco(const pIdPessoa: String): String;

  end;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

procedure TServerMethods1.SetPessoa(const pIdPessoa, pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome : String);
begin
   FDPessoa.Open();
   FDPessoa.Insert;
   FDPessoaidpessoa.AsInteger := StrToInt(pIdPessoa);
   FDPessoaflnatureza.AsInteger := StrToInt(pNatureza);
   FDPessoadsdocumento.AsString := pDocumentio;
   FDPessoanmprimeiro.AsString := pPrimeiroNome;
   FDPessoanmsegundo.AsString := pSegundoNome;
   FDPessoadtregistro.AsDateTime := Date();
   FDPessoa.Post;
end;

procedure TServerMethods1.ModifyPessoa(const pIdPessoa, pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome : String);
begin
   FDPessoa.Open();
   FDPessoa.Locate('idpessoa', pIdPessoa, [loCaseInsensitive, loPartialKey]);
   FDPessoa.Edit;
   FDPessoaflnatureza.AsInteger := StrToInt(pNatureza);
   FDPessoadsdocumento.AsString := pDocumentio;
   FDPessoanmprimeiro.AsString := pPrimeiroNome;
   FDPessoanmsegundo.AsString := pSegundoNome;
   FDPessoa.Post;
end;

procedure TServerMethods1.DeletePessoa(const pIdPessoa: Integer);
begin
   FDPessoa.Open();
   FDPessoa.Locate('idpessoa', pIdPessoa, [loCaseInsensitive, loPartialKey]);
   FDPessoa.Delete;
end;

function TServerMethods1.GetProximoCodigoPessoa(const pSQL: String): Integer;
begin
   FDQuery.Open(pSQL);

   if FDQuery.FieldByName('Codigo').AsInteger <= 0 then
      Result := 1
   else
      Result := FDQuery.FieldByName('Codigo').AsInteger;
end;

function TServerMethods1.GetProximoCodigoEndereco(const pSQL: String): Integer;
begin
   FDQuery.Open(pSQL);

   if FDQuery.FieldByName('Codigo').AsInteger <= 0 then
      Result := 1
   else
      Result := FDQuery.FieldByName('Codigo').AsInteger;
end;

procedure TServerMethods1.GetPessoa(const pIdPessoa: integer; var pNatureza, pDocumentio, pPrimeiroNome, pSegundoNome, pDataRegistro: String) ;
begin
   FDPessoa.Open();
   FDPessoa.Locate('idpessoa', pIdPessoa, [loCaseInsensitive, loPartialKey]);
   pNatureza :=  FDPessoaflnatureza.AsString;
   pDocumentio :=  FDPessoadsdocumento.AsString;
   pPrimeiroNome :=  FDPessoanmprimeiro.AsString;
   pPrimeiroNome :=  FDPessoanmsegundo.AsString;
   pDataRegistro :=  FDPessoadtregistro.AsString;
end;

procedure TServerMethods1.SetEndereco(const pIdPEssoa,pIdEndereco, pCEP: String);
begin
   FDEndereco.Open();
   FDEndereco.Insert;
   FDEnderecoidpessoa.AsInteger := StrToInt(pIdPEssoa);
   FDEnderecoidendereco.AsInteger := StrToInt(pIdEndereco);
   FDEnderecodscep.AsString := pCEP;
   FDEndereco.Post;
end;


procedure TServerMethods1.ModifyEndereco(const pIdPEssoa,pIdEndereco, pCEP: String);
begin
   FDEndereco.Open();
   FDEndereco.Locate('idpessoa;idendereco', VarArrayOf([pIdPessoa,pIdEndereco]), []);

   FDEndereco.Edit;
   FDEnderecodscep.AsString := pCEP;
   FDEndereco.Post;
end;

procedure TServerMethods1.SetEnderecoIntegracao(const pIdEndereco, pUf, pCidade, pBairro, pLogradouro, pComplemento: String);
begin
   FDEndereco_Integracao.Open();
   FDEndereco_Integracao.Insert;
   FDEndereco_Integracaoidendereco.AsInteger := StrToInt(pIdEndereco);
   FDEndereco_Integracaodsuf.AsString := pUf;
   FDEndereco_Integracaonmcidade.AsString := pCidade;
   FDEndereco_Integracaonmbairro.AsString := pBairro;
   FDEndereco_Integracaonmlogradouro.AsString := pLogradouro;
   FDEndereco_Integracaodscomplemento.AsString := pComplemento;
   FDEndereco_Integracao.Post;
end;

procedure TServerMethods1.ModifyEnderecoIntegracao(const pIdEndereco, pUf, pCidade, pBairro, pLogradouro, pComplemento: String);
begin
   FDEndereco_Integracao.Open();
   FDEndereco_Integracao.Locate('idendereco', pIdEndereco, [loCaseInsensitive, loPartialKey]);

   FDEndereco_Integracao.Edit;
   FDEndereco_Integracaodsuf.AsString := pUf;
   FDEndereco_Integracaonmcidade.AsString := pCidade;
   FDEndereco_Integracaonmbairro.AsString := pBairro;
   FDEndereco_Integracaonmlogradouro.AsString := pLogradouro;
   FDEndereco_Integracaodscomplemento.AsString := pComplemento;
   FDEndereco_Integracao.Post;
end;


procedure TServerMethods1.GetEndereco(const pIdPessoa, pIdEndereco: String; var pCep ,pUf, pCidade, pBairro, pLogradouro, pComplemento: String);
begin
   FDEndereco.Open();
   FDEndereco.Locate('idpessoa;idendereco', VarArrayOf([pIdPessoa,pIdEndereco]), []);

   FDEndereco_Integracao.Open();
   FDEndereco_Integracao.Locate('idendereco', pIdEndereco, [loCaseInsensitive, loPartialKey]);

   pCep := FDEnderecodscep.AsString;
   pUf := FDEndereco_Integracaodsuf.AsString;
   pCidade := FDEndereco_Integracaonmcidade.AsString;
   pBairro := FDEndereco_Integracaonmbairro.AsString;
   pLogradouro := FDEndereco_Integracaonmlogradouro.AsString;
   pComplemento := FDEndereco_Integracaonmcidade.AsString;
end;

function TServerMethods1.ExisteEndereco(const pSQL: String; var pidendereco: Integer): Boolean;
begin
   FDQuery.Open(pSQL);
   Result := True;

   pidendereco := FDQuery.FieldByName('idendereco').AsInteger;

   if FDQuery.RecordCount <= 0 then
      Result := False;
end;

function TServerMethods1.GetListaEnderecos: TStringList;
var
   vListaEndereco: TStringList;
begin
   FDQuery.Open('SELECT idendereco, dscep FROM endereco');

   vListaEndereco := TStringList.Create;
   try
      while not FDQuery.Eof do
      begin
         vListaEndereco.Add(FDQuery.FieldByName('idendereco').AsString + ';' + FDQuery.FieldByName('dscep').AsString);
         FDQuery.Next;
      end;

      Result := vListaEndereco;
   finally
      vListaEndereco.Free;
   end;
end;

function TServerMethods1.GetIdendereco(const pIdPessoa: String): String;
begin
   FDQuery.Open('SELECT idendereco FROM endereco where idpessoa = ' + pIdPessoa);

   Result := FDQuery.FieldByName('idendereco').AsString;
end;

end.

