using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageUser : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Redirect if not logged in as Admin
        if (Session["UserId"] == null || Session["Role"] == null
            || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            lblAdminName.Text = Session["Username"] != null
                ? Session["Username"].ToString()
                : "Admin";

            LoadUsers();
        }
    }

    private void LoadUsers(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = @"SELECT UserID, Username, Email, Role, Age, Gender, CurrentWeight, Height, FitnessGoal
                 FROM Users";

            // Add search filter if search term provided
            if (!string.IsNullOrEmpty(search))
            {
                query += @" WHERE Username LIKE @search
                            OR Email LIKE @search";
            }

            query += " ORDER BY UserID DESC";

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(search))
            {
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvUsers.DataSource = dt;
            gvUsers.DataBind();

            lblUserCount.Text = dt.Rows.Count.ToString();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadUsers(txtSearch.Text.Trim());
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadUsers();
    }

    protected void btnShowAddForm_Click(object sender, EventArgs e)
    {
        pnlAddUser.Visible = true;
        pnlEditUser.Visible = false;
        pnlDeleteConfirm.Visible = false;
        HideMessages();
    }

    protected void btnCancelAdd_Click(object sender, EventArgs e)
    {
        pnlAddUser.Visible = false;
        ClearAddForm();
    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Check if username already exists
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Username = @username",
                    conn);
                checkCmd.Parameters.AddWithValue(
                    "@username", txtAddUsername.Text.Trim());

                int exists = (int)checkCmd.ExecuteScalar();
                if (exists > 0)
                {
                    ShowError("Username already exists. Please choose another.");
                    return;
                }

                // Insert new user
                SqlCommand cmd = new SqlCommand(
                @"INSERT INTO Users
                    (Username, Email, Password, Role, Age, Gender, CurrentWeight, Height, FitnessGoal)
                  VALUES
                    (@username, @email, @password, @role, @age, @gender, @weight, @height, @goal)", conn);

                cmd.Parameters.AddWithValue("@username", txtAddUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtAddEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@password", txtAddPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@age", string.IsNullOrEmpty(txtAddAge.Text) ? (object)DBNull.Value : int.Parse(txtAddAge.Text));
                cmd.Parameters.AddWithValue("@gender", ddlAddGender.SelectedValue);
                cmd.Parameters.AddWithValue("@weight", string.IsNullOrEmpty(txtAddWeight.Text) ? (object)DBNull.Value : decimal.Parse(txtAddWeight.Text));
                cmd.Parameters.AddWithValue("@height", string.IsNullOrEmpty(txtAddHeight.Text) ? (object)DBNull.Value : decimal.Parse(txtAddHeight.Text));
                cmd.Parameters.AddWithValue("@goal", ddlAddGoal.SelectedValue);
                cmd.Parameters.AddWithValue("@role", ddlAddRole.SelectedValue);

                cmd.ExecuteNonQuery();
            }

            pnlAddUser.Visible = false;
            ClearAddForm();
            LoadUsers();
            ShowSuccess("User added successfully.");
        }
        catch (Exception ex)
        {
            ShowError("Error adding user: " + ex.Message);
        }
    }

    // ── GRIDVIEW ROW COMMAND (Edit / Delete buttons) ─────
    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int userID = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "EditUser")
        {
            LoadEditForm(userID);
        }
        else if (e.CommandName == "DeleteUser")
        {
            LoadDeleteConfirm(userID);
        }
    }

    // ── LOAD EDIT FORM ───────────────────────────────────
    private void LoadEditForm(int userID)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(
                @"SELECT UserID, Username, Email, Role, Age, Gender, CurrentWeight, Height, FitnessGoal
                    FROM Users WHERE UserID = @userID", conn);
            cmd.Parameters.AddWithValue("@userID", userID);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                hfEditUserID.Value = reader["UserID"].ToString();
                txtEditUsername.Text = reader["Username"].ToString();
                txtEditEmail.Text = reader["Email"].ToString();
                txtEditAge.Text = reader["Age"].ToString();
                ddlEditGender.SelectedValue = reader["Gender"].ToString() == "" ? "" : reader["Gender"].ToString();
                txtEditWeight.Text = reader["CurrentWeight"].ToString();
                txtEditHeight.Text = reader["Height"].ToString();
                // 1. Grab the database value and trim any accidental extra spaces
                string goalValue = reader["FitnessGoal"].ToString().Trim();

                // 2. Check if this exact text exists in your HTML dropdown list
                if (ddlEditGoal.Items.FindByValue(goalValue) != null)
                {
                    // If it exists, select it
                    ddlEditGoal.SelectedValue = goalValue;
                }
                else
                {
                    // If it doesn't match anything, fallback to the default "Select..." option
                    ddlEditGoal.SelectedValue = "";
                }
                ddlEditRole.SelectedValue = reader["Role"].ToString();
            }
            reader.Close();
        }

        pnlEditUser.Visible = true;
        pnlAddUser.Visible = false;
        pnlDeleteConfirm.Visible = false;
        HideMessages();
    }

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        pnlEditUser.Visible = false;
    }

    // ── SAVE EDIT ────────────────────────────────────────
    protected void btnSaveEdit_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(
                    @"UPDATE Users
                      SET Username = @username,
                          Email    = @email,
                          Role     = @role,
                          Age      = @age,
                          Gender   = @gender,
                          CurrentWeight = @weight,
                          Height   = @height,
                          FitnessGoal = @goal
                      WHERE UserID = @userID", conn);

                cmd.Parameters.AddWithValue(
                    "@username", txtEditUsername.Text.Trim());
                cmd.Parameters.AddWithValue(
                    "@email", txtEditEmail.Text.Trim());
                cmd.Parameters.AddWithValue(
                    "@role", ddlEditRole.SelectedValue);
                cmd.Parameters.AddWithValue(
                    "@userID", Convert.ToInt32(hfEditUserID.Value));
                cmd.Parameters.AddWithValue(
                    "@age", string.IsNullOrEmpty(txtEditAge.Text) ? (object)DBNull.Value : int.Parse(txtEditAge.Text));
                cmd.Parameters.AddWithValue(
                    "@gender", ddlEditGender.SelectedValue);
                cmd.Parameters.AddWithValue(
                    "@weight", string.IsNullOrEmpty(txtEditWeight.Text) ? (object)DBNull.Value : decimal.Parse(txtEditWeight.Text));
                cmd.Parameters.AddWithValue(
                    "@height", string.IsNullOrEmpty(txtEditHeight.Text) ? (object)DBNull.Value : decimal.Parse(txtEditHeight.Text));
                cmd.Parameters.AddWithValue(
                    "@goal", ddlEditGoal.SelectedValue);

                cmd.ExecuteNonQuery();
            }

            pnlEditUser.Visible = false;
            LoadUsers();
            ShowSuccess("User updated successfully.");
        }
        catch (Exception ex)
        {
            ShowError("Error updating user: " + ex.Message);
        }
    }

    // ── LOAD DELETE CONFIRM ──────────────────────────────
    private void LoadDeleteConfirm(int userID)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT Username FROM Users WHERE UserID = @userID", conn);
            cmd.Parameters.AddWithValue("@userID", userID);

            object result = cmd.ExecuteScalar();
            string username = "";

            if (result != null)
            {
                username = result.ToString();
            }

            lblDeleteUsername.Text = username;
            hfDeleteUserID.Value = userID.ToString();
        }

        pnlDeleteConfirm.Visible = true;
        pnlAddUser.Visible = false;
        pnlEditUser.Visible = false;
        HideMessages();
    }

    protected void btnCancelDelete_Click(object sender, EventArgs e)
    {
        pnlDeleteConfirm.Visible = false;
    }

    // ── CONFIRM DELETE ───────────────────────────────────
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Users WHERE UserID = @userID", conn);
                cmd.Parameters.AddWithValue(
                    "@userID", Convert.ToInt32(hfDeleteUserID.Value));

                cmd.ExecuteNonQuery();
            }

            pnlDeleteConfirm.Visible = false;
            LoadUsers();
            ShowSuccess("User deleted successfully.");
        }
        catch (Exception ex)
        {
            ShowError("Error deleting user: " + ex.Message);
        }
    }

    // ── LOGOUT ───────────────────────────────────────────
    protected void btnShowLogout_Click(object sender, EventArgs e)
    {
        pnlLogoutConfirm.Visible = true;
    }

    protected void btnCancelLogout_Click(object sender, EventArgs e)
    {
        pnlLogoutConfirm.Visible = false;
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/Login.aspx");
    }

    // ── HELPERS ──────────────────────────────────────────
    private void ShowSuccess(string message)
    {
        pnlSuccess.Visible = true;
        lblSuccess.Text = message;
        pnlError.Visible = false;
    }

    private void ShowError(string message)
    {
        pnlError.Visible = true;
        lblError.Text = message;
        pnlSuccess.Visible = false;
    }

    private void HideMessages()
    {
        pnlSuccess.Visible = false;
        pnlError.Visible = false;
    }

    private void ClearAddForm()
    {
        txtAddUsername.Text = "";
        txtAddEmail.Text = "";
        txtAddPassword.Text = "";
        ddlAddRole.SelectedIndex = 0;
    }

}