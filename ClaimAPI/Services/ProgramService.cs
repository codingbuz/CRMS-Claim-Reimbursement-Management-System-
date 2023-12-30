using ClaimAPI.Data;
using ClaimAPI.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace ClaimAPI.Services
{
    
    public interface IProgram
    {
        List<ProgramVm> GetPrograms(int UserId);

        public Tuple<string, List<ProgramMaster>> getAllprograms();


        Tuple<string, ProgramMaster> getSingleProgram(int id);
        public string Addprogram(ProgramMaster pm);
        public string Updateprogram(ProgramMaster pm);

    }
    public class ProgramService : IProgram
    {
        public ApplicationDbContext DbContext { get; }
        public ProgramService(ApplicationDbContext dbContext)
        {
            DbContext = dbContext;
        }
        public List<ProgramVm> GetPrograms(int UserId)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "usp_get_program_path";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@UserId", UserId);

                command.Parameters.Add(parameter);

                DbContext.Database.OpenConnection();

                var result = command.ExecuteReader();
                List<ProgramVm> resultList = new List<ProgramVm>();
                while (result.Read())
                {
                    ProgramVm resultVm = new ProgramVm();
                    resultVm.Id = result["Id"].ToString();
                    resultVm.Path = result["path"].ToString();
                    resultVm.Title = result["title"].ToString();
                    resultVm.Description = result["Descr"].ToString();
                    resultList.Add(resultVm);
                }
                return resultList;
            }

        }

        public Tuple<string, List<ProgramMaster>> getAllprograms()
        {
            string message = string.Empty;
            List<ProgramMaster> lstprm = new List<ProgramMaster>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_program_master";
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
                        ProgramMaster objprm = new ProgramMaster();
                        objprm.Id = Convert.ToInt32(result["Id"]);
                        objprm.P_title = result["P_title"].ToString();
                        objprm.Path = result["Path"].ToString();
                        objprm.Descr = result["Descr"].ToString();
                        objprm.Display_Sequence = Convert.ToInt32(result["Display_Sequence"]);
                        objprm.Status = Convert.ToInt32(result["Status"]);
                        lstprm.Add(objprm);
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
            return new Tuple<string, List<ProgramMaster>>(message, lstprm);

        }

        public string Addprogram(ProgramMaster pm)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_program_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "create";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@P_title";
                    parameter.SqlValue = pm.P_title;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Path";
                    parameter.SqlValue = pm.Path;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Descr";
                    parameter.SqlValue = pm.Descr;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Display_Sequence";
                    parameter.SqlValue = pm.Display_Sequence;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Status";
                    parameter.SqlValue = pm.Status;
                    parameter.SqlDbType = SqlDbType.Int;
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

        public string Updateprogram(ProgramMaster pm)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_program_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "update";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@P_title";
                    parameter.SqlValue = pm.P_title;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Path";
                    parameter.SqlValue = pm.Path;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Descr";
                    parameter.SqlValue = pm.Descr;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Id";
                    parameter.SqlValue = pm.Id;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Display_Sequence";
                    parameter.SqlValue = pm.Display_Sequence;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Status";
                    parameter.SqlValue = pm.Status;
                    parameter.SqlDbType = SqlDbType.Int;
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

        public Tuple<string, ProgramMaster> getSingleProgram(int id)
        {
            string message = string.Empty;
            ProgramMaster objprm = new ProgramMaster();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_program_master";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Action";
                    parameter.SqlValue = "get";
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Id";
                    parameter.SqlValue = id;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {

                        objprm.Id =Convert.ToInt32(result["Id"]);
                        objprm.P_title = result["P_title"].ToString();
                        objprm.Path= result["Path"].ToString();
                        objprm.Descr = result["Display_Sequence"].ToString();
                        objprm.Display_Sequence = Convert.ToInt32(result["Display_Sequence"]);
                        objprm.Status = Convert.ToInt32(result["status"]);
                        
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
            return new Tuple<string, ProgramMaster>(message, objprm);
        }
    }
}
