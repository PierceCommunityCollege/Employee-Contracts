using System;
using System.Web;
using System.Web.UI;

public partial class View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now);
        
        if (!Page.IsPostBack)
        {
            if (!(Request.QueryString["Request"] == null) && Page.User.Identity.IsAuthenticated)
            {
                pnlContractText.Controls.Add(new LiteralControl(Contract.GetContractByID(Request.QueryString["Request"].ToString().Trim()).ContractText));
            }
        }
    }
}
