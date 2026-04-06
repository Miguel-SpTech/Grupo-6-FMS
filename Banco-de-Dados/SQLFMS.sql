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
    senha_hash VARCHAR(255),
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
    numeracao VARCHAR(50),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    data_instalacao DATETIME,
    data_manutencao DATETIME,
    status VARCHAR(20),
    fkBloco INT,
    FOREIGN KEY (fkBloco) REFERENCES Blocos(idBloco)
);


CREATE TABLE Leitores (
    idLeitura INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME,
    leitura TINYINT,
    fkSensor INT,
    tipo_leitura VARCHAR(45),
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);
