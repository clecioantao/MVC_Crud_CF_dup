CREATE TABLE PESSOA(
PessoaId int identity(1,1) not null,
NomePessoa varchar(60) not null,
EnderecoPessoa varchar(60) not null,
ComplementoPessoa varchar(60),
CidadeId int not null,
EstadoId int not null,
PRIMARY KEY (PessoaId)
)

CREATE TABLE CIDADE(
CidadeId int identity(1,1) not null,
NomeCidade varchar(60) not null,
PRIMARY KEY (CidadeId)
)

CREATE TABLE ESTADO(
EstadoId int identity(1,1) not null,
NomeEstado varchar(60) not null,
PRIMARY KEY (EstadoId)
)

ALTER TABLE CIDADE ADD CONSTRAINT TESTE FOREIGN KEY (CidadeId) references CIDADE(CidadeId)