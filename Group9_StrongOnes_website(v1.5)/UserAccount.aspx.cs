using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadUserData();
        }
    }

    private void LoadUserData()
    {
        string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;
        string userId = Session["UserId"].ToString();

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT Username, Email, Gender, Age, Height, CurrentWeight, FitnessGoal FROM Users WHERE UserId = @UserId";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblWelcomeName.Text = reader["Username"].ToString();
                            lblEmail.Text = reader["Email"].ToString();
                            lblGender.Text = reader["Gender"].ToString();
                            lblAge.Text = reader["Age"].ToString();
                            lblHeight.Text = reader["Height"].ToString() + " cm";
                            lblWeight.Text = reader["CurrentWeight"].ToString() + " kg";
                            lblGoal.Text = reader["FitnessGoal"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
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