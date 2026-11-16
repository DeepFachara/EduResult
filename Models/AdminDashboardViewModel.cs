namespace StudentResultManagement.Models
{
    public class AdminDashboardViewModel
    {
        public int TotalStudents { get; set; }
        public int TotalSubjects { get; set; }
        public int TotalResults { get; set; }
        public int TotalPassed { get; set; }
        public int TotalFailed { get; set; }
        public double PassPercentage { get; set; }
        public double AverageScore { get; set; }

        // Result Publishing Status
        public bool IsResultPublished { get; set; } = true;
    }
}
