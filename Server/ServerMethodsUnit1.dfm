object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 377
  Width = 367
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=teste'
      'User_Name=postgres'
      'Password=bzvxc29y'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 136
    Top = 80
  end
  object DataSetProvider1: TDataSetProvider
    Left = 136
    Top = 190
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 144
    Top = 190
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 216
    Top = 104
  end
  object FDSQLiteFunction1: TFDSQLiteFunction
    Left = 248
    Top = 184
  end
  object FDPessoa: TFDTable
    IndexFieldNames = 'idpessoa'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'pessoa'
    TableName = 'pessoa'
    Left = 160
    Top = 288
    object FDPessoaidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDPessoaflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object FDPessoadsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object FDPessoanmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object FDPessoanmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object FDPessoadtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FDQuery: TFDQuery
    Connection = FDConnection1
    Left = 32
    Top = 48
  end
  object FDEndereco: TFDTable
    IndexFieldNames = 'idendereco'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'endereco'
    TableName = 'endereco'
    Left = 272
    Top = 264
    object FDEnderecodscep: TWideStringField
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object FDEnderecoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDEnderecoidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
    end
  end
  object FDEndereco_Integracao: TFDTable
    IndexFieldNames = 'idendereco'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'endereco_integracao'
    TableName = 'endereco_integracao'
    Left = 288
    Top = 168
    object FDEndereco_Integracaoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDEndereco_Integracaodsuf: TWideStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 10
    end
    object FDEndereco_Integracaonmcidade: TWideStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object FDEndereco_Integracaonmbairro: TWideStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object FDEndereco_Integracaonmlogradouro: TWideStringField
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object FDEndereco_Integracaodscomplemento: TWideStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
end
