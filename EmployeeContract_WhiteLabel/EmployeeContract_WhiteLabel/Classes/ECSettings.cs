using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// ECSettings.cs
/// Written by R Cooke for Pierce College
/// Application settings for the EmployeeContracts project.
/// </summary>
public class ECSettings
{
	public ECSettings()
	{
	}

    /// <summary>
    /// Application-wide connection string. Stored in web.config
    /// </summary>
    public static string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
}
