using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// ECSettings.cs
/// Written by R Cooke for Pierce College
/// Common settings for the Employee Contracts Administrator app
/// </summary>
public class Settings
{
	public Settings()
	{
	}

    /// <summary>
    /// Application-wide connection string. Stored in web.config
    /// </summary>
    public static string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
}
