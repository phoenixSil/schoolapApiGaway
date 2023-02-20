using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace schoolapApiGaway.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UtilisateurController : ControllerBase
    {
        public UtilisateurController()
        {

        }

        [HttpGet]
        public async Task<ActionResult<string>> LireTousLesUtilisateurs()
        {
            return "allelouia";
        }
    }
}
