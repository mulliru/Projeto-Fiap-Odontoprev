package br.com.fiap;

import br.com.fiap.Procedures.ProceduresCliente;
import br.com.fiap.Procedures.ProceduresEmailPaciente;

import java.sql.Date;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\nEscolha uma entidade para realizar operações:");
            System.out.println("1. Cliente");
            System.out.println("2. Email");
            System.out.println("3. Sair");
            System.out.print("Opção: ");
            int entidade = scanner.nextInt();

            if (entidade == 3) {
                System.out.println("Encerrando o programa.");
                break;
            }

            System.out.println("\nEscolha uma operação:");
            System.out.println("1. Inserir");
            System.out.println("2. Atualizar");
            System.out.println("3. Ler");
            System.out.println("4. Excluir");
            System.out.println("5. Voltar");
            System.out.print("Opção: ");
            int operacao = scanner.nextInt();

            if (operacao == 5) {
                continue;
            }

            switch (entidade) {
                case 1: // Cliente
                    handleClienteOperations(scanner, operacao);
                    break;
                case 2: // Email
                    handleEmailOperations(scanner, operacao);
                    break;
                default:
                    System.out.println("Entidade inválida. Tente novamente.");
            }
        }

        scanner.close();
    }

    private static void handleClienteOperations(Scanner scanner, int operacao) {
        int idCliente;
        String nomeCliente, cpf, rg, sexo;
        Date dataNascimento;

        switch (operacao) {
            case 1:
                // Inserir Cliente
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                System.out.print("Digite o Nome do Cliente: ");
                nomeCliente = scanner.next();
                System.out.print("Digite o CPF do Cliente: ");
                cpf = scanner.next();
                System.out.print("Digite o RG do Cliente: ");
                rg = scanner.next();
                System.out.print("Digite a Data de Nascimento do Cliente (YYYY-MM-DD): ");
                dataNascimento = Date.valueOf(scanner.next());
                System.out.print("Digite o Sexo do Cliente (M/F): ");
                sexo = scanner.next();
                ProceduresCliente.inserirNoCliente(String.valueOf(idCliente), nomeCliente, cpf, rg, dataNascimento, sexo);
                break;

            case 2:
                // Atualizar Cliente
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                System.out.print("Digite o Nome do Cliente: ");
                nomeCliente = scanner.next();
                System.out.print("Digite o CPF do Cliente: ");
                cpf = scanner.next();
                System.out.print("Digite o RG do Cliente: ");
                rg = scanner.next();
                System.out.print("Digite a Data de Nascimento do Cliente (YYYY-MM-DD): ");
                dataNascimento = Date.valueOf(scanner.next());
                System.out.print("Digite o Sexo do Cliente (M/F): ");
                sexo = scanner.next();
                ProceduresCliente.atualizarOCliente(idCliente, nomeCliente, cpf, rg, dataNascimento, sexo);
                break;

            case 3:
                // Ler Cliente
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                ProceduresCliente.lerOCliente(idCliente);
                break;

            case 4:
                // Excluir Cliente
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                ProceduresCliente.excluirOCliente(idCliente);
                break;

            default:
                System.out.println("Opção inválida. Tente novamente.");
        }
    }

    private static void handleEmailOperations(Scanner scanner, int operacao) {
        int idEmail, idCliente;
        String tpEmail, stEmail;

        switch (operacao) {
            case 1:
                // Inserir Email do Paciente
                System.out.print("Digite o ID do Email: ");
                idEmail = scanner.nextInt();
                System.out.print("Digite o Tipo de Email: ");
                tpEmail = scanner.next();
                System.out.print("Digite o Status do Email: ");
                stEmail = scanner.next();
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                ProceduresEmailPaciente.inserirOEmailPaciente(idEmail, tpEmail, stEmail, idCliente);
                break;

            case 2:
                // Atualizar Email do Paciente
                System.out.print("Digite o ID do Email: ");
                idEmail = scanner.nextInt();
                System.out.print("Digite o Tipo de Email: ");
                tpEmail = scanner.next();
                System.out.print("Digite o Status do Email: ");
                stEmail = scanner.next();
                System.out.print("Digite o ID do Cliente: ");
                idCliente = scanner.nextInt();
                ProceduresEmailPaciente.atualizarOEmailPaciente(idEmail, tpEmail, stEmail, idCliente);
                break;

            case 3:
                // Ler Email do Paciente
                System.out.print("Digite o ID do Email: ");
                idEmail = scanner.nextInt();
                ProceduresEmailPaciente.lerOEmailPaciente(idEmail);
                break;

            case 4:
                // Excluir Email do Paciente
                System.out.print("Digite o ID do Email: ");
                idEmail = scanner.nextInt();
                ProceduresEmailPaciente.excluirOEmailPaciente(idEmail);
                break;

            default:
                System.out.println("Opção inválida. Tente novamente.");
        }
    }
}
