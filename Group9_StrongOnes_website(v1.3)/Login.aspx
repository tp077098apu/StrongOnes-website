<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login - Health & Fitness</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function togglePassword() {
            var pwdField = document.getElementById('<%= txtPassword.ClientID %>');
            pwdField.type = pwdField.type === "password" ? "text" : "password";
        }
    </script>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 50px 20px; }
        .form-container { max-width: 400px; margin: auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .input-field { width: 100%; padding: 10px; margin: 8px 0 20px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #4CAF50; color: white; padding: 12px; width: 100%; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background-color: #45a049; }
        .register-link { display: block; text-align: center; margin-top: 15px; color: #555; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2 style="text-align:center; color: #333;">Welcome Back!</h2>
            <label>Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" Required="true"></asp:TextBox>
            <label>Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" Required="true"></asp:TextBox>
            <div style="margin-top: -10px; margin-bottom: 20px;">
                <input type="checkbox" onclick="togglePassword()" id="chkShowPassword" /> <label for="chkShowPassword" style="font-size: 14px; color: #555;">Show Password</label>
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Secure Login" OnClick="btnLogin_Click" CssClass="btn-submit" />
            <div style="text-align:center; margin-top: 15px;">
                <a href="ForgotPassword.aspx" style="color: #e74c3c; font-size: 14px; text-decoration: none;">Forgot Password?</a>
            </div>
            <div class="register-link">
                Don't have an account? <a href="Register.aspx" style="color: #4CAF50; font-weight: bold;">Register here</a>
            </div>
        </div>
    </form>
</body>
</html>