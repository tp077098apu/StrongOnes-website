using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class WorkoutSchedule : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadSchedule();
        }
    }

    private void LoadSchedule()
    {
        int userID = Convert.ToInt32(Session["UserId"]);

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"
            SELECT DayName, WorkoutName, Duration
            FROM WorkoutSchedule WS
            INNER JOIN Workouts W
            ON WS.WorkoutID = W.WorkoutID
            WHERE UserID = @UserID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userID);

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    gvSchedule.DataSource = dt;
                    gvSchedule.DataBind();
                }
            }
        }
    }
}