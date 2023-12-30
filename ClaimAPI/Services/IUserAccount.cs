using ClaimAPI.Enums;
using ClaimAPI.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace ClaimAPI.Services
{

        public interface IUserAccount
        {
            string SignUp(Users users);
            LoginResult Login(UserLogin users);
            UserVm GetUserByEmailID(string email);
            void Logout();
        
    }
    public interface IRoleManage
    {
        string AddRole(RoleMaster Rm);
        string UpdateRole(RoleMaster Rm);
        Tuple<string, RoleMaster> getSingleRole(int id);
        Tuple<string, List<RoleMaster>> getRoles();
        string AssignRole(int roleId,int userId,int status);

        Tuple<string, List<IdcardModel>> Idcard();

        Tuple<string, IdcardModel> GetSingleIdcard(int id);

        public Tuple<string, List<AssignRoleModel>> getAssignRoles();


        Tuple<string, List<UserRights>> GetAllRights(int userid);
        string SaveProgramRights(int userid, string programsxml);

        public Tuple<string, List<RoleName>> GetAllRoles();

        public Tuple<string, List<UserRights>> GetAllprogramrightsbyrole(int roleid);


        public string SaveProgramRightsbyrole(int roleid, string programsxml);
    }
}
