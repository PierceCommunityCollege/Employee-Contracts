using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace EmpConReader2017
{
    class Program
    {
        static void Main(string[] args)
        {

            const string strConnection = "Data Source=SOME_SERVER_NAME;Initial Catalog=EmpCon;User ID=ecdbuser;Password=SOME_COMPLEX_PASSWORD";

            const string strDirName = @"\\your\drivepath\to\byrequest\processed\employee-contracts";

            var di = new DirectoryInfo(strDirName);

            var files = di.GetFiles();

            foreach (var fo in files)
            {
                if (fo.Extension.Equals(".txt"))
                {
                    //UPDATE 04.18.2017 RCooke: we need to be able to read in multiple appointment letters from
                    //the same file. Handle each letter as *its own insert*, because in the past we've occasionally
                    //seen records for two different employees get printed to the same letter.
                    var strAllText = File.ReadAllText(strDirName + "\\" + fo.Name);
                    strAllText = strAllText.Replace("\r\n", "<br />");
                    strAllText = strAllText.Replace("\f", "");
                    var startPosition = 0;
                    var letterEndPosition = strAllText.IndexOf("CANCELLATION, THE EMPLOYEE SHALL BE PAID FOR SESSIONS HELD.", StringComparison.Ordinal);

                    while (letterEndPosition != - 1)
                    {
                        var thisLetterText = strAllText.Substring(startPosition, ((letterEndPosition + 64) - startPosition));
                        if (!thisLetterText.EndsWith(">")) //close the line break tag, if it got chopped off
                        {
                            thisLetterText = thisLetterText + ">";
                        }

                        var strSid = thisLetterText.Substring(33, 9);
                        var strYrq = thisLetterText.Substring(43, 4);
                        var strApptNo = thisLetterText.Substring(48, 2);

                        if ((!strSid.Contains(" ")) && (!strYrq.Contains(" ")) && (!strApptNo.Contains(" ")))
                        {
                            using (var conn = new SqlConnection(strConnection))
                            {
                                using (var comm = new SqlCommand("usp_Insert_tblContract", conn))
                                {
                                    comm.CommandType = CommandType.StoredProcedure;
                                    comm.Parameters.Add("@sid", SqlDbType.VarChar, 9).Value = strSid;
                                    comm.Parameters.Add("@yrq", SqlDbType.VarChar, 4).Value = strYrq;
                                    comm.Parameters.Add("@apptNo", SqlDbType.VarChar, 2).Value = strApptNo;
                                    comm.Parameters.Add("@contractText", SqlDbType.VarChar).Value = HttpUtility.HtmlEncode(thisLetterText);

                                    conn.Open();
                                    comm.ExecuteNonQuery();
                                }
                            }
                        }
                        startPosition = letterEndPosition + 65;
                        letterEndPosition =
                            strAllText.IndexOf("CANCELLATION, THE EMPLOYEE SHALL BE PAID FOR SESSIONS HELD.",
                                startPosition, StringComparison.Ordinal);
                    }
                    
                }

                //check file's modified date
                var lastWriteTime = fo.LastWriteTime;
                //if old, check for existence of archive directory and move file
                if (lastWriteTime > DateTime.Now.AddDays(-30)) continue;
                if (!Directory.Exists(strDirName + @"\Archive"))
                {
                    Directory.CreateDirectory(strDirName + @"\Archive");
                }

                try
                {
                    //if a file by this name already exists in the archive directory, append a digit until we find an original name
                    var iCounter = 1;
                    var strNewFilename = fo.Name;
                    while (File.Exists(strDirName + @"\Archive\" + strNewFilename))
                    {
                        strNewFilename = fo.Name.Replace(fo.Extension, "") + "_" + iCounter + fo.Extension;
                        iCounter++;
                    }
                    File.Move(strDirName + "\\" + fo.Name, strDirName + @"\Archive\" + strNewFilename);
                    //Console.WriteLine("Archived file " + fo.Name + ": Last Updated " + lastWriteTime.ToShortDateString()); //debugging only
                }
                catch (Exception ex)
                {
                    //Console.WriteLine("Failed moving file " + fo.Name + " to archive directory " + strDirName + "\\Archive" + ": " +
                    //ex.Message); //debugging only
                }
            }

        }
    }
}
