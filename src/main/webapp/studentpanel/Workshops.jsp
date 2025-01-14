<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.JSONArray" %>
<!-- Include the Navigation Bar -->
<%@ include file="nav.jsp" %>
<%
    // Access the session and retrieve the userID and sessionCookie
    String sessionId = (String) session.getAttribute("userID");
    String sessionCookie = (String) session.getAttribute("sessionCookie");
    if (sessionId == null || sessionId.isEmpty() || sessionCookie == null) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workshop Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f9;
        }
        h2 {
            color: #333;
            font-weight: bold;
            font-size: 32px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .feedback-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        .feedback-button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function submitFeedback(eid) {
            window.location.href = "feedback.jsp?eid=" + eid;
        }
    </script>
</head>
<body>
<h2>Workshop Details</h2>
<table>
    <thead>
    <tr>
        <th>EID</th>
        <th>Date</th>
        <th>Name</th>
        <th>Status</th>
        <th>Location</th>
        <th>Topic</th>
        <th>Speaker</th>
        <th>Duration</th>
        <th>BID</th>
        <th>Feedback</th>
    </tr>
    </thead>
    <tbody>
    <%
        // The API endpoint URL
        String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/student/workshops";

        HttpURLConnection connection = null;
        StringBuilder responseContent = new StringBuilder();

        try {
            URL url = new URL(apiUrl);
            connection = (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");

            // Add session cookie for authentication
            connection.setRequestProperty("Cookie", sessionCookie);

            int statusCode = connection.getResponseCode();
            if (statusCode == HttpURLConnection.HTTP_OK) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String line;
                while ((line = reader.readLine()) != null) {
                    responseContent.append(line);
                }
                reader.close();

                JSONArray workshops = new JSONArray(responseContent.toString());

                for (int i = 0; i < workshops.length(); i++) {
                    JSONObject workshop = workshops.getJSONObject(i);
                    String eid = workshop.getString("eid");
                    String date = workshop.getString("date");
                    String name = workshop.getString("name");
                    String status = workshop.getString("status");
                    String location = workshop.getString("location");
                    String topic = workshop.getString("topic");
                    String speaker = workshop.getString("speaker");
                    String duration = workshop.getString("duration");
                    String bid = workshop.getString("bid");
    %>
    <tr>
        <td><%= eid %></td>
        <td><%= date %></td>
        <td><%= name %></td>
        <td><%= status %></td>
        <td><%= location %></td>
        <td><%= topic %></td>
        <td><%= speaker %></td>
        <td><%= duration %></td>
        <td><%= bid %></td>
        <td>
            <button type="button" class="feedback-button" onclick="submitFeedback('<%= eid %>')">Submit Feedback</button>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="10" style="color: red;">Error: Unable to fetch workshops. HTTP Status: <%= statusCode %></td>
    </tr>
    <%
        }
    } catch (Exception e) {
    %>
    <tr>
        <td colspan="10" style="color: red;">Error: <%= e.getMessage() %></td>
    </tr>
    <%
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    %>
    </tbody>
</table>
</body>
</html>
