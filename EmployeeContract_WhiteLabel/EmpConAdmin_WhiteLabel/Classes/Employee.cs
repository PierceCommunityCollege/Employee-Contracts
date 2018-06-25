using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;

/// <summary>
/// Employee.cs
/// Written by R Cooke for Pierce College
/// A class to encapsulate information for Employees whose appointment letters are available.
/// </summary>
public class Employee
{
    private string _sid;
    public string SID
    {
        get { return _sid; }
        set { _sid = value; }
    }

    private string _empName;
    public string EmpName
    {
        get { return _empName; }
        set 
        {
            TextInfo ti = new CultureInfo("en-US", false).TextInfo;
            string strConvertedValue = ti.ToLower(value);
            _empName = ti.ToTitleCase(strConvertedValue); 
        }
    }
    
    public Employee()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static Employee GetBySID(string strSID)
    {
        Employee emp = new Employee();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(Settings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.Add("@sid", SqlDbType.VarChar).Value = strSID;

                conn.Open();
                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        DataRow dr = dt.Rows[0];
        emp.SID = dr["SID"].ToString();
        emp.EmpName = dr["EMP_NAME"].ToString();

        return emp;
    }

    public static List<Employee> GetEmployees()
    {
        List<Employee> employees = new List<Employee>();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(Settings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("usp_GetEmpList_vwEmployee", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;
                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        foreach (DataRow dr in dt.Rows)
        {
            Employee e = new Employee();
            e.SID = dr["SID"].ToString();
            e.EmpName = dr["EMP_NAME"].ToString();
            employees.Add(e);
        }

        return employees;
    }
}