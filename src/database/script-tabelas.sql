
drop database if exists FMS;

CREATE DATABASE IF NOT EXISTS FMS;
USE FMS;



CREATE TABLE Restaurante (
    idRestaurante INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    nome_fantasia VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    status VARCHAR(9) NOT NULL DEFAULT 'Pendente',
    quantmesa INT NOT NULL,
    CONSTRAINT chk_status_restaurante
    CHECK (status IN ('Aprovado', 'Pendente'))
);
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(100)  NULL,
    bairro VARCHAR(100)  NULL,
    cidade VARCHAR(50)  NULL,
    uf CHAR(2)  NULL,
    complemento VARCHAR(45) NOT NULL,
    fkRestaurante INT,
    CONSTRAINT fk_restaurante_endereco
    FOREIGN KEY (fkRestaurante)
    REFERENCES Restaurante(idRestaurante)
);
CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(40) NOT NULL,
    cargo VARCHAR(13) NOT NULL,
    fkRestaurante INT NOT NULL,
    fkUsuario INT,
    CONSTRAINT chk_cargo CHECK (cargo IN ('superAdmin','Administrador', 'Operador')),
    CONSTRAINT fk_restaurante_usuario FOREIGN KEY (fkRestaurante) REFERENCES Restaurante(idRestaurante),
    CONSTRAINT fk_usuario FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Bloco (
    fkRestaurante INT,
    bloco CHAR(3),
    PRIMARY KEY (fkRestaurante, bloco),
    CONSTRAINT fk_restaurante_bloco FOREIGN KEY (fkRestaurante) REFERENCES Restaurante(idRestaurante)
);



CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATE,
    data_manutencao DATE,
    status VARCHAR(7) NOT NULL,
    fkRestaurante INT NOT NULL,
    fkBloco CHAR(3) NOT NULL,
    CONSTRAINT chk_status_sensor CHECK (status IN ('Ativo', 'Inativo')),
    CONSTRAINT fk_sensor_bloco FOREIGN KEY (fkRestaurante, fkBloco) REFERENCES Bloco(fkRestaurante, bloco)
);
CREATE TABLE Registro (
    idRegistro INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME DEFAULT CURRENT_TIMESTAMP,
    leitura TINYINT,
    fkSensor INT,
    tipo_leitura VARCHAR(7),
    CONSTRAINT fk_sensor_registro FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
    CONSTRAINT chk_tipo_registro
    CHECK (tipo_leitura IN ('Mapa', 'Entrada', 'Saída'))
);



-- -----------------------------------------------------------------------------------------------------------
-- ------------------------------------------ INSERT ---------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------




-------------------------------------------- INSERT RESTAURANTE--------------------
desc Restaurante;


INSERT INTO Restaurante VALUES
(default, 'Pizzaria Di Napoli Alimentos Ltda.','Bella Napoli','11222333000111','Aprovado',40),
(default, 'Massa & Forno Gastronomia Eireli','Santo Pedaço','44555666000144','Pendente',50),
(default,  'Comércio de Massas Artesanais Lupa Ltda.', 'Luppa Pizza Bar','77888999000177', 'Aprovado', 30),
(default,  'Rede de Pizzarias Redonda de Ouro S.A.', 'Disco de Ouro','10203040000110', 'Aprovado',30), 
(default,  'Mamma Mia Serviços de Alimentação Me.', 'Forno da Mamma','55444333000155', 'Pendente',20);



-------------------------------------------- INSERT ENDERECO ------------
desc Endereco;
select * from Endereco;
INSERT INTO Endereco VALUES
(default, '01310200', 'Avenida Paulista',  'Bela Vista', 'São Paulo', 'SP', 'Bloco 2A', 1),
(default, '20040002', 'Avenida Rio Branco', 'Centro', 'Rio de Janeiro','RJ', '', 2),
(default, '70150900', 'Praça dos Três Poderes',  'Zona Cívico - Administrativa', 'Brasília', 'DF', '', 3),
(default, '30140061', 'Rua da Bahia', 'Lourdes', 'Belo Horizonte', 'MG', 'Bloco 6D',4),
(default, '80020100', 'Praça Tiradentes','Centro', 'Curitiba', 'PR', '',5);
select * from Endereco;



----------------------------------------- INSERT ADMINISTRADORES  --------------
desc Usuario;

INSERT INTO Usuario VALUES
(default, 'Ricardo Cavalcante', 'ricardo.admin@pizzaria.com', 'R3c@rd0_99', 'Administrador', 1, NULL),
(default, 'Fernanda Montes', 'fernanda.adm@pizzaria.com','F3rn@nd4_#1', 'Administrador', 2, NULL);

-------------------------------------- Super ADMINISTRADORES  --------------
INSERT INTO Usuario VALUES
(default, 'Raissa', 'raissamlima4536@gmail.com', 'R3c@rd0_99', 'superAdmin', 1, NULL);



-------------------------------------- insert operadores-------------------


INSERT INTO Usuario
 VALUES (default, 'Mariana Souza', 'mariana.oper@pizzaria.com','Mari#S2026','Operador',1,1),
(default, 'Lucas Gabriel Santos','lucas.oper@pizzaria.com','Lks_8871ab','Operador',1,1);


----------------------------------- INSERT BLOCO-------------------


INSERT INTO Bloco VALUES
(1, '01'),
(1, '02'),
(1, '03'),
(1, '04'),
(1, '05'),
(1, '06'),
(1, '07'),
(1, '08'),
(1, '09'),
(1, '10'),
(1, '11'),
(1, '12'),
(1, '13'),
(1, '14'),
(1, '15'),
(1, '16'),
(1, '17'),
(1, '18'),
(1, '19'),
(1, '20'),
(1, '21'),
(1, '22'),
(1, '23'),
(1, '24'),
(1, '25'),
(1, '26'),
(1, '27'),
(1, '28'),
(1, '29'),
(1, '30'),
(1, '31'),
(1, '32'),
(1, '33'),
(1, '34'),
(1, '35'),
(1, '36'),
(1, '37'),
(1, '38'),
(1, '39'),
(1, '40'),
(1, '41'),
(1, '42'),
(1, '43'),
(1, '44'),
(1, '45'),
(1, '46'),
(1, '47'),
(1, '48'),
(1, '49'),
(1, '50'),
(1, '51'),
(1, '52'),
(1, '53'),
(1, '54'),
(1, '55'),
(1, '56'),
(1, '57'),
(1, '58'),
(1, '59'),
(1, '60'),
(1, '61'),
(1, '62'),
(1, '63'),
(1, '64'),
(1, '65'),
(1, '66'),
(1, '67'),
(1, '68'),
(1, '69'),
(1, '70'),
(1, '71'),
(1, '72'),
(1, '73'),
(1, '74'),
(1, '75'),
(1, '76'),
(1, '77'),
(1, '78'),
(1, '79'),
(1, '80'),
(1, '81'),
(1, '82'),
(1, '83'),
(1, '84'),
(1, '85'),
(1, '86'),
(1, '87'),
(1, '88'),
(1, '89'),
(1, '90'),
(1, '91'),
(1, '92'),
(1, '93'),
(1, '94'),
(1, '95'),
(1, '96'),
(1, '97'),
(1, '98'),
(1, '99'),
(1, '100'),
(1, '101'),
(1, '102'),
(1, '103'),
(1, '104'),
(1, '105'),
(1, '106'),
(1, '107'),
(1, '108'),
(1, '109'),
(1, '110'),
(1, '111'),
(1, '112'),
(1, '113'),
(1, '114'),
(1, '115'),
(1, '116'),
(1, '117'),
(1, '118'),
(1, '119'),
(1, '120'),
(1, '121'),
(1, '122'),
(1, '123'),
(1, '124'),
(1, '125'),
(1, '126'),
(1, '127'),
(1, '128'),
(1, '129'),
(1, '130'),
(1, '131'),
(1, '132'),
(1, '133'),
(1, '134'),
(1, '135'),
(1, '136'),
(1, '137'),
(1, '138'),
(1, '139'),
(1, '140'),
(1, '141'),
(1, '142'),
(1, '143'),
(1, '144'),


(2, '01'),
(2, '02'),
(2, '03'),

(3, '01'),
(3, '02'),
(3, '03'),

(4, '01'),
(4, '02'),
(4, '03'),

(5, '01'),
(5, '02'),
(5, '03');


-------------------------------------------- INSERT SENSOR-------------------
desc Sensor;
INSERT INTO Sensor (idSensor, data_instalacao, data_manutencao, status, fkRestaurante, fkBloco) VALUES
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '01'),
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '02'),
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '03'),
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '04'),
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '05'),
(default, '2022-11-28', '2025-01-21', 'Ativo', 1, '06'),
(default, '2022-11-28', '2023-11-01', 'Ativo', 1, '07'),
(default, '2022-11-28', '2024-05-12', 'Ativo', 1, '08'),
(default, '2023-01-10', '2025-07-04', 'Ativo', 1, '09'),
(default, '2023-01-10', '2025-10-14', 'Ativo', 1, '10'),
(default, '2020-07-22', '2024-10-17', 'Ativo', 1, '11'),
(default, '2020-07-22', '2024-08-17', 'Ativo', 1, '12'),
(default, '2020-07-22', '2024-08-25', 'Ativo', 1, '13'),
(default, '2024-02-05', '2024-05-30', 'Ativo', 1, '14'),
(default, '2024-02-05', '2024-03-30', 'Ativo', 1, '15'),
(default, '2024-02-05', '2025-09-20', 'Ativo', 1, '16'),
(default, '2019-05-12', '2023-11-20', 'Ativo', 1, '17'),
(default, '2019-05-12', '2023-11-01', 'Ativo', 1, '18'),
(default, '2019-10-30', '2023-07-14', 'Ativo', 1, '19'),
(default, '2019-10-30', '2023-07-14', 'Ativo', 1, '20'),
(default, '2020-01-15', '2023-03-09', 'Ativo', 1, '21'),
(default, '2020-01-15', '2023-03-09', 'Ativo', 1, '22'),
(default, '2020-08-04', '2025-12-25', 'Ativo', 1, '23'),
(default, '2020-08-04', '2022-12-25', 'Ativo', 1, '24'),
(default, '2020-08-04', '2024-12-25', 'Ativo', 1, '25'),
(default, '2021-04-22', '2024-01-05', 'Ativo', 1, '26'),
(default, '2021-09-11', '2022-02-18', 'Ativo', 1, '27'),
(default, '2021-09-11', '2021-11-18', 'Ativo', 1, '28'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '29'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '30'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '31'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '32'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '33'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '34'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '35'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '36'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '37'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '38'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '39'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '40'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '41'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '42'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '43'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '44'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '45'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '46'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '47'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '48'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '49'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '50'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '51'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '52'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '53'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '54'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '55'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '56'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '57'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '58'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '59'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '60'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '61'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '62'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '63'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '64'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '65'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '66'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '67'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '68'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '69'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '70'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '71'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '72'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '73'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '74'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '75'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '76'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '77'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '78'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '79'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '80'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '81'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '82'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '83'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '84'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '85'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '86'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '87'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '88'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '89'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '90'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '91'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '92'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '93'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '94'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '95'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '96'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '97'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '98'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '99'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '100'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '101'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '102'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '103'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '104'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '105'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '106'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '107'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '108'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '109'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '110'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '111'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '112'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '113'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '114'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '115'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '116'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '117'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '118'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '119'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '120'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '121'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '122'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '123'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '124'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '125'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '126'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '127'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '128'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '129'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '130'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '131'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '132'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '133'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '134'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '135'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '136'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '137'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '138'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '139'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '140'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '141'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '142'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '143'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 1, '144')
;



----------------------------------- insert Registro --------------------

select * from Registro;
INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura) VALUES

('2026-05-21 11:15:00', 1, 1, 'Entrada'),
('2026-05-21 12:30:00', 1, 2, 'Entrada'),

('2026-05-22 10:20:00', 1, 1, 'Entrada'),
('2026-05-22 13:45:00', 1, 2, 'Entrada'),

('2026-05-23 09:05:00', 1, 1, 'Entrada'),
('2026-05-23 12:40:00', 1, 2, 'Entrada'),

('2026-05-24 11:50:00', 1, 1, 'Entrada'),
('2026-05-24 14:15:00', 1, 2, 'Entrada'),

('2026-05-25 10:00:00', 1, 1, 'Entrada'),
('2026-05-25 12:10:00', 1, 2, 'Entrada'),

('2026-05-26 09:30:00', 1, 1, 'Entrada'),
('2026-05-26 13:00:00', 1, 2, 'Entrada'),

('2026-05-27 10:45:00', 1, 1, 'Entrada'),
('2026-05-27 12:35:00', 1, 2, 'Entrada')
;


-- ATUAL
select * from Registro r JOIN Sensor s on s.idSensor = r.fkSensor where fkRestaurante = 1;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura) VALUES
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada'),
(default, 1, 1, 'Entrada'),
(default, 1, 2, 'Entrada')
;


desc Registro;

-- ---------------------- populando registros de uma semana de forma automatizada

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 604800) SECOND,
    FLOOR(RAND() * 2),
    (idSensor),
    'Entrada'
FROM Sensor,
	(SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
    SELECT 10) as repeticoes
WHERE fkRestaurante = 1 AND fkBloco < 03;


INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 604800) SECOND,
    FLOOR(RAND() * 2),
    (idSensor),
    'Entrada'
FROM Sensor,
	(SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
    SELECT 10) as repeticoes
WHERE fkRestaurante = 1 AND fkBloco < 03;


INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 604800) SECOND,
    FLOOR(RAND() * 2),
    (idSensor),
    'Entrada'
FROM Sensor,
	(SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
    SELECT 10) as repeticoes
WHERE fkRestaurante = 1 AND fkBloco < 03;


INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 604800) SECOND,
    FLOOR(RAND() * 2),
    (idSensor),
    'Entrada'
FROM Sensor,
	(SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
    SELECT 10) as repeticoes
WHERE fkRestaurante = 1 AND fkBloco < 03;





----------------- Populando registros atuais de forma automatizada------------------------

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor,
	(SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6) as repeticoes
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
SELECT
    NOW(),
    FLOOR(RAND() * 2),
    (idSensor),
    'Mapa'
FROM Sensor
WHERE fkRestaurante = 1 AND fkBloco > 02;




----------------------------- SELECTS ---------------------------------------

-- pegando todos os admins

SELECT f.nome, f.cargo, c.nome, c.cargo, r.nome_fantasia
FROM Usuario f Left join  Usuario c ON f.fkUsuario = c.idUsuario
JOIN Restaurante r ON f.fkRestaurante = r.idRestaurante
ORDER BY f.cargo;


SELECT * FROM sensor order by fkBloco;
SELECT idSensor from Sensor;


------- funcionarios ---------------
SELECT f.nome AS Funcionario, f.cargo, c.nome AS Superior, c.cargo, r.nome_fantasia
FROM Usuario f 
LEFT JOIN Usuario c ON f.fkUsuario = c.idUsuario
JOIN Restaurante r ON f.fkRestaurante = r.idRestaurante
ORDER BY f.cargo;

 
-- SELECT LEITURA DO SENSOR
select * from registro;

SELECT *
FROM Registro r JOIN Sensor s ON r.fkSensor = s.idSensor
JOIN Bloco b ON s.fkRestaurante = b.fkRestaurante AND s.fkBloco = b.bloco
JOIN Restaurante res ON b.fkRestaurante = res.idRestaurante;

-- SELECT DO USUARIO
SELECT *
FROM Usuario u
JOIN Restaurante r ON u.fkRestaurante = r.idRestaurante;


-- SELECT DOS SENSORES
SELECT s.idSensor,s.data_manutencao,s.status,s.fkBloco,b.bloco,b.fkRestaurante,r.nome_fantasia,r.status
FROM Sensor s JOIN Bloco b ON s.fkRestaurante = b.fkRestaurante
AND s.fkBloco = b.bloco JOIN Restaurante r ON b.fkRestaurante = r.idRestaurante;





-- views da dashboard(kpis)

-- rotação das mesas 


select*from Sensor;
CREATE VIEW vw_rotacao_mesa	 AS 
SELECT 
   r.idRestaurante,
   r.nome_fantasia,
   r.quantmesa,
     COUNT(reg.idRegistro) AS totalCliente_hoje,
     ROUND(COUNT(reg.idRegistro)/r.quantmesa,2) AS rotacao_mesa
     FROM Restaurante r
     JOIN Sensor s on r.idRestaurante=s.fkRestaurante
     JOIN Registro reg
      on s.idSensor=reg.fkSensor
	WHERE reg.tipo_leitura = 'Entrada'
	AND DATE(reg.data) = CURDATE()

	GROUP BY
		r.idRestaurante,
		r.nome_fantasia,
		r.quantmesa;
        
        SELECT*FROM vw_rotacao_mesa	;
        
/*      
	INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura)
VALUES
(NOW(), 1, 1, 'Entrada'),
(NOW(), 1, 2, 'Entrada'),
(NOW(), 1, 3, 'Entrada'),
(NOW(), 1, 1, 'Entrada'),
(NOW(), 1, 2, 'Entrada'),
(NOW(), 1, 3, 'Entrada');
*/        
	-- kpi atual/ideal
    
    CREATE VIEW vw_fluxo_7dias AS
SELECT
    r.idRestaurante,
    r.nome_fantasia,

   

    COUNT(reg.idRegistro) AS fluxo_atual_7dias,
    
    ROUND(r.quantmesa *2 *3.5*7,0)  AS fluxo_ideal_7dias

FROM Restaurante r


JOIN Sensor s
    ON r.idRestaurante = s.fkRestaurante

JOIN Registro reg
    ON s.idSensor = reg.fkSensor

WHERE reg.tipo_leitura = 'Entrada'
AND reg.data >= NOW() - INTERVAL 7 DAY

GROUP BY
    r.idRestaurante,
    r.nome_fantasia;
   
    
    SELECT * FROM vw_fluxo_7dias;
    

	-- percentual de ocupação do restaurante 
    
    
    CREATE VIEW vw_ocupacao_restaurante AS
SELECT
    r.idRestaurante,
    r.nome_fantasia,
    
     ROUND(r.quantmesa *3.5 ,0)  AS capacidade_maxima,
  
   
    SUM(
        CASE
            WHEN reg.tipo_leitura = 'Entrada' THEN 1
            WHEN reg.tipo_leitura = 'Saída' THEN -1
            ELSE 0
        END
    ) AS pessoas_no_restaurante,

    ROUND(
        (
            SUM(
                CASE
                    WHEN reg.tipo_leitura = 'Entrada' THEN 1
                    WHEN reg.tipo_leitura = 'Saída' THEN -1
                    ELSE 0
                END
            ) /  (r.quantmesa * 3.5)
        ) * 100,
        2
    ) AS percentual_ocupacao

FROM Restaurante r

JOIN Sensor s
    ON r.idRestaurante = s.fkRestaurante

JOIN Registro reg
    ON s.idSensor = reg.fkSensor
    
    WHERE reg.data>= NOW() -INTERVAL 24 HOUR

GROUP BY
    r.idRestaurante,
    r.nome_fantasia,
    r.quantMesa;
    
    
    SELECT *FROM vw_ocupacao_restaurante;
    
 

-- view do heatmap 


CREATE or REPLACE VIEW vw_heatmap_blocos AS
SELECT 
    s.fkRestaurante AS idRestaurante,
    s.fkBloco AS bloco,
    SUM(r.leitura) AS total_movimentacoes
FROM Sensor s
JOIN Registro r 
    ON r.fkSensor = s.idSensor
WHERE r.tipo_leitura = 'Mapa' AND data >= current_date
GROUP BY
    s.fkRestaurante,
    s.fkBloco;
    
SELECT * FROM Registro where fkSensor = 1;

    
select * from vw_heatmap_blocos;

-- view de quantidade clientes nos ultimos 7 dias 


CREATE VIEW vw_clientes_7dias AS
SELECT
    r.idRestaurante,
    r.nome_fantasia,
    DATE(reg.data) as data_dia,

     DAYOFWEEK(reg.data) as dia_na_semana_num,
     (COUNT(reg.idRegistro) * 2) as total_movimentacao
        FROM Restaurante r 
        JOIN Sensor s ON r.idRestaurante = s.fkRestaurante
		JOIN Registro reg ON s.idSensor = reg.fkSensor
		WHERE reg.tipo_leitura = 'Entrada'
		AND reg.data >= CURDATE() - INTERVAL 7 DAY
		AND reg.data <  CURDATE()
		GROUP BY 
        r.idRestaurante, 
        r.nome_fantasia, 
        DATE(reg.data), 
        DAYOFWEEK(reg.data);
       
  select *from vw_clientes_7dias;
  
 

-- usuarios vm
CREATE USER IF NOT EXISTS 'usuario_insert'@'localhost' IDENTIFIED BY 'Rml_1505';
CREATE USER IF NOT EXISTS 'usuario_select'@'localhost' IDENTIFIED BY 'Yag_2102';

select * from usuario;


select * from vw_clientes_7dias WHERE idRestaurante = 1 order by dia_na_semana_num ASC;

-- ----------------------------------------

SELECT * FROM Usuario;

SELECT * FROM Usuario u JOIN Restaurante r on r.idRestaurante = u.fkRestaurante;

SELECT * FROM Bloco b JOIN Restaurante r on r.idRestaurante = b.fkRestaurante;

SELECT * FROM Sensor;

SELECT * FROM Restaurante;



SELECT * FROM Bloco;

desc Sensor;





SELECT * FROM Registro r JOIN Sensor s on s.idSensor = r.fkSensor;
/*
INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura) VALUES

(default, 1, 1, 'Mapa'),
(default, 1, , 'Mapa'),
;*/
desc Registro;
SELECT * FROM Sensor;
SELECT * FROM Registro;