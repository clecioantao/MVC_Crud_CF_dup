using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace MVCcodfirst4.Models
{
    public class Estado
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EstadoId { get; set; }
        [Required]
        [Display(Name = "Estado")]
        public string NomeEstado { get; set; }

        public virtual ICollection<Pessoa> Pessoa_est { get; set; }

    }
}