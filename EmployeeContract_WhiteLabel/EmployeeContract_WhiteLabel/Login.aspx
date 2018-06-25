<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" Codebehind="Login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Contracts - Log In</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="font-size: 14px; width: 310px; font-family: Tahoma;margin-left:auto;margin-right:auto; color: black;">
            <tr>
                <td colspan="2" align="center"><h2>Employee Contracts Login</h2></td>
            </tr>
            <tr>
                <td>Employee ID:</td>
                <td style="width: 186px">
                    <asp:TextBox ID="tbUsername" TextMode="Password" runat="server" Width="165px" />
                </td>
            </tr>
            <tr>
                <td>PIN:</td>
                <td style="width: 186px">
                    <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" Width="165px" />
                </td>
            </tr>
            <tr>
                <td>Remember me?</td>
                <td style="width: 186px"><asp:CheckBox ID="Persist" runat="server" />
                    
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td style="width: 186px">
                    <br />
                    <asp:Button ID="btnLogin" Text="Log On" runat="server" Width="88px" OnClick="btnLogin_Click" /></td>
            </tr>
            <tr>
                <td colspan="2"><span class="note">NOTE: If your PIN number starts with a zero(s), please DO NOT type that zero(s) into the PIN field. </span></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Label ID="Msg" runat="server" ForeColor="Red" Text="Invalid credentials. Please try again." Visible="False" ></asp:Label></td>
            </tr>
        </table>
        </div>
    </form>
</body>
</html>
