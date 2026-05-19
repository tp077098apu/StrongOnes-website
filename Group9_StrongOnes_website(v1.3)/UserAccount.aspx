<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserAccount.aspx.cs" Inherits="UserDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Dashboard - Health & Fitness Education</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 30px; }
        .dashboard-container { max-width: 600px; margin: auto; }
        .card { background: white; padding: 25px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .card-title { margin-top: 0; color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 10px; }
        .data-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #eee; }
        .data-label { font-weight: bold; color: #555; }
        .data-value { color: #000; }
        .btn-logout { background-color: #d33; color: white; padding: 10px 15px; border: none; border-radius: 4px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-logout:hover { background-color: #b32424; }
        .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            
            <div class="header-flex">
                <h2 style="color: #333; margin: 0;">Welcome, <asp:Label ID="lblWelcomeName" runat="server" Text="User"></asp:Label>!</h2>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn-logout" />
            </div>

            <div class="card">
                <h3 class="card-title">Your Profile Overview</h3>
                
                <div class="data-row">
                    <span class="data-label">Email:</span>
                    <asp:Label ID="lblEmail" runat="server" CssClass="data-value"></asp:Label>
                </div>
                <div class="data-row">
                    <span class="data-label">Gender:</span>
                    <asp:Label ID="lblGender" runat="server" CssClass="data-value"></asp:Label>
                </div>
                <div class="data-row">
                    <span class="data-label">Age:</span>
                    <asp:Label ID="lblAge" runat="server" CssClass="data-value"></asp:Label>
                </div>
                <div class="data-row">
                    <span class="data-label">Height:</span>
                    <asp:Label ID="lblHeight" runat="server" CssClass="data-value"> cm</asp:Label>
                </div>
                <div class="data-row">
                    <span class="data-label">Current Weight:</span>
                    <asp:Label ID="lblWeight" runat="server" CssClass="data-value"> kg</asp:Label>
                </div>
                <div class="data-row">
                    <span class="data-label">Primary Fitness Goal:</span>
                    <asp:Label ID="lblGoal" runat="server" CssClass="data-value" Font-Bold="true" ForeColor="#4CAF50"></asp:Label>
                </div>
            </div>

        </div>
    </form>
</body>
</html>