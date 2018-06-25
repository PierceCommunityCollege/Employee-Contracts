<%@ Page Language="C#" AutoEventWireup="true" Inherits="_Default" Codebehind="Default.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your College - Employee Contract</title>
    <link rel="Stylesheet" type="text/css" href="basic.css" />
    <script type="text/javascript" src="jquery-1.7.1.js"></script>
    <script type="text/javascript" src="jquery.tablesorter.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#gvContracts").tablesorter();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="wrap">
    
    <div id="header"><h2>Employee Contracts Viewer</h2></div>
    
    <div id="body">
    
    <p>Select a contract record to view. Use your browser's 'Print Preview' function to format your contract for printing.</p>
    <br />
    
    <asp:GridView ID="gvContracts" runat="server" AutoGenerateColumns="false" 
            GridLines="Horizontal" AlternatingRowStyle-BackColor="Silver" 
            EmptyDataText="No contracts to display." Width="500" CellPadding="4" 
            CellSpacing="4" ondatabound="gvContracts_DataBound">
    <HeaderStyle BackColor="#a51d4b" ForeColor="White" HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField HeaderText="YRQ" DataField="YRQ" />
        <asp:BoundField HeaderText="Appointment" DataField="ApptNo" />
        <asp:BoundField HeaderText="Date" DataField="ContractText" />
        <asp:HyperLinkField HeaderText="Action" Text="View" DataNavigateUrlFields="RequestNumber" DataNavigateUrlFormatString="View.aspx?Request={0}" Target="_blank" />
    </Columns>
    </asp:GridView>
    <br /><br />
    <a href="Logout.aspx">Log Out</a>
    
    </div>
    
    </div>
    </form>
</body>
</html>
