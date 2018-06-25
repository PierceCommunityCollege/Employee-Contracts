using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindEmpNames();
            BindYRQs();
        }
    }

    private void BindEmpNames()
    {
        lbEmpName.Items.Clear();
        List<Employee> employees = Employee.GetEmployees();

        foreach (Employee emp in employees)
        {
            lbEmpName.Items.Add(new ListItem(emp.EmpName, emp.SID));
        }
    }

    private void BindYRQs()
    {
        lbYRQ.Items.Clear();
        List<YRQ> yrqs = YRQ.GetYRQS();

        foreach (YRQ y in yrqs)
        {
            lbYRQ.Items.Add(new ListItem(y.YRQCode + " - " + y.YRQName, y.YRQCode));
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblSearchSummary.Text = "";
        List<ReportRecord> searchResults = ReportRecord.SearchRecords(ParseSelected(lbEmpName), ParseSelected(lbYRQ));

        gvSearchResults.DataSource = searchResults;
        gvSearchResults.DataBind();

        if (gvSearchResults.Rows.Count > 0) //apply THEAD tags so we can use jQuery TableSorter
        {
            gvSearchResults.UseAccessibleHeader = true;
            gvSearchResults.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvSearchResults.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }

    protected string ParseSelected(ListBox lb)
    {
        StringBuilder strSelectedValues = new StringBuilder();

        foreach (ListItem li in lb.Items)
        {
            if (li.Selected)
            {
                strSelectedValues.Append(li.Value + ",");
            }
        }

        return strSelectedValues.ToString();
    }
}