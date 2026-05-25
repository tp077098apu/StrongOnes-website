using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class ManageWorkouts : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Admin security check
        if (Session["UserId"] == null ||
            Session["Role"] == null ||
            Session["Role"].ToString() != "Admin")
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

                    gvWorkouts.DataSource = dt;
                    gvWorkouts.DataBind();
                }
            }
        }
    }

    protected void btnAddWorkout_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"
            INSERT INTO Workouts
            (WorkoutName, Difficulty, Duration)
            VALUES
            (@WorkoutName, @Difficulty, @Duration)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@WorkoutName", txtWorkoutName.Text);
                cmd.Parameters.AddWithValue("@Difficulty", ddlLevel.SelectedValue);
                cmd.Parameters.AddWithValue("@Duration", txtDuration.Text);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string successScript = "Swal.fire({ title: 'Success!', text: 'Workout added successfully.', icon: 'success', confirmButtonColor: '#6C3FC5' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);

                    LoadWorkouts();
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

    protected void gvWorkouts_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int workoutID = Convert.ToInt32(gvWorkouts.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "DELETE FROM Workouts WHERE WorkoutID = @WorkoutID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@WorkoutID", workoutID);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string successScript = "Swal.fire({ title: 'Deleted!', text: 'Workout removed successfully.', icon: 'success', confirmButtonColor: '#4CAF50' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);

                    LoadWorkouts();
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

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}