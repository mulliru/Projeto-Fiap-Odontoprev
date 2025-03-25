CREATE OR REPLACE FUNCTION relatorio RETURN VARCHAR2 IS
    v_total_clientes NUMBER;
    v_total_masculino NUMBER;
    v_total_feminino NUMBER;
    v_total_outros NUMBER;
    v_meses_nascimento SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
    v_qtde_por_mes SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
    v_relatorio CLOB := EMPTY_CLOB();
BEGIN
    
    v_meses_nascimento.EXTEND(12);
    v_qtde_por_mes.EXTEND(12);
    
    FOR i IN 1 .. 12 LOOP
        v_meses_nascimento(i) := TO_CHAR(ADD_MONTHS(DATE '2024-01-01', i-1), 'Month');
        v_qtde_por_mes(i) := 0;
    END LOOP;
    
    
    SELECT COUNT(*) INTO v_total_clientes FROM O_CLIENTE;
    
    
    SELECT COUNT(*) INTO v_total_masculino FROM O_CLIENTE WHERE FL_SEXO = 'M';
    SELECT COUNT(*) INTO v_total_feminino FROM O_CLIENTE WHERE FL_SEXO = 'F';
    SELECT COUNT(*) INTO v_total_outros FROM O_CLIENTE WHERE FL_SEXO NOT IN ('M', 'F');
    
    
    FOR rec IN (SELECT TO_CHAR(DT_NASC, 'MM') AS mes, COUNT(*) AS quantidade
                FROM O_CLIENTE
                GROUP BY TO_CHAR(DT_NASC, 'MM')
                ORDER BY TO_CHAR(DT_NASC, 'MM')) LOOP
        v_qtde_por_mes(TO_NUMBER(rec.mes)) := rec.quantidade;
    END LOOP;
    
   
    v_relatorio := 'Relatório de Clientes' || CHR(10) || '------------------------' || CHR(10);
    v_relatorio := v_relatorio || 'Total de Clientes: ' || v_total_clientes || CHR(10);
    v_relatorio := v_relatorio || 'Total de Clientes Masculinos: ' || v_total_masculino || CHR(10);
    v_relatorio := v_relatorio || 'Total de Clientes Femininos: ' || v_total_feminino || CHR(10);
    v_relatorio := v_relatorio || 'Total de Clientes Outros: ' || v_total_outros || CHR(10) || CHR(10);
    v_relatorio := v_relatorio || 'Clientes por Mês de Nascimento:' || CHR(10);
    
    FOR i IN 1 .. 12 LOOP
        v_relatorio := v_relatorio || v_meses_nascimento(i) || ': ' || v_qtde_por_mes(i) || CHR(10);
    END LOOP;
    
    RETURN v_relatorio;
END;
/
