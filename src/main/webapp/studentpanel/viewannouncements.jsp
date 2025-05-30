<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONArray" %>
<!-- Include the Navigation Bar -->
<%@ include file="nav.jsp" %>
<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    String sessionCookie = (String) session.getAttribute("sessionCookie");
    if (sessionId == null || sessionId.isEmpty() || sessionCookie == null) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>
<%
    // The API endpoint URL
    String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/students/announcements";

    // Set response content type to HTML
    response.setContentType("text/html");
    PrintWriter writer = response.getWriter();

    HttpURLConnection connection = null;
    StringBuilder responseContent = new StringBuilder();

    try {
        // Open connection to the API
        URL url = new URL(apiUrl);
        connection = (HttpURLConnection) url.openConnection();

        // Set up the request method and headers
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept", "application/json");

        // Add session cookie for authentication
        connection.setRequestProperty("Cookie", sessionCookie);

        // Read the response
        int statusCode = connection.getResponseCode();
        if (statusCode == HttpURLConnection.HTTP_OK) {
            InputStream inputStream = connection.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String line;
            while ((line = reader.readLine()) != null) {
                responseContent.append(line);
            }
            reader.close();

            // Parse the JSON response
            JSONArray jsonResponse = new JSONArray(responseContent.toString());

            // Display announcements
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Announcements</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #333;
            font-weight: bold;
            font-size: 32px;
        }
        .announcement {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }
        .announcement h3 {
            margin: 0;
            color: #007bff;
        }
        .announcement p {
            margin: 5px 0;
            color: #555;
        }
        .announcement .date {
            font-size: 0.9em;
            color: #888;
        }
    </style>
</head>
<body>
<h2>Announcements</h2>
<div>
    <% for (int i = 0; i < jsonResponse.length(); i++) {
        JSONObject announcement = jsonResponse.getJSONObject(i);
        String eid = announcement.getString("eid");
        String description = announcement.getString("description");
        String bid = announcement.getString("bid");
        String date = announcement.getString("date");
    %>
    <div class="announcement">
        <h3>Event ID: <%= eid %></h3>
        <p><strong>Description:</strong> <%= description %></p>
        <p><strong>Batch ID:</strong> <%= bid %></p>
        <p class="date"><strong>Date:</strong> <%= date %></p>
    </div>
    <% } %>
</div>
</body>
</html>
<%
        } else {
            writer.println("<p style='color: red;'>Error: Unable to fetch announcements. HTTP Status: " + statusCode + "</p>");
        }
    } catch (Exception e) {
        writer.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (connection != null) {
            connection.disconnect();
        }
    }
%>
