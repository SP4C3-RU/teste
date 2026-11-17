-- TDE DE BANCO DE DADOS 
-- ===========================================
CREATE DATABASE clínica01;
USE clínica01;
-- ==========================================

-- 1.PACIENTE(CLÍNTES QUE IRAM A CLÍNICA PARA CONSULTAS)
CREATE TABLE paciente (
id_paciente   INT AUTO_INCREMENT PRIMARY KEY,
nome  VARCHAR(150) NOT NULL UNIQUE,
cpf   VARCHAR(11) NOT NULL UNIQUE,
email VARCHAR(150) NOT NULL UNIQUE,
telefone VARCHAR(20) NOT NULL,
data_nascimento  DATE NOT NULL,
data_cadastro  DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 2.MÉDICO(RESPONSAVEL POR ATENDER AS NECESSIDADES MÉDICAS DOS CLÍENTES) 
CREATE TABLE medico (
id_medico INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
crm VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(150) NOT NULL UNIQUE
);

-- 3.ESPECIALIDADE(ÁREA A QUAL O MÉDICO ATUA) 
CREATE TABLE especialidade (
id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL UNIQUE,
descricao VARCHAR(500)
);

-- 4.MÉDICO ESPECIALISTA( UM MÉDICO PODE TER VÁRIAS ESPECIALIDADES E UMA ESPECIALIDADE PODE TER VÁRIOS MÉDICOS)
CREATE TABLE medico_especialidade (
id_medico INT NOT NULL,
id_especialidade INT NOT NULL,

PRIMARY KEY (id_medico, id_especialidade),

FOREIGN KEY (id_medico)
REFERENCES medico(id_medico),

FOREIGN KEY (id_especialidade)
REFERENCES especialidade(id_especialidade)
);

-- 5.CONSULTAS(DATA) HORA A QUAL O CLÍENTE DEVE IR A CLÍNICA APÓS MARCAR A CONSULTA)
CREATE TABLE consulta (
id_consulta INT AUTO_INCREMENT PRIMARY KEY,
id_paciente INT NOT NULL,
id_medico INT NOT NULL,
id_especialidade INT NOT NULL,
data_hora TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
status VARCHAR(20) NOT NULL DEFAULT 'agendada',
motivo VARCHAR(500) NOT NULL,
valor DECIMAL(10,2) NOT NULL,

FOREIGN KEY (id_paciente)
  REFERENCES paciente(id_paciente),
  
  FOREIGN KEY (id_medico, id_especialidade)
    REFERENCES medico_especialidade(id_medico, id_especialidade),
    
CHECK (
   status IN (
      'agendada',
      'realizada',
      'cancelada',
      'falta'
	)
),
CHECK (valor>= 0)
);

-- 6.PRONTUÁRIOS(LISTA DE INFORÇÃO MÉDICA REFENTE AO CLÍENTE)
CREATE TABLE prontuario (
id_prontuario SERIAL PRIMARY KEY,
id_consulta INT NOT NULL UNIQUE,
diagnostico VARCHAR(500),
observacoes VARCHAR(1000),
data_registro DATE NOT NULL DEFAULT (CURRENT_DATE),

FOREIGN KEY (id_consulta)
	REFERENCES consulta(id_consulta)
);

-- 7.PRESCRIÇÕES(ORIENTAÇÃO MÉDICA REFENTE AO DIAGNOSTICO E AOS RÉMEDIOS REMOENDADOS)
CREATE TABLE prescricao (
id_prescricao INT AUTO_INCREMENT PRIMARY KEY,
id_prontuario BIGINT UNSIGNED NOT NULL,
medicamento VARCHAR(150) NOT NULL,
dosagem VARCHAR(100) NOT NULL,
frequencia VARCHAR(100) NOT NULL,
duracao_tratamento VARCHAR(100) NOT NULL,
orientacoes VARCHAR(500),

FOREIGN KEY (id_prontuario)
  REFERENCES prontuario(id_prontuario)
);

-- COMEÇANDO A INSERIR UM FORMAÇÕES NO BANCO, COMENÇANDO PELA ESPECIALIDADE, MEDICO, PACIENTE, MEDICO_ESPECIALIDADE, CONSULTA, PRONTUARIO E PRESCRIÇÃO.

INSERT INTO especialidade (nome, descricao)
VALUES
('Cardiologia', 'Cuida do coração e do sistema circulatório'),
('Dermatologia', 'Cuida da pele, cabelos e unhas'),
('Pediatria', 'Atendimento de crianças e adolescentes'),
('Ortopedia', 'Cuida dos ossos, músculos e articulações'),
('Neurologia', 'Cuida do sistema nervoso'),
('Ginecologia','Cuida da saúde da mulher e do sistema reprodutor feminino'),
('Psiquiatria', 'Cuida da saúde mental'),
('Endocrinologia', 'Cuida dos hormônios e do metabolismo');

SELECT * FROM especialidade;

INSERT INTO medico (nome, crm, email)
VALUES
('Ana Souza', 'CRM1001', 'ana.souza@clinica.com'),
('Bruno Lima', 'CRM1002', 'bruno.lima@clinica.com'),
('Carla Mendes', 'CRM1003', 'carla.mendes@clinica.com'),
('Daniel Rocha', 'CRM1004', 'daniel.rocha@clinica.com'),
('Elisa Martins', 'CRM1005', 'elisa.martins@clinica.com'),
('Ricardo Barros', 'CRM1806', 'ricardo@clinica.com'),
('Sofia Andrade', 'CRM 1007', 'sofia@clinica.com'),
('Igor Menezes', 'CRM1008', 'igor.menezes@clinica.com'),
('Gustavo Neves', 'CRM1009', 'gustavo.neves@clinica.com'),
('Helena Prado', 'CRM1010', 'helena.prado@clinica.com'),
('Marcos Vieira', 'CRM1011', 'marcos.vieira@clinica.com');

SELECT * FROM medico;

INSERT INTO paciente (nome, cpf, email, telefone, data_nascimento)
VALUES
('João Silva', '11111111111', 'joao@email.com', '85999990001', '1990-04-15'),
('Maria Oliveira', '22222222222', 'maria@email.com', '85999990002', '1985-08-20'),
('Pedro Santos', '33333333333', 'pedro@email.com', '85999990003', '2001-02-10'),
('Juliana Costa', '44444444444', 'juliana@email.com', '85999990004', '1995-11-05'),
('Lucas Almeida', '55555555555', 'lucas@email.com', '85999990005', '2015-06-17'),
('Fernanda Gomes', '66666666666', 'fernanda@email.com', '85999990006', '1978-03-25'),
('Rafael Pereira', '77777777777', 'rafael@email.com', '85999990007', '1988-12-09'),
('Camila Ribeiro', '88888888888', 'camila@email.com', '85999990008', '2007-09-30'),
('Mariana Alves','99999999999','mariana@email.com','85999990009','1997-07-12');

ALTER TABLE paciente ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'agendada';

INSERT INTO paciente (nome, cpf, email, telefone, data_nascimento,data_cadastro, status)
VALUES
('Alice Moraes', '10101010101', 'alice@email.com','85999990011', '1992-01-10', '2023-02-14', 'falta'),
('Benicio Tavares', '20202020202', 'benicio@email.com','85999990012', '1987-03-22', '2023-05-30', 'realizada'),
('Cecília Duarte', '30303030303', 'cecilia@email.com','85999990013', '2000-07-14', '2023-08-11', 'agendada'),
('Diego Furtado', '40404040404', 'diego@email.com','85999990014', '1975-11-30', '2023-11-26', 'cancelada'),
('Eduarda Lins', '50505050505', 'eduarda@email.com','85999990015', '2010-05-08', '2026-09-27', 'agendada'),
('Fábio Queiroz', '60606060606', 'fabio@email.com','85999990016', '1998-09-03', '2024-02-21', 'agendada'),
('Gabriela Pires', '70707070707', 'gabriela@email.com','85999990017', '1983-12-17', '2024-04-03', 'realizada'),
('Heitor Sampaio', '80808080808', 'heitor@email.com','85999990018', '2015-02-27', '2024-07-15', 'falta'),
('Isabela Fontes', '90909090909', 'isabela@email.com','85999990019', '1994-06-19', '2024-10-28', 'realizada'),
('Joaquim Bezerra', '12121212121', 'joaquim@email.com','85999990020', '1969-08-05', '2024-12-12', 'agendada'),
('Karina Vasques', '13131313131', 'karina@email.com','85999990021', '2003-10-11', '2025-02-06', 'cancelada'),
('Leandro Aguiar', '14141414141', 'leandro@email.com','85999990022', '1989-04-24', '2025-04-17', 'realizada'),
('Marina Coutinho', '15151515151', 'marina.c@email.com','85999990023', '1991-07-02', '2025-06-29', 'agendada'),
('Nicolas Barreto', '16161616161', 'nicolas@email.com','85999990024', '2012-01-29', '2025-07-23', 'falta'),
('Olívia Sarmento', '17171717171', 'olivia@email.com','85999990025', '1980-11-13', '2025-09-04', 'realizada'),
('Paulo Rangel', '18181818181', 'paulo.r@email.com','85999990026', '1996-03-07', '2025-11-15', 'agendada'),
('Queila Amaral', '19191919191', 'queila@email.com','85999990027', '1985-09-21', '2026-01-08', 'cancelada'),
('Rodrigo Peixoto', '21212121212', 'rodrigo@email.com','85999990028', '1972-05-16', '2026-02-19', 'realizada'),
('Sabrina Loyola', '22222222223', 'sabrina@email.com','85999990029', '2005-12-04', '2026-03-27', 'agendada'),
('Thiago Nogueira', '23232323232', 'thiago@email.com','85999990030', '1993-08-28', '2026-04-14', 'falta'),
('Ursula Mendonça', '24242424242', 'ursula@email.com','85999990031', '1999-02-15', '2026-05-06', 'realizada'),
('Vitor Camargo', '25252525252', 'vitor@email.com','85999990032', '1965-10-09', '2026-06-11', 'cancelada'),
('Wanda Espinosa', '26262626262', 'wanda@email.com','85999990033', '1988-06-23', '2026-07-02', 'agendada'),
('Xavier Tomaz', '27272727272', 'xavier@email.com','85999990034', '1979-04-01', '2026-07-25', 'realizada'),
('Yasmin Craveiro', '28282828282', 'yasmin@email.com','85999990035', '2008-07-27', '2026-08-13', 'falta'),
('Zeca Portela', '29292929292', 'zeca@email.com','85999990036', '2001-11-18', '2026-08-30', 'agendada');

SELECT * FROM paciente;
     
INSERT INTO medico_especialidade (id_medico, id_especialidade)
VALUES
(1, 1), -- Ana: Cardiologia
(1, 2), -- Ana: Dermatologia
(2, 2), -- Bruno: Dermatologia
(3, 3), -- Carla: Pediatria
(3, 6), -- carla: Ginecologia
(4, 4), -- Daniel: Ortopedia
(5, 1), -- Elisa: Cardiologia 
(5, 3), -- Elisa: Pediatria
(6, 6), -- Ricardo: Ginecologia
(6, 8), -- Ricardo: Endocrinologia
(7, 7), -- Sofia: Psiquiatria
(7, 6), -- Sofia: Ginecologia
(9, 5), -- Gustavo: Neurologia
(9, 1), -- Gustavo : Cardiologia
(10, 7), -- Helena: Psiquiatria
(10, 6), -- Helena: Ginecologia
(8, 8), -- Igor: Neurologia
(8, 1), -- Igor: Cardiologia
(11, 4), -- Marcos: Ortopedia
(11, 6); -- Marcos: Ginecologia

SELECT * FROM medico_especialidade;

INSERT INTO consulta (id_paciente, id_medico, id_especialidade, data_hora, status, motivo, valor)
VALUES
    (10, 1, 1, '2023-02-27 08:00:00', 'falta', 'Dor no peito', 250.00),
    (11, 2, 2, '2023-06-13 09:00:00', 'realizada', 'Manchas na pele', 180.00),
    (12, 4, 4, '2023-08-25 11:00:00', 'realizada', 'Dor no joelho', 220.00),
    (13, 1, 1, '2023-12-11 11:00:00', 'cancelada', 'Avaliação cardíaca', 250.00),
    (16, 7, 7, '2024-04-17 10:00:00', 'realizada', 'Ansiedade', 300.00),
    (17, 9, 5, '2024-07-29 11:00:00', 'falta', 'Dores de cabeça', 240.00),
    (18, 10, 7, '2024-11-12 08:00:00', 'realizada', 'Avaliação psiquiátrica', 300.00),
    (20, 11, 4, '2025-02-20 10:00:00', 'cancelada', 'Dor no ombro', 220.00),
    (21, 11, 6, '2025-05-02 11:00:00', 'cancelada', 'Consulta ginecológica', 200.00),
    (23, 2, 2, '2025-08-06 09:00:00', 'falta', 'Coceira persistente', 180.00),
    (24, 3, 3, '2025-09-18 10:00:00', 'realizada', 'Consulta pediátrica', 160.00),
    (26, 5, 3, '2026-01-22 08:00:00', 'cancelada', 'Consulta pediátrica', 160.00),
    (27, 6, 8, '2026-03-05 09:00:00', 'realizada', 'Alteração hormonal', 230.00),
    (29, 8, 1, '2026-04-28 11:00:00', 'falta', 'Avaliação cardíaca', 250.00),
    (30, 6, 6, '2026-05-20 08:00:00', 'realizada', 'Consulta ginecológica', 200.00),
    (31, 7, 7, '2026-06-25 09:00:00', 'cancelada', 'Ansiedade', 300.00),
    (33, 1, 2, '2026-08-08 11:00:00', 'realizada', 'Irritação na pele', 180.00),
    (34, 3, 3, '2026-08-27 08:00:00', 'falta', 'Febre e tosse', 160.00),
    (31, 7, 7, '2026-09-22 10:00:00', 'realizada', 'Avaliação psiquiátrica', 300.00),
    (1, 1, 1, '2026-10-01 08:00:00', 'agendada', 'Dor no peito', 250.00),
    (2, 2, 2, '2026-10-01 09:00:00', 'agendada', 'Manchas na pele', 180.00),
    (3, 4, 4, '2026-10-01 10:00:00', 'agendada', 'Dor no joelho', 220.00),
    (4, 5, 1, '2026-10-02 08:30:00', 'agendada', 'Avaliação cardíaca', 250.00),
    (5, 3, 3, '2026-10-02 09:30:00', 'realizada', 'Febre e tosse', 160.00),
    (6, 1, 2, '2026-10-02 10:30:00', 'realizada', 'Irritação na pele', 180.00),
    (7, 5, 1, '2026-10-03 08:00:00', 'agendada', 'Pressão alta', 250.00),
    (8, 3, 3, '2026-10-03 09:00:00', 'agendada', 'Consulta de rotina', 160.00),
    (1, 4, 4, '2026-10-03 10:00:00', 'agendada', 'Dor nas costas', 220.00),
    (2, 1, 1, '2026-10-04 08:30:00', 'realizada', 'Palpitações', 250.00),
    (3, 2, 2, '2026-10-04 09:30:00', 'agendada', 'Coceira persistente', 180.00),
    (4, 3, 3, '2026-10-04 10:30:00', 'agendada', 'Avaliação pediátrica', 160.00),
    (15, 6, 6, '2026-10-05 09:00:00', 'realizada', 'Consulta ginecológica', 200.00),
    (19, 8, 8, '2026-10-06 09:00:00', 'agendada', 'Alteração hormonal', 230.00),
    (22, 1, 1, '2026-10-07 08:00:00', 'agendada', 'Pressão alta', 250.00),
    (25, 4, 4, '2026-10-08 11:00:00', 'agendada', 'Dor nas costas', 220.00),
    (28, 11, 6, '2026-10-09 10:00:00', 'realizada', 'Consulta ginecológica', 200.00),
    (32, 6, 8, '2026-10-10 10:00:00', 'realizada', 'Alteração hormonal', 230.00),
    (35, 7, 7, '2026-10-11 09:00:00', 'agendada', 'Ansiedade', 300.00),
    (14, 5, 1, '2026-10-20 08:00:00', 'agendada', 'Palpitações', 250.00);
    
SELECT * FROM consulta;

INSERT INTO consulta (id_paciente, id_medico, id_especialidade, data_hora, motivo, valor)
VALUES
(9, 4, 4, '2026-10-10 14:00:00', 'Dor no ombro', 220.00);

UPDATE consulta
SET status = 'realizada'
WHERE id_consulta = 9;

INSERT INTO prontuario (id_consulta, diagnostico, observacoes)
VALUES
(9, 'inflamacao no ombro', 'paciente orientado a evitar esforço físico');
SELECT LAST_INSERT_ID(9);

INSERT INTO prescricao (id_prontuario, medicamento, dosagem, frequencia, duracao_tratamento, orientacoes)
VALUES
(1, 'Ibuprofeno', '400 mg', 'A cada 8 horas', '5 dias', 'Tomar após as refeições'),

(1, 'Dipirona', '500 mg', 'A cada 6 horas', '3 dias', 'Tomar somente em caso de dor');

SELECT * FROM prescricao;

SET SQL_SAFE_UPDATES = 0;
UPDATE consulta
SET valor = valor * 1.08 
WHERE id_especialidade = 1;
SET SQL_SAFE_UPDATES = 1;
-- A CARDIOLOGIA PASSOU DE 250 PRA 270
SELECT id_consulta, id_especialidade, valor FROM consulta
WHERE id_especialidade = 1;

ALTER TABLE consulta
ADD justificativa_cancelamento VARCHAR(500);
UPDATE consulta
SET
 status = 'cancelada',
 justificativa_cancelamento = 'Paciente informou que não poderá comparecer'
WHERE id_consulta = 3;

SELECT id_consulta
 status, justificativa_cancelamento
FROM consulta
WHERE id_consulta = 3;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM especialidade WHERE id_especialidade = 1;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE especialidade
ADD ativo BOOLEAN NOT NULL DEFAULT (TRUE);

UPDATE especialidade
SET ativo = FALSE
WHERE id_especialidade = 1;

SELECT * FROM especialidade;

INSERT INTO especialidade (id_especialidade, nome, descricao)
VALUES
(1, 'Cardiologia', 'Cuida do coração e do sistema circulatório');

-- =============================================================================================================
-- A PARTIR DAQUI TERA O USO DOS SELECT, INDICE E VIEWS
-- =============================================================================================================

SELECT * FROM paciente
WHERE data_cadastro > '2026-01-01'
ORDER BY nome;

SELECT medico.nome, especialidade.nome FROM medico
LEFT JOIN medico_especialidade ON medico.id_medico = medico_especialidade.id_medico
LEFT JOIN especialidade ON medico_especialidade.id_especialidade = especialidade.id_especialidade
ORDER BY medico.nome;

SELECT medico.nome AS nome_medico, especialidade.nome AS nome_especialidade FROM medico
LEFT JOIN medico_especialidade ON medico.id_medico = medico_especialidade.id_medico
LEFT JOIN especialidade ON medico_especialidade.id_especialidade = especialidade.id_especialidade
ORDER BY medico.nome;

SELECT medico.nome, COUNT(consulta.id_consulta) AS quantidade_consultas,
AVG(consulta.valor) AS valor_medio FROM medico
LEFT JOIN consulta ON medico.id_medico = consulta.id_medico
AND consulta.status = 'realizada'
GROUP BY medico.id_medico, medico.nome;

SELECT medico.nome, COUNT(consulta.id_consulta) AS quantidade_consultas FROM medico
INNER JOIN consulta ON medico.id_medico = consulta.id_medico
WHERE consulta.status = 'realizada'
GROUP BY medico.id_medico, medico.nome
HAVING COUNT(consulta.id_consulta) > 3;

SELECT paciente.nome AS paciente, medico.nome AS medico,
DATE(consulta.data_hora) AS data_consulta, TIME(consulta.data_hora) AS horario_consulta
FROM consulta
INNER JOIN paciente ON consulta.id_paciente = paciente.id_paciente
INNER JOIN medico ON consulta.id_medico = medico.id_medico
WHERE consulta.status = 'agendada' 
  AND consulta.data_hora >= '2026-10-01 00:00:00'
ORDER BY consulta.data_hora;

SELECT paciente.nome, MAX(consulta.data_hora) AS ultima_consulta
FROM paciente
LEFT JOIN consulta ON paciente.id_paciente = consulta.id_paciente
GROUP BY paciente.id_paciente, paciente.nome
ORDER BY paciente.nome;

SELECT especialidade.nome, SUM(consulta.valor) AS total_faturado
FROM especialidade INNER JOIN consulta ON especialidade.id_especialidade = consulta.id_especialidade
WHERE consulta.status = 'realizada'
GROUP BY  especialidade.id_especialidade, especialidade.nome;

SELECT medico.nome, COUNT(consulta.id_consulta) AS quantidade_consultas FROM medico
INNER JOIN consulta ON medico.id_medico = consulta.id_medico
WHERE consulta.status = 'realizada'
GROUP BY medico.id_medico, medico.nome
ORDER BY quantidade_consultas DESC;

SELECT MONTH(data_hora) AS mes, YEAR(data_hora) AS ano, SUM(valor) AS total_faturado
FROM consulta WHERE status = 'realizada'
GROUP BY YEAR(data_hora), MONTH(data_hora)
ORDER BY YEAR(data_hora), MONTH(data_hora);

-- UTILIZAÇÃO DE INDICE

SELECT * FROM consulta
WHERE id_medico = 1 AND data_hora BETWEEN '2026-10-01' AND '2026-10-31'
AND status = 'realizada';
CREATE INDEX idx_consulta_medico_data_status 
ON consulta (id_medico, data_hora, status);

SELECT * FROM paciente
WHERE cpf = '11111111111';
CREATE UNIQUE INDEX idx_paciente_cpf
ON paciente (cpf);

SELECT * FROM consulta
WHERE id_paciente = 1
ORDER BY data_hora desc;
CREATE INDEX idx_consulta_paciente_data
ON consulta (id_paciente, data_hora DESC);

-- CRIAÇÃO DAS VIEWS

CREATE VIEW vw_agenda_medica AS
SELECT medico.nome AS medico, especialidade.nome AS especialidade, paciente.nome AS paciente,
    DATE(consulta.data_hora) AS data,
    TIME(consulta.data_hora) AS horario,
    consulta.status AS status
FROM consulta
INNER JOIN medico ON consulta.id_medico = medico.id_medico
INNER JOIN paciente ON consulta.id_paciente = paciente.id_paciente
INNER JOIN especialidade ON consulta.id_especialidade = especialidade.id_especialidade;

CREATE VIEW vw_historico_paciente AS
SELECT paciente.nome AS paciente,
  consulta.data_hora AS data_consulta,
  medico.nome AS medico,
  prontuario.diagnostico AS diagnostico,
  prescricao.medicamento AS medicamento,
  prescricao.dosagem AS dosagem,
  prescricao.frequencia AS frequencia,
  prescricao.duracao_tratamento AS duracao_tratamento,
  prescricao.orientacoes AS orientacoes
FROM paciente
INNER JOIN consulta ON paciente.id_paciente = consulta.id_paciente
INNER JOIN medico ON consulta.id_medico = medico.id_medico
INNER JOIN prontuario ON consulta.id_consulta = prontuario.id_consulta
INNER JOIN prescricao ON prontuario.id_prontuario = prescricao.id_prontuario;
SELECT * FROM vw_historico_paciente
WHERE paciente = 'Leandro Aguiar';


SELECT * FROM vw_agenda_medica
WHERE medico = 'Ana Souza'
AND data = '2026-10-01';

-- Vantagem
-- A view simplifica a consulta. Todos os JOIN entre consulta, médico, paciente e especialidade já estão guardados dentro dela. Evita uma consulta longa.

-- desvantagem
-- A view não armazena dados e não cria índices próprios. Toda vez que é chamada, os JOIN são executados novamente. 
-- Além disso, se um filtro é aplicado sobre a view, o banco precisa trabalhar sobre o resultado inteiro antes de filtrar, o que pode deixar a busca mais lenta em tabelas grandes.