<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<!-- Main Container -->
<div class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
    <!-- Heading -->
    <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Admin Login</h1>

    <!-- Login Form -->
    <form id="adminLoginForm" class="space-y-6">
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

        <!-- Submit Button -->
        <div>
            <button type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
                Login
            </button>
        </div>
    </form>

    <!-- Footer -->
    <p class="text-center text-gray-500 text-sm mt-6">
        © 2024 Event Management System. All rights reserved.
    </p>
</div>

<script>
    // JavaScript to handle form submission
    document.getElementById("adminLoginForm").addEventListener("submit", async (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        const response = await fetch("/api/v1/admin/login", {
            method: "POST",
            body: JSON.stringify(Object.fromEntries(formData)),
            headers: { "Content-Type": "application/json" }
        });
        const data = await response.json();

        if (response.ok) {
            alert(data.message || "Login Successful");
            // Redirect to the admin dashboard (if applicable)
            window.location.href = "/admin/dashboard";
        } else {
            alert(data.message || "Login Failed. Please try again.");
        }
    });
</script>
</body>
</html>
