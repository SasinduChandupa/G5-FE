<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Event Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<!-- Main Container -->
<div class="bg-white shadow-lg rounded-lg p-8 max-w-md w-full text-center">
    <!-- Heading -->
    <h1 class="text-4xl font-bold text-gray-800 mb-4">Welcome to Event Management</h1>
    <p class="text-gray-600 mb-8">Please select your role to proceed:</p>

    <!-- Role Selection Buttons -->
    <div class="space-y-4">
        <a href="auth/admin-login.jsp" class="block bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-md">
            Admin Login
        </a>
        <a href="auth/student-login.jsp" class="block bg-green-600 hover:bg-green-700 text-white font-medium py-3 px-4 rounded-md">
            Student Login
        </a>
        <a href="auth/lecturer-login.jsp" class="block bg-yellow-500 hover:bg-yellow-600 text-white font-medium py-3 px-4 rounded-md">
            Lecturer Login
        </a>
    </div>
</div>

</body>
</html>
