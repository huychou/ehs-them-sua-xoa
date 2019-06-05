using EHS.DAL.Core;
using EHS.DAL.Helper;
using EHS.Models;
using EHS.WebAPI.Helper;
using log4net;
using System;
using System.Collections.Generic;
using System.Data;

using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;

namespace EHS.WebAPI.Controller
{
    [EHS.WebAPI.Filter.FilterIP]
    [RoutePrefix("api/EHS/MyNewController")]
    public class MyNewController : ApiController
    {
        private NBear.Data.Gateway oAC = new NBear.Data.Gateway("TestEHS"); //CSDL
        protected readonly ILog Loger = LogManager.GetLogger("HSSELogger"); // Ghi log
        EHSContext _context = new EHSContext(); // entityframwork (có thể sử dụng unitOfWork. // ==> design patter 
        HelperBiz _helper = new HelperBiz(); // ==> tùy chọn
        UnitOfWork unitOfWork = new UnitOfWork(); // sử dụng entity framework chủ yếu thêm sửa xóa delete
        OperationResult operationResult = new OperationResult(); //thông báo được trả về


        [Route("GetDataDepartment")]
        [HttpGet]
        public IHttpActionResult GetDataDepartment(string costcenter, string spec)
        {
            var data = oAC.ExecuteStoredProcedure("GetDataDepartment"
                , new string[] { "@CostCenter", "@Specification" }
                , new string[] { costcenter, spec }).Tables[0];
            return Ok(data);
        }

        [Route("GetHan")]
        [HttpGet]
        public IHttpActionResult GetH(string name, string ngonngu, string tt)
        {
            var data = oAC.ExecuteStoredProcedure("HGetMethod"
                , new string[] { "@MethodName", "@Description_VN", "@Status" }
                , new string[] { name, ngonngu, tt }).Tables[0];
            return Ok(data);
        }

        [Route("GetCompany")]
        [HttpGet]
        public IHttpActionResult GetCompany()
        {
            var data = oAC.SelectDataSet("SELECT * FROM Company",null).Tables[0];
            return Ok(data);
        }

        [Route("AddCompany")]
        [HttpPost]
        public IHttpActionResult AddCompany(Company entity)
        {
            try
            {
                entity.CompID = Guid.NewGuid().ToString().ToUpper();
                entity.CompOriginID = entity.CompID;
                entity.Status = 1;
                _context.Company.Add(entity);
                _context.SaveChanges();

                operationResult.Success = true;
                operationResult.Caption = "THanh cong";
                operationResult.Message = "THem thanh cong company";

            }
            catch (Exception e)
            {
                operationResult.Success = false;
                operationResult.Caption = "Fail";
                operationResult.Message = e.Message;
            }

            return Ok(operationResult);
        }


        [Route("DeleteCompany")]
        [HttpDelete]
        public IHttpActionResult DeleteCompany(string Id)
        {
            try
            {
                var x = _context.Company.Where(a => a.CompID.Equals(Id)).FirstOrDefault();
                _context.Company.Remove(x);
                _context.SaveChanges();

                operationResult.Success = true;
                operationResult.Caption = "Thanh cong";
                operationResult.Message = "Xoa thanh cong company";
            }
            catch (Exception e)
            {
                operationResult.Success = false;
                operationResult.Caption = "Fail";
                operationResult.Message = e.Message;
            }

            return Ok(operationResult);
        }

        [Route("UpdateCompany")]
        [HttpPost]
        public IHttpActionResult UpdateCompany(string Id, Company entity)
        {
            try
            {
                var x = _context.Company.Where(a => a.CompID.Equals(Id)).First();
                entity.CompID = x.CompID;
                entity.CompOriginID = x.CompOriginID;
                entity.Stamp = x.Stamp;
                entity.UserID = x.UserID;
                
                _context.Entry(x).CurrentValues.SetValues(entity); 
                _context.SaveChanges();

                operationResult.Success = true;
                operationResult.Caption = "Thanh cong";
                operationResult.Message = "Sửa thanh cong company";
            }
            catch (Exception e)
            {
                operationResult.Success = false;
                operationResult.Caption = "Fail";
                operationResult.Message = e.Message;
            }

            return Ok(operationResult);
        }
    }
}
