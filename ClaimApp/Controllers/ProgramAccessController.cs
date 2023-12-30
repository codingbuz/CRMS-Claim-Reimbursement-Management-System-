using Microsoft.AspNetCore.Mvc;

namespace ClaimApp.Controllers
{
    public class ProgramAccessController : Controller
    {
        public IActionResult AddProgram()
        {
            return View();
        }
    }
}
