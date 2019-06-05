using EHS.DAL.Core.Repository;
using EHS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EHS.DAL.Core
{
    public interface IUnitOfWork : IDisposable
    {
        IGenericRepository<Company> CompanyRepository { get; }
        IGenericRepository<Voucher> VoucherRepository { get; }
        IGenericRepository<VoucherDetail> VoucherDetailRepository { get; }
        IGenericRepository<WasteItem> WasteItemRepository { get; }
        IGenericRepository<MethodProcess> MethodProcessRepository { get; }
        void Save();
    }
}
