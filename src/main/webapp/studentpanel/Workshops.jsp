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
    if (sessionId == null || sessionId.isEmpty()) {
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
            font-weight: bold;  /* Make the text bold */
            font-size: 32px;     /* Increase the font size */
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
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        .feedback-button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        // Function to handle the row selection and redirect to the feedback page
        function submitFeedback(eid) {
            // Redirect to feedback.jsp with the selected EID as a query parameter
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
        String apiUrl = "http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/student/workshops";

        HttpURLConnection connection = null;
        StringBuilder responseContent = new StringBuilder();

        try {
            // Create a URL object and open a connection
            URL url = new URL(apiUrl);
            connection = (HttpURLConnection) url.openConnection();

            // Set up the request method and headers
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");

            // Ensure cookies are sent if available
            String cookieHeader = request.getHeader("Cookie");
            if (cookieHeader != null) {
                connection.setRequestProperty("Cookie", cookieHeader);
            }

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
                JSONArray workshops = new JSONArray(responseContent.toString());

                // Display the workshops
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
            <!-- Call submitFeedback function with EID when the button is clicked -->
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