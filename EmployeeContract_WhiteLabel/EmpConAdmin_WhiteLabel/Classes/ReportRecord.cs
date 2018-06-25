using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;

/// <summary>
/// ReportRecord.cs
/// Written by R Cooke for Pierce College
/// Encapsulate a single record to be output into a report of records in the database, for administrator purposes.
/// </summary>
public class ReportRecord
{
    private string _empName;
    public string EmpName
    {
        get { return _empName; }
        set { _empName = value; }
    }

    private string _sid;
    public string SID
    {
        get { return _sid; }
        set { _sid = value; }
    }

    private string _yrq;
    public string YRQ
    {
        get { return _yrq; }
        set { _yrq = value; }
    }

    private string _apptNo;
    public string ApptNo
    {
        get { return _apptNo; }
        set { _apptNo = value; }
    }

    private string _contractText;
    public string ContractText
    {
        get { return _contractText; }
        set { _contractText = value; }
    }

    private string _updatedOn;
    public string UpdatedOn
    {
        get { return _updatedOn; }
        set { _updatedOn = value; }
    }
    
    public ReportRecord()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static List<ReportRecord> SearchRecords(string strSID, string strYRQ)
    {
        List<ReportRecord> searchResults = new List<ReportRecord>();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(Settings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("usp_GetSearchResults_vwContractReport", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;
                if (strSID.Length > 0) { comm.Parameters.Add("@sid", SqlDbType.VarChar).Value = strSID; } //these params default to NULL and are optional
                if (strYRQ.Length > 0) { comm.Parameters.Add("@yrq", SqlDbType.VarChar).Value = strYRQ; }

                conn.Open();
                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                ReportRecord r = new ReportRecord();
                r.ApptNo = dr["apptNo"].ToString();
                r.ContractText = dr["contractText"].ToString();
                r.EmpName = dr["EMP_NAME"].ToString();
                r.SID = dr["SID"].ToString();
                r.UpdatedOn = dr["updatedOn"].ToString();
                r.YRQ = dr["yrq"].ToString();
                searchResults.Add(r);
            }
        }

        return searchResults;
    }
}