<%@ Page Language="C#" AutoEventWireup="true" Inherits="View" Codebehind="View.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your College - Employee Contract</title>
    <link rel="Stylesheet" type="text/css" href="printfriendly.css" />
    <script type="text/javascript" src="jquery-1.7.1.js"></script>
    <%--<script type="text/javascript">
        $(document).ready(function() {
        $('#note').fadeOut(5000);
        });
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
    <asp:Panel ID="pnlContractText" runat="server"></asp:Panel>
    
    </div>

    <div id="footer">
        Provide footer information here.
        <br /><br /> 
    </div>
    </form>
</body>
</html>
