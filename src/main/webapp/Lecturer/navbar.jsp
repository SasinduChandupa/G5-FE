<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navigation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<!-- Navbar -->
<nav class="bg-blue-800 text-white px-6 py-4 flex justify-between items-center">
    <div class="text-2xl font-bold">NIBMEvex</div>
    <div class="space-x-6">
        <a href="LecturerDashbord.jsp" class="hover:underline text-white font-medium">Home</a>
        <a href="workshops.jsp" class="hover:underline text-white font-medium">Workshop</a>
        <a href="interviews.jsp" class="hover:underline text-white font-medium">Interview</a>
        <a href="displayAnnouncement.jsp" class="hover:underline text-white font-medium">Announcements</a>
        <a href="manageEvent.jsp" class="hover:underline text-white font-medium">Manage Event</a>
        <a href="../logout.jsp" class="hover:underline text-white font-medium">Logout</a>

    </div>
</nav>
</body>
</html>
