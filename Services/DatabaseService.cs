using System;
using System.Collections.Generic;
using Npgsql;
using IllnessTracker.Models;

namespace IllnessTracker.Services;

public class DatabaseService
{
    // ИСПРАВЛЕНО: HospitalDB
    private readonly string _connStr = "Host=localhost;Port=5432;Database=HospitalDB;Username=postgres;Password=1234";

    public List<IllnessRecordView> GetPage(int page, int size)
    {
        var list = new List<IllnessRecordView>();
        using var conn = new NpgsqlConnection(_connStr);
        conn.Open();
        var sql = @"SELECT ir.id, e.fullname, d.name, it.name, ir.startdate, ir.enddate 
                    FROM illnessrecords ir
                    JOIN employees e ON ir.employeeid = e.id
                    JOIN departments d ON e.departmentid = d.id
                    JOIN illnesstypes it ON ir.illnesstypeid = it.id
                    ORDER BY ir.startdate DESC
                    LIMIT @limit OFFSET @offset";
        
        using var cmd = new NpgsqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("limit", size);
        cmd.Parameters.AddWithValue("offset", (page - 1) * size);

        using var r = cmd.ExecuteReader();
        while (r.Read())
        {
            list.Add(new IllnessRecordView {
                Id = r.GetInt32(0),
                EmployeeName = r.GetString(1),
                DepartmentName = r.GetString(2),
                IllnessType = r.GetString(3),
                StartDate = r.GetDateTime(4),
                EndDate = r.GetDateTime(5),
                DurationDays = (r.GetDateTime(5) - r.GetDateTime(4)).Days
            });
        }
        return list;
    }

    public int GetTotal()
    {
        using var conn = new NpgsqlConnection(_connStr);
        conn.Open();
        using var cmd = new NpgsqlCommand("SELECT COUNT(*) FROM illnessrecords", conn);
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public void Delete(int id)
    {
        using var conn = new NpgsqlConnection(_connStr);
        conn.Open();
        using var cmd = new NpgsqlCommand("DELETE FROM illnessrecords WHERE id = @id", conn);
        cmd.Parameters.AddWithValue("id", id);
        cmd.ExecuteNonQuery();
    }

    public string GetStats()
    {
        try {
            using var conn = new NpgsqlConnection(_connStr);
            conn.Open();
            // Самый болеющий отдел
            var sql = @"SELECT d.name, SUM(ir.enddate - ir.startdate) 
                        FROM illnessrecords ir 
                        JOIN employees e ON ir.employeeid = e.id 
                        JOIN departments d ON e.departmentid = d.id 
                        GROUP BY d.name ORDER BY 2 DESC LIMIT 1";
            using var cmd = new NpgsqlCommand(sql, conn);
            using var r = cmd.ExecuteReader();
            if (r.Read()) return $"ЛИДЕР ПО БОЛЕЗНЯМ: {r.GetString(0)} ({r.GetInt32(1)} дн.)";
            return "Статистика пуста";
        } catch { return "Ошибка статистики"; }
    }
}