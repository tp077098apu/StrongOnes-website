<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkoutSchedule.aspx.cs" Inherits="WorkoutSchedule" Title="StrongOnes – Workout Schedule" %>
    <style>
        body {
            font-family: Segoe UI;
            background: #f5f5f5;
        }

        .container {
            width: 85%;
            margin: auto;
            padding: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 15px;
            border: 1px solid #ddd;
        }

        th {
            background: #6C3FC5;
            color: white;
        }
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="container">

    <h1>Weekly Workout Schedule</h1>

    <asp:GridView ID="gvSchedule" runat="server"
        AutoGenerateColumns="False">

        <Columns>

            <asp:BoundField DataField="DayName" HeaderText="Day" />
            <asp:BoundField DataField="WorkoutName" HeaderText="Workout" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" />

        </Columns>

    </asp:GridView>

</div>

</form>
</body>
</html>