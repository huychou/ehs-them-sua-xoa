using EHS.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EHS.DAL.Core
{
    public class EHSContext:DbContext
    {
        public EHSContext()
            : base("name=TestEHS")
        { }
        public DbSet<Company> Company { set; get; }
        public DbSet<MethodProcess> MethodProcess { set; get; }
        public DbSet<Voucher> Voucher { set; get; }
        public DbSet<VoucherDetail> VocuherDetail { set; get; }
        public DbSet<WasteItem> WasteItems { set; get; }

    }
}
