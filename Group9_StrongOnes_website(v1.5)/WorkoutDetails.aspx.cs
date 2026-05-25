using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class WorkoutDetails : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    int workoutID;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check login
        if (Session["UserId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        workoutID = Convert.ToInt32(Request.QueryString["id"]);

        if (!IsPostBack)
        {
            LoadWorkoutDetails();
            LoadExercises();
        }
    }

    private void LoadWorkoutDetails()
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT * FROM Workouts WHERE WorkoutID = @WorkoutID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@WorkoutID", workoutID);

                try
                {
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblWorkoutName.Text = reader["WorkoutName"].ToString();
                        lblDifficulty.Text = reader["Difficulty"].ToString();
                        lblDuration.Text = reader["Duration"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    string safeErrorMessage = ex.Message.Replace("'", "\'");
                    string errorScript = "Swal.fire({ title: 'Error', text: '" + safeErrorMessage + "', icon: 'error' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
                }
            }
        }
    }
}