-- Trigger Auditoria - O_CLIENTE
CREATE OR REPLACE TRIGGER TRG_AUDITORIA_Odontoprev
AFTER INSERT OR UPDATE OR DELETE ON O_CLIENTE
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
    v_dados_anteriores CLOB;
BEGIN
    -- Definir operação
    IF INSERTING THEN
        v_operacao := 'INSERT';
        v_dados_anteriores := 'Novo Cliente: ' || :NEW.id_cliente || ', Nome: ' || :NEW.nm_cliente;
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
        v_dados_anteriores := 'Antes -> ID: ' || :OLD.id_cliente || ', Nome: ' || :OLD.nm_cliente || 
                              ' | Depois -> ID: ' || :NEW.id_cliente || ', Nome: ' || :NEW.nm_cliente;
    ELSIF DELETING THEN
        v_operacao := 'DELETE';
        v_dados_anteriores := 'Removido -> ID: ' || :OLD.id_cliente || ', Nome: ' || :OLD.nm_cliente;
    END IF;

    -- Inserir na tabela de auditoria
    INSERT INTO AUDITORIA_LOG (tabela_afetada, operacao, usuario, dados_anteriores)
    VALUES ('O_CLIENTE', v_operacao, USER, v_dados_anteriores);
END;
/

-----------------------------------------------------------------------------------------------------------

-- Trigger Auditoria - O_ENDERECO_CLIENTE
CREATE OR REPLACE TRIGGER TRG_AUDITORIA_ENDERECO_CLIENTE
AFTER INSERT OR UPDATE OR DELETE ON O_ENDERECO_CLIENTE
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
    v_dados_anteriores CLOB;
BEGIN
    -- Definir operação
    IF INSERTING THEN
        v_operacao := 'INSERT';
        v_dados_anteriores := 'Novo Endereço: ' || :NEW.id_endereco || ', Logradouro: ' || :NEW.NR_LOGRADOURO || 
                              ', Complemento: ' || :NEW.DS_COMPLEMENTO_NRO || ', Ponto de Referência: ' || :NEW.DS_PONTO_REFERENCIA ||
                              ', Bairro: ' || :NEW.ID_BAIRRO_CLIENTE || ', Cliente ID: ' || :NEW.ID_CLIENTE;
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
        v_dados_anteriores := 'Antes -> ID: ' || :OLD.id_endereco || ', Logradouro: ' || :OLD.NR_LOGRADOURO || 
                              ' | Depois -> ID: ' || :NEW.id_endereco || ', Logradouro: ' || :NEW.NR_LOGRADOURO;
    ELSIF DELETING THEN
        v_operacao := 'DELETE';
        v_dados_anteriores := 'Removido -> ID: ' || :OLD.id_endereco || ', Logradouro: ' || :OLD.NR_LOGRADOURO;
    END IF;

    -- Inserir na tabela de auditoria com sequência para ID_LOG
    INSERT INTO AUDITORIA_LOG_ENDERECO (ID_LOG, tabela_afetada, operacao, usuario, dados_anteriores)
    VALUES (SEQ_AUDITORIA_LOG_ENDERECO.NEXTVAL, 'O_ENDERECO_CLIENTE', v_operacao, USER, v_dados_anteriores);
END;

--------------------------------------------------------------------------------------------------
-- Trigger Auditoria - O_PROFISSIONAL

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_PROFISSIONAL
AFTER INSERT OR UPDATE OR DELETE ON O_PROFISSIONAL
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
    v_dados_anteriores CLOB;
BEGIN
    -- Definir operação
    IF INSERTING THEN
        v_operacao := 'INSERT';
        v_dados_anteriores := 'Novo Profissional: ' || :NEW.CFO || ', Nome: ' || :NEW.NM_PROFISSIONAL || 
                              ', CPF: ' || :NEW.NR_CPF || ', RG: ' || :NEW.NR_RG;
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
        v_dados_anteriores := 'Antes -> CFO: ' || :OLD.CFO || ', Nome: ' || :OLD.NM_PROFISSIONAL || 
                              ' | Depois -> CFO: ' || :NEW.CFO || ', Nome: ' || :NEW.NM_PROFISSIONAL;
    ELSIF DELETING THEN
        v_operacao := 'DELETE';
        v_dados_anteriores := 'Removido -> CFO: ' || :OLD.CFO || ', Nome: ' || :OLD.NM_PROFISSIONAL;
    END IF;

    -- Inserir na tabela de auditoria
    INSERT INTO AUDITORIA_LOG_PROFISSIONAL (tabela_afetada, operacao, usuario, dados_anteriores)
    VALUES ('O_PROFISSIONAL', v_operacao, USER, v_dados_anteriores);
END;
/

--------------------------------------------------------------------------------
-- TESTES DO INSERT, UPDATE E DELETE

INSERT INTO O_CLIENTE (id_cliente, nm_cliente) VALUES (31, 'João Silva');
UPDATE O_CLIENTE SET nm_cliente = 'João Pedro Silva' WHERE id_cliente = 31;
DELETE FROM O_CLIENTE WHERE id_cliente = 1;


INSERT INTO O_ENDERECO_CLIENTE (id_endereco, ds_complemento_nro) VALUES (31, 'Enderço teste');
UPDATE O_ENDERECO_CLIENTE SET ds_complemento_nro = 'Enderço teste' WHERE id_endereco = 31;
DELETE from O_ENDERECO_CLIENTE  WHERE id_endereco = 31;

INSERT INTO O_PROFISSIONAL (cfo, nm_profissional) VALUES (3131, 'Dr João Manuel');
UPDATE O_PROFISSIONAL SET nm_profissional = 'Dr. João Manuel' WHERE cfo = 3131;
DELETE from O_PROFISSIONAL  WHERE cfo = 3131;

DELETE FROM O_ENDERECO_CLIENTE
WHERE id_endereco = 31;

--------------------------------------------------------------------------------
-- LOG DO TRIGGER

SELECT * FROM AUDITORIA_LOG ORDER BY operacao DESC;
SELECT * FROM auditoria_log_endereco ORDER BY ID_LOG DESC;
SELECT * FROM auditoria_log_profissional ORDER BY ID_LOG DESC;


