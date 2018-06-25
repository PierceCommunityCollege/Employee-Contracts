using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now);
        
        if (!Page.User.Identity.IsAuthenticated)
        {
            Response.Redirect("Login.aspx");
        }
        
        if (!Page.IsPostBack)
        {
            BindContracts();
        }

    }

    private void BindContracts()
    {
        List<Contract> contractsForEmployee = Contract.GetContractsForEmployee(Page.User.Identity.Name);

        gvContracts.DataSource = contractsForEmployee;
        gvContracts.DataBind();
    }

    protected void gvContracts_DataBound(object sender, EventArgs e)
    {
        if (this.gvContracts.Rows.Count > 0)
        {
            gvContracts.UseAccessibleHeader = true;
            gvContracts.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvContracts.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }
}
