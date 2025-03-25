using Microsoft.EntityFrameworkCore;
using Sprint02.Models;

namespace Sprint02.Data
{
    public class ProdutoContext : DbContext
    {
        public ProdutoContext(DbContextOptions<ProdutoContext> options) : base(options) { }

        public DbSet<Produto> Produtos { get; set; }
    }
}
