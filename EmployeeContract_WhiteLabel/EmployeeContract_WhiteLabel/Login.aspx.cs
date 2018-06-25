using System;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // flag to show if successfully logged in.
        bool bSuccessful = ECSecurity.AuthenticateUser(tbUsername.Text.Trim(), tbPassword.Text.Trim());

        // User logged in successfully
        if (bSuccessful)
        {
            Session["UserName"] = tbUsername.Text.Trim();

            // Redirect to the index page
            FormsAuthentication.RedirectFromLoginPage(tbUsername.Text, Persist.Checked);
        }
        else
        {
            // Show the user that they were unable to login
            Msg.Text = "Invalid credentials. If you do not know your employee PIN, please contact Payroll.";
            Msg.Visible = true;
        }
    }
}
