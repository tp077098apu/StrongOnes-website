using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ForgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        // STEP 1: Check if the two password boxes match!
        if (txtNewPassword.Text != txtConfirmPassword.Text)
        {
            // If they made a typo, stop the code and show an error popup
            string mismatchScript = "Swal.fire({ title: 'Passwords do not match', text: 'Please make sure your new passwords match exactly.', icon: 'warning', confirmButtonColor: '#e74c3c' });";
            this.ClientScript.RegisterStartupScript(this.GetType(), "WarningMessage", mismatchScript, true);
            return;
        }

        string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            // STEP 2: We removed Email, so now we ONLY verify if the Username exists
            string verifyQuery = "SELECT COUNT(1) FROM Users WHERE Username = @Username";

            using (SqlCommand verifyCmd = new SqlCommand(verifyQuery, conn))
            {
                verifyCmd.Parameters.AddWithValue("@Username", txtUsername.Text);

                try
                {
                    conn.Open();
                    int userExists = Convert.ToInt32(verifyCmd.ExecuteScalar());

                    if (userExists == 1)
                    {
                        // STEP 3: Username is real! Update the password.
                        string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE Username = @Username";

                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@NewPassword", txtNewPassword.Text);
                            updateCmd.Parameters.AddWithValue("@Username", txtUsername.Text);

                            updateCmd.ExecuteNonQuery();

                            // Success Popup! Redirects them back to Login when they click OK.
                            string successScript = @"
                                    Swal.fire({ 
                                        title: 'Password Updated!', 
                                        text: 'Your password has been changed successfully.', 
                                        icon: 'success', 
                                        confirmButtonColor: '#4CAF50' 
                                    }).then(function() {
                                        window.location = 'Login.aspx';
                                    });";

                            this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);
                        }
                    }
                    else
                    {
                        // If they typed a username that doesn't exist in the database
                        string errorScript = "Swal.fire({ title: 'User Not Found', text: 'We could not find an account with that username.', icon: 'error', confirmButtonColor: '#d33' });";
                        this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
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