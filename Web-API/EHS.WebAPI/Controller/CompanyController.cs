

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
    [RoutePrefix("api/EHS/CompanyController")]
    public class CompanyController : ApiController
    {
        private NBear.Data.Gateway oAC = new NBear.Data.Gateway("TestEHS");
        protected readonly ILog Loger = LogManager.GetLogger("HSSELogger");
        EHSContext _context = new EHSContext();
        HelperBiz _helper = new HelperBiz();
        UnitOfWork unitOfWork = new UnitOfWork();
        OperationResult operationResult = new OperationResult();
        /// <summary>
        /// List all Object
        /// </summary>
        /// <returns></returns>
        
        [Route("GetBasic")]
        [HttpGet]
        
        public IHttpActionResult GetBasic()
        {
            
            var data = oAC.ExecuteStoredProcedure("GetBasic", new string[] { "@Table", "@Lang" }, new string[] {"Company", null }).Tables[0];
            return Ok(data);
        }
        /// <summary>
        /// Search By Object
        /// </summary>
        /// <returns></returns>
        [Route("Search")]
        [HttpGet]
        public IHttpActionResult Search(string CompName, string Type, string CompCode, string Status)
        {
            try
            {
                var dt = oAC.ExecuteStoredProcedure("SearchCompany", new string[] { "CompName", "Type", "CompCode", "Status" }, new string[] { CompName, Type, CompCode, Status }).Tables[0];
                return Ok(dt);
            }
            catch (Exception e)
            {
                Loger.Error(e);
                throw new Exception(e.Message);
            }
        }      
      
        /// <summary>
        /// Find an object on Entity FrameWork
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Route("FindById")]
        [HttpPost]
        public IHttpActionResult FindById(Company entity)
        {
            var data = unitOfWork.CompanyRepository.FindBy(x => x.CompID == entity.CompID).FirstOrDefault();
            return Ok(data);
        }
       
        /// <summary>
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Create")]
        [HttpPost]
        public IHttpActionResult Add(Company entity)
        {
            entity.CompOriginID = entity.CompID = Guid.NewGuid().ToString().ToUpper();
            entity.Stamp = DateTime.Now;
            operationResult = unitOfWork.CompanyRepository.Add(entity);        
            unitOfWork.Save();//Save database after Update
            return Ok(operationResult);
        }
        /// <summary>      
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Update")]
        [HttpPost]
        public IHttpActionResult Update(Company entity)
        {
            entity.Stamp = DateTime.Now;
            entity.CompID = Guid.NewGuid().ToString().ToUpper();        
            operationResult = unitOfWork.CompanyRepository.Add(entity);         
            unitOfWork.Save();//Save database after Update
            return Ok(operationResult);
        }
        /// <summary>      
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Remove")]
        [HttpPost]
        public IHttpActionResult Remove(Company entity)
        {
            try
            {
                var current = unitOfWork.CompanyRepository.FindBy(x => x.CompID == entity.CompID).FirstOrDefault();
                if (current.Status == 1) current.Status = 0;
                    else current.Status = 1;
                //operationResult = unitOfWork.CompanyRepository.Remove(currentEntity);
                unitOfWork.Save();//Save database after Update
                operationResult.Success = true;
            }
            catch (Exception ex)
            {
                operationResult.Caption = "Failed";
                operationResult.Success = false;
                operationResult.Message = ex.ToString();
            }
           
            return Ok(operationResult);
        }

    }
}
