# SÓ EXECUTAR QUANDO A TABELA O_CLIENTE ESTIVER COM DADOS
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_TELEFONE_CLIENTE (id_telefone, nr_ddd, nr_telefone, tp_telefone, id_cliente)
VALUES (:id_telefone, :nr_ddd, :nr_telefone, :tp_telefone, :id_cliente)
"""

telefone_data = [
        (1, 11, 987654321, 'Celular', 1),
        (2, 21, 912345678, 'Celular', 2),
        (3, 31, 998765432, 'Celular', 3),
        (4, 41, 998889999, 'Comercial', 4),
        (5, 51, 997778888, 'Celular', 5),
        (6, 61, 996667777, 'Residencial', 6),
        (7, 71, 995556666, 'Celular', 7),
        (8, 81, 994445555, 'Comercial', 8),
        (9, 91, 993334444, 'Residencial', 9),
        (10, 41, 992223333, 'Celular', 10)
    ]
cursor.executemany(insert_sql, telefone_data)

connection.commit()
print("10 registros inseridos com sucesso.")