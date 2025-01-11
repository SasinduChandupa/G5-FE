<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.OutputStream" %>
<jsp:include page="navbar.jsp" />

<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("./logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Interview</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Create Interview</h1>
</header>

<!-- Main Form -->
<div class="container mx-auto my-8 p-4">
    <h2 class="text-xl font-bold text-blue-700 mb-4">Interview Details</h2>

    <form id="interviewForm" method="POST" action="CreateInterview.jsp">
        <div class="mb-4">
            <label for="name" class="block text-sm font-semibold">Interview Name</label>
            <input type="text" id="name" name="name" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="date" class="block text-sm font-semibold">Interview Date</label>
            <input type="date" id="date" name="date" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="status" class="block text-sm font-semibold">Status</label>
            <input type="text" id="status" name="status" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="interviewer" class="block text-sm font-semibold">Interviewer Name</label>
            <input type="text" id="interviewer" name="interviewer" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="location" class="block text-sm font-semibold">Location</label>
            <input type="text" id="location" name="location" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-md">Create Interview</button>
        </div>
    </form>

    <!-- Backend Processing -->
    <div class="mt-8">
        <%
            String responseMessage = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    // Extract form data
                    String name = request.getParameter("name");
                    String date = request.getParameter("date");
                    String status = request.getParameter("status");
                    String interviewer = request.getParameter("interviewer");
                    String location = request.getParameter("location");

                    // API URL for creating an interview
                    String apiUrl = "http://localhost:8080/api/v1/lecturer/events/create/interview";
                    URL url = new URL(apiUrl);
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("POST");
                    connection.setRequestProperty("Content-Type", "application/json");

                    // Add authentication cookie
                    String cookie = request.getHeader("Cookie");
                    if (cookie != null) {
                        connection.setRequestProperty("Cookie", cookie);
                    }

                    // Create JSON payload
                    JSONObject payload = new JSONObject();
                    payload.put("name", name);
                    payload.put("date", date);
                    payload.put("status", status);
                    payload.put("interviewer", interviewer);
                    payload.put("location", location);

                    // Send payload
                    connection.setDoOutput(true);
                    try (OutputStream os = connection.getOutputStream()) {
                        os.write(payload.toString().getBytes("utf-8"));
                    }

                    // Handle response
                    int responseCode = connection.getResponseCode();
                    if (responseCode == 200) {
                        responseMessage = "Success: Interview created successfully.";
                    } else {
                        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"))) {
                            StringBuilder errorResponse = new StringBuilder();
                            String line;
                            while ((line = br.readLine()) != null) {
                                errorResponse.append(line.trim());
                            }
                            responseMessage = "Error: " + errorResponse;
                        }
                    }
                } catch (Exception e) {
                    responseMessage = "Error: " + e.getMessage();
                }
            }
        %>

        <% if (!responseMessage.isEmpty()) { %>
        <div class="<%= responseMessage.startsWith("Success") ? "text-green-500" : "text-red-500" %>">
            <p><%= responseMessage %></p>
        </div>
        <% } %>
    </div>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>

</body>
</html>
