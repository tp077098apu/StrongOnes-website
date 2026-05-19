<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestDB.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Master_Database %>" SelectCommand="SELECT * FROM [Users]"></asp:SqlDataSource>
</body>
</html>
