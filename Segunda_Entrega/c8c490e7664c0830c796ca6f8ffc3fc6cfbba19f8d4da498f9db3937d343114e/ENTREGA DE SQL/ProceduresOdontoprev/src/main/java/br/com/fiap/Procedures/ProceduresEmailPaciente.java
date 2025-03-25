package br.com.fiap.Procedures;

import java.sql.*;

public class ProceduresEmailPaciente {
    private static final String URL = "jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL"; // Ajuste com seu URL do Oracle
    private static final String USER = "rm552659"; // Ajuste com seu usuário
    private static final String PASSWORD = "171004"; // Ajuste com sua senha

    public static void inserirOEmailPaciente(int idEmail, String tpEmail, String stEmail, int idCliente) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call inserir_o_email_paciente(?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idEmail);
            stmt.setString(2, tpEmail);
            stmt.setString(3, stEmail);
            stmt.setInt(4, idCliente);

            stmt.execute();
            System.out.println("Registro inserido com sucesso!");

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

    public static void atualizarOEmailPaciente(int idEmail, String tpEmail, String stEmail, int idCliente) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call atualizar_o_email_paciente(?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idEmail);
            stmt.setString(2, tpEmail);
            stmt.setString(3, stEmail);
            stmt.setInt(4, idCliente);

            stmt.execute();
            System.out.println("Registro atualizado com sucesso!");

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

    public static void lerOEmailPaciente(int idEmail) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call ler_o_email_paciente(?, ?, ?, ?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idEmail);
            stmt.registerOutParameter(2, Types.VARCHAR);
            stmt.registerOutParameter(3, Types.VARCHAR);
            stmt.registerOutParameter(4, Types.INTEGER);

            stmt.execute();

            String tpEmail = stmt.getString(2);
            String stEmail = stmt.getString(3);
            int idCliente = stmt.getInt(4);

            System.out.println("Tipo de Email: " + tpEmail);
            System.out.println("Status do Email: " + stEmail);
            System.out.println("ID do Cliente: " + idCliente);

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

    public static void excluirOEmailPaciente(int idEmail) {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            String sql = "{call excluir_o_email_paciente(?)}";
            stmt = conn.prepareCall(sql);

            stmt.setInt(1, idEmail);

            stmt.execute();
            System.out.println("Registro excluído com sucesso!");

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
}
