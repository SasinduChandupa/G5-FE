<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.*" %>
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
    <title>View Interviews</title>
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
<h2>Interview Details</h2>
<table>
    <thead>
    <tr>
        <th>Event ID</th>
        <th>Interviewer</th>
        <th>Location</th>
        <th>Date</th>
        <th>Feedback</th>
    </tr>
    </thead>
    <tbody>
    <%
        // The API endpoint URL
        String apiUrl = "http://localhost:8080/api/v1/students/interviews";

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
                JSONArray interviews = new JSONArray(responseContent.toString());

                // Iterate through the array and display interview details
                for (int i = 0; i < interviews.length(); i++) {
                    JSONObject interview = interviews.getJSONObject(i);
                    String eid = interview.getString("eid");
                    String interviewer = interview.getString("interviewer");
                    String location = interview.getString("location");
                    String date = interview.getString("date");
    %>
    <tr>
        <td><%= eid %></td>
        <td><%= interviewer %></td>
        <td><%= location %></td>
        <td><%= date %></td>
        <td>
            <!-- Call submitFeedback function with EID when the button is clicked -->
            <button type="button" class="feedback-button" onclick="submitFeedback('<%= eid %>')">Submit Feedback</button>
        </td>
    </tr>
    <%
                }
            } else {
                out.println("<tr><td colspan='4' style='color: red;'>Error: Unable to fetch interviews. HTTP Status: " + statusCode + "</td></tr>");
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='4' style='color: red;'>Error: " + e.getMessage() + "</td></tr>");
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