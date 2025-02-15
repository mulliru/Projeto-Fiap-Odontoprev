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
INSERT INTO O_CIDADE_CLIENTE (id_cidade, nm_cidade)
VALUES (:id_cidade, :nm_cidade)
"""

cidade_data = [
        (1, 'São Paulo'),
        (2, 'Rio de Janeiro'),
        (3, 'Belo Horizonte'),
        (4, 'Curitiba'),
        (5, 'Fortaleza'),
        (6, 'Salvador'),
        (7, 'Brasília'),
        (8, 'Manaus'),
        (9, 'Porto Alegre'),
        (10, 'Recife')
    ]

cursor.executemany(insert_sql, cidade_data)

connection.commit()
print("10 registros inseridos com sucesso.")