CREATE DATABASE IF NOT EXISTS FMS;
USE FMS;


CREATE TABLE Restaurante (
    idRestaurante INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    nome_fantasia VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    status VARCHAR(9) NOT NULL,
    quantmesa INT NOT NULL,
    CONSTRAINT chk_status_restaurante
    CHECK (status IN ('Aprovado', 'Pendente'))
);
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    complemento VARCHAR(45),
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
    CONSTRAINT chk_cargo CHECK (cargo IN ('Administrador', 'Operador')),
    CONSTRAINT fk_restaurante_usuario FOREIGN KEY (fkRestaurante) REFERENCES Restaurante(idRestaurante),
    CONSTRAINT fk_usuario FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Bloco (
    fkRestaurante INT,
    bloco CHAR(2),
    PRIMARY KEY (fkRestaurante, bloco),
    CONSTRAINT fk_restaurante_bloco FOREIGN KEY (fkRestaurante) REFERENCES Restaurante(idRestaurante)
);



CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATE,
    data_manutencao DATE,
    status VARCHAR(7) NOT NULL,
    fkRestaurante INT NOT NULL,
    fkBloco CHAR(2) NOT NULL,
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


----------------------- INSERT ENDERECO ------------
desc Endereco;
select * from Endereco;
INSERT INTO Endereco VALUES

(default, '01310200', 'Avenida Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', 'Bloco 2A', 1),
(default, '20040002', 'Avenida Rio Branco', '45', 'Centro', 'Rio de Janeiro','RJ', '', 2),
(default, '70150900', 'Praça dos Três Poderes', 'SN', 'Zona Cívico - Administrativa', 'Brasília', 'DF', '', 3),
(default, '30140061', 'Rua da Bahia', '1022', 'Lourdes', 'Belo Horizonte', 'MG', 'Bloco 6D',4),
(default, '80020100', 'Praça Tiradentes', '290', 'Centro', 'Curitiba', 'PR', '',5),
(default, '40020000', 'Praça Visconde de Cayru', '250', 'Comércio', 'Salvador', 'BA', 'Bloco 4C',6),
(default, '60060390', 'Rua dos Tabajaras', '410', 'Praia de Iracema', 'Fortaleza', 'CE', '',7),
(default, '90010001', 'Avenida Mauá', '1050', 'Centro Histórico', 'Porto Alegre', 'RS', '',8),
(default, '04101000', 'Rua das Orquídeas', '520', 'Vila Mariana', 'São Paulo', 'SP', '',9),
(default, '30112020', 'Avenida Getúlio Vargas', '1150', 'Savassi', 'Belo Horizonte', 'MG', '',10),
(default, '80230010', 'Alameda dos Anjos', '45', 'Rebouças', 'Curitiba', 'PR', '',11),
(default, '20040030', 'Rua do Ouvidor', '89', 'Centro', 'Rio de Janeiro', 'RJ', '',12),
(default, '60160230', 'Avenida Dom Luís', '1200', 'Aldeota', 'Fortaleza', 'CE', '',13),
(default, '90010001', 'Rua da Praia,', '330', 'Centro Historico', 'Porto Alegre', 'RS', '',14),
(default, '41820020', 'Avenida Tancredo Neves', '2450', 'Caminho das Árvores', 'Salvador', 'BA', '',15);
select * from Endereco;


-------------------- INSERT RESTAURANTE--------------------
desc Restaurante;


INSERT INTO Restaurante VALUES
(default, 'Pizzaria Di Napoli Alimentos Ltda.','Bella Napoli','11222333000111','Aprovado',40),
(default, 'Massa & Forno Gastronomia Eireli','Santo Pedaço','44555666000144','Pendente',50),
(default,  'Comércio de Massas Artesanais Lupa Ltda.', 'Luppa Pizza Bar','77888999000177', 'Aprovado', 30),
(default,  'Rede de Pizzarias Redonda de Ouro S.A.', 'Disco de Ouro','10203040000110', 'Aprovado',100),
(default,  'Mamma Mia Serviços de Alimentação Me.', 'Forno da Mamma','55444333000155', 'Pendente',150);


----------------- INSERT ADMINISTRADORES  --------------
desc Usuario;

INSERT INTO Usuario VALUES
(default, 'Ricardo Cavalcante', 'ricardo.admin@pizzaria.com', 'R3c@rd0_99', 'Administrador', 1, NULL),
(default, 'Fernanda Montes', 'fernanda.adm@pizzaria.com','F3rn@nd4_#1', 'Administrador', 2, NULL);


SELECT f.nome, f.cargo, c.nome, c.cargo, r.nome_fantasia
FROM Usuario f JOIN Usuario c ON f.fkUsuario = c.idUsuario
JOIN Restaurante r ON f.fkRestaurante = r.idRestaurante
ORDER BY f.cargo;

-------------------- INSERT BLOCO-------------------


INSERT INTO Bloco VALUES
(1, '01'),
(1, '02'),
(2, '01'),
(2, '02');


-------------------- INSERT SENSROR-------------------
desc Sensor;
INSERT INTO Sensor VALUES
(default, '2021-03-15', '2025-04-08', 'Ativo', 1, '01'),
(default, '2022-11-28', '2025-01-21', 'Ativo', 1, '02'),
(default, '2022-11-28', '2023-11-01', 'Ativo', 1, '03'),
(default, '2022-11-28', '2024-05-12', 'Inativo', 1, '04'),
(default, '2023-01-10', '2024-10-02', 'Ativo', 2, '01'),
(default, '2023-01-10', '2025-07-04', 'Ativo', 2, '02'),
(default, '2023-01-10', '2025-10-14', 'Inativo', 2, '03'),
(default, '2020-07-22', '2024-10-17', 'Inativo', 7, '01'),
(default, '2020-07-22', '2024-08-17', 'Inativo', 7, '02'),
(default, '2020-07-22', '2024-08-25', 'Inativo', 7, '03'),
(default, '2024-02-05', '2024-05-30', 'Ativo', 3, '01'),
(default, '2024-02-05', '2024-03-30', 'Inativo', 3, '02'),
(default, '2024-02-05', '2025-09-20', 'Ativo', 3, '03'),
(default, '2019-05-12', '2023-11-20', 'Ativo', 8, '02'),
(default, '2019-05-12', '2023-11-01', 'Ativo', 8, '01'),
(default, '2019-10-30', '2023-07-14', 'Inativo', 9, '01'),
(default, '2019-10-30', '2023-07-14', 'Ativo', 9, '02'),
(default, '2020-01-15', '2023-03-09', 'Ativo', 10, '01'),
(default, '2020-01-15', '2023-03-09', 'Inativo', 10, '02'),
(default, '2020-08-04', '2025-12-25', 'Ativo', 4, '01'),
(default, '2020-08-04', '2022-12-25', 'Ativo', 4, '02'),
(default, '2020-08-04', '2024-12-25', 'Ativo', 4, '03'),
(default, '2021-04-22', '2024-01-05', 'Ativo', 11, '01'),
(default, '2021-04-22', '2022-06-05', 'Ativo', 11, '02'),
(default, '2021-09-11', '2022-02-18', 'Inativo', 5, '01'),
(default, '2021-09-11', '2021-11-18', 'Ativo', 5, '02'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 5, '03'),
(default, '2019-02-04', '2021-12-30', 'Inativo', 12, '02'),
(default, '2019-02-04', '2025-12-30', 'Ativo', 12, '01'),
(default, '2024-08-04', '2024-12-25', 'Ativo', 6, '01'),
(default, '2024-08-04', '2025-12-25', 'Ativo', 6, '02'),
(default, '2024-08-04', '2025-12-25', 'Ativo', 6, '03'),
(default, '2022-08-04', '2022-01-09', 'Ativo', 9, '01'),
(default, '2022-08-04', '2025-12-25', 'Ativo', 9, '02'),
(default, '2023-12-04', '2023-12-25', 'Ativo', 14, '01'),
(default, '2023-12-04', '2024-12-25', 'Ativo', 14, '02'),
(default, '2021-12-04', '2023-12-25', 'Ativo', 13, '01'),
(default, '2021-12-04', '2022-12-25', 'Ativo', 13, '02'),
(default, '2025-12-04', '2025-12-05', 'Ativo', 15, '01'),
(default, '2025-12-04', '2025-12-15', 'Ativo', 15, '02');


----------------- insert leitor --------------------
select * from Sensor order by fkRestaurante;
----------- Empresa 1
-- sensor 1
INSERT INTO Registro VALUES
(null, default, 1, 1, 'Entrada'),
(null, default, 0, 1, 'Entrada');

SELECT * FROM sensor order by fkBloco;
SELECT idSensor from Sensor;



----------------------------- SELECTS ---------------------------------------



 
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


INSERT INTO Usuario
 VALUES (default, 'Mariana Souza', 'mariana.oper@pizzaria.com','Mari#S2026','Operador',1,1),
(default, 'Lucas Gabriel Santos','lucas.oper@pizzaria.com','Lks_8871ab','Operador',1,1);


-- SELECT DOS SENSORES
SELECT s.idSensor,s.data_manutencao,s.status,s.fkBloco,b.bloco,b.fkRestaurante,r.nome_fantasia,r.status
FROM Sensor s JOIN Bloco b ON s.fkRestaurante = b.fkRestaurante
AND s.fkBloco = b.bloco JOIN Restaurante r ON b.fkRestaurante = r.idRestaurante;


-- Criando Usuarios para maquina virtual ----------------------------
CREATE USER 'usuario_insert'@'localhost' IDENTIFIED BY 'Rml_1505';
CREATE USER 'usuario_select'@'localhost' IDENTIFIED BY 'Yag_2102';

-- usar como root
GRANT INSERT ON FMS.* TO 'usuario_insert'@'localhost';
GRANT SELECT  ON FMS.* TO 'usuario_select'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'usuario_insert'@'localhost';
SHOW GRANTS FOR 'usuario_select'@'localhost';
