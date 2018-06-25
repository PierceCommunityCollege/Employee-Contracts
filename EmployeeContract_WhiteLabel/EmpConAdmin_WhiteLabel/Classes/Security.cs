using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;

/// <summary>
/// ECSecurity.cs
/// Written by R Cooke for Pierce College
/// Common methods related to data validation and security for the Employee Contracts Administrator.
/// </summary>
public class Security
{
	public Security()
	{
	}

    public static bool AuthenticateUser(String strUserName, String strPassword)
    {
        bool isAuthenticated = false;
        using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
        {
            using (SqlCommand cm = new SqlCommand("usp_AuthenticateUser_vw_Employee", cn))
            {
                cm.CommandType = CommandType.StoredProcedure;
                cm.Parameters.Add("@UserName", SqlDbType.VarChar, 50);
                cm.Parameters["@UserName"].Value = strUserName;
                cm.Parameters.Add("@UserPassword", SqlDbType.VarChar, 50);
                cm.Parameters["@UserPassword"].Value = strPassword;
                cm.Parameters.Add("@IsAuthenticated", SqlDbType.Bit);
                cm.Parameters["@IsAuthenticated"].Direction = ParameterDirection.Output;

                cn.Open();
                cm.ExecuteNonQuery();

                isAuthenticated = Convert.ToBoolean(cm.Parameters["@IsAuthenticated"].Value);
            }
        }
        return isAuthenticated;
    }
}
