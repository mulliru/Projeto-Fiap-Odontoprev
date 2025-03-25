CREATE OR REPLACE PROCEDURE inserir_o_bairro_cliente (
    p_id_bairro_cliente IN NUMBER,
    p_nm_bairro IN VARCHAR2,
    p_id_cidade IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Adiciona os valores obrigatórios na lista
    v_valores_obrigatorios.EXTEND(3); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_bairro_cliente);
    v_valores_obrigatorios(2) := p_nm_bairro;
    v_valores_obrigatorios(3) := TO_CHAR(p_id_cidade);

    -- Verifica se há valores nulos
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_BAIRRO_CLIENTE (ID_BAIRRO_CLIENTE, NM_BAIRRO, ID_CIDADE)
        VALUES (p_id_bairro_cliente, p_nm_bairro, p_id_cidade);

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_bairro_cliente (
    p_id_bairro_cliente IN NUMBER,
    p_nm_bairro IN VARCHAR2,
    p_id_cidade IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Adiciona os valores obrigatórios na lista
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := p_nm_bairro;
    v_valores_obrigatorios(2) := TO_CHAR(p_id_cidade);

    -- Verifica se há valores nulos
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_BAIRRO_CLIENTE
        SET NM_BAIRRO = p_nm_bairro,
            ID_CIDADE = p_id_cidade
        WHERE ID_BAIRRO_CLIENTE = p_id_bairro_cliente;

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

 
 -------------------------------------------------------------------------------
 
CREATE OR REPLACE PROCEDURE ler_o_bairro_cliente (
    p_id_bairro_cliente IN NUMBER,
    p_nm_bairro OUT VARCHAR2,
    p_id_cidade OUT NUMBER
) IS
BEGIN
    SELECT NM_BAIRRO, ID_CIDADE
    INTO p_nm_bairro, p_id_cidade
    FROM O_BAIRRO_CLIENTE
    WHERE ID_BAIRRO_CLIENTE = p_id_bairro_cliente;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nm_bairro := NULL;
        p_id_cidade := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/


--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_bairro_cliente (
    p_id_bairro_cliente IN NUMBER
) IS
BEGIN
    DELETE FROM O_BAIRRO_CLIENTE
    WHERE ID_BAIRRO_CLIENTE = p_id_bairro_cliente;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------

