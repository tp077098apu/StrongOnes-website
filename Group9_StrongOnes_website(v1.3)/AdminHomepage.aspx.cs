using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminHomepage : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        // 1. Check if they are logged in AND if they are actually an Admin
        if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            // If not, kick them back to login
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            // 2. Display admin name using the correct session variable from the Login page
            lblAdminName.Text = Session["Username"] != null
                ? Session["Username"].ToString()
                : "Admin";

            // Load all dashboard data
            LoadDashboardStats();
        }
    }
    private void LoadDashboardStats()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Total Users
            SqlCommand cmdUsers = new SqlCommand(
                "SELECT COUNT(*) FROM Users", conn);
            lblTotalUsers.Text = cmdUsers.ExecuteScalar().ToString();

            //// Total Workouts
            //SqlCommand cmdWorkouts = new SqlCommand(
            //    "SELECT COUNT(*) FROM Workout", conn);
            //lblTotalWorkouts.Text = cmdWorkouts.ExecuteScalar().ToString();

            //// Total Nutrition
            //SqlCommand cmdNutrition = new SqlCommand(
            //    "SELECT COUNT(*) FROM Nutrition", conn);
            //lblTotalNutrition.Text = cmdNutrition.ExecuteScalar().ToString();

            // Active Users
            //SqlCommand cmdActive = new SqlCommand(
            //    "SELECT COUNT(*) FROM Users WHERE Status = 'Active'", conn);
            //lblActiveUsers.Text = cmdActive.ExecuteScalar().ToString();
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Clear all session data
        Session.Clear();
        Session.Abandon();

        // Redirect to admin login page
        Response.Redirect("Login.aspx");
    }
}