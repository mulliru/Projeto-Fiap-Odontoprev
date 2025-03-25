CREATE OR REPLACE FUNCTION verificar_nulos (
    p_args SYS.ODCIVARCHAR2LIST
) RETURN VARCHAR2 IS
    v_index PLS_INTEGER;
BEGIN
    FOR v_index IN 1 .. p_args.COUNT LOOP
        IF p_args(v_index) IS NULL THEN
            RETURN 'Entrada obrigatória no índice ' || v_index || ' é NULL';
        END IF;
    END LOOP;

    RETURN 'Todas entradas não são nulas';
END;
/


--------------------------------------------------------------------------------
-- INSERT
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE inserir_no_cliente (
    p_id_cliente IN VARCHAR2,
    p_nm_cliente IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nr_rg IN VARCHAR2,
    p_dt_nasc IN DATE,
    p_fl_sexo IN CHAR
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
BEGIN
    
    v_valores_obrigatorios.EXTEND(3);
    v_valores_obrigatorios(1) := p_nm_cliente;
    v_valores_obrigatorios(2) := p_nr_cpf;
    v_valores_obrigatorios(3) := TO_CHAR(p_dt_nasc, 'YYYY-MM-DD'); 

    
    v_mensagem_validacao := verificar_nulos(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        INSERT INTO O_CLIENTE (ID_CLIENTE,NM_CLIENTE, NR_CPF, NR_RG, DT_NASC, FL_SEXO)
        VALUES (p_id_cliente, p_nm_cliente, p_nr_cpf, p_nr_rg, p_dt_nasc, p_fl_sexo);

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
-- UPDATE
CREATE OR REPLACE PROCEDURE atualizar_o_cliente (
    p_id_cliente NUMBER ,
    p_nm_cliente IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nr_rg IN VARCHAR2,
    p_dt_nasc IN DATE,
    p_fl_sexo IN CHAR
) IS
    v_mensagem_validacao VARCHAR2(100);
    v_valores_obrigatorios SYS.DBMS_DEBUG_VC2COLL := SYS.DBMS_DEBUG_VC2COLL();
BEGIN
    v_valores_obrigatorios.EXTEND(3);
    v_valores_obrigatorios(1) := p_nm_cliente;
    v_valores_obrigatorios(2) := p_nr_cpf;
    v_valores_obrigatorios(3) := TO_CHAR(p_dt_nasc, 'YYYY-MM-DD');

    v_mensagem_validacao := verify_not_null(v_valores_obrigatorios);

    IF v_mensagem_validacao != 'Todas entradas não são nulas' THEN
        RAISE_APPLICATION_ERROR(-20001, v_mensagem_validacao);
    ELSE
        UPDATE O_CLIENTE
        SET NM_CLIENTE = p_nm_cliente,
            NR_CPF = p_nr_cpf,
            NR_RG = p_nr_rg,
            DT_NASC = p_dt_nasc,
            FL_SEXO = p_fl_sexo
        WHERE ID_CLIENTE = p_id_cliente;

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
-- DELETE
CREATE OR REPLACE PROCEDURE excluir_o_cliente (
    p_id_cliente IN NUMBER
) IS
BEGIN
    DELETE FROM O_CLIENTE WHERE ID_CLIENTE = p_id_cliente;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--------------------------------------------------------------------------------
-- READ
CREATE OR REPLACE PROCEDURE ler_o_cliente (
    p_id_cliente IN NUMBER,
    p_nm_cliente OUT VARCHAR2,
    p_nr_cpf OUT VARCHAR2,
    p_nr_rg OUT VARCHAR2,
    p_dt_nasc OUT DATE,
    p_fl_sexo OUT CHAR
) IS
BEGIN
    SELECT NM_CLIENTE, NR_CPF, NR_RG, DT_NASC, FL_SEXO
    INTO p_nm_cliente, p_nr_cpf, p_nr_rg, p_dt_nasc, p_fl_sexo
    FROM O_CLIENTE
    WHERE ID_CLIENTE = p_id_cliente;
END;
/
--------------------------------------------------------------------------------

-- CURSOR
CREATE OR REPLACE PROCEDURE listar_clientes IS
    CURSOR c_clientes IS
        SELECT ID_CLIENTE, NM_CLIENTE, NR_CPF, NR_RG, DT_NASC, FL_SEXO
        FROM O_CLIENTE;
    v_id_cliente O_CLIENTE.ID_CLIENTE%TYPE;
    v_nm_cliente O_CLIENTE.NM_CLIENTE%TYPE;
    v_nr_cpf O_CLIENTE.NR_CPF%TYPE;
    v_nr_rg O_CLIENTE.NR_RG%TYPE;
    v_dt_nasc O_CLIENTE.DT_NASC%TYPE;
    v_fl_sexo O_CLIENTE.FL_SEXO%TYPE;
BEGIN
    OPEN c_clientes;
    LOOP
        FETCH c_clientes INTO v_id_cliente, v_nm_cliente, v_nr_cpf, v_nr_rg, v_dt_nasc, v_fl_sexo;
        EXIT WHEN c_clientes%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID_CLIENTE: ' || v_id_cliente);
        DBMS_OUTPUT.PUT_LINE('NM_CLIENTE: ' || v_nm_cliente);
        DBMS_OUTPUT.PUT_LINE('NR_CPF: ' || v_nr_cpf);
        DBMS_OUTPUT.PUT_LINE('NR_RG: ' || v_nr_rg);
        DBMS_OUTPUT.PUT_LINE('DT_NASC: ' || TO_CHAR(v_dt_nasc, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('FL_SEXO: ' || v_fl_sexo);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    CLOSE c_clientes;
END;
/


--------------------------------------------------------------------------------
-- CHAMADA DO RELATORIO DE O_CLIENTE

DECLARE
    v_relatorio VARCHAR2(32767);
BEGIN
    v_relatorio := relatorio;
    DBMS_OUTPUT.PUT_LINE(v_relatorio);
END;
/
