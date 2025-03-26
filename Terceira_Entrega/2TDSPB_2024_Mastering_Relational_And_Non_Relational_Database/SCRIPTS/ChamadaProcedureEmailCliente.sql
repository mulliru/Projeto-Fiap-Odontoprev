-- Criação do Pacote (Package Specification)
CREATE OR REPLACE PACKAGE pkg_email_paciente AS
    -- Procedure para inserir um novo email do paciente
    PROCEDURE inserir_o_email_paciente(
        p_id_email IN NUMBER,
        p_tp_email IN VARCHAR2,
        p_st_email IN VARCHAR2,
        p_id_cliente IN NUMBER
    );

    -- Procedure para atualizar um email do paciente
    PROCEDURE atualizar_o_email_paciente(
        p_id_email IN NUMBER,
        p_tp_email IN VARCHAR2,
        p_st_email IN VARCHAR2,
        p_id_cliente IN NUMBER
    );

    -- Procedure para ler os dados de um email do paciente
    PROCEDURE ler_o_email_paciente(
        p_id_email IN NUMBER,
        p_tp_email OUT VARCHAR2,
        p_st_email OUT VARCHAR2,
        p_id_cliente OUT NUMBER
    );

    -- Procedure para excluir um email do paciente
    PROCEDURE excluir_o_email_paciente(
        p_id_email IN NUMBER
    );
END pkg_email_paciente;
/

-- Criação do Corpo do Pacote (Package Body)
CREATE OR REPLACE PACKAGE BODY pkg_email_paciente AS
    -- Implementação da procedure para inserir um novo email do paciente
    PROCEDURE inserir_o_email_paciente(
        p_id_email IN NUMBER,
        p_tp_email IN VARCHAR2,
        p_st_email IN VARCHAR2,
        p_id_cliente IN NUMBER
    ) IS
    BEGIN
        INSERT INTO O_EMAIL_PACIENTE (ID_EMAIL, TP_EMAIL, ST_EMAIL, ID_CLIENTE)
        VALUES (p_id_email, p_tp_email, p_st_email, p_id_cliente);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Email do paciente inserido com sucesso.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao inserir email do paciente: ' || SQLERRM);
            ROLLBACK;
    END inserir_o_email_paciente;

    -- Implementação da procedure para atualizar um email do paciente
    PROCEDURE atualizar_o_email_paciente(
        p_id_email IN NUMBER,
        p_tp_email IN VARCHAR2,
        p_st_email IN VARCHAR2,
        p_id_cliente IN NUMBER
    ) IS
    BEGIN
        UPDATE O_EMAIL_PACIENTE
        SET TP_EMAIL = p_tp_email,
            ST_EMAIL = p_st_email,
            ID_CLIENTE = p_id_cliente
        WHERE ID_EMAIL = p_id_email;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Email do paciente atualizado com sucesso.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao atualizar email do paciente: ' || SQLERRM);
            ROLLBACK;
    END atualizar_o_email_paciente;

    -- Implementação da procedure para ler os dados de um email do paciente
    PROCEDURE ler_o_email_paciente(
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
            DBMS_OUTPUT.PUT_LINE('Email do paciente não encontrado.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao ler email do paciente: ' || SQLERRM);
    END ler_o_email_paciente;

    -- Implementação da procedure para excluir um email do paciente
    PROCEDURE excluir_o_email_paciente(
        p_id_email IN NUMBER
    ) IS
    BEGIN
        DELETE FROM O_EMAIL_PACIENTE
        WHERE ID_EMAIL = p_id_email;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Email do paciente excluído com sucesso.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao excluir email do paciente: ' || SQLERRM);
            ROLLBACK;
    END excluir_o_email_paciente;
END pkg_email_paciente;
/


SET SERVEROUTPU ON;
-- INSERT
BEGIN
    pkg_email_paciente.inserir_o_email_paciente(44, 'Pessoal', 'Ativo', 3);
END;

-- ATUALIZAR
BEGIN
    pkg_email_paciente.atualizar_o_email_paciente(44, 'Trabalho', 'Inativo', 3);
END;

-- LEITURA
DECLARE
    v_tp_email VARCHAR2(50);
    v_st_email VARCHAR2(50);
    v_id_cliente NUMBER;
BEGIN
    pkg_email_paciente.ler_o_email_paciente(44, v_tp_email, v_st_email, v_id_cliente);
    DBMS_OUTPUT.PUT_LINE('Tipo de Email: ' || v_tp_email);
    DBMS_OUTPUT.PUT_LINE('Status do Email: ' || v_st_email);
    DBMS_OUTPUT.PUT_LINE('ID do Cliente: ' || v_id_cliente);
END;

-- DELETE
BEGIN
    pkg_email_paciente.excluir_o_email_paciente(44);
END;

SELECT * FROM O_EMAIL_PACIENTE WHERE ID_EMAIL = 2;