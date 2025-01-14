<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="navbar.jsp" />

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
    <title>Create Workshop</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Create Workshop</h1>
</header>

<!-- Form for Creating Workshop -->
<div class="container mx-auto my-8 p-4">
    <h2 class="text-xl font-bold text-blue-700 mb-4">Workshop Details</h2>

    <form method="POST" action="CreateWorkshop.jsp">
        <div class="mb-4">
            <label for="name" class="block text-sm font-semibold">Workshop Name</label>
            <input type="text" id="name" name="name" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="date" class="block text-sm font-semibold">Workshop Date</label>
            <input type="date" id="date" name="date" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="status" class="block text-sm font-semibold">Status</label>
            <input type="text" id="status" name="status" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="location" class="block text-sm font-semibold">Location</label>
            <input type="text" id="location" name="location" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="topic" class="block text-sm font-semibold">Topic</label>
            <input type="text" id="topic" name="topic" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="speaker" class="block text-sm font-semibold">Speaker</label>
            <input type="text" id="speaker" name="speaker" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="duration" class="block text-sm font-semibold">Duration (hours)</label>
            <input type="text" id="duration" name="duration" class="w-full px-4 py-2 border rounded-md" required>
        </div>

        <div class="mb-4">
            <label for="batchId" class="block text-sm font-semibold">Batch ID</label>
            <select id="batchId" name="batchId" class="w-full px-4 py-2 border rounded-md" required>
                <option value="">Select Batch</option>
                <%
                    String batchApiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/badges";
                    try {
                        // Get batches from API
                        URL url = new URL(batchApiUrl);
                        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                        connection.setRequestMethod("GET");
                        connection.setRequestProperty("Content-Type", "application/json");
                        connection.setRequestProperty("Cookie", sessionCookie);

                        int responseCode = connection.getResponseCode();
                        if (responseCode == 200) {
                            StringBuilder apiResponse = new StringBuilder();
                            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                                String responseLine;
                                while ((responseLine = br.readLine()) != null) {
                                    apiResponse.append(responseLine.trim());
                                }
                            }
                            // Parse the JSON response
                            JSONArray batches = new JSONArray(apiResponse.toString());
                            for (int i = 0; i < batches.length(); i++) {
                                JSONObject batch = batches.getJSONObject(i);
                                String bid = batch.getString("bid");
                                String name = batch.getString("name");
                %>
                <option value="<%= bid %>"><%= name + " (" + bid + ")" %></option>
                <%
                    }
                } else {
                %>
                <option value="">No batches available</option>
                <%
                    }
                } catch (Exception e) {
                %>
                <option value="">Error loading batches</option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="mb-4">
            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-md">Create Workshop</button>
        </div>
    </form>

    <div class="mt-8">
        <%
            String responseMessage = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    // Extract values from the form submission
                    String name = request.getParameter("name");
                    String date = request.getParameter("date");
                    String status = request.getParameter("status");
                    String location = request.getParameter("location");
                    String topic = request.getParameter("topic");
                    String speaker = request.getParameter("speaker");
                    String duration = request.getParameter("duration");
                    String batchId = request.getParameter("batchId");

                    // Set up the connection to the API endpoint
                    String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/events/create/workshop";
                    URL url = new URL(apiUrl);
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("POST");
                    connection.setRequestProperty("Content-Type", "application/json");
                    connection.setRequestProperty("Cookie", sessionCookie);

                    // Create JSON payload
                    JSONObject jsonPayload = new JSONObject();
                    jsonPayload.put("date", date);
                    jsonPayload.put("name", name);
                    jsonPayload.put("status", status);
                    jsonPayload.put("location", location);
                    jsonPayload.put("topic", topic);
                    jsonPayload.put("speaker", speaker);
                    jsonPayload.put("duration", duration);
                    jsonPayload.put("bid", batchId);

                    // Send the request
                    connection.setDoOutput(true);
                    try (OutputStream os = connection.getOutputStream()) {
                        byte[] input = jsonPayload.toString().getBytes("utf-8");
                        os.write(input, 0, input.length); // Write the request payload
                    }

                    // Handle the response
                    int responseCode = connection.getResponseCode();
                    StringBuilder apiResponse = new StringBuilder();
                    if (responseCode == 200) {
                        try (BufferedReader br = new BufferedReader(
                                new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                            String responseLine;
                            while ((responseLine = br.readLine()) != null) {
                                apiResponse.append(responseLine.trim());
                            }
                            responseMessage = "Success: " + apiResponse.toString();
                        }
                    } else {
                        responseMessage = "Error: Received HTTP " + responseCode;
                    }
                } catch (Exception e) {
                    responseMessage = "Error: Unable to create the workshop. " + e.getMessage();
                }
            }
        %>

        <% if (!responseMessage.isEmpty()) { %>
        <div class="mt-4 text-green-500">
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
