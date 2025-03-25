using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sprint02.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Produtos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "NUMBER(10)", nullable: false)
                        .Annotation("Oracle:Identity", "START WITH 1 INCREMENT BY 1"),
                    name_odon = table.Column<string>(type: "NVARCHAR2(2000)", nullable: false),
                    email_odon = table.Column<string>(type: "NVARCHAR2(2000)", nullable: false),
                    password_odon = table.Column<string>(type: "NVARCHAR2(50)", maxLength: 50, nullable: false),
                    cpf_odon = table.Column<string>(type: "NVARCHAR2(11)", maxLength: 11, nullable: false),
                    tratamento_odon = table.Column<int>(type: "NUMBER(10)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Produtos", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Produtos");
        }
    }
}
