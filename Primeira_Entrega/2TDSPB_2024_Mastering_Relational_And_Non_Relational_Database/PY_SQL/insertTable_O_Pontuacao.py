# SÓ EXECUTAR QUANDO A TABELA O_SERVICO_IA ESTIVER COM DADOS
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
INSERT INTO O_PONTUACAO (id_conta, qnt_pontos, dt_inicio_pontos, dt_final_validade, id_servico_ia)
VALUES (:id_conta, :qnt_pontos, :dt_inicio_pontos, :dt_final_validade, :id_cliente)
"""

pontuacao_data = [
        (1, 100, datetime(2024, 1, 1), datetime(2024, 12, 31), 1),  
        (2, 200, datetime(2023, 1, 15), datetime(2023, 12, 31), 2), 
        (3, 150, datetime(2022, 5, 10), datetime(2023, 5, 10), 3),  
        (4, 250, datetime(2021, 7, 1), datetime(2022, 6, 30), 4),   
        (5, 300, datetime(2023, 3, 1), datetime(2024, 3, 1), 5),    
        (6, 180, datetime(2023, 9, 1), datetime(2024, 9, 1), 6),    
        (7, 90, datetime(2022, 11, 11), datetime(2023, 11, 11), 7), 
        (8, 120, datetime(2023, 4, 5), datetime(2024, 4, 5), 8),    
        (9, 160, datetime(2023, 8, 15), datetime(2024, 8, 15), 9),  
        (10, 200, datetime(2023, 12, 1), datetime(2024, 12, 1), 10)  
]

cursor.executemany(insert_sql, pontuacao_data)

connection.commit()
print("10 registros inseridos com sucesso.")