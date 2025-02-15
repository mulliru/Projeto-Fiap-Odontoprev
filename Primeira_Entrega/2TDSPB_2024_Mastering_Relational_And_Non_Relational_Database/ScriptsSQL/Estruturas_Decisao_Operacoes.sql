
--5. DOIS BLOCOS DE DECISAO SENDO UM UPDATE E OUTRO DE DELETE

SET SERVEROUTPUT ON;

DECLARE
    v_id_cliente NUMERIC := 1;  -- Aqui o id do cliente que queremos mudar
    v_novos_pontos NUMERIC := 1000;  -- Professor aqui se atribui os novos pontos do cliente
    v_qnt_pontos NUMERIC;
BEGIN
   
    SELECT NVL(SUM(qnt_pontos), 0) INTO v_qnt_pontos
    FROM O_PONTUACAO
    WHERE id_servico_ia IN (SELECT id_servico_ia FROM O_SERVICO_IA WHERE id_cliente = v_id_cliente);

    IF v_qnt_pontos > 0 THEN
       
        UPDATE O_PONTUACAO
        SET qnt_pontos = v_novos_pontos
        WHERE id_servico_ia IN (SELECT id_servico_ia FROM O_SERVICO_IA WHERE id_cliente = v_id_cliente);

        DBMS_OUTPUT.PUT_LINE('Pontos atualizados com sucesso para o Cliente ID: ' || v_id_cliente);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || v_id_cliente || ' não possui pontos registrados.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente encontrado com ID: ' || v_id_cliente);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

--------------------------------------------------------------------------------
--Exclusao
SET SERVEROUTPUT ON;

DECLARE
    v_id_cliente NUMERIC := 1;  
    v_existente NUMERIC;
BEGIN
    
    SELECT COUNT(*) INTO v_existente
    FROM O_SERVICO_IA
    WHERE id_cliente = v_id_cliente;

    IF v_existente = 0 THEN
        
        DELETE FROM O_CLIENTE
        WHERE id_cliente = v_id_cliente;

        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || v_id_cliente || ' excluído com sucesso.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || v_id_cliente || ' não pode ser excluído, pois possui serviços associados.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente encontrado com ID: ' || v_id_cliente);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/