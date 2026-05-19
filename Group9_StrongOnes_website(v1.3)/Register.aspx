<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>


<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register - Health & Fitness</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script type="text/javascript">
        function togglePassword() {
            var pwdField = document.getElementById('<%= txtPassword.ClientID %>');
            pwdField.type = pwdField.type === "password" ? "text" : "password";
        }
    </script>
    
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 20px; }
        .form-container { max-width: 500px; margin: auto; }
        .section-card { background: white; padding: 20px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .section-title { margin-top: 0; color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 5px; }
        .input-field { width: 100%; padding: 8px; margin: 8px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #4CAF50; color: white; padding: 12px; width: 100%; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2 style="text-align:center;">Create Your Profile</h2>

            <div class="section-card">
                <h3 class="section-title">1. Account Details</h3>
                
                <label>Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" Required="true"></asp:TextBox>
                
                <label>Email Address:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="input-field" Required="true"></asp:TextBox>

                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" Required="true"></asp:TextBox>
                
                <input type="checkbox" onclick="togglePassword()" id="chkShowPassword" /> 
                <label for="chkShowPassword">Show Password</label>
            </div>

            <div class="section-card">
                <h3 class="section-title">2. Physical Details & Goals</h3>
                
                <label>Gender:</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="input-field">
                    <asp:ListItem Text="Select Gender" Value=""></asp:ListItem>
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                </asp:DropDownList>

                <label>Age:</label>
                <asp:TextBox ID="txtAge" runat="server" TextMode="Number" min="0" CssClass="input-field"></asp:TextBox>

                <label>Current Weight (kg):</label>
                <asp:TextBox ID="txtWeight" runat="server" TextMode="Number" step="0.1" min="0" CssClass="input-field"></asp:TextBox>

                <label>Height (cm):</label>
                <asp:TextBox ID="txtHeight" runat="server" TextMode="Number" step="0.1" min="0" CssClass="input-field"></asp:TextBox>

                <label>Fitness Goal:</label>
                <asp:DropDownList ID="ddlFitnessGoal" runat="server" CssClass="input-field">
                    <asp:ListItem Text="Select a Goal" Value=""></asp:ListItem>
                    <asp:ListItem Text="Lose Weight" Value="Lose Weight"></asp:ListItem>
                    <asp:ListItem Text="Gain Muscle" Value="Gain Muscle"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Complete Registration" OnClick="btnRegister_Click" CssClass="btn-submit" />
            
            <div style="text-align:center; margin-top: 15px;">
                Already have an account? <a href="Login.aspx" style="color: #4CAF50; font-weight: bold;">Login here</a>
            </div>
        </div>
    </form>
</body>
</html>