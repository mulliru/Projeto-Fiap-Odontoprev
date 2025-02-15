# SÓ EXECUTAR QUANDO A TABELA O_SERVICO_IA ESTIVER COM DADOS
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_DIAGNOSTICO_SERVICO_IA (id_diagnostico, st_diagnostico, desc_diagnostico, id_servico_ia)
VALUES (:id_diagnostico, :st_diagnostico, :desc_diagnostico, :id_servico_ia)
"""

diagnostico_data = [
        (1, 'N', 'Diagnóstico Inicial - Não Iniciado', 1),
        (2, 'A', 'Acompanhamento Regular - Em Andamento', 2),
        (3, 'A', 'Revisão Anual - Em Andamento', 3),
        (4, 'N', 'Avaliação de Risco - Não Iniciado', 4),
        (5, 'F', 'Consulta de Especialista - Finalizado', 5),
        (6, 'F', 'Exame Completo - Finalizado', 6),
        (7, 'A', 'Segunda Opinião - Em Andamento', 7),
        (8, 'N', 'Tratamento em Andamento - Não Iniciado', 8),
        (9, 'F', 'Diagnóstico Final - Finalizado', 9),
        (10, 'A', 'Encaminhamento para Especialista - Em Andamento', 10)
    ]

cursor.executemany(insert_sql, diagnostico_data)

connection.commit()
print("10 registros inseridos com sucesso.")