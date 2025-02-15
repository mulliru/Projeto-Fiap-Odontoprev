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
INSERT INTO O_EMAIL_PACIENTE (id_email, tp_email, st_email, id_cliente)
VALUES (:id_email, :tp_email, :st_email, :id_cliente)
"""

email_data = [
        (1, 'Pessoal', 'ativo', 1),
        (2, 'Comercial', 'ativo', 2),
        (3, 'Pessoal', 'inativo', 3),
        (4, 'Comercial', 'ativo', 4),
        (5, 'Pessoal', 'ativo', 5),
        (6, 'Comercial', 'ativo', 6),
        (7, 'Pessoal', 'inativo', 7),
        (8, 'Comercial', 'ativo', 8),
        (9, 'Pessoal', 'ativo', 9),
        (10, 'Comercial', 'inativo', 10)
    ]

cursor.executemany(insert_sql, email_data)

connection.commit()
print("10 registros inseridos com sucesso.")