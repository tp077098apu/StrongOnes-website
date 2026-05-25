<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>StrongOnes - Health and Fitness Education</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
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
               
        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
        }

        /*Layout*/
        .container {
            max-width: 1160px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /*Buttons*/
        .btn {
            display: inline-block;
            padding: 11px 28px;
            border-radius: 6px;
            font-size: 0.92rem;
            font-weight: 600;
            cursor: pointer;
            border: 2px solid transparent;
            transition: var(--transition);
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

        .btn-outline-white {
            background: transparent;
            color: var(--white);
            border-color: var(--white);
            display: inline-block;
            padding: 11px 28px;
            border-radius: 6px;
            font-size: 0.92rem;
            font-weight: 600;
            border: 2px solid var(--white);
            transition: var(--transition);
        }
        .btn-outline-white:hover {
            background: var(--white);
            color: var(--purple);
        }

        /*Section Header*/
        .section-header {
            text-align: center;
            margin-bottom: 48px;
        }
        .section-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 10px;
        }
        .section-header p {
            font-size: 1rem;
            color: var(--gray-mid);
            max-width: 500px;
            margin: 0 auto;
        }

        /*Navigation Bar*/
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

        /*Hero section*/
        .hero {
            background: var(--off-white);
            padding: 40px 0;
        }

        .hero-inner {
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            gap: 60px;
        }

        .hero-text h1 {
            font-size: 3rem;
            font-weight: 800;
            color: var(--black);
            line-height: 1.15;
            margin-bottom: 18px;
        }

        .hero-text h1 span { 
            color: var(--purple); 
        }

        .hero-text p {
            font-size: 1.05rem;
            color: var(--gray-mid);
            margin-bottom: 32px;
            max-width: 440px;
            line-height: 1.7;
        }

        .hero-ctas { 
            display: flex; gap: 14px; 
        }

        .hero-image {
            height: 420px;
            border-radius: var(--radius);
            overflow: hidden;
            background: var(--gray-light);
        }

        .hero-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }

        /*Features*/
        .features {
            padding: 50px 0;
            background: var(--white);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        .feat-card {
            padding: 32px 26px;
            border: 1px solid var(--gray-light);
            border-radius: var(--radius);
            background: var(--white);
            transition: var(--transition);
        }
        .feat-card:hover {
            border-color: var(--purple);
            box-shadow: var(--shadow);
            transform: translateY(-4px);
        }

        .feat-card h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 10px;
        }

        .feat-card p {
            font-size: 0.9rem;
            color: var(--gray-mid);
            line-height: 1.65;
            margin-bottom: 16px;
        }

        .card-link {
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--purple);
            transition: var(--transition);
        }
        .card-link:hover {
            letter-spacing: 0.02em;
        }

        /*Join Us*/
        .join-cta {
            background: var(--purple);
            padding: 50px 0;
            text-align: center;
        }

        .cta-inner h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--white);
            margin-bottom: 14px;
        }

        .cta-inner p {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.78);
            margin-bottom: 36px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
        }

        .cta-btns {
            display: flex;
            justify-content: center;
            gap: 14px;
        }
        
        /*Footer*/
        .footer {
            background: var(--black);
            color: rgba(255, 255, 255, 0.65);
            padding: 50px 0 0;
        }

        .footer-inner {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 48px;
            padding-bottom: 52px;
        }

        .footer-col h4 {
            color: var(--white);
            font-size: 0.85rem;

            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 16px;
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

        .footer-contact {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 20px;
        }

        .contact-link {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.88rem;
            color: rgba(255, 255, 255, 0.65);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .contact-link:hover {
            color: var(--purple-light);
        }

        .contact-icon {
            font-size: 1.1rem;
            color: var(--purple-light);
            width: 18px;
            text-align: center;
        }

        .social-links {
            display: flex;
            gap: 10px;
            margin-top: 8px;
        }

        .social-btn {
            width: 38px;
            height: 38px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .social-btn:hover { 
            background: var(--purple); color: var(--white); 
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
                <a href="UserAccount.aspx">Profile</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container hero-inner">
            <div class="hero-text">
                <h1>Be On Top<br /><span>With Your Body and Mind.</span></h1>
                <p>Access hundreds of workouts, healthy recipes and personalised goal tracking — all in one place. Built for everyone.</p>
                <div class="hero-ctas">
                    <a href="Login.aspx" class="btn btn-purple">Join for Free</a>
                    <a href="Workout.aspx" class="btn btn-outline">Browse Workout</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="images/hero.jpg" alt="StrongOnes fitness" />
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <div class="section-header">
                <h2>Everything You Need to Reach Your Fitness Goal</h2>
                <p>From workout plans to nutritional guidance — StrongOnes is your all-in-one health education platform.</p>
            </div>
            <div class="features-grid">
                <div class="feat-card">          
                    <h3>Structured Workouts</h3>
                    <p>Browse hundreds workout routines categorised by fitness level, muscle group and workout style.</p>
                    <a href="Workout.aspx" class="card-link">Explore workouts &rarr;</a>
                </div>
                <div class="feat-card">
                    <h3>Nutrition Guidance</h3>
                    <p>Discover healthy recipes, meal plans and calorie guides tailored to support your fitness goals.</p>
                    <a href="Nutrition.aspx" class="card-link">View recipes &rarr;</a>
                </div>
                <div class="feat-card">
                    <h3>Goal Tracker</h3>
                    <p>Set personal fitness milestones and track your progress over time with our built-in goal tracking tool.</p>
                    <a href="*" class="card-link">Start tracking &rarr;</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Join Us Section -->
    <section class="join-cta">
        <div class="container cta-inner">
            <h2>Ready to Start Your Journey?</h2>
            <p>Join thousands of members already living healthier lives with StrongOnes for free and get started.</p>
            <div class="cta-btns">
                <a href="Register.aspx" class="btn btn-purple">Create Free Account</a>
                <a href="AboutUs.aspx" class="btn btn-outline-white">Learn More</a>
            </div>
        </div>
    </section>

    <!-- Footer-->
    <footer class="footer">
        <div class="container footer-inner">
            <div class="footer-brand">
                <a href="Homepage.aspx" class="logo">Strong<span>Ones</span></a>
                <p>Your own health and fitness education platform. Empowering healthier lifestyles for everyone.</p>
                <br />
                <div class="footer-col">
                    <h4>Contact Us</h4>
                    <ul class="footer-contact">
                        <li>
                            <a href="https://wa.me/60128894667" target="_blank" class="contact-link">
                                <i class="fa-brands fa-whatsapp contact-icon"></i>
                                +60 12-889 4667
                            </a>
                        </li>
                        <li>
                            <a href="mailto:supportstrongones@gmail.com" class="contact-link">
                                <i class="fa-solid fa-envelope contact-icon"></i>
                                supportstrongones@gmail.com
                            </a>
                        </li>
                    </ul>
                     <h4 style="margin-top: 24px;">Follow Us</h4>
                    <div class="social-links">
                        <a href="https://instagram.com/strongones" target="_blank" class="social-btn">
                            <i class="fa-brands fa-instagram"></i>
                        </a>
                        <a href="https://tiktok.com/@strongones" target="_blank" class="social-btn">
                            <i class="fa-brands fa-tiktok"></i>
                        </a>
                        <a href="https://facebook.com/strongones" target="_blank" class="social-btn">
                            <i class="fa-brands fa-facebook"></i>
                        </a>
                    </div>
                </div>
                <br />
                <p>&copy; 2026 StrongOnes. All rights reserved.</p>
            </div>
        </div>
    </footer>

</body>
</html>
