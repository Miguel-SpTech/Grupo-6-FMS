
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

-------------------- INSERT RESTAURANTE--------------------
desc Restaurante;


INSERT INTO Restaurante VALUES
(default, 'Pizzaria Di Napoli Alimentos Ltda.','Bella Napoli','11222333000111','Aprovado',40),
(default, 'Massa & Forno Gastronomia Eireli','Santo Pedaço','44555666000144','Pendente',50),
(default,  'Comércio de Massas Artesanais Lupa Ltda.', 'Luppa Pizza Bar','77888999000177', 'Aprovado', 30),
(default,  'Rede de Pizzarias Redonda de Ouro S.A.', 'Disco de Ouro','10203040000110', 'Aprovado',30), 
(default,  'Mamma Mia Serviços de Alimentação Me.', 'Forno da Mamma','55444333000155', 'Pendente',20);



----------------------- INSERT ENDERECO ------------
desc Endereco;
select * from Endereco;
INSERT INTO Endereco VALUES
(default, '01310200', 'Avenida Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', 'Bloco 2A', 1),
(default, '20040002', 'Avenida Rio Branco', '45', 'Centro', 'Rio de Janeiro','RJ', '', 2),
(default, '70150900', 'Praça dos Três Poderes', 'SN', 'Zona Cívico - Administrativa', 'Brasília', 'DF', '', 3),
(default, '30140061', 'Rua da Bahia', '1022', 'Lourdes', 'Belo Horizonte', 'MG', 'Bloco 6D',4),
(default, '80020100', 'Praça Tiradentes', '290', 'Centro', 'Curitiba', 'PR', '',5);
select * from Endereco;



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
(1, '03'),
(1, '04'),

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

select*from bloco;

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
(default, '2020-07-22', '2024-10-17', 'Inativo', 5, '01'),
(default, '2020-07-22', '2024-08-17', 'Inativo', 5, '02'),
(default, '2020-07-22', '2024-08-25', 'Inativo', 5, '03'),
(default, '2024-02-05', '2024-05-30', 'Ativo', 3, '01'),
(default, '2024-02-05', '2024-03-30', 'Inativo', 3, '02'),
(default, '2024-02-05', '2025-09-20', 'Ativo', 3, '03'),
(default, '2019-05-12', '2023-11-20', 'Ativo', 4, '02'),
(default, '2019-05-12', '2023-11-01', 'Ativo', 4, '01'),
(default, '2019-10-30', '2023-07-14', 'Inativo', 5, '01'),
(default, '2019-10-30', '2023-07-14', 'Ativo', 5, '02'),
(default, '2020-01-15', '2023-03-09', 'Ativo', 4, '01'),
(default, '2020-01-15', '2023-03-09', 'Inativo', 4, '02'),
(default, '2020-08-04', '2025-12-25', 'Ativo', 4, '01'),
(default, '2020-08-04', '2022-12-25', 'Ativo', 4, '02'),
(default, '2020-08-04', '2024-12-25', 'Ativo', 4, '03'),
(default, '2021-04-22', '2024-01-05', 'Ativo', 5, '01'),
(default, '2021-09-11', '2022-02-18', 'Inativo', 5, '01'),
(default, '2021-09-11', '2021-11-18', 'Ativo', 5, '02'),
(default, '2021-09-11', '2023-12-18', 'Ativo', 5, '03');


----------------- insert leitor --------------------
select * from Sensor order by fkRestaurante;
----------- Empresa 1
-- sensor 1
INSERT INTO Registro VALUES
(null, default, 1, 1, 'Entrada'),
(null, default, 1, 1, 'Entrada'),
(null, default, 1, 1, 'Entrada'),
(null, default, 1, 2, 'Entrada'),
(null, default, 1, 2, 'Entrada'),
(null, default, 1, 5, 'Entrada'),
(null, default, 1, 6, 'Entrada');

INSERT INTO Registro (data, leitura, fkSensor, tipo_leitura) VALUES
('2026-05-21 11:15:00', 1, 1, 'Entrada'),
('2026-05-21 12:30:00', 1, 2, 'Entrada'),

('2026-05-22 10:20:00', 1, 1, 'Entrada'),
('2026-05-22 13:45:00', 1, 2, 'Entrada'),
('2026-05-22 18:10:00', 1, 3, 'Entrada'),

('2026-05-23 09:05:00', 1, 1, 'Entrada'),
('2026-05-23 12:40:00', 1, 2, 'Entrada'),
('2026-05-23 19:25:00', 1, 3, 'Entrada'),

('2026-05-24 11:50:00', 1, 1, 'Entrada'),
('2026-05-24 14:15:00', 1, 2, 'Entrada'),
('2026-05-24 20:30:00', 1, 3, 'Entrada'),

('2026-05-25 10:00:00', 1, 1, 'Entrada'),
('2026-05-25 12:10:00', 1, 2, 'Entrada'),
('2026-05-25 18:45:00', 1, 3, 'Entrada'),
('2026-05-25 21:20:00', 1, 1, 'Entrada'),

('2026-05-26 09:30:00', 1, 1, 'Entrada'),
('2026-05-26 13:00:00', 1, 2, 'Entrada'),
('2026-05-26 17:40:00', 1, 3, 'Entrada'),
('2026-05-26 20:15:00', 1, 1, 'Entrada'),

('2026-05-27 10:45:00', 1, 1, 'Entrada'),
('2026-05-27 12:35:00', 1, 2, 'Entrada'),
('2026-05-27 15:50:00', 1, 3, 'Entrada'),
('2026-05-27 19:10:00', 1, 1, 'Entrada'),
('2026-05-27 21:55:00', 1, 2, 'Entrada');

INSERT INTO Registro VALUES

(null, default, 1, 3, 'Mapa'),
(null, default, 1, 4, 'Mapa'),
(null, default, 1, 5, 'Mapa');




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


-- insert operador

INSERT INTO Usuario
 VALUES (default, 'Mariana Souza', 'mariana.oper@pizzaria.com','Mari#S2026','Operador',1,1),
(default, 'Lucas Gabriel Santos','lucas.oper@pizzaria.com','Lks_8871ab','Operador',1,1);


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
     ROUND(COUNT(reg.idRegistro)/r.quantmesa,2) AS rotaçao_mesa
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


CREATE VIEW vw_heatmap_blocos AS
SELECT
    r.idRestaurante,
    r.nome_fantasia,

    s.fkBloco AS bloco,

    COUNT(reg.idRegistro) AS total_movimentacoes

FROM Restaurante r

JOIN Sensor s
    ON r.idRestaurante = s.fkRestaurante

JOIN Registro reg
    ON s.idSensor = reg.fkSensor

WHERE reg.tipo_leitura = 'Mapa'

GROUP BY
    r.idRestaurante,
    r.nome_fantasia,
    s.fkBloco;
    
select *from vw_heatmap_blocos;

-- view de quantidade clientes nos ultimos 7 dias 

drop view  vw_clientes_7dias;
CREATE VIEW vw_clientes_7dias AS

SELECT
    dados.idRestaurante,
    dados.nome_fantasia,
    dados.data_dia,

    CASE DAYOFWEEK(dados.data_dia)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-Feira'
        WHEN 3 THEN 'Terça-Feira'
        WHEN 4 THEN 'Quarta-Feira'
        WHEN 5 THEN 'Quinta-Feira'
        WHEN 6 THEN 'Sexta-Feira'
        WHEN 7 THEN 'Sábado'
    END AS dia_semana,

    dados.total_clientes

FROM (

    SELECT
        r.idRestaurante,
        r.nome_fantasia,
        DATE(reg.data) AS data_dia,
        COUNT(reg.idRegistro) AS total_clientes

    FROM Restaurante r

    JOIN Sensor s
        ON r.idRestaurante = s.fkRestaurante

    JOIN Registro reg
        ON s.idSensor = reg.fkSensor

WHERE reg.tipo_leitura = 'Entrada'
AND reg.data >= CURDATE() - INTERVAL 7 DAY
AND reg.data <  CURDATE()

GROUP BY 
 r.idRestaurante,
 r.nome_fantasia,
 DATE(reg.data)
 
  ORDER  BY
  r.idRestaurante,
  data_dia;

select *from vw_clientes_7dias;




-- colocar para mostrar o dia exemplp segunda terça, quarta
