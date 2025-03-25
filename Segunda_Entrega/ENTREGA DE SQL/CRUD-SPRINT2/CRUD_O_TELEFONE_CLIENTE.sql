CREATE OR REPLACE PROCEDURE inserir_o_telefone_cliente (
    p_id_telefone IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER,
    p_tp_telefone IN VARCHAR2,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_telefone);
    v_valores_obrigatorios(2) := TO_CHAR(p_id_cliente);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_TELEFONE_CLIENTE (ID_TELEFONE, NR_DDD, NR_TELEFONE, TP_TELEFONE, ID_CLIENTE)
        VALUES (p_id_telefone, p_nr_ddd, p_nr_telefone, p_tp_telefone, p_id_cliente);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_telefone_cliente (
    p_id_telefone IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER,
    p_tp_telefone IN VARCHAR2,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(1); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_telefone);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_TELEFONE_CLIENTE
        SET NR_DDD = p_nr_ddd,
            NR_TELEFONE = p_nr_telefone,
            TP_TELEFONE = p_tp_telefone,
            ID_CLIENTE = p_id_cliente
        WHERE ID_TELEFONE = p_id_telefone;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ler_o_telefone_cliente (
    p_id_telefone IN NUMBER,
    p_nr_ddd OUT NUMBER,
    p_nr_telefone OUT NUMBER,
    p_tp_telefone OUT VARCHAR2,
    p_id_cliente OUT NUMBER
) IS
BEGIN
    SELECT NR_DDD, NR_TELEFONE, TP_TELEFONE, ID_CLIENTE
    INTO p_nr_ddd, p_nr_telefone, p_tp_telefone, p_id_cliente
    FROM O_TELEFONE_CLIENTE
    WHERE ID_TELEFONE = p_id_telefone;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nr_ddd := NULL;
        p_nr_telefone := NULL;
        p_tp_telefone := NULL;
        p_id_cliente := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/


--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE excluir_o_telefone_cliente (
    p_id_telefone IN NUMBER
) IS
BEGIN
    DELETE FROM O_TELEFONE_CLIENTE
    WHERE ID_TELEFONE = p_id_telefone;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


