<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%
    // Access the session and retrieve the userID and sessionCookie
    String sessionId = (String) session.getAttribute("userID");
    String sessionCookie = (String) session.getAttribute("sessionCookie");

    if (sessionId == null || sessionId.isEmpty() || sessionCookie == null || sessionCookie.isEmpty()) {
        response.sendRedirect("./logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Feedback</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">

<!-- Header -->
<header class="bg-blue-800 text-white py-4">
    <div class="container mx-auto px-4">
        <h1 class="text-2xl font-bold">Feedback Management System</h1>
    </div>
</header>

<div class="container mx-auto px-4 py-8 flex-grow">
    <h3 class="text-xl font-semibold mb-6">View All Feedback</h3>

    <%
        String feedbackData = null;

        try {
            // Connect to the backend API
            URL url = new URL("http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/received");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");

            // Pass session cookie for authentication
            connection.setRequestProperty("Cookie", sessionCookie);

            int responseCode = connection.getResponseCode();
            if (responseCode == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();
                feedbackData = jsonResponse.toString();
            } else {
                feedbackData = "Failed to fetch feedback. HTTP Code: " + responseCode;
            }
        } catch (Exception e) {
            feedbackData = "Error: " + e.getMessage();
        }

        // Parse JSON and display feedback in a table
        if (feedbackData != null) {
            if (feedbackData.startsWith("[")) {
    %>
    <div class="bg-white shadow rounded-lg p-6">
        <h4 class="text-lg font-bold mb-4">Feedback List</h4>
        <table class="min-w-full border border-gray-200">
            <thead>
            <tr class="bg-blue-800 text-white">
                <th class="px-4 py-2 text-left">Feedback ID</th>
                <th class="px-4 py-2 text-left">Sender ID</th>
                <th class="px-4 py-2 text-left">Receiver ID</th>
                <th class="px-4 py-2 text-left">Description</th>
                <th class="px-4 py-2 text-left">Event ID</th>
                <th class="px-4 py-2 text-left">Profile</th>
            </tr>
            </thead>
            <tbody class="bg-white">
            <%
                JSONArray feedbackArray = new JSONArray(feedbackData);
                for (int i = 0; i < feedbackArray.length(); i++) {
                    JSONObject feedback = feedbackArray.getJSONObject(i);
            %>
            <tr class="border-b border-gray-200 hover:bg-gray-50">
                <td class="px-4 py-2"><%= feedback.getString("fid") %></td>
                <td class="px-4 py-2"><%= feedback.getString("sender") %></td>
                <td class="px-4 py-2"><%= feedback.getString("receiver") %></td>
                <td class="px-4 py-2"><%= feedback.getString("description") %></td>
                <td class="px-4 py-2"><%= feedback.getString("eid") %></td>
                <td class="px-4 py-2">
                    <!-- Profile icon for View Profile -->
                    <a href="./studentProfile.jsp?studentId=<%= feedback.getString("sender") %>" class="text-blue-800 hover:text-blue-600">
                        <i class="fas fa-user-circle text-xl"></i>
                    </a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
    } else {
    %>
    <div class="text-red-600 text-center mt-6">
        <%= feedbackData %>
    </div>
    <%
            }
        }
    %>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>

</body>
</html>
