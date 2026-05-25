<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkoutDetails.aspx.cs" Inherits="WorkoutDetails" Title="StrongOnes – Workout Details" %>
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