using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
                Response.Redirect("AdminHomepage.aspx");
            else
                Response.Redirect("UserDashboard.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT UserId, Username, Role FROM Users WHERE Username = @Username AND Password = @Password";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            Session["UserId"] = reader["UserId"].ToString();
                            Session["Username"] = reader["Username"].ToString();

                            string userRole = reader["Role"].ToString();
                            Session["Role"] = userRole;

                            if (userRole == "Admin")
                                Response.Redirect("AdminHomepage.aspx");
                            else
                                Response.Redirect("UserDashboard.aspx");
                        }
                        else
                        {
                            string errorScript = "Swal.fire({ title: 'Login Failed', text: 'Invalid username or password.', icon: 'error', confirmButtonColor: '#d33' });";
                            this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    string safeErrorMessage = ex.Message.Replace("'", "\\'");
                    string errorScript = "Swal.fire({ title: 'Database Error', text: '" + safeErrorMessage + "', icon: 'error', confirmButtonColor: '#d33' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
                }
            }
        }
    }
}