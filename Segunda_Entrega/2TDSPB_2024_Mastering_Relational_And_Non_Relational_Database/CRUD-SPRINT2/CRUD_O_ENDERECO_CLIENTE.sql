CREATE OR REPLACE PROCEDURE inserir_o_endereco_cliente (
    p_id_endereco IN NUMBER,
    p_nr_logradouro IN VARCHAR2,
    p_ds_complemento_nro IN VARCHAR2,
    p_ds_ponto_referencia IN VARCHAR2,
    p_id_bairro_cliente IN NUMBER,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Adiciona os valores obrigatórios na lista
    v_valores_obrigatorios.EXTEND(5); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_endereco);
    v_valores_obrigatorios(2) := p_nr_logradouro;
    v_valores_obrigatorios(3) := p_ds_complemento_nro;
    v_valores_obrigatorios(4) := p_ds_ponto_referencia;
    v_valores_obrigatorios(5) := TO_CHAR(p_id_bairro_cliente);

    -- Verifica se há valores nulos
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_ENDERECO_CLIENTE (ID_ENDERECO, NR_LOGRADOURO, DS_COMPLEMENTO_NRO, DS_PONTO_REFERENCIA, ID_BAIRRO_CLIENTE, ID_CLIENTE)
        VALUES (p_id_endereco, p_nr_logradouro, p_ds_complemento_nro, p_ds_ponto_referencia, p_id_bairro_cliente, p_id_cliente);

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE atualizar_o_endereco_cliente (
    p_id_endereco IN NUMBER,
    p_nr_logradouro IN VARCHAR2,
    p_ds_complemento_nro IN VARCHAR2,
    p_ds_ponto_referencia IN VARCHAR2,
    p_id_bairro_cliente IN NUMBER,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Adiciona os valores obrigatórios na lista
    v_valores_obrigatorios.EXTEND(4); 
    v_valores_obrigatorios(1) := p_nr_logradouro;
    v_valores_obrigatorios(2) := p_ds_complemento_nro;
    v_valores_obrigatorios(3) := p_ds_ponto_referencia;
    v_valores_obrigatorios(4) := TO_CHAR(p_id_bairro_cliente);

    -- Verifica se há valores nulos
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_ENDERECO_CLIENTE
        SET NR_LOGRADOURO = p_nr_logradouro,
            DS_COMPLEMENTO_NRO = p_ds_complemento_nro,
            DS_PONTO_REFERENCIA = p_ds_ponto_referencia,
            ID_BAIRRO_CLIENTE = p_id_bairro_cliente,
            ID_CLIENTE = p_id_cliente
        WHERE ID_ENDERECO = p_id_endereco;

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ler_o_endereco_cliente (
    p_id_endereco IN NUMBER,
    p_nr_logradouro OUT VARCHAR2,
    p_ds_complemento_nro OUT VARCHAR2,
    p_ds_ponto_referencia OUT VARCHAR2,
    p_id_bairro_cliente OUT NUMBER,
    p_id_cliente OUT NUMBER
) IS
BEGIN
    SELECT NR_LOGRADOURO, DS_COMPLEMENTO_NRO, DS_PONTO_REFERENCIA, ID_BAIRRO_CLIENTE, ID_CLIENTE
    INTO p_nr_logradouro, p_ds_complemento_nro, p_ds_ponto_referencia, p_id_bairro_cliente, p_id_cliente
    FROM O_ENDERECO_CLIENTE
    WHERE ID_ENDERECO = p_id_endereco;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nr_logradouro := NULL;
        p_ds_complemento_nro := NULL;
        p_ds_ponto_referencia := NULL;
        p_id_bairro_cliente := NULL;
        p_id_cliente := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE excluir_o_endereco_cliente (
    p_id_endereco IN NUMBER
) IS
BEGIN
    DELETE FROM O_ENDERECO_CLIENTE
    WHERE ID_ENDERECO = p_id_endereco;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
