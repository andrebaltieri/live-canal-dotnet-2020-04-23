using CanalDotNet.Models;
using Microsoft.EntityFrameworkCore;

namespace CanalDotNet.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options)
            : base(options)
        {
        }

        public DbSet<TodoItem> Todos { get; set; }
        public DbSet<User> Users { get; set; }
    }
}