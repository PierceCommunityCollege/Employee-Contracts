using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;

/// <summary>
/// Contract.cs
/// Written by R Cooke for Pierce College
/// A class to encapsulate Contract records from the database.
/// </summary>
public class Contract
{
    private string _recordID;
    public string RecordID
    {
        get { return _recordID; }
        set { _recordID = value; }
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
        set { _contractText = HttpUtility.HtmlDecode(value); }
    }

    private string _requestNumber;
    public string RequestNumber
    {
        get { return _requestNumber; }
        set { _requestNumber = value; }
    }
    
    public Contract()
	{
	}

    public static List<Contract> GetContractsForEmployee(string strEmpID)
    {
        List<Contract> contracts = new List<Contract>();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(ECSettings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("usp_GetRecord_tblContract", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.Add("@sid", SqlDbType.VarChar).Value = strEmpID;

                conn.Open();
                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        foreach (DataRow r in dt.Rows)
        {
            Contract contract = new Contract();
            contract.RecordID = r[0].ToString();
            contract.RequestNumber = ECUtility.GenerateRequestID(r[1].ToString().Trim() + r[2].ToString().Trim() + r[3].ToString().Trim()); //Note: we are concatening SID + yrq + apptNo to generate a unique encrypted ID, in order to obfuscate selection criteria.
            contract.SID = r[1].ToString();
            contract.YRQ = r[2].ToString();
            contract.ApptNo = r[3].ToString();
            contract.ContractText = r[4].ToString();
            contracts.Add(contract);
        }

        return contracts;
    }

    public static Contract GetContractByID(string strRequestID)
    {
        Contract selectedContract = new Contract();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(ECSettings.ConnectionString))
        {
            using (SqlCommand comm = new SqlCommand("usp_GetRecordByID_tblContract", conn))
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.Parameters.Add("@request_id", SqlDbType.VarChar).Value = strRequestID;

                da.SelectCommand = comm;
                da.Fill(dt);
            }
        }

        foreach (DataRow row in dt.Rows)
        {
            selectedContract.RecordID = row["record_id"].ToString();
            selectedContract.SID = row["sid"].ToString();
            selectedContract.YRQ = row["yrq"].ToString();
            selectedContract.ApptNo = row["apptNo"].ToString();
            selectedContract.ContractText = row["contractText"].ToString();
        }

        return selectedContract;
    }
}
