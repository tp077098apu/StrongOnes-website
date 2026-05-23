<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Reset Password - Health & Fitness</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 50px 20px; }
        .form-container { max-width: 400px; margin: auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .input-field { width: 100%; padding: 10px; margin: 8px 0 20px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #e74c3c; color: white; padding: 12px; width: 100%; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background-color: #c0392b; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #555; text-decoration: none; font-size: 14px; }
        .back-link a { color: #3498db; font-weight: bold; text-decoration: none; }
        .back-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2 style="text-align:center; color: #333;">Reset Password</h2>
            <p style="text-align:center; color: #666; font-size: 14px; margin-bottom: 20px;">
                Enter your username and pick a new password.
            </p>

            <label>Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" Required="true"></asp:TextBox>
            
            <label>New Password:</label>
            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="input-field" Required="true"></asp:TextBox>

            <label>Confirm Password:</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="input-field" Required="true"></asp:TextBox>

            <asp:Button ID="btnReset" runat="server" Text="Update Password" OnClick="btnReset_Click" CssClass="btn-submit" />
            
            <div class="back-link">
                Remembered it? <a href="Login.aspx">Back to Login</a>
            </div>
        </div>
    </form>
</body>
</html>