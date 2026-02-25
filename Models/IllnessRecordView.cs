using System;

namespace IllnessTracker.Models
{
    // Класс-представление для отображения данных в таблице
    public class IllnessRecordView
    {
        public int Id { get; set; }
        
        // Инициализируем пустой строкой, чтобы C# не ругался на возможный null
        public string EmployeeName { get; set; } = string.Empty;
        public string DepartmentName { get; set; } = string.Empty;
        public string IllnessType { get; set; } = string.Empty;
        
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int DurationDays { get; set; }
    }
}