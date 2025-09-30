-- Criação do banco de dados
CREATE DATABASE agencia_viagens;
USE agencia_viagens;

-- 1. Usuário / Cliente
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    endereco TEXT
);

-- 2. Destino Turístico
CREATE TABLE destino (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    localizacao VARCHAR(150),
    principais_atrativos TEXT,
    categoria VARCHAR(50),
    imagem_url VARCHAR(255)
);

-- 3. Pacote de Viagem
CREATE TABLE pacote (
    id_pacote INT AUTO_INCREMENT PRIMARY KEY,
    nome_pacote VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    quantidade_vagas INT,
    id_destino INT,
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino)
);

-- 4. Reserva
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    status ENUM('pendente','confirmada','cancelada') DEFAULT 'pendente',
    quantidade_pessoas INT NOT NULL,
    id_usuario INT,
    id_pacote INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote)
);

-- 5. Hotel / Acomodação
CREATE TABLE hotel (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    categoria VARCHAR(50),
    preco_diaria DECIMAL(10,2),
    contato VARCHAR(100),
    id_destino INT,
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino)
);

-- 6. Transporte
CREATE TABLE transporte (
    id_transporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('avião','ônibus','carro','trem','barco'),
    empresa VARCHAR(100),
    horario_partida DATETIME,
    horario_chegada DATETIME,
    origem VARCHAR(100),
    destino VARCHAR(100),
    preco DECIMAL(10,2),
    id_pacote INT,
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote)
);

-- 7. Avaliação / Comentário
CREATE TABLE avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao DATE,
    id_usuario INT,
    id_destino INT,
    id_pacote INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino),
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote)
);
