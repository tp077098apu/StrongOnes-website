using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WorkoutLibrary : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check login
        if (Session["UserId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadWorkouts();
        }
    }

    private void LoadWorkouts()
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT * FROM Workouts";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptWorkouts.DataSource = dt;
                    rptWorkouts.DataBind();
                }
            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT * FROM Workouts WHERE WorkoutName LIKE @Search";

            if (ddlDifficulty.SelectedValue != "")
            {
                query += " AND Difficulty = @Difficulty";
            }

            if (ddlGoal.SelectedValue != "")
            {
                query += " AND Goal = @Goal";
            }

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text + "%");

                if (ddlDifficulty.SelectedValue != "")
                {
                    cmd.Parameters.AddWithValue("@Difficulty", ddlDifficulty.SelectedValue);
                }

                if (ddlGoal.SelectedValue != "")
                {
                    cmd.Parameters.AddWithValue("@Goal", ddlGoal.SelectedValue);
                }

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptWorkouts.DataSource = dt;
                    rptWorkouts.DataBind();
                }
            }
        }
    }
}