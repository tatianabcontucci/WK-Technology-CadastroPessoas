unit uCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ClientClassesUnit1, ClientModuleUnit1,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, System.JSON, Vcl.Buttons;

  
type
  TfrmCadPessoa = class(TForm)
    PageControl1: TPageControl;
    tbCadastro: TTabSheet;
    Panel2: TPanel;
    pnlCliente: TPanel;
    lblPrimeiroNome: TLabel;
    lblCodigo: TLabel;
    Label1: TLabel;
    lblcgcCpf: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtPrimeiroNome: TEdit;
    cbNatureza: TComboBox;
    edtCgcCpf: TMaskEdit;
    edtSegundoNome: TEdit;
    edtDataRegistro: TMaskEdit;
    Panel1: TPanel;
    lblBairro: TLabel;
    lblCep: TLabel;
    Label6: TLabel;
    lblCidade: TLabel;
    lblLogradouro: TLabel;
    Label9: TLabel;
    edtCidade: TEdit;
    edtCep: TMaskEdit;
    edtBairro: TEdit;
    pnlRodape: TPanel;
    btExcluir: TButton;
    btAlterar: TButton;
    btInserir: TButton;
    edtLogradouro: TEdit;
    edtComplemento: TEdit;
    btSalvar: TButton;
    btcancelar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    edtUf: TEdit;
    Panel3: TPanel;
    btAtualizaIntegracaoEndereco: TButton;
    Button1: TButton;
    DiretorioArquivoPessoaLote: TOpenDialog;
    procedure btInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btcancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure cbNaturezaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure btAtualizaIntegracaoEnderecoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
    FServerMethods1Client: TServerMethods1Client;
    FSQL: String;
    FEndereco: TStringList;
    function GetProximoCodigoPessoa:  Integer;
    procedure CreateServerMethods1Client;
    procedure DestroyServerMethods1Client;
    procedure LimparCampos;
    procedure HabilitarDesabilitarCampos(const pHabilitaDesabilita: Boolean);
    procedure InserirPessoa;
    procedure AlterarPessoa;
    procedure ExcluirPessoa;
    procedure GetPessoa;
    function RemoverCaracterEspecial(const pTexto: String): String;
    procedure BuscarCEP(const pCep: String);
    procedure CarregarEnderecoCEP;
    function ValidarCampo: Boolean;
    procedure GravarEndereco;
    procedure CarregarEndereco(const pIdPessoa, pIdEndereco: String);
    procedure ImportarCSV(pArquivo: String);
    

  public
    { Public declarations }
  end;

var
  frmCadPessoa: TfrmCadPessoa;


implementation

{$R *.dfm}



procedure TfrmCadPessoa.btAlterarClick(Sender: TObject);
begin
   HabilitarDesabilitarCampos(True);
   btInserir.Tag := 0;
   btAlterar.Tag := 1;
   btInserir.Enabled := False;
   btSalvar.Enabled := True;
end;

procedure TfrmCadPessoa.btcancelarClick(Sender: TObject);
begin
   btInserir.Tag := 0;
   btAlterar.Tag := 0;
   HabilitarDesabilitarCampos(False);
   LimparCampos;
   btInserir.Enabled := True;
   btAlterar.Enabled := True;
   btSalvar.Enabled := False;
end;

procedure TfrmCadPessoa.btExcluirClick(Sender: TObject);
begin
   FServerMethods1Client.DeletePessoa(StrToInt(edtCodigo.Text));
end;

procedure TfrmCadPessoa.btInserirClick(Sender: TObject);
var
   vIdPessoa: Integer;
begin
   LimparCampos;
   edtCodigo.Text := IntToStr(GetProximoCodigoPessoa);
   HabilitarDesabilitarCampos(True);
   btInserir.Tag := 1;
   btAlterar.Enabled := False;
   btSalvar.Enabled := True;
   edtDataRegistro.Text := DateToStr(DAte())
end;

procedure TfrmCadPessoa.btSalvarClick(Sender: TObject);
begin
   if not ValidarCampo then
   begin
      Exit;
   end;

   if btInserir.Tag = 1 then
      InserirPessoa;

   if btAlterar.Tag = 1 then
      AlterarPessoa;

   GravarEndereco;

   btSalvar.Enabled := False;
   btInserir.Enabled := True;
   btAlterar.Enabled := True;
end;

procedure TfrmCadPessoa.cbNaturezaClick(Sender: TObject);
begin
   if cbNatureza.ItemIndex = 0 then
   begin
      lblcgcCpf.Caption := 'CPF';
      edtCgcCpf.EditMask := '999.999.999-99';
      edtCgcCpf.SetFocus;
   end
   else
   begin
      lblcgcCpf.Caption := 'CNPJ';
      edtCgcCpf.EditMask := '99.999.999/999-99';
      edtCgcCpf.SetFocus;
   end;
end;

function TfrmCadPessoa.GetProximoCodigoPessoa:  Integer;
begin
   try
      FSQL := 'SELECT MAX(idpessoa) + 1 AS codigo FROM pessoa';
      Result := FServerMethods1Client.GetProximoCodigoPessoa(FSQL);
   except
      Showmessage('N?o ? poss?vel realizar o Cadastro! Servidor Desconectado.');
   end;
end;

procedure TfrmCadPessoa.CreateServerMethods1Client;
begin

end;

procedure TfrmCadPessoa.DestroyServerMethods1Client;
begin
   FreeAndNil(FServerMethods1Client);
end;


procedure TfrmCadPessoa.edtCodigoExit(Sender: TObject);
begin
   GetPessoa;
end;

procedure TfrmCadPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   DestroyServerMethods1Client;
   FEndereco.Free;
end;

procedure TfrmCadPessoa.FormCreate(Sender: TObject);
begin
   CreateServerMethods1Client;
end;

procedure TfrmCadPessoa.FormShow(Sender: TObject);
begin
   try
      FServerMethods1Client := TServerMethods1Client.Create(ClientModule1.DSRESTConnection1);
   finally
      LimparCampos;
      HabilitarDesabilitarCampos(False);
   end;
end;

procedure TfrmCadPessoa.LimparCampos;
begin
   edtCodigo.Clear;
   cbNatureza.ItemIndex := -1;
   edtCgcCpf.Clear;
   edtPrimeiroNome.Clear;
   edtSegundoNome.Clear;
   edtDataRegistro.Clear;
   edtCep.Clear;
   edtUf.Clear;
   edtCidade.Clear;
   edtBairro.Clear;
   edtLogradouro.Clear;
   edtComplemento.Clear;

   if cbNatureza.CanFocus then
      cbNatureza.SetFocus;
end;

procedure TfrmCadPessoa.HabilitarDesabilitarCampos(const pHabilitaDesabilita: Boolean);
begin
   cbNatureza.Enabled := pHabilitaDesabilita;
   edtCgcCpf.Enabled := pHabilitaDesabilita;
   edtPrimeiroNome.Enabled := pHabilitaDesabilita;
   edtSegundoNome.Enabled := pHabilitaDesabilita;
   edtDataRegistro.Enabled := pHabilitaDesabilita;
   edtCep.Enabled := pHabilitaDesabilita;
   edtUf.Enabled := pHabilitaDesabilita;
   edtCidade.Enabled := pHabilitaDesabilita;
   edtBairro.Enabled := pHabilitaDesabilita;
   edtLogradouro.Enabled := pHabilitaDesabilita;
   edtComplemento.Enabled := pHabilitaDesabilita;
end;

procedure TfrmCadPessoa.InserirPessoa;
begin
   try          
      FServerMethods1Client.SetPessoa(edtCodigo.Text, IntToStr(cbNatureza.ItemIndex + 1), edtCgcCpf.Text, edtPrimeiroNome.Text,
         edtSegundoNome.Text);

      LimparCampos;
      HabilitarDesabilitarCampos(False);
      ShowMessage('Pessoa incluida com sucesso!');
   except
      Showmessage('Erro ao acessar o servidor');
   end;
end;

procedure TfrmCadPessoa.AlterarPessoa;
begin
   try
   FServerMethods1Client.ModifyPessoa(edtCodigo.Text, IntToStr(cbNatureza.ItemIndex + 1), edtCgcCpf.Text, edtPrimeiroNome.Text,
      edtSegundoNome.Text);
   Except
      Showmessage('N?o ? poss?vel realizar altera??es! Servidor Desconectado.');
   end;
end;

procedure TfrmCadPessoa.ExcluirPessoa;
begin
   try
      FServerMethods1Client.DeletePessoa(StrToInt(edtCodigo.Text));
   Except
      Showmessage('N?o ? poss?vel fazer a exclus?o! Servidor Desconectado.');
   end;
end;

function TfrmCadPessoa.RemoverCaracterEspecial(const pTexto: String): String;
var
   vCgcCpf: String;
begin
   vCgcCpf := StringReplace(pTexto, '.', '', [rfReplaceAll, rfIgnoreCase]);
   vCgcCpf := StringReplace(vCgcCpf, '-', '', [rfReplaceAll, rfIgnoreCase]);
   vCgcCpf := StringReplace(vCgcCpf, '/', '', [rfReplaceAll, rfIgnoreCase]);
   Result := vCgcCpf;
end;

procedure TfrmCadPessoa.GetPessoa;
var
   vNatureza, vdocumento, vPrimeiroNome, vSegundoNome, vDataRegistro, vIdEndereco: String;
begin
   try
      FServerMethods1Client.GetPessoa(StrToInt(edtCodigo.Text), vNatureza, vdocumento, vPrimeiroNome, vSegundoNome, vDataRegistro);
      cbNatureza.ItemIndex := StrToInt(vNatureza) - 1;
      edtCgcCpf.Text := vdocumento;
      edtPrimeiroNome.Text := vPrimeiroNome;
      edtSegundoNome.Text := vSegundoNome;
      edtDataRegistro.Text := vDataRegistro;

      vIdEndereco := FServerMethods1Client.GetIdendereco(edtCodigo.Text);
      if vIdEndereco <> EmptyStr then      
         CarregarEndereco(edtCodigo.Text, vIdEndereco);
   except
      Showmessage('N?o foi poss?vel localizar o cadastro! Servidor Desconectado');
   end;
end;

procedure TfrmCadPessoa.BuscarCEP(const pCep: string);
var
   data: TJSONObject;
begin
  RESTClient1.BaseURL := 'https://viacep.com.br/ws/' + pCep + '/json/';

  RESTRequest1.Execute;
  data := RESTResponse1.JSONValue as TJSONObject;
  try
    if FEndereco = nil then
      FEndereco := TStringList.Create;

    FEndereco.Clear;  
    if Assigned(data) then
    begin
        try
          FEndereco.Add(data.Values['logradouro'].Value);
        except
          on Exception do
            FEndereco.Add('');
        end;
        try
          FEndereco.Add(data.Values['bairro'].Value);
        except
         on Exception do
           FEndereco.Add('');
        end;
        try
          FEndereco.Add(data.Values['uf'].Value);
        except
         on Exception do
           FEndereco.Add('');
        end;
        try
          FEndereco.Add(data.Values['localidade'].Value);
        except
         on Exception do
           FEndereco.Add('');
        end;
        try
          FEndereco.Add(data.Values['complemento'].Value);
        except
         on Exception do
           FEndereco.Add('');
        end;
      end;
  finally
    FreeAndNil(data);
  end;
end;

procedure TfrmCadPessoa.Button1Click(Sender: TObject);
var
   vArquivo: String;
begin
   if DiretorioArquivoPessoaLote.Execute then
      vArquivo:= DiretorioArquivoPessoaLote.FileName;
   ImportarCSV(vArquivo);
end;

procedure TfrmCadPessoa.btAtualizaIntegracaoEnderecoClick(Sender: TObject);
var 
 vThreadEndereco : TThread;
 vListaEndereco: TStringList;
 vCep, vIdEndereco, vTexto: String;
begin
   vThreadEndereco := TThread.CreateAnonymousThread( procedure
   var
      vContador: Integer;
   begin

    vListaEndereco := TStringList.Create;
   try

      for vContador := 0 to vListaEndereco.Count do
      begin
        //Carrega o id e cep do encereco que ser? atualizado
        vTexto := vListaEndereco.Strings[vContador];
        vCep := Copy(vTexto, pos(';',vTexto)+1, length(vTexto));
        delete(vTexto,Pos(';', vTexto)+1, length(vCep)+1);
        vIdEndereco := Copy(vTexto, 1, pos(';',vTexto)-1);
  
        //Busca CEP atualiza API Via Cep 
        BuscarCEP(vCep);
         
        //Faz atualiza??o no banco de dados tabela endereco_integracao 
        FServerMethods1Client.ModifyEnderecoIntegracao(vIdEndereco,  FEndereco.Strings[2],  FEndereco.Strings[3],
             FEndereco.Strings[1],  FEndereco.Strings[0],  FEndereco.Strings[4]);
      end;
   finally
      vListaEndereco.Free;
   end;

  end);
  vThreadEndereco.start();
end;

function TfrmCadPessoa.ValidarCampo: Boolean;
begin
   Result := True;

   if cbNatureza.ItemIndex < 0 then
   begin
      Result := False;
      ShowMessage('Informe a natureza');
      if cbNatureza.CanFocus then
         cbNatureza.SetFocus;
      Exit;
   end;

   if edtCgcCpf.Text = EmptyStr then
   begin
      Result := False;
      ShowMessage('Informe o documento');
      if edtCgcCpf.CanFocus then
         edtCgcCpf.SetFocus;
      Exit;
   end;

   if edtPrimeiroNome.Text = EmptyStr then
   begin
      Result := False;
      ShowMessage('Informe o primeiro nome');
      if edtPrimeiroNome.CanFocus then
         edtPrimeiroNome.SetFocus;
      Exit;
   end;

   if edtSegundoNome.Text = EmptyStr then
   begin
      Result := False;
      ShowMessage('Informe o segundo nome');
      if edtSegundoNome.CanFocus then
         edtSegundoNome.SetFocus;
      Exit;
   end;
end;

procedure TfrmCadPessoa.GravarEndereco;
var
   vIdEndereco: Integer;
begin
   try
      FSQL := 'SELECT idendereco FROM Endereco where idpessoa = ' + edtCodigo.Text;
      if FServerMethods1Client.ExisteEndereco(FSQL, vIdEndereco) then
      begin
         FSQL := 'SELECT MAX(idendereco) + 1 AS codigo FROM endereco where idpessoa = ' + edtCodigo.Text;
         vIdEndereco := FServerMethods1Client.GetProximoCodigoEndereco(FSQL);
      
         FServerMethods1Client.SetEndereco(edtCodigo.Text, IntTostr(vIdEndereco), edtCep.Text);
         FServerMethods1Client.SetEnderecoIntegracao(intToStr(vIdEndereco), edtUf.Text, edtCidade.Text,
            edtBairro.Text, edtLogradouro.Text, edtComplemento.Text);
      end
      else
      begin
         FServerMethods1Client.ModifyEndereco(edtCodigo.Text, IntTostr(vIdEndereco), edtCep.Text);
         FServerMethods1Client.ModifyEnderecoIntegracao(IntToStr(vIdEndereco)
         , edtUf.Text, edtCidade.Text,
            edtBairro.Text, edtLogradouro.Text, edtComplemento.Text);
      end;
   except
      Showmessage('Erro ao acessar o servidor');
   end;
end;

procedure TfrmCadPessoa.edtCepExit(Sender: TObject);
var
   vCep: String;
begin
   vCep := RemoverCaracterEspecial(edtCep.Text);
   BuscarCEP(vCep); 
   CarregarEnderecoCEP; 
end;

procedure TfrmCadPessoa.CarregarEnderecoCEP;
begin
   edtUf.Text := FEndereco.Strings[2];
   edtCidade.Text := FEndereco.Strings[3];
   edtBairro.Text := FEndereco.Strings[1];
   edtLogradouro.Text := FEndereco.Strings[0];
   edtComplemento.Text := FEndereco.Strings[4];
end;

procedure TfrmCadPessoa.CarregarEndereco(const pIdPessoa, pIdEndereco: String);
var
 vCep ,vUf, vCidade, vBairro, vLogradouro, vComplemento: String;
begin
   FServerMethods1Client.GetEndereco(pIdPessoa, pIdEndereco, vCep ,vUf, vCidade, vBairro, vLogradouro, vComplemento );

   edtCep.Text := vCep;
   edtUf.Text := vUf;
   edtLogradouro.Text := vLogradouro;
   edtComplemento.Text := vComplemento;
   edtCidade.Text := vCidade;
end;


procedure TfrmCadPessoa.ImportarCSV(pArquivo: String);
var
  ArquivoCSV: TextFile;
  Contador, I: Integer;
  Linha: String;
  vIdPessoa, vNatureza, vDocumento, vPrimeiroNome, vSegundoNome: String;  
  
  //Le as colunas do CSV separado com ;
  function MontaValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then 
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;

begin
  // Carregando o arquivo ...
  AssignFile(ArquivoCSV, pArquivo);

  try
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);
    Contador := 1;

    while not Eoln(ArquivoCSV) do
    begin
      //Carrega Dados da pessoa do arquivo CSV
      vIdPessoa := IntToStr(GetProximoCodigoPessoa);
      vNatureza := MontaValor;
      vDocumento := RemoverCaracterEspecial(MontaValor);
      vPrimeiroNome := MontaValor;
      vSegundoNome := MontaValor;

      //Gravar tabela Pessoa
      FServerMethods1Client.SetPessoa(vIdPessoa, vNatureza,vDocumento, vPrimeiroNome, vSegundoNome);

      //faz a leitura da pr?xima linha do arquivo CSV
      Readln(ArquivoCSV, Linha);
      Contador := Contador + 1;
    end;

  finally
    CloseFile(ArquivoCSV);
  end;

end;


end.
