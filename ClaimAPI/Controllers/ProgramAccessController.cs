using ClaimAPI.Models;
using ClaimAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ClaimAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProgramAccessController : ControllerBase
    {
        private APIResponse response = new APIResponse();
        public IProgram ProgramService { get; }
        public ProgramAccessController(IProgram program)
        {
            ProgramService = program;
        }

        [Route("GetProgramList")]
        [HttpGet]
        public IActionResult GetProgramList(int UserId) {
            try
            {
                var result = ProgramService.GetPrograms(UserId);
                response.status = 200;
                response.ok = true;
                response.data = result;
                response.message = "program found!";

            }
            catch (Exception ex)
            {
                response.status = 500;
                response.ok = true;
                response.message = ex.Message;
            }
            return Ok(response);
        }


        [Route("getAllProgramName")]
        [HttpGet]
        public IActionResult getAllProgramName()
        {

            try
            {

                var result = ProgramService.getAllprograms();
                if (string.IsNullOrEmpty(result.Item1))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = result.Item2;
                    response.message = "Record found!";
                }
                else
                {
                    response.status = -100;
                    response.ok = false;
                    response.data = null;
                    response.message = result.Item1;

                }
            }
            catch (Exception ex)
            {
                response.status = -100;
                response.ok = false;
                response.data = null;
                response.message = ex.Message;
            }
            return Ok(response);
        }

        

        [Route("AddPrograms")]
        [HttpPost]
        public IActionResult AddPrograms()
        {
            try
            {
                ProgramMaster pm = new ProgramMaster();
                pm.P_title= Request.Form["P_title"].ToString();
                pm.Path= Request.Form["Path"].ToString();
                pm.Descr = Request.Form["Descr"].ToString();
                pm.Display_Sequence= Convert.ToInt32(Request.Form["Display_Sequence"]);
                pm.Status = Convert.ToInt32(Request.Form["Status"]);
                
                var result = ProgramService.Addprogram(pm);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = pm;
                    response.message = "Program Add successfully !";
                }
                else
                {
                    response.status = -100;
                    response.ok = false;
                    response.data = null;
                    response.message = result;

                }
            }
            catch (Exception ex)
            {
                response.status = -100;
                response.ok = false;
                response.data = null;
                response.message = ex.Message;
            }
            return Ok(response);
        }

        [Route("UpdateProgram")]
        [HttpPost]
        public IActionResult UpdateProgram()
        {
            try
            {
                ProgramMaster pm = new ProgramMaster();
                pm.Id = Convert.ToInt32(Request.Form["Id"]);
                pm.P_title = Request.Form["P_title"].ToString();
                pm.Path = Request.Form["Path"].ToString();
                pm.Descr = Request.Form["Descr"].ToString();
                pm.Display_Sequence = Convert.ToInt32(Request.Form["Display_Sequence"]);
                pm.Status = Convert.ToInt32(Request.Form["Status"]);

                var result = ProgramService.Updateprogram(pm);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = pm;
                    response.message = "Data update successfully!";
                }
                else
                {
                    response.status = -100;
                    response.ok = false;
                    response.data = null;
                    response.message = result;

                }
            }
            catch (Exception ex)
            {
                response.status = -100;
                response.ok = false;
                response.data = null;
                response.message = ex.Message;
            }
            return Ok(response);
        }


        [Route("GetSingleProgram")]
        [HttpGet]
        public IActionResult GetSingleProgram(int id)
        {
            try
            {

                var result =ProgramService.getSingleProgram(id);
                if (string.IsNullOrEmpty(result.Item1))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = result.Item2;
                    response.message = "Record found!";
                }
                else
                {
                    response.status = -100;
                    response.ok = false;
                    response.data = null;
                    response.message = result.Item1;

                }
            }
            catch (Exception ex)
            {
                response.status = -100;
                response.ok = false;
                response.data = null;
                response.message = ex.Message;
            }
            return Ok(response);
        }

    }
}
