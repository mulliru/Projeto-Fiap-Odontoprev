--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE inserir_o_profissional (
    p_cfo IN NUMBER,
    p_nm_profissional IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nr_rg IN VARCHAR2
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Validação dos campos obrigatórios
    v_valores_obrigatorios.EXTEND(1);
    v_valores_obrigatorios(1) := TO_CHAR(p_cfo);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_PROFISSIONAL (CFO, NM_PROFISSIONAL, NR_CPF, NR_RG)
        VALUES (p_cfo, p_nm_profissional, p_nr_cpf, p_nr_rg);
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE atualizar_o_profissional (
    p_cfo IN NUMBER,
    p_nm_profissional IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nr_rg IN VARCHAR2
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    -- Validação do campo obrigatório
    v_valores_obrigatorios.EXTEND(1);
    v_valores_obrigatorios(1) := TO_CHAR(p_cfo);

    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_PROFISSIONAL
        SET NM_PROFISSIONAL = p_nm_profissional,
            NR_CPF = p_nr_cpf,
            NR_RG = p_nr_rg
        WHERE CFO = p_cfo;
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ler_o_profissional (
    p_cfo IN NUMBER,
    p_nm_profissional OUT VARCHAR2,
    p_nr_cpf OUT VARCHAR2,
    p_nr_rg OUT VARCHAR2
) IS
BEGIN
    SELECT NM_PROFISSIONAL, NR_CPF, NR_RG
    INTO p_nm_profissional, p_nr_cpf, p_nr_rg
    FROM O_PROFISSIONAL
    WHERE CFO = p_cfo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nm_profissional := NULL;
        p_nr_cpf := NULL;
        p_nr_rg := NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE excluir_o_profissional (
    p_cfo IN NUMBER
) IS
BEGIN
    DELETE FROM O_PROFISSIONAL
    WHERE CFO = p_cfo;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
