# SÓ EXECUTAR QUANDO A TABELA O_DIAGNOSTICO_SERVICO_IA  e O_PROFISSIONAL ESTIVER COM DADOS
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_DIAGNOSTICO_PROFISSIONAL (id_diagnostico, cfo)
VALUES (:id_diagnostico, :cfo)
"""

diagnostico_profissional_data = [
        (1, 12345),
        (2, 67890),
        (3, 54321),
        (4, 98765),
        (5, 13579),
        (6, 24680),
        (7, 11223),
        (8, 44556),
        (9, 77889),
        (10, 99000)
    ]

cursor.executemany(insert_sql, diagnostico_profissional_data)

connection.commit()
print("10 registros inseridos com sucesso.")