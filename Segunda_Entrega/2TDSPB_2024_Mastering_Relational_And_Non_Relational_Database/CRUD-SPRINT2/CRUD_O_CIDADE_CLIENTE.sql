CREATE OR REPLACE PROCEDURE inserir_o_cidade_cliente (
    p_id_cidade IN NUMBER,
    p_nm_cidade IN VARCHAR2
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_cidade);
    v_valores_obrigatorios(2) := p_nm_cidade;

    
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_CIDADE_CLIENTE (ID_CIDADE, NM_CIDADE)
        VALUES (p_id_cidade, p_nm_cidade);

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_cidade_cliente (
    p_id_cidade IN NUMBER,
    p_nm_cidade IN VARCHAR2
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_cidade);
    v_valores_obrigatorios(2) := p_nm_cidade;

    
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_CIDADE_CLIENTE
        SET NM_CIDADE = p_nm_cidade
        WHERE ID_CIDADE = p_id_cidade;

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ler_o_cidade_cliente (
    p_id_cidade IN NUMBER,
    p_nm_cidade OUT VARCHAR2
) IS
BEGIN
    SELECT NM_CIDADE
    INTO p_nm_cidade
    FROM O_CIDADE_CLIENTE
    WHERE ID_CIDADE = p_id_cidade;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nm_cidade := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE excluir_o_cidade_cliente (
    p_id_cidade IN NUMBER
) IS
BEGIN
    DELETE FROM O_CIDADE_CLIENTE
    WHERE ID_CIDADE = p_id_cidade;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

