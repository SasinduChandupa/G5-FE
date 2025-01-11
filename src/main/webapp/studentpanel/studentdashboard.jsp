<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Add Button -->
    <div class="text-center">
        <button onclick="goToInterviews()" class="bg-blue-600 text-white font-bold py-3 px-6 rounded-md">
            View Interviews
        </button>
    </div>

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
        .bg-bright {
            filter: brightness(1.2);
        }
    </style>
</head>
<body class="relative bg-cover bg-center sm:bg-auto lg:bg-cover" style="background-image: url('../pictures/grad3.jpg');">

<!-- Navigation Bar -->
<nav class="bg-gray-900 text-white shadow-md fixed w-full top-0 z-20">
    <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <!-- Logo Animation -->
            <img src="../images/nibm.jpg" alt="EVEX Logo"
                 class="logo w-30 cursor-pointer max-h-20 px-5">

            <!-- Text Animation -->
            <span class="brand-title text-white text-2xl font-bold">
                NIBM EVEX
            </span>
        </div>
    </div>
</nav>

<!-- Brightened background overlay -->
<div class="absolute inset-0 bg-bright bg-opacity-70"></div>
<div class="relative min-h-screen flex items-center justify-center bg-gray-100 bg-opacity-20">
    <div class="w-full max-w-7xl mx-auto px-6 py-12">
        <!-- Section Heading -->
        <h1 class="text-4xl font-extrabold text-center mb-12" style="color: white; text-shadow: 2px 2px 4px black;">
            Welcome to the Student Dashboard
        </h1>

        <!-- Grid container -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">

            <!-- View Interviews -->
            <div class="p-8 bg-gradient-to-r from-green-300 to-green-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="Interviews.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-microphone-alt text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Interviews</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        Check out the latest Interviews.
                    </p>
                </a>
            </div>

            <!-- View Workshops -->
            <div class="p-8 bg-gradient-to-r from-green-500 to-green-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="Workshops.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-chalkboard-teacher text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Workshops</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        Check out the latest Workshops.
                    </p>
                </a>
            </div>

            <!-- View Feedback -->
            <div class="p-8 bg-gradient-to-r from-green-600 to-green-900 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="viewfeedback.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-star text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Feedback</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        See feedback you’ve received from lecturers.
                    </p>
                </a>
            </div>

            <!-- Announcements -->
            <div class="p-8 bg-gradient-to-r from-green-600 to-green-900 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="viewannouncements.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-bullhorn text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Announcements</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        Stay updated with the latest news and announcements.
                    </p>
                </a>
            </div>

            <!-- View Profile -->
            <div class="p-8 bg-gradient-to-r from-orange-500 to-orange-800 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="viewprofile.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-id-card text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Profile</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        Check out your profile.
                    </p>
                </a>
            </div>

            <!-- View Portfolio -->
            <div class="p-8 bg-gradient-to-r from-orange-600 to-orange-900 text-white rounded-lg shadow-lg hover:scale-105 transform transition duration-300 hover:shadow-2xl">
                <a href="viewportfolio.jsp" class="block text-center">
                    <div class="flex justify-center mb-4">
                        <i class="fas fa-folder-open text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold">View Portfolio</h2>
                    <p class="mt-2 text-white/90 hover:text-white">
                        Check out your portfolio.
                    </p>
                </a>
            </div>
        </div>
    </div>
</div>


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

</body>
</html>