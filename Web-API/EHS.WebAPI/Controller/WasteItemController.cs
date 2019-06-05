using EHS.DAL.Core;
using EHS.DAL.Helper;
using EHS.Models;
using EHS.WebAPI.Helper;
using log4net;
using System;
using System.Linq;
using System.Web.Http;

namespace EHS.WebAPI.Controller
{
    [EHS.WebAPI.Filter.FilterIP]
    [RoutePrefix("api/EHS/WasteItemController")]
    public class WasteItemController : ApiController
    {
        private NBear.Data.Gateway oAC = new NBear.Data.Gateway("TestEHS");
        protected readonly ILog Loger = LogManager.GetLogger("HSSELogger");
        HelperBiz _helper = new HelperBiz();
        UnitOfWork unitOfWork = new UnitOfWork();
        OperationResult operationResult = new OperationResult();
        /// <summary>
        /// List all Object
        /// </summary>
        /// <returns></returns>
        [Route("GetBasic")]
        [HttpGet]
        public IHttpActionResult GetBasic(string lang)
        {
            var data = oAC.ExecuteStoredProcedure("GetBasic", new string[] { "@Table", "@Lang" }, new string[] {  "WasteItems", lang }).Tables[0];
            return Ok(data);
        }

        /// <summary>
        /// Search By Object
        /// </summary>
        /// <returns></returns>
        [Route("Search")]
        [HttpGet]
        public IHttpActionResult Search(string MethodID, string State, string ItemCode, string Description, string ProcessComp, string Status)
        {
            try
            {
                var dt = oAC.ExecuteStoredProcedure("SearchWasteItem", new string[] { "MethodID", "State", "ItemCode", "Description", "ProcessComp", "Status" }, new string[] { MethodID, State, ItemCode, Description, ProcessComp, Status }).Tables[0];
                return Ok(dt);
            }
            catch (Exception e)
            {
                Loger.Error(e);
                throw new Exception(e.Message);
            }
        }     

        [Route("GetWasteByCompany")]
        [HttpGet]

        public IHttpActionResult GetWasteByCompany(string comp, string lang)
        {
            try
            {
                var dt = oAC.ExecuteStoredProcedure("GetWasteByCompany",

                    new string[] { "CompID", "Lang" }, new object[] { comp, lang }).Tables[0];
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
        public IHttpActionResult FindById(WasteItem entity)
        {
            var data = unitOfWork.WasteItemRepository.FindBy(x => x.WasteID == entity.WasteID).FirstOrDefault();
            return Ok(data);
        }
        /// <summary>
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Create")]
        [HttpPost]
        public IHttpActionResult Add(WasteItem entity)
        {
            entity.WasteOriginID = entity.WasteID = Guid.NewGuid().ToString().ToUpper();
            entity.Stamp = DateTime.Now;
            operationResult = unitOfWork.WasteItemRepository.Add(entity);
            unitOfWork.Save();//Save database after Update
            return Ok(operationResult);
        }
        /// <summary>      
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Update")]
        [HttpPost]
        public IHttpActionResult Update(WasteItem entity)
        {
            /* UPDATE WITH NON-VERSION */
            entity.Stamp = DateTime.Now;
            operationResult = unitOfWork.WasteItemRepository.Update(entity);
                /* UPDATE WITH VERSION  */
                    //entity.WasteID = Guid.NewGuid().ToString().ToUpper();   
                    //operationResult = unitOfWork.WasteItemRepository.Add(entity);        
            unitOfWork.Save();//Save database after Update
            return Ok(operationResult);
        }
        /// <summary>      
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Remove")]
        [HttpPost]
        public IHttpActionResult Remove(WasteItem entity)
        {
            try
            {
                var current = unitOfWork.WasteItemRepository.FindBy(x => x.WasteID == entity.WasteID).FirstOrDefault();
                if (current.Status == 1) current.Status = 0;
                    else current.Status = 1;
                //operationResult = unitOfWork.WasteItemRepository.Save();
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
