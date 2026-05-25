using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitnessApp
{ }

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string connString = ConfigurationManager.ConnectionStrings["Master_Database"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            // Notice 'Customer' is hardcoded as the default Role here
            string query = @"INSERT INTO Users 
                                 (Username, Email, Password, Age, Gender, CurrentWeight, Height, FitnessGoal, Role) 
                                 VALUES 
                                 (@Username, @Email, @Password, @Age, @Gender, @CurrentWeight, @Height, @FitnessGoal, 'Customer')";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@FitnessGoal", ddlFitnessGoal.SelectedValue);

                int age = string.IsNullOrEmpty(txtAge.Text) ? 0 : Convert.ToInt32(txtAge.Text);
                decimal weight = string.IsNullOrEmpty(txtWeight.Text) ? 0 : Convert.ToDecimal(txtWeight.Text);
                decimal height = string.IsNullOrEmpty(txtHeight.Text) ? 0 : Convert.ToDecimal(txtHeight.Text);

                if (age < 0 || weight < 0 || height < 0)
                {
                    string warningScript = "Swal.fire({ title: 'Invalid Input!', text: 'Values cannot be negative.', icon: 'warning', confirmButtonColor: '#d33' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "WarningMessage", warningScript, true);
                    return;
                }

                cmd.Parameters.AddWithValue("@Age", age);
                cmd.Parameters.AddWithValue("@CurrentWeight", weight);
                cmd.Parameters.AddWithValue("@Height", height);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    string successScript = "Swal.fire({ title: 'Success!', text: 'Registration Successful!', icon: 'success', confirmButtonColor: '#4CAF50' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", successScript, true);

                    txtPassword.Text = "";
                }
                catch (Exception ex)
                {
                    string safeErrorMessage = ex.Message.Replace("'", "\\'");
                    string errorScript = "Swal.fire({ title: 'Oops...', text: 'Error: " + safeErrorMessage + "', icon: 'error', confirmButtonColor: '#d33' });";
                    this.ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", errorScript, true);
                }
            }
        }
    }
}