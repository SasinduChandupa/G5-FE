<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*, java.io.*, org.json.*" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            border: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .alert {
            margin-top: 20px;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Update Student</h3>
    <%
        String sid = request.getParameter("sid");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String profilePic = request.getParameter("profilePic");
        String password = ""; // Password is not passed in URL for security reasons
        int age = request.getParameter("age") != null ? Integer.parseInt(request.getParameter("age")) : 0;
        String badgeId = request.getParameter("badgeId");

        String alertMessage = null;
        String alertType = null;

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Fetch updated data from form submission
            username = request.getParameter("username");
            name = request.getParameter("name");
            email = request.getParameter("email");
            profilePic = request.getParameter("profilePic");
            age = Integer.parseInt(request.getParameter("age"));
            password = request.getParameter("password");

            try {
                // Construct the API endpoint for updating a student
                URL url = new URL("http://51.20.114.214:8081/api/v1/admin/student/" + sid);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("PUT");
                connection.setRequestProperty("Content-Type", "application/json");

                // Retrieve the session cookie and pass it in the request
                String sessionCookie = (String) session.getAttribute("sessionCookie");
                if (sessionCookie != null) {
                    connection.setRequestProperty("Cookie", sessionCookie);
                }

                connection.setDoOutput(true);

                // Construct the JSON payload
                JSONObject payload = new JSONObject();
                payload.put("username", username);
                payload.put("name", name);
                payload.put("email", email);
                payload.put("password", password);
                payload.put("profilePic", profilePic);
                payload.put("age", age);
                payload.put("badge", new JSONObject().put("bid", badgeId));

                try (OutputStream os = connection.getOutputStream()) {
                    os.write(payload.toString().getBytes("UTF-8"));
                }

                int responseCode = connection.getResponseCode();
                if (responseCode == 200) {
                    alertMessage = "Student updated successfully!";
                    alertType = "success";
                } else {
                    alertMessage = "Failed to update student. HTTP Code: " + responseCode;
                    alertType = "danger";
                }

                connection.disconnect();
            } catch (Exception e) {
                alertMessage = "Error: " + e.getMessage();
                alertType = "danger";
            }
        }
    %>
    <form method="post" action="updatestudent.jsp?sid=<%= sid %>">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="<%= username %>" required>
        </div>
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= name %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= email %>" required>
        </div>
        <div class="form-group">
            <label for="profilePic">Profile Picture URL</label>
            <input type="text" id="profilePic" name="profilePic" value="<%= profilePic %>">
        </div>
        <div class="form-group">
            <label for="age">Age</label>
            <input type="number" id="age" name="age" value="<%= age %>" required>
        </div>
        <div class="form-group">
            <label for="badgeId">Badge ID</label>
            <input type="text" id="badgeId" name="badgeId" value="<%= badgeId %>" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="btn">Update Student</button>
    </form>

    <% if (alertMessage != null) { %>
    <div class="alert alert-<%= alertType %>"><%= alertMessage %></div>
    <% } %>
</div>
</body>
</html>
