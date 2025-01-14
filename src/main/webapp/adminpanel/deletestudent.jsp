<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*" %>
<jsp:include page="nav.jsp" />
<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Student</title>
    <style>
        .message {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            text-align: center;
            font-size: 1.2em;
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
<h1>Delete Student</h1>
<%
    String sid = request.getParameter("sid");
    if (sid == null) {
%>
<p class="message error">Student ID is missing!</p>
<% } else {
    String apiUrl = "http://51.20.114.214:8081/api/v1/admin/student/remove/" + sid;
    try {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("DELETE");
        conn.setRequestProperty("Accept", "application/json");

        // Retrieve the session cookie and pass it in the request
        String sessionCookie = (String) session.getAttribute("sessionCookie");
        if (sessionCookie != null) {
            conn.setRequestProperty("Cookie", sessionCookie);
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseMessage = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                responseMessage.append(line);
            }
            reader.close();
%>
<p class="message success"><%= responseMessage.toString() %></p>
<%
} else {
%>
<p class="message error">Failed to delete student. HTTP Code: <%= responseCode %></p>
<%
    }
    conn.disconnect();
} catch (Exception e) {
%>
<p class="message error">Error: <%= e.getMessage() %></p>
<%
        }
    }
%>
</body>
</html>
