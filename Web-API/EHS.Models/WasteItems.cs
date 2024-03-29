//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EHS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class WasteItems
    {
        public WasteItems()
        {
            this.VoucherDetail = new HashSet<VoucherDetail>();
        }
    
        public string WasteID { get; set; }
        public string MethodID { get; set; }
        public string State { get; set; }
        public string ItemCode { get; set; }
        public string Description_EN { get; set; }
        public string Description_TW { get; set; }
        public string Description_CN { get; set; }
        public string Description_VN { get; set; }
        public string CompID { get; set; }
        public Nullable<int> Status { get; set; }
        public Nullable<System.DateTime> Stamp { get; set; }
        public string Remark { get; set; }
        public string WasetNumID { get; set; }
    
        public virtual Company Company { get; set; }
        public virtual MethodProcess MethodProcess { get; set; }
        public virtual ICollection<VoucherDetail> VoucherDetail { get; set; }
    }
}
