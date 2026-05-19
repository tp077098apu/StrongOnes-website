using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminDashboard : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            lblAdminName.Text = Session["Username"].ToString();
            BindGrid();
        }
    }

    private void BindGrid()
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT UserId, Username, Email, Role FROM Users";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }
    }

    // --- NEW: Handle the "Make Admin" button click ---
    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Promote")
        {
            // Grab the ID of the user they clicked on
            int userIdToPromote = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Run an UPDATE query to change their role
                string query = "UPDATE Users SET Role = 'Admin' WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userIdToPromote);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Show success popup and refresh the table
                        string successScript = "Swal.fire({ title: 'Promoted!', text: 'User has been granted Admin privileges.', icon: 'success', confirmButtonColor: '#3498db' });";
                        this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);

                        BindGrid();
                    }
                    catch (Exception ex)
                    {
                        string safeErrorMessage = ex.Message.Replace("'", "\\'");
                        string errorScript = "Swal.fire({ title: 'Error', text: '" + safeErrorMessage + "', icon: 'error', confirmButtonColor: '#d33' });";
                        this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
                    }
                }
            }
        }
    }

    // Handle the "Delete" button click
    protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int userIdToDelete = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "DELETE FROM Users WHERE UserId = @UserId";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userIdToDelete);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string successScript = "Swal.fire({ title: 'Deleted!', text: 'User has been permanently removed.', icon: 'success', confirmButtonColor: '#4CAF50' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);

                    BindGrid();
                }
                catch (Exception ex)
                {
                    string safeErrorMessage = ex.Message.Replace("'", "\\'");
                    string errorScript = "Swal.fire({ title: 'Error', text: '" + safeErrorMessage + "', icon: 'error', confirmButtonColor: '#d33' });";
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