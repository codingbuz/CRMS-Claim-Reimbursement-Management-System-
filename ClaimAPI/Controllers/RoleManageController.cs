using ClaimAPI.Models;
using ClaimAPI.Services;
using ClaimAPI.Utility;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace ClaimAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoleManageController : Controller
    {
        public IRoleManage _accountService { get; }
        private APIResponse response = new APIResponse();
        public RoleManageController(IRoleManage rolemanage)
        {
            _accountService = rolemanage;
        }


        [HttpGet]
        [Route("GetAllRoles")]
        public IActionResult GetAllRoles()
        {
            try
            {

                var result = _accountService.getRoles();
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
    

        [HttpPost]
        [Route("CreateRole")]
        public IActionResult CreateRole()
        {
            try
            {
                RoleMaster Rm = new RoleMaster();
                Rm.RoleName = Request.Form["RoleName"].ToString();
               
                Rm.Status = Request.Form["Status"].ToString();

                var result = _accountService.AddRole(Rm);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = Rm;
                    response.message = "Data saved successfully!";
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
        [HttpGet]
        [Route("GetRole")]
        public IActionResult GetRole(int id)
        {
            try
            {

                var result = _accountService.getSingleRole(id);
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


        [HttpPost]
        [Route("UpdateRole")]
        public IActionResult UpdateRole()
        {
            try
            {
                RoleMaster Rm = new RoleMaster();
                Rm.RoleName = Request.Form["RoleName"].ToString();
                Rm.Status = Request.Form["Status"].ToString();
                Rm.Id =Convert.ToInt32( Request.Form["Id"]);

                var result = _accountService.UpdateRole(Rm);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.data = Rm;
                    response.message = "Data saved successfully!";
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

        [HttpPost]
        [Route("Assignrole")]
        public IActionResult AssignRole()
        {
            try
            {
                
                int roleId = Convert.ToInt32(Request.Form["RoleName"]);
                int userId = Convert.ToInt32(Request.Form["Status"]);
                int status = Convert.ToInt32(Request.Form["status"]);

                var result = _accountService.AssignRole(roleId, userId,status);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    
                    response.message = "Data saved successfully!";
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

        [HttpGet]
        [Route("GetAllAssignRoles")]
        public IActionResult GetAllAssignRoles()
        {
            try
            {

                var result = _accountService.getAssignRoles();
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


        [HttpGet]
        [Route("GetIdcard")]
        public IActionResult GetIdcard()
        {
            try
            {

                var result = _accountService.Idcard();
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


        [HttpGet]
        [Route("GetSingleIdcard")]
        public IActionResult GetSingleIdcard(int id)
        {
            try
            {

                var result = _accountService.GetSingleIdcard(id);
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



        [HttpGet]
        [Route("GetAllRights")]
        public IActionResult GetAllRights(int UserId)
        {
            try
            {

                var result = _accountService.GetAllRights(UserId);
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



        [HttpPost]
        [Route("AssignRightsIndividual")]
        public IActionResult AssignRightsIndividual()
        {
            try
            {
                int UserId = Convert.ToInt32(Request.Form["UserId"]);
                string str = Request.Form["lstPrograms"].ToString();
                var lstPrograms = JsonSerializer.Deserialize<List<ProgramsRights>>(str);

                var xmlPrograms = XMLUtil.XMLFunction(lstPrograms);

                var result = _accountService.SaveProgramRights(UserId, xmlPrograms);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.message = "Data saved successfully!";
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


        [HttpGet]
        [Route("getAllrole")]
        public IActionResult getAllrole()
        {
            try
            {

                var result = _accountService.GetAllRoles();
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


        [HttpGet]
        [Route("GetAllprogrambyrole")]
        public IActionResult GetAllprogrambyrole(int roleId)
        {
            try
            {

                var result = _accountService.GetAllprogramrightsbyrole(roleId);
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



        [HttpPost]
        [Route("AssignRightsByRole")]
        public IActionResult AssignRightsByRole()
        {
            try
            {
                int roleId = Convert.ToInt32(Request.Form["roleId"]);
                string str = Request.Form["lstPrograms"].ToString();
                var lstrights = JsonSerializer.Deserialize<List<ProgramsRights>>(str);

                var xmlPrograms = XMLUtil.XMLFunction(lstrights);

                var result = _accountService.SaveProgramRights(roleId, xmlPrograms);
                if (string.IsNullOrEmpty(result))
                {
                    response.status = 200;
                    response.ok = true;
                    response.message = "Data saved successfully!";
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

    }
}
