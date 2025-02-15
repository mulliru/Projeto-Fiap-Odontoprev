# SÓ EXECUTAR QUANDO A TABELA O_RECOMEPENSA ESTIVER COM DADOS
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_ESTOQUE (id_estoque, qnt_produto, id_recompensa)
VALUES (:id_estoque, :qnt_produto, :id_recompensa)
"""

estoque_data = [
        (1, 100, 1), 
        (2, 200, 2), 
        (3, 150, 3), 
        (4, 250, 4), 
        (5, 300, 5), 
        (6, 180, 6), 
        (7, 90, 7), 
        (8, 120, 8), 
        (9, 160, 9), 
        (10, 200, 10) 
    ]


cursor.executemany(insert_sql, estoque_data)

connection.commit()
print("10 registros inseridos com sucesso.")