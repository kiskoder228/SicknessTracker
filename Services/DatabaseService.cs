using System;
using System.Collections.Generic;
using Npgsql;
using IllnessTracker.Models;

namespace IllnessTracker.Services;

public class DatabaseService
{
    private readonly string _connectionString = "Host=localhost;Port=5432;Database=HospitalDB;Username=postgres;Password=1234";

    private NpgsqlConnection GetConnection() => new NpgsqlConnection(_connectionString);

    public List<IllnessRecordView> GetPage(int page, int size)
    {
        var list = new List<IllnessRecordView>();

        try 
        {
            using var conn = GetConnection();
            conn.Open();

            var sql = @"
                SELECT ir.id, e.fullname, d.name as dept, it.name as illness, ir.startdate, ir.enddate 
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
                    Id = r.GetInt32(r.GetOrdinal("id")),
                    EmployeeName = r.GetString(r.GetOrdinal("fullname")),
                    DepartmentName = r.GetString(r.GetOrdinal("dept")),
                    IllnessType = r.GetString(r.GetOrdinal("illness")),
                    StartDate = r.GetDateTime(r.GetOrdinal("startdate")),
                    EndDate = r.GetDateTime(r.GetOrdinal("enddate")),
                    DurationDays = (r.GetDateTime(r.GetOrdinal("enddate")) - r.GetDateTime(r.GetOrdinal("startdate"))).Days
                });
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[DB ERROR]: {ex.Message}");
        }

        return list;
    }

    public int GetTotal()
    {
        try 
        {
            using var conn = GetConnection();
            conn.Open();
            using var cmd = new NpgsqlCommand("SELECT COUNT(*) FROM illnessrecords", conn);
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
        catch { return 0; }
    }

    public void Delete(int id)
    {
        try 
        {
            using var conn = GetConnection();
            conn.Open();
            using var cmd = new NpgsqlCommand("DELETE FROM illnessrecords WHERE id = @id", conn);
            cmd.Parameters.AddWithValue("id", id);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) 
        { 
            Console.WriteLine($"[DELETE ERROR]: {ex.Message}"); 
        }
    }

    public string GetStats()
    {
        try 
        {
            using var conn = GetConnection();
            conn.Open();
            var sql = @"
                SELECT d.name, SUM(ir.enddate - ir.startdate) 
                FROM illnessrecords ir 
                JOIN employees e ON ir.employeeid = e.id 
                JOIN departments d ON e.departmentid = d.id 
                GROUP BY d.name 
                ORDER BY 2 DESC 
                LIMIT 1";

            using var cmd = new NpgsqlCommand(sql, conn);
            using var r = cmd.ExecuteReader();
            if (r.Read())
            {
                return $"ЛИДЕР ПО БОЛЕЗНЯМ: {r.GetString(0)} ({r.GetValue(1)} дн.)";
            }
            return "ДАННЫЕ ДЛЯ СТАТИСТИКИ ОТСУТСТВУЮТ";
        }
        catch (Exception ex)
        {
            return $"БАЗА НЕДОСТУПНА: {ex.Message}";
        }
    }
}