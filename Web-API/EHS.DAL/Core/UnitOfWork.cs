using EHS.DAL.Core.Repository;
using EHS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EHS.DAL.Core
{
    public class UnitOfWork:IUnitOfWork
    {
        private readonly EHSContext _context = new EHSContext();
        private IGenericRepository<Company> _companyRepository;
        private IGenericRepository<Voucher> _voucherRepository;
        private IGenericRepository<VoucherDetail> _voucherDetailRepository;
        private IGenericRepository<MethodProcess> _methodProcessRepository;
        private IGenericRepository<WasteItem> _wasteItemRepository;

        public UnitOfWork()
        {
            _companyRepository = new CompanyRepository(_context);
            _voucherDetailRepository = new VoucherDetailRepository(_context);
            _voucherRepository = new VoucherRepository(_context);
            _methodProcessRepository = new MethodProcessRepository(_context);
            _wasteItemRepository = new WasteItemRepository(_context);
        }
        public Repository.IGenericRepository<Models.Company> CompanyRepository
        {
            get
            {
                if (_companyRepository == null)
                    _companyRepository = new GenericRepository<Company>(_context);
                return _companyRepository;
            }
        }

        public Repository.IGenericRepository<Models.Voucher> VoucherRepository
        {
            get
            {
                if (_voucherRepository == null)
                    _voucherRepository = new GenericRepository<Voucher>(_context);
                return _voucherRepository;
            }
        }

        public Repository.IGenericRepository<Models.VoucherDetail> VoucherDetailRepository
        {
            get
            {
                if (_voucherDetailRepository == null)
                    _voucherDetailRepository = new GenericRepository<VoucherDetail>(_context);
                return _voucherDetailRepository;
            }
        }

        public Repository.IGenericRepository<Models.WasteItem> WasteItemRepository
        {
            get
            {
                if (_wasteItemRepository == null)
                    _wasteItemRepository = new GenericRepository<WasteItem>(_context);
                return _wasteItemRepository;
            }
        }

        public Repository.IGenericRepository<Models.MethodProcess> MethodProcessRepository
        {
            get
            {
                if (_methodProcessRepository == null)
                    _methodProcessRepository = new GenericRepository<MethodProcess>(_context);
                return _methodProcessRepository;
            }
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
