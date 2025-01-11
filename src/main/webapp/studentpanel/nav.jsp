<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NIBM EVEX</title>
    <!-- Link to Tailwind CSS (you can replace with your CDN or local file) -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="m-0 p-0">
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
        <!-- Navigation Links -->
        <div class="flex space-x-6">
            <a href="studentdashboard.jsp" class="hover:text-green-400 transition">Home</a>
            <!-- Additional Navigation Links -->
            <a href="editprofile.jsp" class="hover:text-green-400 transition">Update Profile</a>
            <a href="updateportfolio.jsp" class="hover:text-green-400 transition">Career Portfolio</a>
            <a href="Interviews.jsp" class="hover:text-green-400 transition">View Interviews</a>
            <a href="Workshops.jsp" class="hover:text-green-400 transition">View Workshops</a>
            <a href="viewfeedback.jsp" class="hover:text-green-400 transition">View Feedback</a>
            <a href="viewannouncements.jsp" class="hover:text-green-400 transition">View Announcements</a>
            <a href="viewprofile.jsp" class="hover:text-green-400 transition">View Profile</a>
            <a href="viewportfolio.jsp" class="hover:text-green-400 transition">View Portfolio</a>

            <!-- Logout Button -->
            <a href="../logout.jsp" class="hover:text-green-400 transition">
                <button class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md">
                    Logout
                </button>
            </a>
        </div>
    </div>
</nav>

<!-- Main Content Section -->
<div class="pt-24 px-6 mb-12">
    <!-- Your content goes here -->
</div>
</body>

</html>