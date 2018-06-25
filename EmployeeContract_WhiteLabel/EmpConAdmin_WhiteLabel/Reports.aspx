<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="Reports" Codebehind="Reports.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ContentPlaceHolder1_gvSearchResults").tablesorter();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1 id="title">Employee Contract Reports</h1>

    Search database records by:<br />
    <table cellpadding="2" cellspacing="2">
        <tr>
            <td><strong>Employee:</strong></td>
            <td><strong>YRQ:</strong></td>
        </tr>
        <tr>
            <td><asp:ListBox ID="lbEmpName" runat="server" Rows="10" SelectionMode="Multiple" ToolTip="Ctrl + left-click to make multiple selections or un-select."></asp:ListBox></td>
            <td><asp:ListBox ID="lbYRQ" runat="server" Rows="10" SelectionMode="Multiple" ToolTip="Ctrl + left-click to make multiple selections or un-select."></asp:ListBox></td>
        </tr>
    </table>
    <asp:Button ID="btnSearch" runat="server" Text="Search" 
        onclick="btnSearch_Click" /><br />
        All search criteria are optional. Clear selections to search all available employees and/or YRQs.
        <br /><br />
        
    <asp:Label ID="lblSearchSummary" runat="server"></asp:Label><br />
    <asp:GridView ID="gvSearchResults" runat="server" EmptyDataText="No records to display." GridLines="Horizontal" Width="800px" AutoGenerateColumns="false">
    <HeaderStyle BackColor="#a51d4b" ForeColor="White" Font-Bold="true" />
    <RowStyle VerticalAlign="Top" />
    <AlternatingRowStyle BackColor="Silver" />
    <Columns>
        <asp:BoundField HeaderText="SID" DataField="SID" />
        <asp:BoundField HeaderText="Name" DataField="EmpName" />
        <asp:BoundField HeaderText="YRQ" DataField="YRQ" />
        <asp:BoundField HeaderText="Appt" DataField="ApptNo" />
        <asp:BoundField HeaderText="Excerpt" DataField="ContractText" />
        <asp:BoundField HeaderText="Updated" DataField="UpdatedOn" />
    </Columns>
    </asp:GridView>

</asp:Content>

