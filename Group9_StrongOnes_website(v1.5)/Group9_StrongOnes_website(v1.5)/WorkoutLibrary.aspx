<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkoutLibrary.aspx.cs" Inherits="WorkoutLibrary" Title="StrongOnes – Workout Library" %>


<form id="form1" runat="server">

<div class="container">

    <h1><i class="fa-solid fa-dumbbell"></i> Workout Library</h1>

    <div class="filters">

        <asp:TextBox ID="txtSearch" runat="server"
            placeholder="Search workout..."></asp:TextBox>

        <asp:DropDownList ID="ddlDifficulty" runat="server" OnSelectedIndexChanged="ddlDifficulty_SelectedIndexChanged">
            <asp:ListItem Text="All Levels" Value=""></asp:ListItem>
            <asp:ListItem>Beginner</asp:ListItem>
            <asp:ListItem>Intermediate</asp:ListItem>
            <asp:ListItem>Advanced</asp:ListItem>
        </asp:DropDownList>

        <asp:DropDownList ID="ddlGoal" runat="server">
            <asp:ListItem Text="All Goals" Value=""></asp:ListItem>
            <asp:ListItem>Fat Loss</asp:ListItem>
            <asp:ListItem>Muscle Gain</asp:ListItem>
            <asp:ListItem>Strength</asp:ListItem>
        </asp:DropDownList>

        <asp:Button ID="btnFilter" runat="server"
            Text="Filter"
            CssClass="btn"
            OnClick="btnFilter_Click" />

    </div>

    <div class="workout-grid">

        <asp:Repeater ID="rptWorkouts" runat="server" OnItemCommand="rptWorkouts_ItemCommand">
            <ItemTemplate>

                <div class="workout-card">

                    <h3><%# Eval("WorkoutName") %></h3>

                    <p>
                        Duration: <%# Eval("Duration") %> mins
                    </p>

                    <span class="badge">
                        <%# Eval("Difficulty") %>
                    </span>

                    <br />

                    <a class="btn"
                       href='WorkoutDetails.aspx?id=<%# Eval("WorkoutID") %>'>
                        View Details
                    </a>

                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>

</div>

</form>
</body>
</html>