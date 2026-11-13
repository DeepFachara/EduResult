namespace StudentResultManagement.Models
{
    public class Subject
    {
        public int SubjectID { get; set; }
        public string SubjectName { get; set; }
        public int MaxMarks { get; set; } = 100;
        public int PassingMarks { get; set; } = 40;
    }
}
