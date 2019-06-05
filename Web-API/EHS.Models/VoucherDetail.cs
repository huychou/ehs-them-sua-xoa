using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EHS.Models
{
    [Table("VoucherDetail")]
    public class VoucherDetail
    {
        public VoucherDetail() { }
        [Column("ID")]
        [Key]
        public string ID { get; set; }

        public string WasteID { get; set; }

        public string VoucherID { get; set; }

        public int? Quantity { get; set; }

        public float? Weight { get; set; }
             
    }
}
