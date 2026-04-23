CREATE DATABASE FMS;

use FMS;

CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8) not null,
    logradouro VARCHAR(100) not null,
    numero VARCHAR(10),
    bairro VARCHAR(100) not null,
    cidade varchar(100) not null,
    uf char(2) not null,
    complemento varchar(100)
    );
CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14) not null,
    razao_social VARCHAR(100) not null,
    nome_fantasia VARCHAR(100) not null, 
    status VARCHAR(7) not null,
    fkEmpresa int,
    fkEndereco int not null,
    quantmesa int null,
    constraint fk_empresa foreign key (fkEmpresa) references Empresa(idEmpresa),
    constraint chk_status check (status in('Ativo', 'Inativo')),
    constraint fk_endereco foreign key (fkEndereco) references Endereco(idEndereco)
);

CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) not null,
    email VARCHAR(100) not null,
    senha VARCHAR(255) not null, 
    cargo VARCHAR(13) not null,
    fkEmpresa INT not null,
    fkUsuario INT, 
    constraint chk_cargo check (cargo in ('Administrador', 'Operador')),
    constraint fk_empresa_usuario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    constraint fk_usuario FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);





CREATE TABLE EmpresaTelefone (
    idEmpresaTelefone int primary key auto_increment,
    fkEmpresa INT not null,
    numero varchar(17) not null,
    tipoTelefone varchar(16) not null,
    constraint chk_tipo_telefone check (tipoTelefone in ('Telefone Voip', 'Telefone Fixo', 'Telefone Celular')),
    constraint fk_empresa_empresatelefone FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
); 


CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) not null,
    email VARCHAR(100) not null,
    cpf CHAR(11) not null unique,
    fkEmpresa INT not null,
    constraint fk_empresa_cliente FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
); 


CREATE TABLE Blocos (
    fkEmpresa int,
    bloco CHAR(2),
    constraint pk_blocos primary key (fkEmpresa, bloco),
    constraint fk_empresa_blocos FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATE,
    data_manutencao DATE,
    status VARCHAR(7) not null,
    fkEmpresa int not null,
    fkBloco CHAR(2) not null,
    constraint fk_empresa_bloco_sensor foreign key (fkEmpresa, fkBloco) references Blocos(fkEmpresa, bloco),
    constraint chk_status_sensor check (status in ('Inativo', 'Ativo'))
); 


CREATE TABLE Registros ( 
    idRegistro INT AUTO_INCREMENT PRIMARY KEY,
    data datetime default (current_timestamp()),
    leitura tinyint,
    fkSensor INT,
    tipo_leitura VARCHAR(7),
    constraint fk_sensor_registros FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
    constraint chk_tipo_registros check(tipo_leitura in ('Mapa', 'Entrada', 'Saída'))
); 


----------------------- INSERT ENDERECO ------------
desc Endereco;
select * from Endereco;
INSERT INTO Endereco VALUES
(default, '01310200', 'Avenida Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', 'Bloco 2A'),
(default, '20040002', 'Avenida Rio Branco', '45', 'Centro', 'Rio de Janeiro','RJ', ''),
(default, '70150900', 'Praça dos Três Poderes', 'SN', 'Zona Cívico - Administrativa', 'Brasília', 'DF', ''),
(default, '30140061', 'Rua da Bahia', '1022', 'Lourdes', 'Belo Horizonte', 'MG', 'Bloco 6D'),
(default, '80020100', 'Praça Tiradentes', '290', 'Centro', 'Curitiba', 'PR', ''),
(default, '40020000', 'Praça Visconde de Cayru', '250', 'Comércio', 'Salvador', 'BA', 'Bloco 4C'),
(default, '60060390', 'Rua dos Tabajaras', '410', 'Praia de Iracema', 'Fortaleza', 'CE', ''),
(default, '90010001', 'Avenida Mauá', '1050', 'Centro Histórico', 'Porto Alegre', 'RS', ''),
(default, '04101000', 'Rua das Orquídeas', '520', 'Vila Mariana', 'São Paulo', 'SP', ''),
(default, '30112020', 'Avenida Getúlio Vargas', '1150', 'Savassi', 'Belo Horizonte', 'MG', ''),
(default, '80230010', 'Alameda dos Anjos', '45', 'Rebouças', 'Curitiba', 'PR', ''),
(default, '20040030', 'Rua do Ouvidor', '89', 'Centro', 'Rio de Janeiro', 'RJ', ''),
(default, '60160230', 'Avenida Dom Luís', '1200', 'Aldeota', 'Fortaleza', 'CE', ''),
(default, '90010001', 'Rua da Praia,', '330', 'Centro Historico', 'Porto Alegre', 'RS', ''),
(default, '41820020', 'Avenida Tancredo Neves', '2450', 'Caminho das Árvores', 'Salvador', 'BA', '');
select * from Endereco;


-------------------- INSERT EMPRESA MATRIZ --------------------
desc Empresa;

insert into Empresa values
(default,'11222333000111' , 'Pizzaria Di Napoli Alimentos Ltda.', 'Bella Napoli', 'Ativo', null, 1, null),
(default, '44555666000144', 'Massa & Forno Gastronomia Eireli', 'Santo Pedaço', 'Inativo', null, 2, null),
(default, '77888999000177', 'Comércio de Massas Artesanais Lupa Ltda.', 'Luppa Pizza Bar', 'Ativo', null, 3, null),
(default, '10203040000110', 'Rede de Pizzarias Redonda de Ouro S.A.', 'Disco de Ouro', 'Ativo', null, 4, null),
(default, '55444333000155', 'Mamma Mia Serviços de Alimentação Me.', 'Forno da Mamma', 'Inativo', null, 5, null);

-------------------- INSERT EMPRESA FILIAIS -----------------
-- nome fantasia é o mesmo, razão social possui diferenca no complemento

INSERT INTO Empresa values
(default, '11222333000222', 'Pizzaria Di Napoli Alimentos Ltda - Comércio', 'Bella Napoli', 'Ativo', 1, 6,12),
(default, '11222333000333', 'Pizzaria Di Napoli Alimentos Ltda - Centro Histórico', 'Bella Napoli', 'Inativo', 1, 8,14),
(default, '44555666000255', 'Massa & Forno Gastronomia Eireli - Praia de Iracema', 'Santo Pedaço', 'Ativo', 2, 7,16),
(default, '44555666000366', 'Massa & Forno Gastronomia Eireli - ', 'Santo Pedaço', 'Inativo', 2, 9,20),
(default, '77888999000288', 'Comércio de Massas Artesanais Lupa Ltda - Savassi', 'Luppa Pizza Bar', 'Ativo', 3, 10,15),
(default, '77888999000399', 'Comércio de Massas Artesanais Lupa Ltda - Caminho das Árvores', 'Luppa Pizza Bar', 'Inativo', 3, 15,18),
(default, '10203040000220', 'Rede de Pizzarias Redonda de Ouro S.A - Centro', 'Disco de Ouro', 'Ativo', 4, 12,11),
(default, '10203040000330', 'Rede de Pizzarias Redonda de Ouro S.A - Centro Histórico', 'Disco de Ouro', 'Inativo', 4, 14,8),
(default, '55444333000266', 'Mamma Mia Serviços de Alimentação Me - Aldeota', 'Forno de Mamma', 'Ativo', 5, 13,14),
(default, '55444333000377', 'Mamma Mia Serviços de Alimentação Me - Rebouças', 'Forno de Mamma', 'Inativo', 5, 11,15);
----------------- INSERT USUARIO CHEFE --------------
desc Usuario;

INSERT INTO Usuario VALUES
(default, 'Ricardo Cavalcante', 'ricardo.admin@pizzaria.com', 'R3c@rd0_99', 'Administrador', 1, null),
(default, 'Fernanda Montes', 'fernanda.adm@pizzaria.com', 'F3rn@nd4_#1', 'Administrador', 2, null),
(default, 'Gustavo Henrique', 'gustavo.adm@pizzaria.com', 'Gus_Admin!26', 'Administrador', 3, null),
(default, 'Camila Arantes', 'camila.adm@pizzaria.com', 'Cami_99Ar#', 'Administrador', 4, null),
(default, 'Roberto Silveira', 'roberto.adm@pizzaria.com', 'Rob_Silva@88', 'Administrador', 5, null),
(default, 'Rodrigo Sanches', 'rodrigo.s.adm@pizzaria.com', 'nadoi120(JU)1', 'Administrador', 6, null),
(default, 'Isabela Nogueira', 'isabela.no.adm@pizzaria.com', 'ASNDO!@*W@!', 'Administrador', 7, null),
(default, 'Camila Vergueiro', 'camila.ve.adm@pizzaria.com', 'ASDO!@GN*', 'Administrador', 8, null),
(default, 'Marcelo Tostes', 'marcelo.to.adm@pizzaria.com', 'VNAOUD*&', 'Administrador', 9, null),
(default, 'Fernanda Linhares', 'fernanda.li.adm@pizzaria.com', ')@(*&DA', 'Administrador', 10, null),
(default, 'Renato Meirelles', 'renato.mei.adm@pizzaria.com', 'CNASOU*&&', 'Administrador', 11, null),
(default, 'Larissa Dornelles', 'larissa.dor.adm@pizzaria.com', 'NVOAS*&¨&', 'Administrador', 12, null),
(default, 'André Valadares', 'andre.val.adm@pizzaria.com', ')@#*HQIFC', 'Administrador', 13, null),
(default, 'Patrícia Rezende', 'patricia.rez.adm@pizzaria.com', '@&*(E&*$DJF', 'Administrador', 14, null),
(default, 'Vinícius Macedo', 'vinicius.mac.adm@pizzaria.com', 'mnfoAI(*@', 'Administrador', 15, null);

-------------- INSERT USUARIO OPERADOR ---------------
desc Usuario;
insert into Usuario values
(default, 'Mariana Souza', 'mariana.oper@pizzaria.com', 'Mari#S2026', 'Operador', 1, 1),
(default, 'Lucas Gabriel Santos', 'lucas.oper@pizzaria.com', 'Lks_8871ab', 'Operador', 1, 1),
(default, 'Beatriz Helena Rocha', 'beatriz.oper@pizzaria.com', 'B_Rocha!92', 'Operador', 2, 2),
(default, 'Tiago Oliveira Lima', 'tiago.oper@pizzaria.com', 'tig_Oliveira7', 'Operador', 2, 2),
(default, 'Juliana Paes', 'juliana.oper@pizzaria.com', 'Ju_Oper2026!', 'Operador', 3, 3),
(default, 'Aline Ferreira', 'aline.oper@pizzaria.com', 'Ali_Ferr@10', 'Operador', 3, 3),
(default, 'Igor Martins', 'igor.oper@pizzaria.com', 'Igor_M#2026', 'Operador', 4, 4),
(default, 'André Felipe', 'andre.oper@pizzaria.com', 'And_F3lip3', 'Operador', 4, 4),
(default, 'Vanessa Costa', 'vanessa.oper@pizzaria.com', 'Van_Cost@81', 'Operador', 5, 5),
(default, 'Gabriel Junqueira', 'gabriel.oper@pizzaria.com', 'Gabs_Junk77', 'Operador', 5, 5),
(default, 'Sabrina Mendes', 'sabrina.oper@pizzaria.com', 'Sab_Mend3s@1', 'Operador', 6, 6),
(default, 'Patricia Lima', 'patricia.oper@pizzaria.com', 'Pat_Lima$22', 'Operador', 6, 6),
(default, 'Douglas Souza', 'douglas.oper@pizzaria.com', 'Doug_Sz!44', 'Operador', 7, 7),
(default, 'Leticia Fontes', 'leticia.oper@pizzaria.com', 'Let_F0nt3s#', 'Operador', 7, 7),
(default, 'Sergio Murilo', 'sergio.oper@pizzaria.com', 'Serg_Muri#9', 'Operador', 8, 8),
(default, 'Renata Borges', 'renata.oper@pizzaria.com', 'Ren@ta_B0rg', 'Operador', 8, 8),
(default, 'Marcos Vinicius Prado', 'marcos.oper@pizzaria.com', 'Mrc_Prado!15', 'Operador', 9, 9),
(default, 'Juliana Medeiros', 'juliana.me.oper@pizzaria.com', '(*DAI', 'Operador', 9, 9),
(default, 'Caio Vasconcelos', 'caio.vas.oper@pizzaria.com', 'ANSDO&¨(', 'Operador', 10, 10),
(default, 'Flávia Siqueira', 'flavia.si.oper@pizzaria.com', 'NAVK%&', 'Operador', 10, 10),
(default, 'Otávio Mesquita', 'otavio.mes.oper@pizzaria.com', '¨NASDO$¨%', 'Operador', 11, 11),
(default, 'Bianca Louzada', 'bianca.lou.oper@pizzaria.com', 'LVAUH(*&', 'Operador', 11, 11),
(default, 'Rafael Peixoto', 'rafael.pei.oper@pizzaria.com', '@&*(VCAIU', 'Operador', 12, 12),
(default, 'Sabrina Viana', 'sabrina.via.oper@pizzaria.com', ')(*&GASUCFT', 'Operador', 12, 12),
(default, 'Leandro Castelo', 'leandro.cast.oper@pizzaria.com', 'FNURas$!', 'Operador', 13, 13),
(default, 'Priscila Amaral', 'priscila.ama.oper@pizzaria.com', 'pa( va¨(@!', 'Operador', 13, 13),
(default, 'Douglas Fontoura', 'douglas.fon.oper@pizzaria.com', '@@oihdqw(8', 'Operador', 14, 14),
(default, 'Tatiane Galvão', 'tatiane.galv.oper@pizzaria.com', 'cmpvoais&!@', 'Operador', 14, 14),
(default, 'Hugo Diniz', 'hugo.diniz.oper@pizzaria.com', 'anclo*&(', 'Operador', 15, 15),
(default, 'Mônica Sales', 'monica.sales.oper@pizzaria.com', '(¨@!VPIvao', 'Operador', 15, 15);
select * from Usuario;
select f.nome, f.cargo, c.nome, c.cargo, e.nome_fantasia from Usuario f join Usuario c on f.fkUsuario = c.idUsuario
join Empresa e on f.fkEmpresa = e.idEmpresa order by f.cargo;


-------------- INSERT EMPRESATELEFONE-----------
DESC EmpresaTelefone;

select * from EmpresaTelefone et join Empresa e on et.fkEmpresa = e.idEmpresa join Endereco en on e.fkEndereco = en.idEndereco;
select * from EmpresaTelefone;
INSERT INTO EmpresaTelefone values
(1, 1, 1130559012, 'Telefone Fixo'),
(2, 2, 2125447788, 'Telefone Fixo'),
(3, 3, 6133214455, 'Telefone Fixo'),
(4, 4, 3134215500, 'Telefone Fixo'),
(5, 5, 4132331144, 'Telefone Fixo'),
(6, 6, 1198765432, 'Telefone Fixo'),
(7, 7, 2199122334, 'Telefone Fixo'),
(8, 8, 6198444556, 'Telefone Fixo'),
(9, 9, 3199288405, 'Telefone Fixo'),
(10, 10, 5199555667, 'Telefone Fixo'),
(11, 11, 1140032580, 'Telefone Fixo'),
(12, 12, 3135159900, 'Telefone Fixo'),
(13, 13, 1130559012, 'Telefone Fixo'),
(14, 14, 1130559012, 'Telefone Fixo'),
(15, 15, 1130559012, 'Telefone Fixo'),
(16, 15, 11987651234, 'Telefone Celular'),
(17, 14, 11912345678, 'Telefone Celular'),
(18, 13, 21998874433, 'Telefone Celular'),
(30, 12, 21977665544, 'Telefone Celular'),
(19, 11, 31988223311, 'Telefone Celular'),
(20, 10, 27999001122, 'Telefone Celular'),
(21, 9, 41984005566, 'Telefone Celular'),
(22, 8, 51991112233, 'Telefone Celular'),
(23, 7, 48988447788, 'Telefone Celular'),
(24, 6, 71992223344, 'Telefone Celular'),
(25, 5, 81987776655, 'Telefone Celular'),
(26, 4, 85996660099, 'Telefone Celular'),
(27, 3, 61981110022, 'Telefone Celular'),
(28, 2, 62993334455, 'Telefone Celular'),
(29, 1, 91982221100, 'Telefone Celular');

select * from EmpresaTelefone;

----------------- INSERT CLIENTE ------------------
select * from Empresa;
desc Cliente;
INSERT INTO Cliente values
(default, 'Marcos Menezes', 'marcos.menezes@rep-brasil.com', '12345678900', 1),
(default, 'Bruno Zimmerman', 'bruno.z@sulrepresentacoes.com.br', '56789012344', 2),
(default, 'Amanda Ferreira', 'amanda.ferreira@norte-distrib.com', '01234567899', 3),
(default, 'Felipe Matos', 'felipe.matos@conexaosul.com.br', '78901234566', 4),
(default, 'Rodrigo Amaral', 'rodrigo.amaral@central-vendas.com', '90123456788', 5),
(default, 'Vitor Hugo Peixoto', 'vitor.hugo@rep-brasil.com', '12345678900', 6),
(default, 'Sabrina Esteves', 'sabrina.esteves@sulrepresentacoes.com.br', '56789012344', 7),
(default, 'Leandro Alencar', 'leandro.alencar@norte-distrib.com', '01234567899', 8),
(default, 'Tainá Marcondes', 'taina.marcondes@vendas.com.br', '78901234566', 9),
(default, 'Filipe Holanda', 'filipe.holanda@central-vendas.com', '90123456788', 10),
(default, 'Lorena Caldeira', 'lorena.caldeira@algor.com.br', '78901234566', 11),
(default, 'Murilo Bittencourt', 'murilo.bittencourt@irmaos.com.br', '78901234566', 12),
(default, 'Erika Lins', 'erika.lins@centro.com.br', '78901234566', 13),
(default, 'Samuel Quintela', 'samuel.quintela@conexaosul.com.br', '78901234566', 14),
(default, 'Débora Mansur', 'debora.mansur@brasil.com.br', '78901234566', 15)
;
select * from Cliente;
-------------------- INSERT BLOCOS -------------------
desc Blocos;
select * from Blocos;
INSERT INTO Blocos VALUES
(1, 01),
(1, 02),
(2, 01),
(2, 02),
(3, 01),
(3, 02),
(4, 01),
(4, 02),
(5, 01),
(5, 02),
(6, 01),
(6, 02),
(7, 01),
(7, 02),
(8, 01),
(8, 02),
(9, 01),
(9, 02),
(10, 01),
(10, 02),
(11, 01),
(11, 02),
(12, 01),
(12, 02),
(13, 01),
(13, 02),
(14, 01),
(14, 02),
(15, 01),
(15, 02),
(1, 03),
(1, 04),
(2, 03),
(3, 03),
(4, 03),
(5, 03),
(6, 03),
(7, 03);
Update blocos set numeracao = '1B' where idBloco = 6;
select * from Blocos;
-- INSERT SENSOR
desc Sensor;
INSERT INTO Sensor VALUES
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, 01),
(default, '2022-11-28', '2025-01-21', 'Ativo', 1, 02),
(default, '2022-11-28', '2023-11-01', 'Ativo', 1, 03),
(default, '2022-11-28', '2024-05-12', 'Inativo', 1, 04),
(default, '2023-01-10', '2024-10-02', 'Ativo', 2, 01),
(default, '2023-01-10', '2025-07-04', 'Ativo', 2, 02),
(default, '2023-01-10', '2025-10-14', 'Inativo', 2, 03),
(default, '2020-07-22', '2024-10-17', 'Inativo', 7, 01),
(default, '2020-07-22', '2024-08-17', 'Inativo', 7, 02),
(default, '2020-07-22', '2024-08-25', 'Inativo', 7, 03),
(default, '2024-02-05', '2024-05-30', 'Ativo', 3, 01),
(default, '2024-02-05', '2024-03-30', 'Inativo', 3, 02),
(default, '2024-02-05', '2025-09-20', 'Ativo', 3, 03),
(default, '2019-05-12', '2023-11-20', 'Ativo', 8, 02),
(default, '2019-05-12', '2023-11-01', 'Ativo', 8, 01),
(default, '2019-10-30', '2023-07-14', 'Inativo', 9, 01),
(default, '2019-10-30', '2023-07-14', 'Ativo', 9, 02),
(default, '2020-01-15', '2023-03-09', 'Ativo', 10, 01),
(default, '2020-01-15', '2023-03-09', 'Inativo', 10, 02),
(default, '2020-08-04', '2025-12-25', 'Ativo', 4, 01),
(default, '2020-08-04', '2022-12-25', 'Ativo', 4, 02),
(default, '2020-08-04', '2024-12-25', 'Ativo', 4, 03),
(default, '2021-04-22', '2024-01-05', 'Ativo', 11, 01),
(default, '2021-04-22', '2022-06-05', 'Ativo', 11, 02),
(default, '2021-09-11', '2022-02-18', 'Inativo', 5, 01),
(default, '2021-09-11', '2021-11-18', 'Ativo', 5, 02),
(default, '2021-09-11', '2023-12-18', 'Ativo', 5, 03),
(default, '2019-02-04', '2021-12-30', 'Inativo', 12, 02),
(default, '2019-02-04', '2025-12-30', 'Ativo', 12, 01),
(default, '2024-08-04', '2024-12-25', 'Ativo', 6, 01),
(default, '2024-08-04', '2025-12-25', 'Ativo', 6, 02),
(default, '2024-08-04', '2025-12-25', 'Ativo', 6, 03),
(default, '2022-08-04', '2022-01-09', 'Ativo', 9, 01),
(default, '2022-08-04', '2025-12-25', 'Ativo', 9, 02),
(default, '2023-12-04', '2023-12-25', 'Ativo', 14, 01),
(default, '2023-12-04', '2024-12-25', 'Ativo', 14, 02),
(default, '2021-12-04', '2023-12-25', 'Ativo', 13, 01),
(default, '2021-12-04', '2022-12-25', 'Ativo', 13, 02),
(default, '2025-12-04', '2025-12-05', 'Ativo', 15, 01),
(default, '2025-12-04', '2025-12-15', 'Ativo', 15, 02);


----------------- insert leitor --------------------
select * from Sensor order by fkEmpresa;
----------- Empresa 1
-- sensor 1
insert into Registros values
(null, default, 1, 1, 'Entrada');
insert into Registros values
(null, default, 0, 1, 'Entrada');
-- sensor 2
Insert into Registros values
(null, default, 1, 2, 'Saída');
insert into Registros values
(null, default, 0, 2, 'Saída');
-- sensor 3
insert into Registros values
(null, default, 1, 3, 'Mapa');
insert into Registros values
(null, default, 0, 3, 'Mapa');
-- Sensor 4
insert into Registros values
(null, default, 1, 4, 'Mapa');
insert into Registros values
(null, default, 0, 4, 'Mapa');

-------------- Empresa 2
-- sensor 5
insert into Registros values
(null, default, 1, 5, '');
insert into Registros values
(null, default, 0, 5, '');
-- sensor 6
insert into Registros values
(null, default, 1, 6, '');
insert into Registros values
(null, default, 0, 6, '');
-- sensor 9
insert into Registros values
(null, default, 1, 9, '');
insert into Registros values
(null, default, 0, 9, '');
-- sensor 10
insert into Registros values
(null, default, 1, 10, '');
insert into Registros values
(null, default, 0, 10, '');
desc Registros;


SELECT * FROM sensor order by fkBloco;
SELECT idSensor from Sensor;



----------------------------- SELECTS ---------------------------------------


-- SELECT TELEFONE DA EMPRESA
select numero, tipoTelefone, cnpj, razao_social, nome_fantasia, status from EmpresaTelefone ET join Empresa E on et.fkempresa = e.idEmpresa;
 
-- SELECT LEITURA DO SENSOR
select * from registros;
select * from registros r join Sensor s on r.fkSensor = s.idSensor join Blocos b on s.fkbloco = b.idBloco join Empresa e on b.fkEmpresa = e.idEmpresa;
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

select * from Blocos b join Sensor s on s.fkEmpresa = b.fkEmpresa and s.fkBloco = b.Bloco join Empresa e on s.fkEmpresa = e.idEmpresa;


-- SELECT DO REPRESENTANTE
select * from Cliente C JOIN Empresa E on C.fkEmpresa = E.idEmpresa;

----------------------Criando usuarios ----------------------------
CREATE USER 'usuario_insert'@'localhost' IDENTIFIED BY 'Rml_1505';
CREATE USER 'usuario_select'@'localhost' IDENTIFIED BY 'Yag_2102';

-- usar como root
GRANT INSERT ON FMS.* TO 'usuario_insert'@'localhost';
GRANT SELECT  ON FMS.* TO 'usuario_select'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'usuario_insert'@'localhost';
SHOW GRANTS FOR 'usuario_select'@'localhost';
