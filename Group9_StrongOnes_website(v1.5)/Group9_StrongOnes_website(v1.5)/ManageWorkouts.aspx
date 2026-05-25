<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageWorkouts.aspx.cs" Inherits="ManageWorkouts" Title="StrongOnes – Manage Workouts" %>

    <link href="admin.css" rel="stylesheet" />
</head>
<body>

<form id="form1" runat="server">

<div class="main-content">

    <div class="topbar">
        <h1>Manage Workouts</h1>
    </div>

    <div class="card">

        <asp:TextBox ID="txtWorkoutName" runat="server"
            placeholder="Workout Name"></asp:TextBox>

        <asp:DropDownList ID="ddlLevel" runat="server">
            <asp:ListItem>Beginner</asp:ListItem>
            <asp:ListItem>Intermediate</asp:ListItem>
            <asp:ListItem>Advanced</asp:ListItem>
        </asp:DropDownList>

        <asp:TextBox ID="txtDuration" runat="server"
            placeholder="Duration"></asp:TextBox>

        <asp:Button ID="btnAddWorkout" runat="server"
            Text="Add Workout"
            OnClick="btnAddWorkout_Click" />

    </div>

    <asp:GridView ID="gvWorkouts" runat="server"
        AutoGenerateColumns="False"
        DataKeyNames="WorkoutID"
        OnRowDeleting="gvWorkouts_RowDeleting">

        <Columns>

            <asp:BoundField DataField="WorkoutName"
                HeaderText="Workout" />

            <asp:BoundField DataField="Difficulty"
                HeaderText="Difficulty" />

            <asp:BoundField DataField="Duration"
                HeaderText="Duration" />

            <asp:CommandField ShowDeleteButton="True" />

        </Columns>

    </asp:GridView>

</div>

</form>
</body>
</html>