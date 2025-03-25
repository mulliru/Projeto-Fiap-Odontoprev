CREATE DATABASE IF NOT EXISTS challenge_db;
USE challenge_db;

CREATE TABLE IF NOT EXISTS dados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rm VARCHAR(10) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    data DATE NOT NULL
);

INSERT INTO dados (rm, nome, data) VALUES ('553315', 'Murillo Ferreira Ramos', CURDATE());
INSERT INTO dados (rm, nome, data) VALUES ('552659', 'William Kenzo Hayashi', CURDATE());
INSERT INTO dados (rm, nome, data) VALUES ('553874', 'Pedro Luiz Prado', CURDATE());
