
import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_PROFISSIONAL (cfo, nm_profissional, nr_cpf, nr_rg)
VALUES (:cfo, :nm_profissional, :nr_cpf, :nr_rg)
"""

profissional_data = [
    (12345, 'Dr. João Silva', '123.456.789-00', 'MG-12.345.678'), 
    (67890, 'Dra. Maria Oliveira', '987.654.321-00', 'SP-98.765.432'), 
    (54321, 'Dr. Pedro Santos', '456.123.789-11', 'RJ-23.456.789'), 
    (98765, 'Dra. Ana Paula', '321.654.987-11', 'RS-98.123.456'), 
    (13579, 'Dr. Lucas Almeida', '147.258.369-11', 'PR-15.987.654'), 
    (24680, 'Dra. Fernanda Costa', '963.852.741-00', 'CE-32.654.321'), 
    (11223, 'Dr. Ricardo Martins', '753.159.486-00', 'BA-10.123.456'), 
    (44556, 'Dra. Camila Lima', '852.369.741-00', 'MG-22.987.654'), 
    (77889, 'Dr. Thiago Pereira', '159.753.246-00', 'SP-11.345.678'), 
    (99000, 'Dra. Juliana Rocha', '951.753.864-00', 'RJ-44.987.123')  
]

cursor.executemany(insert_sql, profissional_data)

connection.commit()
print("10 registros inseridos com sucesso.")