<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkoutLibrary.aspx.cs" Inherits="WorkoutLibrary" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StrongOnes – Workout Library</title>

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            font-family: 'Segoe UI';
            background: #f5f5f5;
            margin: 0;
        }

        .container {
            width: 90%;
            margin: auto;
            padding: 30px;
        }

        h1 {
            color: #6C3FC5;
        }

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .filters select,
        .filters input {
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .workout-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .workout-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .workout-card h3 {
            color: #4A2590;
        }

        .badge {
            display: inline-block;
            background: #EDE9FF;
            color: #4A2590;
            padding: 5px 10px;
            border-radius: 20px;
            margin-top: 10px;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 16px;
            background: #6C3FC5;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        .btn:hover {
            background: #4A2590;
        }
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="container">

    <h1><i class="fa-solid fa-dumbbell"></i> Workout Library</h1>

    <div class="filters">

        <asp:TextBox ID="txtSearch" runat="server"
            placeholder="Search workout..."></asp:TextBox>

        <asp:DropDownList ID="ddlDifficulty" runat="server">
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

        <asp:Repeater ID="rptWorkouts" runat="server">
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