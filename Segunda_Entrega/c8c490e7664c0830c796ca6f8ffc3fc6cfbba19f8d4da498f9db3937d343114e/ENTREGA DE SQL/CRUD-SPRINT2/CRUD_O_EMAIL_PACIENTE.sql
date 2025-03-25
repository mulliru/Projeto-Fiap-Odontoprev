CREATE OR REPLACE PROCEDURE inserir_o_email_paciente (
    p_id_email IN NUMBER,
    p_tp_email IN VARCHAR2,
    p_st_email IN VARCHAR2,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(2); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_email);
    v_valores_obrigatorios(2) := TO_CHAR(p_id_cliente);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_EMAIL_PACIENTE (ID_EMAIL, TP_EMAIL, ST_EMAIL, ID_CLIENTE)
        VALUES (p_id_email, p_tp_email, p_st_email, p_id_cliente);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_email_paciente (
    p_id_email IN NUMBER,
    p_tp_email IN VARCHAR2,
    p_st_email IN VARCHAR2,
    p_id_cliente IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(1); 
    v_valores_obrigatorios(1) := TO_CHAR(p_id_email);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_EMAIL_PACIENTE
        SET TP_EMAIL = p_tp_email,
            ST_EMAIL = p_st_email,
            ID_CLIENTE = p_id_cliente
        WHERE ID_EMAIL = p_id_email;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ler_o_email_paciente (
    p_id_email IN NUMBER,
    p_tp_email OUT VARCHAR2,
    p_st_email OUT VARCHAR2,
    p_id_cliente OUT NUMBER
) IS
BEGIN
    SELECT TP_EMAIL, ST_EMAIL, ID_CLIENTE
    INTO p_tp_email, p_st_email, p_id_cliente
    FROM O_EMAIL_PACIENTE
    WHERE ID_EMAIL = p_id_email;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_tp_email := NULL;
        p_st_email := NULL;
        p_id_cliente := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_email_paciente (
    p_id_email IN NUMBER
) IS
BEGIN
    DELETE FROM O_EMAIL_PACIENTE
    WHERE ID_EMAIL = p_id_email;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


