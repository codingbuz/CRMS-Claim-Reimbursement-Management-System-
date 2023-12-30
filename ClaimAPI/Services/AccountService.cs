using ClaimAPI.Data;
using ClaimAPI.Models;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using System.Data;
using Microsoft.Data.SqlClient;
using ClaimAPI.Enums;

namespace ClaimAPI.Services
{
    public class AccountService: IUserAccount
    {
         public ApplicationDbContext DbContext { get; }
        public AccountService(ApplicationDbContext dbContext) {
            DbContext = dbContext;
        }

        public LoginResult Login(UserLogin users)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "USP_LoginUser";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@email", users.UserId);
                var parameter2 = new SqlParameter("@pass", users.Password);

                command.Parameters.Add(parameter);
                command.Parameters.Add(parameter2);

                DbContext.Database.OpenConnection();
                LoginResult result = (LoginResult)command.ExecuteScalar();
                return result;
            }
           
        }

        public UserVm GetUserByEmailID(string email)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "usp_get_user_by_email";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@email", email);

                command.Parameters.Add(parameter);

                DbContext.Database.OpenConnection();

                var result = command.ExecuteReader();
                result.Read();
                UserVm user=new UserVm();
                user.Email = result["Email"].ToString();
                user.Id = result["Id"].ToString();
                user.UserName = result["Nm"].ToString();
                user.Mobile = result["Mobile"].ToString();
                user.ManagerId = result["Manager_Id"].ToString();
                DbContext.Database.CloseConnection();
                return user;
            }

        }
        public void Logout()
        {
            // nno code
        }

        public string SignUp(Users users)
        {
            DbContext.Users.Add(users);
            DbContext.SaveChanges();
            return "ok";
        }
    }


    public class RoleManagerService : IRoleManage
    {

        public ApplicationDbContext DbContext { get; }
        public RoleManagerService(ApplicationDbContext dbContext)
        {
            DbContext = dbContext;
        }

        public string AddRole(RoleMaster Rm)   
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_role_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "create";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@RoleName";
                    parameter.SqlValue = Rm.RoleName;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Status";
                    parameter.SqlValue = Rm.Status;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);



                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;

        }

        public Tuple<string, List<RoleMaster>> getRoles()
        {
            string message = string.Empty;
            List<RoleMaster> lstRole = new List<RoleMaster>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_role_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "getall";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        RoleMaster objRoleM = new RoleMaster();
                        objRoleM.Id = Convert.ToInt32(result["Id"]);
                        objRoleM.RoleName = result["Role"].ToString();
                        objRoleM.Status = result["Status"].ToString();
                        lstRole.Add(objRoleM);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<RoleMaster>>(message, lstRole);
        }

        public Tuple<string, RoleMaster> getSingleRole(int id)
        {
            string message = string.Empty;
            RoleMaster objRolem = new RoleMaster();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_role_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "get";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@id";
                    parameter.SqlValue = id;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {

                        objRolem.RoleName = result["Role"].ToString();
                        objRolem.Id = Convert.ToInt32(result["Id"]);
                        objRolem.Status = result["Status"].ToString();

                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, RoleMaster>(message, objRolem);

        }

        public string UpdateRole(RoleMaster Rm)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_role_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "update";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@id";
                    parameter.SqlValue = Rm.Id;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@RoleName";
                    parameter.SqlValue = Rm.RoleName;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Status";
                    parameter.SqlValue = Rm.Status;
                    parameter.SqlDbType = SqlDbType.TinyInt;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;
        }

        public string AssignRole(int roleId, int userId, int status)
        {
            string massege = string.Empty;
            try
            {
                using(var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_assign_role";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@roleId";
                    parameter.SqlValue = roleId;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@UserId";
                    parameter.SqlValue = userId;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Status";
                    parameter.SqlValue = status;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch(SqlException ex)
            {
                massege = ex.Message;
            }
            catch (Exception ex)
            {
                massege = ex.Message;
            }

            return massege;
        }

        public Tuple<string, List<IdcardModel>> Idcard()
        {
            string message = string.Empty;
            List<IdcardModel> lstRole = new List<IdcardModel>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_get_Idcard";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();
                    

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        IdcardModel obj = new IdcardModel();
                        obj.Id = Convert.ToInt32(result["Id"]);
                        obj.Name = result["Nm"].ToString();
                        obj.Email = result["Email"].ToString();
                        obj.Mobile = result["Mobile"].ToString();
                        lstRole.Add(obj);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<IdcardModel>>(message, lstRole);
        }

        public Tuple<string, IdcardModel> GetSingleIdcard(int id)
        {
            string message = string.Empty;
            IdcardModel obj = new IdcardModel();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_get_IdcardById";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();



                    parameter = new SqlParameter();
                    parameter.ParameterName = "@id";
                    parameter.SqlValue = id;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {

                        obj.Name = result["Nm"].ToString();
                        obj.Id = Convert.ToInt32(result["Id"]);
                        obj.Email = result["Email"].ToString();
                        obj.Mobile = result["Mobile"].ToString();


                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, IdcardModel>(message, obj);
        }

        public Tuple<string, List<AssignRoleModel>> getAssignRoles()
        {
            string message = string.Empty;
            List<AssignRoleModel> lstRole = new List<AssignRoleModel>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_GET_ROLES";
                    command.CommandType = CommandType.StoredProcedure;

                    

                   

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        AssignRoleModel objRoleM = new AssignRoleModel();
                        objRoleM.Id = Convert.ToInt32(result["Id"]);
                        objRoleM.Name = result["Role"].ToString();
                       
                        lstRole.Add(objRoleM);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<AssignRoleModel>>(message, lstRole);
        }

        public Tuple<string, List<UserRights>> GetAllRights(int userid)
        {
            string message = string.Empty;
            List<UserRights> lstRights = new List<UserRights>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_get_programs_rights";
                    command.CommandType = CommandType.StoredProcedure;
                    var parameter = new SqlParameter();
                    parameter = new SqlParameter();
                    parameter.ParameterName = "@userId";
                    parameter.SqlValue = userid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);



                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        UserRights objRights = new UserRights();
                        objRights.Id = Convert.ToInt32(result["id"]);
                        objRights.Title = result["P_title"].ToString();
                        objRights.Descr = result["Descr"].ToString();
                        objRights.Ischecked = result["ischecked"].ToString();
                        lstRights.Add(objRights);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<UserRights>>(message, lstRights);
        }

        public string SaveProgramRights(int userid, string programsxml)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_SAVE_USER_INDIVIDUAL_RIGHTS";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@UserId";
                    parameter.SqlValue = userid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Rights";
                    parameter.SqlValue = programsxml;
                    parameter.SqlDbType = SqlDbType.Xml;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;
        }

        public Tuple<string, List<RoleName>> GetAllRoles()
        {
            string message = string.Empty;
            List<RoleName> lstroles = new List<RoleName>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_GET_ROLES";
                    command.CommandType = CommandType.StoredProcedure;

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        RoleName objroles = new RoleName();
                        objroles.Name = result["Role"].ToString();
                        objroles.Id = Convert.ToInt32(result["Id"]);
                       

                        lstroles.Add(objroles);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<RoleName>>(message, lstroles);
        }

        public Tuple<string, List<UserRights>> GetAllprogramrightsbyrole(int roleid)
        {
            string message = string.Empty;
            List<UserRights> lstRights = new List<UserRights>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_get_programs_rights_by_role";
                    command.CommandType = CommandType.StoredProcedure;
                    var parameter = new SqlParameter();
                    parameter = new SqlParameter();
                    parameter.ParameterName = "@roleId";
                    parameter.SqlValue = roleid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);



                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        UserRights objRights = new UserRights();
                        objRights.Id = Convert.ToInt32(result["id"]);
                        objRights.Title = result["P_title"].ToString();
                        objRights.Descr = result["Descr"].ToString();
                        objRights.Ischecked = result["Ischecked"].ToString();
                        lstRights.Add(objRights);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<UserRights>>(message, lstRights);
        }

        public string SaveProgramRightsbyrole(int roleid, string programsxml)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_SAVE_USER_Group_RIGHTS";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@roleId";
                    parameter.SqlValue = roleid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Rights";
                    parameter.SqlValue = programsxml;
                    parameter.SqlDbType = SqlDbType.Xml;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;
        }
    }
}
