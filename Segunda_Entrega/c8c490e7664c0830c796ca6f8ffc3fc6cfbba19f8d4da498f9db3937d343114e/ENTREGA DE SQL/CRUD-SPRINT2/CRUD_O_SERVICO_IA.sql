CREATE OR REPLACE PROCEDURE inserir_o_servico_ia (
    p_id_servico_ia IN NUMBER,
    p_dt_inicio IN DATE,
    p_dt_final IN DATE,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_servico_ia);
    v_valores_obrigatorios(2) := TO_CHAR(p_id_cliente);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_SERVICO_IA (ID_SERVICO_IA, DT_INICIO, DT_FINAL, ID_CLIENTE)
        VALUES (p_id_servico_ia, p_dt_inicio, p_dt_final, p_id_cliente);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_servico_ia (
    p_id_servico_ia IN NUMBER,
    p_dt_inicio IN DATE,
    p_dt_final IN DATE,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(1); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_servico_ia);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_SERVICO_IA
        SET DT_INICIO = p_dt_inicio,
            DT_FINAL = p_dt_final,
            ID_CLIENTE = p_id_cliente
        WHERE ID_SERVICO_IA = p_id_servico_ia;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ler_o_servico_ia (
    p_id_servico_ia IN NUMBER,
    p_dt_inicio OUT DATE,
    p_dt_final OUT DATE,
    p_id_cliente OUT NUMBER
) IS
BEGIN
    SELECT DT_INICIO, DT_FINAL, ID_CLIENTE
    INTO p_dt_inicio, p_dt_final, p_id_cliente
    FROM O_SERVICO_IA
    WHERE ID_SERVICO_IA = p_id_servico_ia;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_dt_inicio := NULL;
        p_dt_final := NULL;
        p_id_cliente := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/


--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_servico_ia (
    p_id_servico_ia IN NUMBER
) IS
BEGIN
    DELETE FROM O_SERVICO_IA
    WHERE ID_SERVICO_IA = p_id_servico_ia;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


