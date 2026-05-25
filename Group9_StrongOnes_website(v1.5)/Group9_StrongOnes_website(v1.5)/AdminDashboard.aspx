<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="AdminDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Dashboard - Health & Fitness</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        body { font-family: Arial, sans-serif; background-color: #eceff1; padding: 30px; }
        .dashboard-container { max-width: 900px; margin: auto; }
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .card-title { margin-top: 0; color: #333; border-bottom: 2px solid #d32f2f; padding-bottom: 10px; }
        
        .grid-view { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 15px; }
        .grid-view th, .grid-view td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        .grid-view th { background-color: #f4f4f4; color: #333; }
        .grid-view tr:hover { background-color: #f9f9f9; }
        
        .btn-logout { background-color: #333; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        
        /* New styling for the Promote button */
        .btn-promote { background-color: #3498db; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; margin-right: 5px; }
        .btn-promote:hover { background-color: #2980b9; }
        
        .btn-delete { background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; }
        .btn-delete:hover { background-color: #c0392b; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2 style="color: #333;">Admin Control Panel - <asp:Label ID="lblAdminName" runat="server" ForeColor="#d32f2f"></asp:Label></h2>
                <asp:Button ID="btnLogout" runat="server" Text="Secure Logout" OnClick="btnLogout_Click" CssClass="btn-logout" />
            </div>

            <div class="card">
                <h3 class="card-title">Manage Registered Users</h3>
                
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="grid-view" 
                              DataKeyNames="UserId" OnRowDeleting="gvUsers_RowDeleting" OnRowCommand="gvUsers_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="UserId" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="Email" HeaderText="Email Address" />
                        <asp:BoundField DataField="Role" HeaderText="Role" />
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnPromote" runat="server" CommandName="Promote" CommandArgument='<%# Eval("UserId") %>' 
                                            Text="Make Admin" CssClass="btn-promote" />
                                            
                                <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete User" CssClass="btn-delete"
                                            OnClientClick="return confirm('WARNING: Are you sure you want to permanently delete this user?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>  
            </div>
        </div>
    </form>
</body>
</html>