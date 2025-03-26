SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE BODY PKG_RELATORIOS AS 

    -- Relatório de Clientes e Endereços
    PROCEDURE PRC_RELATORIO_CLIENTES_ENDERECOS IS 
        CURSOR c_clientes IS 
            SELECT 
                c.ID_CLIENTE, 
                c.NM_CLIENTE, 
                c.NR_CPF, 
                c.NR_RG, 
                c.DT_NASC, 
                c.FL_SEXO,
                e.ID_ENDERECO,
                e.NR_LOGRADOURO, 
                e.DS_COMPLEMENTO_NRO, 
                e.DS_PONTO_REFERENCIA,
                e.ID_BAIRRO_CLIENTE
            FROM O_CLIENTE c
            LEFT JOIN O_ENDERECO_CLIENTE e 
                ON c.ID_CLIENTE = e.ID_CLIENTE
            ORDER BY c.NM_CLIENTE;

        v_cliente c_clientes%ROWTYPE;
    BEGIN 
        OPEN c_clientes;
        LOOP
            FETCH c_clientes INTO v_cliente;
            EXIT WHEN c_clientes%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_cliente.NM_CLIENTE || 
                                 ' | CPF: ' || v_cliente.NR_CPF || 
                                 ' | RG: ' || v_cliente.NR_RG || 
                                 ' | Nascimento: ' || TO_CHAR(v_cliente.DT_NASC, 'DD/MM/YYYY') || 
                                 ' | Sexo: ' || v_cliente.FL_SEXO || 
                                 ' | Endereço ID: ' || NVL(TO_CHAR(v_cliente.ID_ENDERECO), 'N/A') || 
                                 ' | Logradouro: ' || NVL(v_cliente.NR_LOGRADOURO, 'N/A') || 
                                 ' | Complemento: ' || NVL(v_cliente.DS_COMPLEMENTO_NRO, 'N/A') || 
                                 ' | Ponto de Referência: ' || NVL(v_cliente.DS_PONTO_REFERENCIA, 'N/A') || 
                                 ' | Bairro ID: ' || NVL(TO_CHAR(v_cliente.ID_BAIRRO_CLIENTE), 'N/A'));
        END LOOP;
        
        CLOSE c_clientes;
    END PRC_RELATORIO_CLIENTES_ENDERECOS;

    -- Relatório de Serviços e Recompensas
    PROCEDURE PRC_RELATORIO_SERVICOS_RECOMPENSAS IS 
        CURSOR c_servicos IS 
            SELECT 
                s.ID_SERVICO_IA,
                s.DT_INICIO, 
                s.DT_FINAL, 
                s.ID_CLIENTE, 
                r.ID_RECOMPENSA,
                r.NM_PRODUTO, 
                r.DESC_PRODUTO, 
                r.PRECO_PRODUTO
            FROM O_SERVICO_IA s
            LEFT JOIN O_RECOMPENSA r 
                ON s.ID_CLIENTE = (SELECT ID_CLIENTE FROM O_CLIENTE c WHERE c.ID_CLIENTE = s.ID_CLIENTE)
            ORDER BY s.DT_INICIO DESC;

        v_servico c_servicos%ROWTYPE;
    BEGIN 
        OPEN c_servicos;
        LOOP
            FETCH c_servicos INTO v_servico;
            EXIT WHEN c_servicos%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Serviço ID: ' || v_servico.ID_SERVICO_IA || 
                                 ' | Cliente ID: ' || v_servico.ID_CLIENTE || 
                                 ' | Início: ' || TO_CHAR(v_servico.DT_INICIO, 'DD/MM/YYYY') || 
                                 ' | Fim: ' || TO_CHAR(v_servico.DT_FINAL, 'DD/MM/YYYY') || 
                                 ' | Recompensa: ' || NVL(v_servico.NM_PRODUTO, 'Nenhuma') || 
                                 ' | Descrição: ' || NVL(v_servico.DESC_PRODUTO, 'N/A') || 
                                 ' | Preço: R$ ' || NVL(TO_CHAR(v_servico.PRECO_PRODUTO, '9999.99'), '0.00'));
        END LOOP;
        
        CLOSE c_servicos;
    END PRC_RELATORIO_SERVICOS_RECOMPENSAS;

END PKG_RELATORIOS;
/


-- Executando os relatórios
BEGIN
    PKG_RELATORIOS.PRC_RELATORIO_CLIENTES_ENDERECOS;
END;
/

BEGIN
    PKG_RELATORIOS.PRC_RELATORIO_SERVICOS_RECOMPENSAS;
END;
/