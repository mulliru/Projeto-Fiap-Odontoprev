package br.com.fiap.Procedures;

import java.sql.*;

public class ProceduresCliente {
    private static final String URL = "jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL"; // Ajuste com seu URL do Oracle
    private static final String USER = "rm552659"; // Ajuste com seu usuário
    private static final String PASSWORD = "171004"; // Ajuste com sua senha

    public static void inserirNoCliente(String idCliente, String nmCliente, String nrCpf, String nrRg, Date dtNasc, String flSexo) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call inserir_no_cliente(?, ?, ?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setString(1, idCliente);
            stmt.setString(2, nmCliente);
            stmt.setString(3, nrCpf);
            stmt.setString(4, nrRg);
            stmt.setDate(5, dtNasc);
            stmt.setString(6, String.valueOf(flSexo));

            stmt.execute();
            System.out.println("Registro inserido com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    public static void atualizarOCliente(int idCliente, String nmCliente, String nrCpf, String nrRg, Date dtNasc, String flSexo) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call atualizar_o_cliente(?, ?, ?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idCliente);
            stmt.setString(2, nmCliente);
            stmt.setString(3, nrCpf);
            stmt.setString(4, nrRg);
            stmt.setDate(5, dtNasc);
            stmt.setString(6, String.valueOf(flSexo));

            stmt.execute();
            System.out.println("Registro atualizado com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    public static void lerOCliente(int idCliente) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call ler_o_cliente(?, ?, ?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idCliente);
            stmt.registerOutParameter(2, Types.VARCHAR);
            stmt.registerOutParameter(3, Types.VARCHAR);
            stmt.registerOutParameter(4, Types.VARCHAR);
            stmt.registerOutParameter(5, Types.DATE);
            stmt.registerOutParameter(6, Types.CHAR);

            stmt.execute();

            String nmCliente = stmt.getString(2);
            String nrCpf = stmt.getString(3);
            String nrRg = stmt.getString(4);
            Date dtNasc = stmt.getDate(5);
            char flSexo = stmt.getString(6).charAt(0);

            System.out.println("Nome do Cliente: " + nmCliente);
            System.out.println("CPF: " + nrCpf);
            System.out.println("RG: " + nrRg);
            System.out.println("Data de Nascimento: " + dtNasc);
            System.out.println("Sexo: " + flSexo);

        } catch (SQLException e) {
            System.out.println("Erro ao executar o procedimento armazenado: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                System.out.println("Erro ao fechar recursos: " + se.getMessage());
                se.printStackTrace();
            }
        }
    }

    public static void excluirOCliente(int idCliente) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call excluir_o_cliente(?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idCliente);

            stmt.execute();
            System.out.println("Registro excluído com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}