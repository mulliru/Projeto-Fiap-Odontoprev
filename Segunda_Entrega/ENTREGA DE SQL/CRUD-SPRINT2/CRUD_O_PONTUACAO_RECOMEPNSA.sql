CREATE OR REPLACE PROCEDURE inserir_o_pontuacao_recompensa (
    p_id_recompensa IN NUMBER,
    p_id_conta IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(2);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_recompensa);
    v_valores_obrigatorios(2) := TO_CHAR(p_id_conta);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_PONTUACAO_RECOMPENSA (ID_RECOMPENSA, ID_CONTA)
        VALUES (p_id_recompensa, p_id_conta);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE atualizar_o_pontuacao_recompensa (
    p_id_recompensa IN NUMBER,
    p_id_conta IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(2);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_recompensa);
    v_valores_obrigatorios(2) := TO_CHAR(p_id_conta);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_PONTUACAO_RECOMPENSA
        SET ID_CONTA = p_id_conta
        WHERE ID_RECOMPENSA = p_id_recompensa;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE ler_o_pontuacao_recompensa (
    p_id_recompensa IN NUMBER,
    p_id_conta OUT NUMBER
) IS
BEGIN
    SELECT ID_CONTA
    INTO p_id_conta
    FROM O_PONTUACAO_RECOMPENSA
    WHERE ID_RECOMPENSA = p_id_recompensa;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_id_conta := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE excluir_o_pontuacao_recompensa (
    p_id_recompensa IN NUMBER
) IS
BEGIN
    DELETE FROM O_PONTUACAO_RECOMPENSA
    WHERE ID_RECOMPENSA = p_id_recompensa;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
