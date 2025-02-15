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
INSERT INTO O_CLIENTE (id_cliente, nm_cliente, nr_cpf, nr_rg, dt_nasc, fl_sexo)
VALUES (:id_cliente, :nm_cliente, :nr_cpf, :nr_rg, :dt_nasc, :fl_sexo)
"""

clientes_data = [
    (1, 'João Silva', '123.456.789-00', 'MG-12.345.678', datetime(1985, 5, 12), 'M'),
    (2, 'Maria Oliveira', '987.654.321-00', 'SP-98.765.432', datetime(1990, 9, 25), 'F'),
    (3, 'Pedro Santos', '456.123.789-11', 'RJ-23.456.789', datetime(1982, 3, 18), 'M'),
    (4, 'Ana Paula', '321.654.987-11', 'RS-98.123.456', datetime(1995, 12, 5), 'F'),
    (5, 'Lucas Almeida', '147.258.369-11', 'PR-15.987.654', datetime(1988, 7, 22), 'M'),
    (6, 'Fernanda Costa', '963.852.741-00', 'CE-32.654.321', datetime(1992, 11, 30), 'F'),
    (7, 'Ricardo Martins', '753.159.486-00', 'BA-10.123.456', datetime(1980, 2, 14), 'M'),
    (8, 'Camila Lima', '852.369.741-00', 'MG-22.987.654', datetime(1993, 4, 20), 'F'),
    (9, 'Thiago Pereira', '159.753.246-00', 'SP-11.345.678', datetime(1987, 8, 15), 'M'),
    (10, 'Juliana Rocha', '951.753.864-00', 'RJ-44.987.123', datetime(1991, 1, 1), 'F')
]

cursor.executemany(insert_sql, clientes_data)

connection.commit()
print("10 registros inseridos com sucesso.")
