using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace MVCcodfirst4.Models
{
    public class Pessoa
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PessoaId { get; set; }
        [Required]
        [Display(Name = "Nome")]
        public string NomePessoa { get; set; }
        [Required]
        [Display(Name = "Endereço")]
        public string EnderecoPessoa { get; set; }
        [Display(Name = "Complemento")]
        public string ComplementoPessoa { get; set; }
        public int CidadeId { get; set; }
        public int EstadoId { get; set; }

        public virtual Cidade Cidade { get; set; }
        public virtual Estado Estado { get; set; }
    }
}