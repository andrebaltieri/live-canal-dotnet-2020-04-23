using System.ComponentModel.DataAnnotations;

namespace CanalDotNet.Models
{
    public class TodoItem
    {
        public int Id { get; set; }

        [Required]
        public string Title { get; set; }

        public bool Done { get; set; }
        public string User { get; set; }

    }
}