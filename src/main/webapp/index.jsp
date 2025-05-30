<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Event Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Custom Keyframes for Animations */
        @keyframes showRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Logo Animation */
        .logo {
            animation: showRight 1s ease forwards;
            animation-delay: 0.2s;
        }

        /* Brand Title Animation */
        .brand-title {
            animation: showRight 1.5s ease forwards;
            animation-delay: 0.6s;
        }

        /* Main Header Animation */
        .hero-title {
            position: relative;
            font-size: 28px;
            font-weight: 700;
            color: #ffffff;
            animation: showRight 1s ease forwards;
            animation-delay: 0.9s;
        }

        .hero-title::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            color: #ffffff;
            animation: showRight 1s ease forwards;
            animation-delay: 0.9s;

        }
    </style>
</head>
<body class="relative" style="background-image: url('auth/images/Galle_2.jpg'); background-size: cover; background-position: center; height: 100vh; margin: 0; background-attachment: fixed;">
<!-- Navigation Bar -->
<nav class="bg-gray-900 text-white shadow-md fixed w-full top-0 z-20">
    <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <!-- Logo Animation -->
            <img src="images/nibm.jpg" alt="EVEX Logo"
                 class="logo w-30 cursor-pointer max-h-20 px-5">


        </div>
        <!-- Navigation Links -->
        <div class="flex space-x-6">
            <!-- Text Animation -->
            <span class="brand-title text-white text-2xl font-bold">
                NIBM EVEX
            </span>
        </div>
    </div>
</nav>

<!-- Main Section with Background Image -->
<section class="relative pt-20 w-full flex flex-col items-center justify-center text-center" style="height: 40vh; background: none;">
    <!-- Hero Image Content -->
    <div class="relative z-10 text-white">
        <h1 class="text-5xl md:text-6xl font-bold mb-4 hero-title">Welcome to Our Platform</h1>
        <p class="text-lg md:text-2xl mb-6">Your gateway to efficient student and lecturer management</p>
    </div>
</section>


<!-- Role Selection Section -->
<section class="bg-white rounded-lg sm:px-6 md:px-20 py-8 mx-4 shadow-lg bg-white/80 p-8 mx-auto w-full max-w-md relative z-20 -mt-20 shadow-lg">
    <!-- Heading -->
    <h2 class="text-4xl font-bold text-gray-800 mb-4 text-center">Get Started</h2>
    <p class="text-gray-600 mb-8 text-center">Please select your role to proceed:</p>

    <!-- Role Selection Buttons -->
    <div class="space-y-4">
        <a href="admin-login.jsp" class="block bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-md text-center">
            Admin Login
        </a>
        <a href="student-login.jsp" class="block bg-green-600 hover:bg-green-700 text-white font-medium py-3 px-4 rounded-md text-center">
            Student Login
        </a>
        <a href="lecturer-login.jsp" class="block bg-yellow-500 hover:bg-yellow-600 text-white font-medium py-3 px-4 rounded-md text-center">
            Lecturer Login
        </a>
    </div>
</section>

<!-- Footer Section -->
<footer class="bg-black/60 text-white">
    <div class="container mx-auto px-5 py-8">
        <!-- Top Divider -->
        <hr class="mb-4 border-gray-500">

        <!-- Footer Content -->
        <div class="flex flex-col md:flex-row justify-center items-center text-center">
            <!-- Contact Section -->
            <section id="Contact-section" class="drop-shadow-lg px-4 sm:px-6 md:px-20 py-2 mx-4">
                <h6 class="mx-auto text-xl font-semibold mb-3">Contact Us</h6>
                <ul class="space-y-2">
                    <li>
                        <a href="#" class="hover:text-green-400 transition">
                            <i class="fa-solid fa-phone text-white mr-2"></i> +94 117 321 000
                        </a>
                    </li>
                    <li>
                        <a href="#" class="hover:text-green-400 transition">
                            <i class="fa-solid fa-house text-white mr-2"></i> National Institute of Business Management <br>
                            Galle Campus<br>
                            No. 132, Pettigalawatta, Matara Road,Galle.
                        </a>
                    </li>
                    <li>
                        <a href="#" class="hover:text-green-400 transition">
                            <i class="fa-solid fa-envelope text-white mr-2"></i>nibmevex.edu.lk
                        </a>
                    </li>
                </ul>
            </section>
        </div>

        <!-- Bottom Divider -->
        <hr class="my-4 border-gray-500">

        <!-- Footer Bottom -->
        <div class="text-center text-gray-300 text-sm">
            &copy; 2024 Event Management. All rights reserved.
        </div>
    </div>
</footer>

<!-- Font Awesome Script -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>