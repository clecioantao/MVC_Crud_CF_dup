/* SQL SERVER */

-- Tipos de dados: https://docs.microsoft.com/pt-br/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-2017

--- ****************************************************************************************************** ---

/* 1) OPERADORES DE COMPARAÇÃO - ARQUIVO: 1-operadores-comparacao */

--setando o banco de dados
    use curso;

--Usando operador = 
	SELECT * FROM   senso 
	WHERE  uf ='SP';

/*
comentarios
comentarios
*/

-- mesmo exemplo testando Collate 
-- link https://docs.microsoft.com/pt-br/sql/t-sql/statements/windows-collation-name-transact-sql?view=sql-server-2017

	SELECT * FROM   senso 
	WHERE  uf ='sp';
    
	SELECT * FROM   senso 
	WHERE  nome_mun ='Águas de Lindóia';

	SELECT * FROM   senso 
	WHERE  nome_mun ='Aguas de Lindoia';

--Outro exemplo operador = 
	SELECT * FROM   senso 
	WHERE nome_mun = 'Dourado'      
	AND uf = 'SP' 

--Usando operador > 
	SELECT * FROM   senso 
	WHERE  populacao > 100000 

--Usando operador > 
	SELECT * FROM   senso 
	WHERE  populacao > 1000000

--Usando operador < 
	SELECT * FROM   senso 
	WHERE  populacao < 10000 
--Usando operador < 
	SELECT * FROM   senso 
	WHERE  populacao < 50000;

--Usando operador <= 
	SELECT * FROM   senso 
	WHERE  populacao <= 10000; 
--Usando operador <= 
	SELECT * FROM   senso 
	WHERE  populacao <= 50000

--Usando operador <> 
	SELECT * FROM   senso 
	WHERE  uf <> 'SP'        
	AND uf <> 'SC'

--Combinando operadores 
	SELECT * FROM   senso 
	WHERE  populacao <= 100000        
		AND populacao >= 50000        
		AND uf = 'SP'        
		AND nome_mun <> 'Vinhedo';

--- ****************************************************************************************************** ---

/* 2) OPERADORES ARITIMÉTICOS - ARQUIVO: 2-operadores-matematicos */

USE AdventureWorks2017

--Operador + 
SELECT 1 + 3 as resultado;

--Operador * 
SELECT 3 * 2  as resultado;

--Operador - 
SELECT 5 - 2 as resultado;

--Operador / 
SELECT 15 / 3 as resultado
 
--Operador %  Mod
--mostra o restando da divisao
SELECT 12%5 as resultado;
--sobra zero
SELECT 12%4 as resultado

--
select ((1+4)*(3*3))/5 as resultado;

/*
Usando o operador de adição para calcular o número total de 
horas de ausência do trabalho para cada funcionário.
*/
use AdventureWorks2017;

SELECT  
		P.BusinessEntityID AS ID,
		p.firstname as nome,             
		p.lastname, 
		P.Demographics,            
		e.vacationhours,             
		e.sickleavehours,             
		e.vacationhours + e.sickleavehours AS 'Horas Ausente' 
FROM   humanresources.employee AS e 
    
	JOIN person.person AS p          
	ON e.businessentityid = p.businessentityid 
		GROUP BY p.BusinessEntityID
	ORDER  BY 'Horas Ausente' ASC;

--Usando subtração em uma instrução SELECT
SELECT Max(taxrate) as maximo,
       Min(taxrate) as minimo,
	   Max(taxrate) - Min(taxrate) AS 'Diferença na Taxa' 
FROM   sales.salestaxrate 
WHERE  stateprovinceid IS NOT NULL; 

/*
O exemplo a seguir recupera o número de identificação do produto, 
o nome, o preço de tabela e o novo preço de tabela de 
todas as bicicletas mountain bike na tabela Product. 
O novo preço de tabela é calculado usando o operador aritmético * 
para multiplicar ListPrice por 1.15.
*/

	SELECT  A.ProductID,        
			A.Name,        
			A.ListPrice,        
			A.ListPrice * 1.15 AS Novo_preco 
			FROM   production.product as a
				WHERE  NAME LIKE 'Mountain-%' 
	ORDER  BY productid ASC; 

/*
O exemplo a seguir usa o operador aritmético de divisão para 
calcular a meta de vendas mensal da equipe de vendas em Ciclos de 12 meses
*/

	SELECT  s.businessentityid AS SalesPersonID,        
			p.firstname,        
			p.lastname,        
			s.salesquota,        
			s.salesquota / 12    AS 'Meta Mensal' ,
			e.JobTitle
			FROM   sales.salesperson AS s        
				JOIN humanresources.employee AS e          
				ON s.businessentityid = e.businessentityid        
				JOIN person.person AS p          
				ON s.businessentityid = p.businessentityid
			where s.salesquota is not null;

/* clecio */
select * from sales.SalesPerson as s
join HumanResources.Employee as e
on s.BusinessEntityID =  e.BusinessEntityID
join Person.Person as p
on s.BusinessEntityID = p.BusinessEntityID
where s.SalesQuota is not null


/*
O exemplo a seguir divide o número 38 por 5. 
Isto resulta em 7 como a parte inteira do resultado = 7
e demonstra como o módulo retorna o resto de 3.
*/

	SELECT 38 / 5 AS Inteiro,        
	       38 % 5 AS Restante

--- ****************************************************************************************************** ---

/* 3) OPERADORES LÓGICOS E FILTROS - ARQUIVO: 3-operadores-logicos-filtros */
		   
--OPERADOR WHERE
use crm;
go	
	SELECT * FROM   
	cliente 
	WHERE  codigo_pais = 'BR';


--OPERADOR AND
	SELECT a.primeiro_nome 'Primeiro Nome',
	       a.ultimo_nome,
		   a.nascimento,
		   a.sexo,
		   a.etnia 
    from cliente a
	WHERE sexo='Female'
	and etnia='Eskimo';


--OPERADOR BETWEEN
	SELECT  a.primeiro_nome,
	        a.ultimo_nome,
			a.nascimento 
    from cliente a
	WHERE a.sexo='female'
	and a.nascimento between '1980-01-01' and '1990-12-31';

--OPERADOR IN
	SELECT a.primeiro_nome,
	       a.ultimo_nome,
		   a.id_profissao
    FROM CLIENTE a
	where a.id_profissao in ('91','191','151')

--OPERADOR NOT IN
	SELECT
	       a.primeiro_nome Nome,
	       a.ultimo_nome Sobrenome,
		   a.id_profissao,
		   a.etnia
	 FROM CLIENTE a
	where a.id_profissao not in ('91','191')
	and a.etnia in ('Eskimo','Lumbee');


--LIKE LOCALIZA VALORES QUE CONTENHAM "OR" EM QUALQUER LUGAR

	SELECT a.primeiro_nome,
	       a.ultimo_nome
   FROM   clientea
		WHERE  a.primeiro_nome LIKE '%or%'; 

--LIKE Encontra quaisquer valores que tenham "r" na segunda posição	
	SELECT a.primeiro_nome,
	       a.ultimo_nome
	 FROM   clientea
		WHERE  a.primeiro_nome LIKE '_r%'; 

--LIKE Localiza valores que começam com "a" e possuem pelo menos 3 caracteres de comprimento
	SELECT a.primeiro_nome,
	       a.ultimo_nome 
    FROM   cliente a
		WHERE  a.primeiro_nome LIKE 'A_%_%';

--LIKE Localiza valores que começam com "a" e termina com "o"
	SELECT a.primeiro_nome,
	       a.ultimo_nome 
   FROM   cliente a
		WHERE  a.primeiro_nome LIKE 'a%o'; 

--LIKE Localiza valores que começam com "a"	
	SELECT  a.primeiro_nome,
	       a.ultimo_nome  
	FROM   clientea
		WHERE  a.primeiro_nome NOT LIKE 'a%';

--OPERADOR LIKE CORINGA []

	SELECT 	primeiro_nome,ultimo_nome
			FROM   cliente
			WHERE  primeiro_nome LIKE '[CS]he%';


		SELECT 	primeiro_nome,ultimo_nome
			FROM   cliente
			WHERE  primeiro_nome LIKE 'he[CS]%';


	SELECT 	primeiro_nome,ultimo_nome
			FROM   cliente
			WHERE  primeiro_nome LIKE 'Lui[ZS]%';  
	
--OPERADOR NOT

USE curso;
		SELECT * FROM SENSO
			WHERE  NOME_MUN LIKE 'A%'        
			AND UF = 'SP'        
			AND NOT POPULACAO >10000;


--OPERADOR OR
		SELECT * FROM SENSO
		WHERE  POPULACAO < 50000        
		AND ( UF = 'AM' OR UF = 'PR' );

use AdventureWorks2017
--OPERADOR IS NULL
		SELECT  lastname,        
				firstname,        
				MiddleName 
		FROM   person.person 
		WHERE  MiddleName IS NULL; 

--OPERADOR IS not NULL
		SELECT  lastname,        
				firstname,        
				MiddleName 
		FROM   person.person 
		WHERE  MiddleName IS not NULL; 

--OPERADOR EXISTS

SELECT a.FirstName, a.LastName  
FROM Person.Person AS a  
WHERE EXISTS  
(SELECT *   
    FROM HumanResources.Employee AS b  
    WHERE a.BusinessEntityID = b.BusinessEntityID  
    AND a.LastName = 'Johnson');  
 	
--MESMO EXEMPLO UTILIZANDO IN
SELECT a.FirstName, a.LastName  
FROM Person.Person AS a  
WHERE a.LastName IN  
(SELECT a.LastName  
    FROM HumanResources.Employee AS b  
    WHERE a.BusinessEntityID = b.BusinessEntityID  
    AND a.LastName = 'Johnson'); 

--O exemplo a seguir mostra duas consultas para localizar lojas cujo nome seja igual ao de um fornecedor.
-- A primeira consulta usa EXISTS e a segunda usa =``ANY.
SELECT DISTINCT s.Name  
FROM Sales.Store AS s   
WHERE EXISTS  
(SELECT *  
    FROM Purchasing.Vendor AS v  
    WHERE s.Name = v.Name) ; 

--MESMO EXEMPLO UTILIZANDO ANY

SELECT DISTINCT s.Name  
FROM Sales.Store AS s   
WHERE s.Name = ANY  
(SELECT v.Name  
    FROM Purchasing.Vendor AS v ) ; 
	 
--OPERADOR IS NOT NULL
		SELECT  lastname,        
				firstname,        
				MiddleName 
		FROM   person.Person
		WHERE  MiddleName IS NOT NULL; 

use CURSO
--OPERADOR HAVING 
	SELECT  a.uf,
	        Count(a.cod_mun) as qtd_cidades
		   FROM   SENSO a
		   GROUP  BY  a.uf HAVING  Count(a.cod_mun) > 100
		   order by 1 asc;

	SELECT  a.uf estado,
	        Count(a.cod_mun) 'quantidade cidades'
		   FROM   SENSO a
		   GROUP  BY  a.uf HAVING  Count(a.cod_mun) > 100
		   order by 2 desc;

--OPERADOR HAVING 
		SELECT  a.uf ,       
				sum(a.populacao) as populacao
		FROM   senso a       
		GROUP  BY a.uf HAVING sum(a.populacao) < 1000000
		order by 2 desc; 

		SELECT  a.uf ,       
				sum(a.populacao) as populacao
		FROM   senso a       
		GROUP  BY a.uf HAVING sum(a.populacao) > 1000000
		order by 2 desc; 

--- ****************************************************************************************************** ---

/* 4) Definição DML - ARQUIVO: 1-dml 

DML - É um conjunto de instruções usada nas consultas e modificações dos dados armazenados nas tabelas do banco de dados.

Alguns Exemplos:

SELECT -> Recupera linhas do banco de dados e permite a seleção de uma
		  ou várias linhas ou colunas de uma ou várias tabelas 

INSERT -> Instrução utilizada para inserir dados a uma ou mais tabelas no banco de dados 

UPDATE -> Instrução utilizada para atualizar dados de uma ou mais tabelas no banco de dados

DELETE -> Instrução utilizada para excluir dados de uma ou mais tabelas no banco de dados

MERGE -> Realiza operações de inserção, atualização ou exclusão em uma tabela de 
	     destino com base nos resultados da junção com a tabela de origem

BULK INSET -> Importa um arquivo de dados em uma tabela ou exibição do banco de dados 
              em um formato especificado pelo usuário

*/

--DDL  CRIACAO DA TABELA PARA EXERCICIOS
USE CURSO;
GO

CREATE TABLE funcionarios
(
  ID int identity(1,1) NOT NULL PRIMARY KEY,
  NOME VARCHAR(50) NOT NULL,
  SALARIO DECIMAL(10,2),
  SETOR VARCHAR(30)
  );

--DML SELECT
--EXEMPLO SELECT
SELECT * FROM   funcionarios;
--EXEMPLO SELECT
	SELECT nome,setor 
	FROM   funcionarios; 

--EXEMPLO SELECT
	SELECT nome,setor depto
	FROM   funcionarios;

--DML INSERT
	INSERT INTO funcionarios VALUES  ('Joao',1000,''), ('Jose',2000,''),('Alexandre',3000,'') ;

--OU
	INSERT INTO funcionarios (nome,salario) VALUES ('Pedro',1000);

--simulando erro
   INSERT INTO funcionarios (nome,salario) VALUES ('Pedro','zaerre');

--simulando erro

  INSERT INTO funcionarios (salario) VALUES (2500);

--DML UPDATE
	UPDATE funcionarios SET    salario = '1500' 
	WHERE  id = '1';

--OU Aumento de 50% sobre Salário atual.
	UPDATE funcionarios SET    salario = salario*1.5 
	WHERE  id = '1'; 

--exemplo update com mais de um campo
	UPDATE funcionarios SET    salario = salario*1.5, setor='TI'
	WHERE  id <> '1'; 

--DML DELETE
	DELETE funcionarios 
	where id='1';

--- ****************************************************************************************************** ---

/* 5) Definição DDL 

DDL (Linguagem de Definição de Dados) – É um conjunto de instruções usado para criar 
    e modificar as estruturas dos objetos armazenados no banco de dados.

Alguns Exemplos:

ALTER -> Use as instruções ALTER para modificar a definição de entidades existentes. 
         Use ALTER TABLE para adicionar uma nova coluna a uma tabela ou use ALTER DATABASE                                   para definir opções do banco de dados.

CREATE -> Use instruções CREATE para definir novas entidades. Use CREATE TABLE para adicionar 
          uma nova tabela em um banco de dados.

DROP -> Use instruções DROP para remover entidades existentes. Use DROP TABLE para remover 
        uma tabela de um banco de dados.

DISABLE TRIGGER -> Desabilita uma Trigger DML, DDL ou de logon.

ENABLE TRIGGER -> Habilita uma Trigger DML, DDL ou de logon.

TRUNCATE TABLE -> Remove todas as linhas de uma tabela sem registrar as exclusões de 
                  linhas individuais.

UPDATE STATISTICS -> Atualiza estatísticas de otimização de consulta de uma tabela 
                     ou view indexada.

*/

--DDL CRIANDO TABELA
use curso;
GO

CREATE TABLE colaborador   
(      
		matricula INT IDENTITY(1,1) not null,
	    nome      VARCHAR(50) NOT NULL,      
		sobrenome VARCHAR(50) NOT NULL,      
		endereco  VARCHAR(50),      
		cidade    VARCHAR(50),      
		pais      VARCHAR(25),      
		data_nasc DATE not null check(data_nasc<getdate()),
		data_cadastro datetime default getdate(),
		situacao char(1) default('A')
		);

--DDL CRIANDO TABELA COM CHAVE ESTRANGEIRA
CREATE TABLE salario   
(      
	matricula INT PRIMARY KEY NOT NULL,      
	salario   DECIMAL(10, 2) NOT NULL check (salario>0)
    FOREIGN KEY(matricula) REFERENCES colaborador(matricula)
  ) ;
--CORRINGO ERRO PRA CRIAR A TABELA SALARIO
--DDL PARA ADICIONAR CHAVE PRIMARIA NA TAB colaborador
  ALTER TABLE colaborador ADD PRIMARY KEY (MATRICULA);

--DDL CRIACAO DE TABELA COM CHAVE PRIMARIA
CREATE TABLE audit_salario   
	(  
		transacao int identity(1,1)NOT NULL PRIMARY KEY,    
		matricula  INT NOT NULL,      
		data_trans DATETIME NOT NULL,      
		sal_antigo DECIMAL(10, 2),      
		sal_novo   DECIMAL(10, 2), 
		Usuario    varchar(20)not null   
		);

 -- ADD CHAVE ESTRANGEIRA

ALTER TABLE audit_salario
ADD FOREIGN KEY (matricula) REFERENCES colaborador(matricula); 

--TENTANDO EXCLUIR A TABELAS COLABORADOR 
DROP TABLE colaborador;

--DDL CRIACAO DE INDEX
 CREATE INDEX ix_func1 ON colaborador(data_nasc);
 CREATE INDEX ix_func2 ON colaborador(cidade,pais);

 --Adicionando novo campo na tabela 
 ALTER TABLE colaborador ADD genero CHAR(1); 
 
 --Renomeando campo da tabela
 --EXEC sp_rename 'TABELA_ORIGEM.CAMPO_ORIG', 'Campo_orig', 'COLUMN'

EXEC Sp_rename 'colaborador.endereco', 'ender', 'COLUMN' 

--Alterando tipo da coluna
ALTER TABLE colaborador ALTER COLUMN ender VARCHAR(30);
   
--Excluindo campo da coluna
ALTER TABLE colaborador DROP COLUMN genero; 

--Excluindo chave estrangeira
ALTER TABLE salario
DROP CONSTRAINT FK__salario__salario__0E6E26BF; 
   
--Renomeando Tabela
--EXEC sp_rename   'Nome Antigo', 'Nome Novo'
EXEC Sp_rename   'colaborador','FUNC';

EXEC Sp_rename   'FUNC','colaborador';

--DDL CRIACAO DE DATABASE
CREATE DATABASE TESTE;

--Excluindo database

DROP DATABASE TESTE; 

--Excluindo table
DROP TABLE SALARIO;

--CRIACAO DE VIEW
	CREATE VIEW v_colaborador
	AS
	SELECT * FROM colaborador;

--ALTER VIEW
	ALTER VIEW v_colaborador
	AS 
	SELECT matricula,NOME FROM colaborador

--Excluindo VIEW
DROP VIEW v_colaborador; 
--Excluindo index
DROP index ix_func1 ON colaborador;
--CRIANDO INDEX
CREATE INDEX IX_FUNC1 ON colaborador (NOME)
--Excluindo procedure
DROP PROCEDURE proc_salario; 
--Excluindo Função
DROP function func_salario;
--Excluindo Trigger
DROP trigger trig_func_salario;

--DDL TRUNCATE
SELECT * into senso_bk from senso;
-- verifcando dados;

select * from senso_bk;
--realizando truncate
TRUNCATE TABLE	 senso_bk;

--DDL TRUNCATE VERIFICANDO

--FAZENDO BK EM TABELA TEMPORARIA
SELECT * INTO #BK_SENSO2 FROM SENSO;
--VERIFCANDO REGISTRO TABELA TEMPORARIA
SELECT * FROM #BK_SENSO2;

--ANALISE DE REGISTROS ANTES DO TRUNCATE
SELECT Count(*) AS AntesTruncateCount 
FROM   #BK_SENSO2; 

--DDL TRUNCATE APAGAR DADOS DA TABELA
TRUNCATE TABLE SENSO;
 
--VERIFICANDO TABELAS APOS TRUNCATE
SELECT Count(*) AS DepoisTruncateCount 
FROM   SENSO; 

--POPULANDO A TABELA COM DADOS DA TABELA TEMPORARIA
 insert into SENSO
 select * from #BK_SENSO2
--verifanco registro 
 select * from SENSO;

	--- ****************************************************************************************************** ---

/* 5) Definição DCL 

DCL (Linguagem de Controle de Dados) – São usados para controle de acesso e gerenciamento 
de permissões para usuários em no banco de dados. Com eles, pode facilmente permitir 
ou negar algumas ações para usuários nas tabelas ou registros (segurança de nível de linha).

Alguns Exemplos:

GRANT -> Atribui privilégios de acesso do usuário a objetos do banco de dados.

REVOKE -> Remove os privilégios de acesso aos objetos obtidos com o comando GRANT.

DENY -> O comando é usado para impedir explicitamente que um usuário receba uma 
        permissão específica.

*/

-- Parte 1 CONCEDE-GRANT
-- Cria um login e dá permissões no banco

exec master.dbo.sp_addlogin 'UsrTeste','SenhaTeste';

use curso;
go
--Adiocnar
EXEC sp_grantdbaccess 'UsrTeste';

--EXEC sp_revokedbaccess 'UsrTeste';

--Concedendo Acesso DE ATUALIZACAO PARA UsrTeste.
GRANT UPDATE ON FUNCIONARIOS TO UsrTeste; 

--Concedendo Acesso DE INSERT PARA UsrTeste.
GRANT INSERT ON FUNCIONARIOS TO UsrTeste; 

--Concedendo Acesso DE Leitura PARA UsrTeste.
GRANT SELECT ON FUNCIONARIOS TO UsrTeste;

--Concedendo Acesso DE DELETE PARA UsrTeste.
GRANT DELETE ON FUNCIONARIOS TO UsrTeste;

--criando procedure

CREATE PROCEDURE testproc 
as
select * from senso

--executando procedure
EXEC testproc

--Concedendo Acesso PARA EXCUTAR PROC TESTE_PROC PARA UsrTeste.
GRANT EXECUTE ON testproc TO UsrTeste  

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--ALTERANDO USUARIO LOGADO

SETUSER 'UsrTeste'
--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--EXECUTANDO PROCEDURE COM USUARIO UsrTeste
EXEC testproc

--TESTANDO SELECT
SELECT  * from FUNCIONARIOS;

--TESTANDO INSERT
INSERT into FUNCIONARIOS values ('Maria','1000','TI')

--TESTANDO UPDATE
UPDATE FUNCIONARIOS set nome='Maisa'
where id='9';

--TESTANDO DELETE
DELETE FROM FUNCIONARIOS
WHERE ID='9';

SETUSER 

select CURRENT_USER;

-- PARTE 2 REVOGA-REVOKE

select  CURRENT_USER

--REVOGANDO Acesso DE ATUALIZACAO UsrTeste.
REVOKE UPDATE ON FUNCIONARIOS to UsrTeste; 

-- REVOGANDO Acesso DE inserção UsrTeste.
REVOKE INSERT ON FUNCIONARIOS TO UsrTeste; 

-- REVOGANDO Acesso DE Leitura UsrTeste.
REVOKE SELECT ON FUNCIONARIOS TO UsrTeste; 

--REVOGA DIREITO DE EXECUCAO DA PROC TESTE_PROC PARA UsrTeste.
REVOKE EXECUTE ON testproc TO UsrTeste ;

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--EXEC sp_grantdbaccess 'UsrTeste','UsrTeste'

--EXEC sp_revokedbaccess 'UsrTeste'

--ALTERANDO USUARIO LOGADO
SETUSER 'UsrTeste'

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--EXECUTANDO PROCEDURE COM USUARIO UsrTeste
EXEC testproc;

--TESTANDO SELECT
SELECT  * from FUNCIONARIOS

--TESTANDO INSERT
INSERT into FUNCIONARIOS values ('Maria','1000','TI')

--TESTANDO UPDATE
UPDATE FUNCIONARIOS set nome='Marilia'
where id='8';

--TESTANDO DELETE
DELETE FROM FUNCIONARIOS
WHERE ID='8'

setuser;

select CURRENT_USER

--3 PARTE NEGA-DENY
--NEGANDO Acesso DE ATUALIZACAO UsrTeste.
DENY UPDATE ON FUNCIONARIOS TO UsrTeste; 

-- NEGANDO Acesso DE ATUALIZACAO UsrTeste.
DENY INSERT ON FUNCIONARIOS TO UsrTeste;
 
-- NEGANDO Acesso DE Leitura UsrTeste.
DENY SELECT ON FUNCIONARIOS TO UsrTeste;

--NEGA ACESSO A EXECUSSAO DE PROCEDURE
DENY EXECUTE ON testproc TO UsrTeste;

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER;

--ALTERANDO USUARIO LOGADO
SETUSER 'UsrTeste'

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--EXECUTANDO PROCEDURE COM USUARIO UsrTeste
EXEC testproc

--TESTANDO SELECT
SELECT  * from FUNCIONARIOS;

--TESTANDO INSERT
INSERT into FUNCIONARIOS values ('Maria','1000','TI');

--TESTANDO UPDATE
UPDATE FUNCIONARIOS set nome='Marilia'
where id='7';

--TESTANDO DELETE
DELETE FROM FUNCIONARIOS
WHERE ID='7';

setuser;

select CURRENT_USER

--- ****************************************************************************************************** ---

/* 6) Definição TCL 

TCL (Linguagem de Controle de Transações) – São usados ​​para gerenciar as mudanças feitas por 
instruções DML . Ele permite que as declarações a serem agrupadas em transações lógicas.

Alguns Exemplos:

COMMIT -> É usado para salvar permanentemente qualquer transação no banco de dados.

ROLLBACK -> Este comando restaura o banco de dados para o último estado commited.

BEGIN TRANSACTION -> Marca o ponto inicial de uma transação local explícita. 
                     As transações explícitas começam com a instrução BEGIN TRANSACTION e 
					 terminam com a instrução COMMIT ou ROLLBACK.

*/

-- PARTE 1
-- criando tabela de teste
create table cadastro
(
 nome varchar(50) not null,
 docto varchar(20) not null
 );

--INICIA TRANSAÇÃO
BEGIN TRANSACTION ;

--INSERE REGISTROS
INSERT INTO cadastro VALUES      ('Andre', '12341244');
INSERT INTO cadastro VALUES      ('Joao',  '12341248');
INSERT INTO cadastro VALUES      ('Pedro', '12341246');

--SELECT DOS REGISTRO INSERIDOS
SELECT * FROM   cadastro ;

--RETORNA O TABELA NAO ESTADO ANTERIOR DO BEGIN TRANSACTION
ROLLBACK ;

--EFETIVA AS INFORMACOES NA TABELAS DO BANCO DE DADOS
COMMIT TRANSACTION;

--SELECT DOS REGISTRO INSERIDOS
SELECT * FROM   cadastro ;

-- PARTE 2

--limpando a tabela
delete from cadastro;
--INICIA TRANSACAO

BEGIN TRANSACTION 
--INSERE REGISTRO
INSERT INTO cadastro  VALUES ('Andre', '12341244') ;
--CRIA UM PONTO DE RECUPERACAO
SAVE TRANSACTION a1;
--INSERE REGISTRO
INSERT INTO cadastro  VALUES ('Joao','12341244') ;
--CRIA UM PONTO DE RECUPERACAO
SAVE TRANSACTION a2 ;
--INSERE REGISTRO
INSERT INTO cadastro VALUES ('Pedro', '12341244') ;
--CRIA UM PONTO DE RECUPERACAO
SAVE TRANSACTION a3 ;

--VERIFICA REGISTROS
SELECT * FROM   cadastro;

--RESTAURA A TABELA ATE O PONTO A2 
ROLLBACK TRANSACTION a2 ;

--VERIFICA REGISTROS
SELECT * FROM   cadastro;

--RETORNA A TABELA NO ESTADO ANTERIOR AO BEGIN TRANSACTION
ROLLBACK ;

--EFETIVA AS INFORMAÇOES NA TABELA
COMMIT TRANSACTION;

--VERIFICA REGISTROS
SELECT * FROM   cadastro;

--- ****************************************************************************************************** ---

/* 7)  Union e Union all

Combina os resultados de duas ou mais consultas em um único conjunto de resultados, 
que inclui todas as linhas pertencentes a todas as consultas da união. 
A operação UNION é diferente de usar junções que combinam colunas de duas tabelas.

*/

use curso;

	--SIMULANDO ERRO UNION
	SELECT 1,1
	UNION 
	SELECT 'A',2

	-- CORRETO
	SELECT '1',1
	UNION 
	SELECT 'A',2

--exemplo

	SELECT '1',1
	UNION 
	SELECT '1',1

--EXEMPLO USANDO UNION
	USE AdventureWorks2017;

	SELECT CITY
	FROM   PERSON.ADDRESS
	WHERE AddressID<15000

	UNION 

	SELECT CITY  
	FROM   PERSON.ADDRESS
	WHERE AddressID>=15000
	ORDER BY CITY;

----EXEMPLO USANDO UNION ALL

	SELECT a.City, a.AddressID
	FROM   PERSON.ADDRESS a
	WHERE AddressID<15000

	UNION 

	SELECT a.City, a.AddressID  
	FROM   PERSON.ADDRESS a
	WHERE AddressID>=15000
	ORDER BY City;

--EXEMPLO COM UNION
   USE CRM;
	SELECT cidade,        
		   codigo_pais 
	FROM   CLIENTE 
		WHERE  codigo_pais = 'US' 
		
	UNION
	 
	SELECT cidade,        
		   codigo_pais 
	FROM   CLIENTE 
		WHERE  codigo_pais = 'BR' 
	ORDER  BY cidade;

--EXEMPLO COM UNION ALL
	SELECT cidade,        
		   codigo_pais 
	FROM   CLIENTE 
		WHERE  codigo_pais = 'US' 
		
	UNION ALL
	 
   SELECT  cidade,        
		   codigo_pais 
	FROM   CLIENTE 
		WHERE  codigo_pais = 'BR' 
	ORDER  BY cidade

--- ****************************************************************************************************** ---

/* 8)  SUBQUERYS */

use crm;

-- dar direito para usuario criar diagrama
select SYSTEM_USER
ALTER AUTHORIZATION ON DATABASE::CRM TO "PAVILION\Clecio";

Go
--exemplo subquerys
	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.sexo 
		   from  cliente a
	 where a.id_cliente in (select b.id_cliente from carro_cliente b where b.ano='2010');

-- exemplo (Clecio) da mesma query acima, porém com possibilidade de trazer campos da outra tabela
	 select a.id_cliente,
			a.primeiro_nome,
			a.ultimo_nome,
			a.sexo,
			b.ano
	 from cliente a
	 join carro_cliente b on a.id_cliente = b.id_cliente
	 where b.ano = '2010'

--exemplo subquerys

	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.sexo 
		   from cliente a
	 where a.id_cliente in (select b.id_cliente from carro_cliente b where b.ano='2005'
	  and b.id_carro in (select c.id_carro from carro_montadora c where c.id_montadora=2));

-- exemplo (Clecio) da mesma query acima, porém com possibilidade de trazer campos da outra tabela

	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.sexo,
		   b.ano as ano_carro,
		   c.nome_carro
		   from cliente a
		   join carro_cliente b on a.id_cliente =  b.id_cliente
		   join carro_montadora c on b.id_carro = c.id_carro 
		   where b.ano = '2005' and c.id_montadora = 2
		   order by a.id_cliente

--exemplo subquery 

	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.sexo,
		   (select b.nome_carro 
				   from carro_montadora b
				   inner join carro_cliente c
				   on b.id_carro=c.id_carro
				   and a.id_cliente=c.id_cliente) as nome_carro
			from cliente a;
	

	-- retornando o nome do carro com subselect
	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.sexo,
		   (select b.nome_carro 
				   from carro_montadora b
				   inner join carro_cliente c
				   on b.id_carro=c.id_carro
				   and a.id_cliente=c.id_cliente) as nome_carro
			from cliente a;

	-- retornando pais com subselect

	select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.codigo_pais,
		   (select b.nome_pais from pais b where a.codigo_pais=b.codigo_pais) as nome_pais
		   from cliente a

	--trazendo o pais e o idioma com subselect,nome_pais

		select a.id_cliente,
		   a.primeiro_nome,
		   a.ultimo_nome,
		   a.codigo_pais,
		   (select b.nome_pais from pais b where a.codigo_pais=b.codigo_pais) as nome_pais,
		   (select top 1 b.idioma from idiomas b where a.id_cliente=b.id_cliente) as idioma
		   from cliente a;
			
--subselect com funções de agregação
	select a.id_montadora,a.nome_carro,
	(select AVG(b.ano) from carro_cliente b where a.id_carro=b.id_carro) media_ano,
	(select MIN(b.ano) from carro_cliente b where a.id_carro=b.id_carro) mais_antigo,
	(select MAX(b.ano) from carro_cliente b where a.id_carro=b.id_carro) mais_novo,
	(select count(*) from carro_cliente b where a.id_carro=b.id_carro) qtd
	from 
	carro_montadora a;

	--criando cenario para fazer update com subselect
	alter table carro_montadora add  qtd int;

	--verificando informacao da da tabels

	select * from carro_montadora;

	--criado update para contar qtd de carros que os clientes possuem modelo

	begin transaction
	  update carro_montadora set qtd=(select count(*) as qtd from carro_cliente b
	  inner join  carro_montadora c on
	  c.id_carro=b.id_carro
	  and carro_montadora.id_carro=b.id_carro
	  group by b.id_carro);

	 -- correto commit
	 commit;

	 -- erro Rollback

	 Rollback

--drop coluna
	alter table carro_montadora drop COLUMN  qtd;

-- exemplo delete com subselect
begin transaction 

delete  carro_cliente
where id_cliente in (select id_cliente from cliente where codigo_pais='BR');

Rollback;

 select * from carro_cliente;

 --- ****************************************************************************************************** ---

/* 9)  JOIN (JUNÇÕES)  */

create database curso
use curso;
--drop table alunos
--CRIACAO DE TABELA ALUNOS
--drop table alunos
--drop table disciplina
--drop table matricula
create table alunos
(id_aluno int identity(1,1),
 nome varchar(20) not null
 );
 --drop table disciplina
create table disciplina
(
 id_disciplina int identity(1,1),
 nome_disc varchar(20)
 );
 --drop table matricula
 create table matricula
 (id_aluno int,
  id_disciplina int,
  periodo varchar(10)
  );

  --ALTERANDO TABELA CAMPO ID_ALUNO PARA NAO PERMITIR NOT NULL
  ALTER TABLE MATRICULA ALTER COLUMN id_aluno INT NOT NULL;
  --ALTERANDO TABELA 
  ALTER TABLE MATRICULA ALTER COLUMN id_disciplina INT NOT NULL;

  --CRIANDO CHAVE PRIMARIA COMPOSTA
  ALTER TABLE MATRICULA ADD CONSTRAINT PK_1 PRIMARY KEY (ID_ALUNO,id_disciplina);
  alter table matricula add constraint PK_1 PRIMARY KEY (id_aluno, id_disciplina)
 --ADICIONANDO CHAVE PRIMARIA TABELA DISCIPLINA
  ALTER TABLE DISCIPLINA ADD CONSTRAINT PK2 PRIMARY KEY (id_disciplina);
  alter table disciplina ADD CONSTRAINT PK_2 PRIMARY KEY (id_disciplina)
  --ADICIONANDO CHAVE PRIMARIA TABELA ALUNOS
  ALTER TABLE ALUNOS ADD CONSTRAINT PK1 PRIMARY KEY (ID_ALUNO);
  ALTER TABLE ALUNOS ADD CONSTRAINT PK1 PRIMARY KEY (ID_ALUNO)
  
  --ADICIONANDO CHAVE ESTRANGEIRA NA TABELA MATRICULA CAMPO ID_ALUNO
  ALTER TABLE MATRICULA 
  ADD CONSTRAINT FK_MAT1 FOREIGN KEY  (ID_ALUNO) REFERENCES ALUNOS(ID_ALUNO);
  ALTER TABLE MATRICULA 
  ADD CONSTRAINT FK_MAT1 FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(ID_ALUNO)

  -- APAGANDO CONSTRAINT FOREIGN KEY 
  ALTER TABLE MATRICULA DROP CONSTRAINT FK_MAT1

  --ADICIONANDO CHAVE ESTRANGEIRA NA TABELA MATRICULA CAMPO ID_ALUNO
  ALTER TABLE MATRICULA 
  ADD CONSTRAINT FK_MAT2 FOREIGN KEY  (id_disciplina) REFERENCES DISCIPLINA(id_disciplina);

  
  --INSERINDO REGISTRO ALUNOS
  insert into alunos values ('Joao'),('Maria'),('Pedro'),('Tiago'),('Henrique');

  SELECT * FROM alunos;

  --INSERINDO REGISTRO DISCIPLINAS
  insert into disciplina values 
  ('Fisica'),('Quimica'),('Matematica'),('Banco de Dados'),('Programacao');
  
  SELECT * FROM disciplina;

  --INSERINDO MATRICULAS DE ALUNOS
  insert into matricula values ('1','1','Noturno');
  insert into matricula values ('1','2','Vespertino');
  insert into matricula values ('1','3','Matutino');

  insert into matricula values ('2','3','Noturno');
  insert into matricula values ('2','4','Noturno');

  insert into matricula values ('3','1','Noturno');
  insert into matricula values ('3','3','Noturno');
  insert into matricula values ('3','4','Noturno');

  insert into matricula values ('5','1','Matutino');
  insert into matricula values ('5','2','Vespertino');
  insert into matricula values ('5','4','Noturno');

--simulando erros
  insert into matricula values ('6','6','Noturno');

  insert into matricula values ('5','4','Noturno');

  --ALUNO CODIG 4 NAO TEM MATRICULA
  --DISCIPLINA 5 NAO TEM ALUNOS

  --INNER JOIN

  select a.id_aluno,
		 a.nome,
		 c.id_disciplina,
         c.nome_disc,
		 b.periodo
  from alunos a
  inner join matricula b 
  on a.id_aluno=b.id_aluno
  inner join disciplina c
  on b.id_disciplina=c.id_disciplina;
  --on b.id_disciplina=b.id_aluno;

  -- Testando apenas com JOIN - Clecio
  select a.id_aluno,
		 a.nome,
		 c.id_disciplina,
         c.nome_disc,
		 b.periodo
  from alunos a
  join matricula b 
  on a.id_aluno=b.id_aluno
  join disciplina c
  on b.id_disciplina=c.id_disciplina;
  --on b.id_disciplina=b.id_aluno;

  --LEFT JOIN

  select a.id_aluno,
		 a.nome,
		 c.id_disciplina,
         c.nome_disc,
		 b.periodo
  from alunos a
  left join matricula b 
  on a.id_aluno=b.id_aluno
  left join disciplina c
  on b.id_disciplina=c.id_disciplina
  --where c.id_disciplina is null /* by clecio */
  
 --RIGHT JOIN
  select a.id_aluno,
		 a.nome,
		 c.id_disciplina,
         c.nome_disc,
		 b.periodo
  from alunos a
  right join matricula b 
  on a.id_aluno=b.id_aluno
  right join disciplina c
  on b.id_disciplina=c.id_disciplina
  order by a.id_aluno asc;

  --FULL JOIN
  select a.id_aluno,
		 a.nome,
		 c.id_disciplina,
         c.nome_disc,
		 b.periodo
  from alunos a
  full join matricula b 
  on a.id_aluno=b.id_aluno
  full join disciplina c
  on b.id_disciplina=c.id_disciplina;

--INNER JOIN
--Testando seus conhecimentos
use crm;

SELECT a.id_cliente, 
       a.primeiro_nome,
	   a.codigo_pais,
	   b.ano,
	   c.nome_carro,
	   d.nome_montadora
	   from cliente a
	   inner join carro_cliente b
	   on a.id_cliente=b.id_cliente
	   
	   inner join  carro_montadora c
	   on b.id_carro=c.id_carro
       
	   inner join montadora d
	   on c.id_montadora=d.id_montadora;

--INNER JOIN
use AdventureWorks2017;

select a.BusinessEntityID,
       a.FirstName,
	   a.LastName,
	   b.JobTitle,
	   a.PersonType
from Person.Person a 
inner join HumanResources.Employee b
on a.BusinessEntityID=b.BusinessEntityID;

--verficando dados tabela person
select * from Person.Person

--Rigth Join
select a.BusinessEntityID,a.FirstName,a.LastName,b.JobTitle, a.PersonType
from Person.Person a 
Right join HumanResources.Employee b
on a.BusinessEntityID=b.BusinessEntityID;

--left Join
select a.BusinessEntityID,a.FirstName,a.LastName,b.JobTitle, a.PersonType
from Person.Person a 
left join HumanResources.Employee b
on a.BusinessEntityID=b.BusinessEntityID

--FULL JOIN
select a.BusinessEntityID,a.FirstName,a.LastName,b.JobTitle, a.PersonType
from Person.Person a 
FULL join HumanResources.Employee b
on a.BusinessEntityID=b.BusinessEntityID

 --- ****************************************************************************************************** ---

/* 9)  FUNÇÕES DE AGREGAÇÃO  */

--conhecendo as tabelas
use curso;
select top 5 * from senso
select top 5 * from uf
select TOP 5 * from regiao

--AVG Retorna a média dos valores em um grupo. Valores nulos são ignorados
select AVG(populacao) from senso;

--AVG MEDIA POR ESTADO

SELECT UF,AVG(POPULACAO) AS QTD FROM senso
GROUP BY UF
ORDER BY 1

--AVG POR REGIAO

SELECT B.regiao, AVG(a.POPULACAO) AS POP
	FROM senso A
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY B.regiao 
ORDER BY 2 desc

--MIN Retorna o valor mínimo na expressão. Pode ser seguido pela cláusula OVER
select MIN(populacao) from senso;

--MIN  POR ESTADO

SELECT UF,MIN(POPULACAO) 
	FROM senso
GROUP BY UF
ORDER BY 2

--MIN POR REGIAO

SELECT B.regiao,MIN(POPULACAO) FROM senso A
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY B.regiao
ORDER BY 2

--MAX Retorna o valor máximo na expressão
select MAX(populacao) from senso

--MAX  POR ESTADO

SELECT UF,MAX(POPULACAO) FROM senso
GROUP BY UF
ORDER BY 2 DESC

select s.uf , max(populacao) as pop from senso s
group by s.uf
order by 2 asc

--MAX POR REGIAO

SELECT B.regiao,MAX(a.POPULACAO)maximo FROM senso a
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY B.regiao
ORDER BY 2 DESC

SELECT b.estado,MAX(a.POPULACAO)maximo FROM senso a
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY b.estado
ORDER BY 2 DESC

--SUM Retorna a soma de todos os valores ou somente os valores DISTINCT na expressão. 
--SUM pode ser usado exclusivamente com colunas numéricas.Valores nulos são ignorados.

select SUM(populacao) from senso
--183989711
--183989711
--183989711

--SUM  POR ESTADO

SELECT UF,SUM(POPULACAO) FROM senso
GROUP BY UF
ORDER BY 2 DESC

--SUM POR REGIAO

SELECT B.regiao,SUM(a.POPULACAO) FROM senso a
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY B.regiao
ORDER BY 2 DESC

--COUNT Retorna o número de itens de um grupo

select COUNT(*) from senso

--Descobrindo qtd estados
select count(distinct uf) from senso;

--exemplo
select count(uf) from senso;

--COUNT  POR ESTADO

SELECT UF,COUNT(*) qtd FROM senso
GROUP BY UF
ORDER BY 2 DESC

--COUNT POR REGIAO

SELECT B.regiao,COUNT(*) FROM senso a
INNER JOIN regiao B
ON A.cod_uf=b.cod_uf
GROUP BY B.regiao
ORDER BY 2 DESC

select top(3) * from regiao
select top(3) * from senso
select top(3) * from uf

-- mudando autorização usuario banco
ALTER AUTHORIZATION ON DATABASE::curso TO "PAVILION\Clecio";

--usando varias funçoes de agregacao

select avg(populacao)media_pop,
	   min(populacao)minimo_pop,
	   max(populacao)maximo_pop,
	   sum(populacao)total_pop,
	   COUNT(*) qtd_cidades
from senso;

--POR ESTADO

SELECT UF,
	   avg(populacao)media_pop,
	   min(populacao)minimo_pop,
	   max(populacao)maximo_pop,
	   sum(populacao)total_pop,
	   COUNT(*) qtd_cidades
FROM senso
GROUP BY UF
ORDER BY UF DESC

--POR REGIAO

SELECT B.regiao,
	   avg(populacao)media_pop,
	   min(populacao)minimo_pop,
	   max(populacao)maximo_pop,
	   sum(populacao)total_pop,
	   COUNT(*) qtd_cidades
 FROM senso a
INNER JOIN regiao B
ON A.cod_uf=B.cod_uf
GROUP BY B.regiao
ORDER BY 2;

--STDEV Retorna o desvio padrão estatístico de todos os valores da expressão especificada

select STDEV(populacao)  from senso;

--STDEVP Retorna o desvio padrão estatístico para a população de todos os 
--valores na expressão especificada

select STDEVP(populacao)  from senso;

--GROUPING Indica se uma expressão de coluna especificada em uma lista 
--GROUP BY é agregada ou não. GROUPING retorna 1 para agregada ou 0 
--para não agregada no conjunto de resultados.

select uf,sum(populacao) as populacao,
GROUPING(uf) as grupo 
from senso
group by uf with rollup

--Projetando crescimento
--usando exemplo
SELECT a.nome_mun,
       a.populacao,
       a.populacao*1.05 projecao_Pop
from senso a

--por estado
SELECT a.uf,
       sum(a.populacao) populacao,
       sum(a.populacao)*1.05 projecao_Pop
from senso a
group by a.uf

--GROUPING_ID
/*
É uma função que calcula o nível de agrupamento. 
GROUPING_ID pode ser usada apenas na lista SELECT <select>, 
na cláusula HAVING ou ORDER BY, quando GROUP BY for especificada.
*/
select b.regiao,a.uf,sum(a.populacao) populacao,
GROUPING_ID(b.regiao,a.uf) as grupo 
from senso a
inner join regiao b
on a.cod_uf=b.cod_uf
group by rollup(b.regiao,a.uf);

--VAR Retorna a variância estatística de todos os valores da expressão especificada
SELECT VAR(POPULACAO) FROM senso;

SELECT UF,VAR(POPULACAO) FROM senso
GROUP BY UF

--VARP Retorna a variância estatística para o preenchimento 
--de todos os valores da expressão especificada.
SELECT VARP(POPULACAO) FROM senso

SELECT UF,VARP(POPULACAO) FROM senso
GROUP BY UF;

SELECT UF,VAR(POPULACAO) var,VARP(POPULACAO)varp FROM senso
GROUP BY UF

--exemplo com Grouping
use crm

SELECT codigo_pais,       
       count(*)        'Qtd',        
       Grouping(codigo_pais) AS 'Grouping' 
from cliente
GROUP  BY codigo_pais WITH rollup;

--exemplo
SELECT a.nome_montadora Montadora,       
       count(*)        'Qtd',        
       Grouping(a.nome_montadora) AS 'Grouping' 
from montadora a
 inner join carro_montadora b
 on a.id_montadora=b.id_montadora
GROUP  BY a.nome_montadora WITH rollup;
--exmplo

SELECT a.nome_montadora,b.nome_carro,       
       count(*)        'Qtd',        
       Grouping(a.nome_montadora) AS 'Grouping' 
from montadora a
 inner join carro_montadora b
 on a.id_montadora=b.id_montadora
 where a.nome_montadora in ('Toyota','Alfa Romeo')
GROUP  BY a.nome_montadora,b.nome_carro  WITH rollup;

--trazendo o nome cidade com maior populacao em cada estado
use curso;
select a.* from  
(select cod_uf,MAX(populacao) as populacao from senso group by cod_uf) b
join senso a
on a.cod_uf=b.cod_uf
and a.populacao=b.populacao
order by a.populacao desc

select * from senso

--
select a.* from   
(select cod_uf,MIN(populacao) as populacao from senso group by cod_uf) b
join senso a
on a.cod_uf=b.cod_uf
and a.populacao=b.populacao
order by a.populacao desc

--outro exemplo

SELECT a.cod_uf, a.nome_mun, a.populacao
FROM senso a
GROUP BY a.cod_uf, a.nome_mun, a.populacao
HAVING populacao = (SELECT MAX(populacao) FROM senso WHERE cod_uf = a.cod_uf)
ORDER BY a.populacao desc

SELECT a.cod_uf, a.nome_mun, a.populacao
FROM senso a
GROUP BY a.cod_uf, a.nome_mun, a.populacao
HAVING populacao = (SELECT min(populacao) FROM senso WHERE cod_uf = a.cod_uf)
ORDER BY a.populacao desc

 --- ****************************************************************************************************** ---

/* 10)  FUNÇÕES DE CLASSIFICAÇÃO  */

--RANK EXEMPLO 2 1
/*As funções de classificação retornam um valor de classificação 
para cada linha em uma partição. Dependendo da função usada, 
algumas linhas podem receber o mesmo valor que outras. 
As funções de classificação são não determinísticas
*/
use curso
select rank() OVER (ORDER BY estado ASC) AS rank_uf ,
       estado 
from uf

--RANK EXEMPLO 2
select rank() OVER (ORDER BY estado ASC) AS rank_uf ,
	   regiao,
	   estado  
from regiao;

--RANK EXEMPLO 3
select rank() OVER (ORDER BY regiao ASC) AS rank_uf ,
       regiao,
	   estado
from regiao;

--NTILE
/*Distribui as linhas de uma partição ordenada em um número de grupos especificado. 
Os grupos são numerados, iniciando em um. Para cada linha, 
NTILE retorna o número do grupo ao qual a linha pertence.
*/
select NTILE(8) OVER (ORDER BY regiao ASC) AS NTILE_uf ,
regiao,estado  
from regiao

--DENSE_RANK
/*Retorna a classificação de linhas dentro da partição de um conjunto de resultados, 
sem qualquer lacuna na classificação. A classificação de uma linha é um mais 
o número de classificações distintas que vêm antes da linha em questão.
*/
select DENSE_RANK() OVER (ORDER BY regiao ASC) AS DENSE_RANK_uf ,
	  regiao,
	  estado
from regiao

select DENSE_RANK() OVER (ORDER BY estado ASC) AS DENSE_RANK_uf ,
regiao,estado
regiao_uf  from regiao

--ROW_NUMBER
/*Retorna o número sequencial de uma linha em uma partição de um conjunto de resultados, 
iniciando em 1 para a primeira linha de cada partição.
*/
select ROW_NUMBER() OVER (ORDER BY estado ASC) AS ROW_NUMBER_uf ,
	  regiao,
	  estado
from regiao;

--combinando valores 1
select ROW_NUMBER() OVER (ORDER BY regiao ASC) AS ROW_NUMBER_uf ,
       DENSE_RANK() OVER (ORDER BY regiao ASC) AS DENSE_RANK_uf ,
	   NTILE(6) OVER (ORDER BY regiao ASC) AS NTILE_uf ,
	   rank() OVER (ORDER BY regiao ASC) AS rank_uf ,
       regiao,
	   estado
regiao_uf 
from regiao
order by 5,6

--combinando valores 1
select ROW_NUMBER() OVER (ORDER BY estado ASC) AS ROW_NUMBER_uf ,
       DENSE_RANK() OVER (ORDER BY estado ASC) AS DENSE_RANK_uf ,
	   NTILE(5) OVER (ORDER BY estado ASC) AS NTILE_uf ,
	   rank() OVER (ORDER BY estado ASC) AS rank_uf ,
regiao,estado
regiao_uf 
from regiao
order by 4,6

--simulando classificacao de campeonato
--drop table campeonato
create table campeonato
(
 nometime varchar(30)not null,
 pontos int not null
 );
 --populando tabela
insert into campeonato values ('Atlético-GO','22');
insert into campeonato values ('Chapecoense','28');
insert into campeonato values ('Ponte Preta','28');
insert into campeonato values ('Grêmio','43');
insert into campeonato values ('Cruzeiro','37');
insert into campeonato values ('Santos','41');
insert into campeonato values ('Palmeiras','40');
insert into campeonato values ('Corinthians','53');
insert into campeonato values ('Flamengo','38');
insert into campeonato values ('Botafogo','37');
insert into campeonato values ('Atlético-PR','34');
insert into campeonato values ('Vasco','31');
insert into campeonato values ('Atlético-MG','31');
insert into campeonato values ('Sport','29');
insert into campeonato values ('Avaí','29');
insert into campeonato values ('Bahia','27');
insert into campeonato values ('Fluminense','31');
insert into campeonato values ('São Paulo','27');
insert into campeonato values ('Coritiba','27');
insert into campeonato values ('Vitória','26');

--select * from campeonato

--Classificacao do campeonato
	select rank() OVER (ORDER BY pontos desc) AS classif ,
		    nometime,
			pontos 
	from campeonato;

 --- ****************************************************************************************************** ---

/* 11)  FUNÇÕES LOGICAS  */

--CHOOSE
--Retorna o item ao índice especificado de uma lista de valores no SQL Server.
--Exemplo 1

SELECT Choose (4, 'Gerente', 'Diretor', 'Desenvolvedor', 'Tester') AS Escolhido 

--Exemplo 2
Use AdventureWorks2017
 SELECT productcategoryid,     
Choose (productcategoryid, 'A', 'B', 'C', 'D', 'E') AS Expressao 
FROM   production.productcategory; 

--select distinct productcategoryid  FROM   production.productcategory; 
--exemplo 3

 SELECT jobtitle,        
        hiredate,
		Month(hiredate)mes,        
		Choose(Month(hiredate), 'Winter', 'Winter', 'Spring', 'Spring', 
		                        'Spring','Summer', 'Summer','Summer', 
								'Autumn', 'Autumn', 'Autumn','Winter') AS Quarter_Hired 
		FROM   humanresources.employee 
		WHERE  Year(hiredate) > 2005 
		ORDER  BY Year(hiredate);

--IIF
--Retorna um de dois valores, dependendo de a expressão booliana 
--ser avaliada como true ou false no SQL Server 
--Exemplo 1
 DECLARE @a INT = 45,          
		 @b INT = 40;   
		 SELECT IIF (@a > @b, 'TRUE', 'FALSE') AS Resultado;

DECLARE  @a INT = 45,          
		 @b INT = 40;   
		 SELECT IIF (@a > @b, 'Maior', 'Menor') AS Resultado;

DECLARE  @a INT = 45,          
		 @b INT = 40;   
		 SELECT IIF (@a < @b, 'Menor', 'Maior') AS Resultado;

--EXEMPLO 2
--IIF com constantes NULL
--O resultado dessa instrução é um erro
SELECT IIF (45 > 30, NULL, NULL) AS Result;

--EXEMPLO 3
/*IIF com parâmetros NULL
O retorno NULL.*/
	DECLARE @P INT = NULL,         
			@S INT = NULL; 
	SELECT  IIF (45 > 30, @p, @s) AS Result

 --- ****************************************************************************************************** ---

/* 12)  FUNÇÕES MATEMÁTICAS  */

--ABS
--Uma função matemática que retorna o valor absoluto (positivo) 
--da expressão numérica especificada.

SELECT Abs(-1.0),        
       Abs(0.0),        
	   Abs(1.0),
	   Abs(-9.0),
	   Abs(9.0),
	   abs(-5.4),
	   abs(5.4);

--RAND
--Retorna um valor float pseudoaleatório de 0 a 1, exclusivo.

SELECT Rand(), 
       Rand(), 
	   Rand()

--exenplo

DECLARE @cont smallint;
SET @cont = 1;
WHILE @cont < 5
   BEGIN
      SELECT RAND() RANDOMICO
      SET @cont = @cont + 1
   END;

--ROUND
--Retorna um valor numérico, arredondado, para o comprimento ou precisão especificados.

SELECT Round(123.9994, 3), --0,1,2,3,4<    
       Round(123.9995, 3); --5,6,7,8,9 >

SELECT Round(123.9994, 2), --0,1,2,3,4<    
       Round(123.9995, 2); --5,6,7,8,9 >
--exemplo 2

SELECT Round(123.4545, 2); 
SELECT Round(123.45,-2);
SELECT Round(193.45,-2);

--exemplo 3
SELECT Round(150.75, 0);
SELECT Round(150.75, 0, 1); 

--EXEMPLO FUNÇÃO POWER PONTENCIA
SELECT POWER(2,2);
SELECT POWER(2,3);

--OUTRO
DECLARE @VALOR INT=3,
        @POTENCIA INT=2;

SELECT POWER(@VALOR,@POTENCIA)

-- EXEMPLO SQRT RAIZ QUADRADA
SELECT SQRT(90);

 --- ****************************************************************************************************** ---

/* 13)  FUNÇÕES DE LIMITE  */

--TOP
--recuperando top 10 campeonato
use curso;
SELECT TOP 5 * FROM campeonato
order by pontos desc;

use crm;

--trazento top 10 montadoras x carros

select top 10 a.nome_montadora,count(b.id_carro) as qtd_carro
from montadora a
inner join carro_montadora b
on a.id_montadora=b.id_montadora
group by a.nome_montadora
order by  qtd_carro desc;

--recuperando 10 cidades mais populosas Brasil
use curso;
select top 10 * from senso
order by populacao desc

--outra exemplo
select top 10 *,rank() over(order by populacao desc) as posicao 
from senso
order by populacao desc

 --- ****************************************************************************************************** ---

/* 14)  FUNÇÕES DE CONVERSÃO  */

DECLARE @meuvalor DECIMAL(5,2); 
SET @meuvalor = 193.57; 
-- Or, using CAST  
SELECT Cast(@meuvalor AS VARBINARY(20)); 
SELECT @meuvalor; 
--SELECT Cast(Cast(@meuvalor AS VARBINARY(20)) AS DECIMAL(5,2)); 
-- Or, using CONVERT  
SELECT CONVERT(VARBINARY(20), @meuvalor); 
SELECT CONVERT(DECIMAL(5, 2), CONVERT(VARBINARY(20), @meuvalor));

-- Use CAST  
    use AdventureWorks2017
	SELECT top(5) Substring(NAME, 1, 30) AS ProductName,        
	listprice 
    FROM   production.product 
	WHERE  Cast(listprice AS INT) LIKE '3%';

	/* funciona sem precisar converter - by clecio */
	SELECT top(5) Substring(NAME, 1, 30) AS ProductName,        
	listprice 
    FROM   production.product 
	WHERE  listprice LIKE '3%';

-- Use CONVERT.   
	SELECT Substring(NAME, 1, 30) AS ProductName,        
	listprice 
	FROM   production.product 
    WHERE  CONVERT(INT, listprice) LIKE '3%';

--Formatando cast e arrendondando
--Usando CAST com operadores aritméticos
	SELECT Cast(Round(salesytd / commissionpct, 0) AS INT) AS formatado,        
					 (salesytd / commissionpct )  nao_format 
	FROM   sales.salesperson 
	WHERE  commissionpct <> 0

	SELECT Round(salesytd / commissionpct, 0)  AS formatado,        
					 (salesytd / commissionpct )  nao_format 
	FROM   sales.salesperson 
	WHERE  commissionpct <> 0

--Usando CAST para concatenar (!Simulando erro)
	SELECT  'A lista de preco é ' + listprice AS Lista_preco 
	FROM   production.product 
	WHERE  listprice BETWEEN 350.00 AND 400.00;

--Usando CAST para concatenar Distinct
	SELECT  distinct 'A lista de preco é '+ Cast(listprice AS VARCHAR(12)) AS Lista_preco 
	FROM   production.product 
	WHERE  listprice BETWEEN 350.00 AND 400.00;
--Usando CAST para concatenar Distinct (!Simulando erro)
	SELECT distinct  'A lista de preco é '+ listprice AS ListPrice 
	FROM   production.product 
	WHERE  listprice BETWEEN 350.00 AND 400.00;

--Usando CAST para produzir texto mais legível
	SELECT DISTINCT 
	p.NAME as Nome_original,
	Cast(p.NAME AS CHAR(15)) AS Nome_tratado,                 
		s.unitprice as preço, round(cast(s.unitprice as DECIMAL(10,2)),0)duas_casas
	FROM   sales.salesorderdetail AS s        
		JOIN production.product AS p          
		ON s.productid = p.productid 
	WHERE  p.NAME LIKE 'Long-Sleeve Logo Jersey, M';

--Usando CAST com a cláusula LIKE

	SELECT p.firstname,        
		   p.lastname,        
		   s.salesytd,        
		   s.businessentityid,        
		   Cast(Cast(s.salesytd AS INT) AS CHAR(30) )cast_1,        
		   Cast(s.salesytd AS CHAR(30)) as cast_2
	FROM   person.person AS p        
		JOIN sales.salesperson AS s          
		ON p.businessentityid = s.businessentityid 
		WHERE  Cast(Cast(s.salesytd AS INT) AS CHAR(20)) LIKE '2%';

	-- teste clecio

	SELECT p.firstname,        
		   p.lastname,        
		   s.salesytd,        
		   s.businessentityid,        
		   Cast(Cast(s.salesytd AS INT) AS CHAR(30) )cast_1,        
		   Cast(s.salesytd AS CHAR(30)) as cast_2
	FROM   person.person AS p        
		JOIN sales.salesperson AS s          
		ON p.businessentityid = s.businessentityid 
		WHERE  Cast(Cast(s.salesytd AS INT) AS CHAR(20)) LIKE '2%';

--TRY Cast
SELECT   
    CASE WHEN TRY_CAST('TESTE' AS float) IS NULL   
    THEN 'Cast Falhou!'  
    ELSE 'Cast OK!'  
END AS Resultado; 
--TRY Cast
SELECT   
    CASE WHEN TRY_CAST(52 AS float) IS NULL   
    THEN 'Cast Falhou!'  
    ELSE 'Cast OK!'  
END AS Resultado; 

--TRY cast
SET DATEFORMAT dmy;  
SELECT TRY_CAST('12/31/2010' AS datetime) AS Resultado;  
GO

--TRY cast
SET DATEFORMAT dmy;  
SELECT TRY_CAST('05/12/2010' AS datetime) AS Resultado;  
GO  

--Simulando erro
select cast('12/31/2010' as datetime);
select try_cast('12/31/2010' as datetime);

--Exemplos Parse
--Retorna o resultado de uma expressão, convertida no tipo de dados solicitado no SQL Server
/*
string_value deve ser uma representação válida do tipo de dados solicitado, ou PARSE gera um erro.

data_type
Valor literal que representa o tipo de dados solicitado para o resultado.

culture
Cadeia de caracteres opcional que identifica a cultura na qual string_value é formatado.
*/

--Configuração Explicita de idioma
SELECT PARSE('Monday, 13 December 2010' AS datetime USING 'en-US') AS Resultado; 

SELECT PARSE('Segunda-feira, 13 Dezembro 2010' AS datetime USING 'pt-BR') AS Result; 

--Configuração implícita de idioma
SELECT PARSE('R$345,98' AS money USING 'pt-BR') AS Result; 

SELECT PARSE('$345.98' AS money USING 'en-US') AS Result; 

SET LANGUAGE 'English';  
SELECT PARSE('12/20/2010' AS datetime) AS Resultado;  

SET LANGUAGE 'Português';  
SELECT PARSE('20/12/2010' AS datetime) AS Resultado; 

--simula erro
SET LANGUAGE 'Português';  
SELECT PARSE('05/30/2010' AS datetime) AS Resultado;   

-- TRY_CONVERT
SELECT   
    CASE WHEN TRY_CONVERT(float,'TESTE') IS NULL   
    THEN 'Convert Falhou!'  
    ELSE 'Convert OK!'  
END AS Resultado; 
--TRY TRY_CONVERT
SELECT   
    CASE WHEN TRY_CONVERT(float,65) IS NULL   
    THEN 'TRY_CONVERT Falhou!'  
    ELSE 'TRY_CONVERT OK!'  
END AS Resultado; 

--TRY Convert
SET DATEFORMAT dmy;  
SELECT TRY_CONVERT(datetime, '12/31/2010' ) AS Resultado;  
GO

--TRY Convert
SET DATEFORMAT dmy;  
SELECT TRY_CONVERT(datetime,'05/12/2010') AS Resultado;  
GO  

--TRY PARSE
SELECT TRY_PARSE('Hello World!!!' AS datetime2 USING 'en-US') AS Result;

SELECT TRY_PARSE('10/05/2010' AS datetime USING 'en-US') AS Result;

 --- ****************************************************************************************************** ---

/* 14)  FUNÇÕES DE CARACTERES  */

--ASCII Exemplo
--
	select ASCII('SQL')
	select ASCII('S')
	select ASCII('Q')
	select ASCII('?')

/*O exemplo a seguir supõe um conjunto de caracteres ASCII e retorna o valor 
ASCII e o caractere CHAR para cada caractere na cadeia de 
caracteres da frase “TEste*/
	DECLARE @posicao INT, @string CHAR(8)
	-- Initialize the variables. 
	SET @posicao = 1; 
	SET @string = 'Testando'; 
		WHILE @posicao <= Datalength(@string)   
			BEGIN       
				SELECT Ascii(Substring(@string, @posicao, 1))cod_ascii,              
				Char(Ascii(Substring(@string, @posicao, 1))), @posicao as posição  
				
				SET @posicao = @posicao + 1   
			END;

--select Ascii(Substring('Ola Mundo', 1, 1))
			
--LTRIM
--Retorna uma expressão de caractere depois de remover espaços em branco à esquerda

	DECLARE @string_to_trim VARCHAR(60); 
	SET @string_to_trim ='     Cinco espaços no inicio.        '; 
	SELECT  'Texto sem espaço:'+Ltrim(@string_to_trim); 
	SELECT  'Texto sem espaço:'+trim(@string_to_trim); 
	SELECT  'Texto Com espaço:'+@string_to_trim; 

--STR

--Exemplo Retorna dados de caractere convertidos de dados numéricos.

SELECT  Str(123.45, 6, 1);
--Prova de conversao de numerico para caractere
SELECT 'Teste '+Str(123.45, 6, 1);
SELECT 'Teste '+Str(1123.45, 7, 2);
--sumila erro
SELECT 'Teste '+123.45;

/*Quando a expressão excede o comprimento especificado, a cadeia de 
caracteres retorna ** para o comprimento especificado*/

SELECT Str(123.45, 2, 2); 

--CONCAT
/*Retorna uma cadeia de caracteres que é o resultado da concatenação de dois ou mais valores*/
 
SELECT  Concat(CURRENT_USER, 
               ' Seu Saldo é R$', 
			   11.00, 
			   ' em ',
               day(getdate()),'/',
			   month(getdate()),'/',
			   year(getdate())) AS Resultado;

--Simulando erro com
SELECT CURRENT_USER+ 
               ' Seu Saldo é R$'+ 
			   11.00+
			   ' em '+
               day(getdate())+'/'+
			   month(getdate())+'/'+
			   year(getdate())AS Resultado;

--CONCAT_WS 
--Separa e retornar valores de cadeia de caracteres concatenados com o delimitador especificado ]
--no argumento da primeira função.
--Atenção ignora valores null 
USE crm;

SELECT CONCAT_WS(';',a.primeiro_nome,a.ultimo_nome,a.email,a.nascimento,a.sexo)
 from cliente a;

--exemplo
use curso
--select a.id_aluno,a.nome,b.id_disciplina,c.nome_disc,b.periodo from alunos a
--select CONCAT_WS('|',a.id_aluno,a.nome,b.id_disciplina,c.nome_disc,b.periodo) from alunos a
select CONCAT_WS('|',a.id_aluno,a.nome,
                  isnull(b.id_disciplina,''),
                  isnull(c.nome_disc,''),
                  isnull(b.periodo,'sem period')) from alunos a
left join matricula b
on a.id_aluno=b.id_aluno
left join disciplina c
on b.id_disciplina=c.id_disciplina;

--REPLACE
/*Substitui todas as ocorrências de um valor da cadeia de caracteres 
especificado por outro valor de cadeia de caracteres*/
--O exemplo a seguir substitui a cadeia de caracteres cde em abcdefghi por xxx.
	
	SELECT 'abcdefghicde' de,
		Replace('abcdefghicde', 'cde', 'xxx') para

--O exemplo a seguir substitui a cadeia de caracteres cde em teste por producao.
SELECT  'Isto é teste' de,
		Replace('Isto é teste', 'teste', 'producao')para;

--REPLACE NO SELECT
	use curso
	SELECT REGIAO,
		REPLACE(REGIAO,'Sul','South') 
		FROM regiao

--Exemplo de Update usando replace.

CREATE TABLE pessoas   
	(nome VARCHAR(30) 
	) 
--inserindo registros
	INSERT INTO pessoas VALUES ('José') 
	INSERT INTO pessoas VALUES ('André') 
	INSERT INTO pessoas VALUES('Helem') 
--verificando registros

select * from pessoas
--
UPDATE pessoas SET nome=replace(nome, 'é', 'e');

--REPLICATE
--Repete um valor da cadeia de caracteres um número especificado de vezes
/*O exemplo a seguir replica um caractere 0 quatro vezes na frente de um código 
de linha de produção no banco de dados*/
    use AdventureWorks2017
	SELECT name,
	       productline,
		   Replicate('0', 4) + productline AS 'Codigo' 
	FROM   Production.product 
	WHERE  productline = 'T' 
	ORDER  BY name

/*Usando REPLICATE e DATALENGTH
O exemplo a seguir preenche números à esquerda até um comprimento especificado, 
à medida que são convertidos de um tipo de dados numérico em caractere ou Unicode.*/

--LEFT
--Retorna a parte da esquerda de uma cadeia de caracteres com o número de caracteres especificado.

	use AdventureWorks2017
	SELECT  NAME,
			LEFT(NAME, 5) 
	FROM   production.product 
	ORDER  BY productid;

--UPPER
--Retorna uma expressão de caractere com dados de caractere em minúsculas convertidos em maiúsculas
	use curso
	SELECT estado, 
		   upper(estado) 
	from regiao

--SUBSTRING
--Retorna uma substring de caractere com dados de caractere dento do parâmetro informado
use AdventureWorks2017
	SELECT lastname nome,        
		   Substring(lastname, 1, 3)  lastname1,        
		   Substring(lastname, 4, 10) lastname2 
	FROM   person.person 
	ORDER  BY lastname; 

--REVERSE
--Retorna a ordem inversa de um valor da cadeia de caracteres.

	SELECT firstname,        
		   Reverse(firstname) AS Reverse 
		   FROM   person.person 
   WHERE  businessentityid < 5 
   ORDER  BY firstname

--LEN
--Retorna o número de caracteres da expressão da cadeia de caracteres especificada, 
--excluindo espaços em branco à direita
	SELECT  firstname,
			Len(firstname) AS Tamanho        	             
   FROM   sales.vindividualcustomer 
   WHERE  countryregionname = 'Australia'; 
   
--DATALENGTH
--Retorna o número de bytes usado para representar qualquer expressão
	SELECT  NAME,
			Datalength(NAME)as data       	    
	FROM   production.product 
	ORDER  BY NAME;

--Comparando Datalength com Len
SELECT  NAME,
		Datalength(NAME)as Datalength,
       Len(NAME)as len		    
	FROM   production.product 
	ORDER  BY NAME

use curso
--drop table t1
CREATE TABLE t1   
	(      c1 VARCHAR(3),      
			c2 CHAR(3),
			c3 NVARCHAR(3)  
	 );

INSERT INTO t1 VALUES      ('2','2','2') 
INSERT INTO t1 VALUES      ('37','37','37') 
INSERT INTO t1 VALUES      ('597','597','597') 

--select * from t1
--drop table t1
SELECT c1,
       c2,
	   c3,
	   Datalength(c1)dtlc1,
	   Datalength(c2)dtlc2,
	   Datalength(c3)dtlc3
	   FROM   t1;

--RIGHT
--Retorna a parte da direita de uma cadeia de caracteres com o número de caracteres especificado
use curso
	SELECT a.estado,
		   RIGHT(estado, 5) AS 'Estado' 
	FROM   regiao a
	
--LOWER
--Retorna uma expressão de caractere depois de converter 
--para minúsculas os dados de caracteres em maiúsculas
--O exemplo a seguir usa a função LOWER, a função UPPER, 
--e aninha a função UPPER dentro da função LOWER selecionando 
--nomes de produtos com preços entre US$ 11 e US$ 20. 
--Este exemplo usa o banco de dados AdventureWorks2014

use AdventureWorks2017
	SELECT Substring(NAME, 1, 20)name,
		   Lower(Substring(NAME, 1, 20)) AS Lower,        
		   Upper(Substring(NAME, 1, 20)) AS Upper,        
		   Lower(Upper(Substring(NAME, 1, 20))) AS LowerUpper 
   FROM   production.product 
   WHERE  listprice BETWEEN 11.00 AND 20.00; 

--RTRIM
--Retorna uma cadeia de caracteres depois de truncar todos os espaços em branco à direita
--EXEMPLO SIMPLES
SELECT Rtrim('Removendo espaços.   ');

--EXEMPLO 2
	DECLARE @string_to_trim VARCHAR(60); 
	SET @string_to_trim ='Deixamos 4 espacos apos final da sentença.    '; 
	SELECT @string_to_trim + ' proxima string.'; 
	SELECT Rtrim(@string_to_trim) + ' proxima string.'

 --- ****************************************************************************************************** ---

/* 15)  FUNÇÕES DE DATA E HORA  */

--FUNCOES DATA E HORA DO SISTEMA
SELECT Sysdatetime () exSysdatetime
SELECT Sysdatetimeoffset () exSysdatetimeoffset
SELECT Sysutcdatetime () exSysutcdatetime
SELECT CURRENT_TIMESTAMP exCURRENT_TIMESTAMP
SELECT Getdate () exGetdate
SELECT Getutcdate () exGetutcdate

--FUNCAO DE DATA E HORA PARTES
--RETORNA O DIA/Mes/Ano

	SELECT Getdate()data_hora,
	       Datename (day, Getdate()) DIA_N,
		   Datename (month, Getdate()) MES_N,
		   Datename (year, Getdate()) ANO_N
	--RETORNA O DIA/Mes/Ano
	
	SELECT Datepart (day, Getdate()) DIA_P,
		   Datepart (month, Getdate())MES_P,
		   Datepart (year, Getdate()) ANO_P
	
	--RETORNA O DIA/Mes/Ano
	SELECT Day(Getdate()) DIA,
	       Month (Getdate()) MES,
		   YEAR (Getdate()) ANO
	
	--RETONAR DATA HORA COM 7 ARGUMENTOS
	--ANO MES DIA HORA MINUTOS SEGUNDO MILESEGUNDOS 
	SELECT DATETIMEFROMPARTS (2017,11,30,3,45,59,1) HORA

--
use CRM;

--exemplo 1
select a.primeiro_nome,
       a.nascimento,
       MONTH(a.nascimento)mes,
	   YEAR(a.nascimento)ano,
	   DAY(a.nascimento) dia 
	   from cliente a

--exemplo 2
select MONTH(a.nascimento)mes,
	   YEAR(a.nascimento)ano,
	   count(*) qtd
	   from cliente a
group by MONTH(a.nascimento),YEAR(a.nascimento)
order by YEAR(a.nascimento) ASC,MONTH(a.nascimento) ASC

--OUTRO EXEMPLO
select CONCAT(MONTH(a.nascimento),'-',DATENAME(MONTH,a.nascimento))mes,
	   YEAR(a.nascimento)ano,
	   count(*) qtd
	   from cliente a
group by CONCAT(MONTH(a.nascimento),'-',DATENAME(MONTH,a.nascimento)),YEAR(a.nascimento)
order by YEAR(a.nascimento) ASC,1 ASC

--exemplo 3
select 
	   YEAR(a.nascimento)ano,
	   count(*) qtd
	   from cliente a
group by YEAR(a.nascimento)
order by YEAR(a.nascimento) ASC

--CORRIGINGO ERRO
--partes
select distinct concat(REPLICATE('0', 2 - len(Month(nascimento))),MONTH(nascimento)),
len(Month(nascimento)) contando_carac
from cliente

-- CORRECAO
select concat(REPLICATE('0', 2 - len(Month(nascimento))),MONTH(nascimento),'-',DATENAME(MONTH,a.nascimento))mes,
	   YEAR(a.nascimento)ano,
	   count(*) qtd
	   from cliente a
group by concat(REPLICATE('0', 2 - len(Month(nascimento))),MONTH(nascimento),'-',DATENAME(MONTH,a.nascimento)),
         YEAR(a.nascimento)
order by YEAR(a.nascimento) ASC,1 ASC

--DIFERENCA EM DIAS
SELECT Datediff (day, '2015-03-12', '2017-07-13') ;

--DIFERENCA EM MESES
SELECT Datediff (month, '2015-03-12', '2017-07-13');

--DIFERENCA EM Anos
SELECT Datediff (year, '2015-03-12', '2017-07-13')
 
--Atraves deste comando podemo descobrir ha quantos dias/meses ou anos temos de  vida. 
--DIFERENCA EM DIA
SELECT Datediff (day, '1977-11-05', Getdate());

--DIFERENCA EM MESES
SELECT Datediff (month, '1977-11-05', Getdate()) 

--DIFERENCA EM Anos
SELECT Datediff (year, '1977-11-05', Getdate())

--EXEMPLO
USE CRM

	SELECT a.id_cliente,
		   a.nascimento,
		   getdate() hoje,
		   Datediff (day,a.nascimento,getdate()) dif_dia,
		   Datediff (month,a.nascimento,getdate()) dif_mes,
		   Datediff (YEAR,a.nascimento,getdate()) dif_anos
    FROM cliente A 
	where a.nascimento>'1980-01-01';

	--teste com sua data de nascimento
	declare @meu_aniversario as datetime;
	set @meu_aniversario='1977-11-05';

	select Datediff (day,@meu_aniversario,getdate()) dif_dia,
		   Datediff (month,@meu_aniversario,getdate()) dif_mes,
		   Datediff (YEAR,@meu_aniversario,getdate()) dif_anos

--Adicionando 90 dias
	SELECT getdate() agora,
		   Dateadd (day, 90, Getdate()) 
--Adicionando 2 meses
	SELECT getdate() agora,
	       Dateadd (month, 2, Getdate()) 
--Adicionando 3 anos
	SELECT getdate() agora,
		   Dateadd (year, 3, Getdate())

--Exemplo
use curso
--drop table contas
create table contas
(
 id_cont int identity(1,1) not null primary key,
 data_conta date not null,
 dias int,
 data_vencimento date ,
 valor decimal(10,2),
 situacao char(1) default('A')
 );
 --inserindo dados
  insert into contas (data_conta,dias,valor) values ('2018-05-24',10,25.75);

  insert into contas (data_conta,dias,valor) values ('2018-05-24',30,40.75);

  insert into contas (data_conta,dias,valor) values ('2018-05-24',60,30.75);

  --exemplo

  select id_cont,data_conta,dias,data_vencimento,valor from contas;

-- trazendo o valor na consulta
    select id_cont,
	       data_conta,
		   dias,
		   Dateadd(day,dias,data_conta) vencto,
		   valor from contas;
--realizando update 
 update contas set data_vencimento = Dateadd(day,dias,data_conta)
 where data_vencimento is null;

-- verificando

select * from contas

 --- ****************************************************************************************************** ---

/* 16)  FORMATANDO DATAS  */

--FORMATANDO DATAS
	Select convert(varchar(10),getdate(),103)

	Select convert(varchar(5),getdate(),103)

	Select convert(varchar(10),getdate(),108)

	Select convert(varchar(5),getdate(),108)

	SELECT CONVERT(VARCHAR(20),GETDATE(), 100)

	SELECT CONVERT(VARCHAR(8),GETDATE(), 1)
	
	select convert(varchar(10),getdate(),103), 
	       substring(convert(varchar(10),getdate(),103),4,2)

--Extensão
SELECT CAST(DAY(GETDATE()) AS VARCHAR(2)) + ' de ' +
       DATENAME(MM, GETDATE()) AS [Dia e Mes]

--EXEMPLO EM TABELA
USE crm
	SELECT a.nascimento,
		   CONVERT(varchar(10),a.nascimento,120)padrao120,
	       CONVERT(varchar(10),a.nascimento,103)padrao103,
		   CONVERT(VARCHAR(20),a.nascimento,100)padrao100,
		   CONVERT(VARCHAR(11),a.nascimento,100)padrao100,
		   CONVERT(VARCHAR(8),a.nascimento,1)  padrao1
		   FROM cliente a

--- ****************************************************************************************************** ---

/* 17)  EXPRESSÕES - CASE  */

	--Exenmplo Simples
	use curso
	DECLARE @data DATETIME 
	SET @data=getdate()+2
	SELECT @data Data,
		 CASE   WHEN @data = Getdate() THEN 'Hoje'          
				WHEN @data < Getdate() THEN 'Ontem'          
				WHEN @data > Getdate() THEN 'Amanhã' 
				else 'Não sei'       
				END dia 
	
	--Exemplo 1
	use AdventureWorks2017
	SELECT productnumber,
	       productline,         
	Categoria=CASE productline                     
				WHEN 'R' THEN 'Road'                     
				WHEN 'M' THEN 'Mountain'                     
				WHEN 'T' THEN 'Touring'                     
				WHEN 'S' THEN 'Other sale items'                     
				ELSE 'Not for sale' 
				END       
	FROM   production.product 
	ORDER  BY productnumber;

--Exemplo 2
	SELECT productnumber,
	       productline,         
	    CASE                      
			WHEN productline='R' THEN 'Road'                     
			WHEN productline='M' THEN 'Mountain'                     
			WHEN productline='T' THEN 'Touring'                     
			WHEN productline='S' THEN 'Other sale items'                     
			ELSE 'Not for sale' END Categoria,       
			NAME 
	FROM   production.product 
	ORDER  BY productnumber;

--Exemplo

SELECT productnumber,        
	   NAME, 
	   listprice,       
	   CASE WHEN listprice = 0 THEN 'Não está a venda' 
	        WHEN listprice <=50 THEN 'Abaixo de $50'                          
			WHEN listprice >50  AND listprice <=250 THEN 'Entre $ 51 de $250' 
			WHEN listprice >250 AND listprice <=1000 THEN 'Entre que $251 de $1000' 
			ELSE 'Acima de $1000' END Range_preco,        
			'Produtos' AS Categoria 
	   FROM   production.product 
	   ORDER  BY productnumber

--Ordernando com Case When
SELECT businessentityid,        
       salariedflag 
	FROM   humanresources.employee 
	ORDER  BY CASE WHEN salariedflag = 1 THEN businessentityid END DESC,           
	          CASE WHEN salariedflag = 0 THEN businessentityid END ASC

SELECT businessentityid,        
       salariedflag 
	FROM   humanresources.employee 
	ORDER  BY CASE WHEN salariedflag = 1 THEN businessentityid END DESC,           
	          else businessentityid END ASC		  

--update com Case when
  BEGIN TRANSACTION

	UPDATE humanresources.employee 
	SET vacationhours = ( CASE WHEN ( ( vacationhours - 10.00 ) < 0 ) 
	   THEN  vacationhours + 40.00 
	   ELSE ( vacationhours + 20.00 ) END ) 
	   --realizando print dos campos atualizado
	   output deleted.businessentityid,        
	   deleted.vacationhours AS Antes,        
	   inserted.vacationhours AS Depois 
	   WHERE  salariedflag = 0;
   
   Rollback transaction;

--Fim 
--- ****************************************************************************************************** ---

/* 18)  EXPRESSÕES - NULLIF e ISNULL  */

--criando o problema 
SELECT 100 / 0 

--Tratando 

use curso
create table teste2
(
  val1 int,
  val2 int
);
--Populando tabela teste2
insert into teste2 values (100,0),(100,25),(1,0),(5,2)

--verificando dados
select * from teste2
--Expressao com erro
select val1,
       val2,
	   val1/val2 expressao
from teste2

--Expressao tratando erros
select 
		val1,
		val2,
		isnull(val1/nullif(val2,0),0) expressao1,
		isnull(cast(val1 as decimal(5,2))/cast(nullif(val2,0) as decimal(5,2)),0) expressao2
from teste2;

--Comparando Case Nullif
--Retorna um valor nulo se as duas expressões especificadas forem iguais.

use AdventureWorks2017
	SELECT productid,        
		   makeflag,        
		   finishedgoodsflag,        
		   NULLIF(makeflag, finishedgoodsflag)AS 'Null se igual' 
		   FROM   production.product 
		   WHERE  productid < 10; 
		 
--exemplo 
--ISNULL
use curso

--select distinct a.id_aluno,a.nome,b.periodo 
select distinct a.id_aluno,a.nome,isnull(b.periodo,'Vazio') as periodo
from alunos a
left join matricula b
on a.id_aluno=b.id_aluno;

--- ****************************************************************************************************** ---

/* 19)  EXPRESSÕES - COALESCE  */

--exemplos
SELECT COALESCE(NULL, NULL, 'Terceiro Valor', 'Quarto valor');

SELECT COALESCE(NULL, NULL, NULL, NULL);

use curso
--drop table tab_salario;
CREATE TABLE tab_salario  
(  
    matricula     int   identity,  
    salario_hora  decimal   NULL,  
    salario       decimal   NULL,  
    comissao      decimal   NULL,  
    vendas        int   NULL  
); 
 
INSERT tab_salario (salario_hora, salario, comissao, vendas)  
VALUES  
    (10.00, NULL, NULL, NULL),  
    (20.00, NULL, NULL, NULL),  
    (30.00, NULL, NULL, NULL),  
    (40.00, NULL, NULL, NULL),  
    (NULL, 10000.00, NULL, NULL),  
    (NULL, 20000.00, NULL, NULL),  
    (NULL, 30000.00, NULL, NULL),  
    (NULL, 40000.00, NULL, NULL),  
    (NULL, NULL, 15000, 3),  
    (NULL, NULL, 25000, 2),  
    (NULL, NULL, 20000, 6),  
    (NULL, NULL, 14000, 4);  

SELECT matricula,
       salario_hora, salario, comissao, vendas,
      CAST(COALESCE(salario_hora * 40 * 52,salario,comissao * vendas) AS money) AS 'Total Salario'   
FROM tab_salario 
ORDER BY matricula;
GO  

--- ****************************************************************************************************** ---

/* 20)  VIEWS  */

--criacao de view 
use AdventureWorks2017;
CREATE VIEW v_data_contratacao 
AS   
	SELECT p.firstname,          
		   p.lastname,          
		   e.businessentityid,          
		   e.hiredate   
		   FROM   humanresources.employee e          
		   JOIN person.person AS p            
ON e.businessentityid = p.businessentityid;

--select na view

select * from v_data_contratacao
where year(hiredate)='2009';

--Alterando view

Alter VIEW v_data_contratacao 
AS   
	SELECT p.firstname primeiranome,          
		   p.lastname ultimoNome, 
		   p.MiddleName nome_meio, --Campo adicionado         
		   e.businessentityid id,          
		   e.hiredate admissao  
		   FROM   humanresources.employee e          
		   JOIN person.person AS p            
ON e.businessentityid = p.businessentityid;

--select na view

select * from v_data_contratacao
where year(admissao)='2009';

--View com dados Particionados.
--Criação de view com dados de varias tabelas usando UNION ALL

--Create the tables and insert the values. 
use curso
CREATE TABLE fornecedores1              
(              
id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 1 AND 150),             
fornec CHAR(50)              
)
CREATE TABLE fornecedores2              
( 
 id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 151 AND 300),          
 fornec    CHAR(50) )

CREATE TABLE fornecedores3             
(
  id_fornec INT PRIMARY KEY CHECK(id_fornec BETWEEN 301 AND 450),       
  fornec char(50)
 )
CREATE TABLE fornecedores4              
(             
  id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 451 AND 600),             
  fornec    CHAR(50)              
) 

--inserindo valores  
 INSERT  fornecedores1 VALUES  ('1','CaliforniaCorp') 
 INSERT  fornecedores1 VALUES  ('5', 'BraziliaLtd')
  
 INSERT  fornecedores2 VALUES  ('231','FarEast')
 INSERT  fornecedores2 VALUES  ('280','NZ') 

 INSERT  fornecedores3 VALUES  ('321','EuroGroup') 
 INSERT  fornecedores3 VALUES  ('442','UKArchip') 
  
 INSERT  fornecedores4 VALUES  ('475','India') 
 INSERT  fornecedores4 VALUES  ('521','Afrique') 

--simular erro
 INSERT  fornecedores4 VALUES  ('10','India') 
 INSERT  fornecedores4 VALUES  ('25','Afrique') 

 --criando view
 CREATE VIEW v_fornec_geral  
	as
	SELECT id_fornec,fornec FROM  fornecedores1 
	UNION ALL 
	SELECT id_fornec,fornec FROM fornecedores2 
	UNION ALL 
	SELECT id_fornec,fornec FROM fornecedores3 
	UNION ALL 
	SELECT id_fornec,fornec FROM  fornecedores4 

--Select na view v_fornec_geral

select * from v_fornec_geral

--Alterando a View
alter VIEW v_fornec_geral  
	as
	SELECT 'f1' origem,id_fornec,fornec FROM  fornecedores1 
	UNION ALL 
	SELECT 'f2',id_fornec,fornec FROM fornecedores2 
	UNION ALL 
	SELECT 'f3',id_fornec,fornec FROM fornecedores3 
	UNION ALL 
	SELECT 'f4',id_fornec,fornec FROM  fornecedores4 

--Select na view v_fornec_geral

 INSERT  fornecedores4 VALUES  ('476','Argentine') ;
 INSERT  fornecedores4 VALUES  ('522','Venezuela') ;

select * from v_fornec_geral
--where origem='f2';

--- ****************************************************************************************************** ---

/* 21)  TABELAS TEMPORÁRIAS  */

--Manipulando Temp table
--CRUD com temp table
use curso
--crianddo tabela temporaria 
  CREATE TABLE #minhatemporaria   
  (      
    campo1 VARCHAR(80) NOT NULL,      
	campo2 MONEY NOT NULL  
  ) 

--inserindo dados na tabela temporaria 
INSERT INTO #minhatemporaria VALUES      ('Real', 1000) 
INSERT INTO #minhatemporaria VALUES      ('Dolar',3000) 

--Selecionando dados na tabela temporaria 
SELECT * FROM   #minhatemporaria 

--exemplo 2
SELECT campo1, campo2 FROM   #minhatemporaria 

--criando tabela temporaria através de um select
 SELECT * INTO   #minhatemporaria2 FROM   #minhatemporaria; 

--Selecionando dados na tabela temporaria 
SELECT * FROM   #minhatemporaria2 

--Atualizando tabela temporaria 
UPDATE #minhatemporaria    SET   campo1='Libra'
 WHERE campo1= 'Real'

--verificando update
 SELECT * FROM #minhatemporaria
 
 SELECT * FROM   #minhatemporaria2 
 
--DELETANDO registros
DELETE  FROM   #minhatemporaria

--Dropando a tabela temporaria 
DROP TABLE #minhatemporaria 
DROP TABLE #minhatemporaria2

--criando tabela temporario com select
use curso
select nome_mun into #sensoTemp from senso

--verifcando dados
select * from #sensoTemp

drop table #sensoTemp;

--criando um tabelas objeto permamente no banco de dados atraves de um select

select * into senso_bk1 from senso;

--verifcando
select * from senso_bk1;

--- ****************************************************************************************************** ---

/* 22)  ESTRUTURA IF  */

--Comando IF

IF 1 = 1
	BEGIN   
		PRINT 'Correto é TRUE' 
	END 
	ELSE 
		PRINT 'Errado é FALSE';
		
DECLARE @a int
set @a = 1
IF @a > 1
print 'a'
else if @a = 1
select * from regiao
	

--IF AND
IF 1 = 1 AND  2 <> 2 
	BEGIN   
		PRINT 'Correto é TRUE' 
	END 
	ELSE 
		PRINT 'Errado é FALSE';

-- exemplo And
IF 1 = 1 AND 2 = 17 
	BEGIN  
		 PRINT 'Correto é TRUE' 
	END 
	ELSE 
		PRINT 'Errado é FALSE';

--Terceiro exemplo OR IF ELSE
IF 1 <> 1 OR 2 = 17 
	BEGIN  
		 PRINT 'Correto é TRUE' 
	END 
	ELSE
		PRINT 'Errado é FALSE';
		
--4 Exemplo 

use curso

--Teste com IF ELSE
DECLARE @id_aluno int;
SET @id_aluno='4';
IF (SELECT Count(*)     
	FROM   matricula     WHERE  id_aluno = @id_aluno ) = 0
		BEGIN   
			PRINT 'Aluno não Matriculado' 
		END
		ELSE   
		BEGIN       
		PRint 'Disciplina Matriculadas';
		SELECT b.nome_disc,a.periodo  from matricula a 
		inner join disciplina b
		on a.id_disciplina=b.id_disciplina
		and a.id_aluno=@id_aluno   
		END ;

--IF 
-- Declaração da variável 
	DECLARE @Idade INT; 
-- Atribuição do valor a variável
	SET @Idade=17; 
-- Se... for menor que 18 anos
	IF @Idade < 18 
		PRINT 'Menor que 18 anos'; 
-- Se não ... 
	ELSE IF @Idade >=18 and @Idade<65
		PRINT 'Maior que 18 anos'; 
	ELSE  
		PRINT 'Maior que 65 anos'; 

--- ****************************************************************************************************** ---

/* 23)  ESTRUTURA WHILE  */

--EXEMPLO 1 WHILE
DECLARE @cont int
SET @cont=10 
WHILE (select  getdate()-@cont) <=getdate()	   
       BEGIN
         Print  getdate()-@cont
		 SET @cont=@cont-1
	   IF (getdate()-@cont)>=getdate()	   
	     
           BREAK

       ELSE
          CONTINUE
        END;

-- Simplificação exemplo acima by Clecio
DECLARE @cont int
SET @cont=10 
WHILE (select  getdate()-@cont) <=getdate()	   
       BEGIN
         Print  getdate()-@cont
		 SET @cont=@cont-1
       END;

--WHILE TABUADA
DECLARE @CONT INT, 
        @TAB INT
SET @CONT = 0
SET @TAB = 3
 
WHILE(@CONT<=10)
BEGIN  
    PRINT CAST(@CONT as nvarchar) + N' X ' + CAST(@TAB as nvarchar) + N' = ' + CAST(@CONT*@TAB as nvarchar)
	SET @CONT = @CONT + 1
END;

-- Ampliação do exemplo acima by Clecio
DECLARE @CONT INT, 
        @TAB INT
SET @CONT = 1
SET @TAB = 1
WHILE(@TAB<=10) 
--PRINT 'Tabuada do: ' + CAST(@TAB as nvarchar)
BEGIN
	WHILE(@CONT<=10)
	
	BEGIN  
	
		PRINT CAST(@TAB as nvarchar)  + N' X ' + CAST(@CONT as nvarchar) + N' = ' + CAST(@CONT*@TAB as nvarchar)
		SET @CONT = @CONT + 1
	END;
	PRINT 'Tabuada do: ' + CAST(@TAB as nvarchar);
	PRINT '-------------------------------' 
	
	SET @CONT = 0
	SET @TAB = @TAB + 1
END



--Mostrar  numero par ou impar em intervalo

DECLARE @val1 INT,  
        @val2 INT,
		@mod INT
SET @val1 = 1
SET @val2 = 10
 
WHILE(@val1<=@val2)
BEGIN  
    SET @mod=@val1%2
	if @mod=0
		BEGIN
			Print 'O Numero '+cast(@val1 as nchar(2))+' é par'
			SET @val1 = @val1 + 1
		END
	else
		BEGIN 
			Print  'O Numero '+cast(@val1 as nchar(2))+' é impar' 
			SET @val1 = @val1 + 1
		END	
END	
		
--- ****************************************************************************************************** ---

/* 24)  POPULANDO TABELAS COM WHILE  */

use curso;
--drop table DIM_DATA
CREATE TABLE DIM_DATA(
	 ID_DIM_DATA int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	 DATA date NOT NULL,
	 ANO smallint NOT NULL,
	 MES smallint NOT NULL,
	 DIA smallint NOT NULL,
	 DIA_SEMANA smallint NOT NULL,
	 DIA_ANO smallint NOT NULL,
	 ANO_BISSEXTO char(1) NOT NULL,
	 DIA_UTIL char(1) NOT NULL,
	 FIM_SEMANA char(1) NOT NULL,
	 FERIADO char(1) NOT NULL,
	 NOME_FERIADO varchar(30) NULL,
	 NOME_DIA_SEMANA varchar(15) NOT NULL,
	 NOME_DIA_SEMANA_ABREV char(3) NOT NULL,
	 NOME_MES varchar(15) NOT NULL,
	 NOME_MES_ABREV char(3) NOT NULL,
	 QUINZENA smallint NOT NULL,
	 BIMESTRE smallint NOT NULL,
	 TRIMESTRE smallint NOT NULL,
	 SEMESTRE smallint NOT NULL,
	 NR_SEMANA_MES smallint NOT NULL,
	 NR_SEMANA_ANO smallint NOT NULL,
	 ESTACAO_ANO varchar(15) NOT NULL,
	 DATA_POR_EXTENSO varchar(50) NOT NULL,
	 EVENTO varchar(50) NULL
);

 --select * from DIM_DATA

 DECLARE @dataInicial date, 
         @dataFinal date, 
		 @data date, 
		 @ano smallint, 
		 @mes smallint, 
		 @dia smallint, 
		 @diaSemana smallint, 
		 @diaUtil char(1), 
		 @fimSemana char(1), 
		 @feriado char(1), 
		 @preFeriado char(1), 
		 @posFeriado char(1), 
		 @nomeFeriado varchar(30), 
		 @nomeDiaSemana varchar(15), 
		 @nomeDiaSemanaAbrev char(3), 
		 @nomeMes varchar(15), 
		 @nomeMesAbrev char(3),
		 @bimestre smallint, 
		 @trimestre smallint, 
		 @nrSemanaMes smallint, 
		 @estacaoAno varchar(15), 
		 @dataPorExtenso varchar(50)

--informe aqui o período para o qual deseja criar os dados
set @dataInicial = '01/01/2012'
set @dataFinal = '31/12/2030'

while @dataInicial <= @dataFinal
begin
 set @data = @dataInicial
 set @ano = year(@data)
 set @mes = month(@data)
 set @dia = day(@data)
 set @diaSemana = datepart(weekday,@data)

 if @diaSemana in (1,7) 
 set @fimSemana = 'S'
 else set @fimSemana = 'N'

 /* feriados locais/regionais e aqueles que não possuem data fixa 
 (carnaval, páscoa e corpus cristis) tb devem ser adicionados aqui */

 if (@mes = 1 and @dia=1) or (@mes = 12 and @dia = 31) --confraternização universal
 set @nomeFeriado = 'confraternização universal'
 else 
 if (@mes = 4 and @dia=21) --tiradentes
 set @nomeFeriado = 'tiradentes'
 else 
 if (@mes = 5 and @dia= 1) --dia do trabalho
 set @nomeFeriado = 'dia do trabalho'
 else 
 if (@mes = 9 and @dia = 7) --independência do brasil
 set @nomeFeriado = 'independência do brasil'
 else 
 if (@mes = 10 and @dia = 12) --nossa senhora aparecida
 set @nomeFeriado = 'nossa senhora aparecida'
 else
 if (@mes = 11 and @dia =2) --finados
 set @nomeFeriado = 'finados'
 else
 if (@mes = 11 and @dia =15) --proclamação da república
 set @nomeFeriado = 'proclamação da república'
 else
 if (@mes = 12 and @dia=25) --natal
 set @nomeFeriado = 'natal'
 else set @nomeFeriado = null
 
 if (@mes = 1 and @dia = 1) or --confraternização universal
 (@mes = 4 and @dia = 21) or --tiradentes
 (@mes = 5 and @dia = 1) or --dia do trabalho
 (@mes = 9 and @dia = 7) or --independência do brasil
 (@mes = 10 and @dia = 12) or --nossa senhora aparecida
 (@mes = 11 and @dia = 2) or --finados
 (@mes = 11 and @dia = 15) or --proclamação da república
 (@mes = 12 and @dia = 25) --natal
 set @feriado = 'S'
 else set @feriado = 'N'


 set @nomeMes = case when @mes = 1 then 'janeiro'
 when @mes = 2 then 'fevereiro'
 when @mes = 3 then 'março'
 when @mes = 4 then 'abril'
 when @mes = 5 then 'maio'
 when @mes = 6 then 'junho'
 when @mes = 7 then 'julho'
 when @mes = 8 then 'agosto'
 when @mes = 9 then 'setembro'
 when @mes = 10 then 'outubro'
 when @mes = 11 then 'novembro'
 when @mes = 12 then 'dezembro' end

 set @nomeMesAbrev = case when @mes = 1 then 'jan'
 when @mes = 2 then 'fev'
 when @mes = 3 then 'mar'
 when @mes = 4 then 'abr'
 when @mes = 5 then 'mai'
 when @mes = 6 then 'jun'
 when @mes = 7 then 'jul'
 when @mes = 8 then 'ago'
 when @mes = 9 then 'set'
 when @mes = 10 then 'out'
 when @mes = 11 then 'nov'
 when @mes = 12 then 'dez' end

 if @fimSemana = 'S' or @feriado = 'S'
 set @diaUtil = 'N'
 else set @diaUtil = 'S'

 set @nomeDiaSemana = case when @diaSemana = 1 then 'domingo'
 when @diaSemana = 2 then 'segunda-feira'
 when @diaSemana = 3 then 'terça-feira'
 when @diaSemana = 4 then 'quarta-feira'
 when @diaSemana = 5 then 'quinta-feira'
 when @diaSemana = 6 then 'sexta-feira'
 else 'sábado' end

 set @nomeDiaSemanaAbrev = case when @diaSemana = 1 then 'dom'
 when @diaSemana = 2 then 'seg'
 when @diaSemana = 3 then 'ter'
 when @diaSemana = 4 then 'qua'
 when @diaSemana = 5 then 'qui'
 when @diaSemana = 6 then 'sex'
 else 'sáb' end

 set @bimestre = case when @mes in (1,2) then 1
 when @mes in (3,4) then 2
 when @mes in (5,6) then 3
 when @mes in (7,8) then 4
 when @mes in (9,10) then 5
 else 6 end

 set @trimestre = case when @mes in (1,2,3) then 1
 when @mes in (4,5,6) then 2
 when @mes in (7,8,9) then 3
 else 4 end

 set @nrSemanaMes = case when @dia < 8 then 1
 when @dia < 15 then 2
 when @dia < 22 then 3
 when @dia < 29 then 4
 else 5 end
--20 Mar 2017 - outono
--21 Jun 2017 - inverno
--22 Set 2017 - primavera
--21 Dez 2017 - verao

 if @data between cast('23/09/'+convert(char(4),@ano) as date) 
	and cast('20/12/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'primavera'
 else if @data between cast('21/03/'+convert(char(4),@ano) as date) 
 and cast('20/06/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'outono'
 else if @data between cast('21/06/'+convert(char(4),@ano) as date) 
 and cast('22/09/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'inverno'
 else -- @data between 21/12 e 20/03
 set @estacaoAno = 'verão'

INSERT INTO DIM_DATA
 SELECT @data
 ,@ano
 ,@mes
 ,@dia
 ,@diaSemana
 ,datepart(dayofyear,@data) --DIA_ANO
 ,case when (@ano % 4) = 0 then 'S' else 'N' end -- ANO_BISSEXTO
 ,@diaUtil
 ,@fimSemana
 ,@feriado
 ,@nomeFeriado
 ,@nomeDiaSemana
 ,@nomeDiaSemanaAbrev
 ,@nomeMes
 ,@nomeMesAbrev
 ,case when @dia < 16 then 1 else 2 end -- QUINZENA
 ,@bimestre
 ,@trimestre
 ,case when @mes < 7 then 1 else 2 end -- SEMESTRE
 ,@nrSemanaMes
 ,datepart(wk,@data)--NR_SEMANA_ANO, smallint
 ,@estacaoAno
 ,lower(@nomeDiaSemana + ', ' + cast(@dia as varchar) + ' de ' + @nomeMes + ' de ' + cast(@ano as varchar))
 ,null--EVENTO, varchar(50))

 set @dataInicial = dateadd(day,1,@dataInicial) 
end

--SELECT  * from DIM_DATA		

--- ****************************************************************************************************** ---

/* 24)  TRY - CATCH TRATANDO ERROS  */

BEGIN TRY  
    -- Testando divisão por zero
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO 

--- ****************************************************************************************************** ---

/* 25)  CURSORES   */

---- CURSORES - EXEMPLO 1

	USE CURSO
	--DECLARA VARIAVEL
	DECLARE @MinhaVariavel VARCHAR(100),
	        @id_aluno int
	--DECLARA O CURSOR 
	DECLARE meu_cursor 
	CURSOR local FOR SELECT id_aluno, NOME FROM ALUNOS 
	--ABRINDO O CURSOR
	open meu_cursor
	-- Lendo a próxima linha
	FETCH next FROM meu_cursor INTO @id_aluno, @MinhaVariavel 
	-- Percorrendo linhas do cursor (enquanto houverem)
	WHILE(@@FETCH_STATUS = 0) 
		begin 
		print cast(@id_aluno as varchar(10))+'-'+@MinhaVariavel+' FETCH_STATUS-> '+cast(@@FETCH_STATUS as varchar(10))
	-- Lendo a próxima linha
		FETCH next FROM meu_cursor INTO @id_aluno,@MinhaVariavel 
	end
	print 'FETCH_STATUS-> '+cast(@@FETCH_STATUS as varchar(10))
	-- Fechando Cursor para leitura
	close meu_cursor
	-- Finalizado o cursor
	deallocate meu_cursor

---- CURSORES - EXEMPLO 2

--Preparando base para cursor para UPDATE
--drop table clifor
use curso
-- criando nova tabela através de select
 select a.BusinessEntityID codpessoa,
	    a.FirstName nome,
		a.LastName sobrenome,
		cast('' as varchar(100)) nomecompleto
        into clifor
  from AdventureWorks2017.person.person a
--verifcando dados carregado sem nome completo
select * from clifor

--Inicio cursor (Declara Variavies)
DECLARE @codpessoa   INT, 
        @primeironome VARCHAR(50), 
        @sobrenome    VARCHAR(50), 
        @nomecompleto VARCHAR(100) 
-- Cursor para percorrer os registros 
DECLARE cursor1 CURSOR FOR 
  SELECT codpessoa, 
         nome, 
         sobrenome 
  FROM   clifor 

--Abrindo Cursor 
OPEN cursor1 

-- Lendo a próxima linha 
FETCH next FROM cursor1 INTO @codpessoa, @primeironome, @sobrenome 

-- Percorrendo linhas do cursor (enquanto houverem) 
WHILE @@FETCH_STATUS = 0 
  BEGIN 
      -- Executando as rotinas desejadas manipulando o registro 
      UPDATE clifor 
      SET    nomecompleto =@primeironome+' '+@sobrenome 
      WHERE  codpessoa = @codpessoa 

      -- Lendo a próxima linha 
      FETCH next FROM cursor1 INTO @codpessoa, @primeironome, @sobrenome 
  END 

-- Fechando Cursor para leitura 
CLOSE cursor1 

-- Finalizado o cursor 
DEALLOCATE cursor1 

--verficando dados
--select * from clifor
--criando chave primaria para otimizar consulta/update
ALTER TABLE clifor ADD CONSTRAINT PK_id1 PRIMARY KEY (codpessoa);
-- apagando primary key para testes
alter table clifor drop constraint pk_id1 

---- CURSORES - EXEMPLO 3

use curso
--drop table cli_nome
create table cli_nome
(cod_cliente int primary key not null,
 nome_completo varchar(100) not null
 );

 --select * from cli_nome

--CRIANDO CURSOR PARA INSERT
--DECLARANDO VARIAVEIS
    DECLARE @codcliente int, 
	        @primeironome VARCHAR(30), 
			@sobrenome VARCHAR(60), 
			@nomecompleto VARCHAR(90)
 
-- Cursor para percorrer os registros
DECLARE cursor1 CURSOR FOR
select a.BusinessEntityID, a.FirstName, a.LastName from AdventureWorks2017.Person.Person a
 
--Abrindo Cursor
OPEN cursor1
 
-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codcliente, @primeironome, @sobrenome
 
-- Percorrendo linhas do cursor (enquanto houverem)
WHILE @@FETCH_STATUS = 0
BEGIN
 
-- Executando as rotinas desejadas manipulando o registro
--update clientes set nomecompleto = @primeironome + ' ' + @sobrenome where codcliente = @codcliente
 SET @nomecompleto=@primeironome + ' ' + @sobrenome;
 insert into cli_nome values (@codcliente,@nomecompleto);
-- Lendo a próxima linha



--verifindo insert 
--select * from cli_nome

---- CURSORES - EXEMPLO 4

--drop table tabela_clientes
--go
USE curso;
GO
create table tabela_clientes(
id_cliente int not null primary key,
nome_cliente varchar(200),
cpf_cliente varchar(20)
)
go
--delete from tabela_clientes
insert into tabela_clientes values
(1,'Fabio', NULL),
(2,'Jorge', 21325658454),
(3,'Jack', NULL),
(4,'Peter', 34132567878)
--go

--select * from tabela_clientes
--go

DECLARE
@id_cliente int,
@nome_cliente VARCHAR(200),
@cpf_cliente VARCHAR(20)

--Declarando o cursor
DECLARE nome_do_cursor CURSOR FOR

--dados que o cursor ira trabalhar
SELECT
       id_cliente,nome_cliente, cpf_cliente
FROM   tabela_clientes

--abre o cursor
OPEN nome_do_cursor

--posicionar o ponteiro do cursor na primeira linha do resultado do select acima
FETCH NEXT FROM nome_do_cursor

--insere nas variaveis os valores da primeira linha do resultado armazenado no cursor
INTO @id_cliente,@nome_cliente, @cpf_cliente

--Esse parte diz "Enquanto tiver linha no cursor, faça:"
WHILE @@FETCH_STATUS = 0

--Nessa parte você insere o bloco de instruções que ira trabalhar no seu cursor.

--Se CPF for igual a nulo
BEGIN
IF (@cpf_cliente is NULL)
--Inserir no final do nome da pessoa o texto "Atualizar CPF"
	BEGIN
--UPDATE tabela_clientes SET nome_cliente = @nome_cliente + ' Atualizar CPF' where cpf_cliente is  null
	UPDATE tabela_clientes SET cpf_cliente = 'Atualizar CPF'
    where cpf_cliente is  null
	and id_cliente=@id_cliente
	END
FETCH NEXT FROM nome_do_cursor
INTO @id_cliente,@nome_cliente, @cpf_cliente
END

--Para fechar o cursos você precisar inserir os seguinte comandos
CLOSE nome_do_cursor
DEALLOCATE nome_do_cursor

--FIM

--select * from tabela_clientes

---- CURSORES - EXEMPLO 5

--CRIANDO TABELA PARA CURSOR
--drop table contapagparc
create table contapagparc
(
 num_doc  int ,
 dtvenc  date,
 parcela  int
 );
--verificando estrutura
select  num_doc,dtvenc from contapagparc
select *  from contapagparc


insert into contapagparc values ('1',getdate()+30,'')
insert into contapagparc values ('1',getdate()+45,'')
insert into contapagparc values ('1',getdate()+60,'')

insert into contapagparc values ('2',getdate()+15,'')
insert into contapagparc values ('2',getdate()+20,'')
insert into contapagparc values ('2',getdate()+25,'')

--select * from contapagparc

DECLARE @num_doc AS INT 
DECLARE @dtvenc AS DATE 
DECLARE @cont AS INT =0 
DECLARE @num_doc_aux AS INT 

DECLARE cursorparc CURSOR FOR 
  SELECT num_doc, 
         dtvenc 
  FROM   contapagparc 
  ORDER  BY num_doc, 
            dtvenc ASC 

OPEN cursorparc 

FETCH next FROM cursorparc INTO @num_doc, @dtvenc 

WHILE @@FETCH_STATUS = 0 
  --status fecth  
  -- 0 Instrucao bem sucedida 
  -- 1 instrucao falhou  
  -- 2 a linha buscado nao existe 
  BEGIN 
      IF @num_doc_aux <> @num_doc 
        BEGIN 
            SET @cont=1; 
            SET @num_doc_aux= @num_doc; 
        END 
      ELSE 
        BEGIN 
            SET @cont=@cont + 1 
            SET @num_doc_aux= @num_doc; 
        END 

      --atualizazao 
      UPDATE contapagparc 
      SET    parcela = @cont 
      WHERE  num_doc = @num_doc 
             AND dtvenc = @dtvenc; 

      FETCH next FROM cursorparc INTO @num_doc, @dtvenc 
  END 

CLOSE cursorparc 

DEALLOCATE cursorparc 

--select * from contapagparc

---- CURSORES - EXEMPLO 6

--CRIA E POPULA TABELA DE TESTE
use curso
--DROP TABLE ##DADOS
 
CREATE TABLE ##DADOS 
(
  NUMERO int NULL,
  NOME VARCHAR(20),
 );
 
INSERT INTO ##DADOS VALUES (1,'Jack')
INSERT INTO ##DADOS VALUES (2,'Peter')
INSERT INTO ##DADOS VALUES (3,'Sam')
INSERT INTO ##DADOS VALUES (4,'Malcon')
INSERT INTO ##DADOS VALUES (5,'David')
INSERT INTO ##DADOS VALUES (6,'Marlos')
INSERT INTO ##DADOS VALUES (7,'Greg')
INSERT INTO ##DADOS VALUES (8,'Jorge')
INSERT INTO ##DADOS VALUES (9,'Richard')
INSERT INTO ##DADOS VALUES (10,'Anne')

-- select * from ##DADOS
--Declarando cursor
DECLARE cDados SCROLL CURSOR FOR
SELECT NUMERO,NOME FROM ##DADOS
 
--Abre cursor
OPEN cDados;
 
--Verifica a quantidade de linhas
SELECT @@CURSOR_ROWS;
 
--Primeiro registro do cursor
FETCH ABSOLUTE 1 FROM cDados;
 
--Próximo registro
FETCH NEXT FROM cDados;
 
--Último Registro
FETCH LAST FROM cDados;
 
--Retorna a linha anterior ao registro atual do cursor
FETCH PRIOR FROM cDados;
 
--Volta para a segunha linha do cursor
FETCH ABSOLUTE 2 FROM cDados;
 
--Avança três registros em relação ao registro atual
FETCH RELATIVE 3 FROM cDados;
 
--Retrocede dois registros em relação ao registro atual
FETCH RELATIVE -2 FROM cDados;
 
CLOSE cDados;
DEALLOCATE cDados;

---- CURSORES - EXEMPLO 7

USE curso 

DECLARE @id_aluno  INT, 
        @nome      VARCHAR(30), 
        @nome_disc VARCHAR(30), 
        @periodo   VARCHAR(10) 
--DECLARANDO PRIMEIRO CURSOR 
DECLARE c_alunos CURSOR FOR 
  SELECT id_aluno, 
         nome 
  FROM   alunos 

OPEN c_alunos 

FETCH next FROM c_alunos INTO @id_aluno, @nome 

--REPETICAO PRIMEIRO CURSOR 
WHILE @@FETCH_STATUS = 0 
  BEGIN 
      PRINT 'Nome do Aluno: ' + @nome; 

      PRINT 'Disciplinas:'; 

      --DECLARANDO SEGUNDO CURSOR
      DECLARE c_disciplina CURSOR FOR 
        SELECT b.nome_disc, 
               a.periodo 
        FROM   matricula a 
               INNER JOIN disciplina b 
                       ON a.id_disciplina = b.id_disciplina 
        WHERE  a.id_aluno = @id_aluno 

      OPEN c_disciplina 

      FETCH next FROM c_disciplina INTO @nome_disc, @periodo 

      --REPETICAO SEGUNDO CURSOR 
      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            PRINT @nome_disc; 

            FETCH next FROM c_disciplina INTO @nome_disc, @periodo 
        --FECHANDO REPETICAO SEGUNDO CURSOR 
        END 

      --FECHANDO DESALOC SEGUNDO CURSOR 
      CLOSE c_disciplina 

      DEALLOCATE c_disciplina 

      PRINT '---------------:'; 
	  --LENDO PROXIMO REGISTRO CURSOR 1
      FETCH next FROM c_alunos INTO @id_aluno, @nome 
  --FECHANDO REPETICAO PRIMEIRO CURSOR 
  END 

--FECHANDO DESALOC SEGUNDO CURSOR 
CLOSE c_alunos 

DEALLOCATE c_alunos 

--- ****************************************************************************************************** ---

/* 25)  FUNÇÕES  */

-- ESCALAR EXEMPLO 1
--Criando função escalar TRIM

--drop function Trim
USE curso;
go
--drop FUNCTION FN_Trim;

CREATE FUNCTION FN_Trim(@ST VARCHAR(1000)) 
 returns VARCHAR(1000)   
  BEGIN       
	RETURN(Ltrim(Rtrim(@ST)))   
  END;

--Invocando função escalar TRIM
SELECT '>' + ('      Silva Telles       ')+'<' TESTE1
union
SELECT '>' + dbo.FN_Trim('      Silva Telles       ')+'<' TESTE2

-- Tamanho dos strings by Clecio
SELECT len('          FASDFASDFASDF              ') 
select len(dbo.FN_Trim('          FASDFASDFASDF              '))

--PARA ALTERAR FUNÇÃO
ALTER  FUNCTION FN_Trim(@ST VARCHAR(500)) 
 returns VARCHAR(500)   
  BEGIN       
	RETURN(Ltrim(Rtrim(@ST)))   
  END

--APAGAR FUNÇÃO
DROP FUNCTION FN_Tri;

-- ESCALAR EXEMPLO 2 
-- Criando função escalar Soma

--drop function Soma
use curso
go
CREATE FUNCTION Soma(@num1 INT,@num2 INT) 
	returns INT   
	BEGIN       
		DECLARE @res INT       
		SET @res=@num1 + @num2       
		RETURN ( @res )   
	END

--Invocando função escalar Soma

SELECT '>>>' ,dbo.SOMA(5,3)

-- drop table #testesoma
-- inserindo dados em tabela temporária
create table #testesoma
 (val1 int,
  val2 int
  )
  
  --inserindo valores
  insert into #testesoma values (10,2),(5,4),(89,3)
  -- select * from #testesoma
  -- invocando funcao soma 
  select val1,
         val2,
         dbo.soma(val1,val2)
   from #testesoma

-- ESCALAR EXEMPLO 3 
-- Criando função escalar Retorna Estoque

use curso
-- CRIANDO TABELA
-- DROP TABLE SALDOS
-- DROP FUNCTION SALDO
CREATE TABLE SALDOS
 (NUM_CONTA  VARCHAR(10) NOT NULL PRIMARY KEY,
  SALDO_INICIAL DECIMAL(10,2),
  SALDO_FINAL   DECIMAL(10,2)
  );
--INSERINDO VALORES
  INSERT INTO SALDOS VALUES ('123-9',1000,1000),('124-7',1000,500),('125-6',500,1000);

--FUNÇAO ESCALAR
CREATE FUNCTION SALDO(@CONTA VARCHAR(10)) returns DECIMAL AS    
BEGIN       
	DECLARE @SALDO DECIMAL;       
	SELECT @SALDO = SALDO_FINAL-SALDO_INICIAL      
		FROM SALDOS
		WHERE NUM_CONTA=@CONTA; 
			IF ( @SALDO IS NULL )         
			SET @SALDO = 0;       
			RETURN @SALDO;   
	END;
	
--invocante a funcao SALDO
	SELECT NUM_CONTA,
	       SALDO_INICIAL,
		   SALDO_FINAL,
		   dbo.SALDO(NUM_CONTA) AS SALDO
		   FROM   SALDOS
		   
-- ESCALAR EXEMPLO 4 
-- Criando função escalar Retorna Data
-- funcao para receber duas data e retornar intervalo de acordo com parametro.
USE CURSO;
--FUNÇÃO DE TABELA
--VARIAVEL DIA INTERVALOS ENTRE OS DIAS
--DTI DATA INICIAL
--DTF DATA FINAL
--DROP FUNCTION func_dias
Create FUNCTION dbo.func_dias(@dia INT,@dti DATETIME,@dtf DATETIME) 
	returns @tbl TABLE(SEQ INT,DT DATETIME) 
	AS   
	BEGIN  
	  DECLARE @CONT INT;
	   SET @CONT=1;    
		WHILE @dti <= @dtf         
			BEGIN             
				INSERT INTO @tbl  (SEQ,dt) VALUES (@CONT,@dti)             
				SET @dti = Dateadd(day, @dia, @dti) 
				SET @CONT=@CONT+1        
			End
			Return
	end;

--invocando funcao dias
	SELECT * FROM   dbo.func_dias(3,getdate(),getdate()+12) 

-- ESCALAR EXEMPLO 5 
-- Criando função escalar Retorna Cidade

use curso

Create Function FN_Cidades (@UF VarChar(2))
Returns Table
As
 Return(
  Select a.nome_mun,a.populacao from senso a
  Where a.uf = @UF);
 
--Invocando funções 
Select * from dbo.FN_Cidades('SP')

-- ESCALAR EXEMPLO 6 
-- Criando função IN Line

use curso
--drop function func_venda_prod 
--FUNÇÃO INLINE
--drop function FN_ESTADO_POP
--Criando Function  – Table Value
CREATE FUNCTION FN_ESTADO_POP (@regiao varchar(20)) 
returns TABLE 
AS     
RETURN       
(SELECT a.uf,b.estado,b.regiao, sum(a.populacao) as total
        FROM  senso a
		INNER JOIN REGIAO b
		ON a.cod_uf=b.cod_uf
		where b.regiao=@regiao
		group by a.uf,b.estado,b.regiao );

--Invocando funcao 

SELECT * FROM   dbo.FN_ESTADO_POP ('Norte');

print SYSTEM_USER

--- ****************************************************************************************************** ---

/* 26)  PROCEDURES  */

--Retornar Boas Vindas para usuários logados
--drop PROCEDURE proc_msg_boas_vindas
USE curso
GO
CREATE PROCEDURE proc_msg_boas_vindas
AS
BEGIN
	--msg
	PRINT 'Seja Bem-vindo'+' '+ SYSTEM_USER
	--condicional
	IF (datepart(hour,getdate())>8 and datepart(hour,getdate())<12) 
		PRINT 'Bom dia!!!'
	ELSE IF (datepart(hour,getdate())>=12 and datepart(hour,getdate())<=18)
		PRINT 'Boa tarde!!'
	ELSE 
		PRINT 'Boa Noite!!'
	
END

--Executando Procedure
EXEC proc_msg_boas_vindas

----------------------------------
--Procedure para calcular Quadrado
--DROP calc_quadradro;
CREATE PROCEDURE calc_quadradro @PAR1 INT
AS
BEGIN
	SELECT @PAR1*@PAR1 AS QUADRADO
END


--Executando Procedure
EXEC calc_quadradro 3 

--Procedure para calcular CUBO
CREATE PROCEDURE calc_cubo @PAR1 INT
AS
BEGIN
 
	SELECT @PAR1*@PAR1*@PAR1 AS CUBO

END

--Executando Procedure
EXEC calc_cubo 5 

-------------------------------------------------------
--Procedure para calcular IMC- Indice de massa do corpo
--drop procedure calc_imc
USE curso
GO
CREATE PROCEDURE calc_imc @PESO decimal(10,2),@ALTURA decimal(10,2)
AS
BEGIN
--DECLARA VARIVEL
DECLARE @IMC decimal(10,2);
--ATRIBUI VALOR
SET @IMC= @PESO/(@ALTURA*@ALTURA)
--BLOCO CONDICIONAL
	IF @IMC < 17
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Muito abaixo do peso'
	End
	ELSE IF @IMC >= 17 and @IMC <= 18.49
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Abaixo do peso'
	End

	ELSE IF @IMC >= 18.5 and @IMC <= 24.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Peso normal'
	end

	ELSE IF @IMC >= 25 and @IMC <= 29.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Acima do peso'
	End

	ELSE IF @IMC >= 30 and @IMC <= 34.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade I'
	End

	ELSE IF @IMC >= 35 and @IMC <= 39.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade II (severa)'
	End

	ELSE IF @IMC >= 40
		Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade III (mórbida)'
	END
END

--excutando procedure calc_imc
--informando peso e altura
exec calc_imc 70,1.70

-----------------------------
--  PROC CARACTERES - 
--  ASCII Exemplo
--
	select ASCII('SQL')
	select ASCII('S')
	select ASCII('Q')
	select ASCII('?')

/*O exemplo a seguir supõe um conjunto de caracteres ASCII e retorna o valor 
ASCII e o caractere CHAR para cada caractere na cadeia de 
caracteres da frase “TEste*/
	DECLARE @posicao INT, @string CHAR(8)
	-- Initialize the variables. 
	SET @posicao = 1; 
	SET @string = 'Testando'; 
		WHILE @posicao <= Datalength(@string)   
			BEGIN       
				SELECT Ascii(Substring(@string, @posicao, 1))cod_ascii,              
				Char(Ascii(Substring(@string, @posicao, 1))), @posicao as posição  
				
				SET @posicao = @posicao + 1   
			END;

--select Ascii(Substring('Ola Mundo', 1, 1))
			
--LTRIM
--Retorna uma expressão de caractere depois de remover espaços em branco à esquerda

	DECLARE @string_to_trim VARCHAR(60); 
	SET @string_to_trim ='     Cinco espaços no inicio.        '; 
	SELECT  'Texto sem espaço:'+Ltrim(@string_to_trim); 
	SELECT  'Texto sem espaço:'+trim(@string_to_trim); 
	SELECT  'Texto Com espaço:'+@string_to_trim; 

--STR

--Exemplo Retorna dados de caractere convertidos de dados numéricos.

SELECT  Str(123.45, 6, 1);
--Prova de conversao de numerico para caractere
SELECT 'Teste '+Str(123.45, 6, 1);
SELECT 'Teste '+Str(1123.45, 7, 2);
--sumila erro
SELECT 'Teste '+123.45;

/*Quando a expressão excede o comprimento especificado, a cadeia de 
caracteres retorna ** para o comprimento especificado*/

SELECT Str(123.45, 2, 2); 

--CONCAT
/*Retorna uma cadeia de caracteres que é o resultado da concatenação de dois ou mais valores*/
 
SELECT  Concat(CURRENT_USER, 
               ' Seu Saldo é R$', 
			   11.00, 
			   ' em ',
               day(getdate()),'/',
			   month(getdate()),'/',
			   year(getdate())) AS Resultado;

--Simulando erro com
SELECT CURRENT_USER+ 
               ' Seu Saldo é R$'+ 
			   11.00+
			   ' em '+
               day(getdate())+'/'+
			   month(getdate())+'/'+
			   year(getdate())AS Resultado;

--CONCAT_WS 
--Separa e retornar valores de cadeia de caracteres concatenados com o delimitador especificado ]
--no argumento da primeira função.
--Atenção ignora valores null 
USE crm;

SELECT CONCAT_WS(';',a.primeiro_nome,a.ultimo_nome,a.email,a.nascimento,a.sexo)
 from cliente a;

--exemplo
use curso
--select a.id_aluno,a.nome,b.id_disciplina,c.nome_disc,b.periodo from alunos a
--select CONCAT_WS('|',a.id_aluno,a.nome,b.id_disciplina,c.nome_disc,b.periodo) from alunos a
select CONCAT_WS('|',a.id_aluno,a.nome,
                  isnull(b.id_disciplina,''),
                  isnull(c.nome_disc,''),
                  isnull(b.periodo,'sem period')) from alunos a
left join matricula b
on a.id_aluno=b.id_aluno
left join disciplina c
on b.id_disciplina=c.id_disciplina;

--REPLACE
/*Substitui todas as ocorrências de um valor da cadeia de caracteres 
especificado por outro valor de cadeia de caracteres*/
--O exemplo a seguir substitui a cadeia de caracteres cde em abcdefghi por xxx.
	
	SELECT 'abcdefghicde' de,
		Replace('abcdefghicde', 'cde', 'xxx') para

--O exemplo a seguir substitui a cadeia de caracteres cde em teste por producao.
SELECT  'Isto é teste' de,
		Replace('Isto é teste', 'teste', 'producao')para;

--REPLACE NO SELECT
	use curso
	SELECT REGIAO,
		REPLACE(REGIAO,'Sul','South') 
		FROM regiao

--Exemplo de Update usando replace.

CREATE TABLE pessoas   
	(nome VARCHAR(30) 
	) 
--inserindo registros
	INSERT INTO pessoas VALUES ('José') 
	INSERT INTO pessoas VALUES ('André') 
	INSERT INTO pessoas VALUES('Helem') 
--verificando registros

select * from pessoas
--
UPDATE pessoas SET nome=replace(nome, 'é', 'e');

--REPLICATE
--Repete um valor da cadeia de caracteres um número especificado de vezes
/*O exemplo a seguir replica um caractere 0 quatro vezes na frente de um código 
de linha de produção no banco de dados*/
    use AdventureWorks2017
	SELECT name,
	       productline,
		   Replicate('0', 4) + productline AS 'Codigo' 
	FROM   Production.product 
	WHERE  productline = 'T' 
	ORDER  BY name

/*Usando REPLICATE e DATALENGTH
O exemplo a seguir preenche números à esquerda até um comprimento especificado, 
à medida que são convertidos de um tipo de dados numérico em caractere ou Unicode.*/

--LEFT
--Retorna a parte da esquerda de uma cadeia de caracteres com o número de caracteres especificado.

	use AdventureWorks2017
	SELECT  NAME,
			LEFT(NAME, 5) 
	FROM   production.product 
	ORDER  BY productid;

--UPPER
--Retorna uma expressão de caractere com dados de caractere em minúsculas convertidos em maiúsculas
	use curso
	SELECT estado, 
		   upper(estado) 
	from regiao

--SUBSTRING
--Retorna uma substring de caractere com dados de caractere dento do parâmetro informado
use AdventureWorks2017
	SELECT lastname nome,        
		   Substring(lastname, 1, 3)  lastname1,        
		   Substring(lastname, 4, 10) lastname2 
	FROM   person.person 
	ORDER  BY lastname; 

--REVERSE
--Retorna a ordem inversa de um valor da cadeia de caracteres.

	SELECT firstname,        
		   Reverse(firstname) AS Reverse 
		   FROM   person.person 
   WHERE  businessentityid < 5 
   ORDER  BY firstname

--LEN
--Retorna o número de caracteres da expressão da cadeia de caracteres especificada, 
--excluindo espaços em branco à direita
	SELECT  firstname,
			Len(firstname) AS Tamanho        	             
   FROM   sales.vindividualcustomer 
   WHERE  countryregionname = 'Australia'; 
   
--DATALENGTH
--Retorna o número de bytes usado para representar qualquer expressão
	SELECT  NAME,
			Datalength(NAME)as data       	    
	FROM   production.product 
	ORDER  BY NAME;

--Comparando Datalength com Len
SELECT  NAME,
		Datalength(NAME)as Datalength,
       Len(NAME)as len		    
	FROM   production.product 
	ORDER  BY NAME

use curso
--drop table t1
CREATE TABLE t1   
	(      c1 VARCHAR(3),      
			c2 CHAR(3),
			c3 NVARCHAR(3)  
	 );

INSERT INTO t1 VALUES      ('2','2','2') 
INSERT INTO t1 VALUES      ('37','37','37') 
INSERT INTO t1 VALUES      ('597','597','597') 

--select * from t1
--drop table t1
SELECT c1,
       c2,
	   c3,
	   Datalength(c1)dtlc1,
	   Datalength(c2)dtlc2,
	   Datalength(c3)dtlc3
	   FROM   t1;

--RIGHT
--Retorna a parte da direita de uma cadeia de caracteres com o número de caracteres especificado
use curso
	SELECT a.estado,
		   RIGHT(estado, 5) AS 'Estado' 
	FROM   regiao a
	
--LOWER
--Retorna uma expressão de caractere depois de converter 
--para minúsculas os dados de caracteres em maiúsculas
--O exemplo a seguir usa a função LOWER, a função UPPER, 
--e aninha a função UPPER dentro da função LOWER selecionando 
--nomes de produtos com preços entre US$ 11 e US$ 20. 
--Este exemplo usa o banco de dados AdventureWorks2014

use AdventureWorks2017
	SELECT Substring(NAME, 1, 20)name,
		   Lower(Substring(NAME, 1, 20)) AS Lower,        
		   Upper(Substring(NAME, 1, 20)) AS Upper,        
		   Lower(Upper(Substring(NAME, 1, 20))) AS LowerUpper 
   FROM   production.product 
   WHERE  listprice BETWEEN 11.00 AND 20.00; 

--RTRIM
--Retorna uma cadeia de caracteres depois de truncar todos os espaços em branco à direita
--EXEMPLO SIMPLES
SELECT Rtrim('Removendo espaços.   ');

--EXEMPLO 2
	DECLARE @string_to_trim VARCHAR(60); 
	SET @string_to_trim ='Deixamos 4 espacos apos final da sentença.    '; 
	SELECT @string_to_trim + ' proxima string.'; 
	SELECT Rtrim(@string_to_trim) + ' proxima string.'


-- PROC CRUD

--DROP TABLE CAD_PESSOA;
USE curso
GO
CREATE TABLE CAD_PESSOA 
(
    ID_PESSOA INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(50),
    EMAIL VARCHAR(30),
    SITUACAO CHAR(1),
    CONSTRAINT CK_SITUA CHECK(SITUACAO IN('B','A'))
    );

--DROP PROCEDURE SP_CRUD
--PROCEDURE DE CADASTRO
CREATE  PROCEDURE SP_CRUD         @V_OPER       CHAR(1), --I INSERIR --A -ATUALIZA --S SELECIONA - D--DELETE
                                  @V_ID_PESSOA  INTEGER, --CODIGO DA PESSOA
                                  @V_NOME       VARCHAR(50),
                                  @V_EMAIL      VARCHAR(30),
                                  @V_SITUACAO   CHAR(1)
AS
BEGIN 
 --declarando variaveis
DECLARE
  @V_SID_PESSOA INTEGER,
  @V_SNOME VARCHAR(50),
  @V_SEMAIL VARCHAR(30),
  @V_SSITUACAO CHAR(1);

BEGIN TRANSACTION  
--verifica operacao de insert
  IF (@V_OPER = 'I') 
  BEGIN
    IF (@V_ID_PESSOA is null or   @V_ID_PESSOA='' or @V_NOME is null OR @V_NOME='' 
	or  @V_EMAIL is nulL or @V_EMAIL='')
        BEGIN 
            ROLLBACK;
            PRINT 'CAMPOS IMCOMPLETOS';
			GOTO FIM_ERRO
        END
		ELSE
           INSERT INTO CAD_PESSOA(ID_PESSOA, NOME,EMAIL, SITUACAO) VALUES (@v_id_pessoa, @v_NOME, @v_email,'A');
		   GOTO FIM_CERTO 
		END
   END
  
--verifica operacao de atualização
  
     IF (@V_OPER = 'A') 
		BEGIN
			IF (@V_ID_PESSOA is null or   @V_ID_PESSOA='') 
              BEGIN
				ROLLBACK;
				PRINT 'CAMPOS IMCOMPLETOS';
				GOTO FIM_ERRO
			END
        ELSE
            UPDATE CAD_PESSOA SET NOME =ISNULL(@V_NOME,NOME), EMAIL=ISNULL(@V_EMAIL,EMAIL),
			SITUACAO=ISNULL(@V_SITUACAO,SITUACAO)
            WHERE ID_PESSOA = @V_ID_PESSOA;
		    GOTO FIM_CERTO
       END 
	   
  --verifica operacao de delete
    IF(@V_OPER = 'D') BEGIN
     IF (@V_ID_PESSOA is null or @V_ID_PESSOA='') 
       BEGIN
        ROLLBACK;
        PRINT 'CAMPOS IMCOMPLETOS';
		GOTO FIM_ERRO
       END
	   ELSE
            DELETE FROM CAD_PESSOA WHERE ID_PESSOA = @V_ID_PESSOA;
			 GOTO FIM_CERTO
     END
	
 --verifica operacao de select
   IF (@V_OPER = 'S') 
    BEGIN
  
	SELECT @V_SID_PESSOA=a.id_pessoa,@V_SNOME=a.nome,@V_SEMAIL=email,@V_SSITUACAO=situacao
    FROM CAD_PESSOA a 
	WHERE ID_PESSOA = @V_ID_PESSOA;
   
		 PRINT CONCAT('ID: ',@V_SID_PESSOA); 
		 PRINT 'Nome: '+@V_SNOME; 
		 PRINT 'e-mail: '+@V_SEMAIL; 
		 PRINT 'Situacao: '+@V_SSITUACAO; 

		 GOTO FIM_CERTO
    
	END
   
 FIM_CERTO:
 COMMIT; 
 PRINT 'DADOS SELECIONADOS,INSERIDOS OU ATUALIZADO COM SUCESSO'; 
 GOTO FIM
 
 FIM_ERRO:
 PRINT 'ALGO DEU ERRADO!!!'; 

 FIM:
 PRINT 'FINALIZADO!!!'; 

 --INSERT
 EXECUTE   SP_CRUD 'I',1,'JONHY','JONHY@JONHY.COM','A';
 EXECUTE   SP_CRUD 'I',2,'PETER','PETER@PETER.COM','A';
 EXECUTE   SP_CRUD 'I',3,'DEREK','DEREK@DEREK.COM','A';

 --TESTE
 EXECUTE   SP_CRUD 'I',5,NULL,'JP@JP.COM','A';

 --SELECT 
EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=4,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;

--UPDATE
EXECUTE SP_CRUD @V_OPER='A',@V_ID_PESSOA=4,@V_NOME='NUNO',@V_EMAIL='NUNO@NUNO.COM',@V_SITUACAO='A'

 --SELECT 
EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=2,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;
--DELETE
EXECUTE SP_CRUD @V_OPER='D',@V_ID_PESSOA=4,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;
--EXEMPLO
EXECUTE SP_CRUD 'D',4,NULL,NULL,NULL

 --SELECT 
EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=2,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;

SELECT * FROM CAD_PESSOA
 
--- ****************************************************************************************************** ---

/* 27)  TRIGGERS  */

 USE CURSO
--DROP TABLE FUNC
CREATE TABLE FUNC (
 MATRICULA INT IDENTITY(1,1) PRIMARY KEY,
 NOME VARCHAR(30) NOT NULL,
 SOBRENOME VARCHAR (30) NOT NULL,
 ENDERECO  VARCHAR (30) NOT NULL,
 CIDADE    VARCHAR (30) NOT NULL,
 ESTADO    VARCHAR (2) NOT NULL,
 DATA_NASC  DATETIME
 ) ; 
insert into func values ('Steve','Morse','Rua 13','JUNDIAI','SP','1977-11-05')
insert into func values ('Joao','Pedro','Rua 14','SÃO PAULO','SP','1980-27-10')
insert into func values ('Maria','Clara','Rua 15','RIBERAO PRETO','SP','1985-05-05')
insert into func values ('Pedro','Luiz','Rua 16','CAMPINAS','SP','1990-12-09')

--SELECT * FROM FUNC
--DROP TABLE auditoria_salario
create table auditoria_salario (
matricula varchar(30) not null,
sal_antes decimal(10,2)  not null,
sal_depois decimal(10,2)  not null,
usuario varchar(20) not null,
data_atualizacao datetime not null
);

--DROP TABLE SALARIO
CREATE TABLE SALARIO 
( matricula INT NOT NULL,
  SALARIO DECIMAL(10,2) NOT NULL
  );

insert into SALARIO values (1,1000)
insert into SALARIO values (2,1500)
insert into SALARIO values (3,2000)
insert into SALARIO values (4,2500)

SELECT * FROM SALARIO

--drop trigger TG_aud_sal

create trigger TG_aud_sal --unico registro
	on SALARIO 
		after UPDATE
	as
	Begin		
	
		declare @sal_antigo decimal(10,2)
		declare @sal_novo decimal(10,2)
		declare @matricula int
			
		select @matricula  = (select matricula from inserted)
		select @sal_antigo = (select SALARIO from deleted)
		select @sal_novo   = (select SALARIO from inserted)
							
	Insert into auditoria_salario 
	values 
	(@matricula, isnull(@sal_antigo,0), @sal_novo, SYSTEM_USER, getdate())
			
	end	

--TESTANDO TRIGGER
update salario set salario ='2500' where matricula='1'

update salario set salario ='3000' where matricula='2'

update salario set salario ='3500' where matricula='3'

update salario set salario ='4000' where matricula='4'


select * from auditoria_salario;

--verificando problema problema
update salario set salario=salario*1.10;

---------------------------------------------------------
--multiplos registros
--DISABLE TRIGGER TG_aud_sal on salario
--ENABLE TRIGGER TG_aud_sal on salario
use curso
--drop trigger TG_aud_sal2
CREATE TRIGGER tg_aud_sal2 
ON salario 
after UPDATE 
AS 
  BEGIN 
      DECLARE @matricula_aux INT 
      DECLARE cursor_processo CURSOR FOR 
       
	    SELECT matricula  FROM   inserted /*TABELA VIRTUAL INSERT */

      OPEN cursor_processo 

      FETCH next FROM cursor_processo INTO @matricula_aux 

      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            INSERT INTO auditoria_salario 
            SELECT       i.matricula, 
                         d.salario, --sal antigo
                         i.salario, --sal novo
                         SYSTEM_USER, 
                         Getdate() 
            FROM   deleted d, 
                   inserted i 
            WHERE  d.matricula = i.matricula 
                   AND @matricula_aux = i.matricula 

            FETCH next FROM cursor_processo INTO @matricula_aux 
        END 

      CLOSE cursor_processo 

      DEALLOCATE cursor_processo 
  END 
/*	
    delete from auditoria_salario
	
	update salario set salario=salario*1.15
	
	select * from auditoria_salario
	select * from salario
*/

--DROP TABLE conta_corrente
use curso
go
--drop table conta_corrente
create table conta_corrente
( conta_c varchar(20) not null,
  valor   decimal(10,2) not null,
  operacao char(1) not null --D / C
  ) 
--drop table saldo_conta
  create table saldo_conta
  (conta_c varchar(20) not null,
   saldo   decimal(10,2) not null
  );

----------------------------------------------------------------------  
--criando trigger para atualizar tabelas saldo;
--drop trigger TG_SALDO_CC
CREATE TRIGGER TG_SALDO_CC
ON conta_corrente 
FOR INSERT
AS 
  BEGIN 
      DECLARE @CONTA_C VARCHAR(20), 
              @VALOR   DECIMAL(10, 2), 
              @OPER    CHAR(1) 

      SELECT @CONTA_C = I.conta_c, 
             @VALOR = I.valor, 
             @OPER = I.operacao 
      FROM   inserted I 
	  /* D=debito C=credito*/
	
      IF @OPER NOT IN ( 'D', 'C' ) 
        BEGIN 
            PRINT 'OPERACAO NAO PERMITIDA' 

            ROLLBACK TRANSACTION 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) = 0 
         AND @OPER = 'D' 
        BEGIN 
            INSERT INTO saldo_conta 
            VALUES      (@CONTA_C, 
                         @VALOR *- 1) 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) = 0 
         AND @OPER = 'C' 
        BEGIN 
            INSERT INTO saldo_conta 
            VALUES      (@CONTA_C, 
                         @VALOR) 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) > 0 
         AND @OPER = 'C' 
        BEGIN 
            UPDATE saldo_conta 
            SET    saldo = saldo + @VALOR 
            WHERE  conta_c = @CONTA_C 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) > 0 
         AND @OPER = 'D' 
        BEGIN 
            UPDATE saldo_conta 
            SET    saldo = saldo - @VALOR 
            WHERE  conta_c = @CONTA_C 
        END 
  END 

--testando trigger
--PARAMETROS   CONTA CORRENTE, VALOR , OPERACAO
--gerar movimentos
insert into conta_corrente values (123478,1500,'X')
insert into conta_corrente values (123479,2000,'Y')

--gerando movimentos
insert into conta_corrente values (123478,3000,'C')--TESTADO
insert into conta_corrente values (123478,3000,'D')--TESTADO
insert into conta_corrente values (123478,1500,'C')--TESTADO
insert into conta_corrente values (123478,2000,'D')--TESTADO

insert into conta_corrente values (123479,3000,'C')
insert into conta_corrente values (123479,2000,'D')

select * from conta_corrente
select * from saldo_conta
/*
delete from conta_corrente
delete from  saldo_conta
*/

----------------------------------------------------------
--create trigger de restrição DDL
--drop trigger trig_controla_ddl on database
--drop trigger trig_controla_ddl on ALL SERVER
--disable trigger trig_controla_ddl on database
--enable trigger trig_controla_ddl on database

--disable trigger trig_controla_ddl_db on database
--drop TRIGGER trig_controla_ddl_db on database
use curso
GO
create TRIGGER trig_controla_ddl_db 
ON DATABASE
FOR create_procedure, alter_procedure, drop_procedure,CREATE_TABLE,DROP_TABLE, ALTER_TABLE
AS 
    IF Datepart(hh, Getdate()) <= 8 
        OR Datepart(hh, Getdate()) >= 18 
      BEGIN 
          DECLARE @msg VARCHAR(200) 
          SELECT @msg = 'Complete o trabalho em horario comercial' 
          PRINT ( @msg ) 
          ROLLBACK 
      END 

--disable trigger trig_controla_ddl_SRV on ALL SERVER
--drop TRIGGER trig_controla_ddl_SRV on ALL SERVER
create TRIGGER trig_controla_ddl_SRV 
ON ALL SERVER
FOR create_procedure, alter_procedure, drop_procedure,CREATE_TABLE,DROP_TABLE, ALTER_TABLE
AS 
    IF Datepart(hh, Getdate()) <= 8 
        OR Datepart(hh, Getdate()) >= 18 
      BEGIN 
          DECLARE @msg VARCHAR(200) 
          SELECT @msg = 'Complete o trabalho em horario comercial' 
          PRINT ( @msg ) 
          ROLLBACK 
      END 
--teste procudere criacao
--drop PROCEDURE Proc_teste_dml
	 CREATE PROCEDURE Proc_teste_dml
		AS 
		BEGIN 
			PRINT 'Teste de criacao' 
		END 
	  
	  execute proc_teste_dml;

--teste create tabela
    drop table teste_tg
	create table teste_tg
	(
	 numero int
	 );
	
--- ****************************************************************************************************** ---

/* 28)  MERGE  */

--EXEMPLO MERGE
--CRIANDO TABELA TEMPORARIA 1
--DROP TABLE #Tabela1 
CREATE TABLE #Tabela1 
        ( 
		 nome VARCHAR (100),
         cadastro DATETIME,
		 alteracao DATETIME,
		 situacao BIT)

INSERT #Tabela1  VALUES 
			('JACK', GETDATE(), NULL, 1),
            ('PETER', GETDATE(), NULL, 1),
            ('JOHN', GETDATE(), NULL, 1),
            ('MALCON', GETDATE(), NULL, 1),
			('ARTHUR', GETDATE(), NULL, 1)
--DROP TABLE #Tabela2 
CREATE TABLE #Tabela2 
		( nome VARCHAR(100), 
		  email VARCHAR(100))

INSERT #Tabela2  VALUES 
			('JACK','jack@jack.com'),
            ('PETER','peter@peter.com'),
            ('JOHN','john@jonh.com'),
            ('MALCON','malcon@malcon.com'),
			('RICHARD','richard@richard.com')

SELECT * FROM #Tabela1

SELECT * FROM #Tabela2

--INICIO MERGE

MERGE #Tabela1 AS Destino

USING #Tabela2 AS Origem

ON Destino.Nome = Origem.Nome

-- Há registro no destino e na origem
WHEN MATCHED

THEN UPDATE SET situacao = 0, Alteracao = GETDATE()

--Quando não há registro no destino e há na origem
WHEN NOT MATCHED

THEN INSERT (Nome, Cadastro,alteracao,situacao) VALUES (origem.nome, Getdate(), Getdate(),1)

-- Quando  há registro no destino mas não há na origem

WHEN NOT MATCHED BY SOURCE 

THEN UPDATE SET situacao = NULL, alteracao = GETDATE();

--VERIFICANDO RESULTADO
SELECT * FROM #Tabela1

SELECT * FROM #Tabela2 

------------------------------------------------------------
--MERGE SQL statement - Part 1

--Crianda tabela destino
use curso
go
--drop table produtos destino
CREATE TABLE produtos
(
cod_prod INT PRIMARY KEY,
descricao VARCHAR(100),
preco MONEY
) 
GO

--Inserindo dados na tabela
INSERT INTO produtos
VALUES
(1, 'Cha', 10.00),
(2, 'Café', 20.00),
(3, 'Leite',30.00),
(4, 'Pão', 40.00)
GO

INSERT INTO produtos
VALUES (6, 'Acucar', 10.00)
-- Criando tabela
--drop table produto_atualizados origem
CREATE TABLE produto_atualizados
(
cod_prod INT PRIMARY KEY,
descricao VARCHAR(100),
preco MONEY
) 
GO

--Inserindo dados na tabela
INSERT INTO produto_atualizados
VALUES
(1, 'Cha', 10.00),
(2, 'Café', 25.00),
(3, 'Leite', 35.00),
(5, 'Peixe', 60.00)
GO

INSERT INTO produto_atualizados
VALUES (6, 'Sal', 10.00)

SELECT * FROM produtos
SELECT * FROM produto_atualizados
GO

--MERGE SQL Declraçao - Part 2
--Sincronizar a tabela destino
--atualizando com dados da origem
MERGE produtos AS destino
USING produto_atualizados AS origem 
ON (destino.cod_prod = origem.cod_prod) 

-- Há registro no destino e na origem
WHEN MATCHED AND destino.descricao <> origem.descricao 
OR destino.preco <> origem.preco THEN 
UPDATE SET destino.descricao = origem.descricao, 
destino.preco = origem.preco 

--Quando não há registro no destino e há na origem
WHEN NOT MATCHED BY TARGET THEN 
INSERT (cod_prod, descricao, preco) 
VALUES (origem.cod_prod, origem.descricao, origem.preco)

--Quando  há registro no destino mas não há na origem
WHEN NOT MATCHED BY SOURCE THEN 
DELETE
--$action especifica coluna  nvarchar(10) 
--OUTPUTRetorna informações ou expressões baseadas 
--em cada linha afetada por uma instrução INSERT, UPDATE, DELETE ou MERGE
OUTPUT $action, 
DELETED.cod_prod AS Destino_cod_prod, 
DELETED.descricao AS Destino_descricao, 
DELETED.preco AS Destino_preco, 
INSERTED.cod_prod AS origem_cod_prod, 
INSERTED.descricao AS origem_descricao, 
INSERTED.preco AS origem_epreco; 

SELECT @@ROWCOUNT;
GO

SELECT * FROM produtos
SELECT * FROM produto_atualizados
GO