<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StrongOnes - Health and Fitness Education</title>
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
            color: var(--black);
            background: var(--white);
            line-height: 1.6;
            font-size: 16px;
        }

        .container {
            max-width: 1160px;
            margin: 0 auto;
            padding: 0 24px;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
        }

        .navbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: var(--purple);
            border-bottom: 1px solid var(--gray-light);
            height: 64px;
            display: flex;
            align-items: center;
        }

        .nav-inner {
            display: flex;
            align-items: center;
            gap: 32px;
            width: 100%
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--purple-light);
            letter-spacing: -0.02em;
            flex-shrink: 0;
        }

        .logo span { 
            color: var(--purple-dark); 
        }

        .nav-links {
            display: flex;
            gap: 4px;
            flex: 1;
            justify-content: center;
        }

        .nav-links a {
            padding: 8px 14px;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--gray-light);
            border-radius: 6px;
            transition: var(--transition);
        }
        .nav-links a:hover,
        .nav-links a.active {
            color: var(--purple);
            background: var(--white);
        }

        .nav-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0;
        }

        .nav-actions a {
            color:var(--white)
        }
        .nav-actions .btn { 
            padding: 8px 20px; 
            font-size: 0.88rem; 

        }

        .footer {
            background: var(--black);
            color: rgba(255, 255, 255, 0.65);
            padding: 64px 0 0;
        }

        .footer-inner {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 48px;
            padding-bottom: 52px;
        }

        .footer-brand .logo {
            display: inline-block;
            margin-bottom: 14px;
            font-size: 1.4rem;
        }

        .footer-brand p {
            font-size: 0.88rem;
            line-height: 1.7;
            max-width: 350px;
        }

    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="container nav-inner">
            <a href="homepage.aspx" class="logo">Strong<span>Ones</span></a>
            <ul class="nav-links">
                <li><a href="AboutUs.aspx">About Us</a></li>
                <li><a href="Workout.aspx">Workouts</a></li>
                <li><a href="Nutrition.aspx">Nutritions</a></li>
                <li><a href="ContactUs.aspx">Contact Us</a></li>
                <li><a href="FAQ.aspx">FAQ</a></li>
            </ul>
            <div class="nav-actions">
                <a href="Login.aspx">Login</a>
                <a href="Account.aspx">Profile</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section>
        Hero section
    </section>

    <!-- Features Section -->
    <section>
        Features section
    </section>

    <!-- Join Us Section -->
    <section>
        Join Us section
    </section>

    <!-- Footer-->
    <footer class="footer">
        <div class="container footer-inner">
            <div class="footer-brand">
                <a href="Homepage.aspx" class="logo">Strong<span>Ones</span></a>
                <p>Your own health and fitness education platform. Empowering healthier lifestyles for everyone.</p>
                <br />
                <p>&copy; 2026 StrongOnes. All rights reserved.</p>
            </div>
        </div>
    </footer>

</body>
</html>
