using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;

/// <summary>
/// YRQ.cs
/// Written by R Cooke for Pierce College
/// Encapsulate Year/Quarter information.
/// </summary>
public class YRQ
{
    private string _yrqCode;
    public string YRQCode
    {
        get { return _yrqCode; }
        set { _yrqCode = value; }
    }

    private string _yrqName;
    public string YRQName
    {
        get { return _yrqName; }
        set 
        {
            TextInfo ti = new CultureInfo("en-US", false).TextInfo;
            string strConvertedValue = ti.ToLower(value);
            _yrqName = ti.ToTitleCase(strConvertedValue); 
        }
    }
    
    public YRQ()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static List<YRQ> GetYRQS()
    {
        List<YRQ> yrqs = new List<YRQ>();

        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(Settings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("usp_GetYRQList_vwYRQ", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;

                conn.Open();
                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        foreach (DataRow dr in dt.Rows)
        {
            YRQ yrq = new YRQ();
            yrq.YRQCode = dr["YRQ"].ToString();
            yrq.YRQName = dr["ABBR_TITLE"].ToString();
            yrqs.Add(yrq);
        }

        return yrqs;
    }
}