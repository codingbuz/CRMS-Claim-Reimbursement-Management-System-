using Microsoft.AspNetCore.Mvc;

namespace ClaimApp.Controllers
{
    public class RoleController : Controller
    {
        public IActionResult ManageRole()
        {
            return View();
        }

        public IActionResult Idcard()
        {
            return View();
        }
        public IActionResult AssignRole()
        {
            return View();
        }

       // Role/AssignRights
        public IActionResult AssignRights()
        {
            return View();
        }


        //AssignRightByRole

        public IActionResult AssignRightByRole()
        {
            return View();
        }
    }
}
