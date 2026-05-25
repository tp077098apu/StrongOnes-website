<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminHomepage.aspx.cs" Inherits="AdminHomepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StrongOnes – Admin Dashboard</title>
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --purple:       #6C3FC5;
            --purple-dark:  #4A2590;
            --purple-light: #EDE9FF;
            --white:        #FFFFFF;
            --off-white:    #F8F7FC;
            --gray-light:   #F0EEF8;
            --gray-mid:     #9490A8;
            --gray-dark:    #3A3650;
            --black:        #1A1730;
            --red:          #E53E3E;
            --red-light:    #FFF5F5;
            --green:        #38A169;
            --green-light:  #F0FFF4;
            --font:         'Segoe UI', Arial, sans-serif;
            --radius:       10px;
            --shadow:       0 2px 16px rgba(108, 63, 197, 0.10);
            --transition:   all 0.2s ease;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--font);
            background: var(--off-white);
            color: var(--black);
            font-size: 15px;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul { 
            list-style: none; 
        }

        /*Layout*/
        .admin-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /*Side Bar*/
        .sidebar {
            width: 250px;
            background: var(--black);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            z-index: 100;
        }

        .sidebar-logo {
            padding: 24px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .sidebar-logo .logo {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--purple-light);
            letter-spacing: -0.02em;
        }

        .logo span {
            color: var(--purple);
        }

        .sidebar-logo .admin-tag {
            font-size: 0.72rem;
            color: var(--gray-mid);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-top: 2px;
        }

        .sidebar-nav {
            flex: 1;
            padding: 20px 12px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .nav-label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--gray-mid);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            padding: 8px 10px 4px;
            margin-top: 8px;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 12px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.65);
            transition: var(--transition);
        }

        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.07);
            color: var(--white);
        }

        .sidebar-nav a.active {
            background: var(--purple);
            color: var(--white);
        }

        .sidebar-nav a i {
            width: 18px;
            text-align: center;
            font-size: 0.95rem;
        }

        .sidebar-footer {
            padding: 16px 12px;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
        }

        .sidebar-footer .btn-logout {
            display: flex;
            align-items: center;
            gap: 12px;
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.65);
            background: none;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            text-align: left;
        }

        .sidebar-footer .btn-logout:hover {
            background: rgba(229, 62, 62, 0.15);
            color: var(--red);
        }

        /*Main Content*/
        .main-content {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* ── TOP BAR ── */
        .topbar {
            background: var(--white);
            border-bottom: 1px solid var(--gray-light);
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-left h1 {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--black);
        }

        .topbar-left p {
            font-size: 0.8rem;
            color: var(--gray-mid);
            margin-top: 1px;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-avatar {
            width: 36px;
            height: 36px;
            background: var(--purple);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 700;
            font-size: 0.9rem;
        }

        .admin-name {
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--gray-dark);
        }

        /*Page Body*/
        .page-body {
            padding: 32px;
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        /*Stats*/
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            border: 1px solid var(--gray-light);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: var(--transition);
        }

        .stat-card:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            flex-shrink: 0;
        }

        .stat-icon.purple { 
            background: var(--purple-light); 
            color: var(--purple); 
        }

        .stat-icon.green  { 
            background: var(--green-light);  
            color: var(--green);  
        }

        .stat-icon.red    { 
            background: var(--red-light);    
            color: var(--red);    
        }

        .stat-info .label {
            font-size: 0.8rem;
            color: var(--gray-mid);
            font-weight: 500;
        }

        .stat-info .value {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--black);
            line-height: 1.2;
        }

        /*Section Title*/
        .section-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 16px;
        }

        /*Management*/
        .manage-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .manage-card {
            background: var(--white);
            border: 1px solid var(--gray-light);
            border-radius: var(--radius);
            padding: 28px 24px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            transition: var(--transition);
        }

        .manage-card:hover {
            box-shadow: var(--shadow);
            border-color: var(--purple);
            transform: translateY(-3px);
        }

        .manage-card-icon {
            width: 52px;
            height: 52px;
            background: var(--purple-light);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            color: var(--purple);
        }

        .manage-card h3 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--black);
        }

        .manage-card p {
            font-size: 0.87rem;
            color: var(--gray-mid);
            line-height: 1.6;
            flex: 1;
        }

        .manage-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        /*Buttons*/
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.84rem;
            font-weight: 600;
            cursor: pointer;
            border: 2px solid transparent;
            transition: var(--transition);
            text-decoration: none;
        }

        .btn-purple {
            background: var(--purple);
            color: var(--white);
            border-color: var(--purple);
        }

        .btn-purple:hover {
            background: var(--purple-dark);
            border-color: var(--purple-dark);
        }

        .btn-outline {
            background: transparent;
            color: var(--purple);
            border-color: var(--purple);
        }
        .btn-outline:hover {
            background: var(--purple);
            color: var(--white);
        }

        .btn-red {
            background: transparent;
            color: var(--red);
            border-color: var(--red);
        }
        .btn-red:hover {
            background: var(--red);
            color: var(--white);
        }

        /*Logout Modal*/
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.45);
            z-index: 999;
            display: flex;          /* always flex when Panel is visible */
            align-items: center;
            justify-content: center;
        }

        .modal-box {
            background: var(--white);
            border-radius: 14px;
            padding: 36px 32px;
            width: 100%;
            max-width: 380px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        }

        .modal-icon {
            width: 60px;
            height: 60px;
            background: var(--red-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--red);
            margin: 0 auto 20px;
        }

        .modal-box h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 8px;
        }

        .modal-box p {
            font-size: 0.9rem;
            color: var(--gray-mid);
            margin-bottom: 28px;
        }

        .modal-btns {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .modal-btns .btn {
            padding: 10px 28px;
            font-size: 0.9rem;
        }

        .btn-cancel {
            background: var(--gray-light);
            color: var(--gray-dark);
            border-color: var(--gray-light);
        }

        .btn-cancel:hover {
            background: var(--gray-mid);
            color: var(--white);
            border-color: var(--gray-mid);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-wrapper">

            <!--Side Bar-->
            <aside class="sidebar">

            <div class="sidebar-logo">
                <div class="logo">Strong<span>Ones</span></div>
                <div class="admin-tag">Admin Portal</div>
            </div>

            <nav class="sidebar-nav">
                <div class="nav-label">Main</div>
                <a href="AdminHomepage.aspx" class="active">Dashboard</a>

                <div class="nav-label">Manage</div>
                <a href="ManageUser.aspx">Manage Users</a>
                <a href="ManageWorkouts.aspx">Manage Workouts</a>
                <a href="ManageNutrition.aspx">Manage Nutrition</a>
            </nav>

            <div class="sidebar-footer">
                <asp:Button ID="btnShowLogout" runat="server"
                    Text="Logout"
                    CssClass="btn-logout"
                    OnClick="btnShowLogout_Click" />
            </div>

            </aside>

            <!--Main Content-->
            <div class="main-content">

                <!--Top Bar-->
                <div class="topbar">
                    <div class="topbar-left">
                        <h1>Dashboard</h1>
                    </div>
                    <div class="topbar-right">
                        <div class="admin-profile">
                            <div class="admin-avatar">A</div>
                            <span class="admin-name">
                                <asp:Label ID="lblAdminName" runat="server" Text="Admin" />
                            </span>
                        </div>
                    </div>
                </div>

                <!--Page Body-->
                <div class="page-body">

                    <!--Stats Cards-->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon purple">
                                <i class="fa-solid fa-users"></i>
                            </div>
                            <div class="stat-info">
                                <div class="label">Total Users</div>
                                <div class="value">
                                    <asp:Label ID="lblTotalUsers" runat="server" Text="0" />
                                </div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon green">
                                <i class="fa-solid fa-dumbbell"></i>
                            </div>
                            <div class="stat-info">
                                <div class="label">Total Workouts</div>
                                <div class="value">
                                    <asp:Label ID="lblTotalWorkouts" runat="server" Text="0" />
                                </div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon red">
                                <i class="fa-solid fa-bowl-food"></i>
                            </div>
                            <div class="stat-info">
                                <div class="label">Total Nutrition</div>
                                <div class="value">
                                    <asp:Label ID="lblTotalNutrition" runat="server" Text="0" />
                                </div>
                            </div>
                        </div>                  
                    </div>

                    <!--Management Cards-->
                    <div>
                    <div class="section-title">Management</div>
                    <div class="manage-grid">

                        <!-- Manage Users -->
                        <div class="manage-card">
                            <div class="manage-card-icon">
                                <i class="fa-solid fa-users"></i>
                            </div>
                            <h3>Manage Users</h3>
                            <p>View all registered accounts, check user 
                               details, and remove accounts that violate 
                               community guidelines.</p>
                            <div class="manage-actions">
                                <a href="ManageUser.aspx" class="btn btn-purple">
                                    <i class="fa-solid fa-eye"></i> View Users
                                </a>
                            </div>
                        </div>

                        <!--Manage Workout-->
                        <div class="manage-card">
                            <div class="manage-card-icon">
                                <i class="fa-solid fa-dumbbell"></i>
                            </div>
                            <h3>Manage Workouts</h3>
                            <p>Add new exercise routines, update existing 
                               workout details, or remove outdated content 
                               from the database.</p>
                            <div class="manage-actions">
                                <a href="ManageWorkouts.aspx" class="btn btn-purple">
                                    <i class="fa-solid fa-eye"></i> View Workouts
                                </a>
                                <a href="ManageWorkouts.aspx?action=add" 
                                   class="btn btn-outline">
                                    <i class="fa-solid fa-plus"></i> Add New
                                </a>
                            </div>
                        </div>

                        <!--Manage Nutrition-->
                         <div class="manage-card">
                            <div class="manage-card-icon">
                                <i class="fa-solid fa-bowl-food"></i>
                            </div>
                            <h3>Manage Nutrition</h3>
                            <p>Insert new healthy recipes and calorie data, 
                               update existing entries, or remove outdated 
                               nutrition content.</p>
                            <div class="manage-actions">
                                <a href="ManageNutrition.aspx" class="btn btn-purple">
                                    <i class="fa-solid fa-eye"></i> View Nutrition
                                </a>
                                <a href="ManageNutrition.aspx?action=add" 
                                   class="btn btn-outline">
                                    <i class="fa-solid fa-plus"></i> Add New
                                </a>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlLogoutConfirm" runat="server" 
            Visible="false" 
            CssClass="modal-overlay show">
            <div class="modal-box">
                <div class="modal-icon">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </div>
                <h3>Confirm Logout</h3>
                <p>Are you sure you want to log out of the admin portal?</p>
                <div class="modal-btns">
                    <asp:Button ID="btnCancelLogout" runat="server"
                        Text="Cancel"
                        CssClass="btn btn-cancel"
                        OnClick="btnCancelLogout_Click" />
                    <asp:Button ID="btnLogout" runat="server"
                        Text="Yes, Logout"
                        CssClass="btn btn-red"
                        OnClick="btnLogout_Click" />
                </div>
            </div>
        </asp:Panel>

    </form>


</body>
</html>
