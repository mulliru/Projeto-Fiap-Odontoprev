SET SERVEROUTPUT ON

-- PL/SQL usando o INNER JOIN com GROUP BY e ORDER BY
BEGIN
    FOR r IN (
        SELECT 
            c.id_cliente,
            c.nm_cliente,
            COUNT(s.id_servico_ia) AS total_servicos
        FROM 
            O_CLIENTE c
        INNER JOIN 
            O_SERVICO_IA s ON c.id_cliente = s.id_cliente
        GROUP BY 
            c.id_cliente, c.nm_cliente
        ORDER BY 
            total_servicos DESC  
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || r.id_cliente || 
                             ', Nome: ' || r.nm_cliente || 
                             ', Total de Serviços: ' || r.total_servicos);
    END LOOP;
END;
/


--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

-- PL/SQL usando o LEFT JOIN com GROUP BY e ORDER BY
BEGIN
    FOR r IN (
        SELECT 
            c.id_cliente,
            c.nm_cliente,
            SUM(NVL(p.qnt_pontos, 0)) AS total_pontos
        FROM 
            O_CLIENTE c
        LEFT JOIN 
            O_PONTUACAO p ON c.id_cliente = p.id_conta  
        GROUP BY 
            c.id_cliente, c.nm_cliente
        ORDER BY 
            total_pontos DESC 
    ) LOOP
        
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || r.id_cliente || 
                             ', Nome: ' || r.nm_cliente || 
                             ', Total de Pontos: ' || r.total_pontos);
    END LOOP;
END;
/


--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;


-- PL/SQL usando o RIGHT JOIN com GROUP BY e ORDER BY
BEGIN
    FOR r IN (
        SELECT 
            c.id_cliente,
            c.nm_cliente,
            COUNT(s.id_servico_ia) AS total_servicos,
            TO_CHAR(s.dt_inicio, 'DD/MM/YYYY') AS dt_inicio,  
            TO_CHAR(s.dt_final, 'DD/MM/YYYY') AS dt_final     
        FROM 
            O_SERVICO_IA s
        RIGHT JOIN 
            O_CLIENTE c ON s.id_cliente = c.id_cliente  
        GROUP BY 
            c.id_cliente, c.nm_cliente, s.dt_inicio, s.dt_final
        ORDER BY 
            total_servicos DESC  
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente ID: ' || NVL(TO_CHAR(r.id_cliente), 'Nenhum') || 
                             ', Nome: ' || NVL(r.nm_cliente, 'Nenhum') || 
                             ', Total de Serviços: ' || r.total_servicos || 
                             ', Data Início: ' || NVL(r.dt_inicio, 'Nenhuma') || 
                             ', Data Final: ' || NVL(r.dt_final, 'Nenhuma'));
    END LOOP;
END;
/


