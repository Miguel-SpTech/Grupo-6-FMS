CREATE DATABASE FMS;

use FMS;

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14),
    razao_social VARCHAR(100),
    nome_fantasia VARCHAR(100),
    status VARCHAR(45)
);

CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    senha_hash VARCHAR(255), -- pARA ALTERAR, SENHA HASH PRA SENHA
    cargo VARCHAR(100),
    fkEmpresa INT,
    fkUsuario INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);


CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8),
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(100),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE TipoTelefone (
    idTipoTelefone INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);


CREATE TABLE EmpresaTelefone (
    fkEmpresa INT,
    fkTipoTelefone INT,
    PRIMARY KEY (fkEmpresa, fkTipoTelefone),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkTipoTelefone) REFERENCES TipoTelefone(idTipoTelefone) 
    -- RETIRAR A TABELA TIPO TELEFONE E ADCIONAR UM CAMPO PARA VALIDAR O TIPO TELEFONE COM CHECK
    -- ADCIONAR UMA COLUNA PRO NUMERO
);


CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cpf CHAR(11),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Blocos (
    idBloco INT AUTO_INCREMENT PRIMARY KEY,
    numeracao VARCHAR(50), -- RETIRAR E DEIXAR PARA IDENTIFICAÇAO APENAS IDbLOCO
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATETIME,
    data_manutencao DATETIME,
    status VARCHAR(20), -- CHECK INATIVO ATIVO
    fkBloco INT,
    FOREIGN KEY (fkBloco) REFERENCES Blocos(idBloco)
);


CREATE TABLE Leitores ( -- registros
    idLeitura INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME,
    leitura TINYINT,
    fkSensor INT,
    tipo_leitura VARCHAR(45),
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);


-- INSERT EMPRESA
CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14),
    razao_social VARCHAR(100),
    nome_fantasia VARCHAR(100),
    status VARCHAR(45) -- fazer check ativo inativo
    -- adcionar auto-relacionamento
);


insert into Empresa values
(default,'14654897000152' , 'Pizzaria Di Napoli Alimentos Ltda.', 'Bella Napoli', 'Ativo'),
(default, '28412365000108', 'Massa & Forno Gastronomia Eireli', 'Santo Pedaço', 'Inativo'),
(default, '35987123000144', 'Comércio de Massas Artesanais Lupa Ltda.', 'Luppa Pizza Bar', 'Ativo'),
(default, '42156789000191', 'Rede de Pizzarias Redonda de Ouro S.A.', 'Disco de Ouro', 'Ativo'),
(default, '59321456000127', 'Mamma Mia Serviços de Alimentação Me.', 'Forno da Mamma', 'Inativo');
select * from Empresa;
CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    senha_hash VARCHAR(255),
    cargo VARCHAR(100),
    fkEmpresa INT,
    fkUsuario INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);

-- INSERT USUARIO
insert into Usuario values
(default, 'Ricardo Cavalcante', 'ricardo.admin@pizzaria.com', 'R3c@rd0_99', 'Administrador', 1, null),
(default, 'Mariana Souza', 'mariana.oper@pizzaria.com', 'Mari#S2026', 'Operador', 1, 1),
(default, 'Lucas Gabriel Santos', 'lucas.func@pizzaria.com', 'Lks_8871ab', 'Funcionario', 1, 1),
(default, 'Beatriz Helena Rocha', 'beatriz.oper@pizzaria.com', 'B_Rocha!92', 'Operador', 1, 1),
(default, 'Tiago Oliveira Lima', 'tiago.func@pizzaria.com', 'tig_Oliveira7', 'Funcionario', 1, 1),
(default, 'Fernanda Montes', 'fernanda.adm@pizzaria.com', 'F3rn@nd4_#1', 'Administrador', 2, null),
(default, 'Juliana Paes', 'juliana.oper@pizzaria.com', 'Ju_Oper2026!', 'Operador', 2, 6),
(default, 'Aline Ferreira', 'aline.func@pizzaria.com', 'Ali_Ferr@10', 'Funcionario', 2, 6),
(default, 'Igor Martins', 'igor.func@pizzaria.com', 'Igor_M#2026', 'Funcionario', 2, 6),
(default, 'Gustavo Henrique', 'gustavo.adm@pizzaria.com', 'Gus_Admin!26', 'Adminstrador', 3, null),
(default, 'André Felipe', 'andre.oper@pizzaria.com', 'And_F3lip3', 'Operador', 3, 10),
(default, 'Vanessa Costa', 'vanessa.func@pizzaria.com', 'Van_Cost@81', 'Funcionario', 3, 10),
(default, 'Gabriel Junqueira', 'gabriel.func@pizzaria.com', 'Gabs_Junk77', 'Funcionario', 3, 10),
(default, 'Sabrina Mendes', 'sabrina.func@pizzaria.com', 'Sab_Mend3s@1', 'Funcionario', 3, 10),
(default, 'Camila Arantes', 'camila.adm@pizzaria.com', 'Cami_99Ar#', 'Administrador', 4, null),
(default, 'Patricia Lima', 'patricia.oper@pizzaria.com', 'Pat_Lima$22', 'Operador', 4, 13),
(default, 'Douglas Souza', 'douglas.func@pizzaria.com', 'Doug_Sz!44', 'Funcionario', 4, 13),
(default, 'Leticia Fontes', 'leticia.func@pizzaria.com', 'Let_F0nt3s#', 'Funcionario', 4, 13),
(default, 'Roberto Silveira', 'roberto.adm@pizzaria.com', 'Rob_Silva@88', 'Administrador', 5, null),
(default, 'Sergio Murilo', 'sergio.oper@pizzaria.com', 'Serg_Muri#9', 'Operador', 5, 16),
(default, 'Renata Borges', 'renata.func@pizzaria.com', 'Ren@ta_B0rg', 'Funcionario', 5, 16),
(default, 'Marcos Vinicius Prado', 'marcos.func@pizzaria.com', 'Mrc_Prado!15', 'Funcionario', 5, 16);
select * from Usuario;
select f.nome, f.cargo, c.nome, c.cargo, e.nome_fantasia from Usuario f join Usuario c on f.fkUsuario = c.idUsuario
join Empresa e on f.fkEmpresa = e.idEmpresa order by f.cargo;

-- INSERT ENDERECO
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8),
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(100),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

desc Endereco;
alter table Endereco add column estado char(2) after bairro;
alter table Endereco add column cidade varchar(100) after bairro;
INSERT INTO Endereco VALUES
(default, '01310200', 'Avenida Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', 1),
(default, '20040002', 'Avenida Rio Branco', '45', 'Centro', 'Rio de Janeiro','RJ', 2),
(default, '70150900', 'Praça dos Três Poderes', 'SN', 'Zona Cívico - Administrativa', 'Brasília', 'DF', 3),
(default, '30140061', 'Rua da Bahia', '1022', 'Lourdes', 'Belo Horizonte', 'MG', 4),
(default, '80020100', 'Praça Tiradentes', '290', 'Centro', 'Curitiba', 'PR', 5),
(default, '40020000', 'Praça Visconde de Cayru', '250', 'Comércio', 'Salvador', 'BA', 4),
(default, '60060390', 'Rua dos Tabajaras', '410', 'Praia de Iracema', 'Fortaleza', 'CE', 2),
(default, '90010001', 'Avenida Mauá', '1050', 'Centro Histórico', 'Porto Alegre', 'RS', 1);

select * from Endereco;
-- INSERT TipoTelefone
CREATE TABLE TipoTelefone (
    idTipoTelefone INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);
INSERT INTO TipoTelefone values
(default, 'Telefone Fixo'),
(default, 'Telefone Celular'),
(default, 'Telefone VoIP');
select * from tipoTelefone;
-- INSERT EmpresaTelefone
CREATE TABLE EmpresaTelefone (
    fkEmpresa INT,
    fkTipoTelefone INT,
    PRIMARY KEY (fkEmpresa, fkTipoTelefone),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkTipoTelefone) REFERENCES TipoTelefone(idTipoTelefone)
);
ALTER TABLE EmpresaTelefone ADD COLUMN numero int;
alter table EmpresaTelefone modify column numero varchar(12);
DESC EmpresaTelefone;
INSERT INTO EmpresaTelefone values
(1, 1, 1130559012),
(2, 1, 2125447788),
(3, 1, 6133214455),
(4, 1, 3134215500),
(5, 1, 4132331144),
(1, 2, 11987654321),
(2, 2, 21991223344),
(3, 2, 61984445566),
(4, 2, 31992884050),
(5, 2, 51995556677),
(1, 3, 1140032580),
(4, 3, 3135159900);
select * from EmpresaTelefone;
-- INSERT CLIENTE
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cpf CHAR(11),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);
INSERT INTO Cliente values
(default, 'Marcos Menezes', 'marcos.menezes@rep-brasil.com', '12345678900', 1),
(default, 'Bruno Zimmerman', 'bruno.z@sulrepresentacoes.com.br', '56789012344', 2),
(default, 'Amanda Ferreira', 'amanda.ferreira@norte-distrib.com', '01234567899', 3),
(default, 'Felipe Matos', 'felipe.matos@conexaosul.com.br', '78901234566', 4),
(default, 'Rodrigo Amaral', 'rodrigo.amaral@central-vendas.com', '90123456788', 5);
select * from Cliente;
-- INSERT BLOCOS

CREATE TABLE Blocos (
    idBloco INT AUTO_INCREMENT PRIMARY KEY,
    numeracao VARCHAR(50),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);
select * from Blocos;
INSERT INTO Blocos VALUES
(default, '1A', 1),
(default, '1A', 2),
(default, '1A', 3),
(default, '1A', 4),
(default, '1A', 5),
(default, '1A', 1),
(default, '1B', 2),
(default, '1B', 3),
(default, '1B', 4),
(default, '1B', 5),
(default, '1C', 1),
(default, '1C', 2),
(default, '1C', 3),
(default, '1C', 4);
Update blocos set numeracao = '1B' where idBloco = 6;
select * from Blocos;
-- INSERT SENSOR

CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATETIME,
    data_manutencao DATETIME,
    status VARCHAR(20),
    fkBloco INT,
    FOREIGN KEY (fkBloco) REFERENCES Blocos(idBloco)
);
INSERT INTO Sensor VALUES
(default, '2021-03-15', '2025-04-08', 'Ativo', 1),
(default, '2022-11-28', '2025-01-21', 'Ativo', 6),
(default, '2023-01-10', '2024-10-02', 'Ativo', 2),
(default, '2020-07-22', '2024-08-17', 'Inativo', 7),
(default, '2024-02-05', '2024-05-30', 'Ativo', 3),
(default, '2019-05-12', '2023-11-20', 'Ativo', 8),
(default, '2019-10-30', '2023-07-14', 'Inativo', 9),
(default, '2020-01-15', '2023-03-09', 'Inativo', 10),
(default, '2020-08-04', '2022-12-25', 'Ativo', 4),
(default, '2021-04-22', '2022-06-05', 'Ativo', 11),
(default, '2021-09-11', '2022-02-18', 'Inativo', 5),
(default, '2019-02-04', '2021-12-30', 'Inativo', 12);
select * from Sensor join Blocos on Sensor.fkBloco = Blocos.idBloco;
truncate table Sensor;
desc Leitores;
alter table Leitores add CONSTRAINT fk_sensor foreign key (fkSensor) references Sensor(idSensor);
alter table Leitores drop foreign key leitores_ibfk_1;
show create table Leitores;


-- insert leitor

CREATE TABLE Leitores (
    idLeitura INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME,
    leitura TINYINT,
    fkSensor INT,
    tipo_leitura VARCHAR(45),
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);
alter table Leitores modify column data datetime default (current_timestamp());
-- sensor 1
insert into Leitores values
(null, default, 1, 1, '');
insert into Leitores values
(null, default, 0, 1, '');
-- sensor 2
Insert into Leitores values
(null, default, 1, 2, '');
insert into Leitores values
(null, default, 0, 2, '');
-- sensor 3
insert into Leitores values
(null, default, 1, 3, '');
insert into Leitores values
(null, default, 0, 3, '');
-- sensor 5
insert into Leitores values
(null, default, 1, 5, '');
insert into Leitores values
(null, default, 0, 5, '');
-- sensor 6
insert into Leitores values
(null, default, 1, 6, '');
insert into Leitores values
(null, default, 0, 6, '');
-- sensor 9
insert into Leitores values
(null, default, 1, 9, '');
insert into Leitores values
(null, default, 0, 9, '');
-- sensor 10
insert into Leitores values
(null, default, 1, 10, '');
insert into Leitores values
(null, default, 0, 10, '');

select * from Leitores;

SELECT * FROM sensor order by fkBloco;
SELECT idSensor from Sensor;




show tables;
desc Empresa;
desc Blocos;
desc Cliente;
desc EmpresaTelefone;
desc endereco;
desc Leitores;
desc Sensor;
desc TipoTelefone;
desc Usuario;

alter table Sensor modify column fkBloco int not null;



----------------------------- SELECTS ---------------------------------------


-- SELECT TELEFONE DA EMPRESA
select numero, descricao, nome_fantasia from EmpresaTelefone ET JOIN TipoTelefone T on ET.fkTipoTelefone = T.idTipoTelefone
 JOIN Empresa E on ET.fkEmpresa = E.idEmpresa order by nome_fantasia;

-- SELECT LEITURA DO SENSOR
select * from Leitores L JOIN Sensor S on L.fkSensor = S.idSensor 
JOIN Blocos B on S.fkBloco = B.idBloco JOIN Empresa E on B.fkEmpresa = E.idEmpresa;

SELECT L.data data_leitura, L.leitura, S.idSensor Sensor, S.data_instalacao, S.data_manutencao, S.status status_sensor, B.numeracao bloco_do_sensor, E.nome_fantasia
FROM Leitores L JOIN Sensor S ON L.fkSensor = S.idSensor JOIN Blocos B ON S.fkBloco = B.idBloco JOIN Empresa E ON B.fkEmpresa = E.idEmpresa
-- where S.idSensor = 1;
;

-- SELECT DO USUARIO
select * from Usuario U JOIN Empresa E on U.fkEmpresa = E.idEmpresa;

-- SELECT DAS FILIAIS (trocar o status de tabela)
select cep, logradouro, numero, bairro, cidade, uf, idEmpresa, nome_fantasia, status from Endereco En JOIN Empresa E on En.fkEmpresa = E.idEmpresa;
alter table Endereco rename column estado to uf;

-- SELECT DOS SENSORES
select S.idSensor, S.data_manutencao, S.status, S.fkBloco, B.numeracao, B.fkEmpresa, E.nome_fantasia, E.status 
from Sensor S JOIN Blocos B on S.fkBloco = B.idBloco JOIN Empresa E on B.fkEmpresa = E.idEmpresa;

-- SELECT DO REPRESENTANTE
select * from Cliente C JOIN Empresa E on C.fkEmpresa = E.idEmpresa;

-- será que deveriamos ligar o representante com o endereço, assim como a coluna status
-- Também ligar o Bloco com o endereco e não diretamente com a empresa
