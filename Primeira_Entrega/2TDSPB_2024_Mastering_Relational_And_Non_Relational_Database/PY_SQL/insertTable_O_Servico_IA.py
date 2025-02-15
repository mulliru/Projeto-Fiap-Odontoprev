# SÓ EXECUTAR QUANDO A TABELA O_CLIENTE ESTIVER COM DADOS
import oracledb
from datetime import datetime


username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_SERVICO_IA (id_servico_ia, dt_inicio, dt_final, id_cliente)
VALUES (:id_servico_ia, :dt_inicio, :dt_final, :id_cliente)
"""

servico_ia_data = [
        (1, datetime(2024, 1, 1), datetime(2024, 12, 31), 1),
        (2, datetime(2023, 1, 15), datetime(2023, 12, 31), 2),  
        (3, datetime(2022, 5, 10), datetime(2023, 5, 10), 3),  
        (4, datetime(2021, 7, 1), datetime(2022, 6, 30), 4),
        (5, datetime(2023, 3, 1), datetime(2024, 3, 1), 5),     
        (6, datetime(2023, 9, 1), datetime(2024, 9, 1), 6),     
        (7, datetime(2022, 11, 11), datetime(2023, 11, 11), 7), 
        (8, datetime(2023, 4, 5), datetime(2024, 4, 5), 8),   
        (9, datetime(2023, 8, 15), datetime(2024, 8, 15), 9),   
        (10, datetime(2023, 12, 1), datetime(2024, 12, 1), 10)   
]

cursor.executemany(insert_sql, servico_ia_data)

connection.commit()
print("10 registros inseridos com sucesso.")