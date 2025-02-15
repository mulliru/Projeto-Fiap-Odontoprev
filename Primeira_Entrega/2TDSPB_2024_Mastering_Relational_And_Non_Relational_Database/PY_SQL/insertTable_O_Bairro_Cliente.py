# SÓ EXECUTAR QUANDO A TABELA O_CIDADE_CLIENTE ESTIVER COM DADOS
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
INSERT INTO O_BAIRRO_CLIENTE (id_bairro_cliente, nm_bairro, id_cidade)
VALUES (:id_bairro_cliente, :nm_bairro, :id_cidade)
"""

bairro_data = [
        (1, 'Jardins', 1), 
        (2, 'Copacabana', 2), 
        (3, 'Savassi', 3), 
        (4, 'Centro', 4), 
        (5, 'Aldeota', 5), 
        (6, 'Barra', 6), 
        (7, 'Asa Sul', 7), 
        (8, 'Adrianópolis', 8), 
        (9, 'Moinhos de Vento', 9), 
        (10, 'Boa Viagem', 10)
    ]

cursor.executemany(insert_sql, bairro_data)

connection.commit()
print("10 registros inseridos com sucesso.")