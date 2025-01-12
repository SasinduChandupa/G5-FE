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
    <title>View Received Details</title>
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
    </style>
</head>
<body>
<h2>Feedback Details</h2>
<table>
    <thead>
    <tr>
        <th>FID</th>
        <th>Sender</th>
        <th>Receiver</th>
        <th>Description</th>
        <th>EID</th>
        <th>SID</th>
        <th>LID</th>
    </tr>
    </thead>
    <tbody>
    <%
        // The API endpoint URL
        String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/student/received";

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
                JSONArray receivedDetails = new JSONArray(responseContent.toString());

                // Iterate through the array and display details
                for (int i = 0; i < receivedDetails.length(); i++) {
                    JSONObject detail = receivedDetails.getJSONObject(i);
                    String fid = detail.getString("fid");
                    String sender = detail.getString("sender");
                    String receiver = detail.getString("receiver");
                    String description = detail.getString("description");
                    String eid = detail.getString("eid");
                    String sid = detail.getString("sid");
                    String lid = detail.getString("lid");
    %>
    <tr>
        <td><%= fid %></td>
        <td><%= sender %></td>
        <td><%= receiver %></td>
        <td><%= description %></td>
        <td><%= eid %></td>
        <td><%= sid %></td>
        <td><%= lid %></td>
    </tr>
    <%
                }
            } else {
                out.println("<tr><td colspan='7' style='color: red;'>Error: Unable to fetch data. HTTP Status: " + statusCode + "</td></tr>");
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='7' style='color: red;'>Error: " + e.getMessage() + "</td></tr>");
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