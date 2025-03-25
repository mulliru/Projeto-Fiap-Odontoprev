--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE inserir_o_diagnostico_profissional (
    p_id_diagnostico IN NUMBER,
    p_cfo IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    
    v_valores_obrigatorios.EXTEND(2);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_diagnostico);
    v_valores_obrigatorios(2) := TO_CHAR(p_cfo);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_DIAGNOSTICO_PROFISSIONAL (ID_DIAGNOSTICO, CFO)
        VALUES (p_id_diagnostico, p_cfo);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_diagnostico_profissional (
    p_id_diagnostico IN NUMBER,
    p_cfo IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    
    v_valores_obrigatorios.EXTEND(1);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_diagnostico);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_DIAGNOSTICO_PROFISSIONAL
        SET CFO = p_cfo
        WHERE ID_DIAGNOSTICO = p_id_diagnostico;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ler_o_diagnostico_profissional (
    p_id_diagnostico IN NUMBER,
    p_cfo OUT NUMBER
) IS
BEGIN
    SELECT CFO
    INTO p_cfo
    FROM O_DIAGNOSTICO_PROFISSIONAL
    WHERE ID_DIAGNOSTICO = p_id_diagnostico;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_cfo := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_diagnostico_profissional (
    p_id_diagnostico IN NUMBER
) IS
BEGIN
    DELETE FROM O_DIAGNOSTICO_PROFISSIONAL
    WHERE ID_DIAGNOSTICO = p_id_diagnostico;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
