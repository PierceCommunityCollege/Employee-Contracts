using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// ECUtility.cs
/// Written by R Cooke for Pierce College
/// </summary>
public class Utility
{
	public Utility()
	{
	}

    /// <summary>
    /// Produces an MD5 hash of the specified input string.
    /// </summary>
    /// <param name="input"></param>
    /// <returns>string</returns>
    public static string GenerateRequestID(string input)
    {
        // Create a new instance of the MD5CryptoServiceProvider object.
        MD5 md5Hasher = MD5.Create();

        // Convert the input string to a byte array and compute the hash.
        byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

        // Create a new Stringbuilder to collect the bytes
        // and create a string.
        StringBuilder sBuilder = new StringBuilder();

        // Loop through each byte of the hashed data 
        // and format each one as a hexadecimal string.
        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }

        // Return the hexadecimal string.
        return sBuilder.ToString().ToUpper();
    }
}
