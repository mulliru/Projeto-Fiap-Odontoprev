using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Sprint02.Models
{
    public class Produto
    {
        [Key]
        public int Id { get; set; }

        [Column("name_odon")]
        public string Nome { get; set; } = "Sem Nome";

        [Column("email_odon")]
        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Column("password_odon")]
        [Required]
        [StringLength(50)]
        [MinLength(6)]
        [DataType(DataType.Password)]
        public string Password { get; set; } = string.Empty;

        [Column("cpf_odon")]
        [Required]
        [MaxLength(11)]
        public string Cpf { get; set; } = string.Empty;

        [Column("tratamento_odon")]
        public int PrimeiroTratamento { get; set; }
    }
}
