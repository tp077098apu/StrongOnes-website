<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkoutDetails.aspx.cs" Inherits="WorkoutDetails" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Workout Details</title>

    <style>
        body {
            font-family: Segoe UI;
            background: #f8f7fc;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .exercise {
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }

        .btn-save {
            background: #6C3FC5;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="container">

    <div class="card">

        <h1>
            <asp:Label ID="lblWorkoutName" runat="server"></asp:Label>
        </h1>

        <p>
            Difficulty:
            <asp:Label ID="lblDifficulty" runat="server"></asp:Label>
        </p>

        <p>
            Duration:
            <asp:Label ID="lblDuration" runat="server"></asp:Label>
            mins
        </p>

        <asp:Button ID="btnSaveRoutine" runat="server"
            Text="Save Routine"
            CssClass="btn-save"
            OnClick="btnSaveRoutine_Click" />

    </div>

    <div class="card">

        <h2>Exercises</h2>

        <asp:Repeater ID="rptExercises" runat="server">
            <ItemTemplate>

                <div class="exercise">

                    <h3><%# Eval("ExerciseName") %></h3>

                    <p>
                        Sets: <%# Eval("Sets") %>
                    </p>

                    <p>
                        Reps: <%# Eval("Reps") %>
                    </p>

                    <p>
                        Rest Time: <%# Eval("RestTime") %> sec
                    </p>

                    <p>
                        <%# Eval("Description") %>
                    </p>

                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>

</div>

</form>
</body>
</html>