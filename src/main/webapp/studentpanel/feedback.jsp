<%@ page import="java.io.OutputStream, java.io.IOException" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="org.json.JSONObject" %>
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
    <title>Feedback Submission</title>
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
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<h2>Submit Feedback</h2>

<%
    String message = null;
    String messageType = "";
    String eid = request.getParameter("eid"); // Get EID from URL

    if (eid == null || eid.trim().isEmpty()) {
        message = "Error: EID is missing.";
        messageType = "error";
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String feedback = request.getParameter("feedback");

        // Check if feedback is provided
        if (feedback == null || feedback.trim().isEmpty()) {
            message = "Please fill in all fields.";
            messageType = "error";
        } else {
            String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/student/send";
            HttpURLConnection connection = null;

            try {
                // Prepare the JSON payload
                JSONObject payload = new JSONObject();
                payload.put("description", feedback);  // Changed key to "description"
                payload.put("eid", eid);

                // Send the POST request
                URL url = new URL(apiUrl);
                connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST");
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setDoOutput(true);

                // Ensure cookies are sent if available
                String cookieHeader = request.getHeader("Cookie");
                if (cookieHeader != null) {
                    connection.setRequestProperty("Cookie", cookieHeader);
                }

                OutputStream os = connection.getOutputStream();
                os.write(payload.toString().getBytes("UTF-8"));
                os.close();

                int statusCode = connection.getResponseCode();

                if (statusCode == HttpURLConnection.HTTP_OK) {
                    message = "Feedback sent to lecturer successfully.";
                    messageType = "success";
                } else {
                    message = "Error: Unable to send feedback. HTTP Status: " + statusCode;
                    messageType = "error";
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
                messageType = "error";
            } finally {
                if (connection != null) {
                    connection.disconnect();
                }
            }
        }
    }
%>

<% if (message != null) { %>
<div class="message <%= messageType %>"><%= message %></div>
<% } %>

<!-- Only display the EID as a hidden field (if needed for future use) -->
<form method="post" action="./feedback.jsp">
    <label for="feedback">Feedback:</label>
    <textarea id="feedback" name="feedback" rows="5" required></textarea>

    <!-- Hidden field to send EID in case it's needed elsewhere -->
    <input type="hidden" name="eid" value="<%= eid %>">

    <button type="submit">Submit Feedback</button>
</form>

</body>
</html>