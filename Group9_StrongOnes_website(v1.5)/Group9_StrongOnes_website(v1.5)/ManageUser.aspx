<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUser.aspx.cs" Inherits="ManageUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StrongOnes – Manage Users</title>
    <link href="admin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-wrapper">

            <!-- SIDEBAR -->
            <aside class="sidebar">
                <div class="sidebar-logo">
                    <div class="logo">Strong<span>Ones</span></div>
                    <div class="admin-tag">Admin Portal</div>
                </div>
                <nav class="sidebar-nav">
                    <div class="nav-label">Main</div>
                    <a href="AdminHomepage.aspx">
                        <i class="fa-solid fa-gauge"></i> Dashboard
                    </a>
                    <div class="nav-label">Manage</div>
                    <a href="ManageUsers.aspx" class="active">
                        <i class="fa-solid fa-users"></i> Manage Users
                    </a>
                    <a href="ManageWorkouts.aspx">
                        <i class="fa-solid fa-dumbbell"></i> Manage Workouts
                    </a>
                    <a href="ManageNutrition.aspx">
                        <i class="fa-solid fa-bowl-food"></i> Manage Nutrition
                    </a>
                </nav>
                <div class="sidebar-footer">
                            <asp:Button ID="btnShowLogout" runat="server"
                                Text="Logout"
                                CssClass="btn-logout"
                                OnClick="btnShowLogout_Click" />
                        </div>
            </aside>

            <!-- MAIN CONTENT -->
            <div class="main-content">

                <!-- Topbar -->
                <div class="topbar">
                    <div>
                        <h1>Manage Users</h1>
                        <p>View, add, edit and remove user accounts</p>
                    </div>
                    <span class="admin-name">
                        <asp:Label ID="lblAdminName" runat="server" Text="Admin" />
                    </span>
                </div>

                <!-- Page Body -->
                <div class="page-body">

                    <!-- Messages -->
                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                        <div class="msg msg-success">
                            <asp:Label ID="lblSuccess" runat="server" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlError" runat="server" Visible="false">
                        <div class="msg msg-error">
                            <asp:Label ID="lblError" runat="server" />
                        </div>
                    </asp:Panel>

                    <!-- Page Header -->
                    <div class="page-header">
                        <h2>
                            All Users
                            (<asp:Label ID="lblUserCount" runat="server" Text="0" />)
                        </h2>
                        <asp:Button ID="btnShowAddForm" runat="server"
                            Text="+ Add New User"
                            CssClass="btn btn-purple"
                            OnClick="btnShowAddForm_Click" />
                    </div>

                    <!-- ADD USER FORM -->
                    <asp:Panel ID="pnlAddUser" runat="server" Visible="false">
                        <div class="form-panel">
                            <h3>Add New User</h3>
                            <div class="form-grid">

                                <div class="form-group">
                                    <label>Username</label>
                                    <asp:TextBox ID="txtAddUsername" runat="server"
                                        placeholder="Enter username" />
                                    <asp:RequiredFieldValidator runat="server"
                                        ControlToValidate="txtAddUsername"
                                        ValidationGroup="AddUser"
                                        ErrorMessage="Username is required."
                                        ForeColor="Red" />
                                </div>

                                <div class="form-group">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtAddEmail" runat="server"
                                        placeholder="Enter email"
                                        TextMode="Email" />
                                    <asp:RequiredFieldValidator runat="server"
                                        ControlToValidate="txtAddEmail"
                                        ValidationGroup="AddUser"
                                        ErrorMessage="Email is required."
                                        ForeColor="Red" />
                                    <asp:RegularExpressionValidator runat="server"
                                        ControlToValidate="txtAddEmail"
                                        ValidationGroup="AddUser"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ErrorMessage="Enter a valid email."
                                        ForeColor="Red" />
                                </div>

                                <div class="form-group">
                                    <label>Password</label>
                                    <asp:TextBox ID="txtAddPassword" runat="server"
                                        placeholder="Enter password"
                                        TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server"
                                        ControlToValidate="txtAddPassword"
                                        ValidationGroup="AddUser"
                                        ErrorMessage="Password is required."
                                        ForeColor="Red" />
                                </div>

                                <div class="form-group">
                                    <label>Age</label>
                                    <asp:TextBox ID="txtAddAge" runat="server" TextMode="Number" /> </div>

                                <div class="form-group">
                                    <label>Gender</label>
                                    <asp:DropDownList ID="ddlAddGender" runat="server"> <asp:ListItem Value="">Select...</asp:ListItem>
                                        <asp:ListItem Value="Male">Male</asp:ListItem>
                                        <asp:ListItem Value="Female">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group">
                                    <label>Weight (kg)</label>
                                    <asp:TextBox ID="txtAddWeight" runat="server" /> </div>

                                <div class="form-group">
                                    <label>Height (cm)</label>
                                    <asp:TextBox ID="txtAddHeight" runat="server" /> </div>

                                <div class="form-group">
                                    <label>Fitness Goal</label>
                                    <asp:DropDownList ID="ddlAddGoal" runat="server"> <asp:ListItem Value="">Select...</asp:ListItem>
                                        <asp:ListItem Value="Weight Loss">Weight Loss</asp:ListItem>
                                        <asp:ListItem Value="Muscle Gain">Muscle Gain</asp:ListItem>
                                        <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group">
                                    <label>Role</label>
                                    <asp:DropDownList ID="ddlAddRole" runat="server">
                                        <asp:ListItem Value="Customer">Customer</asp:ListItem>
                                        <asp:ListItem Value="Admin">Admin</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                            </div>
                            <div class="form-actions">
                                <asp:Button ID="btnAddUser" runat="server"
                                    Text="Add User"
                                    CssClass="btn btn-purple"
                                    ValidationGroup="AddUser"
                                    OnClick="btnAddUser_Click" />
                                <asp:Button ID="btnCancelAdd" runat="server"
                                    Text="Cancel"
                                    CssClass="btn btn-gray"
                                    CausesValidation="false"
                                    OnClick="btnCancelAdd_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- EDIT USER FORM -->
                    <asp:Panel ID="pnlEditUser" runat="server" Visible="false">
                        <div class="form-panel">
                            <h3>Edit User</h3>
                            <asp:HiddenField ID="hfEditUserID" runat="server" />
                            <div class="form-grid">

                                <div class="form-group">
                                    <label>Username</label>
                                    <asp:TextBox ID="txtEditUsername" runat="server" />
                                    <asp:RequiredFieldValidator runat="server"
                                        ControlToValidate="txtEditUsername"
                                        ValidationGroup="EditUser"
                                        ErrorMessage="Username is required."
                                        ForeColor="Red" />
                                </div>

                                <div class="form-group">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtEditEmail" runat="server" />
                                    <asp:RequiredFieldValidator runat="server"
                                        ControlToValidate="txtEditEmail"
                                        ValidationGroup="EditUser"
                                        ErrorMessage="Email is required."
                                        ForeColor="Red" />
                                </div>

                                <div class="form-group">
                                    <label>Age</label>
                                    <asp:TextBox ID="txtEditAge" runat="server" TextMode="Number" /> 
                                </div>

                                <div class="form-group">
                                    <label>Gender</label>
                                    <asp:DropDownList ID="ddlEditGender" runat="server"> 
                                        <asp:ListItem Value="">Select...</asp:ListItem>
                                        <asp:ListItem Value="Male">Male</asp:ListItem>
                                        <asp:ListItem Value="Female">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group">
                                    <label>Weight (kg)</label>
                                    <asp:TextBox ID="txtEditWeight" runat="server" /> 
                                </div>

                                <div class="form-group">
                                    <label>Height (cm)</label>
                                    <asp:TextBox ID="txtEditHeight" runat="server" /> 
                                </div>

                                <div class="form-group">
                                    <label>Fitness Goal</label>
                                    <asp:DropDownList ID="ddlEditGoal" runat="server"> 
                                        <asp:ListItem Value="">Select...</asp:ListItem>
                                        <asp:ListItem Value="Weight Loss">Weight Loss</asp:ListItem>
                                        <asp:ListItem Value="Muscle Gain">Muscle Gain</asp:ListItem>
                                        <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group">
                                    <label>Role</label>
                                    <asp:DropDownList ID="ddlEditRole" runat="server">
                                        <asp:ListItem Value="Customer">Customer</asp:ListItem>
                                        <asp:ListItem Value="Admin">Admin</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                            </div>
                            <div class="form-actions">
                                <asp:Button ID="btnSaveEdit" runat="server"
                                    Text="Save Changes"
                                    CssClass="btn btn-purple"
                                    ValidationGroup="EditUser"
                                    OnClick="btnSaveEdit_Click" />
                                <asp:Button ID="btnCancelEdit" runat="server"
                                    Text="Cancel"
                                    CssClass="btn btn-gray"
                                    CausesValidation="false"
                                    OnClick="btnCancelEdit_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- DELETE CONFIRM -->
                    <asp:Panel ID="pnlDeleteConfirm" runat="server" Visible="false">
                        <div class="confirm-panel">
                            <asp:HiddenField ID="hfDeleteUserID" runat="server" />
                            <p>
                                Delete user:
                                <strong>
                                    <asp:Label ID="lblDeleteUsername" runat="server" />
                                </strong>?
                                This cannot be undone.
                            </p>
                            <div class="form-actions">
                                <asp:Button ID="btnConfirmDelete" runat="server"
                                    Text="Yes, Delete"
                                    CssClass="btn btn-red"
                                    CausesValidation="false"
                                    OnClick="btnConfirmDelete_Click" />
                                <asp:Button ID="btnCancelDelete" runat="server"
                                    Text="Cancel"
                                    CssClass="btn btn-gray"
                                    CausesValidation="false"
                                    OnClick="btnCancelDelete_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- SEARCH BAR -->
                    <div class="search-row">
                        <asp:TextBox ID="txtSearch" runat="server"
                            placeholder="Search by username or email..."
                            CssClass="search-input" />
                        <asp:Button ID="btnSearch" runat="server"
                            Text="Search"
                            CssClass="btn btn-purple"
                            CausesValidation="false"
                            OnClick="btnSearch_Click" />
                        <asp:Button ID="btnReset" runat="server"
                            Text="Reset"
                            CssClass="btn btn-gray"
                            CausesValidation="false"
                            OnClick="btnReset_Click" />
                    </div>

                    <!-- USERS TABLE -->
                    <asp:GridView ID="gvUsers" runat="server"
                        CssClass="data-table"
                        AutoGenerateColumns="false"
                        DataKeyNames="UserID"
                        OnRowCommand="gvUsers_RowCommand"
                        EmptyDataText="No users found.">
                        <Columns>
                            <asp:BoundField DataField="UserID"
                                HeaderText="ID" />
                            <asp:BoundField DataField="Username"
                                HeaderText="Username" />
                            <asp:BoundField DataField="Email"
                                HeaderText="Email" />
                            <asp:BoundField DataField="Age" 
                                HeaderText="Age" />
                            <asp:BoundField DataField="Gender" 
                                HeaderText="Gender" />
                            <asp:BoundField DataField="CurrentWeight" 
                                HeaderText="Weight(kg)" />
                            <asp:BoundField DataField="Height" 
                                HeaderText="Height(cm)" />
                            <asp:BoundField DataField="FitnessGoal" 
                                HeaderText="Goal" />
                            <asp:BoundField DataField="Role"
                                HeaderText="Role" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button runat="server"
                                        Text="Edit"
                                        CssClass="btn btn-outline btn-sm"
                                        CommandName="EditUser"
                                        CommandArgument='<%# Eval("UserID") %>'
                                        CausesValidation="false" />
                                    <asp:Button runat="server"
                                        Text="Delete"
                                        CssClass="btn btn-red btn-sm"
                                        CommandName="DeleteUser"
                                        CommandArgument='<%# Eval("UserID") %>'
                                        CausesValidation="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>
                <!-- end page-body -->
            </div>
            <!-- end main-content -->
        </div>
        <!-- end admin-wrapper -->

        <!-- LOGOUT MODAL -->
        <asp:Panel ID="pnlLogoutConfirm" runat="server"
            Visible="false" CssClass="modal-overlay">
            <div class="modal-box">
                <h3>Confirm Logout</h3>
                <p>Are you sure you want to log out?</p>
                <div class="form-actions" style="justify-content:center">
                    <asp:Button ID="btnCancelLogout" runat="server"
                        Text="Cancel"
                        CssClass="btn btn-gray"
                        CausesValidation="false"
                        OnClick="btnCancelLogout_Click" />
                    <asp:Button ID="btnLogout" runat="server"
                        Text="Yes, Logout"
                        CssClass="btn btn-red"
                        CausesValidation="false"
                        OnClick="btnLogout_Click" />
                </div>
            </div>
</asp:Panel>
    </form>
</body>
</html>
