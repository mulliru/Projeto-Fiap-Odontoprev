import oracledb



username = 'rm552659'
password = '171004'
host = 'oracle.fiap.com.br'
port = 1521
service = 'ORCL'


    
connection = oracledb.connect(user=username, password=password, host=host, port=port, service_name=service)
cursor = connection.cursor()

insert_sql = """
INSERT INTO O_RECOMPENSA (id_recompensa, nm_produto, desc_produto, preco_produto)
VALUES (:id_recompensa, :nm_produto, :desc_produto, :preco_produto)
"""

recompensas_data = [
        (1, 'Cesta de Frutas', 'Uma deliciosa cesta cheia de frutas frescas.', 50.00),
        (2, 'Vale Compras', 'Vale de R$100 para gastar em compras.', 100.00),
        (3, 'Assinatura de Streaming', 'Assinatura de 1 ano para um serviço de streaming.', 300.00),
        (4, 'Curso Online', 'Acesso a um curso online de sua escolha.', 150.00),
        (5, 'Fone de Ouvido', 'Fone de ouvido com cancelamento de ruído.', 200.00),
        (6, 'Relógio Fitness', 'Relógio inteligente para monitoramento de atividades.', 400.00),
        (7, 'Experiência Gastronômica', 'Jantar em um restaurante renomado.', 250.00),
        (8, 'Kit de Beleza', 'Um kit com produtos de beleza e cuidados pessoais.', 120.00),
        (9, 'Assinatura de Revistas', 'Assinatura de 1 ano para revistas de seu interesse.', 80.00),
        (10, 'Voucher de Viagem', 'Voucher de R$500 para ser usado em viagens.', 500.00)
    ]

cursor.executemany(insert_sql, recompensas_data)

connection.commit()
print("10 registros inseridos com sucesso.")