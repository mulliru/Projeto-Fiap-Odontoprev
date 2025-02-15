# SÓ EXECUTAR QUANDO A TABELA O_PONTUACAO  e O_RECOMPENSA ESTIVER COM DADOS
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_PONTUACAO_RECOMPENSA (id_recompensa, id_conta)
VALUES (:id_recompensa, :id_conta)
"""

pontuacao_recompensa_data = [
        (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5),
        (6, 6),
        (7, 7),
        (8, 8),
        (9, 9),
        (10, 10)
    ]

cursor.executemany(insert_sql, pontuacao_recompensa_data)

connection.commit()
print("10 registros inseridos com sucesso.")