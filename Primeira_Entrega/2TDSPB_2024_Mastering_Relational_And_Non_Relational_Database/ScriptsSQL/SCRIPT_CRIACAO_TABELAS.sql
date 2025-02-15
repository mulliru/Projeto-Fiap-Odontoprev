CREATE TABLE O_CLIENTE (
    id_cliente NUMERIC PRIMARY KEY,
    nm_cliente VARCHAR(255),
    nr_cpf VARCHAR(14) UNIQUE,
    nr_rg VARCHAR(20) UNIQUE,
    dt_nasc DATE,
    fl_sexo CHAR(1)
);


CREATE TABLE O_SERVICO_IA (
    id_servico_ia NUMERIC PRIMARY KEY,
    dt_inicio DATE,
    dt_final DATE,
    id_cliente NUMERIC,
    FOREIGN KEY (id_cliente) REFERENCES O_CLIENTE(id_cliente)
);


CREATE TABLE O_PONTUACAO (
    id_conta NUMERIC PRIMARY KEY,
    qnt_pontos NUMERIC,
    dt_inicio_pontos DATE,
    dt_final_validade DATE,
    id_servico_ia NUMERIC,
    FOREIGN KEY (id_servico_ia) REFERENCES O_SERVICO_IA(id_servico_ia)
);


CREATE TABLE O_RECOMPENSA (
    id_recompensa NUMERIC PRIMARY KEY,
    nm_produto VARCHAR(255),
    desc_produto VARCHAR(255),
    preco_produto NUMERIC
);


CREATE TABLE O_ESTOQUE (
    id_estoque NUMERIC PRIMARY KEY,
    qnt_produto NUMERIC,
    id_recompensa NUMERIC,
    FOREIGN KEY (id_recompensa) REFERENCES O_RECOMPENSA(id_recompensa)
);

-- Tabela O_TELEFONE_CLIENTE
CREATE TABLE O_TELEFONE_CLIENTE (
    id_telefone NUMERIC PRIMARY KEY,
    nr_ddd NUMERIC,
    nr_telefone NUMERIC,
    tp_telefone VARCHAR(50),
    id_cliente NUMERIC,
    FOREIGN KEY (id_cliente) REFERENCES O_CLIENTE(id_cliente)
);

-- Tabela O_EMAIL_PACIENTE
CREATE TABLE O_EMAIL_PACIENTE (
    id_email NUMERIC PRIMARY KEY,
    tp_email VARCHAR(100),
    st_email VARCHAR(100),
    id_cliente NUMERIC,
    FOREIGN KEY (id_cliente) REFERENCES O_CLIENTE(id_cliente)
);

--
CREATE TABLE O_DIAGNOSTICO_SERVICO_IA (
    id_diagnostico NUMERIC PRIMARY KEY,
    st_diagnostico CHAR(1),
    desc_diagnostico VARCHAR(255),
    id_servico_ia NUMERIC,
    FOREIGN KEY (id_servico_ia) REFERENCES O_SERVICO_IA(id_servico_ia)
);

    
CREATE TABLE O_PROFISSIONAL (
    cfo NUMERIC PRIMARY KEY,
    nm_profissional VARCHAR(255),
    nr_cpf VARCHAR(14),
    nr_rg VARCHAR(14)
);

-- Tabela O_DIAGNOSTICO_PROFISSIONAL
CREATE TABLE O_DIAGNOSTICO_PROFISSIONAL (
    id_diagnostico NUMERIC,
    cfo NUMERIC,
    FOREIGN KEY (id_diagnostico) REFERENCES O_DIAGNOSTICO_SERVICO_IA(id_diagnostico),
    FOREIGN KEY (cfo) REFERENCES O_PROFISSIONAL(cfo)
);

CREATE TABLE O_PONTUACAO_RECOMPENSA (
    id_recompensa NUMERIC,
    id_conta NUMERIC,
    FOREIGN KEY (id_recompensa) REFERENCES O_RECOMPENSA(id_recompensa),
    FOREIGN KEY (id_conta) REFERENCES O_PONTUACAO(id_conta)
);


CREATE TABLE O_CIDADE_CLIENTE (
    id_cidade NUMERIC PRIMARY KEY,
    nm_cidade VARCHAR(255)
);


CREATE TABLE O_BAIRRO_CLIENTE (
    id_bairro_cliente NUMERIC PRIMARY KEY,
    nm_bairro VARCHAR(255),
    id_cidade NUMERIC,
    FOREIGN KEY (id_cidade) REFERENCES O_CIDADE_CLIENTE(id_cidade)
);


CREATE TABLE O_ENDERECO_CLIENTE (
    id_endereco NUMERIC PRIMARY KEY,
    nr_logradouro VARCHAR(255),
    ds_complemento_nro VARCHAR(255),
    ds_ponto_referencia VARCHAR(255),
    id_bairro_cliente NUMERIC,
    id_cliente NUMERIC,
    FOREIGN KEY (id_bairro_cliente) REFERENCES O_BAIRRO_CLIENTE(id_bairro_cliente),
    FOREIGN KEY (id_cliente) REFERENCES O_CLIENTE(id_cliente)
);












