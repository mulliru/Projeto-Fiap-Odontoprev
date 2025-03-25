CREATE OR REPLACE PROCEDURE inserir_o_estoque (
    p_id_estoque IN NUMBER,
    p_qnt_produto IN NUMBER,
    p_id_recompensa IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(1);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_estoque);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_ESTOQUE (ID_ESTOQUE, QNT_PRODUTO, ID_RECOMPENSA)
        VALUES (p_id_estoque, p_qnt_produto, p_id_recompensa);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_estoque (
    p_id_estoque IN NUMBER,
    p_qnt_produto IN NUMBER,
    p_id_recompensa IN NUMBER
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    v_valores_obrigatorios.EXTEND(1);
    v_valores_obrigatorios(1) := TO_CHAR(p_id_estoque);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_ESTOQUE
        SET QNT_PRODUTO = p_qnt_produto,
            ID_RECOMPENSA = p_id_recompensa
        WHERE ID_ESTOQUE = p_id_estoque;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ler_o_estoque (
    p_id_estoque IN NUMBER,
    p_qnt_produto OUT NUMBER,
    p_id_recompensa OUT NUMBER
) IS
BEGIN
    SELECT QNT_PRODUTO, ID_RECOMPENSA
    INTO p_qnt_produto, p_id_recompensa
    FROM O_ESTOQUE
    WHERE ID_ESTOQUE = p_id_estoque;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_qnt_produto := NULL;
        p_id_recompensa := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_estoque (
    p_id_estoque IN NUMBER
) IS
BEGIN
    DELETE FROM O_ESTOQUE
    WHERE ID_ESTOQUE = p_id_estoque;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
