<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Registration - NIBM EVEX</title>
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
    </style>
</head>
<body class="relative bg-cover bg-center sm:bg-auto lg:bg-cover" style="background-image: url('images/lecturer3.jpg');">

<!-- Navigation Bar -->
<nav class="bg-gray-900 text-white shadow-md fixed w-full top-0 z-20">
    <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <!-- Logo Animation -->
            <img src="images/nibm.jpg" alt="EVEX Logo"
                 class="logo w-30 cursor-pointer max-h-20 px-5">

            <!-- Text Animation -->
            <span class="brand-title text-white text-2xl font-bold">
                NIBM EVEX
            </span>
        </div>
        <!-- Navigation Links -->
        <div class="flex space-x-6">
            <a href="#" class="hover:text-green-400 transition">Home</a>
        </div>
    </div>
</nav>
<div><br><br><br><br><br><br><br></div>
<!-- Registration Section -->
<section class="relative h-screen flex items-center justify-center">
    <!-- Dark Overlay -->
    <div class="absolute inset-0 bg-black opacity-50"></div>

    <!-- Main Container -->
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md relative z-10">
        <!-- Heading -->
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Lecturer Registration</h1>

        <!-- Registration Form -->
        <form id="lecturerRegisterForm" class="space-y-6">
            <!-- Name Field -->
            <div>
                <label for="name" class="block text-gray-700 font-medium mb-2">Name:</label>
                <input type="text" id="name" name="name"
                       class="w-full border border-gray-300 rounded-md p-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
                       placeholder="Enter your name" required>
            </div>

            <!-- Email Field -->
            <div>
                <label for="email" class="block text-gray-700 font-medium mb-2">Email:</label>
                <input type="email" id="email" name="email"
                       class="w-full border border-gray-300 rounded-md p-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
                       placeholder="Enter your email" required>
            </div>

            <!-- Username Field -->
            <div>
                <label for="username" class="block text-gray-700 font-medium mb-2">Username:</label>
                <input type="text" id="username" name="username"
                       class="w-full border border-gray-300 rounded-md p-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
                       placeholder="Enter your username" required>
            </div>

            <!-- Password Field -->
            <div>
                <label for="password" class="block text-gray-700 font-medium mb-2">Password:</label>
                <input type="password" id="password" name="password"
                       class="w-full border border-gray-300 rounded-md p-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
                       placeholder="Enter your password" required>
            </div>

            <!-- Contact Field -->
            <div>
                <label for="contact" class="block text-gray-700 font-medium mb-2">Contact:</label>
                <input type="text" id="contact" name="contact"
                       class="w-full border border-gray-300 rounded-md p-3 focus:outline-none focus:ring-2 focus:ring-blue-400"
                       placeholder="Enter your contact number" required>
            </div>

            <!-- Submit Button -->
            <div>
                <button type="submit"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
                    Register
                </button>
            </div>
        </form>

        <!-- Feedback Message -->
        <div id="responseMessage" class="text-center text-sm mt-4"></div>
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
                            No. 132, Pettigalawatta, Matara Road, Galle.
                        </a>
                    </li>
                    <li>
                        <a href="#" class="hover:text-green-400 transition">
                            <i class="fa-solid fa-envelope text-white mr-2"></i> nibmevex.edu.lk
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

<!-- JavaScript for Form Submission -->
<script>
    document.getElementById("lecturerRegisterForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        const responseMessageDiv = document.getElementById("responseMessage");
        responseMessageDiv.innerHTML = ""; // Clear previous messages

        // Collect form data
        const formData = {
            name: document.getElementById("name").value,
            email: document.getElementById("email").value,
            username: document.getElementById("username").value,
            password: document.getElementById("password").value,
            contact: document.getElementById("contact").value
        };

        try {
            // Send POST request to the backend
            const response = await fetch("https://virtserver.swaggerhub.com/ChanukaDilshan-8ba/event-management_system_api/1.0.0/admin/lecturer/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(formData)
            });

            // Parse JSON response
            const data = await response.json();

            // Handle the response
            if (response.ok) {
                responseMessageDiv.innerHTML = `<p class="text-green-600 font-medium">${data.message || "Registration Successful!"}</p>`;
                alert("Registration Successful!");
                window.location.href = "/lecturer/dashboard"; // Redirect after success
            } else {
                responseMessageDiv.innerHTML = `<p class="text-red-600 font-medium">${data.message || "Registration Failed. Please try again."}</p>`;
            }
        } catch (error) {
            console.error("Error:", error);
            responseMessageDiv.innerHTML = `<p class="text-red-600 font-medium">An unexpected error occurred. Please try again.</p>`;
        }
    });
</script>

</body>
</html>
