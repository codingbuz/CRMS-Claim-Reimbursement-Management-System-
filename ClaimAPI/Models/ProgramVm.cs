namespace ClaimAPI.Models
{
    public class ProgramVm
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Path { get; set; }
        public string Description { get; set; }
    }

    public class ProgramsRights
    {
        public string id { get; set; }
        public int ischecked { get; set; }
    }
}
