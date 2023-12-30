
namespace ClaimAPI.Models
{
 
        public class Users
        {
            public int Id { get; set; }
            public string UserId { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string UserName { get; set; }

        }

    public class UserRights
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Descr { get; set; }
        public string Ischecked { get; set; }

    }
    public class UserVm
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string UserName { get; set; }
        public string ManagerId { get; set; }
        public string ManagerName { get; set; }
        public string Password { get; set; }
        public string Status { get; set; }


    }
    public class UserLogin
        {
            public string UserId { get; set; }
            public string Password { get; set; }
        }
    
    public class AssignRoleModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
    public class Entity
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class RoleMaster
    {
        public int Id { get; set; }
        public string RoleName { get; set; }

        public string Status { get; set; }
    }

    public class UserName
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Role { get; set; }
    }

    public class RoleName
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public string Ischecked { get; set; }

    }
    public class ProgramMaster
    {
        public int Id { get; set; }
        public string P_title { get; set; }
        public string Path { get; set; }

        public string Descr { get; set; }
        public int Display_Sequence { get; set; }
        public int Status { get; set; }
    }

    public class UserEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Role { get; set; }
    }
}
