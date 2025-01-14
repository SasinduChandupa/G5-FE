<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>
<jsp:include page="navbar.jsp" />

<%
    // Access the session and retrieve the sessionCookie
    String sessionCookie = (String) session.getAttribute("sessionCookie");
    if (sessionCookie == null || sessionCookie.isEmpty()) {
        response.sendRedirect("./logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Announcements</h1>
</header>

<!-- Announcements Section -->
<div class="container mx-auto my-8 p-4">
    <%
        String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/get/announcements";
        JSONArray announcements = new JSONArray();

        try {
            // Set up the connection
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");

            // Add the session cookie for authentication
            connection.setRequestProperty("Cookie", sessionCookie);

            int responseCode = connection.getResponseCode();

            if (responseCode == 200) {
                // Read the response
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder responseBody = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    responseBody.append(line);
                }
                reader.close();

                // Parse JSON response
                announcements = new JSONArray(responseBody.toString());
            } else {
                out.println("<p class='text-red-500'>Failed to fetch announcements. HTTP Status: " + responseCode + "</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-red-500'>Error fetching announcements: " + e.getMessage() + "</p>");
        }
    %>

    <!-- Display Announcements -->
    <h2 class="text-xl font-bold text-blue-700 mb-4">All Announcements</h2>
    <div class="bg-white shadow-md p-4 rounded-lg">
        <%
            if (announcements.length() > 0) {
                for (int i = 0; i < announcements.length(); i++) {
                    JSONObject announcement = announcements.getJSONObject(i);
                    String eid = announcement.optString("eid", "N/A");
                    String description = announcement.optString("description", "N/A");
                    String bid = announcement.optString("bid", "N/A");
        %>
        <div class="p-4 border-b border-gray-300">
            <p><strong>ID:</strong> <%= eid %></p>
            <p><strong>Description:</strong> <%= description %></p>
            <p><strong>BID:</strong> <%= bid %></p>
        </div>
        <%
            }
        } else {
        %>
        <p class="text-gray-500">No announcements available.</p>
        <%
            }
        %>
    </div>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>

</body>
</html>
