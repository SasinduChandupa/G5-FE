<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        primary: '#1E3A8A',
                        secondary: '#3B82F6',
                        accent: '#E0F2FE'
                    }
                }
            }
        };
    </script>
    <style>
        body {
            background-image: url('C:/Users/User/Downloads/Galle_1.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
        }

        body.dark {
            background-image: none;
            background-color: #1A202C; /* Tailwind dark background color */
        }
    </style>

</head>

<body class="bg-accent font-sans min-h-screen flex flex-col transition duration-300">

<!-- Header -->
<header class="bg-gradient-to-r from-primary to-secondary text-white shadow-lg">
    <div class="max-w-6xl mx-auto px-4">
        <!-- Title -->
        <div class="py-6 flex justify-between items-center">
            <h1 class="text-3xl font-bold uppercase tracking-wide">Lecturer Dashboard</h1>

        </div>

        <!-- Navigation Bar -->
        <nav class="flex space-x-6 py-3 border-t border-white">
            <a href="workshops.jsp" class="hover:underline font-medium">Workshop</a>
            <a href="interviews.jsp" class="hover:underline font-medium">Interview</a>
            <a href="displayAnnouncement.jsp" class="hover:underline font-medium">Announcements</a>
            <a href="manageEvent.jsp" class="hover:underline font-medium">Manage Event</a>
            <a href="../logout.jsp" class="hover:underline font-medium">Logout</a>

        </nav>
    </div>
</header>
<br>
<br>
<br>
<br>

<!-- Main Content -->
<main class="flex-grow container mx-auto my-10">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4 gap-x-10 justify-center items-center px-4">
        <!-- Create Interview -->
        <div
                class="p-6 bg-white dark:bg-gray-700 dark:text-white bg-opacity-80 shadow-xl rounded-lg hover:scale-105 transform transition duration-300">
            <a href="CreateInterview.jsp">
                <button
                        class="bg-secondary dark:bg-blue-600 text-white font-bold py-4 px-8 rounded-md w-full text-center text-lg hover:bg-blue-400">
                    Create Interview
                </button>
            </a>
        </div>

        <!-- Create Workshop -->
        <div
                class="p-6 bg-white dark:bg-gray-700 dark:text-white bg-opacity-80 shadow-xl rounded-lg hover:scale-105 transform transition duration-300">
            <a href="CreateWorkshop.jsp">
                <button
                        class="bg-secondary dark:bg-blue-600 text-white font-bold py-4 px-8 rounded-md w-full text-center text-lg hover:bg-blue-400">
                    Create Workshop
                </button>
            </a>
        </div>

        <!-- Make Announcement -->
        <div
                class="p-6 bg-white dark:bg-gray-700 dark:text-white bg-opacity-80 shadow-xl rounded-lg hover:scale-105 transform transition duration-300">
            <a href="announcements.jsp">
                <button
                        class="bg-secondary dark:bg-blue-600 text-white font-bold py-4 px-8 rounded-md w-full text-center text-lg hover:bg-blue-400">
                    Make Announcement
                </button>
            </a>
        </div>

        <!-- View Feedbacks -->
        <div
                class="p-6 bg-white dark:bg-gray-700 dark:text-white bg-opacity-80 shadow-xl rounded-lg hover:scale-105 transform transition duration-300">
            <a href="viewfeedback.jsp">
                <button
                        class="bg-secondary dark:bg-blue-600 text-white font-bold py-4 px-8 rounded-md w-full text-center text-lg hover:bg-blue-400">
                    View Feedbacks
                </button>
            </a>
        </div>
    </div>
</main>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-primary to-secondary dark:from-gray-800 dark:to-gray-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 Lecturer Dashboard. All Rights Reserved.</p>
</footer>

<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>

</body>

</html>
