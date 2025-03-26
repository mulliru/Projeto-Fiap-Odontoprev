-- Auditoria - Criação de Tabela

CREATE TABLE AUDITORIA_LOG (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tabela_afetada VARCHAR2(50),
    operacao VARCHAR2(10),
    usuario VARCHAR2(50),
    data_registro DATE DEFAULT SYSDATE,
    dados_anteriores CLOB
);

CREATE TABLE AUDITORIA_LOG_PROFISSIONAL (
    id_log NUMBER PRIMARY KEY,  -- Chave primária para identificar cada log
    tabela_afetada VARCHAR2(50), -- Nome da tabela afetada
    operacao VARCHAR2(10),      -- Tipo de operação: INSERT, UPDATE, DELETE
    usuario VARCHAR2(30),       -- Usuário que fez a alteração
    dados_anteriores CLOB,      -- Dados anteriores da operação (antes da alteração)
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data e hora da operação
);

CREATE TABLE AUDITORIA_LOG_ENDERECO (
    id_log NUMBER PRIMARY KEY,  -- Chave primária para identificar cada log
    tabela_afetada VARCHAR2(50), -- Nome da tabela afetada
    operacao VARCHAR2(10),      -- Tipo de operação: INSERT, UPDATE, DELETE
    usuario VARCHAR2(30),       -- Usuário que fez a alteração
    dados_anteriores CLOB,      -- Dados anteriores da operação (antes da alteração)
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data e hora da operação
);

CREATE SEQUENCE SEQ_AUDITORIA_LOG_PROFISSIONAL
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_AUDITORIA_LOG_ENDERECO
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
