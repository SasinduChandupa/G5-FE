<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Registration</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
    <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Lecturer Registration</h1>
    <form id="lecturerRegisterForm" class="space-y-6">
        <div>
            <label for="name" class="block text-gray-700">Name:</label>
            <input type="text" id="name" name="name"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:ring-yellow-500 focus:border-yellow-500">
        </div>
        <div>
            <label for="email" class="block text-gray-700">Email:</label>
            <input type="email" id="email" name="email"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:ring-yellow-500 focus:border-yellow-500">
        </div>
        <div>
            <label for="password" class="block text-gray-700">Password:</label>
            <input type="password" id="password" name="password"
                   class="w-full border border-gray-300 rounded-lg p-2 focus:ring-yellow-500 focus:border-yellow-500">
        </div>
        <button type="submit"
                class="w-full bg-yellow-600 text-white py-2 rounded-lg hover:bg-yellow-700">Register</button>
    </form>
</div>
</body>
</html>
